Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDBEC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A591220843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z9msS7cM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Yp2OIwX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A591220843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeICQNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:13:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34500 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbeICQNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:13:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 61BD8607B5; Mon,  3 Sep 2018 11:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535975603;
        bh=OYpOCmYEXjh8jxJQDs1KTcuThX/0XXlHULSVUlpKJLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z9msS7cMdVmNRLKEWO1Gdi17eeDKSU83jmTE3DgkLAE0ZV8RpbDayYX+OYDOyrtVT
         B8McV33HUiPPLk5DCdI2eLxykxDVl7QIOQf+n7pg+2m/bEwgr7zeCeaUatyccskqgD
         mxxIMW79YiC0GR4qfJJj906tKVc4vGQvQbDIf0As=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F1760607B5;
        Mon,  3 Sep 2018 11:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535975601;
        bh=OYpOCmYEXjh8jxJQDs1KTcuThX/0XXlHULSVUlpKJLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yp2OIwX9FEl8RgtoWg8TwP3UqYhIVm10UVdGARCvDj475GH7Iko+hHPzDp+FUIDmR
         WPXp7Pl069w2MmgO9XqwQSpNg31g90qe5gl795pQCLa3eUCpgUB9T/h86zgol251Tz
         +56aUj/gAMukYykW61EsAXe5kSCBkfTJTlgUY10E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F1760607B5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, bgoswami@codeaurora.org,
        srinivas.kandagatla@linaro.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v3 2/2] remoteproc: qcom: Introduce Non-PAS ADSP PIL driver
Date:   Mon,  3 Sep 2018 17:22:40 +0530
Message-Id: <1535975560-8200-3-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535975560-8200-1-git-send-email-rohitkr@codeaurora.org>
References: <1535975560-8200-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds Non PAS ADSP PIL driver for Qualcomm
Technologies Inc SoCs.
Added initial support for SDM845 with ADSP bootup and
shutdown operation handled from Application Processor
SubSystem(APSS).

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 drivers/remoteproc/Kconfig         |  14 ++
 drivers/remoteproc/Makefile        |   1 +
 drivers/remoteproc/qcom_adsp_pil.c | 500 +++++++++++++++++++++++++++++++++++++
 3 files changed, 515 insertions(+)
 create mode 100644 drivers/remoteproc/qcom_adsp_pil.c

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index c98c0b2..445de2d 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -139,6 +139,20 @@ config QCOM_Q6V5_WCSS
 	  Say y here to support the Qualcomm Peripheral Image Loader for the
 	  Hexagon V5 based WCSS remote processors.
 
+config QCOM_ADSP_PIL
+	tristate "Qualcomm Technology Inc ADSP Peripheral Image Loader"
+	depends on OF && ARCH_QCOM
+	depends on QCOM_SMEM
+	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
+	depends on QCOM_SYSMON || QCOM_SYSMON=n
+	select MFD_SYSCON
+	select QCOM_MDT_LOADER
+	select QCOM_Q6V5_COMMON
+	select QCOM_RPROC_COMMON
+	help
+	  Say y here to support the Peripherial Image Loader
+	  for the Qualcomm Technology Inc. ADSP remote processors.
+
 config QCOM_SYSMON
 	tristate "Qualcomm sysmon driver"
 	depends on RPMSG
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index eb86c8b..1258519 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
 obj-$(CONFIG_QCOM_Q6V5_PAS)		+= qcom_q6v5_pas.o
 obj-$(CONFIG_QCOM_Q6V5_PIL)		+= qcom_q6v5_pil.o
 obj-$(CONFIG_QCOM_Q6V5_WCSS)		+= qcom_q6v5_wcss.o
+obj-$(CONFIG_QCOM_ADSP_PIL)		+= qcom_adsp_pil.o
 obj-$(CONFIG_QCOM_SYSMON)		+= qcom_sysmon.o
 obj-$(CONFIG_QCOM_WCNSS_PIL)		+= qcom_wcnss_pil.o
 qcom_wcnss_pil-y			+= qcom_wcnss.o
diff --git a/drivers/remoteproc/qcom_adsp_pil.c b/drivers/remoteproc/qcom_adsp_pil.c
new file mode 100644
index 0000000..977e804
--- /dev/null
+++ b/drivers/remoteproc/qcom_adsp_pil.c
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Qualcomm Technology Inc. ADSP Peripheral Image Loader for SDM845.
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/clk.h>
+#include <linux/firmware.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/reset.h>
+#include <linux/iopoll.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc.h>
+#include <linux/soc/qcom/mdt_loader.h>
+#include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/smem_state.h>
+
+#include "qcom_common.h"
+#include "qcom_q6v5.h"
+#include "remoteproc_internal.h"
+
+/* time out value */
+#define ACK_TIMEOUT			1000
+#define BOOT_FSM_TIMEOUT		10000
+/* mask values */
+#define EVB_MASK			GENMASK(27, 4)
+/*QDSP6SS register offsets*/
+#define RST_EVB_REG			0x10
+#define CORE_START_REG			0x400
+#define BOOT_CMD_REG			0x404
+#define BOOT_STATUS_REG			0x408
+#define RET_CFG_REG			0x1C
+/*TCSR register offsets*/
+#define LPASS_MASTER_IDLE_REG		0x8
+#define LPASS_HALTACK_REG		0x4
+#define LPASS_PWR_ON_REG		0x10
+#define LPASS_HALTREQ_REG		0x0
+
+/* list of clocks required by ADSP PIL */
+static const char * const adsp_clk_id[] = {
+	"sway_cbcr", "lpass_aon", "lpass_ahbs_aon_cbcr", "lpass_ahbm_aon_cbcr",
+	"qdsp6ss_xo", "qdsp6ss_sleep", "qdsp6ss_core",
+};
+
+struct adsp_pil_data {
+	int crash_reason_smem;
+	const char *firmware_name;
+
+	const char *ssr_name;
+	const char *sysmon_name;
+	int ssctl_id;
+};
+
+struct qcom_adsp {
+	struct device *dev;
+	struct rproc *rproc;
+
+	struct qcom_q6v5 q6v5;
+
+	struct clk *xo;
+
+	int num_clks;
+	struct clk_bulk_data *clks;
+
+	void __iomem *qdsp6ss_base;
+
+	struct reset_control *pdc_sync_reset;
+	struct reset_control *cc_lpass_restart;
+
+	struct regmap *halt_map;
+	unsigned int  halt_lpass;
+
+	int crash_reason_smem;
+
+	struct completion start_done;
+	struct completion stop_done;
+
+	phys_addr_t mem_phys;
+	phys_addr_t mem_reloc;
+	void *mem_region;
+	size_t mem_size;
+
+	struct qcom_rproc_glink glink_subdev;
+	struct qcom_rproc_ssr ssr_subdev;
+	struct qcom_sysmon *sysmon;
+};
+
+static int qcom_adsp_shutdown(struct qcom_adsp *adsp)
+{
+	unsigned long timeout;
+	unsigned int val;
+	int ret;
+
+	/* Reset the retention logic */
+	val = readl(adsp->qdsp6ss_base + RET_CFG_REG);
+	val |= 0x1;
+	writel(val, adsp->qdsp6ss_base + RET_CFG_REG);
+
+	clk_bulk_disable_unprepare(adsp->num_clks, adsp->clks);
+
+	/* QDSP6 master port needs to be explicitly halted */
+	ret = regmap_read(adsp->halt_map,
+			adsp->halt_lpass + LPASS_PWR_ON_REG, &val);
+	if (ret || !val)
+		goto reset;
+
+	ret = regmap_read(adsp->halt_map,
+			adsp->halt_lpass + LPASS_MASTER_IDLE_REG,
+			&val);
+	if (ret || val)
+		goto reset;
+
+	regmap_write(adsp->halt_map,
+			adsp->halt_lpass + LPASS_HALTREQ_REG, 1);
+
+	/*  Wait for halt ACK from QDSP6 */
+	timeout = jiffies + msecs_to_jiffies(ACK_TIMEOUT);
+	for (;;) {
+		ret = regmap_read(adsp->halt_map,
+			adsp->halt_lpass + LPASS_HALTACK_REG, &val);
+		if (ret || val || time_after(jiffies, timeout))
+			break;
+
+		udelay(1000);
+	}
+
+	ret = regmap_read(adsp->halt_map,
+			adsp->halt_lpass + LPASS_MASTER_IDLE_REG, &val);
+	if (ret || !val)
+		dev_err(adsp->dev, "port failed halt\n");
+
+reset:
+	/* Assert the LPASS PDC Reset */
+	reset_control_assert(adsp->pdc_sync_reset);
+	/* Place the LPASS processor into reset */
+	reset_control_assert(adsp->cc_lpass_restart);
+	/* wait after asserting subsystem restart from AOSS */
+	udelay(200);
+
+	/* Clear the halt request for the AXIM and AHBM for Q6 */
+	regmap_write(adsp->halt_map, adsp->halt_lpass + LPASS_HALTREQ_REG, 0);
+
+	/* De-assert the LPASS PDC Reset */
+	reset_control_deassert(adsp->pdc_sync_reset);
+	/* Remove the LPASS reset */
+	reset_control_deassert(adsp->cc_lpass_restart);
+	/* wait after de-asserting subsystem restart from AOSS */
+	udelay(200);
+
+	return 0;
+}
+
+static int adsp_load(struct rproc *rproc, const struct firmware *fw)
+{
+	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+
+	return qcom_mdt_load_no_init(adsp->dev, fw, rproc->firmware, 0,
+			     adsp->mem_region, adsp->mem_phys, adsp->mem_size,
+			     &adsp->mem_reloc);
+}
+
+static int adsp_start(struct rproc *rproc)
+{
+	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+	int ret;
+	unsigned int val;
+
+	qcom_q6v5_prepare(&adsp->q6v5);
+
+	ret = clk_prepare_enable(adsp->xo);
+	if (ret)
+		return ret;
+
+	dev_pm_genpd_set_performance_state(adsp->dev, INT_MAX);
+	ret = pm_runtime_get_sync(adsp->dev);
+	if (ret)
+		goto disable_xo_clk;
+
+	ret = clk_bulk_prepare_enable(adsp->num_clks, adsp->clks);
+	if (ret) {
+		dev_err(adsp->dev, "adsp clk_enable failed\n");
+		goto disable_power_domain;
+	}
+
+	/* Program boot address */
+	writel(adsp->mem_phys >> 4, adsp->qdsp6ss_base + RST_EVB_REG);
+
+	/* De-assert QDSP6 stop core. QDSP6 will execute after out of reset */
+	writel(0x1, adsp->qdsp6ss_base + CORE_START_REG);
+
+	/* Trigger boot FSM to start QDSP6 */
+	writel(0x1, adsp->qdsp6ss_base + BOOT_CMD_REG);
+
+	/* Wait for core to come out of reset */
+	ret = readl_poll_timeout(adsp->qdsp6ss_base + BOOT_STATUS_REG,
+			val, (val & BIT(0)) != 0, 10, BOOT_FSM_TIMEOUT);
+	if (ret) {
+		dev_err(adsp->dev, "failed to bootup adsp\n");
+		goto disable_adsp_clks;
+	}
+
+	ret = qcom_q6v5_wait_for_start(&adsp->q6v5, msecs_to_jiffies(5 * HZ));
+	if (ret == -ETIMEDOUT) {
+		dev_err(adsp->dev, "start timed out\n");
+		goto disable_adsp_clks;
+	}
+
+	return 0;
+
+disable_adsp_clks:
+	clk_bulk_disable_unprepare(adsp->num_clks, adsp->clks);
+disable_power_domain:
+	dev_pm_genpd_set_performance_state(adsp->dev, 0);
+	pm_runtime_put(adsp->dev);
+disable_xo_clk:
+	clk_disable_unprepare(adsp->xo);
+
+	return ret;
+}
+
+static void qcom_adsp_pil_handover(struct qcom_q6v5 *q6v5)
+{
+	struct qcom_adsp *adsp = container_of(q6v5, struct qcom_adsp, q6v5);
+
+	clk_disable_unprepare(adsp->xo);
+	dev_pm_genpd_set_performance_state(adsp->dev, 0);
+	pm_runtime_put(adsp->dev);
+}
+
+static int adsp_stop(struct rproc *rproc)
+{
+	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+	int handover;
+	int ret;
+
+	ret = qcom_q6v5_request_stop(&adsp->q6v5);
+	if (ret == -ETIMEDOUT)
+		dev_err(adsp->dev, "timed out on wait\n");
+
+	ret = qcom_adsp_shutdown(adsp);
+	if (ret)
+		dev_err(adsp->dev, "failed to shutdown: %d\n", ret);
+
+	handover = qcom_q6v5_unprepare(&adsp->q6v5);
+	if (handover)
+		qcom_adsp_pil_handover(&adsp->q6v5);
+
+	return ret;
+}
+
+static void *adsp_da_to_va(struct rproc *rproc, u64 da, int len)
+{
+	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+	int offset;
+
+	offset = da - adsp->mem_reloc;
+	if (offset < 0 || offset + len > adsp->mem_size)
+		return NULL;
+
+	return adsp->mem_region + offset;
+}
+
+static const struct rproc_ops adsp_ops = {
+	.start = adsp_start,
+	.stop = adsp_stop,
+	.da_to_va = adsp_da_to_va,
+	.parse_fw = qcom_register_dump_segments,
+	.load = adsp_load,
+};
+
+static int adsp_init_clock(struct qcom_adsp *adsp)
+{
+	int i, ret;
+
+	adsp->xo = devm_clk_get(adsp->dev, "xo");
+	if (IS_ERR(adsp->xo)) {
+		ret = PTR_ERR(adsp->xo);
+		if (ret != -EPROBE_DEFER)
+			dev_err(adsp->dev, "failed to get xo clock");
+		return ret;
+	}
+
+	adsp->num_clks = ARRAY_SIZE(adsp_clk_id);
+	adsp->clks = devm_kcalloc(adsp->dev, adsp->num_clks,
+				sizeof(*adsp->clks), GFP_KERNEL);
+	if (IS_ERR(adsp->clks)) {
+		ret = PTR_ERR(adsp->clks);
+		if (ret != -EPROBE_DEFER)
+			dev_err(adsp->dev, "failed to get adsp clock");
+		return ret;
+	}
+
+	for (i = 0; i < adsp->num_clks; i++)
+		adsp->clks[i].id = adsp_clk_id[i];
+
+	return devm_clk_bulk_get(adsp->dev, adsp->num_clks, adsp->clks);
+}
+
+static int adsp_init_reset(struct qcom_adsp *adsp)
+{
+	adsp->pdc_sync_reset = devm_reset_control_get_exclusive(adsp->dev,
+			"pdc_sync");
+	if (IS_ERR(adsp->pdc_sync_reset)) {
+		dev_err(adsp->dev, "failed to acquire pdc_sync reset\n");
+		return PTR_ERR(adsp->pdc_sync_reset);
+	}
+
+	adsp->cc_lpass_restart = devm_reset_control_get_exclusive(adsp->dev,
+			"cc_lpass");
+	if (IS_ERR(adsp->cc_lpass_restart)) {
+		dev_err(adsp->dev, "failed to acquire cc_lpass restart\n");
+		return PTR_ERR(adsp->cc_lpass_restart);
+	}
+
+	return 0;
+}
+
+static int adsp_init_mmio(struct qcom_adsp *adsp,
+				struct platform_device *pdev)
+{
+	struct device_node *syscon;
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	adsp->qdsp6ss_base = devm_ioremap(&pdev->dev, res->start,
+			resource_size(res));
+	if (IS_ERR(adsp->qdsp6ss_base)) {
+		dev_err(adsp->dev, "failed to map QDSP6SS registers\n");
+		return PTR_ERR(adsp->qdsp6ss_base);
+	}
+
+	syscon = of_parse_phandle(pdev->dev.of_node, "qcom,halt-regs", 0);
+	if (!syscon) {
+		dev_err(&pdev->dev, "failed to parse qcom,halt-regs\n");
+		return -EINVAL;
+	}
+
+	adsp->halt_map = syscon_node_to_regmap(syscon);
+	of_node_put(syscon);
+	if (IS_ERR(adsp->halt_map))
+		return PTR_ERR(adsp->halt_map);
+
+	ret = of_property_read_u32_index(pdev->dev.of_node, "qcom,halt-regs",
+			1, &adsp->halt_lpass);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "no offset in syscon\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
+{
+	struct device_node *node;
+	struct resource r;
+	int ret;
+
+	node = of_parse_phandle(adsp->dev->of_node, "memory-region", 0);
+	if (!node) {
+		dev_err(adsp->dev, "no memory-region specified\n");
+		return -EINVAL;
+	}
+
+	ret = of_address_to_resource(node, 0, &r);
+	if (ret)
+		return ret;
+
+	adsp->mem_phys = adsp->mem_reloc = r.start;
+	adsp->mem_size = resource_size(&r);
+	adsp->mem_region = devm_ioremap_wc(adsp->dev,
+				adsp->mem_phys, adsp->mem_size);
+	if (!adsp->mem_region) {
+		dev_err(adsp->dev, "unable to map memory region: %pa+%zx\n",
+			&r.start, adsp->mem_size);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int adsp_probe(struct platform_device *pdev)
+{
+	const struct adsp_pil_data *desc;
+	struct qcom_adsp *adsp;
+	struct rproc *rproc;
+	int ret;
+
+	desc = of_device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
+	rproc = rproc_alloc(&pdev->dev, pdev->name, &adsp_ops,
+			    desc->firmware_name, sizeof(*adsp));
+	if (!rproc) {
+		dev_err(&pdev->dev, "unable to allocate remoteproc\n");
+		return -ENOMEM;
+	}
+
+	adsp = (struct qcom_adsp *)rproc->priv;
+	adsp->dev = &pdev->dev;
+	adsp->rproc = rproc;
+	platform_set_drvdata(pdev, adsp);
+
+	ret = adsp_alloc_memory_region(adsp);
+	if (ret)
+		goto free_rproc;
+
+	ret = adsp_init_clock(adsp);
+	if (ret)
+		goto free_rproc;
+
+	pm_runtime_enable(adsp->dev);
+
+	ret = adsp_init_reset(adsp);
+	if (ret)
+		goto disable_pm;
+
+	ret = adsp_init_mmio(adsp, pdev);
+	if (ret)
+		goto disable_pm;
+
+	ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, desc->crash_reason_smem,
+			     qcom_adsp_pil_handover);
+	if (ret)
+		goto disable_pm;
+
+	qcom_add_glink_subdev(rproc, &adsp->glink_subdev);
+	qcom_add_ssr_subdev(rproc, &adsp->ssr_subdev, desc->ssr_name);
+	adsp->sysmon = qcom_add_sysmon_subdev(rproc,
+					      desc->sysmon_name,
+					      desc->ssctl_id);
+
+	ret = rproc_add(rproc);
+	if (ret)
+		goto disable_pm;
+
+	return 0;
+
+disable_pm:
+	pm_runtime_disable(adsp->dev);
+free_rproc:
+	rproc_free(rproc);
+
+	return ret;
+}
+
+static int adsp_remove(struct platform_device *pdev)
+{
+	struct qcom_adsp *adsp = platform_get_drvdata(pdev);
+
+	rproc_del(adsp->rproc);
+
+	qcom_remove_glink_subdev(adsp->rproc, &adsp->glink_subdev);
+	qcom_remove_sysmon_subdev(adsp->sysmon);
+	qcom_remove_ssr_subdev(adsp->rproc, &adsp->ssr_subdev);
+	rproc_free(adsp->rproc);
+	pm_runtime_disable(adsp->dev);
+
+	return 0;
+}
+
+static const struct adsp_pil_data adsp_resource_init = {
+	.crash_reason_smem = 423,
+	.firmware_name = "adsp.mdt",
+	.ssr_name = "lpass",
+	.sysmon_name = "adsp",
+	.ssctl_id = 0x14,
+};
+
+static const struct of_device_id adsp_of_match[] = {
+	{ .compatible = "qcom,sdm845-adsp-pil",
+	  .data = &adsp_resource_init},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adsp_of_match);
+
+static struct platform_driver adsp_pil_driver = {
+	.probe = adsp_probe,
+	.remove = adsp_remove,
+	.driver = {
+		.name = "qcom_adsp_pil",
+		.of_match_table = adsp_of_match,
+	},
+};
+
+module_platform_driver(adsp_pil_driver);
+MODULE_DESCRIPTION("QTi SDM845 ADSP Peripherial Image Loader");
+MODULE_LICENSE("GPL v2");
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

