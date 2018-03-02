Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422895AbeCBQnv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:43:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41074 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967981AbeCBQni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:43:38 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A0ED60867
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 06/10] drivers: qcom: rpmh-rsc: allow invalidation of sleep/wake TCS
Date: Fri,  2 Mar 2018 09:43:13 -0700
Message-Id: <20180302164317.10554-7-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302164317.10554-1-ilina@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow sleep and wake commands to be cleared from the respective TCSes,
so that they can be re-populated.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/soc/qcom/rpmh-internal.h |  1 +
 drivers/soc/qcom/rpmh-rsc.c      | 46 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 65dfe1716265..d2f73788a24d 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -90,6 +90,7 @@ struct rsc_drv {
 
 int rpmh_rsc_send_data(struct rsc_drv *drv, struct tcs_request *msg);
 int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, struct tcs_request *msg);
+int rpmh_rsc_invalidate(struct rsc_drv *drv);
 
 void rpmh_tx_done(struct tcs_request *msg, int r);
 
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 34e780d9670f..e9f5a1f387fd 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -170,6 +170,52 @@ static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
 	return tcs;
 }
 
+/**
+ * rpmh_rsc_invalidate - Invalidate sleep and wake TCSes
+ *
+ * @drv: the mailbox controller
+ */
+int rpmh_rsc_invalidate(struct rsc_drv *drv)
+{
+	struct tcs_group *tcs;
+	int m, type, ret = 0;
+	int inv_types[] = { WAKE_TCS, SLEEP_TCS };
+	unsigned long drv_flags, flags;
+
+	/* Lock the DRV and clear sleep and wake TCSes */
+	spin_lock_irqsave(&drv->drv_lock, drv_flags);
+	for (type = 0; type < ARRAY_SIZE(inv_types); type++) {
+		tcs = get_tcs_of_type(drv, inv_types[type]);
+		if (IS_ERR(tcs))
+			continue;
+
+		spin_lock_irqsave(&tcs->tcs_lock, flags);
+		if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS)) {
+			spin_unlock_irqrestore(&tcs->tcs_lock, flags);
+			continue;
+		}
+
+		/* Clear the enable register for each TCS of the type */
+		for (m = tcs->tcs_offset;
+		    m < tcs->tcs_offset + tcs->num_tcs; m++) {
+			if (!tcs_is_free(drv, m)) {
+				spin_unlock_irqrestore(&tcs->tcs_lock, flags);
+				ret = -EAGAIN;
+				goto drv_unlock;
+			}
+			write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, m, 0, 0);
+			/* Mark the TCS slots as free */
+			bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
+		}
+		spin_unlock_irqrestore(&tcs->tcs_lock, flags);
+	}
+drv_unlock:
+	spin_unlock_irqrestore(&drv->drv_lock, drv_flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(rpmh_rsc_invalidate);
+
 static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 					struct tcs_request *msg)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
