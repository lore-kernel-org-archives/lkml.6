Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeDDK1n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:27:43 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:52323 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeDDK1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:27:41 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Kishon Vijay Abraham I <kishon@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] phy: mapphone-mdm6600: add gpiolib dependency
Date: Wed,  4 Apr 2018 12:27:19 +0200
Message-Id: <20180404102733.3747591-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:tbE++lY1GoQkCM4Ef0VJEEPLFUXeGPSv14zPwLsxVZA+7OyCp3S
 gis4oJ+VBTm61nkYvV/rCl/K6IUaFqEGCYKGElzEAPyfZ1aASpGeysHp3QdVBGhHB5a6pp9
 jA/0sWd1gRqq7PezavzXRvD+eTi5/IN1S38Orwp7w8M7hY7K5gavX+qCVtXo9r4U+T/cxM/
 XMlAI2CNTklQncs/YzFig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PovKO4cA8iU=:0k7V7TsJZpuDisrDKvuD2V
 /nYrTo6RFfprn1UquEib176jQ34LoORuheYbaib8dUvaED+yXSW9eT4OLw0fOVhaI+flXA3qF
 cVJw8b0HqlrQFFKcVLyUrQDdU0KACgtGsend8K9JzVPdZ7yhxXGVxHmdx9+uumPGSiDbHuDZx
 CuJNS/r2PvBfNt1O+l7weLbtQAN1kP89zTCmyjDGKidP+x2d1seNMI4gzsc1Bv/YtRiBE51xV
 gV72ikwBXku1TWH0138GTavVBx7KTf9mYBFQfCQWsRW8SLKL97mggHyNxBM0SeWyudrlrYCrR
 pZr/0cTaSKDZ9OHzJejRpi1JRAWCLbtoARg1Sfm8CBC9VG3LuRGJjcqLX439QbUuPwWQmIr9E
 vLD+4Kuqz/6KoOweHxHhWuFbWTVQvHu06+7uV1eJ8ioQVt1u1r9s3PD7R+mjEUcclsUGGCOCC
 4C3bVZjbLLMZcyzO/L/87TkQWx6KbEMORY2K+45Law2tNXAw+J9YnKd87l8rEx//zgl028u7S
 Op/cFWL/Zx+SudPfBMidMeY0fykS4S3JXDV0w+s+8o+3qgMNy6mR6RroMj+y3efAhvczzDP87
 cEV6LrRqcNkAhPzgWqmyqL3kXM6awajG/ZIFodOiUOcteFnrLoe8hHBXaJ5SegjO6hOYJLGNa
 8wbGyGgXH1hXCk/PWt9IfvVJil/ll9+1GfjunERBIc8xcSyvtLBANyvs1jTuvY9jy+IKjKZMm
 2BXUdcX5cQsMd9luzw5sAuLa0QUhfNUSWUnRQw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without gpiolib, the gpiod_get_array_value_cansleep() is an empty stub,
so gcc notices that the resulting array is never initialized:

drivers/phy/motorola/phy-mapphone-mdm6600.c: In function 'phy_mdm6600_status':
drivers/phy/motorola/phy-mapphone-mdm6600.c:188:16: error: 'values[0]' is used uninitialized in this function [-Werror=uninitialized]
   val |= values[i] << i;
          ~~~~~~^~~
drivers/phy/motorola/phy-mapphone-mdm6600.c:188:16: error: 'values[1]' is used uninitialized in this function [-Werror=uninitialized]
drivers/phy/motorola/phy-mapphone-mdm6600.c:188:16: error: 'values[2]' is used uninitialized in this function [-Werror=uninitialized]
cc1: all warnings being treated as errors

With gpiolib enabled, this can't happen and we don't get the warning, so
let's just add a Kconfig dependency for it.

Fixes: 5d1ebbda0318 ("phy: mapphone-mdm6600: Add USB PHY driver for MDM6600 on Droid 4")
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/phy/motorola/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/motorola/Kconfig b/drivers/phy/motorola/Kconfig
index 82651524ffb9..718f8729701d 100644
--- a/drivers/phy/motorola/Kconfig
+++ b/drivers/phy/motorola/Kconfig
@@ -13,7 +13,7 @@ config PHY_CPCAP_USB
 
 config PHY_MAPPHONE_MDM6600
 	tristate "Motorola Mapphone MDM6600 modem USB PHY driver"
-	depends on OF && USB_SUPPORT
+	depends on OF && USB_SUPPORT && GPIOLIB
 	select GENERIC_PHY
 	help
 	  Enable this for MDM6600 USB modem to work on Motorola phones
-- 
2.9.0
