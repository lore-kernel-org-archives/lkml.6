Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeDEQS6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:18:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41872 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbeDEQSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:18:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8908B6055B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v5 06/10] drivers: qcom: rpmh-rsc: allow invalidation of sleep/wake TCS
Date: Thu,  5 Apr 2018 10:18:30 -0600
Message-Id: <20180405161834.3850-7-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180405161834.3850-1-ilina@codeaurora.org>
References: <20180405161834.3850-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow sleep and wake commands to be cleared from the respective TCSes,
so that they can be re-populated.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---

Changes in v4:
	- refactored the rphm_rsc_invalidate()
---
 drivers/soc/qcom/rpmh-internal.h |  1 +
 drivers/soc/qcom/rpmh-rsc.c      | 48 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 638662721086..3fab86a01f14 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -92,6 +92,7 @@ struct rsc_drv {
 int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
 int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
 			     const struct tcs_request *msg);
+int rpmh_rsc_invalidate(struct rsc_drv *drv);
 
 void rpmh_tx_done(const struct tcs_request *msg, int r);
 
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 58fc7254b6f3..1dbccc4d0605 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -162,6 +162,54 @@ static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
 	return tcs;
 }
 
+static int __tcs_invalidate(struct rsc_drv *drv, int type)
+{
+	int m;
+	struct tcs_group *tcs;
+
+	tcs = get_tcs_of_type(drv, type);
+	if (IS_ERR(tcs))
+		return PTR_ERR(tcs);
+
+	spin_lock(&tcs->lock);
+	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS)) {
+		spin_unlock(&tcs->lock);
+		return 0;
+	}
+
+	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
+		if (!tcs_is_free(drv, m)) {
+			spin_unlock(&tcs->lock);
+			return -EAGAIN;
+		}
+		write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, m, 0, 0);
+		bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
+	}
+	spin_unlock(&tcs->lock);
+
+	return 0;
+}
+
+/**
+ * rpmh_rsc_invalidate - Invalidate sleep and wake TCSes
+ *
+ * @drv: the mailbox controller
+ */
+int rpmh_rsc_invalidate(struct rsc_drv *drv)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&drv->drv_lock, flags);
+	ret = __tcs_invalidate(drv, SLEEP_TCS);
+	if (!ret)
+		ret = __tcs_invalidate(drv, WAKE_TCS);
+	spin_unlock_irqrestore(&drv->drv_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(rpmh_rsc_invalidate);
+
 static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 					 const struct tcs_request *msg)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
