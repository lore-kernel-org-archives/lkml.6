Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199ECC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D578D2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nr9ocG7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D578D2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbeKMPrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:47:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731518AbeKMPrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:47:04 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB7A422510;
        Tue, 13 Nov 2018 05:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088237;
        bh=XwB+T1is2BIC6LkbniEMIhJadiGYRkh2O9lYmKPM4CY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nr9ocG7C5euqipd/uNbaH4LUZvZ9Uba1KMRn/mKrQa4ZWb9HdI704mYIDmaIjNtUo
         cQkn1Bkc4DKQJYOHhgX8bXk+KIjbovY7RqR1C5Vpdek3tSjvy/X1sKKOqgLtTjgOfJ
         VZnEQWo36/4K/qpTKWGjU7PbaNzgf/fRl4mjy2+U=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 35/44] clk: sunxi-ng: sun50i: h6: Add 2x fixed post-divider to MMC module clocks
Date:   Tue, 13 Nov 2018 00:49:41 -0500
Message-Id: <20181113054950.77898-35-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113054950.77898-1-sashal@kernel.org>
References: <20181113054950.77898-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

[ Upstream commit c2ff8383cc33c2d9c169e4daf1e37a434c3bb420 ]

On the H6, the MMC module clocks are fixed in the new timing mode,
i.e. they do not have a bit to select the mode. These clocks have
a 2x divider somewhere between the clock and the MMC module.

To be consistent with other SoCs supporting the new timing mode,
we model the 2x divider as a fixed post-divider on the MMC module
clocks.

This patch adds the post-dividers to the MMC clocks, following the
approach on A64.

Fixes: 524353ea480b ("clk: sunxi-ng: add support for the Allwinner H6 CCU")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 43 +++++++++++++++-------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index bdbfe78fe133..3d60f7978506 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -408,26 +408,29 @@ static SUNXI_CCU_GATE(bus_nand_clk, "bus-nand", "ahb3", 0x82c, BIT(0), 0);
 
 static const char * const mmc_parents[] = { "osc24M", "pll-periph0-2x",
 					    "pll-periph1-2x" };
-static SUNXI_CCU_MP_WITH_MUX_GATE(mmc0_clk, "mmc0", mmc_parents, 0x830,
-					0, 4,	/* M */
-					8, 2,	/* N */
-					24, 3,	/* mux */
-					BIT(31),/* gate */
-					0);
-
-static SUNXI_CCU_MP_WITH_MUX_GATE(mmc1_clk, "mmc1", mmc_parents, 0x834,
-					0, 4,	/* M */
-					8, 2,	/* N */
-					24, 3,	/* mux */
-					BIT(31),/* gate */
-					0);
-
-static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_clk, "mmc2", mmc_parents, 0x838,
-					0, 4,	/* M */
-					8, 2,	/* N */
-					24, 3,	/* mux */
-					BIT(31),/* gate */
-					0);
+static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc0_clk, "mmc0", mmc_parents, 0x830,
+					  0, 4,		/* M */
+					  8, 2,		/* N */
+					  24, 3,	/* mux */
+					  BIT(31),	/* gate */
+					  2,		/* post-div */
+					  0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1", mmc_parents, 0x834,
+					  0, 4,		/* M */
+					  8, 2,		/* N */
+					  24, 3,	/* mux */
+					  BIT(31),	/* gate */
+					  2,		/* post-div */
+					  0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2", mmc_parents, 0x838,
+					  0, 4,		/* M */
+					  8, 2,		/* N */
+					  24, 3,	/* mux */
+					  BIT(31),	/* gate */
+					  2,		/* post-div */
+					  0);
 
 static SUNXI_CCU_GATE(bus_mmc0_clk, "bus-mmc0", "ahb3", 0x84c, BIT(0), 0);
 static SUNXI_CCU_GATE(bus_mmc1_clk, "bus-mmc1", "ahb3", 0x84c, BIT(1), 0);
-- 
2.17.1

