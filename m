Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314FDC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6329208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P6vtYGRN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P6vtYGRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6329208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbeG0NkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:40:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46054 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbeG0NkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:40:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3FB7560B7E; Fri, 27 Jul 2018 12:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532693918;
        bh=BY/aSkH9MI7NgUAIsPWv/6I20fPzcHPW17eOSShBZ8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P6vtYGRNCpTxUXnBCKfghNj3aRSk59pRSezjkdKJRq3lmb+VW1Zv4FCIy4yC3veh5
         38qwcVc9dx8KVC4K11wrzmCGURfGPLnUNvRUkGPcTMvj8uRzTAj2s7SIDea99nvja9
         Pukctgh5vwVZPRKqSK4biSupc6QK9QASu3bqq49Y=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0650360B7B;
        Fri, 27 Jul 2018 12:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532693918;
        bh=BY/aSkH9MI7NgUAIsPWv/6I20fPzcHPW17eOSShBZ8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P6vtYGRNCpTxUXnBCKfghNj3aRSk59pRSezjkdKJRq3lmb+VW1Zv4FCIy4yC3veh5
         38qwcVc9dx8KVC4K11wrzmCGURfGPLnUNvRUkGPcTMvj8uRzTAj2s7SIDea99nvja9
         Pukctgh5vwVZPRKqSK4biSupc6QK9QASu3bqq49Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0650360B7B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        robh+dt@kernel.org, arnaud.pouliquen@st.com, andy.gross@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH V4 4/9] rpmsg: Guard against null endpoint ops in destroy
Date:   Fri, 27 Jul 2018 17:47:24 +0530
Message-Id: <1532693849-7037-5-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532693849-7037-1-git-send-email-aneela@codeaurora.org>
References: <1532693849-7037-1-git-send-email-aneela@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Lew <clew@codeaurora.org>

In RPMSG GLINK the chrdev device will allocate an ept as part of the
rpdev creation. This device will not register endpoint ops even though
it has an allocated ept. Protect against the case where the device is
being destroyed.

Signed-off-by: Chris Lew <clew@codeaurora.org>
Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/rpmsg_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index b714a54..0860328 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -80,7 +80,7 @@ struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_device *rpdev,
  */
 void rpmsg_destroy_ept(struct rpmsg_endpoint *ept)
 {
-	if (ept)
+	if (ept && ept->ops)
 		ept->ops->destroy_ept(ept);
 }
 EXPORT_SYMBOL(rpmsg_destroy_ept);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

