Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968079AbeCBQqE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:46:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41074 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967984AbeCBQnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:43:42 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF17D601A1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 10/10] drivers: qcom: rpmh-rsc: allow active requests from wake TCS
Date: Fri,  2 Mar 2018 09:43:17 -0700
Message-Id: <20180302164317.10554-11-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302164317.10554-1-ilina@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
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
index e9f5a1f387fd..d9cfa7aaf49c 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -220,6 +220,7 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 					struct tcs_request *msg)
 {
 	int type;
+	struct tcs_group *tcs;
 
 	switch (msg->state) {
 	case RPMH_ACTIVE_ONLY_STATE:
@@ -235,7 +236,22 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
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
 
 static void send_tcs_response(struct tcs_response *resp)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
