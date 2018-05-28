Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424724AbeE1LWX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423059AbeE1LPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:15:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 259/272] drm: rcar-du: lvds: Fix LVDS startup on R-Car Gen2
Date: Mon, 28 May 2018 12:04:52 +0200
Message-Id: <20180528100301.948557042@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[ Upstream commit 8525d04ba8a6a9ecfa4bd619c988ca873a5fc2a4 ]

According to the latest revision 2.00 of the R-Car Gen2 manual, the LVDS
and the bias circuit must be enabled after the LVDS I/O pins are
enabled, not before. Fix the Gen2 LVDS startup sequence accordingly.

While at it, also fix the comment preceding the first LVDCR0 write that
still talks about hardcoding the LVDS mode 0.

Fixes: 90374b5c25c9 ("drm/rcar-du: Add internal LVDS encoder support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
@@ -59,11 +59,8 @@ static void rcar_du_lvdsenc_start_gen2(s
 
 	rcar_lvds_write(lvds, LVDPLLCR, pllcr);
 
-	/*
-	 * Select the input, hardcode mode 0, enable LVDS operation and turn
-	 * bias circuitry on.
-	 */
-	lvdcr0 = (lvds->mode << LVDCR0_LVMD_SHIFT) | LVDCR0_BEN | LVDCR0_LVEN;
+	/* Select the input and set the LVDS mode. */
+	lvdcr0 = lvds->mode << LVDCR0_LVMD_SHIFT;
 	if (rcrtc->index == 2)
 		lvdcr0 |= LVDCR0_DUSEL;
 	rcar_lvds_write(lvds, LVDCR0, lvdcr0);
@@ -74,6 +71,10 @@ static void rcar_du_lvdsenc_start_gen2(s
 			LVDCR1_CHSTBY_GEN2(1) | LVDCR1_CHSTBY_GEN2(0) |
 			LVDCR1_CLKSTBY_GEN2);
 
+	/* Enable LVDS operation and turn bias circuitry on. */
+	lvdcr0 |= LVDCR0_BEN | LVDCR0_LVEN;
+	rcar_lvds_write(lvds, LVDCR0, lvdcr0);
+
 	/*
 	 * Turn the PLL on, wait for the startup delay, and turn the output
 	 * on.
