Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D22C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0819A208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JRzTONZa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JRzTONZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0819A208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388719AbeG0Nka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:40:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46620 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732143AbeG0Nka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:40:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 70F2160B77; Fri, 27 Jul 2018 12:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532693929;
        bh=xuUWBr8dcM/MN5c95jbBMCh+7xN/ZW9Hqky4oSm3rnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRzTONZaVjTpZR1mZI4efBKFcsXSs4AbGtdVcMv5dW2fjMsuDJpsqTs/kzvhCy/Ve
         UZV0EpQ0ztu52FLdvakxC+WOvNedkTXCl2UQhYqPVexQ6mlWYAcyzhq1ddZu1WpaxI
         3zNKPz6TwYsE2L5qwvb7QRE0uYiBPjvi8x2uhSrA=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1BAE660B62;
        Fri, 27 Jul 2018 12:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532693929;
        bh=xuUWBr8dcM/MN5c95jbBMCh+7xN/ZW9Hqky4oSm3rnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRzTONZaVjTpZR1mZI4efBKFcsXSs4AbGtdVcMv5dW2fjMsuDJpsqTs/kzvhCy/Ve
         UZV0EpQ0ztu52FLdvakxC+WOvNedkTXCl2UQhYqPVexQ6mlWYAcyzhq1ddZu1WpaxI
         3zNKPz6TwYsE2L5qwvb7QRE0uYiBPjvi8x2uhSrA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1BAE660B62
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        robh+dt@kernel.org, arnaud.pouliquen@st.com, andy.gross@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH V4 7/9] rpmsg: glink: Remove chunk size word align warning
Date:   Fri, 27 Jul 2018 17:47:27 +0530
Message-Id: <1532693849-7037-8-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532693849-7037-1-git-send-email-aneela@codeaurora.org>
References: <1532693849-7037-1-git-send-email-aneela@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Lew <clew@codeaurora.org>

It is possible for the chunk sizes coming from the non RPM remote procs
to not be word aligned. Remove the alignment warning and continue to
read from the FIFO so execution is not stalled.

Signed-off-by: Chris Lew <clew@codeaurora.org>
Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_native.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 7b4ffa0..484b427 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -789,9 +789,6 @@ static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
 		return -EAGAIN;
 	}
 
-	if (WARN(chunk_size % 4, "Incoming data must be word aligned\n"))
-		return -EINVAL;
-
 	rcid = le16_to_cpu(hdr.msg.param1);
 	spin_lock_irqsave(&glink->idr_lock, flags);
 	channel = idr_find(&glink->rcids, rcid);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

