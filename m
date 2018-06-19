Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC5CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB60120874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Eif0YEjl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ak6rQz2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB60120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757284AbeFSNO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:14:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34378 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937946AbeFSNMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:12:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4E64760B13; Tue, 19 Jun 2018 13:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529413930;
        bh=f0tSnIOxJW/SIc06df8i3q4z0U/ZhG9/CTPXMfX6afc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eif0YEjlItqnJXvWU4BBx68vXhOMcXhFZLfTlGXgyAIpErPD/0fk1zoFnHf/U1qua
         SD3WLJgwQDYVLCqxjW8YJV+WIBzEsx1H9CWcw868tKRdDx5KTR+ti2cPzdcoqavmBe
         mr8hsZrGFeSHfrZZxxm1NQJ9HNMKvA6s1Zau/znk=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB365607EB;
        Tue, 19 Jun 2018 13:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529413929;
        bh=f0tSnIOxJW/SIc06df8i3q4z0U/ZhG9/CTPXMfX6afc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ak6rQz2Y8W5mohTgoVZznxNUbpAXy0t5YbJ1FkoGIzUo2EXcQdUj52talCfPdYrIZ
         H8DJm7s9ONLgY6gKya8X8yrEElwEAhq8NzD6j4PSlyNMb9dSMU1yqd9AO+gdx/eRih
         +Y0bbpHkq1ZQ3dkPaKgvdTTQgSHjmjmVrxzn+Mp4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB365607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v12 06/10] drivers: qcom: rpmh-rsc: allow invalidation of sleep/wake TCS
Date:   Tue, 19 Jun 2018 18:41:29 +0530
Message-Id: <1529413893-5520-7-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529413893-5520-1-git-send-email-rplsssn@codeaurora.org>
References: <1529413893-5520-1-git-send-email-rplsssn@codeaurora.org>
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
index 604ebb6..fed8459 100644
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

