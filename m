Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbeENKrh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:47:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50788 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752339AbeENKrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:47:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 799BD60AF9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: bjorn.andersson@linaro.org, ohad@wizery.com, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, sibis@codeaurora.org
Cc: sricharan@codeaurora.org
Subject: [PATCH V6 3/5] remoteproc: qcom: Split the head and tail of the q5v5-pil rproc reset function
Date: Mon, 14 May 2018 16:16:50 +0530
Message-Id: <1526294812-23390-4-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526294812-23390-1-git-send-email-sricharan@codeaurora.org>
References: <1526294812-23390-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the q6v5-wcss reset function is same as MSM8996 reset sequence
that will be added later. So split and move out the common pieces
so that the same code can be reused.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 169 ++++++++++++++++++++-----------------
 1 file changed, 93 insertions(+), 76 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index cc26cab..2403bb2 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -430,11 +430,101 @@ static int q6v5_rmb_mba_wait(struct q6v5 *qproc, u32 status, int ms)
 	return val;
 }
 
+static int q6v5_reset(struct q6v5 *qproc)
+{
+	u32 ret;
+	int val, i;
+
+	/* Assert resets, stop core */
+	val = readl(qproc->reg_base + QDSP6SS_RESET_REG);
+	val |= Q6SS_CORE_ARES | Q6SS_BUS_ARES_ENABLE | Q6SS_STOP_CORE;
+	writel(val, qproc->reg_base + QDSP6SS_RESET_REG);
+
+	/* BHS require xo cbcr to be enabled */
+	val = readl(qproc->reg_base + QDSP6SS_XO_CBCR);
+	val |= 0x1;
+	writel(val, qproc->reg_base + QDSP6SS_XO_CBCR);
+
+	/* Read CLKOFF bit to go low indicating CLK is enabled */
+	ret = readl_poll_timeout(qproc->reg_base + QDSP6SS_XO_CBCR,
+				 val, !(val & BIT(31)), 1,
+				 HALT_CHECK_MAX_LOOPS);
+	if (ret) {
+		dev_err(qproc->dev,
+			"xo cbcr enabling timed out (rc:%d)\n", ret);
+		return ret;
+	}
+	/* Enable power block headswitch and wait for it to stabilize */
+	val = readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+	val |= QDSP6v56_BHS_ON;
+	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+	val |= readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+	udelay(1);
+
+	/* Put LDO in bypass mode */
+	val |= QDSP6v56_LDO_BYP;
+	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+
+	/* Deassert QDSP6 compiler memory clamp */
+	val = readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+	val &= ~QDSP6v56_CLAMP_QMC_MEM;
+	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+
+	/* Deassert memory peripheral sleep and L2 memory standby */
+	val |= Q6SS_L2DATA_STBY_N | Q6SS_SLP_RET_N;
+	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+
+	/* Turn on L1, L2, ETB and JU memories 1 at a time */
+	val = readl(qproc->reg_base + QDSP6SS_MEM_PWR_CTL);
+	for (i = 19; i >= 0; i--) {
+		val |= BIT(i);
+		writel(val, qproc->reg_base + QDSP6SS_MEM_PWR_CTL);
+		/*
+		 * Read back value to ensure the write is done then
+		 * wait for 1us for both memory peripheral and data
+		 * array to turn on.
+		 */
+		val |= readl(qproc->reg_base + QDSP6SS_MEM_PWR_CTL);
+		udelay(1);
+	}
+	/* Remove word line clamp */
+	val = readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+	val &= ~QDSP6v56_CLAMP_WL;
+	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+
+	return 0;
+}
+
+static void q6v5_reset_rest(struct q6v5 *qproc)
+{
+	u32 val;
+
+	val = readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+
+	/* Remove IO clamp */
+	val &= ~Q6SS_CLAMP_IO;
+	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+
+	/* Bring core out of reset */
+	val = readl(qproc->reg_base + QDSP6SS_RESET_REG);
+	val &= ~Q6SS_CORE_ARES;
+	writel(val, qproc->reg_base + QDSP6SS_RESET_REG);
+
+	/* Turn on core clock */
+	val = readl(qproc->reg_base + QDSP6SS_GFMUX_CTL_REG);
+	val |= Q6SS_CLK_ENABLE;
+	writel(val, qproc->reg_base + QDSP6SS_GFMUX_CTL_REG);
+
+	/* Start core execution */
+	val = readl(qproc->reg_base + QDSP6SS_RESET_REG);
+	val &= ~Q6SS_STOP_CORE;
+	writel(val, qproc->reg_base + QDSP6SS_RESET_REG);
+}
+
 static int q6v5proc_reset(struct q6v5 *qproc)
 {
 	u32 val;
 	int ret;
-	int i;
 
 	if (qproc->version == MSS_SDM845) {
 
@@ -470,64 +560,7 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 		/* Override the ACC value if required */
 		writel(QDSP6SS_ACC_OVERRIDE_VAL,
 		       qproc->reg_base + QDSP6SS_STRAP_ACC);
-
-		/* Assert resets, stop core */
-		val = readl(qproc->reg_base + QDSP6SS_RESET_REG);
-		val |= Q6SS_CORE_ARES | Q6SS_BUS_ARES_ENABLE | Q6SS_STOP_CORE;
-		writel(val, qproc->reg_base + QDSP6SS_RESET_REG);
-
-		/* BHS require xo cbcr to be enabled */
-		val = readl(qproc->reg_base + QDSP6SS_XO_CBCR);
-		val |= 0x1;
-		writel(val, qproc->reg_base + QDSP6SS_XO_CBCR);
-
-		/* Read CLKOFF bit to go low indicating CLK is enabled */
-		ret = readl_poll_timeout(qproc->reg_base + QDSP6SS_XO_CBCR,
-					 val, !(val & BIT(31)), 1,
-					 HALT_CHECK_MAX_LOOPS);
-		if (ret) {
-			dev_err(qproc->dev,
-				"xo cbcr enabling timed out (rc:%d)\n", ret);
-			return ret;
-		}
-		/* Enable power block headswitch and wait for it to stabilize */
-		val = readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
-		val |= QDSP6v56_BHS_ON;
-		writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
-		val |= readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
-		udelay(1);
-
-		/* Put LDO in bypass mode */
-		val |= QDSP6v56_LDO_BYP;
-		writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
-
-		/* Deassert QDSP6 compiler memory clamp */
-		val = readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
-		val &= ~QDSP6v56_CLAMP_QMC_MEM;
-		writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
-
-		/* Deassert memory peripheral sleep and L2 memory standby */
-		val |= Q6SS_L2DATA_STBY_N | Q6SS_SLP_RET_N;
-		writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
-
-		/* Turn on L1, L2, ETB and JU memories 1 at a time */
-		val = readl(qproc->reg_base + QDSP6SS_MEM_PWR_CTL);
-		for (i = 19; i >= 0; i--) {
-			val |= BIT(i);
-			writel(val, qproc->reg_base +
-						QDSP6SS_MEM_PWR_CTL);
-			/*
-			 * Read back value to ensure the write is done then
-			 * wait for 1us for both memory peripheral and data
-			 * array to turn on.
-			 */
-			val |= readl(qproc->reg_base + QDSP6SS_MEM_PWR_CTL);
-			udelay(1);
-		}
-		/* Remove word line clamp */
-		val = readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
-		val &= ~QDSP6v56_CLAMP_WL;
-		writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+		q6v5_reset(qproc);
 	} else {
 		/* Assert resets, stop core */
 		val = readl(qproc->reg_base + QDSP6SS_RESET_REG);
@@ -555,24 +588,8 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 		val |= Q6SS_L2DATA_SLP_NRET_N_0;
 		writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
 	}
-	/* Remove IO clamp */
-	val &= ~Q6SS_CLAMP_IO;
-	writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
-
-	/* Bring core out of reset */
-	val = readl(qproc->reg_base + QDSP6SS_RESET_REG);
-	val &= ~Q6SS_CORE_ARES;
-	writel(val, qproc->reg_base + QDSP6SS_RESET_REG);
-
-	/* Turn on core clock */
-	val = readl(qproc->reg_base + QDSP6SS_GFMUX_CTL_REG);
-	val |= Q6SS_CLK_ENABLE;
-	writel(val, qproc->reg_base + QDSP6SS_GFMUX_CTL_REG);
 
-	/* Start core execution */
-	val = readl(qproc->reg_base + QDSP6SS_RESET_REG);
-	val &= ~Q6SS_STOP_CORE;
-	writel(val, qproc->reg_base + QDSP6SS_RESET_REG);
+	q6v5_reset_rest(qproc);
 
 pbl_wait:
 	/* Wait for PBL status */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
