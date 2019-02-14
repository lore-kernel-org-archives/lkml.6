Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE49C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E097E2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440172AbfBNV3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:29:45 -0500
Received: from customer-85-204-195-167.ip4.gigabit.dk ([85.204.195.167]:60124
        "EHLO customer-2a00-7660-0ca7-0000-0000-0000-0000-0b1b.ip6.gigabit.dk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388241AbfBNV3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:29:45 -0500
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Feb 2019 16:29:44 EST
Received: by customer-2a00-7660-0ca7-0000-0000-0000-0000-0b1b.ip6.gigabit.dk (Postfix, from userid 1000)
        id F21E74AC6E; Thu, 14 Feb 2019 22:24:37 +0100 (CET)
Message-Id: <641301f26ac895e39b15d62a2ba069b853ab5b09.1550178066.git.rask@formelder.dk>
From:   Rask Ingemann Lambertsen <rask@formelder.dk>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org
Cc:     Olliver Schinagl <oliver@schinagl.nl>,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 14 Feb 2019 16:47:41 +0100
Subject: [PATCH] regulator: axp20x: Fix AXP806 dcdcb copy/paste bug
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An obvious copy/paste bug was introduced with the conversion to sybolic
register masks. The result is contradictory output like this:

vcc-dram: Bringing 1100000uV into 1450000-1450000uV
vcc-dram: 1450 <--> 1550 mV at 1050 mV

This patch fixes it:

vcc-dram: 1450 <--> 1550 mV at 1500 mV

Fixes: db4a555f7c4c ("regulator: axp20x: use defines for masks")
Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
---
 drivers/regulator/axp20x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 1b51d557ab55..f03cae440f7f 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -791,7 +791,7 @@ static const struct regulator_desc axp806_regulators[] = {
 			AXP806_DCDCA_V_CTRL, AXP806_DCDCA_V_CTRL_MASK,
 			AXP806_PWR_OUT_CTRL1, AXP806_PWR_OUT_DCDCA_MASK),
 	AXP_DESC(AXP806, DCDCB, "dcdcb", "vinb", 1000, 2550, 50,
-		 AXP806_DCDCB_V_CTRL, AXP806_DCDCB_V_CTRL,
+		 AXP806_DCDCB_V_CTRL, AXP806_DCDCB_V_CTRL_MASK,
 		 AXP806_PWR_OUT_CTRL1, AXP806_PWR_OUT_DCDCB_MASK),
 	AXP_DESC_RANGES(AXP806, DCDCC, "dcdcc", "vinc",
 			axp806_dcdca_ranges, AXP806_DCDCA_NUM_VOLTAGES,
-- 
2.20.1

