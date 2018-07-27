Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81387C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3654F2089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oVnXj9Dl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RlHZfpgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3654F2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389244AbeG0L0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:26:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45230 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388964AbeG0L0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:26:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 785B660B74; Fri, 27 Jul 2018 10:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532685902;
        bh=LXSvzrGk8u8GMe066kKwp4GfgpPSPfky36YVntV17nA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oVnXj9DlimNKonMI9wA2QXIuDzUwhoVOLu/vy4j23uc7r1MGOMmrqwwPb+6CTfrnv
         usQwIT6Bkc/B1loOMQF1dNBNHAqXsZNPTVG3EXOjT3BKrAm7tzqUVDoho7yLNzl3G9
         Sinm5odsKbaQlsLuRltchCfqrQp9DVzn7n9mlO7g=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 419B760B19;
        Fri, 27 Jul 2018 10:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532685901;
        bh=LXSvzrGk8u8GMe066kKwp4GfgpPSPfky36YVntV17nA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RlHZfpgTINCdkeYLEQpFbbsFvrtACKhGGy/3dNTy54SaAYv4KZG/Rn5ToJLkTSMWK
         E5b4vUnWSLLFBDOTlD5v7WrNtp3KVaInL1bGWQUuLLVRDst6TBpb/EYF50mDtVlX0L
         k2SH4q1OiPlckO6L9/mYYuMeRboIhQa5An5e5fno=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 419B760B19
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v2 1/6] drivers: qcom: rpmh-rsc: return if the controller is idle
Date:   Fri, 27 Jul 2018 15:34:44 +0530
Message-Id: <1532685889-31345-2-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
References: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

Allow the controller status be queried. The controller is busy if it is
actively processing request.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
Changes in v2:
     - Remove unnecessary EXPORT_SYMBOL
---
 drivers/soc/qcom/rpmh-internal.h |  1 +
 drivers/soc/qcom/rpmh-rsc.c      | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index a7bbbb6..4ff43bf 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -108,6 +108,7 @@ struct rsc_drv {
 int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
 			     const struct tcs_request *msg);
 int rpmh_rsc_invalidate(struct rsc_drv *drv);
+bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv);
 
 void rpmh_tx_done(const struct tcs_request *msg, int r);
 
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 33fe9f9..42d0041 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -496,6 +496,26 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
 }
 
 /**
+ *  rpmh_rsc_ctrlr_is_idle: Check if any of the AMCs are busy.
+ *
+ *  @drv: The controller
+ *
+ *  Returns true if the TCSes are engaged in handling requests.
+ */
+bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv)
+{
+	int m;
+	struct tcs_group *tcs = get_tcs_of_type(drv, ACTIVE_TCS);
+
+	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
+		if (!tcs_is_free(drv, m))
+			return false;
+	}
+
+	return true;
+}
+
+/**
  * rpmh_rsc_write_ctrl_data: Write request to the controller
  *
  * @drv: the controller
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

