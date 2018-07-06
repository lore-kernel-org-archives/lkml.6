Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0659DC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AB222CB2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLPY33x1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6AB222CB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933219AbeGFPNP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:13:15 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:37417 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932635AbeGFPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:13:13 -0400
Received: by mail-ua0-f201.google.com with SMTP id z33-v6so3529176uah.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=R1zve2zgmlb4kooJs7DKxUHxVCMuzZdZmn6sw6MVakw=;
        b=FLPY33x1Dr6j+4+2rCld0CVuTnbleh3jrGvFcAMi628PqViySrTHx4qRu86EkrwBcD
         Jnk98jZYKaOSCOZsf2vQE4RMFxwzqFliELNGNPZpoC0/pFpG1QMlNTTNjTk2Xcpgbce/
         kHxFtWk2AFa4YjbiE7fYFDh4whjhwf/nnk7MbHUSpTOxKUXLKOgKtWY9stX1WiIMLSln
         NLl/OS3r0dx8/LnPFsqDofO22rFIZB0L8D97fiWZnsRyMQuqAAdjpayOqrrhAx2E/yj/
         jEnol4ndflRnFb8qixhl1w3esAFoFSpLneE/XNETZqd1lq3BoKQa0lPsThuGe4xL5ElC
         PBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=R1zve2zgmlb4kooJs7DKxUHxVCMuzZdZmn6sw6MVakw=;
        b=jm6VEvsB1e1EWb2V9LWQhIYe0xCYN1yRFdyiazCqiweoMZnJIBY/JaznA1Isn+q1rb
         mcjF9nN9u5KLsUu8FX1lnJRKcV4Zz+AVQnpIwLvquEC/EtKmsneAnQggTWNTwW/V3HxI
         JwTeZ8qYyaInADVh2+QnMeA+g6FvTnBJoTVyxyyY3z9EFoHDQ1ulEReJLLiBdjp0VDNO
         Ti+D8ufBULGQ4QcQMTi5UEydANZradnQkacVEQAdByS9HjIyxPAq5zEqbtj5HrUNbZpm
         C1bYHgsPptp/2o1kDUPbpT4U9bWhcPAtJHzxkiQ92yTJlkammZ/qzSzx4DKEGw50t3VK
         2tRQ==
X-Gm-Message-State: APt69E05/p3mk6ZytRWKvX3ae+VLJYqp/vjC+hJ34w0RTbXDdaQtBH/T
        YqquSVTtLiKaGW1zVN5FfLoRlnxiKQ==
X-Google-Smtp-Source: AAOMgpeNy1oNY4n9jj5KyQJF6nX5Tn2t4DnoqWdblniqid3ZwFNXpPIfmz4R5opDMrxeUabLQeDuSUwUgw==
MIME-Version: 1.0
X-Received: by 2002:a1f:36c3:: with SMTP id d186-v6mr4901010vka.69.1530889992182;
 Fri, 06 Jul 2018 08:13:12 -0700 (PDT)
Date:   Fri,  6 Jul 2018 17:12:56 +0200
Message-Id: <20180706151256.30359-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH] USB: yurex: fix out-of-bounds uaccess in read handler
From:   Jann Horn <jannh@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jannh@google.com
Cc:     Tomoki Sekiyama <tomoki.sekiyama@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general, accessing userspace memory beyond the length of the supplied
buffer in VFS read/write handlers can lead to both kernel memory corruption
(via kernel_read()/kernel_write(), which can e.g. be triggered via
sys_splice()) and privilege escalation inside userspace.

Fix it by using simple_read_from_buffer() instead of custom logic.

Fixes: 6bc235a2e24a ("USB: add driver for Meywa-Denki & Kayac YUREX")
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/usb/misc/yurex.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
index 8abb6cbbd98a..3be40eaa1ac9 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -396,8 +396,7 @@ static ssize_t yurex_read(struct file *file, char __user *buffer, size_t count,
 			  loff_t *ppos)
 {
 	struct usb_yurex *dev;
-	int retval = 0;
-	int bytes_read = 0;
+	int len = 0;
 	char in_buffer[20];
 	unsigned long flags;
 
@@ -405,26 +404,16 @@ static ssize_t yurex_read(struct file *file, char __user *buffer, size_t count,
 
 	mutex_lock(&dev->io_mutex);
 	if (!dev->interface) {		/* already disconnected */
-		retval = -ENODEV;
-		goto exit;
+		mutex_unlock(&dev->io_mutex);
+		return -ENODEV;
 	}
 
 	spin_lock_irqsave(&dev->lock, flags);
-	bytes_read = snprintf(in_buffer, 20, "%lld\n", dev->bbu);
+	len = snprintf(in_buffer, 20, "%lld\n", dev->bbu);
 	spin_unlock_irqrestore(&dev->lock, flags);
-
-	if (*ppos < bytes_read) {
-		if (copy_to_user(buffer, in_buffer + *ppos, bytes_read - *ppos))
-			retval = -EFAULT;
-		else {
-			retval = bytes_read - *ppos;
-			*ppos += bytes_read;
-		}
-	}
-
-exit:
 	mutex_unlock(&dev->io_mutex);
-	return retval;
+
+	return simple_read_from_buffer(buffer, count, ppos, in_buffer, len);
 }
 
 static ssize_t yurex_write(struct file *file, const char __user *user_buffer,
-- 
2.18.0.399.gad0ab374a1-goog

