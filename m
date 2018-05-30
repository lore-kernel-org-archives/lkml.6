Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932608AbeE3Vtz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:49:55 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:33451 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932382AbeE3Vtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:49:52 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fb_omap: add gpiolib dependency
Date: Wed, 30 May 2018 23:49:22 +0200
Message-Id: <20180530214938.1073749-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:G8HuF+dSRxo43ZgzxicXS+Sgtw5RiZhb/HGNBdCbp1PIc9WWrt3
 ZfFNtnOqrHJTAlAh31z3Rle9evAUJ43+w4i5UzniCFuFmp3lNTFjuAQUJ0apBPIorlQZMFa
 njSV3jPEOCg3JrzDRZ0l3lZluDZju1vmfmyPGrD/arH1UF4W1tij7rSqWky7AxAUTmlfued
 sYIcPTBO/3AjpnT9RUGHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iNjEaeTeOws=:W59IGHuLqEk/opP3SM99uj
 LeniHqVc5oocGQoGwJ/gxXUWtDOqXKJm1nFjzOKZEY3ssN//6VUyvxe1qphPckVCvW81qDyp2
 W/QRBLC5iEBJz9Bxf9ubl4OA/5YP3/UBEJXDev+gol/CxyEGbcBaTaAO5PpVqsv0paBDXQVvn
 f/3/IP+F5G0CgBbXpU0MaWih2Ui6I6cZUmfb1VtoJIj9kyw29qkuHvyOPWzvSbmXX/Xyc2cb0
 qgWBl7GlV3AjeiPWz7uIA8/3pyjNk2OQeGQPdDNgv0LWtFDwFo8/P9ywLAAO1C8ewavicVU17
 14QpGfE8qJYu++wKiZGatRhd3EA4KJQk7dUnaztBVYF6yaByPk5++TzfTxu4Ap5BNyEqCUCmC
 wcMccEaSxQBX/U/m0cJqko4HDFruSDw1KY2FbHYACHpWIYuPMjY+yZGar6EOvi+zHsErhdkPi
 MMKpn1LZAvSaOH4WFiYunhBeikSM4+p0DNosBNsaeaEgq/COk2fELjjrBX14mhnvy2zDBADoR
 L8qsDi0EL0lq6HKkj9VpLNWjmV+2GGuFcnt4baKBzmM+HYlGfsP02tZN/rKK+eTd0c4k+Lix+
 LCGg49mY6oZwSBRaazIqdRXKbUxn+tOr0KiJOnq7aieZBOzS9QPB6Nxw4gHn/0cF0fp0iminC
 h8YXB50GBQ5br5I2PO/qgnkHkbV3F6ne+LdrLSmKyItzsmjDeZd+0LURiKS3pQMhUHoE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the omap sub-drivers when CONFIG_GPIOLIB is disabled causes
lots of build failures, either from using gpiolib interfaces, or from
including the wrong headers:

drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c: In function 'opa362_enable':
drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c:101:3: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c: In function 'panel_dpi_enable':
drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c:86:2: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c: In function 'panel_dpi_probe_pdata':
drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c:189:23: error: implicit declaration of function 'gpio_to_desc'; did you mean 'irq_to_desc'? [-Werror=implicit-function-declaration]
drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c: In function 'panel_dpi_probe_of':
drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c:210:9: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_gpio_request_one'? [-Werror=implicit-function-declaration]
drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c: In function 'sharp_ls_enable':
drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c:120:3: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c: In function 'lb035q02_enable':
drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c:170:3: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c: In function 'hdmi_probe_of':
drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c:584:2: error: implicit declaration of function 'of_node_put'; did you mean 'node_set'? [-Werror=implicit-function-declaration]
drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c: In function 'hdmi_probe_of':
drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c:554:2: error: implicit declaration of function 'of_node_put'; did you mean 'node_set'? [-Werror=implicit-function-declaration]

Rather than fixing up each one individually, this just marks all of it
as depending on GPIOLIB.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/omap2/omapfb/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap2/omapfb/Kconfig b/drivers/video/fbdev/omap2/omapfb/Kconfig
index e6226aeed17e..3bf154e676d1 100644
--- a/drivers/video/fbdev/omap2/omapfb/Kconfig
+++ b/drivers/video/fbdev/omap2/omapfb/Kconfig
@@ -5,6 +5,7 @@ menuconfig FB_OMAP2
         tristate "OMAP2+ frame buffer support"
         depends on FB
         depends on DRM_OMAP = n
+	depends on GPIOLIB
 
         select FB_OMAP2_DSS
 	select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
-- 
2.9.0
