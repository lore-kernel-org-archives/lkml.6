Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052E8C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA882198F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XcMpjyts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA882198F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388556AbeHGJ0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:26:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42518 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732772AbeHGJ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:26:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so8105113pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 00:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xltT5TAoujnPv7v6tjWXB8ywHjR+DA+W/BmUvJoRLG8=;
        b=XcMpjytswNVhZH34hRITmXk6+jgo1crh8uXcwaqNwl9RGVkVC/jsKHkmZR384VTbRb
         ljaMc4lwc+bq6AgkHoV2uLENWYwC+7RfJqfSntEVKo0Mq98Yn09324EzEGCHewdJ3ipa
         Fm9s5LfVQEzGE5FXu3CPJ0xAITCOkPhG5a8Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xltT5TAoujnPv7v6tjWXB8ywHjR+DA+W/BmUvJoRLG8=;
        b=dyKMHRL6rgIx+KRQbWmapY4Y1IZy2qD/mdK+TjQkEakcRFeunQrppsCmKd5kU6kMa+
         ePIq9MQZiJGFdyy/ZfogSauM358AO6sEWGJKHxJBaTWCOln4/PwpkHCVWIBy63+B8tLu
         HYi6sTJPUIEjJYaFU1BDcrrYDFmi5yF3XscUOd0WUvFzggk2SQG/Wpd0Z5BFmU5DZSal
         jVHMBMUv8vo4gunRMLqZjh29orFO/M1JqkJBNL5ogNkRXONgMojwD12fAzQ58yZhNeLv
         yg3d6G1DR5JY8GCsASMjc1uj97v2jcfjAdA4MgDwgU1mz8wpdgweatpOSxzb/EY/A3Rm
         DQJQ==
X-Gm-Message-State: AOUpUlGVa3Jf/0Emj6IG73qAJpKUpmxNhKhM5olMGOBlIYI4aCxjhrFg
        wPP6FxayReYR9J8whwhDffcx9CwnPbA=
X-Google-Smtp-Source: AAOMgpfHDrYCyRem7deEupIrm1QUOd5NNkSUOwRWq2Nfypl+4JphC+DQK6gWZeOTBYvTOWnSc0gLug==
X-Received: by 2002:a62:51c6:: with SMTP id f189-v6mr10435412pfb.7.1533626004766;
        Tue, 07 Aug 2018 00:13:24 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q25-v6sm1735898pfk.96.2018.08.07.00.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 00:13:24 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rpmsg: char: Migrate to iter versions of read and write
Date:   Tue,  7 Aug 2018 00:14:24 -0700
Message-Id: <20180807071424.3236-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to use the aio interface for writing to a rpmsg_char
the write_iter function must be implemented, so migrate to iter version
for read and write functions.

Regular read and write uses the iter methods if present and is as such
unaffected.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/rpmsg_char.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index a76b963a7e50..eea5ebbb5119 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -167,9 +167,9 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t rpmsg_eptdev_read(struct file *filp, char __user *buf,
-				 size_t len, loff_t *f_pos)
+static ssize_t rpmsg_eptdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *filp = iocb->ki_filp;
 	struct rpmsg_eptdev *eptdev = filp->private_data;
 	unsigned long flags;
 	struct sk_buff *skb;
@@ -205,8 +205,8 @@ static ssize_t rpmsg_eptdev_read(struct file *filp, char __user *buf,
 	if (!skb)
 		return -EFAULT;
 
-	use = min_t(size_t, len, skb->len);
-	if (copy_to_user(buf, skb->data, use))
+	use = min_t(size_t, iov_iter_count(to), skb->len);
+	if (copy_to_iter(skb->data, use, to) != use)
 		use = -EFAULT;
 
 	kfree_skb(skb);
@@ -214,16 +214,21 @@ static ssize_t rpmsg_eptdev_read(struct file *filp, char __user *buf,
 	return use;
 }
 
-static ssize_t rpmsg_eptdev_write(struct file *filp, const char __user *buf,
-				  size_t len, loff_t *f_pos)
+static ssize_t rpmsg_eptdev_write_iter(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
+	struct file *filp = iocb->ki_filp;
 	struct rpmsg_eptdev *eptdev = filp->private_data;
+	size_t len = iov_iter_count(from);
 	void *kbuf;
 	int ret;
 
-	kbuf = memdup_user(buf, len);
-	if (IS_ERR(kbuf))
-		return PTR_ERR(kbuf);
+	kbuf = kzalloc(len, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	if (!copy_from_iter_full(kbuf, len, from))
+		return -EFAULT;
 
 	if (mutex_lock_interruptible(&eptdev->ept_lock)) {
 		ret = -ERESTARTSYS;
@@ -281,8 +286,8 @@ static const struct file_operations rpmsg_eptdev_fops = {
 	.owner = THIS_MODULE,
 	.open = rpmsg_eptdev_open,
 	.release = rpmsg_eptdev_release,
-	.read = rpmsg_eptdev_read,
-	.write = rpmsg_eptdev_write,
+	.read_iter = rpmsg_eptdev_read_iter,
+	.write_iter = rpmsg_eptdev_write_iter,
 	.poll = rpmsg_eptdev_poll,
 	.unlocked_ioctl = rpmsg_eptdev_ioctl,
 	.compat_ioctl = rpmsg_eptdev_ioctl,
-- 
2.18.0

