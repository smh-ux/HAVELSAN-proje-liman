#!/bin/bash

case "$1" in
    "kur")
        echo "Liman kuruluyor..."
        NODE_MAJOR=18
        sudo apt-get update
        sudo apt-get install -y ca-certificates curl gnupg
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
        echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
        sudo apt install software-properties-common
        sudo add-apt-repository ppa:ondrej/php
        sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
        wget -O- https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor > pgsql.gpg
        sudo mv pgsql.gpg /etc/apt/trusted.gpg.d/pgsql.gpg
        sudo apt update
        wget https://github.com/limanmys/core/releases/download/release.feature-new-ui.863/liman-2.0-RC2-863.deb
        apt install ./liman-2.0-RC2-863.deb
        sudo limanctl administrator
        ;;
    "kaldır")
        echo "Liman kaldırılıyor..."
        sudo limanctl stop
        sudo limanctl remove
        sudo rm -rf /var/lib/liman
        echo "Liman kaldırıldı."
        ;;
    "administrator")
        echo "Liman yönetici sıfırlanıyor..."
        sudo limanctl reset administrator@liman.dev
        ;;
    "reset")
        if [ -z "$2" ]; then
            echo "Lütfen bir e-posta adresi belirtin."
        else
            echo "Liman sıfırlanıyor..."
            sudo limanctl reset "$2"
        fi
        ;;
    "help")
        echo "Kullanım: ./liman.sh <komut>"
        echo "Komutlar:"
        echo "  kur            Liman'ı kurar."
        echo "  kaldır         Liman'ı kaldırır."
        echo "  administrator  Liman yöneticisini sıfırlar."
        echo "  reset <mail>   Belirtilen e-posta adresine sahip Liman kullanıcısını sıfırlar."
        echo "  help           Bu yardım mesajını gösterir."
        ;;
    *)
        echo "Geçersiz komut. Yardım için: ./liman.sh help"
        ;;
esac
