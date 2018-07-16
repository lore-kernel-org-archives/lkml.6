Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3A2ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7699206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7699206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388155AbeGPIGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:06:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47300 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbeGPIGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:06:16 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1D635CA1;
        Mon, 16 Jul 2018 07:40:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: [PATCH 4.14 18/54] USB: yurex: fix out-of-bounds uaccess in read handler
Date:   Mon, 16 Jul 2018 09:35:15 +0200
Message-Id: <20180716073454.213120098@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073450.534886211@linuxfoundation.org>
References: <20180716073450.534886211@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit f1e255d60ae66a9f672ff9a207ee6cd8e33d2679 upstream.

In general, accessing userspace memory beyond the length of the supplied
buffer in VFS read/write handlers can lead to both kernel memory corruption
(via kernel_read()/kernel_write(), which can e.g. be triggered via
sys_splice()) and privilege escalation inside userspace.

Fix it by using simple_read_from_buffer() instead of custom logic.

Fixes: 6bc235a2e24a ("USB: add driver for Meywa-Denki & Kayac YUREX")
Signed-off-by: Jann Horn <jannh@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/yurex.c |   23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -400,8 +400,7 @@ static ssize_t yurex_read(struct file *f
 			  loff_t *ppos)
 {
 	struct usb_yurex *dev;
-	int retval = 0;
-	int bytes_read = 0;
+	int len = 0;
 	char in_buffer[20];
 	unsigned long flags;
 
@@ -409,26 +408,16 @@ static ssize_t yurex_read(struct file *f
 
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


