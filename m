Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BA644C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDFE20869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YZMqR5QF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bqZz3mXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDFE20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934356AbeFKR1O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:27:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53064 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934318AbeFKR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:27:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1891B607BB; Mon, 11 Jun 2018 17:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528738029;
        bh=8uaIx4yjtC/KZ2kKF2NmYzqoW9pMOmZQl91cRN5N3AA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZMqR5QFRCPELWmT0G1EDsEPQ9saE+s4A22MxNKkiiq3QyzrLilHaBSsoK7T6MOxl
         9dUr+G+TIVaOTgX7N+8Sa1237Qrhy1JXb6Csl1v/BebPHS2vQlNI+TNThwH3RAclQk
         pOTa60mfqUtSOviT5jJPXKSPtbjq/qsz3eeUqOsc=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D2665607E4;
        Mon, 11 Jun 2018 17:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528738028;
        bh=8uaIx4yjtC/KZ2kKF2NmYzqoW9pMOmZQl91cRN5N3AA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqZz3mXxPW1cpqdZxZNv6PR9Ect5fe1oGvBSIu+TYWv6hp3y3oglQ+8c8Lpkj6GLd
         tU+rcul3oGseJcmh3LuvHaVvmX1OijzlphzsuqzV/L+FTpYTR8c2FjyeDDH7sUE1On
         iVrUxbtCkOws8+hKECjsgGtajnv4Mq0poBCxyITM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2665607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v10 10/10] drivers: qcom: rpmh-rsc: allow active requests from wake TCS
Date:   Mon, 11 Jun 2018 22:55:49 +0530
Message-Id: <1528737949-17495-11-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528737949-17495-1-git-send-email-rplsssn@codeaurora.org>
References: <1528737949-17495-1-git-send-email-rplsssn@codeaurora.org>
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
index a68dcd1..c4f12fa 100644
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

