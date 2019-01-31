Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B48DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187CD20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8vhCacI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfAaT2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:28:15 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34994 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbfAaT0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:39 -0500
Received: by mail-lf1-f66.google.com with SMTP id q3so2000120lfm.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RC6HS24sBC7tKhpPX26UtgcBbLB0PzUnL1zUvTRcTKs=;
        b=H8vhCacI4nEVCS4o64uJ+00sbGNdrBck4ZW/wvSgrgI3N2yJci/kdvOjLu5ki62E+E
         IT0Ycd5Q54YUYxmwPxY/wcCyew/fzY7nfefUASwFRbB+rZ1N4ONMPEzmrOowi7pRMHDv
         Nr/Orl5XXSM0lveWcwRaoc1AaZ9rdP9iPc9MCrpSoUeYG2eGdzAZxd/Ut//9kueWrorK
         reUHYSk2oUqmSeMoLN7CXMX4xGsxw8JUnH3JQiOtVchMcGt1k4nv2wE49rcDp3BwzaVN
         ZZmqp2NXToQdXIJ3df/mvgksWeuiVuEv0mFs+hf9v6I89F+5mroocmmPZnTISixHSMt9
         x1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=RC6HS24sBC7tKhpPX26UtgcBbLB0PzUnL1zUvTRcTKs=;
        b=JSiNPNFO/luFeu+keg1GlShRgshuCmSD0+gPcsifeTuzSb2IZlobEnxHt67pwOvxGa
         +q5emetNNo3+dEX0WCQp1BgJrsyLHsN/8Uqd1rKEPhoCD77qJ7AdqfMHu3S6BiZ7W6a5
         sZv+aZpmFyMq0l8DWGLS6dL7oCBnyza/jRf4c2BSNYgj16Zhlmb5sD2UJzFe1j6JAujq
         /ISjwdshr5756Av0sxulCcouVR4eYNOVbGKGkyb3Dw0JMQQ+P2x4EvM8HyOQCPuWSy5b
         au9dY5TGcANQhd7j1Gt755s3szTL7iY2H0eO2YCBHyX00Mcb+bD2ORCLEpJUerfoId41
         vXuQ==
X-Gm-Message-State: AJcUukcYYXjxFpOl0orqLmaEV63c7z0YSNJs1FJjZam4OyO2krvH0rdo
        YUqa7kcUzBTqfcKPY1vCjmo=
X-Google-Smtp-Source: ALg8bN6p0XSW6oYj2UtxpzbGUoPRvXtKRu0tI6SYEsGny14wD6GyDB9FuXc6jOQi1TUuRjSHJj29Iw==
X-Received: by 2002:a19:980f:: with SMTP id a15mr27962310lfe.103.1548962795439;
        Thu, 31 Jan 2019 11:26:35 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:35 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 01/19] drm/panel: drop drmP.h usage
Date:   Thu, 31 Jan 2019 20:26:01 +0100
Message-Id: <20190131192619.9763-2-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190131192619.9763-1-sam@ravnborg.org>
References: <20190131192619.9763-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of drmP.h is discouraged and yet we see new panel
drivers utilising drmP.h.
Remove usage of drmP.h from current panel drivers to set a good
example for new drivers.

While touching list of include files sort them.

Build tested on arm/x86.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Stefan Mavrodiev <stefan@olimex.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/panel/panel-arm-versatile.c           | 3 ++-
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c          | 4 +++-
 drivers/gpu/drm/panel/panel-innolux-p079zca.c         | 4 +++-
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c        | 2 +-
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c    | 4 +++-
 drivers/gpu/drm/panel/panel-lg-lg4573.c               | 5 ++++-
 drivers/gpu/drm/panel/panel-lvds.c                    | 1 -
 drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c    | 2 +-
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c      | 7 ++++++-
 drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c  | 3 ++-
 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 3 +--
 drivers/gpu/drm/panel/panel-raydium-rm68200.c         | 5 ++++-
 drivers/gpu/drm/panel/panel-samsung-ld9040.c          | 6 +++++-
 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c         | 6 +++++-
 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c      | 7 ++++++-
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c         | 6 +++++-
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c           | 4 +++-
 drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c       | 3 ++-
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c       | 3 ++-
 drivers/gpu/drm/panel/panel-simple.c                  | 3 ++-
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c        | 6 +++++-
 drivers/gpu/drm/panel/panel-truly-nt35597.c           | 8 ++++++--
 22 files changed, 71 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-arm-versatile.c b/drivers/gpu/drm/panel/panel-arm-versatile.c
index b428c4678106..0ed8ee4673eb 100644
--- a/drivers/gpu/drm/panel/panel-arm-versatile.c
+++ b/drivers/gpu/drm/panel/panel-arm-versatile.c
@@ -25,13 +25,14 @@
  * Epson QCIF display.
  *
  */
-#include <drm/drmP.h>
+#include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
 
 #include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
index bd38bf4f1ba6..1ee8b2ccf718 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
@@ -22,8 +22,10 @@
  * published by the Free Software Foundation.
  */
 
-#include <drm/drmP.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
 #include <linux/of_device.h>
 #include <linux/bitops.h>
diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index 8e5724b63f1f..6c3da2cbacd9 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -8,16 +8,18 @@
  */
 
 #include <linux/backlight.h>
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
 
-#include <drm/drmP.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
 #include <video/mipi_display.h>
 
diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
index 99caa7835e7b..fecdda0b99a5 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
@@ -22,12 +22,12 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/backlight.h>
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 
-#include <drm/drmP.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
index 2a25a914d09e..f61211a69dbe 100644
--- a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
+++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
@@ -4,15 +4,17 @@
  */
 
 #include <linux/backlight.h>
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 
-#include <drm/drmP.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
 #include <video/mipi_display.h>
 
diff --git a/drivers/gpu/drm/panel/panel-lg-lg4573.c b/drivers/gpu/drm/panel/panel-lg-lg4573.c
index 6989238b276a..e63fba2761f4 100644
--- a/drivers/gpu/drm/panel/panel-lg-lg4573.c
+++ b/drivers/gpu/drm/panel/panel-lg-lg4573.c
@@ -15,10 +15,13 @@
  * published by the Free Software Foundation.
 */
 
-#include <drm/drmP.h>
+#include <drm/drm_device.h>
+#include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
 
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index 3f6550e6b6a4..833aeb47065b 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -16,7 +16,6 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
-#include <drm/drmP.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_panel.h>
 
diff --git a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
index 5e8d4523e9ed..c8704be9caa3 100644
--- a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
+++ b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
@@ -15,9 +15,9 @@
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 
+#include <drm/drm_device.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
-#include <drm/drmP.h>
 
 #include <video/videomode.h>
 #include <video/display_timing.h>
diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
index 87fa316e1d7b..5bacf3f2da05 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
@@ -6,12 +6,17 @@
  *          Yannick Fertre <yannick.fertre@st.com>
  */
 
-#include <drm/drmP.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
+
 #include <linux/backlight.h>
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/module.h>
 #include <linux/regulator/consumer.h>
+
 #include <video/mipi_display.h>
 
 #define OTM8009A_BACKLIGHT_DEFAULT	240
diff --git a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
index cb4dfb98be0f..c7037942c7f3 100644
--- a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
+++ b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
@@ -19,12 +19,13 @@
  */
 
 #include <linux/backlight.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 
-#include <drm/drmP.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
 
diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index 2c9c9722734f..28c0620dfe0f 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -53,9 +53,8 @@
 #include <linux/of_graph.h>
 #include <linux/pm.h>
 
-#include <drm/drm_panel.h>
-#include <drm/drmP.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
 
diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
index 77593533abcd..e05e3f950855 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
@@ -7,14 +7,17 @@
  */
 
 #include <linux/backlight.h>
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/module.h>
 #include <linux/regulator/consumer.h>
 
 #include <video/mipi_display.h>
 
-#include <drm/drmP.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
 /*** Manufacturer Command Set ***/
 #define MCS_CMD_MODE_SW		0xFE /* CMD Mode Switch */
diff --git a/drivers/gpu/drm/panel/panel-samsung-ld9040.c b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
index 3cf4cf6a6942..7d27b79d0b2a 100644
--- a/drivers/gpu/drm/panel/panel-samsung-ld9040.c
+++ b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
@@ -11,10 +11,14 @@
  * published by the Free Software Foundation.
 */
 
-#include <drm/drmP.h>
+#include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
index 797bbc7a264e..813afee82ec9 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
@@ -11,11 +11,15 @@
  * published by the Free Software Foundation.
  */
 
-#include <drm/drmP.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
+
 #include <linux/backlight.h>
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
index aeb32aa58899..f1c8000e0386 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
@@ -11,12 +11,17 @@
  * published by the Free Software Foundation.
  */
 
-#include <drm/drmP.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
+
 #include <linux/backlight.h>
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/module.h>
 #include <linux/regulator/consumer.h>
+
 #include <video/mipi_display.h>
 
 #define MCS_LEVEL2_KEY		0xf0
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
index 6ad827b93ae1..b252d23f386f 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
@@ -15,11 +15,15 @@
  * published by the Free Software Foundation.
 */
 
-#include <drm/drmP.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
 #include <linux/regulator/consumer.h>
 
 #include <video/mipi_display.h>
diff --git a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
index 2d99e28ff117..c1348a687447 100644
--- a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
+++ b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
@@ -7,12 +7,14 @@
  */
 
 #include <linux/backlight.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
-#include <drm/drmP.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
 #include <drm/drm_panel.h>
 
 #include <video/display_timing.h>
diff --git a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
index 02fc0f5423d4..2ed11d86c10e 100644
--- a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
@@ -7,13 +7,14 @@
  */
 
 #include <linux/backlight.h>
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 
-#include <drm/drmP.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
 
diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
index e5cae0050f52..e8e2277e934d 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
@@ -19,13 +19,14 @@
  */
 
 #include <linux/backlight.h>
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 
-#include <drm/drmP.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
 
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9e8218f6a3f2..406b1d7aef31 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -22,14 +22,15 @@
  */
 
 #include <linux/backlight.h>
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
-#include <drm/drmP.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
 
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index 74284e5afc5d..76bd6e7a1a60 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -6,11 +6,15 @@
  * 2 as published by the Free Software Foundation.
  */
 
+#include <linux/backlight.h>
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
-#include <drm/drmP.h>
+#include <drm/drm_device.h>
+#include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
 
 #include <video/mipi_display.h>
diff --git a/drivers/gpu/drm/panel/panel-truly-nt35597.c b/drivers/gpu/drm/panel/panel-truly-nt35597.c
index fc2a66c53db4..6317b6b35341 100644
--- a/drivers/gpu/drm/panel/panel-truly-nt35597.c
+++ b/drivers/gpu/drm/panel/panel-truly-nt35597.c
@@ -3,11 +3,15 @@
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  */
 
-#include <drm/drmP.h>
-#include <drm/drm_panel.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
+#include <linux/backlight.h>
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/pinctrl/consumer.h>
-- 
2.12.0

