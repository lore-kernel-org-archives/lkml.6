Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752477AbeENKry (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:47:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51110 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752421AbeENKru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:47:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 858E660386
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: bjorn.andersson@linaro.org, ohad@wizery.com, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, sibis@codeaurora.org
Cc: sricharan@codeaurora.org
Subject: [PATCH V6 5/5] remoteproc: qcom: Add q6v5-wcss rproc ops
Date: Mon, 14 May 2018 16:16:52 +0530
Message-Id: <1526294812-23390-6-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526294812-23390-1-git-send-email-sricharan@codeaurora.org>
References: <1526294812-23390-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

q6v5-wcss core's start function is mostly common
with the q6v5 of msm8996. So reuse that and add
the stop function.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 227 +++++++++++++++++++++++++++++++++++++
 1 file changed, 227 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index fbe179d..979f6c9 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -113,6 +113,17 @@
 #define SLEEP_CHECK_MAX_LOOPS           200
 #define BOOT_FSM_TIMEOUT                10000
 
+/* QDSP6v5-WCSS config/status registers */
+#define TCSR_GLOBAL_CFG0	0x0
+#define TCSR_GLOBAL_CFG1	0x4
+#define SSCAON_CONFIG		0x8
+#define SSCAON_STATUS		0xc
+#define QDSP6SS_BHS_STATUS	0x78
+#define QDSP6SS_RST_EVB		0x10
+
+#define BHS_EN_REST_ACK		BIT(0)
+#define SSCAON_ENABLE		BIT(13)
+
 struct reg_info {
 	struct regulator *reg;
 	int uV;
@@ -823,6 +834,61 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 	return ret < 0 ? ret : 0;
 }
 
+static int q6v5_wcss_start(struct rproc *rproc)
+{
+	struct q6v5 *qproc = rproc->priv;
+	int ret = 0;
+
+	ret = q6v5_clk_enable(qproc->dev, qproc->active_clks,
+			      qproc->active_clk_count);
+	if (ret) {
+		dev_err(qproc->dev, "failed to enable clocks\n");
+		return ret;
+	}
+
+	/* Release Q6 and WCSS reset */
+	ret = reset_control_deassert(qproc->wcss_reset);
+	if (ret)
+		dev_err(qproc->dev, "wcss_reset failed\n");
+
+	ret = reset_control_deassert(qproc->wcss_q6_reset);
+	if (ret)
+		dev_err(qproc->dev, "wcss_q6_reset failed\n");
+
+	/* Lithium configuration - clock gating and bus arbitration */
+	ret = regmap_update_bits(qproc->halt_map,
+				 qproc->halt_nc + TCSR_GLOBAL_CFG0,
+				 0x1F, 0x14);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(qproc->halt_map,
+				 qproc->halt_nc + TCSR_GLOBAL_CFG1,
+				 1, 0);
+	if (ret)
+		return ret;
+
+	/* Write bootaddr to EVB so that Q6WCSS will jump there after reset */
+	writel(rproc->bootaddr >> 4, qproc->reg_base + QDSP6SS_RST_EVB);
+
+	ret = q6v5_reset(qproc);
+	if (ret)
+		return ret;
+
+	q6v5_reset_rest(qproc);
+
+	ret = wait_for_completion_timeout(&qproc->start_done,
+					  msecs_to_jiffies(5000));
+	if (ret == 0) {
+		dev_err(qproc->dev, "start timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	qproc->running = true;
+
+	return 0;
+}
+
 static int q6v5_start(struct rproc *rproc)
 {
 	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
@@ -972,6 +1038,149 @@ static int q6v5_start(struct rproc *rproc)
 	return ret;
 }
 
+static int q6v5_wcss_powerdown(struct q6v5 *qproc)
+{
+	unsigned int val = 0;
+	int ret;
+
+	/* 1 - Assert WCSS/Q6 HALTREQ */
+	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_modem);
+
+	/* 2 - Enable WCSSAON_CONFIG */
+	val = readl(qproc->rmb_base + SSCAON_CONFIG);
+	val |= SSCAON_ENABLE;
+	writel(val, qproc->rmb_base + SSCAON_CONFIG);
+
+	/* 3 - Set SSCAON_CONFIG */
+	val |= BIT(15);
+	val &= ~BIT(16);
+	val &= ~BIT(17);
+	val &= ~BIT(18);
+	writel(val, qproc->rmb_base + SSCAON_CONFIG);
+
+	/* 4 - SSCAON_CONFIG 1 */
+	val |= BIT(1);
+	writel(val, qproc->rmb_base + SSCAON_CONFIG);
+
+	/* 5 - wait for SSCAON_STATUS */
+	ret = readl_poll_timeout(qproc->rmb_base + SSCAON_STATUS,
+				 val, (val & 0xffff) == 0x400, 1000,
+				 HALT_CHECK_MAX_LOOPS);
+	if (ret) {
+		dev_err(qproc->dev,
+			"can't get SSCAON_STATUS rc:%d)\n", ret);
+	}
+
+	/* 6 - De-assert WCSS_AON reset */
+	reset_control_assert(qproc->wcss_aon_reset);
+
+	/* 7 - Disable WCSSAON_CONFIG 13 */
+	val = readl(qproc->rmb_base + SSCAON_CONFIG);
+	val &= ~SSCAON_ENABLE;
+	writel(val, qproc->rmb_base + SSCAON_CONFIG);
+
+	/* 8 - De-assert WCSS/Q6 HALTREQ */
+	reset_control_assert(qproc->wcss_reset);
+
+	return ret;
+}
+
+static int q6v5_q6_powerdown(struct q6v5 *qproc)
+{
+	int i = 0, ret;
+	unsigned int val = 0;
+
+	/* 1 - Halt Q6 bus interface */
+	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_q6);
+
+	/* 2 - Disable Q6 Core clock */
+	val = readl(qproc->reg_base + QDSP6SS_GFMUX_CTL_REG);
+	val &= ~Q6SS_CLK_ENABLE;
+	writel(val, qproc->reg_base + QDSP6SS_GFMUX_CTL_REG);
+
+	/* 3 - Clamp I/O */
+	val = readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+	val |= Q6SS_CLAMP_IO;
+	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+
+	/* 4 - Clamp WL */
+	val |= QDSS_BHS_ON;
+	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+
+	/* 5 - Clear Erase standby */
+	val &= ~Q6SS_L2DATA_STBY_N;
+	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+
+	/* 6 - Clear Sleep RTN */
+	val &= ~Q6SS_SLP_RET_N;
+	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+
+	/* 7 - turn off QDSP6 memory foot/head switch one bank at a time */
+	for (i = 0; i < 20; i++) {
+		val = readl(qproc->reg_base + QDSP6SS_MEM_PWR_CTL);
+		val &= ~BIT(i);
+		writel(val, qproc->reg_base + QDSP6SS_MEM_PWR_CTL);
+		mdelay(1);
+	}
+	/* 8 - Assert QMC memory RTN */
+	val = readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+	val |= QDSP6v56_CLAMP_QMC_MEM;
+	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+
+	/* 9 - Turn off BHS */
+	val &= ~QDSP6v56_BHS_ON;
+	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+	udelay(1);
+	/* 10 - Wait till BHS Reset is done */
+	ret = readl_poll_timeout(qproc->reg_base + QDSP6SS_BHS_STATUS,
+				 val, !(val & BHS_EN_REST_ACK), 1000,
+				 HALT_CHECK_MAX_LOOPS);
+	if (ret) {
+		dev_err(qproc->dev,
+			"BHS_STATUS not OFF (rc:%d)\n", ret);
+	}
+
+	/* 11 -  Assert WCSS reset */
+	reset_control_assert(qproc->wcss_reset);
+
+	/* 12 - Assert Q6 reset */
+	reset_control_assert(qproc->wcss_q6_reset);
+
+	return 0;
+}
+
+static int q6v5_wcss_stop(struct rproc *rproc)
+{
+	struct q6v5 *qproc = rproc->priv;
+	int ret = 0;
+
+	qproc->running = false;
+
+	/* WCSS powerdown */
+	qcom_smem_state_update_bits(qproc->state, BIT(qproc->stop_bit),
+				    BIT(qproc->stop_bit));
+
+	ret = wait_for_completion_timeout(&qproc->stop_done,
+					  msecs_to_jiffies(5000));
+	if (ret == 0) {
+		dev_err(qproc->dev, "timed out on wait\n");
+		return -ETIMEDOUT;
+	}
+
+	qcom_smem_state_update_bits(qproc->state, BIT(qproc->stop_bit), 0);
+
+	ret = q6v5_wcss_powerdown(qproc);
+	if (ret)
+		return ret;
+
+	/* Q6 Power down */
+	ret = q6v5_q6_powerdown(qproc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int q6v5_stop(struct rproc *rproc)
 {
 	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
@@ -1041,6 +1250,15 @@ static void *q6v5_da_to_va(struct rproc *rproc, u64 da, int len)
 	return qproc->mpss_region + offset;
 }
 
+static int q6v5_wcss_load(struct rproc *rproc, const struct firmware *fw)
+{
+	struct q6v5 *qproc = rproc->priv;
+
+	return qcom_mdt_load_no_init(qproc->dev, fw, rproc->firmware,
+				     0, qproc->mba_region, qproc->mba_phys,
+				     qproc->mba_size, &qproc->mpss_reloc);
+}
+
 static const struct rproc_ops q6v5_ops = {
 	.start = q6v5_start,
 	.stop = q6v5_stop,
@@ -1048,6 +1266,14 @@ static void *q6v5_da_to_va(struct rproc *rproc, u64 da, int len)
 	.load = q6v5_load,
 };
 
+static const struct rproc_ops q6v5_wcss_ops = {
+	.start = q6v5_wcss_start,
+	.stop = q6v5_wcss_stop,
+	.da_to_va = q6v5_da_to_va,
+	.load = q6v5_wcss_load,
+	.get_boot_addr = rproc_elf_get_boot_addr,
+};
+
 static irqreturn_t q6v5_wdog_interrupt(int irq, void *dev)
 {
 	struct q6v5 *qproc = dev;
@@ -1569,6 +1795,7 @@ static int q6v5_remove(struct platform_device *pdev)
 	.need_mem_protection = false,
 	.version = WCSS_IPQ8074,
 	.init_reset = q6v5_wcss_init_reset,
+	.ops = &q6v5_wcss_ops,
 };
 
 static const struct of_device_id q6v5_of_match[] = {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
