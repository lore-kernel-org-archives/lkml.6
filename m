Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0B0C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476B62170D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VjMOve7U";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KD/LnPSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476B62170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbeHNPBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:01:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43680 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731879AbeHNPBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:01:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C80FA60D98; Tue, 14 Aug 2018 12:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534248878;
        bh=Vj8QtITOWeeYao1iEjoCk/IzdVOsAZXabdw1qcLgiGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VjMOve7Uh42/yuZmtwfIxa8/DFkSo5l43kDbm3BrexEzpTTG9S6VRHfyj8G9bcfVO
         gFGq4pURpjpPKJl9Ffjgy+PjjZIZLXVI/RRVCVquRMWQR3tMKOLI2OncCqWr8FUUmI
         ig3rvEn1EYPfx2w6P6qgSCjsOuNNFIGDmPIEsKMY=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B491B60C6A;
        Tue, 14 Aug 2018 12:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534248840;
        bh=Vj8QtITOWeeYao1iEjoCk/IzdVOsAZXabdw1qcLgiGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KD/LnPSRwu+OLvhywLcx3jjNFT2KgC0q12SJKUq79pD3GNxybyZ68rEr4AdhsM+k3
         ANk7xHeKWkzfAV7DR/PzvqGXatmrLYd4X+UyfItrNdDNsyLgYz29ifV8p0diPaf2ud
         wSMY1++HndubZJmMQc3KcSDG1m+6yRjA/a5xwk78=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B491B60C6A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     mark.rutland@arm.com, robh@kernel.org, sudeep.holla@arm.com,
        linux@arm.linux.org.uk, ctatlor97@gmail.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, sboyd@codeaurora.org,
        linux@armlinux.org.uk, thierry.escande@linaro.org,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        niklas.cassel@linaro.org
Cc:     sricharan@codeaurora.org
Subject: [PATCH v12 10/14] clk: qcom: Add Krait clock controller driver
Date:   Tue, 14 Aug 2018 17:42:29 +0530
Message-Id: <1534248753-2440-11-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

The Krait CPU clocks are made up of a primary mux and secondary
mux for each CPU and the L2, controlled via cp15 accessors. For
Kraits within KPSSv1 each secondary mux accepts a different aux
source, but on KPSSv2 each secondary mux accepts the same aux
source.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/clk/qcom/Kconfig     |   8 +
 drivers/clk/qcom/Makefile    |   1 +
 drivers/clk/qcom/clk-krait.c |   4 +-
 drivers/clk/qcom/krait-cc.c  | 341 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 352 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/qcom/krait-cc.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 7a99627..7c7ca65 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -289,6 +289,14 @@ config KPSS_XCC
 	  if you want to support CPU frequency scaling on devices such
 	  as MSM8960, APQ8064, etc.
 
+config KRAITCC
+	tristate "Krait Clock Controller"
+	depends on COMMON_CLK_QCOM && ARM
+	select KRAIT_CLOCKS
+	help
+	  Support for the Krait CPU clocks on Qualcomm devices.
+	  Say Y if you want to support CPU frequency scaling.
+
 config KRAIT_CLOCKS
 	bool
 	select KRAIT_L2_ACCESSORS
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 92310ee..949829b 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -47,3 +47,4 @@ obj-$(CONFIG_SDM_VIDEOCC_845) += videocc-sdm845.o
 obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
 obj-$(CONFIG_KPSS_XCC) += kpss-xcc.o
 obj-$(CONFIG_QCOM_HFPLL) += hfpll.o
+obj-$(CONFIG_KRAITCC) += krait-cc.o
diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index 2e41767..7ede744 100644
--- a/drivers/clk/qcom/clk-krait.c
+++ b/drivers/clk/qcom/clk-krait.c
@@ -44,7 +44,7 @@ static int krait_mux_set_parent(struct clk_hw *hw, u8 index)
 	struct krait_mux_clk *mux = to_krait_mux_clk(hw);
 	u32 sel;
 
-	sel = clk_mux_reindex(index, mux->parent_map, 0);
+	sel = clk_mux_index_to_val(mux->parent_map, 0, index);
 	mux->en_mask = sel;
 	/* Don't touch mux if CPU is off as it won't work */
 	if (__clk_is_enabled(hw->clk))
@@ -63,7 +63,7 @@ static u8 krait_mux_get_parent(struct clk_hw *hw)
 	sel &= mux->mask;
 	mux->en_mask = sel;
 
-	return clk_mux_get_parent(hw, sel, mux->parent_map, 0);
+	return clk_mux_val_to_index(hw, mux->parent_map, 0, sel);
 }
 
 const struct clk_ops krait_mux_clk_ops = {
diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
new file mode 100644
index 0000000..7c9dfb0
--- /dev/null
+++ b/drivers/clk/qcom/krait-cc.c
@@ -0,0 +1,341 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+
+#include "clk-krait.h"
+
+static unsigned int sec_mux_map[] = {
+	2,
+	0,
+};
+
+static unsigned int pri_mux_map[] = {
+	1,
+	2,
+	0,
+};
+
+static int
+krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
+{
+	struct krait_div2_clk *div;
+	struct clk_init_data init = {
+		.num_parents = 1,
+		.ops = &krait_div2_clk_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	};
+	const char *p_names[1];
+	struct clk *clk;
+
+	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return -ENOMEM;
+
+	div->width = 2;
+	div->shift = 6;
+	div->lpl = id >= 0;
+	div->offset = offset;
+	div->hw.init = &init;
+
+	init.name = kasprintf(GFP_KERNEL, "hfpll%s_div", s);
+	if (!init.name)
+		return -ENOMEM;
+
+	init.parent_names = p_names;
+	p_names[0] = kasprintf(GFP_KERNEL, "hfpll%s", s);
+	if (!p_names[0]) {
+		kfree(init.name);
+		return -ENOMEM;
+	}
+
+	clk = devm_clk_register(dev, &div->hw);
+	kfree(p_names[0]);
+	kfree(init.name);
+
+	return PTR_ERR_OR_ZERO(clk);
+}
+
+static int
+krait_add_sec_mux(struct device *dev, int id, const char *s,
+		  unsigned int offset, bool unique_aux)
+{
+	struct krait_mux_clk *mux;
+	static const char *sec_mux_list[] = {
+		"acpu_aux",
+		"qsb",
+	};
+	struct clk_init_data init = {
+		.parent_names = sec_mux_list,
+		.num_parents = ARRAY_SIZE(sec_mux_list),
+		.ops = &krait_mux_clk_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	};
+	struct clk *clk;
+
+	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return -ENOMEM;
+
+	mux->offset = offset;
+	mux->lpl = id >= 0;
+	mux->mask = 0x3;
+	mux->shift = 2;
+	mux->parent_map = sec_mux_map;
+	mux->hw.init = &init;
+
+	init.name = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
+	if (!init.name)
+		return -ENOMEM;
+
+	if (unique_aux) {
+		sec_mux_list[0] = kasprintf(GFP_KERNEL, "acpu%s_aux", s);
+		if (!sec_mux_list[0]) {
+			clk = ERR_PTR(-ENOMEM);
+			goto err_aux;
+		}
+	}
+
+	clk = devm_clk_register(dev, &mux->hw);
+
+	if (unique_aux)
+		kfree(sec_mux_list[0]);
+err_aux:
+	kfree(init.name);
+	return PTR_ERR_OR_ZERO(clk);
+}
+
+static struct clk *
+krait_add_pri_mux(struct device *dev, int id, const char *s,
+		  unsigned int offset)
+{
+	struct krait_mux_clk *mux;
+	const char *p_names[3];
+	struct clk_init_data init = {
+		.parent_names = p_names,
+		.num_parents = ARRAY_SIZE(p_names),
+		.ops = &krait_mux_clk_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	};
+	struct clk *clk;
+
+	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	mux->mask = 0x3;
+	mux->shift = 0;
+	mux->offset = offset;
+	mux->lpl = id >= 0;
+	mux->parent_map = pri_mux_map;
+	mux->hw.init = &init;
+
+	init.name = kasprintf(GFP_KERNEL, "krait%s_pri_mux", s);
+	if (!init.name)
+		return ERR_PTR(-ENOMEM);
+
+	p_names[0] = kasprintf(GFP_KERNEL, "hfpll%s", s);
+	if (!p_names[0]) {
+		clk = ERR_PTR(-ENOMEM);
+		goto err_p0;
+	}
+
+	p_names[1] = kasprintf(GFP_KERNEL, "hfpll%s_div", s);
+	if (!p_names[1]) {
+		clk = ERR_PTR(-ENOMEM);
+		goto err_p1;
+	}
+
+	p_names[2] = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
+	if (!p_names[2]) {
+		clk = ERR_PTR(-ENOMEM);
+		goto err_p2;
+	}
+
+	clk = devm_clk_register(dev, &mux->hw);
+
+	kfree(p_names[2]);
+err_p2:
+	kfree(p_names[1]);
+err_p1:
+	kfree(p_names[0]);
+err_p0:
+	kfree(init.name);
+	return clk;
+}
+
+/* id < 0 for L2, otherwise id == physical CPU number */
+static struct clk *krait_add_clks(struct device *dev, int id, bool unique_aux)
+{
+	int ret;
+	unsigned int offset;
+	void *p = NULL;
+	const char *s;
+	struct clk *clk;
+
+	if (id >= 0) {
+		offset = 0x4501 + (0x1000 * id);
+		s = p = kasprintf(GFP_KERNEL, "%d", id);
+		if (!s)
+			return ERR_PTR(-ENOMEM);
+	} else {
+		offset = 0x500;
+		s = "_l2";
+	}
+
+	ret = krait_add_div(dev, id, s, offset);
+	if (ret) {
+		clk = ERR_PTR(ret);
+		goto err;
+	}
+
+	ret = krait_add_sec_mux(dev, id, s, offset, unique_aux);
+	if (ret) {
+		clk = ERR_PTR(ret);
+		goto err;
+	}
+
+	clk = krait_add_pri_mux(dev, id, s, offset);
+err:
+	kfree(p);
+	return clk;
+}
+
+static struct clk *krait_of_get(struct of_phandle_args *clkspec, void *data)
+{
+	unsigned int idx = clkspec->args[0];
+	struct clk **clks = data;
+
+	if (idx >= 5) {
+		pr_err("%s: invalid clock index %d\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return clks[idx] ? : ERR_PTR(-ENODEV);
+}
+
+static const struct of_device_id krait_cc_match_table[] = {
+	{ .compatible = "qcom,krait-cc-v1", (void *)1UL },
+	{ .compatible = "qcom,krait-cc-v2" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, krait_cc_match_table);
+
+static int krait_cc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *id;
+	unsigned long cur_rate, aux_rate;
+	int cpu;
+	struct clk *clk;
+	struct clk **clks;
+	struct clk *l2_pri_mux_clk;
+
+	id = of_match_device(krait_cc_match_table, dev);
+	if (!id)
+		return -ENODEV;
+
+	/* Rate is 1 because 0 causes problems for __clk_mux_determine_rate */
+	clk = clk_register_fixed_rate(dev, "qsb", NULL, 0, 1);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	if (!id->data) {
+		clk = clk_register_fixed_factor(dev, "acpu_aux",
+						"gpll0_vote", 0, 1, 2);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+	}
+
+	/* Krait configurations have at most 4 CPUs and one L2 */
+	clks = devm_kcalloc(dev, 5, sizeof(*clks), GFP_KERNEL);
+	if (!clks)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		clk = krait_add_clks(dev, cpu, id->data);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+		clks[cpu] = clk;
+	}
+
+	l2_pri_mux_clk = krait_add_clks(dev, -1, id->data);
+	if (IS_ERR(l2_pri_mux_clk))
+		return PTR_ERR(l2_pri_mux_clk);
+	clks[4] = l2_pri_mux_clk;
+
+	/*
+	 * We don't want the CPU or L2 clocks to be turned off at late init
+	 * if CPUFREQ or HOTPLUG configs are disabled. So, bump up the
+	 * refcount of these clocks. Any cpufreq/hotplug manager can assume
+	 * that the clocks have already been prepared and enabled by the time
+	 * they take over.
+	 */
+	for_each_online_cpu(cpu) {
+		clk_prepare_enable(l2_pri_mux_clk);
+		WARN(clk_prepare_enable(clks[cpu]),
+		     "Unable to turn on CPU%d clock", cpu);
+	}
+
+	/*
+	 * Force reinit of HFPLLs and muxes to overwrite any potential
+	 * incorrect configuration of HFPLLs and muxes by the bootloader.
+	 * While at it, also make sure the cores are running at known rates
+	 * and print the current rate.
+	 *
+	 * The clocks are set to aux clock rate first to make sure the
+	 * secondary mux is not sourcing off of QSB. The rate is then set to
+	 * two different rates to force a HFPLL reinit under all
+	 * circumstances.
+	 */
+	cur_rate = clk_get_rate(l2_pri_mux_clk);
+	aux_rate = 384000000;
+	if (cur_rate == 1) {
+		pr_info("L2 @ QSB rate. Forcing new rate.\n");
+		cur_rate = aux_rate;
+	}
+	clk_set_rate(l2_pri_mux_clk, aux_rate);
+	clk_set_rate(l2_pri_mux_clk, 2);
+	clk_set_rate(l2_pri_mux_clk, cur_rate);
+	pr_info("L2 @ %lu KHz\n", clk_get_rate(l2_pri_mux_clk) / 1000);
+	for_each_possible_cpu(cpu) {
+		clk = clks[cpu];
+		cur_rate = clk_get_rate(clk);
+		if (cur_rate == 1) {
+			pr_info("CPU%d @ QSB rate. Forcing new rate.\n", cpu);
+			cur_rate = aux_rate;
+		}
+
+		clk_set_rate(clk, aux_rate);
+		clk_set_rate(clk, 2);
+		clk_set_rate(clk, cur_rate);
+		pr_info("CPU%d @ %lu KHz\n", cpu, clk_get_rate(clk) / 1000);
+	}
+
+	of_clk_add_provider(dev->of_node, krait_of_get, clks);
+
+	return 0;
+}
+
+static struct platform_driver krait_cc_driver = {
+	.probe = krait_cc_probe,
+	.driver = {
+		.name = "krait-cc",
+		.of_match_table = krait_cc_match_table,
+	},
+};
+module_platform_driver(krait_cc_driver);
+
+MODULE_DESCRIPTION("Krait CPU Clock Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:krait-cc");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

