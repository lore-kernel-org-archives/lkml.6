Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72842C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E26420874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388201AbfAKOYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:24:02 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44107 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388131AbfAKOX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:23:27 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ghxiP-00054N-7F; Fri, 11 Jan 2019 15:23:17 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC4)
        (envelope-from <ore@pengutronix.de>)
        id 1ghxiO-0002wc-5O; Fri, 11 Jan 2019 15:23:16 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 05/11] MIPS: ath79: support setting up clock via DT on all SoC types
Date:   Fri, 11 Jan 2019 15:22:34 +0100
Message-Id: <20190111142240.10908-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111142240.10908-1-o.rempel@pengutronix.de>
References: <20190111142240.10908-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

Use the same functions as the legacy code

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/ath79/clock.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 6262253622b3..c234818b30e1 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -668,16 +668,6 @@ ath79_get_sys_clk_rate(const char *id)
 
 #ifdef CONFIG_OF
 static void __init ath79_clocks_init_dt(struct device_node *np)
-{
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
-}
-
-CLK_OF_DECLARE(ar7100, "qca,ar7100-pll", ath79_clocks_init_dt);
-CLK_OF_DECLARE(ar7240, "qca,ar7240-pll", ath79_clocks_init_dt);
-CLK_OF_DECLARE(ar9340, "qca,ar9340-pll", ath79_clocks_init_dt);
-CLK_OF_DECLARE(ar9550, "qca,qca9550-pll", ath79_clocks_init_dt);
-
-static void __init ath79_clocks_init_dt_ng(struct device_node *np)
 {
 	struct clk *ref_clk;
 	void __iomem *pll_base;
@@ -692,14 +682,21 @@ static void __init ath79_clocks_init_dt_ng(struct device_node *np)
 		goto err_clk;
 	}
 
-	if (of_device_is_compatible(np, "qca,ar9130-pll"))
+	if (of_device_is_compatible(np, "qca,ar7100-pll"))
+		ar71xx_clocks_init(pll_base);
+	else if (of_device_is_compatible(np, "qca,ar7240-pll") ||
+		 of_device_is_compatible(np, "qca,ar9130-pll"))
 		ar724x_clocks_init(pll_base);
 	else if (of_device_is_compatible(np, "qca,ar9330-pll"))
 		ar933x_clocks_init(pll_base);
-	else {
-		pr_err("%pOF: could not find any appropriate clk_init()\n", np);
-		goto err_iounmap;
-	}
+	else if (of_device_is_compatible(np, "qca,ar9340-pll"))
+		ar934x_clocks_init(pll_base);
+	else if (of_device_is_compatible(np, "qca,qca9530-pll"))
+		qca953x_clocks_init(pll_base);
+	else if (of_device_is_compatible(np, "qca,qca9550-pll"))
+		qca955x_clocks_init(pll_base);
+	else if (of_device_is_compatible(np, "qca,qca9560-pll"))
+		qca956x_clocks_init(pll_base);
 
 	if (of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data)) {
 		pr_err("%pOF: could not register clk provider\n", np);
@@ -714,6 +711,14 @@ static void __init ath79_clocks_init_dt_ng(struct device_node *np)
 err_clk:
 	clk_put(ref_clk);
 }
-CLK_OF_DECLARE(ar9130_clk, "qca,ar9130-pll", ath79_clocks_init_dt_ng);
-CLK_OF_DECLARE(ar9330_clk, "qca,ar9330-pll", ath79_clocks_init_dt_ng);
+
+CLK_OF_DECLARE(ar7100_clk, "qca,ar7100-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar7240_clk, "qca,ar7240-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar9130_clk, "qca,ar9130-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar9330_clk, "qca,ar9330-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar9340_clk, "qca,ar9340-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar9530_clk, "qca,qca9530-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar9550_clk, "qca,qca9550-pll", ath79_clocks_init_dt);
+CLK_OF_DECLARE(ar9560_clk, "qca,qca9560-pll", ath79_clocks_init_dt);
+
 #endif
-- 
2.20.1

