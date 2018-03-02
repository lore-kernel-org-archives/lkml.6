Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425707AbeCBJZc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:25:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49718 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425671AbeCBJYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:24:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1EB06607EF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From: sibis <sibis@codeaurora.org>
To: bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, jassisinghbrar@gmail.com,
        p.zabel@pengutronix.de, ohad@wizery.com, mark.rutland@arm.com,
        robh+dt@kernel.org, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 6/6] remoteproc: qcom: Reorder active clks enable and reset
Date: Fri,  2 Mar 2018 14:53:39 +0530
Message-Id: <1519982619-28336-7-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519982619-28336-1-git-send-email-sibis@codeaurora.org>
References: <1519982619-28336-1-git-send-email-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Active clks need to be enabled before Asserting/Deasserting
the reset lines in SDM845

Signed-off-by: sibis <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index f4997e0..cf45fe6 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -841,17 +841,18 @@ static int q6v5_start(struct rproc *rproc)
 		dev_err(qproc->dev, "failed to enable supplies\n");
 		goto disable_proxy_clk;
 	}
-	ret = qproc->ops->reset_start(qproc);
-	if (ret) {
-		dev_err(qproc->dev, "failed to deassert mss restart\n");
-		goto disable_vdd;
-	}
 
 	ret = q6v5_clk_enable(qproc->dev, qproc->active_clks,
 			      qproc->active_clk_count);
 	if (ret) {
 		dev_err(qproc->dev, "failed to enable clocks\n");
-		goto assert_reset;
+		goto disable_vdd;
+	}
+
+	ret = qproc->ops->reset_start(qproc);
+	if (ret) {
+		dev_err(qproc->dev, "failed to deassert mss restart\n");
+		goto disable_active_clks;
 	}
 
 	/* Assign MBA image access in DDR to q6 */
@@ -862,7 +863,7 @@ static int q6v5_start(struct rproc *rproc)
 		dev_err(qproc->dev,
 			"assigning Q6 access to mba memory failed: %d\n",
 			xfermemop_ret);
-		goto disable_active_clks;
+		goto assert_reset;
 	}
 
 	writel(qproc->mba_phys, qproc->rmb_base + RMB_MBA_IMAGE_REG);
@@ -931,12 +932,12 @@ static int q6v5_start(struct rproc *rproc)
 			"Failed to reclaim mba buffer, system may become unstable\n");
 	}
 
+assert_reset:
+	qproc->ops->reset_stop(qproc);
 disable_active_clks:
 	q6v5_clk_disable(qproc->dev, qproc->active_clks,
 			 qproc->active_clk_count);
 
-assert_reset:
-	qproc->ops->reset_stop(qproc);
 disable_vdd:
 	q6v5_regulator_disable(qproc, qproc->active_regs,
 			       qproc->active_reg_count);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
