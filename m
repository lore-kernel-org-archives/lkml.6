Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF6CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85EA20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gr6VKXV/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bYEQUe/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85EA20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932170AbeFTN2C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:28:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752870AbeFTN16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:27:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 33C4A605BD; Wed, 20 Jun 2018 13:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529501278;
        bh=QTxwBMGQ4fycRne3exyNC0tD/2JU39COfMNLQl2LQkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gr6VKXV/LnlIVBTpMXlv7/Im4LClWfNr4gLT/tztJeVWWtEPV3tqN+jLkH/Qc+hpS
         4Xbx5dJAyoeMY8aDEMlfZJx8wFdQDuu+XAVuDsTRcMx6W2y1Wd/2FHo1gz9yT1g+9H
         SS7ERCzX807obZjbVweTMl/wKHX9wHcvr3Ta/cQs=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4AED060AD8;
        Wed, 20 Jun 2018 13:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529501277;
        bh=QTxwBMGQ4fycRne3exyNC0tD/2JU39COfMNLQl2LQkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bYEQUe/Rt7D39Iglr3HPQb9RArYRgPeHbXgMo1HGEKtIsVj+z3fVO6gpQrmO09Ffc
         9T2yK5jIRhXNRg9rp23JDXLrOVdOLQib88x8MKEtln7gsFQCO7kzJtX1zthQtVuSyc
         TjP4QwOxDxkHiV2i2bEcodRi2TdPyFaEdBkXAZ5U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4AED060AD8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v13 10/10] drivers: qcom: rpmh-rsc: allow active requests from wake TCS
Date:   Wed, 20 Jun 2018 18:57:07 +0530
Message-Id: <1529501227-27163-11-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529501227-27163-1-git-send-email-rplsssn@codeaurora.org>
References: <1529501227-27163-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
---
Changes in v10:
	- return ERR_PTR if invalidate fails
Changes in v9:
	- invalidate again if -EAGAIN is returned by rpmh_rsc_invalidate
---
 drivers/soc/qcom/rpmh-rsc.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 4c0c1f2..098feb9 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -148,7 +148,8 @@ int rpmh_rsc_invalidate(struct rsc_drv *drv)
 static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 					 const struct tcs_request *msg)
 {
-	int type;
+	int type, ret;
+	struct tcs_group *tcs;
 
 	switch (msg->state) {
 	case RPMH_ACTIVE_ONLY_STATE:
@@ -164,7 +165,25 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
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
+			ret = rpmh_rsc_invalidate(drv);
+			if (ret)
+				return ERR_PTR(ret);
+		}
+	}
+
+	return tcs;
 }
 
 static const struct tcs_request *get_req_from_tcs(struct rsc_drv *drv,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

