Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbeCOQvG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:51:06 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:52893 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbeCOQvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:51:04 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Sebastian Reichel <sre@kernel.org>,
        Amitkumar Karwar <amit.karwar@redpinesignals.com>,
        Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] [v2] Bluetooth: btrsi: rework dependencies
Date: Thu, 15 Mar 2018 17:50:16 +0100
Message-Id: <20180315165050.2211236-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:j+SzJK/jgpJjt24V7cDgs/q7gzxh1tKEHbts6atHNQWpFTAdqo4
 UseDWdj35bcWGmwMNjG1z1KcdFqQoOGIb+Qn1j1cl9/MJdKt+oaoE7UULo9ThpSMJwgVVwF
 tA0N2ZVoMauAgZPfgw0cAwfgJ3IuvajxkyoZAJwflpBxE1x0l4t8Ft13oCQfGXziEVrat5a
 2jNh/cCM3VoAVPVJHAi/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jrKgMQjmTYI=:GY509RUMywHof2EhnNGa7Z
 Yocz7VRYXEkax7cpCVqibl2zednTM9foJMlskb0BNkFotlhCi9fPJhRHt+WQKWZ1MyOlg+YII
 se8gBgb67c1WU6QbRJo9QNkBgQnjJWEnZnQ7N10wGjUXzz9pCcgHP/9sil4LqrjjLgw4+pBo6
 eCtXieTvYxIznAUluE2oXODbH2n/NYwK7jK7sQmxVxNFZkQNmQ7TmF1e5CRok/d0VrnsIHHvj
 6uCI74Pkj5qZprVzEom9xC+/AZohs9HeahsNWCAS4mgDCwKFXZv7suaCLciNdcW7QhDZxEmts
 IwPjgmz0+pjibxdlNhffqM72ezffbhs88WX8VUEnTzqZil5+bX8Ws/uvHnNqUHhyJgAhTnAPy
 z8ND3cSCcUQBFEk6U3ZyH7MGKOcVUU8UZOUIS2WmILIGfLokXb4J7iKRSuBZ6B3i94t+s5OPG
 Fs75ZF9VhGvwmwkWu1Rt0nkjcaujiE8oJ6YAhac/wgWzSHPRTLXwBCIukshj2VziMWqjCUMhV
 rYTbXYjrJZ9fgXjouYfJG1ilMPVv3osdevwhwOgLhpLptmGFJMtEjdWxLG2hPPI2Vy2ISS9f/
 VpgHMYCGr6kEZm/9cgi0psE6L3T4AA8EzTnWPquKhzyVCZZEfIZDg/QvqkVZXueDy4a/6Jc1A
 miHcOCq2HEDNZ/euKVz8vxHVeO5FbqBcXjuIhrbHn/H2FhDfV+i2ezTmt+26YAgLFgJ+NO+y0
 BNyqhddPxch1H3fgPUv2tg0cv4FFl7FeBd9CDA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linkage between the bluetooth driver and the wireless
driver is not defined properly, leading to build problems
such as:

warning: (BT_HCIRSI) selects RSI_COEX which has unmet direct dependencies (NETDEVICES && WLAN && WLAN_VENDOR_RSI && BT_HCIRSI && RSI_91X)
drivers/net/wireless/rsi/rsi_91x_main.o: In function `rsi_read_pkt':
(.text+0x205): undefined reference to `rsi_bt_ops'

As the dependency is actually the reverse (RSI_91X uses
the BT_RSI driver, not the other way round), this changes
the dependency to match, and enables the bluetooth driver
from the RSI_COEX symbol.

Fixes: 38aa4da50483 ("Bluetooth: btrsi: add new rsi bluetooth driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: Pick a different from v1
---
 drivers/bluetooth/Kconfig        | 4 +---
 drivers/net/wireless/rsi/Kconfig | 4 +++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index d8bbd661dbdb..149a38ee1fce 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -393,9 +393,7 @@ config BT_QCOMSMD
 	  kernel or say M to compile as a module.
 
 config BT_HCIRSI
-	tristate "Redpine HCI support"
-	default n
-	select RSI_COEX
+	tristate
 	help
 	  Redpine BT driver.
 	  This driver handles BT traffic from upper layers and pass
diff --git a/drivers/net/wireless/rsi/Kconfig b/drivers/net/wireless/rsi/Kconfig
index f004be33fcfa..c6006fab8638 100644
--- a/drivers/net/wireless/rsi/Kconfig
+++ b/drivers/net/wireless/rsi/Kconfig
@@ -13,6 +13,7 @@ if WLAN_VENDOR_RSI
 
 config RSI_91X
 	tristate "Redpine Signals Inc 91x WLAN driver support"
+	select BT_RSI if RSI_COEX
 	depends on MAC80211
 	---help---
 	  This option enabes support for RSI 1x1 devices.
@@ -44,7 +45,8 @@ config RSI_USB
 
 config RSI_COEX
 	bool "Redpine Signals WLAN BT Coexistence support"
-	depends on BT_HCIRSI && RSI_91X
+	depends on BT && RSI_91X
+	depends on !(BT=m && RSI_91X=y)
 	default y
 	---help---
 	  This option enables the WLAN BT coex support in rsi drivers.
-- 
2.9.0
