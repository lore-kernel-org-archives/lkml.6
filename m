Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844C3ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0CB2075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eS8FQUUr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cTxECfkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0CB2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeJIXly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:41:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42396 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeJIXly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:41:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5F5D560BFE; Tue,  9 Oct 2018 16:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539102250;
        bh=PDNjNcPk/lqGgVa1QBxCbj32N5GeaAt9YKOJ+Ao23o8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eS8FQUUr6W+2hqVNFqUVwugr+WKONlC1hJs6cOkiM177iiyUva/e6o90UA7OZKENF
         Jt9/SWkco2dIEjV+L6pKzBXWPTKhHTKeY60BIt9pziYkueq8F2lY+YoOWuAi+uQbq7
         VLE7i/Tv1jbmV2/KxrKRInmBRgNQ6J0CABhYLTOw=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 679286083C;
        Tue,  9 Oct 2018 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539102249;
        bh=PDNjNcPk/lqGgVa1QBxCbj32N5GeaAt9YKOJ+Ao23o8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cTxECfkm1B8r8xv+H3PfsA7lZlPBbS4K5BN1b3tYVDmMJ+IP6Bi0oIM1KpDWVvdNV
         KlBX9fODKVjmZHm+5bJe0CzoxqcpcNKIk/NtuxwuwcUm+LWw6rQifGPOsiGDeCjKnK
         OKjlOAlDABZerc3PcjXdPqwiNJplKRlpadBKriww=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 679286083C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        kyan@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4 3/5] remoteproc: qcom: q6v5-mss: Refactor mba load/unload sequence
Date:   Tue,  9 Oct 2018 21:53:37 +0530
Message-Id: <20181009162339.30522-4-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181009162339.30522-1-sibis@codeaurora.org>
References: <20181009162339.30522-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor re-useable parts of mba load/unload sequence into mba_load and
mba_reclaim respectively. This is done in order to prevent code duplication
for modem coredump, which requires the mba to be loaded before dumping
the segments. No change in functionality is intended.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 239 +++++++++++++++++------------
 1 file changed, 140 insertions(+), 99 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index f52b64120877..c475af65ba1d 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -679,6 +679,143 @@ static bool q6v5_phdr_valid(const struct elf32_phdr *phdr)
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
@@ -803,72 +940,9 @@ static int q6v5_start(struct rproc *rproc)
 
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
 
@@ -897,40 +971,7 @@ static int q6v5_start(struct rproc *rproc)
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
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

