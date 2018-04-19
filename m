Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbeDSWRR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 18:17:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57792 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753935AbeDSWRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 18:17:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2737560FEE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v6 10/10] drivers: qcom: rpmh-rsc: allow active requests from wake TCS
Date: Thu, 19 Apr 2018 16:16:35 -0600
Message-Id: <20180419221635.17849-11-ilina@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419221635.17849-1-ilina@codeaurora.org>
References: <20180419221635.17849-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some RSCs may only have sleep and wake TCS, i.e, there is no dedicated
TCS for active mode request, but drivers may still want to make active
requests from these RSCs. In such cases re-purpose the wake TCS to send
active state requests.

The requirement for this is that the driver is aware that the wake TCS
is being repurposed to send active request, hence the sleep and wake
TCSes be invalidated before the active request is sent.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 170d4a10275d..6a52100cd1e9 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -150,6 +150,7 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 					 const struct tcs_request *msg)
 {
 	int type;
+	struct tcs_group *tcs;
 
 	switch (msg->state) {
 	case RPMH_ACTIVE_ONLY_STATE:
@@ -165,7 +166,22 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 		return ERR_PTR(-EINVAL);
 	}
 
-	return get_tcs_of_type(drv, type);
+	/*
+	 * If we are making an active request on a RSC that does not have a
+	 * dedicated TCS for active state use, then re-purpose a wake TCS to
+	 * send active votes.
+	 * NOTE: The driver must be aware that this RSC does not have a
+	 * dedicated AMC, and therefore would invalidate the sleep and wake
+	 * TCSes before making an active state request.
+	 */
+	tcs = get_tcs_of_type(drv, type);
+	if (msg->state == RPMH_ACTIVE_ONLY_STATE && IS_ERR(tcs)) {
+		tcs = get_tcs_of_type(drv, WAKE_TCS);
+		if (!IS_ERR(tcs))
+			rpmh_rsc_invalidate(drv);
+	}
+
+	return tcs;
 }
 
 static const struct tcs_request *get_req_from_tcs(struct rsc_drv *drv, int m)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
