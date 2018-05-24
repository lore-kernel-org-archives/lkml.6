Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032559AbeEXKrt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 06:47:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42358 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032544AbeEXKrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 06:47:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0757460A06
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From: Raju P L S S S N <rplsssn@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, rplsssn@codeaurora.org,
        ilina@codeaurora.org
Subject: [PATCH v9 10/10] drivers: qcom: rpmh-rsc: allow active requests from wake TCS
Date: Thu, 24 May 2018 16:15:31 +0530
Message-Id: <1527158731-17685-11-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527158731-17685-1-git-send-email-rplsssn@codeaurora.org>
References: <1527158731-17685-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

Some RSCs may only have sleep and wake TCS, i.e, there is no dedicated
TCS for active mode request, but drivers may still want to make active
requests from these RSCs. In such cases re-purpose the wake TCS to send
active state requests.

The requirement for this is that the driver is aware that the wake TCS
is being repurposed to send active request, hence the sleep and wake
TCSes be invalidated before the active request is sent.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v9:
	- invalidate again if -EAGAIN is returned by rpmh_rsc_invalidate
---
 drivers/soc/qcom/rpmh-rsc.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 4ab7001..83c3a65 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -151,7 +151,8 @@ int rpmh_rsc_invalidate(struct rsc_drv *drv)
 static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 					 const struct tcs_request *msg)
 {
-	int type;
+	int type, ret;
+	struct tcs_group *tcs;
 
 	switch (msg->state) {
 	case RPMH_ACTIVE_ONLY_STATE:
@@ -167,7 +168,25 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
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
+		if (!IS_ERR(tcs)) {
+			do {
+				ret = rpmh_rsc_invalidate(drv);
+			} while (ret == -EAGAIN);
+		}
+	}
+
+	return tcs;
 }
 
 static const struct tcs_request *get_req_from_tcs(struct rsc_drv *drv,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
