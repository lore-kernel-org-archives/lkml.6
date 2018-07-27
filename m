Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6816CC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C753208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FFb1RxZe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JkOKDKLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C753208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388580AbeG0NkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:40:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45650 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbeG0NkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:40:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 128C160B7B; Fri, 27 Jul 2018 12:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532693909;
        bh=/iwPFhzuTR1EhsAi4MUmkQ7Y2gHk8p8sHDiMTnBzjxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FFb1RxZeeKnGPOxfvtKmjLsZJ2DgJChT+uboZvpCWSIwOr1OPb0fQh7/4CbOi3QFC
         NJsTklDVBDTo9fhix9/Hnp5oetEfF97ukb+0H6M4DKkW0Kf2iFIQttAjQhxtHkoZFL
         +QeRcCuypb8TMG6BclgnvFy7kfiLm4AEW8evYdeQ=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8F07D605BD;
        Fri, 27 Jul 2018 12:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532693908;
        bh=/iwPFhzuTR1EhsAi4MUmkQ7Y2gHk8p8sHDiMTnBzjxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JkOKDKLGA7vhWVJipiPa5gWiX5BVi3kUbdogsUXkap0jAoy5B/xCJBZvv8Kp6hw19
         GV0QuVTOMoBB+IdEN9yQa6+058cFfuMwS7BLdMQh+8+xeaGiiNh/eUcmG0N7pYoqu4
         WkpXTPqQhQBxH4H/UcLpE92CI+JAeq7VLs+Cv7Q0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F07D605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        robh+dt@kernel.org, arnaud.pouliquen@st.com, andy.gross@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH V4 2/9] rpmsg: glink: Store edge name for glink device
Date:   Fri, 27 Jul 2018 17:47:22 +0530
Message-Id: <1532693849-7037-3-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532693849-7037-1-git-send-email-aneela@codeaurora.org>
References: <1532693849-7037-1-git-send-email-aneela@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Lew <clew@codeaurora.org>

Channels may need to identify the edge their channel was probed for.
Store the edge name by reading the label property from device tree or
default to the node name.

Signed-off-by: Chris Lew <clew@codeaurora.org>
Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_native.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index f505f58..22a3cac 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -93,6 +93,8 @@ struct glink_core_rx_intent {
 struct qcom_glink {
 	struct device *dev;
 
+	const char *name;
+
 	struct mbox_client mbox_client;
 	struct mbox_chan *mbox_chan;
 
@@ -1572,6 +1574,10 @@ struct qcom_glink *qcom_glink_native_probe(struct device *dev,
 	idr_init(&glink->lcids);
 	idr_init(&glink->rcids);
 
+	ret = of_property_read_string(dev->of_node, "label", &glink->name);
+	if (ret < 0)
+		glink->name = dev->of_node->name;
+
 	glink->mbox_client.dev = dev;
 	glink->mbox_client.knows_txdone = true;
 	glink->mbox_chan = mbox_request_channel(&glink->mbox_client, 0);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

