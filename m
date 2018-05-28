Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424635AbeE1LQA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422828AbeE1LPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:15:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 258/272] drm: rcar-du: lvds: Fix LVDS startup on R-Car Gen3
Date: Mon, 28 May 2018 12:04:51 +0200
Message-Id: <20180528100301.872922042@linuxfoundation.org>
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

[ Upstream commit 796ceb9269626afaed3b4955c40d2c3d7a8c5d01 ]

According to the latest revisions of the R-Car Gen3 manual, the LVDS mode
must be set before the LVDS I/O pins are enabled, not after -- fix the
Gen3 LVDS startup sequence accordingly.

Fixes: e947eccbeba4 ("drm: rcar-du: Add support for LVDS mode selection")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[Updated comment in rcar_du_lvdsenc_start_gen3()]
[Moved Gen2 startup comment update to separate commit]
[Fixed =| typo]
Tested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
@@ -95,7 +95,7 @@ static void rcar_du_lvdsenc_start_gen3(s
 	u32 lvdcr0;
 	u32 pllcr;
 
-	/* PLL clock configuration */
+	/* Set the PLL clock configuration and LVDS mode. */
 	if (freq < 42000)
 		pllcr = LVDPLLCR_PLLDIVCNT_42M;
 	else if (freq < 85000)
@@ -107,6 +107,9 @@ static void rcar_du_lvdsenc_start_gen3(s
 
 	rcar_lvds_write(lvds, LVDPLLCR, pllcr);
 
+	lvdcr0 = lvds->mode << LVDCR0_LVMD_SHIFT;
+	rcar_lvds_write(lvds, LVDCR0, lvdcr0);
+
 	/* Turn all the channels on. */
 	rcar_lvds_write(lvds, LVDCR1,
 			LVDCR1_CHSTBY_GEN3(3) | LVDCR1_CHSTBY_GEN3(2) |
@@ -117,7 +120,7 @@ static void rcar_du_lvdsenc_start_gen3(s
 	 * Turn the PLL on, set it to LVDS normal mode, wait for the startup
 	 * delay and turn the output on.
 	 */
-	lvdcr0 = (lvds->mode << LVDCR0_LVMD_SHIFT) | LVDCR0_PLLON;
+	lvdcr0 |= LVDCR0_PLLON;
 	rcar_lvds_write(lvds, LVDCR0, lvdcr0);
 
 	lvdcr0 |= LVDCR0_PWD;
