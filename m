Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791FAC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33463208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WAJ//o8V";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mr7BJeTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33463208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935038AbeFRNjN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:39:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42438 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934807AbeFRNhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:37:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 45E2660B15; Mon, 18 Jun 2018 13:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529329075;
        bh=pLOwIBxDTltsSVQbBtdC0E8Hyq6eVarFPLCIbhHn1/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAJ//o8VNVa5gX33ccn5ulb4RtBGI2gvP4O3j/T+PcrFI5n8NcuDm6j24ycPLf7Jz
         gqOB95ArW3k55QWkaXfay0TODi80TwXLnDTjjFmVENZ4AMcTMJ+BhyFHECCN4w9CxA
         ov/iht4qcOn98AA02Bxd393bzPLlN6IRCTDfgkL8=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43AD060B19;
        Mon, 18 Jun 2018 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529329074;
        bh=pLOwIBxDTltsSVQbBtdC0E8Hyq6eVarFPLCIbhHn1/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mr7BJeTuEgij3tQ5L7z2a1QAyC+78vLZC0iSDxYNHxecYIoYhmKAD+TeIg1PDPzrI
         VqAz/Fkzz6w1m63ZcifMQS+T2YBEEFzZlPAHedRP3y3Dzyr0CIpm7Bp/GlaBfrFMXD
         4KR2+BNW13ZpFLaSlYPNTFg4sRh15yAgEfxFkGu4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43AD060B19
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v11 06/10] drivers: qcom: rpmh-rsc: allow invalidation of sleep/wake TCS
Date:   Mon, 18 Jun 2018 19:07:16 +0530
Message-Id: <1529329040-2606-7-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529329040-2606-1-git-send-email-rplsssn@codeaurora.org>
References: <1529329040-2606-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

Allow sleep and wake commands to be cleared from the respective TCSes,
so that they can be re-populated.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
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
index b87f9b0..a68dcd1 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -101,6 +101,50 @@ static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
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

