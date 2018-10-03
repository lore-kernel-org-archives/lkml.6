Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5404C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABAF21470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X7qjqVMr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X7qjqVMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABAF21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeJCSXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:23:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55232 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJCSXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:23:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 92F3A60C64; Wed,  3 Oct 2018 11:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538566501;
        bh=nUgIgU3sGUyVGun7lBeMAs0TsBKW0lT54wD28lwzNvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X7qjqVMrhWVTLy/dFU2oY7T1KbwUuhYwP2UBkOAaWDpK2c6WZ4nNFped3NmUsI5Kz
         QYsPidu2ZyzLLFReDP/BW0L0uEpCqLvhSzWaGDo72WaN/jEuguwam5sYI36hM7W4cU
         17K4NgXgmI1ZoSaIFpzDjwTSEOhlFjYXG7SDPaCs=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5EAD8607BD;
        Wed,  3 Oct 2018 11:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538566501;
        bh=nUgIgU3sGUyVGun7lBeMAs0TsBKW0lT54wD28lwzNvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X7qjqVMrhWVTLy/dFU2oY7T1KbwUuhYwP2UBkOAaWDpK2c6WZ4nNFped3NmUsI5Kz
         QYsPidu2ZyzLLFReDP/BW0L0uEpCqLvhSzWaGDo72WaN/jEuguwam5sYI36hM7W4cU
         17K4NgXgmI1ZoSaIFpzDjwTSEOhlFjYXG7SDPaCs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5EAD8607BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH 2/5] rpmsg: Add signal callback to rpmsg char device
Date:   Wed,  3 Oct 2018 17:04:20 +0530
Message-Id: <1538566463-24627-3-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538566463-24627-1-git-send-email-aneela@codeaurora.org>
References: <1538566463-24627-1-git-send-email-aneela@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a callback to get the signal notifications from rpmsg.

Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/rpmsg_char.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index a76b963..86003d5 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2012, PetaLogix
  * Copyright (c) 2011, Texas Instruments, Inc.
  * Copyright (c) 2011, Google, Inc.
+ * Copyright (c) 2018, The Linux Foundation.
  *
  * Based on rpmsg performance statistics driver by Michal Simek, which in turn
  * was based on TI & Google OMX rpmsg driver.
@@ -120,6 +121,12 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
 	return 0;
 }
 
+static int rpmsg_sigs_cb(struct rpmsg_device *rpdev, void *priv,
+			 u32 old, u32 new)
+{
+	return 0;
+}
+
 static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 {
 	struct rpmsg_eptdev *eptdev = cdev_to_eptdev(inode->i_cdev);
@@ -136,6 +143,7 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 		return -EINVAL;
 	}
 
+	ept->sig_cb = rpmsg_sigs_cb;
 	eptdev->ept = ept;
 	filp->private_data = eptdev;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

