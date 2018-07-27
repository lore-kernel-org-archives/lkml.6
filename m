Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36053C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2794208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H9JJUKZg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pC78i3eP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2794208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbeG0Nki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:40:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47006 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732143AbeG0Nkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:40:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1EDE560B11; Fri, 27 Jul 2018 12:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532693937;
        bh=KO+GwULgWupur0W7x1US4LJMsdqqmKuGODeG47o5+78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H9JJUKZgBKK1GAqunBtHRkl8XnKHFvpLiodmXoMaUjdqM3rTPVW51k3T6Xe00yRlq
         J5SgahjiqjFkbrzkQUJDyXFVdOjF7AoD4EfFNlsoLZLh77RGNOuqFpatw9LavvXTVw
         gWQ/+PEO4LMjZmNSHd29gvrT8smrXPZ1IUyqRHwM=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A6C660B77;
        Fri, 27 Jul 2018 12:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532693936;
        bh=KO+GwULgWupur0W7x1US4LJMsdqqmKuGODeG47o5+78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pC78i3eP+6pUVfU+aystxRwuNyHGYpizv4+69F1k/ey4xdV1J7s0j8/xdaJ7odCOa
         Mj05b6SXeIMPy04qToq8sNYN/Qjb0EhsBxOZfG5YM9C1CiO9u++I8rZCmdRwBCUvtr
         8k/BpUC8w4QOqtlp7aTwDbg4dapoL06SaCOk5QeY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A6C660B77
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        robh+dt@kernel.org, arnaud.pouliquen@st.com, andy.gross@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH V4 9/9] rpmsg: Add compat ioctl for rpmsg char driver
Date:   Fri, 27 Jul 2018 17:47:29 +0530
Message-Id: <1532693849-7037-10-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532693849-7037-1-git-send-email-aneela@codeaurora.org>
References: <1532693849-7037-1-git-send-email-aneela@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compat ioctl callback to support 32bit user space applications.

Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/rpmsg_char.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 76a4477..a76b963 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -285,6 +285,7 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
 	.write = rpmsg_eptdev_write,
 	.poll = rpmsg_eptdev_poll,
 	.unlocked_ioctl = rpmsg_eptdev_ioctl,
+	.compat_ioctl = rpmsg_eptdev_ioctl,
 };
 
 static ssize_t name_show(struct device *dev, struct device_attribute *attr,
@@ -445,6 +446,7 @@ static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
 	.open = rpmsg_ctrldev_open,
 	.release = rpmsg_ctrldev_release,
 	.unlocked_ioctl = rpmsg_ctrldev_ioctl,
+	.compat_ioctl = rpmsg_ctrldev_ioctl,
 };
 
 static void rpmsg_ctrldev_release_device(struct device *dev)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

