Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB15ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BBA20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZS5N2v27";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PjpY8lxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BBA20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbeGSKCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:02:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40016 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeGSKCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:02:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6796E60B10; Thu, 19 Jul 2018 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531991990;
        bh=cc/x9UODvake8ZJH9/NjhmsmB8DacKCgzKe7nJLSSkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZS5N2v278shGJte8AxjipAqDtDAkDX7btfPgcld+4CqXW+h2tXTcpuSg6KKsoOBgo
         dIKP/IVMM67UQP691emDtya+n0x5ykNzZE/nkX+e1IyOSHN5jymjvq9LPI+lwP5Idn
         wpg3kXVlQ0Jrqgk2tXUts3haMp+jNL2Gbba8NX0c=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43B27607C6;
        Thu, 19 Jul 2018 09:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531991989;
        bh=cc/x9UODvake8ZJH9/NjhmsmB8DacKCgzKe7nJLSSkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PjpY8lxShcUCFgxryIRfsI96DOi0TyMH4PW4KopKwPAO/CLHVOT+eUVHm1guQscrc
         Fu2k3iP8FBEJ9WTKgR6o9iRJswx7JaRIvpE01W5zn5kGysLrOQRXFZY+oPampohRSg
         9kTt24VTYDgGz4yqx8TXqn9eeroXrxHgMXxA3+cs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43B27607C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH 1/6] drivers: qcom: rpmh-rsc: return if the controller is idle
Date:   Thu, 19 Jul 2018 14:49:30 +0530
Message-Id: <1531991975-23665-2-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531991975-23665-1-git-send-email-rplsssn@codeaurora.org>
References: <1531991975-23665-1-git-send-email-rplsssn@codeaurora.org>
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
 drivers/soc/qcom/rpmh-internal.h |  1 +
 drivers/soc/qcom/rpmh-rsc.c      | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

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
index 33fe9f9..e513c3c 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -496,6 +496,27 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
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
+EXPORT_SYMBOL(rpmh_rsc_ctrlr_is_idle);
+
+/**
  * rpmh_rsc_write_ctrl_data: Write request to the controller
  *
  * @drv: the controller
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

