Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeCNW65 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 18:58:57 -0400
Received: from vern.gendns.com ([206.190.152.46]:40546 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751440AbeCNW6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 18:58:55 -0400
From: David Lechner <david@lechnology.com>
To: dri-devel@lists.freedesktop.org
Cc: David Lechner <david@lechnology.com>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tilcdc: Fix setting clock divider for omap-l138
Date: Wed, 14 Mar 2018 17:58:45 -0500
Message-Id: <1521068325-15077-1-git-send-email-david@lechnology.com>
X-Mailer: git-send-email 2.7.4
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes setting the clock divider on the TI OMAP-L138 LCDK board.

The clock drivers for OMAP-L138 are being covernted to the common clock
framework. When this happens, clk_set_rate() will no longer return an
error. However, on this SoC, the clock rate cannot actually be changed
because the clock has to maintain a fixed ratio to the ARM clock. So
after attempting to set the clock rate, we need to check to see if the
new rate is actually close enough. If not, then follow the previous
error path to adjust the divider in LCDC IP block to compensate for not
being able to change the parent clock rate.

Tested working on a TI OMAP-L138 LCDK board.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index 8bf6bb9..6931777 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -224,7 +224,7 @@ static void tilcdc_crtc_set_clk(struct drm_crtc *crtc)
 
 	ret = clk_set_rate(priv->clk, req_rate * clkdiv);
 	clk_rate = clk_get_rate(priv->clk);
-	if (ret < 0) {
+	if (ret < 0 || tilcdc_pclk_diff(req_rate, clk_rate) > 5) {
 		/*
 		 * If we fail to set the clock rate (some architectures don't
 		 * use the common clock framework yet and may not implement
-- 
2.7.4
