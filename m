Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752601AbeB1Nse (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:48:34 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:59837 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752441AbeB1Nsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:48:32 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Baruch Siach <baruch@tkos.co.il>, Arnd Bergmann <arnd@arndb.de>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: raspberrypi-ext: fix firmware dependency
Date: Wed, 28 Feb 2018 14:48:08 +0100
Message-Id: <20180228134822.2194009-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:Y1Bxfn68GtFS0Zgsra2KZo80bWSdI0qPlkBYkKkPlK+RSvpL2L1
 2dUU5NNf5snywx4FaAzJTiydxakT+M25DPzE5lMQjJcnTAHurqAOu4jMm7Xa4ohCaYTUEsm
 ZfXavQb1o4gqmNhbS+49tmiHvqhn8TcCLbZcAc3XhbX1/zSFlZ6pwKSsKvGQ7l5vT6HPYEE
 luA9Fb6NzocKPzggvLFTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m5698xSRjhI=:wOwX2VhE0GLysTgbk4t1ln
 2zFphcaAc+aV5tJTVAT9NwKbJwm4gL19kSd1UEkD9B2p9dfcgHqbg/fz0GxcfI6aDmljdAQpe
 WLV2ZtaKTEOxKG29/BBKX/7uLJTKGD66veOQw8bIzkl59z5TnnSV1Rl3k3/S3yVf9ccr9WN/D
 LQGEMIYgUarzgV+31kvcuY5fjdoDKob1gEaxQkZ1pvE6RMyn7byrqxPmBm8ymPmUIxQ5sSplm
 Rsgu0uDlOq+9ajNq4gXh0wuwSIluoXQ05Z7R49t51fc5xG1VOh8HG/iufEp+D9dOVRGuT2bSv
 b5x+ngfjdDvonDwjbioCG9uD/VRrBHTuPP4icVGrrj97tqt0zbfRjfs9A+L6BAS3ADDIZ5NK5
 2oAqZoSrxxigXM+rCJuSapUWK7FtxcX+/YbdYvdOw9cuB+Rbyb68GKGoW2moLqp7+dbdQUqWW
 End07QKaNB5LxxsroqNY6X7PyDk+1Ma4KiTtQyryBQkJWWYvFG9hySASln4m3TSHhnZXOth76
 SsY0ttWhi1Cm+VwkiFiDG38gvPNulY5DfqeIyW0TYlMN4chDvLeG8Qmw5sddsvudneE5JkT4x
 /JNso/ProYSI9kIv8gLGhPzgc9TXsKtqzv+qNJjWLUph4xNdlQdlcxjMeOHLem5fPoev1cQ+8
 gRN9cX2WRVX1Zn2ZPLpd9TePPuyZ1xLxWvhZHysiMPRV3HR1VCS8o9w7gGUeVa+MccZEzoOvf
 dHQcYKMjYXo0kodHVwv4bYGhhieZjkvJLH5hew==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the firmware driver is a loadable module, the gpio driver cannot be
built-in:

drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_set':
gpio-raspberrypi-exp.c:(.text+0xb4): undefined reference to `rpi_firmware_property'
drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_get':
gpio-raspberrypi-exp.c:(.text+0x1ec): undefined reference to `rpi_firmware_property'
drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_get_direction':
gpio-raspberrypi-exp.c:(.text+0x360): undefined reference to `rpi_firmware_property'
drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_get_polarity':
gpio-raspberrypi-exp.c:(.text+0x4d4): undefined reference to `rpi_firmware_property'
drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_dir_out':
gpio-raspberrypi-exp.c:(.text+0x670): undefined reference to `rpi_firmware_property'
drivers/gpio/gpio-raspberrypi-exp.o:gpio-raspberrypi-exp.c:(.text+0x7fc): more undefined references to `rpi_firmware_property' follow
drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_dir_in':
drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_probe':
gpio-raspberrypi-exp.c:(.text+0x93c): undefined reference to `rpi_firmware_get'

We already have a Kconfig dependency for it, but when compile-testing, it
is disregarded.

This changes the dependency so that compile-testing is only done when the
firmware driver is completely disabled.

Fixes: a98d90e7d588 ("gpio: raspberrypi-exp: Driver for RPi3 GPIO expander via mailbox service")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 2ecd2adbaec6..52a8b0a6f4e1 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -126,7 +126,7 @@ config GPIO_RASPBERRYPI_EXP
 	tristate "Raspberry Pi 3 GPIO Expander"
 	default RASPBERRYPI_FIRMWARE
 	depends on OF_GPIO
-	depends on (ARCH_BCM2835 && RASPBERRYPI_FIRMWARE) || COMPILE_TEST
+	depends on (ARCH_BCM2835 && RASPBERRYPI_FIRMWARE) || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
 	help
 	  Turn on GPIO support for the expander on Raspberry Pi 3 boards, using
 	  the firmware mailbox to communicate with VideoCore on BCM283x chips.
-- 
2.9.0
