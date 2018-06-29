Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE62C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE7927B25
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TIirBX4R";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XYjYb2PA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE7927B25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966443AbeF2JVS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:21:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40958 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932880AbeF2JVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:21:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9C23860452; Fri, 29 Jun 2018 09:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530264071;
        bh=llOZR4knNKpNAJBT3KBqUdSAX50spbQLdQGHAX5hTNA=;
        h=From:To:Cc:Subject:Date:From;
        b=TIirBX4R+SinNiIE3+AKzE7x03MYJfWXvc32gYoD5FfFuGbwBi9I5T5sY71MPf+fX
         8qWVoDTTYFYHOhXFeuhoN0/IpDX6D4ahugO8wYdbwWHRYmcVwOgmX7zhckM9AnS52d
         OWDnO2b6gsX7ePRRncIb24241UKXVCcIwHrhgnBA=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC8D16037C;
        Fri, 29 Jun 2018 09:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530264069;
        bh=llOZR4knNKpNAJBT3KBqUdSAX50spbQLdQGHAX5hTNA=;
        h=From:To:Cc:Subject:Date:From;
        b=XYjYb2PAg+qqKvyjP3Is5dKNOWcskxY/aywKV16zy3QqmEhdcBnIf+tuvF7I67qS+
         fRw9c+brpzINKqDGYnXb0iJlDdanw0W8H4N8emsIOQsTvq3Nty4V38VAT1hnX9SLN4
         AL8fyvlW/e85J2JRvHu1ITCEs6Cu3MJ5AJkng23A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC8D16037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bgoswami@codeaurora.org, sbpata@codeaurora.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v2] remoteproc: qcom: Introduce Non-PAS ADSP PIL driver
Date:   Fri, 29 Jun 2018 14:50:53 +0530
Message-Id: <1530264053-8394-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds APSS based ADSP PIL driver for QCOM SoCs.
Added initial support for SDM845 with ADSP bootup and
shutdown operation handled from Application Processor
SubSystem(APSS).

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
Changes since v1:
- Used APIs from qcom_q6v5.c
- Use clock, reset and regmap driver APIs instead of 
  directly writing into the LPASS registers.
- Created new file for non PAS ADSP PIL instead of extending
  existing ADSP PIL driver.
- cleanups as suggested by Bjorn and Rob.

 .../bindings/remoteproc/qcom,non-pas-adsp.txt      | 138 +++++
 drivers/remoteproc/Kconfig                         |  18 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/qcom_nonpas_adsp_pil.c          | 667 +++++++++++++++++++++
 4 files changed, 824 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt
 create mode 100644 drivers/remoteproc/qcom_nonpas_adsp_pil.c

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt
new file mode 100644
index 0000000..0581aaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt
@@ -0,0 +1,138 @@
+Qualcomm Technology Inc. Non PAS ADSP Peripheral Image Loader
+
+This document defines the binding for a component that loads and boots firmware
+on the Qualcomm Technology Inc. ADSP Hexagon core.
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be one of:
+		    "qcom,sdm845-apss-adsp-pil"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: must specify the base address and size of the qdsp6ss
+
+- reg-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qdsp6ss"
+
+- interrupts-extended:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: must list the watchdog, fatal IRQs ready, handover and
+		    stop-ack IRQs
+
+- interrupt-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "wdog", "fatal", "ready", "handover", "stop-ack"
+
+- clocks:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition:  List of phandle and clock specifier pairs
+
+- clock-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: List of clock input name strings sorted in the same
+				order as the clocks property.
+
+- resets:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to the reset-controller for the lpass
+
+- reset-names:
+        Usage: required
+        Value type: <stringlist>
+        Definition: must be "pdc_sync" and "cc_lpass"
+
+- qcom,halt-regs:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: a phandle reference to a syscon representing TCSR followed
+			by the offset within syscon for lpass halt register.
+
+- cx-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to the regulator to be held on behalf of the
+		    booting Hexagon core
+
+- px-supply:
+	Usage: optional
+	Value type: <phandle>
+	Definition: reference to the px regulator to be held on behalf of the
+		    booting Hexagon core
+
+- memory-region:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to the reserved-memory for the ADSP
+
+- qcom,smem-states:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to the smem state for requesting the ADSP to
+		    shut down
+
+- qcom,smem-state-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "stop"
+
+
+= SUBNODES
+The adsp node may have an subnode named either "smd-edge" or "glink-edge" that
+describes the communication edge, channels and devices related to the ADSP.
+See ../soc/qcom/qcom,smd.txt and ../soc/qcom/qcom,glink.txt for details on how
+to describe these.
+
+
+= EXAMPLE
+The following example describes the resources needed to boot control the
+ADSP, as it is found on SDM845 boards.
+	adsp-pil {
+		compatible = "qcom,sdm845-apss-adsp-pil";
+
+		reg = <0x17300000 0x40c>;
+		reg-names = "qdsp6ss";
+
+		interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
+			<&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+			<&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+			<&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+			<&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "wdog", "fatal", "ready",
+			"handover", "stop-ack";
+
+		clocks = <&clock_rpmh RPMH_CXO_CLK>,
+			<&lpasscc GCC_LPASS_SWAY_CLK>,
+			<&lpasscc LPASS_AUDIO_WRAPPER_AON_CLK>,
+			<&lpasscc LPASS_Q6SS_AHBS_AON_CLK>,
+			<&lpasscc LPASS_Q6SS_AHBM_AON_CLK>,
+			<&lpasscc LPASS_QDSP6SS_XO_CLK>,
+			<&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
+			<&lpasscc LPASS_QDSP6SS_CORE_CLK>;
+		clock-names = "xo", "sway_cbcr", "lpass_aon",
+			"lpass_ahbs_aon_cbcr",
+			"lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
+			"qdsp6ss_sleep", "qdsp6ss_core";
+
+		cx-supply = <&pm8998_s9_level>;
+
+		resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
+			 <&aoss_reset AOSS_CC_LPASS_RESTART>;
+		reset-names = "pdc_sync", "cc_lpass";
+
+		qcom,halt-regs = <&tcsr_mutex_regs 0x22000>;
+
+		memory-region = <&pil_adsp_mem>;
+
+		qcom,smem-states = <&adsp_smp2p_out 0>;
+		qcom,smem-state-names = "stop";
+	};
diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 0dde375..9de0a53 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -100,6 +100,24 @@ config QCOM_ADSP_PIL
 	  Say y here to support the TrustZone based Peripherial Image Loader
 	  for the Qualcomm ADSP remote processors.
 
+config QCOM_NON_PAS_ADSP_PIL
+	tristate "Qualcomm Technology Inc Non PAS ADSP Peripheral Image Loader"
+	depends on OF && ARCH_QCOM
+	depends on QCOM_SMEM
+	depends on RPMSG_QCOM_SMD || RPMSG_QCOM_SMD=n
+	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
+	depends on QCOM_SYSMON || QCOM_SYSMON=n
+	select MFD_SYSCON
+	select QCOM_MDT_LOADER
+	select QCOM_Q6V5_COMMON
+	select QCOM_RPROC_COMMON
+	help
+	  Say y here to support the Non PAS Peripherial Image Loader
+	  for the Qualcomm Technology Inc. ADSP remote processors.
+
+	  It's safe to say N here if you're not interested in Non-PAS
+	  ADSP PIL.
+
 config QCOM_RPROC_COMMON
 	tristate
 
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 03332fa..cbf168e 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
 obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
 obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
 obj-$(CONFIG_QCOM_ADSP_PIL)		+= qcom_adsp_pil.o
+obj-$(CONFIG_QCOM_NON_PAS_ADSP_PIL)	+= qcom_nonpas_adsp_pil.o
 obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
 obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
 obj-$(CONFIG_QCOM_Q6V5_PIL)		+= qcom_q6v5_pil.o
diff --git a/drivers/remoteproc/qcom_nonpas_adsp_pil.c b/drivers/remoteproc/qcom_nonpas_adsp_pil.c
new file mode 100644
index 0000000..826d3d4
--- /dev/null
+++ b/drivers/remoteproc/qcom_nonpas_adsp_pil.c
@@ -0,0 +1,667 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Qualcomm Technology Inc. Non PAS ADSP Peripheral Image Loader for SDM845.
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
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
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
+struct non_pas_adsp_data {
+	int crash_reason_smem;
+	const char *firmware_name;
+	bool has_aggre2_clk;
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
+	struct clk *aggre2_clk;
+	struct clk *gcc_sway_cbcr;
+	struct clk *lpass_audio_aon_clk;
+	struct clk *lpass_ahbs_aon_cbcr;
+	struct clk *lpass_ahbm_aon_cbcr;
+	struct clk *qdsp6ss_xo_cbcr;
+	struct clk *qdsp6ss_sleep_cbcr;
+	struct clk *qdsp6ss_core_cbcr;
+
+	struct regulator *cx_supply;
+	struct regulator *px_supply;
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
+	bool has_aggre2_clk;
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
+	struct qcom_rproc_subdev smd_subdev;
+	struct qcom_rproc_ssr ssr_subdev;
+	struct qcom_sysmon *sysmon;
+};
+
+static int adsp_clk_enable(struct qcom_adsp *adsp)
+{
+	int ret;
+
+	/* Enable SWAY clock */
+	ret = clk_prepare_enable(adsp->gcc_sway_cbcr);
+	if (ret)
+		return ret;
+
+	/* Enable LPASS AHB AON Bus */
+	ret = clk_prepare_enable(adsp->lpass_audio_aon_clk);
+	if (ret)
+		return ret;
+
+	/* Enable the QDSP6SS AHBM and AHBS clocks */
+	ret = clk_prepare_enable(adsp->lpass_ahbs_aon_cbcr);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(adsp->lpass_ahbm_aon_cbcr);
+	if (ret)
+		return ret;
+
+	/* Turn on the XO clock, required to boot FSM */
+	ret = clk_prepare_enable(adsp->qdsp6ss_xo_cbcr);
+	if (ret)
+		return ret;
+
+	/* Enable the QDSP6SS sleep clock for the QDSP6 watchdog enablement */
+	ret = clk_prepare_enable(adsp->qdsp6ss_sleep_cbcr);
+	if (ret)
+		return ret;
+
+	/* Configure QDSP6 core CBC to enable clock */
+	ret = clk_prepare_enable(adsp->qdsp6ss_core_cbcr);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static int adsp_reset(struct qcom_adsp *adsp)
+{
+	unsigned int val;
+	int ret = 0;
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
+	if (ret)
+		dev_err(adsp->dev, "Boot FSM failed to complete.\n");
+
+	return ret;
+}
+
+static int qcom_adsp_start(struct qcom_adsp *adsp)
+{
+	int ret;
+
+	ret = adsp_clk_enable(adsp);
+	if (ret) {
+		dev_err(adsp->dev, "adsp clk_enable failed\n");
+		return ret;
+	}
+
+	/* Program boot address */
+	writel(adsp->mem_phys >> 4, adsp->qdsp6ss_base + RST_EVB_REG);
+
+	ret = adsp_reset(adsp);
+	if (ret)
+		dev_err(adsp->dev, "De-assert QDSP6 out of reset failed\n");
+
+	return ret;
+}
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
+	/* Disable QDSP6 core CBCR clock */
+	clk_disable_unprepare(adsp->qdsp6ss_core_cbcr);
+
+	/* Disable the QDSP6SS sleep clock */
+	clk_disable_unprepare(adsp->qdsp6ss_sleep_cbcr);
+
+	/* Turn off the XO clock */
+	clk_disable_unprepare(adsp->qdsp6ss_xo_cbcr);
+
+	/* Disable the QDSP6SS AHBM and AHBS clocks */
+	clk_disable_unprepare(adsp->lpass_ahbs_aon_cbcr);
+
+	clk_disable_unprepare(adsp->lpass_ahbm_aon_cbcr);
+
+	/* Disable LPASS AHB AON Bus */
+	clk_disable_unprepare(adsp->lpass_audio_aon_clk);
+
+	/* Disable the slave way clock to LPASS */
+	clk_disable_unprepare(adsp->gcc_sway_cbcr);
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
+
+	qcom_q6v5_prepare(&adsp->q6v5);
+
+	ret = clk_prepare_enable(adsp->xo);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(adsp->aggre2_clk);
+	if (ret)
+		goto disable_xo_clk;
+
+	ret = regulator_enable(adsp->cx_supply);
+	if (ret)
+		goto disable_aggre2_clk;
+
+	ret = regulator_enable(adsp->px_supply);
+	if (ret)
+		goto disable_cx_supply;
+
+	ret = qcom_adsp_start(adsp);
+	if (ret) {
+		dev_err(adsp->dev,
+			"failed to bootup adsp\n");
+		goto disable_px_supply;
+	}
+
+	ret = qcom_q6v5_wait_for_start(&adsp->q6v5, msecs_to_jiffies(5000));
+	if (ret == -ETIMEDOUT) {
+		dev_err(adsp->dev, "start timed out\n");
+		qcom_adsp_shutdown(adsp);
+		goto disable_px_supply;
+	}
+
+	return 0;
+
+disable_px_supply:
+	regulator_disable(adsp->px_supply);
+disable_cx_supply:
+	regulator_disable(adsp->cx_supply);
+disable_aggre2_clk:
+	clk_disable_unprepare(adsp->aggre2_clk);
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
+	regulator_disable(adsp->px_supply);
+	regulator_disable(adsp->cx_supply);
+	clk_disable_unprepare(adsp->aggre2_clk);
+	clk_disable_unprepare(adsp->xo);
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
+	int ret;
+
+	adsp->xo = devm_clk_get(adsp->dev, "xo");
+	if (IS_ERR(adsp->xo)) {
+		ret = PTR_ERR(adsp->xo);
+		if (ret != -EPROBE_DEFER)
+			dev_err(adsp->dev, "failed to get xo clock");
+		return ret;
+	}
+
+	if (adsp->has_aggre2_clk) {
+		adsp->aggre2_clk = devm_clk_get(adsp->dev, "aggre2");
+		if (IS_ERR(adsp->aggre2_clk)) {
+			ret = PTR_ERR(adsp->aggre2_clk);
+			if (ret != -EPROBE_DEFER)
+				dev_err(adsp->dev,
+						"failed to get aggre2 clock");
+			return ret;
+		}
+	}
+
+	adsp->gcc_sway_cbcr = devm_clk_get(adsp->dev, "sway_cbcr");
+	if (IS_ERR(adsp->gcc_sway_cbcr)) {
+		ret = PTR_ERR(adsp->xo);
+		if (ret != -EPROBE_DEFER)
+			dev_err(adsp->dev, "failed to get gcc_sway clock\n");
+		return PTR_ERR(adsp->gcc_sway_cbcr);
+	}
+
+	adsp->lpass_audio_aon_clk = devm_clk_get(adsp->dev, "lpass_aon");
+	if (IS_ERR(adsp->lpass_audio_aon_clk)) {
+		ret = PTR_ERR(adsp->xo);
+		if (ret != -EPROBE_DEFER)
+			dev_err(adsp->dev, "failed to get lpass aon clk\n");
+		return PTR_ERR(adsp->lpass_audio_aon_clk);
+	}
+
+	adsp->lpass_ahbs_aon_cbcr = devm_clk_get(adsp->dev,
+						 "lpass_ahbs_aon_cbcr");
+	if (IS_ERR(adsp->lpass_ahbs_aon_cbcr)) {
+		ret = PTR_ERR(adsp->xo);
+		if (ret != -EPROBE_DEFER)
+			dev_err(adsp->dev, "failed to get ahb_aon clk\n");
+		return PTR_ERR(adsp->lpass_ahbs_aon_cbcr);
+	}
+
+	adsp->lpass_ahbm_aon_cbcr = devm_clk_get(adsp->dev,
+						 "lpass_ahbm_aon_cbcr");
+	if (IS_ERR(adsp->lpass_ahbm_aon_cbcr)) {
+		ret = PTR_ERR(adsp->xo);
+		if (ret != -EPROBE_DEFER)
+			dev_err(adsp->dev, "failed to get ahbm_aon clk\n");
+		return PTR_ERR(adsp->lpass_ahbm_aon_cbcr);
+	}
+
+	adsp->qdsp6ss_xo_cbcr = devm_clk_get(adsp->dev, "qdsp6ss_xo");
+	if (IS_ERR(adsp->qdsp6ss_xo_cbcr)) {
+		ret = PTR_ERR(adsp->xo);
+		if (ret != -EPROBE_DEFER)
+			dev_err(adsp->dev, "failed to get qdsp6ss_xo clk\n");
+		return PTR_ERR(adsp->qdsp6ss_xo_cbcr);
+	}
+
+	adsp->qdsp6ss_sleep_cbcr = devm_clk_get(adsp->dev, "qdsp6ss_sleep");
+	if (IS_ERR(adsp->qdsp6ss_sleep_cbcr)) {
+		ret = PTR_ERR(adsp->xo);
+		if (ret != -EPROBE_DEFER)
+			dev_err(adsp->dev, "failed to get qdsp6ss_sleep clk\n");
+		return PTR_ERR(adsp->qdsp6ss_sleep_cbcr);
+	}
+
+	adsp->qdsp6ss_core_cbcr = devm_clk_get(adsp->dev, "qdsp6ss_core");
+	if (IS_ERR(adsp->qdsp6ss_core_cbcr)) {
+		ret = PTR_ERR(adsp->xo);
+		if (ret != -EPROBE_DEFER)
+			dev_err(adsp->dev, "failed to get qdsp6ss_core clk\n");
+		return PTR_ERR(adsp->qdsp6ss_core_cbcr);
+	}
+
+	return 0;
+}
+
+static int adsp_init_regulator(struct qcom_adsp *adsp)
+{
+	adsp->cx_supply = devm_regulator_get(adsp->dev, "cx");
+	if (IS_ERR(adsp->cx_supply))
+		return PTR_ERR(adsp->cx_supply);
+
+	regulator_set_load(adsp->cx_supply, 100000);
+
+	adsp->px_supply = devm_regulator_get(adsp->dev, "px");
+	return PTR_ERR_OR_ZERO(adsp->px_supply);
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
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qdsp6ss");
+	adsp->qdsp6ss_base = devm_ioremap(&pdev->dev, res->start,
+					  resource_size(res));
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
+					 1, &adsp->halt_lpass);
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
+	const struct non_pas_adsp_data *desc;
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
+	adsp->has_aggre2_clk = desc->has_aggre2_clk;
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
+	ret = adsp_init_regulator(adsp);
+	if (ret)
+		goto free_rproc;
+
+	ret = adsp_init_reset(adsp);
+	if (ret)
+		goto free_rproc;
+
+	ret = adsp_init_mmio(adsp, pdev);
+	if (ret)
+		goto free_rproc;
+
+	ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, desc->crash_reason_smem,
+			     qcom_adsp_pil_handover);
+	if (ret)
+		goto free_rproc;
+
+	qcom_add_glink_subdev(rproc, &adsp->glink_subdev);
+	qcom_add_smd_subdev(rproc, &adsp->smd_subdev);
+	qcom_add_ssr_subdev(rproc, &adsp->ssr_subdev, desc->ssr_name);
+	adsp->sysmon = qcom_add_sysmon_subdev(rproc,
+					      desc->sysmon_name,
+					      desc->ssctl_id);
+
+	ret = rproc_add(rproc);
+	if (ret)
+		goto free_rproc;
+
+	return 0;
+
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
+	qcom_remove_smd_subdev(adsp->rproc, &adsp->smd_subdev);
+	qcom_remove_ssr_subdev(adsp->rproc, &adsp->ssr_subdev);
+	rproc_free(adsp->rproc);
+
+	return 0;
+}
+
+static const struct non_pas_adsp_data adsp_resource_init = {
+		.crash_reason_smem = 423,
+		.firmware_name = "adsp.mdt",
+		.has_aggre2_clk = false,
+		.ssr_name = "lpass",
+		.sysmon_name = "adsp",
+		.ssctl_id = 0x14,
+};
+
+static const struct of_device_id adsp_of_match[] = {
+	{ .compatible = "qcom,sdm845-apss-adsp-pil",
+	  .data = &adsp_resource_init},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adsp_of_match);
+
+static struct platform_driver non_pas_adsp_driver = {
+	.probe = adsp_probe,
+	.remove = adsp_remove,
+	.driver = {
+		.name = "qcom_non_pas_adsp_pil",
+		.of_match_table = adsp_of_match,
+	},
+};
+
+module_platform_driver(non_pas_adsp_driver);
+MODULE_DESCRIPTION("QTi SDM845 NON-PAS ADSP Peripherial Image Loader");
+MODULE_LICENSE("GPL v2");
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

