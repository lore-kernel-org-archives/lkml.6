Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9EE06C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49858208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMO4SZi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49858208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965086AbeFNVzx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 17:55:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53168 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965023AbeFNVzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 17:55:47 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so411444wmb.2;
        Thu, 14 Jun 2018 14:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f87psXBEEcPCKnMxIg2du5pf7F+lFkDfUK2uP3OhcqA=;
        b=nMO4SZi9aCa+Sdo5q3tRGiI5i65YX58UNqt/GaEWbPrnapuH3d8ylZfPl1LHvW0F9f
         SAt135TPC59HZO6sPxRKRY/mLRgnrO5478M5JdOKhtFBaJNYbY76eqWX4hlgo0vsn0ta
         nl+vhmjtS675/IOpWrAGwMDtT4G7pby2HQksl/+dlRDoaD8sS64xxr0DLVwudWNEAktz
         IuIXTvwu/7gMAMTgoP380DDkoNLjP/EWCthQ5MzuSe2vB7fNTx60vD7jJpEShXteoaHf
         +1YV1H305VMJONzxU91vICSE63z1eScUQ4edPzbfNzIC/ZwMhcXDiW3jJJBlMvBQ1vzJ
         h5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f87psXBEEcPCKnMxIg2du5pf7F+lFkDfUK2uP3OhcqA=;
        b=tUulRTnHbtvoGeEpqIHg/9aQ/TczgceHzJ7x5rFV8E9zptQD36FSh0MGMqhFb8n6eJ
         eXM8zrdd4feh5n8fdm98twAjLYkN0/pGB6hHS8wYSc9GGtQea/u3C5ZkeJnwoYBR/wdU
         W5bGvxVhImwCwf0R5hfbY+26o0cnxrz2Hf0LGW5f0DOkwl7161xIwp2wYhndn/qpHetD
         LZVF2mi7zZIdX9UFjYZEOxnV62AnaJ+LuTySrsVbDT0mn2pEv7ABrrM5QzuarEdtrVID
         F97sm4BuyIHfgaXL9bmwBRs62ebFIgyYZgVbdTpi9bv/vRiSxfqYU1kEhFPjRPz42Zr2
         QxzQ==
X-Gm-Message-State: APt69E2urqG8Fd4QP1AYtd6oIU3GCDe6wxoe1v7gNmtKYzt/sx4Ix1U1
        o+rmm2KqKH0HeVeS++G4wv0=
X-Google-Smtp-Source: ADUXVKLJqOhaMr2KIGOxADA3SlMM3UvLGN3HoouCyyhbmMTjWiUNowfAWju1BxEpHy5wXs1gbXt79Q==
X-Received: by 2002:a1c:9189:: with SMTP id t131-v6mr3428807wmd.89.1529013345728;
        Thu, 14 Jun 2018 14:55:45 -0700 (PDT)
Received: from gcc67.tetaneutral.net (gcc67.tetaneutral.net. [2a03:7220:8080:c00::1])
        by smtp.gmail.com with ESMTPSA id i76-v6sm285367wmd.20.2018.06.14.14.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 14:55:45 -0700 (PDT)
From:   ilia.lin@gmail.com
To:     ilia.lin@gmail.com
Cc:     Ilia Lin <ilialin@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v13 8/8] clk: qcom: Add ACD path to CPU clock driver for msm8996
Date:   Thu, 14 Jun 2018 23:53:55 +0200
Message-Id: <20180614215358.11264-9-ilia.lin@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180614215358.11264-1-ilia.lin@gmail.com>
References: <20180614215358.11264-1-ilia.lin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilia Lin <ilialin@codeaurora.org>

The PMUX for each duplex allows for selection of ACD clock source.
The DVM (Dynamic Variation Monitor) will flag an error
when a voltage droop event is detected. This flagged error
enables ACD to provide a div-by-2 clock, sourced from the primary PLL.
The duplex will be provided the divided clock
until a pre-programmed delay has expired.

This change configures ACD during the probe and switches
the PMUXes to the ACD clock source.

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/clk/qcom/clk-cpu-8996.c | 75 +++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index ff5c0a5740d2..0a908d849cda 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -53,9 +53,11 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <soc/qcom/kryo-l2-accessors.h>
 
 #include "clk-alpha-pll.h"
 #include "clk-regmap.h"
@@ -69,6 +71,11 @@ enum _pmux_input {
 };
 
 #define DIV_2_THRESHOLD		600000000
+#define PWRCL_REG_OFFSET 0x0
+#define PERFCL_REG_OFFSET 0x80000
+#define MUX_OFFSET	0x40
+#define ALT_PLL_OFFSET	0x100
+#define SSSCTL_OFFSET 0x160
 
 static const u8 prim_pll_regs[PLL_OFF_MAX_REGS] = {
        [PLL_OFF_L_VAL] = 0x04,
@@ -107,7 +114,7 @@ static const struct alpha_pll_config hfpll_config = {
 };
 
 static struct clk_alpha_pll perfcl_pll = {
-	.offset = 0x80000,
+	.offset = PERFCL_REG_OFFSET,
 	.regs = prim_pll_regs,
 	.flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
 	.clkr.hw.init = &(struct clk_init_data){
@@ -119,7 +126,7 @@ static struct clk_alpha_pll perfcl_pll = {
 };
 
 static struct clk_alpha_pll pwrcl_pll = {
-	.offset = 0x0,
+	.offset = PWRCL_REG_OFFSET,
 	.regs = prim_pll_regs,
 	.flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
 	.clkr.hw.init = &(struct clk_init_data){
@@ -149,7 +156,7 @@ static const struct alpha_pll_config altpll_config = {
 };
 
 static struct clk_alpha_pll perfcl_alt_pll = {
-	.offset = 0x80100,
+	.offset = PERFCL_REG_OFFSET + ALT_PLL_OFFSET,
 	.regs = alt_pll_regs,
 	.vco_table = alt_pll_vco_modes,
 	.num_vco = ARRAY_SIZE(alt_pll_vco_modes),
@@ -163,7 +170,7 @@ static struct clk_alpha_pll perfcl_alt_pll = {
 };
 
 static struct clk_alpha_pll pwrcl_alt_pll = {
-	.offset = 0x100,
+	.offset = PWRCL_REG_OFFSET + ALT_PLL_OFFSET,
 	.regs = alt_pll_regs,
 	.vco_table = alt_pll_vco_modes,
 	.num_vco = ARRAY_SIZE(alt_pll_vco_modes),
@@ -176,6 +183,9 @@ static struct clk_alpha_pll pwrcl_alt_pll = {
 	},
 };
 
+void __iomem *base;
+static void qcom_cpu_clk_msm8996_acd_init(void __iomem *base);
+
 /* Mux'es */
 
 struct clk_cpu_8996_mux {
@@ -253,6 +263,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 	switch (event) {
 	case PRE_RATE_CHANGE:
 		ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, ALT_INDEX);
+		qcom_cpu_clk_msm8996_acd_init(base);
 		break;
 	case POST_RATE_CHANGE:
 		if (cnd->new_rate < DIV_2_THRESHOLD)
@@ -260,7 +271,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 							  DIV_2_INDEX);
 		else
 			ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw,
-							  PLL_INDEX);
+							  ACD_INDEX);
 		break;
 	default:
 		ret = 0;
@@ -276,7 +287,7 @@ const struct clk_ops clk_cpu_8996_mux_ops = {
 };
 
 static struct clk_cpu_8996_mux pwrcl_smux = {
-	.reg = 0x40,
+	.reg = PWRCL_REG_OFFSET + MUX_OFFSET,
 	.shift = 2,
 	.width = 2,
 	.clkr.hw.init = &(struct clk_init_data) {
@@ -292,7 +303,7 @@ static struct clk_cpu_8996_mux pwrcl_smux = {
 };
 
 static struct clk_cpu_8996_mux perfcl_smux = {
-	.reg = 0x80040,
+	.reg = PERFCL_REG_OFFSET + MUX_OFFSET,
 	.shift = 2,
 	.width = 2,
 	.clkr.hw.init = &(struct clk_init_data) {
@@ -308,7 +319,7 @@ static struct clk_cpu_8996_mux perfcl_smux = {
 };
 
 static struct clk_cpu_8996_mux pwrcl_pmux = {
-	.reg = 0x40,
+	.reg = PWRCL_REG_OFFSET + MUX_OFFSET,
 	.shift = 0,
 	.width = 2,
 	.pll = &pwrcl_pll.clkr.hw,
@@ -329,7 +340,7 @@ static struct clk_cpu_8996_mux pwrcl_pmux = {
 };
 
 static struct clk_cpu_8996_mux perfcl_pmux = {
-	.reg = 0x80040,
+	.reg = PERFCL_REG_OFFSET + MUX_OFFSET,
 	.shift = 0,
 	.width = 2,
 	.pll = &perfcl_pll.clkr.hw,
@@ -393,6 +404,10 @@ qcom_cpu_clk_msm8996_register_clks(struct device *dev, struct regmap *regmap)
 	clk_alpha_pll_configure(&perfcl_alt_pll, regmap, &altpll_config);
 	clk_alpha_pll_configure(&pwrcl_alt_pll, regmap, &altpll_config);
 
+	/* Enable alt PLLs */
+	clk_prepare_enable(pwrcl_alt_pll.clkr.hw.clk);
+	clk_prepare_enable(perfcl_alt_pll.clkr.hw.clk);
+
 	ret = clk_notifier_register(pwrcl_pmux.clkr.hw.clk, &pwrcl_pmux.nb);
 	if (ret)
 		return ret;
@@ -402,10 +417,48 @@ qcom_cpu_clk_msm8996_register_clks(struct device *dev, struct regmap *regmap)
 	return ret;
 }
 
+#define CPU_AFINITY_MASK 0xFFF
+#define PWRCL_CPU_REG_MASK 0x3
+#define PERFCL_CPU_REG_MASK 0x103
+
+#define L2ACDCR_REG 0x580ULL
+#define L2ACDTD_REG 0x581ULL
+#define L2ACDDVMRC_REG 0x584ULL
+#define L2ACDSSCR_REG 0x589ULL
+
+static DEFINE_SPINLOCK(acd_lock);
+
+static void qcom_cpu_clk_msm8996_acd_init(void __iomem *base)
+{
+	u64 hwid;
+	unsigned long flags;
+
+	spin_lock_irqsave(&acd_lock, flags);
+
+	hwid = read_cpuid_mpidr() & CPU_AFINITY_MASK;
+
+	kryo_l2_set_indirect_reg(L2ACDTD_REG, 0x00006A11);
+	kryo_l2_set_indirect_reg(L2ACDDVMRC_REG, 0x000E0F0F);
+	kryo_l2_set_indirect_reg(L2ACDSSCR_REG, 0x00000601);
+
+	if (PWRCL_CPU_REG_MASK == (hwid | PWRCL_CPU_REG_MASK)) {
+		writel(0xF, base + PWRCL_REG_OFFSET + SSSCTL_OFFSET);
+		wmb();
+		kryo_l2_set_indirect_reg(L2ACDCR_REG, 0x002C5FFD);
+	}
+
+	if (PERFCL_CPU_REG_MASK == (hwid | PERFCL_CPU_REG_MASK)) {
+		kryo_l2_set_indirect_reg(L2ACDCR_REG, 0x002C5FFD);
+		writel(0xF, base + PERFCL_REG_OFFSET + SSSCTL_OFFSET);
+		wmb();
+	}
+
+	spin_unlock_irqrestore(&acd_lock, flags);
+}
+
 static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pdev)
 {
 	int ret;
-	void __iomem *base;
 	struct resource *res;
 	struct regmap *regmap;
 	struct clk_hw_onecell_data *data;
@@ -429,6 +482,8 @@ static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	qcom_cpu_clk_msm8996_acd_init(base);
+
 	data->hws[0] = &pwrcl_pmux.clkr.hw;
 	data->hws[1] = &perfcl_pmux.clkr.hw;
 	data->num = 2;
-- 
2.11.0

