Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeB1NmL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:42:11 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:52703 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbeB1NmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:42:09 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>, David Lechner <david@lechnology.com>,
        Sean Paul <seanpaul@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Meghana Madhyastha <meghana.madhyastha@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tinydrm: add backlight dependency
Date: Wed, 28 Feb 2018 14:40:48 +0100
Message-Id: <20180228134111.2042877-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:e/i3ftyCf7oTYTma45OqIhkCHPxtjiBYiog4qvnKHi8KBpciuRU
 bEFYkA9kNGnki/zAbiOXs0mftrUca6dpFg0L94gW76A8ECcKd+jUFmcU81UHtUx0sQfieLD
 kUTtGBjv0MN7mVL+NzvSapeMypE8iQcCvZ2+8lywM4tH/CNnrhnqgYBRJTxRoPrpsF9Z19V
 b4d7LKGzLrzJcFCKENjdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5dcZjLIgImc=:Wl2s6i8CF0eP8F7ZZqfeXU
 LDvRpy95YnUhK1Qo1lcsB3Bk9k2n4GVkuXUG0k3d5oxH7ECmFvTSZW+9/Wi0ZjRlWskVGr1/T
 0vZnU7NL6Wvth9kqvpZqc0U8DcmZbitaBqOUv5bS77kUKa07q6kdCsUPBT1ZIdYUYpQFwlW0i
 5voiTa7byOaCtatdRTJPpUd1QxaOi1iyBYLY/R+U+BilmMTv2OrCkZr3+QwbXPBMa3UpJX9Qu
 m5aHYRNfm/xS6lQT4Ux8+B11FZ+ieGySTqIX4eIjmxP1+MrO6nF0kEwWN85VT42t4S6vi44To
 3Vj81xDFZEe4ydSt57mWsaDkHFC6kyHD4/iW0b2VjPl/HhREttS4JmQg9u+WMQP+wpfZL+0s/
 LUleNptWl/URQd8M3cPLSJ9pP2QGs8mZS6+D076TMdn9PG1TkklfcBp6AZXnmrliC2eAk3xdC
 UCwfCSA/RUTM6SXs1keDGZbyIrnD/tG6w0r0QHKakcm0GrmvUIs1jdLZ737mHM4f6OTIJWGUS
 dTmDGgMj0z0mS7lXhYD+TYccSOo3pX5JiAcrf+dY7m9tmZk1QYA9bsoi1aSq9Dvok3kqRxTzk
 hgf7AzpEs/R8A4+qH+jyVnrF8cXrnpYtNz3ml7nc9FrHw7sw1pP86SEtF57oVNrpCc7g0Vzs4
 4Hf0IRUGe8K7VRpSKKfyVXK2dC9sjYcm8UsVYNJZeM9tnzKdZRmKbCY9ik9vqQjqODiRgah8n
 fVPunkB8Pd66ZOa//Nr4hGMFozMNyHNvlKrDlw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling devm_of_find_backlight directly means we get a link failure
without CONFIG_BACKLIGHT_CLASS_DEVICE:

drivers/gpu/drm/tinydrm/mi0283qt.o: In function `mi0283qt_probe':
mi0283qt.c:(.text+0x684): undefined reference to `devm_of_find_backlight'

This adds an explicit Kconfig dependency for it. While I did not
observe that failure for st7735r, I assume the same change is needed
there for the same reason.

Fixes: d1a2e7004b5e ("drm/tinydrm: Replace tinydrm_of_find_backlight with of_find_backlight")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/tinydrm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tinydrm/Kconfig b/drivers/gpu/drm/tinydrm/Kconfig
index 13339be843bc..4592a5e3f20b 100644
--- a/drivers/gpu/drm/tinydrm/Kconfig
+++ b/drivers/gpu/drm/tinydrm/Kconfig
@@ -23,6 +23,7 @@ config TINYDRM_ILI9225
 config TINYDRM_MI0283QT
 	tristate "DRM support for MI0283QT"
 	depends on DRM_TINYDRM && SPI
+	depends on BACKLIGHT_CLASS_DEVICE
 	select TINYDRM_MIPI_DBI
 	help
 	  DRM driver for the Multi-Inno MI0283QT display panel
@@ -54,6 +55,7 @@ config TINYDRM_ST7586
 config TINYDRM_ST7735R
 	tristate "DRM support for Sitronix ST7735R display panels"
 	depends on DRM_TINYDRM && SPI
+	depends on BACKLIGHT_CLASS_DEVICE
 	select TINYDRM_MIPI_DBI
 	help
 	  DRM driver Sitronix ST7735R with one of the following LCDs:
-- 
2.9.0
