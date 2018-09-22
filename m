Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1344EC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 18:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EA02150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 18:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EA02150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeIWAL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 20:11:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35170 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbeIWAL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 20:11:59 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3A034207AB; Sat, 22 Sep 2018 20:17:29 +0200 (CEST)
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id 00F64207D4;
        Sat, 22 Sep 2018 20:17:18 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH 4/6] clk: mvebu: ap806: Fix clock name for the cluster
Date:   Sat, 22 Sep 2018 20:17:07 +0200
Message-Id: <20180922181709.13007-5-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180922181709.13007-1-gregory.clement@bootlin.com>
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, the clocks exposed for the cluster are not the CPU clocks, but
the PLL clock used as entry clock for the CPU clocks. The CPU clock will
be managed by a driver submitting in the following patches.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/clk/mvebu/ap806-system-controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/ap806-system-controller.c b/drivers/clk/mvebu/ap806-system-controller.c
index 0a58824ff053..73ba8fd7860f 100644
--- a/drivers/clk/mvebu/ap806-system-controller.c
+++ b/drivers/clk/mvebu/ap806-system-controller.c
@@ -97,7 +97,7 @@ static int ap806_syscon_common_probe(struct platform_device *pdev,
 	cpuclk_freq *= 1000 * 1000;
 
 	/* CPU clocks depend on the Sample At Reset configuration */
-	name = ap_cp_unique_name(dev, syscon_node, "cpu-cluster-0");
+	name = ap_cp_unique_name(dev, syscon_node, "pll-cluster-0");
 	ap806_clks[0] = clk_register_fixed_rate(dev, name, NULL,
 						0, cpuclk_freq);
 	if (IS_ERR(ap806_clks[0])) {
@@ -105,7 +105,7 @@ static int ap806_syscon_common_probe(struct platform_device *pdev,
 		goto fail0;
 	}
 
-	name = ap_cp_unique_name(dev, syscon_node, "cpu-cluster-1");
+	name = ap_cp_unique_name(dev, syscon_node, "pll-cluster-1");
 	ap806_clks[1] = clk_register_fixed_rate(dev, name, NULL, 0,
 						cpuclk_freq);
 	if (IS_ERR(ap806_clks[1])) {
-- 
2.19.0

