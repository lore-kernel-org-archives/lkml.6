Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13C7C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BE720645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BE720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeJNXLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35566 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726319AbeJNXLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:39 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0004cU-FU; Sun, 14 Oct 2018 16:30:18 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLN-00008z-9K; Sun, 14 Oct 2018 16:30:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Laurent Pinchart" <laurent.pinchart+renesas@ideasonboard.com>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.990570062@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 008/366] drm: rcar-du: lvds: Fix LVDS startup on
 R-Car Gen2
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

commit 8525d04ba8a6a9ecfa4bd619c988ca873a5fc2a4 upstream.

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
[bwh: Backported to 3.16:
 - Mode is always 0
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
@@ -87,10 +87,8 @@ static int rcar_du_lvdsenc_start(struct
 
 	rcar_lvds_write(lvds, LVDCHCR, lvdhcr);
 
-	/* Select the input, hardcode mode 0, enable LVDS operation and turn
-	 * bias circuitry on.
-	 */
-	lvdcr0 = LVDCR0_BEN | LVDCR0_LVEN;
+	/* Select the input and set the LVDS mode. */
+	lvdcr0 = 0;
 	if (rcrtc->index == 2)
 		lvdcr0 |= LVDCR0_DUSEL;
 	rcar_lvds_write(lvds, LVDCR0, lvdcr0);
@@ -99,6 +97,10 @@ static int rcar_du_lvdsenc_start(struct
 	rcar_lvds_write(lvds, LVDCR1, LVDCR1_CHSTBY(3) | LVDCR1_CHSTBY(2) |
 			LVDCR1_CHSTBY(1) | LVDCR1_CHSTBY(0) | LVDCR1_CLKSTBY);
 
+	/* Enable LVDS operation and turn bias circuitry on. */
+	lvdcr0 |= LVDCR0_BEN | LVDCR0_LVEN;
+	rcar_lvds_write(lvds, LVDCR0, lvdcr0);
+
 	/* Turn the PLL on, wait for the startup delay, and turn the output
 	 * on.
 	 */

