Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E6AC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2900122BE8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2900122BE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754951AbeFZUD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:03:56 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:57881 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752201AbeFZUDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:03:41 -0400
Received: from belgarion.home ([90.55.203.186])
        by mwinf5d15 with ME
        id 3Y3J1y00841oiFu03Y3Uos; Tue, 26 Jun 2018 22:03:38 +0200
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Tue, 26 Jun 2018 22:03:38 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 1/2] clk: pxa: export 32kHz PLL
Date:   Tue, 26 Jun 2018 22:03:07 +0200
Message-Id: <20180626200308.16192-1-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This clock is especially used by the RTC driver, so export it so that
devicetree users can use it.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/clk/pxa/clk-pxa25x.c          | 6 ++++--
 drivers/clk/pxa/clk-pxa27x.c          | 7 ++++---
 drivers/clk/pxa/clk-pxa3xx.c          | 7 ++++---
 include/dt-bindings/clock/pxa-clock.h | 3 ++-
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/pxa/clk-pxa25x.c b/drivers/clk/pxa/clk-pxa25x.c
index 6416c1f8e632..c0e7c74ebd7b 100644
--- a/drivers/clk/pxa/clk-pxa25x.c
+++ b/drivers/clk/pxa/clk-pxa25x.c
@@ -292,8 +292,10 @@ static void __init pxa25x_register_plls(void)
 {
 	clk_register_fixed_rate(NULL, "osc_3_6864mhz", NULL,
 				CLK_GET_RATE_NOCACHE, 3686400);
-	clk_register_fixed_rate(NULL, "osc_32_768khz", NULL,
-				CLK_GET_RATE_NOCACHE, 32768);
+	clkdev_pxa_register(CLK_OSC32k768, "osc_32_768khz", NULL,
+			    clk_register_fixed_rate(NULL, "osc_32_768khz", NULL,
+						    CLK_GET_RATE_NOCACHE,
+						    32768);
 	clk_register_fixed_rate(NULL, "clk_dummy", NULL, 0, 0);
 	clk_register_fixed_factor(NULL, "ppll_95_85mhz", "osc_3_6864mhz",
 				  0, 26, 1);
diff --git a/drivers/clk/pxa/clk-pxa27x.c b/drivers/clk/pxa/clk-pxa27x.c
index 25a30194d27a..d40b63e7bbce 100644
--- a/drivers/clk/pxa/clk-pxa27x.c
+++ b/drivers/clk/pxa/clk-pxa27x.c
@@ -314,9 +314,10 @@ static void __init pxa27x_register_plls(void)
 	clk_register_fixed_rate(NULL, "osc_13mhz", NULL,
 				CLK_GET_RATE_NOCACHE,
 				13 * MHz);
-	clk_register_fixed_rate(NULL, "osc_32_768khz", NULL,
-				CLK_GET_RATE_NOCACHE,
-				32768 * KHz);
+	clkdev_pxa_register(CLK_OSC32k768, "osc_32_768khz", NULL,
+			    clk_register_fixed_rate(NULL, "osc_32_768khz", NULL,
+						    CLK_GET_RATE_NOCACHE,
+						    32768 * KHz));
 	clk_register_fixed_rate(NULL, "clk_dummy", NULL, 0, 0);
 	clk_register_fixed_factor(NULL, "ppll_312mhz", "osc_13mhz", 0, 24, 1);
 }
diff --git a/drivers/clk/pxa/clk-pxa3xx.c b/drivers/clk/pxa/clk-pxa3xx.c
index 2d126df2bccd..814b651c0504 100644
--- a/drivers/clk/pxa/clk-pxa3xx.c
+++ b/drivers/clk/pxa/clk-pxa3xx.c
@@ -286,9 +286,10 @@ static void __init pxa3xx_register_plls(void)
 	clk_register_fixed_rate(NULL, "osc_13mhz", NULL,
 				CLK_GET_RATE_NOCACHE,
 				13 * MHz);
-	clk_register_fixed_rate(NULL, "osc_32_768khz", NULL,
-				CLK_GET_RATE_NOCACHE,
-				32768);
+	clkdev_pxa_register(CLK_OSC32k768, "osc_32_768khz", NULL,
+			    clk_register_fixed_rate(NULL, "osc_32_768khz", NULL,
+						    CLK_GET_RATE_NOCACHE,
+						    32768);
 	clk_register_fixed_rate(NULL, "ring_osc_120mhz", NULL,
 				CLK_GET_RATE_NOCACHE,
 				120 * MHz);
diff --git a/include/dt-bindings/clock/pxa-clock.h b/include/dt-bindings/clock/pxa-clock.h
index e65803b1dc7e..0b0fd2b01538 100644
--- a/include/dt-bindings/clock/pxa-clock.h
+++ b/include/dt-bindings/clock/pxa-clock.h
@@ -72,6 +72,7 @@
 #define CLK_USIM 58
 #define CLK_USIM1 59
 #define CLK_USMI0 60
-#define CLK_MAX 61
+#define CLK_OSC32k768 61
+#define CLK_MAX 62
 
 #endif
-- 
2.11.0

