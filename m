Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212D8C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61A52157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61A52157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392355AbeIVGNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:13:31 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44224 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391995AbeIVGKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:48 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdy-0008BW-1b; Sat, 22 Sep 2018 01:19:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdo-0000sz-H6; Sat, 22 Sep 2018 01:19:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jann Horn" <jannh@google.com>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.103481533@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 41/63] USB: yurex: fix out-of-bounds uaccess in read
 handler
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/misc/yurex.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -413,8 +413,7 @@ static int yurex_release(struct inode *i
 static ssize_t yurex_read(struct file *file, char *buffer, size_t count, loff_t *ppos)
 {
 	struct usb_yurex *dev;
-	int retval = 0;
-	int bytes_read = 0;
+	int len = 0;
 	char in_buffer[20];
 	unsigned long flags;
 
@@ -422,26 +421,16 @@ static ssize_t yurex_read(struct file *f
 
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
 
 static ssize_t yurex_write(struct file *file, const char *user_buffer, size_t count, loff_t *ppos)

