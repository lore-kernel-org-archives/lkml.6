Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753474AbeEUR2Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:28:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56880 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753341AbeEUR2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:28:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE70D6021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From: Sibi Sankar <sibis@codeaurora.org>
To: bjorn.andersson@linaro.org, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, jassisinghbrar@gmail.com, ohad@wizery.com,
        mark.rutland@arm.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: [PATCH v5 6/8] remoteproc: qcom: Introduce reset assert/deassert helper functions
Date: Mon, 21 May 2018 22:57:12 +0530
Message-Id: <20180521172714.8551-7-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521172714.8551-1-sibis@codeaurora.org>
References: <20180521172714.8551-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding reset assert/deassert helper functions to handle SoC
specific reset sequences. This wil be used by SDM845 to assert and
deassert ALT_RESET and MSS_RESET signals.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index a5fa6521bb83..552805bc07c1 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -352,6 +352,16 @@ static int q6v5_load(struct rproc *rproc, const struct firmware *fw)
 	return 0;
 }
 
+static int q6v5_reset_assert(struct q6v5 *qproc)
+{
+	return reset_control_assert(qproc->mss_restart);
+}
+
+static int q6v5_reset_deassert(struct q6v5 *qproc)
+{
+	return reset_control_deassert(qproc->mss_restart);
+}
+
 static int q6v5_rmb_pbl_wait(struct q6v5 *qproc, int ms)
 {
 	unsigned long timeout;
@@ -767,7 +777,7 @@ static int q6v5_start(struct rproc *rproc)
 		dev_err(qproc->dev, "failed to enable supplies\n");
 		goto disable_proxy_clk;
 	}
-	ret = reset_control_deassert(qproc->mss_restart);
+	ret = q6v5_reset_deassert(qproc);
 	if (ret) {
 		dev_err(qproc->dev, "failed to deassert mss restart\n");
 		goto disable_vdd;
@@ -859,7 +869,7 @@ static int q6v5_start(struct rproc *rproc)
 			 qproc->active_clk_count);
 
 assert_reset:
-	reset_control_assert(qproc->mss_restart);
+	q6v5_reset_assert(qproc);
 disable_vdd:
 	q6v5_regulator_disable(qproc, qproc->active_regs,
 			       qproc->active_reg_count);
@@ -909,7 +919,7 @@ static int q6v5_stop(struct rproc *rproc)
 				      qproc->mpss_phys, qproc->mpss_size);
 	WARN_ON(ret);
 
-	reset_control_assert(qproc->mss_restart);
+	q6v5_reset_assert(qproc);
 	q6v5_disable_irqs(qproc);
 
 	if (!qproc->unvoted_flag) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
