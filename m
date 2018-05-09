Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935524AbeEIRDl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:03:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57000 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965715AbeEIRCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:02:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DCB216022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, rplsssn@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v8 06/10] drivers: qcom: rpmh-rsc: allow invalidation of sleep/wake TCS
Date: Wed,  9 May 2018 11:01:55 -0600
Message-Id: <20180509170159.29682-7-ilina@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509170159.29682-1-ilina@codeaurora.org>
References: <20180509170159.29682-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow sleep and wake commands to be cleared from the respective TCSes,
so that they can be re-populated.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---

Changes in v7:
	- Move bitmap_zero() outside the loop

Changes in v6:
	- remove unnecessary locks around __tcs_invalidate
	- rename function to tcs_invaldiate

Changes in v4:
	- refactored the rphm_rsc_invalidate()
---
 drivers/soc/qcom/rpmh-rsc.c | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index b5894b001ae1..68c25ebbbe09 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -104,6 +104,51 @@ static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
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
+EXPORT_SYMBOL(rpmh_rsc_invalidate);
+
 static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 					 const struct tcs_request *msg)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
