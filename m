Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED738ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3BB21527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cOt7xNhz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BEvSvPVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3BB21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeJQVvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:51:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44306 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQVvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:51:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C65D761314; Wed, 17 Oct 2018 13:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539784564;
        bh=LL7T7jSHsuDu8KIlw8/Wcco5BmJa0AGETQjeTJIOPPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cOt7xNhztcEHW3vzcXuBsEGs2JJLZ6ue+ul0LXCOtYg3IAuv8JQRYEkc8Am8k1F47
         /kCSX3YDduDOPbf0mKNRi6/2jVNIhmD57dNsDkp9POWYLThqjL9GPm+TO73v3Jusem
         Cas/iiNZryztYk9rC+2g7piGiYEAkVhvkEzI4/ec=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15C7D60F39;
        Wed, 17 Oct 2018 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539784560;
        bh=LL7T7jSHsuDu8KIlw8/Wcco5BmJa0AGETQjeTJIOPPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BEvSvPVcYBaKaHPgzzUw2jKPa/2Aw8Aee4+x77GRbDUrCG258jGKeAdVr/4sf40Dv
         0VIfqXTAq3wp9PjrSSmC22BOCTu+maxdpmPb2Fy6QvbaPRTiuSDVAqLZlVGqoGeyPc
         xa5uofwk5uL4TFDBKPyjIFAgdnedQP5UyTX4WKhs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15C7D60F39
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        kyan@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v5 3/5] remoteproc: qcom: q6v5-mss: Refactor mba load/unload sequence
Date:   Wed, 17 Oct 2018 19:25:25 +0530
Message-Id: <20181017135527.30592-4-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181017135527.30592-1-sibis@codeaurora.org>
References: <20181017135527.30592-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor re-useable parts of mba load/unload sequence into mba_load and
mba_reclaim respectively. This is done in order to prevent code duplication
for modem coredump, which requires the mba to be loaded before dumping
the segments. The following changes in functionality are intended:

* Add software bypass to avoid high MX current in mpss error path.
* Remove the proxy votes of clk/regs only after the active/reset clks/regs.
* Reclaim MBA memory after mpss_load failure in mba_reclaim func.
* Set/Unset the dump_mba_loaded flag on mba_load/mba_reclaim respectively.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 308 ++++++++++++++++-------------
 1 file changed, 170 insertions(+), 138 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index f52b64120877..87d7f4d0c176 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -167,6 +167,7 @@ struct q6v5 {
 
 	bool running;
 
+	bool dump_mba_loaded;
 	phys_addr_t mba_phys;
 	void *mba_region;
 	size_t mba_size;
@@ -679,6 +680,171 @@ static bool q6v5_phdr_valid(const struct elf32_phdr *phdr)
 	return true;
 }
 
+static int q6v5_mba_load(struct q6v5 *qproc)
+{
+	int ret;
+	int xfermemop_ret;
+
+	qcom_q6v5_prepare(&qproc->q6v5);
+
+	ret = q6v5_regulator_enable(qproc, qproc->proxy_regs,
+				    qproc->proxy_reg_count);
+	if (ret) {
+		dev_err(qproc->dev, "failed to enable proxy supplies\n");
+		goto disable_irqs;
+	}
+
+	ret = q6v5_clk_enable(qproc->dev, qproc->proxy_clks,
+			      qproc->proxy_clk_count);
+	if (ret) {
+		dev_err(qproc->dev, "failed to enable proxy clocks\n");
+		goto disable_proxy_reg;
+	}
+
+	ret = q6v5_regulator_enable(qproc, qproc->active_regs,
+				    qproc->active_reg_count);
+	if (ret) {
+		dev_err(qproc->dev, "failed to enable supplies\n");
+		goto disable_proxy_clk;
+	}
+
+	ret = q6v5_clk_enable(qproc->dev, qproc->reset_clks,
+			      qproc->reset_clk_count);
+	if (ret) {
+		dev_err(qproc->dev, "failed to enable reset clocks\n");
+		goto disable_vdd;
+	}
+
+	ret = q6v5_reset_deassert(qproc);
+	if (ret) {
+		dev_err(qproc->dev, "failed to deassert mss restart\n");
+		goto disable_reset_clks;
+	}
+
+	ret = q6v5_clk_enable(qproc->dev, qproc->active_clks,
+			      qproc->active_clk_count);
+	if (ret) {
+		dev_err(qproc->dev, "failed to enable clocks\n");
+		goto assert_reset;
+	}
+
+	/* Assign MBA image access in DDR to q6 */
+	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, true,
+				      qproc->mba_phys, qproc->mba_size);
+	if (ret) {
+		dev_err(qproc->dev,
+			"assigning Q6 access to mba memory failed: %d\n", ret);
+		goto disable_active_clks;
+	}
+
+	writel(qproc->mba_phys, qproc->rmb_base + RMB_MBA_IMAGE_REG);
+
+	ret = q6v5proc_reset(qproc);
+	if (ret)
+		goto reclaim_mba;
+
+	ret = q6v5_rmb_mba_wait(qproc, 0, 5000);
+	if (ret == -ETIMEDOUT) {
+		dev_err(qproc->dev, "MBA boot timed out\n");
+		goto halt_axi_ports;
+	} else if (ret != RMB_MBA_XPU_UNLOCKED &&
+		   ret != RMB_MBA_XPU_UNLOCKED_SCRIBBLED) {
+		dev_err(qproc->dev, "MBA returned unexpected status %d\n", ret);
+		ret = -EINVAL;
+		goto halt_axi_ports;
+	}
+
+	qproc->dump_mba_loaded = true;
+	return 0;
+
+halt_axi_ports:
+	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_q6);
+	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_modem);
+	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_nc);
+
+reclaim_mba:
+	xfermemop_ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, false,
+						qproc->mba_phys,
+						qproc->mba_size);
+	if (xfermemop_ret) {
+		dev_err(qproc->dev,
+			"Failed to reclaim mba buffer, system may become unstable\n");
+	}
+
+disable_active_clks:
+	q6v5_clk_disable(qproc->dev, qproc->active_clks,
+			 qproc->active_clk_count);
+assert_reset:
+	q6v5_reset_assert(qproc);
+disable_reset_clks:
+	q6v5_clk_disable(qproc->dev, qproc->reset_clks,
+			 qproc->reset_clk_count);
+disable_vdd:
+	q6v5_regulator_disable(qproc, qproc->active_regs,
+			       qproc->active_reg_count);
+disable_proxy_clk:
+	q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
+			 qproc->proxy_clk_count);
+disable_proxy_reg:
+	q6v5_regulator_disable(qproc, qproc->proxy_regs,
+			       qproc->proxy_reg_count);
+disable_irqs:
+	qcom_q6v5_unprepare(&qproc->q6v5);
+
+	return ret;
+}
+
+static void q6v5_mba_reclaim(struct q6v5 *qproc)
+{
+	int ret;
+	u32 val;
+
+	qproc->dump_mba_loaded = false;
+
+	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_q6);
+	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_modem);
+	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_nc);
+	if (qproc->version == MSS_MSM8996) {
+		/*
+		 * To avoid high MX current during LPASS/MSS restart.
+		 */
+		val = readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+		val |= Q6SS_CLAMP_IO | QDSP6v56_CLAMP_WL |
+			QDSP6v56_CLAMP_QMC_MEM;
+		writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
+	}
+
+	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm,
+						false, qproc->mpss_phys,
+						qproc->mpss_size);
+	WARN_ON(ret);
+
+	q6v5_reset_assert(qproc);
+
+	q6v5_clk_disable(qproc->dev, qproc->reset_clks,
+			 qproc->reset_clk_count);
+	q6v5_clk_disable(qproc->dev, qproc->active_clks,
+			 qproc->active_clk_count);
+	q6v5_regulator_disable(qproc, qproc->active_regs,
+			       qproc->active_reg_count);
+
+	/* In case of failure or coredump scenario where reclaiming MBA memory
+	 * could not happen reclaim it here.
+	 */
+	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, false,
+						qproc->mba_phys,
+						qproc->mba_size);
+	WARN_ON(ret);
+
+	ret = qcom_q6v5_unprepare(&qproc->q6v5);
+	if (ret) {
+		q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
+				 qproc->proxy_clk_count);
+		q6v5_regulator_disable(qproc, qproc->proxy_regs,
+				       qproc->proxy_reg_count);
+	}
+}
+
 static int q6v5_mpss_load(struct q6v5 *qproc)
 {
 	const struct elf32_phdr *phdrs;
@@ -801,74 +967,9 @@ static int q6v5_start(struct rproc *rproc)
 	int xfermemop_ret;
 	int ret;
 
-	qcom_q6v5_prepare(&qproc->q6v5);
-
-	ret = q6v5_regulator_enable(qproc, qproc->proxy_regs,
-				    qproc->proxy_reg_count);
-	if (ret) {
-		dev_err(qproc->dev, "failed to enable proxy supplies\n");
-		goto disable_irqs;
-	}
-
-	ret = q6v5_clk_enable(qproc->dev, qproc->proxy_clks,
-			      qproc->proxy_clk_count);
-	if (ret) {
-		dev_err(qproc->dev, "failed to enable proxy clocks\n");
-		goto disable_proxy_reg;
-	}
-
-	ret = q6v5_regulator_enable(qproc, qproc->active_regs,
-				    qproc->active_reg_count);
-	if (ret) {
-		dev_err(qproc->dev, "failed to enable supplies\n");
-		goto disable_proxy_clk;
-	}
-
-	ret = q6v5_clk_enable(qproc->dev, qproc->reset_clks,
-			      qproc->reset_clk_count);
-	if (ret) {
-		dev_err(qproc->dev, "failed to enable reset clocks\n");
-		goto disable_vdd;
-	}
-
-	ret = q6v5_reset_deassert(qproc);
-	if (ret) {
-		dev_err(qproc->dev, "failed to deassert mss restart\n");
-		goto disable_reset_clks;
-	}
-
-	ret = q6v5_clk_enable(qproc->dev, qproc->active_clks,
-			      qproc->active_clk_count);
-	if (ret) {
-		dev_err(qproc->dev, "failed to enable clocks\n");
-		goto assert_reset;
-	}
-
-	/* Assign MBA image access in DDR to q6 */
-	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, true,
-				      qproc->mba_phys, qproc->mba_size);
-	if (ret) {
-		dev_err(qproc->dev,
-			"assigning Q6 access to mba memory failed: %d\n", ret);
-		goto disable_active_clks;
-	}
-
-	writel(qproc->mba_phys, qproc->rmb_base + RMB_MBA_IMAGE_REG);
-
-	ret = q6v5proc_reset(qproc);
+	ret = q6v5_mba_load(qproc);
 	if (ret)
-		goto reclaim_mba;
-
-	ret = q6v5_rmb_mba_wait(qproc, 0, 5000);
-	if (ret == -ETIMEDOUT) {
-		dev_err(qproc->dev, "MBA boot timed out\n");
-		goto halt_axi_ports;
-	} else if (ret != RMB_MBA_XPU_UNLOCKED &&
-		   ret != RMB_MBA_XPU_UNLOCKED_SCRIBBLED) {
-		dev_err(qproc->dev, "MBA returned unexpected status %d\n", ret);
-		ret = -EINVAL;
-		goto halt_axi_ports;
-	}
+		return ret;
 
 	dev_info(qproc->dev, "MBA booted, loading mpss\n");
 
@@ -897,42 +998,7 @@ static int q6v5_start(struct rproc *rproc)
 						false, qproc->mpss_phys,
 						qproc->mpss_size);
 	WARN_ON(xfermemop_ret);
-
-halt_axi_ports:
-	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_q6);
-	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_modem);
-	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_nc);
-
-reclaim_mba:
-	xfermemop_ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, false,
-						qproc->mba_phys,
-						qproc->mba_size);
-	if (xfermemop_ret) {
-		dev_err(qproc->dev,
-			"Failed to reclaim mba buffer, system may become unstable\n");
-	}
-
-disable_active_clks:
-	q6v5_clk_disable(qproc->dev, qproc->active_clks,
-			 qproc->active_clk_count);
-
-assert_reset:
-	q6v5_reset_assert(qproc);
-disable_reset_clks:
-	q6v5_clk_disable(qproc->dev, qproc->reset_clks,
-			 qproc->reset_clk_count);
-disable_vdd:
-	q6v5_regulator_disable(qproc, qproc->active_regs,
-			       qproc->active_reg_count);
-disable_proxy_clk:
-	q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
-			 qproc->proxy_clk_count);
-disable_proxy_reg:
-	q6v5_regulator_disable(qproc, qproc->proxy_regs,
-			       qproc->proxy_reg_count);
-
-disable_irqs:
-	qcom_q6v5_unprepare(&qproc->q6v5);
+	q6v5_mba_reclaim(qproc);
 
 	return ret;
 }
@@ -941,7 +1007,6 @@ static int q6v5_stop(struct rproc *rproc)
 {
 	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
 	int ret;
-	u32 val;
 
 	qproc->running = false;
 
@@ -949,40 +1014,7 @@ static int q6v5_stop(struct rproc *rproc)
 	if (ret == -ETIMEDOUT)
 		dev_err(qproc->dev, "timed out on wait\n");
 
-	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_q6);
-	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_modem);
-	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_nc);
-	if (qproc->version == MSS_MSM8996) {
-		/*
-		 * To avoid high MX current during LPASS/MSS restart.
-		 */
-		val = readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
-		val |= Q6SS_CLAMP_IO | QDSP6v56_CLAMP_WL |
-			QDSP6v56_CLAMP_QMC_MEM;
-		writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
-	}
-
-
-	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, false,
-				      qproc->mpss_phys, qproc->mpss_size);
-	WARN_ON(ret);
-
-	q6v5_reset_assert(qproc);
-
-	ret = qcom_q6v5_unprepare(&qproc->q6v5);
-	if (ret) {
-		q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
-				 qproc->proxy_clk_count);
-		q6v5_regulator_disable(qproc, qproc->proxy_regs,
-				       qproc->proxy_reg_count);
-	}
-
-	q6v5_clk_disable(qproc->dev, qproc->reset_clks,
-			 qproc->reset_clk_count);
-	q6v5_clk_disable(qproc->dev, qproc->active_clks,
-			 qproc->active_clk_count);
-	q6v5_regulator_disable(qproc, qproc->active_regs,
-			       qproc->active_reg_count);
+	q6v5_mba_reclaim(qproc);
 
 	return 0;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

