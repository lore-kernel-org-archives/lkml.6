Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794E7C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7AC213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MFL/KetA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O0H5PBh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7AC213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeJCSXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:23:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55648 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJCSXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:23:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3819860C72; Wed,  3 Oct 2018 11:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538566517;
        bh=Dx6hgdqcp5/Sk72Wp06vKywV8EGpB2K6sg2z2s5BXiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFL/KetAQlgHVdonGW0gdXqxjjN7/qjono26LcTbr/6Z0k7M0MnGyw7Gfiw5ONQYs
         rlweLj5dW+9L33/WzjWokmzLje01m58PddB/p+FjpjcyHqPpEBSMn7n5Zg4z3IfNz+
         nY3CHO7vORG8nCoqSOhH5Vy/f722vUgSFWYwPPsQ=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DB7C360C85;
        Wed,  3 Oct 2018 11:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538566516;
        bh=Dx6hgdqcp5/Sk72Wp06vKywV8EGpB2K6sg2z2s5BXiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0H5PBh4Ec86a9c7wVGhTgenGR/+dnxZoXq0/KSSVQsWPBql3FO/lmUxrDMMNxSjM
         HbFGn04FylYxe0eLtMcLDfNog7aaDpPMXUClITkvTGS1qLEWcIjXxaNmBTOws4e+WM
         Tqqe4P1AzVwLq1qwOHxuxvl+fUkFF4eoSC9+S47c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB7C360C85
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH 5/5] rpmsg: glink: Convert the native signals to TIOCM
Date:   Wed,  3 Oct 2018 17:04:23 +0530
Message-Id: <1538566463-24627-6-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538566463-24627-1-git-send-email-aneela@codeaurora.org>
References: <1538566463-24627-1-git-send-email-aneela@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Native signals over SMEM transport are different from Linux TIOCM signals.
Add a macro to convert signals when sent or received from clients.

Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_native.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index ff8751b..3054c86 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -18,6 +18,7 @@
 #include <linux/rpmsg.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/termios.h>
 #include <linux/workqueue.h>
 #include <linux/mailbox_client.h>
 
@@ -211,6 +212,11 @@ struct glink_channel {
 
 #define GLINK_FEATURE_INTENTLESS	BIT(1)
 
+#define NATIVE_DTR_SIG BIT(31)
+#define NATIVE_CTS_SIG BIT(30)
+#define NATIVE_CD_SIG BIT(29)
+#define NATIVE_RI_SIG BIT(28)
+
 static void qcom_glink_rx_done_work(struct work_struct *work);
 
 static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
@@ -998,6 +1004,18 @@ static int qcom_glink_handle_signals(struct qcom_glink *glink,
 	}
 
 	old = channel->rsigs;
+
+	/* convert signals from NATIVE to TIOCM */
+	if (signals & NATIVE_DTR_SIG)
+		signals |= TIOCM_DSR;
+	if (signals & NATIVE_CTS_SIG)
+		signals |= TIOCM_CTS;
+	if (signals & NATIVE_CD_SIG)
+		signals |= TIOCM_CD;
+	if (signals & NATIVE_RI_SIG)
+		signals |= TIOCM_RI;
+	signals &= 0x0fff;
+
 	channel->rsigs = signals;
 
 	if (channel->ept.sig_cb)
@@ -1387,6 +1405,17 @@ static int qcom_glink_set_sigs(struct rpmsg_endpoint *ept, u32 sigs)
 
 	channel->lsigs = sigs;
 
+	/* convert signals from TIOCM to NATIVE */
+	sigs &= 0x0fff;
+	if (sigs & TIOCM_DTR)
+		sigs |= NATIVE_DTR_SIG;
+	if (sigs & TIOCM_RTS)
+		sigs |= NATIVE_CTS_SIG;
+	if (sigs & TIOCM_CD)
+		sigs |= NATIVE_CD_SIG;
+	if (sigs & TIOCM_RI)
+		sigs |= NATIVE_RI_SIG;
+
 	return qcom_glink_send_signals(glink, channel, sigs);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

