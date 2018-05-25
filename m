Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967090AbeEYPwr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:52:47 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34175 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966801AbeEYPwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:52:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maciej Purski <m.purski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] drm/bridge: fix dependency for lvds-encoder
Date: Fri, 25 May 2018 17:50:14 +0200
Message-Id: <20180525155030.3667352-7-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180525155030.3667352-1-arnd@arndb.de>
References: <20180525155030.3667352-1-arnd@arndb.de>
X-Provags-ID: V03:K1:LVIm6kSURKg4YU6GswfLEU9yE7ciQXHXfcl8nw6OGCM7qyrhxIr
 wkG0QUw7qvQXlv2yL8kJvbCffpfhPVWQhif46Oj6ywv/aw5eNpWBop9pD1RV7e+c0f6+xAK
 jFbR1xEh5xVOGpFow1G9KsYDNBcJYqZfGDi0KFal4Pn8T5ZUTK6H/HUgTEX01aaOiaLI5so
 xHxHgN2/tzytokmlXx/AA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9Z5UrJCXXQI=:oCvGf7Iep/lJTdqjFyI2px
 Gl5cV3v9ylGW3kwtIlwlv62ZSyCJeNHaqt58PaP9h+lcjYf6dJIMXZw0WN/56KtrZvXokUGzx
 nRp0onJf43joWFwF3/GgfzQ1PZc7DSfkUHFCruvDVfGA3vMbGwhklOTeboHrKGtpYfouvtGCJ
 2Pc727v3Ut53aPndJ1xrO0i0EKpTKELo6VcGCaqw0OtBXV4IRsmNN//j4T5+j2DkTbWhVSVY3
 fbt2OkSAM1Lguj2b+rgg5i3EE9kWlszRwpNH4u5k0jBkMlIe8lGfSV1EHq1JITOnrY322/Gl5
 uf/XCBvTST/Vm1KH32lXriUjZKNSJEyQbQuMCmF1DJ6ufEsfWMqhMcc1YAlmlRiKEOfgZ9nFY
 iDuaTfMkLKAR0N9UD0eZf1AvioBZ/juxM+OUdR7SZSvRLN7/ymL1giM8wnXhajf3wwtFeDzpx
 ognuHGv+bLXgrXeeB8B5lalj/r2gwTwwQOpAE6f6Wh+WeBm2b7qNaqzHjXGUcOVrc9R4P2+rj
 rwYm9bZwgIjDIWpqQKbktEYP7FJuUbQVt02/huJXVtZK0FBaYhdaqcqCcT3nSf17xbuHan+JP
 KBtcqBLUi7jkvhffZ7inb7AjKL7c+tnuOIjQPa1PNagRxMU1GuEBnQAtz0TUcV+NoRxn+JG3V
 t6DSsUlBQ6Jkw3l2Bz4w2h0QQcJ9KElZnpfeBsUhZqa/fJYcKgn6/BTq/JpqM1qLOZqE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRM panel bridge code is built into the kms helpers module, so we
get a link error when trying to use it from a built-in driver while the
kms helper is a loadable module:

drivers/gpu/drm/bridge/lvds-encoder.o: In function `lvds_encoder_probe':
lvds-encoder.c:(.text+0x124): undefined reference to `devm_drm_panel_bridge_add'

This adds a the same dependency in the lvds-encoder that we use for all
the other users of the panel bridge. I did not bisect the problem, but
from inspection it seems to date back to the patch that separated out
the panel bridge from lvds encoder.

Fixes: 13dfc0540a57 ("drm/bridge: Refactor out the panel wrapper from the lvds-encoder bridge.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 6caa47834194..cf47bfa7a050 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -46,6 +46,7 @@ config DRM_DUMB_VGA_DAC
 config DRM_LVDS_ENCODER
 	tristate "Transparent parallel to LVDS encoder support"
 	depends on OF
+	select DRM_KMS_HELPER
 	select DRM_PANEL_BRIDGE
 	help
 	  Support for transparent parallel to LVDS encoders that don't require
-- 
2.9.0
