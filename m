Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10BFC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225D1208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NtvjaQ3F";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A3xx32ZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225D1208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388822AbeG0Qnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:43:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54190 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732148AbeG0Qns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:43:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0D8346085F; Fri, 27 Jul 2018 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532704885;
        bh=CNkLO5LsULva/c9lIxv79aEi8wqIM1+PcyJ/Jh6uW7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NtvjaQ3FrJ/RU+Ozi3mdAy5JALc5vf6CK3RNXr3yKfvTIkOuuOc5E0w71R3yxETW6
         YKHf+rDB15PMS3hJfPD2gdBAmDpBV0jill3nHwMS4+1hcMSRydPukuaGeCTAlKC5H4
         D8EuRC/Bkss08pUQoeQqZYwFdqHYw4scgyt0SmTg=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1EFBB60B7B;
        Fri, 27 Jul 2018 15:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532704883;
        bh=CNkLO5LsULva/c9lIxv79aEi8wqIM1+PcyJ/Jh6uW7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3xx32ZY8AEP7mPRO8LDraZcXSGNf4Umkg/DDrdGSLauxcKJLrGZT0WocboUCAWyt
         4lkWJn0KYVXkOXQNgRNH6p/NU/NGg7Kk0hRnoTAyaDb11u3cBVaNssW8xgFdGtr1xL
         YHdtPsbU0HfEt+yU2HHJ9Xb/PbSrbNcu/s7bWjA8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1EFBB60B7B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 3/6] remoteproc: qcom: q6v5-pil: Refactor mba load/unload sequence
Date:   Fri, 27 Jul 2018 20:50:00 +0530
Message-Id: <20180727152003.11663-4-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180727152003.11663-1-sibis@codeaurora.org>
References: <20180727152003.11663-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor re-useable parts of mba load/unload sequence into mba_load and
mba_reclaim respectively and introduce mba_load flag. This is done in
order to prevent code duplication for modem coredump which requires the
mba to be loaded.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 243 +++++++++++++++++------------
 1 file changed, 144 insertions(+), 99 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index d7a4b9eca5d2..eacf9f0bf49e 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -165,6 +165,7 @@ struct q6v5 {
 	int proxy_reg_count;
 
 	bool running;
+	bool mba_loaded;
 
 	phys_addr_t mba_phys;
 	void *mba_region;
@@ -669,6 +670,145 @@ static bool q6v5_phdr_valid(const struct elf32_phdr *phdr)
 	return true;
 }
 
+static int q6v5_mba_load(struct q6v5 *qproc)
+{
+	int ret;
+	int xfermemop_ret;
+
+	ret = q6v5_regulator_enable(qproc, qproc->proxy_regs,
+				    qproc->proxy_reg_count);
+	if (ret) {
+		dev_err(qproc->dev, "failed to enable proxy supplies\n");
+		return ret;
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
+	qproc->mba_loaded = true;
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
+
+	return ret;
+}
+
+static void q6v5_mba_reclaim(struct q6v5 *qproc)
+{
+	int xfermemop_ret;
+
+	qproc->mba_loaded = false;
+	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_q6);
+	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_modem);
+	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_nc);
+	xfermemop_ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, false,
+						qproc->mba_phys,
+						qproc->mba_size);
+	if (xfermemop_ret) {
+		dev_err(qproc->dev,
+			"Failed to reclaim mba buffer, system may become unstable\n");
+	}
+
+	q6v5_clk_disable(qproc->dev, qproc->active_clks,
+			 qproc->active_clk_count);
+	q6v5_reset_assert(qproc);
+	q6v5_clk_disable(qproc->dev, qproc->reset_clks,
+			 qproc->reset_clk_count);
+	q6v5_regulator_disable(qproc, qproc->active_regs,
+			       qproc->active_reg_count);
+	q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
+			 qproc->proxy_clk_count);
+	q6v5_regulator_disable(qproc, qproc->proxy_regs,
+			       qproc->proxy_reg_count);
+}
+
 static int q6v5_mpss_load(struct q6v5 *qproc)
 {
 	const struct elf32_phdr *phdrs;
@@ -792,72 +932,9 @@ static int q6v5_start(struct rproc *rproc)
 
 	qcom_q6v5_prepare(&qproc->q6v5);
 
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
+		goto disable_irqs;
 
 	dev_info(qproc->dev, "MBA booted, loading mpss\n");
 
@@ -886,40 +963,7 @@ static int q6v5_start(struct rproc *rproc)
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
+	q6v5_mba_reclaim(qproc);
 disable_irqs:
 	qcom_q6v5_unprepare(&qproc->q6v5);
 
@@ -933,6 +977,7 @@ static int q6v5_stop(struct rproc *rproc)
 	u32 val;
 
 	qproc->running = false;
+	qproc->mba_loaded = false;
 
 	ret = qcom_q6v5_request_stop(&qproc->q6v5);
 	if (ret == -ETIMEDOUT)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

