Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032510AbeEXKr3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 06:47:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41894 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032484AbeEXKrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 06:47:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8C2F60C55
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From: Raju P L S S S N <rplsssn@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, rplsssn@codeaurora.org,
        ilina@codeaurora.org
Subject: [PATCH v9 06/10] drivers: qcom: rpmh-rsc: allow invalidation of sleep/wake TCS
Date: Thu, 24 May 2018 16:15:27 +0530
Message-Id: <1527158731-17685-7-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527158731-17685-1-git-send-email-rplsssn@codeaurora.org>
References: <1527158731-17685-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

Allow sleep and wake commands to be cleared from the respective TCSes,
so that they can be re-populated.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v9:
	- Remove EXPORT_SYMBOL

Changes in v7:
	- Move bitmap_zero() outside the loop

Changes in v6:
	- remove unnecessary locks around __tcs_invalidate
	- rename function to tcs_invaldiate

Changes in v4:
	- refactored the rphm_rsc_invalidate()
---
 drivers/soc/qcom/rpmh-rsc.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index e313ff4..4ab7001 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -104,6 +104,50 @@ static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
 	return &drv->tcs[type];
 }
 
+static int tcs_invalidate(struct rsc_drv *drv, int type)
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
+		write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, m, 0);
+	}
+	bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
+	spin_unlock(&tcs->lock);
+
+	return 0;
+}
+
+/**
+ * rpmh_rsc_invalidate - Invalidate sleep and wake TCSes
+ *
+ * @drv: the RSC controller
+ */
+int rpmh_rsc_invalidate(struct rsc_drv *drv)
+{
+	int ret;
+
+	ret = tcs_invalidate(drv, SLEEP_TCS);
+	if (!ret)
+		ret = tcs_invalidate(drv, WAKE_TCS);
+
+	return ret;
+}
+
 static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 					 const struct tcs_request *msg)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
