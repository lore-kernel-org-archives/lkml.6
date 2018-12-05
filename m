Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D09BC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED7B206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED7B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeLEPkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:40:06 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:34350 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbeLEPjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:39:51 -0500
Received: from ramsan ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id 8Ffo1z00M3XaVaC06Ffo5R; Wed, 05 Dec 2018 16:39:49 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gUZHA-0001yg-9f; Wed, 05 Dec 2018 16:39:48 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gUZHA-0003b1-7e; Wed, 05 Dec 2018 16:39:48 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/4] soc: renesas: rcar-sysc: Fix power domain control after system resume
Date:   Wed,  5 Dec 2018 16:39:45 +0100
Message-Id: <20181205153945.13767-5-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205153945.13767-1-geert+renesas@glider.be>
References: <20181205153945.13767-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To control power to a power domain, the System Controller (SYSC) needs
the corresponding interrupt source to be enabled, but masked, to prevent
the CPU from receiving it.

Currently this is handled in the driver's probe() routine, and set up
for every domain present, even if it will not be controlled directly by
SYSC (CPU domains are powered through the APMU on R-Car Gen2 and later).

On R-Car Gen3, PSCI powers down the SoC during system suspend, thus
loosing any configured interrupt state.  Hence after system resume, power
domains not controlled through the APMU (e.g. A3IR, A3VC, A3VP) fail to
power up.

Fix this by replacing the global interrupt setup in the probe() routine
by a domain-specific interrupt setup in rcar_sysc_power(), where the
domain's power is actually controlled.  This brings the code more in
line with the flowchart in the Hardware User's Manual.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/soc/renesas/rcar-sysc.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 123e553510e826f5..0c80fab4f8de6bc8 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -105,6 +105,15 @@ static int rcar_sysc_power(const struct rcar_sysc_ch *sysc_ch, bool on)
 
 	spin_lock_irqsave(&rcar_sysc_lock, flags);
 
+	/*
+	 * The interrupt source needs to be enabled, but masked, to prevent the
+	 * CPU from receiving it.
+	 */
+	iowrite32(ioread32(rcar_sysc_base + SYSCIMR) | isr_mask,
+		  rcar_sysc_base + SYSCIMR);
+	iowrite32(ioread32(rcar_sysc_base + SYSCIER) | isr_mask,
+		  rcar_sysc_base + SYSCIER);
+
 	iowrite32(isr_mask, rcar_sysc_base + SYSCISCR);
 
 	/* Submit power shutoff or resume request until it was accepted */
@@ -324,7 +333,6 @@ static int __init rcar_sysc_pd_init(void)
 	const struct of_device_id *match;
 	struct rcar_pm_domains *domains;
 	struct device_node *np;
-	u32 syscier, syscimr;
 	void __iomem *base;
 	unsigned int i;
 	int error;
@@ -363,24 +371,6 @@ static int __init rcar_sysc_pd_init(void)
 	domains->onecell_data.num_domains = ARRAY_SIZE(domains->domains);
 	rcar_sysc_onecell_data = &domains->onecell_data;
 
-	for (i = 0, syscier = 0; i < info->num_areas; i++)
-		syscier |= BIT(info->areas[i].isr_bit);
-
-	/*
-	 * Mask all interrupt sources to prevent the CPU from receiving them.
-	 * Make sure not to clear reserved bits that were set before.
-	 */
-	syscimr = ioread32(base + SYSCIMR);
-	syscimr |= syscier;
-	pr_debug("%pOF: syscimr = 0x%08x\n", np, syscimr);
-	iowrite32(syscimr, base + SYSCIMR);
-
-	/*
-	 * SYSC needs all interrupt sources enabled to control power.
-	 */
-	pr_debug("%pOF: syscier = 0x%08x\n", np, syscier);
-	iowrite32(syscier, base + SYSCIER);
-
 	for (i = 0; i < info->num_areas; i++) {
 		const struct rcar_sysc_area *area = &info->areas[i];
 		struct rcar_sysc_pd *pd;
-- 
2.17.1

