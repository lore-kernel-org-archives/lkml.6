Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C6BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D752147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfBSRDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:03:02 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:60907 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfBSRCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:02:12 -0500
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr [90.53.137.203])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id BB48F2000D;
        Tue, 19 Feb 2019 17:02:09 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/7] clk: at91: sckc: handle different RC startup time
Date:   Tue, 19 Feb 2019 18:01:56 +0100
Message-Id: <20190219170200.3608-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
References: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sama5d3 slow RC oscillator as a different startup time than all the
previous SoCs. Handle that using its own compatible.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/sckc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index 470aef586f57..e76b1d64e905 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -321,7 +321,8 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
 	return hw;
 }
 
-static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
+static void __init at91sam9x5_sckc_register(struct device_node *np,
+					    unsigned int rc_osc_startup_us)
 {
 	const char *parent_names[2] = { "slow_rc_osc", "slow_osc" };
 	void __iomem *regbase = of_iomap(np, 0);
@@ -334,7 +335,7 @@ static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
 		return;
 
 	hw = at91_clk_register_slow_rc_osc(regbase, parent_names[0], 32768,
-					   50000000, 75);
+					   50000000, rc_osc_startup_us);
 	if (IS_ERR(hw))
 		return;
 
@@ -371,9 +372,21 @@ static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
 	if (child)
 		of_clk_add_hw_provider(child, of_clk_hw_simple_get, hw);
 }
+
+static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
+{
+	at91sam9x5_sckc_register(np, 75);
+}
 CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
 	       of_at91sam9x5_sckc_setup);
 
+static void __init of_sama5d3_sckc_setup(struct device_node *np)
+{
+	at91sam9x5_sckc_register(np, 500);
+}
+CLK_OF_DECLARE(sama5d3_clk_sckc, "atmel,sama5d3-sckc",
+	       of_sama5d3_sckc_setup);
+
 static int clk_sama5d4_slow_osc_prepare(struct clk_hw *hw)
 {
 	struct clk_sama5d4_slow_osc *osc = to_clk_sama5d4_slow_osc(hw);
-- 
2.20.1

