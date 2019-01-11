Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9256C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C596A20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388151AbfAKOX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:23:29 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37405 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388026AbfAKOXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:23:23 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ghxiP-00054T-7K; Fri, 11 Jan 2019 15:23:17 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC4)
        (envelope-from <ore@pengutronix.de>)
        id 1ghxiO-0002xW-BL; Fri, 11 Jan 2019 15:23:16 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     John Crispin <john@phrozen.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: [PATCH v1 11/11] MIPS: ath79: drop !OF clock code
Date:   Fri, 11 Jan 2019 15:22:40 +0100
Message-Id: <20190111142240.10908-12-o.rempel@pengutronix.de>
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

From: John Crispin <john@phrozen.org>

With the target now being fully OF based, we can drop the legacy clock
registration code. All clocks are now probed via devicetree.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/ath79/clock.c  | 56 ----------------------------------------
 arch/mips/ath79/common.h |  3 ---
 2 files changed, 59 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index aea9590bf353..d4ca97e2ec6c 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -617,60 +617,6 @@ static void __init qca956x_clocks_init(void __iomem *pll_base)
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
 }
 
-void __init ath79_clocks_init(void)
-{
-	const char *wdt;
-	const char *uart;
-
-	if (soc_is_ar71xx())
-		ar71xx_clocks_init(ath79_pll_base);
-	else if (soc_is_ar724x() || soc_is_ar913x())
-		ar724x_clocks_init(ath79_pll_base);
-	else if (soc_is_ar933x())
-		ar933x_clocks_init(ath79_pll_base);
-	else if (soc_is_ar934x())
-		ar934x_clocks_init(ath79_pll_base);
-	else if (soc_is_qca953x())
-		qca953x_clocks_init(ath79_pll_base);
-	else if (soc_is_qca955x())
-		qca955x_clocks_init(ath79_pll_base);
-	else if (soc_is_qca956x() || soc_is_tp9343())
-		qca956x_clocks_init(ath79_pll_base);
-	else
-		BUG();
-
-	if (soc_is_ar71xx() || soc_is_ar724x() || soc_is_ar913x()) {
-		wdt = "ahb";
-		uart = "ahb";
-	} else if (soc_is_ar933x()) {
-		wdt = "ahb";
-		uart = "ref";
-	} else {
-		wdt = "ref";
-		uart = "ref";
-	}
-
-	clk_add_alias("wdt", NULL, wdt, NULL);
-	clk_add_alias("uart", NULL, uart, NULL);
-}
-
-unsigned long __init
-ath79_get_sys_clk_rate(const char *id)
-{
-	struct clk *clk;
-	unsigned long rate;
-
-	clk = clk_get(NULL, id);
-	if (IS_ERR(clk))
-		panic("unable to get %s clock, err=%d", id, (int) PTR_ERR(clk));
-
-	rate = clk_get_rate(clk);
-	clk_put(clk);
-
-	return rate;
-}
-
-#ifdef CONFIG_OF
 static void __init ath79_clocks_init_dt(struct device_node *np)
 {
 	struct clk *ref_clk;
@@ -727,5 +673,3 @@ CLK_OF_DECLARE(ar9340_clk, "qca,ar9340-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar9530_clk, "qca,qca9530-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar9550_clk, "qca,qca9550-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar9560_clk, "qca,qca9560-pll", ath79_clocks_init_dt);
-
-#endif
diff --git a/arch/mips/ath79/common.h b/arch/mips/ath79/common.h
index 77dd989e5ce0..25b96f59e8e8 100644
--- a/arch/mips/ath79/common.h
+++ b/arch/mips/ath79/common.h
@@ -19,9 +19,6 @@
 #define ATH79_MEM_SIZE_MIN	(2 * 1024 * 1024)
 #define ATH79_MEM_SIZE_MAX	(256 * 1024 * 1024)
 
-void ath79_clocks_init(void);
-unsigned long ath79_get_sys_clk_rate(const char *id);
-
 void ath79_ddr_ctrl_init(void);
 
 #endif /* __ATH79_COMMON_H */
-- 
2.20.1

