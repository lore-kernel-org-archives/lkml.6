Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB461C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CCA20869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CCA20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbeKLG3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:29:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49530 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729977AbeKLFsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:07 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0000lJ-Bk; Sun, 11 Nov 2018 19:58:37 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0001UP-Hr; Sun, 11 Nov 2018 19:58:34 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Tadeusz Struk" <tadeusz.struk@intel.com>,
        "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.142970070@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 095/366] tpm: fix race condition in tpm_common_write()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tadeusz Struk <tadeusz.struk@intel.com>

commit 3ab2011ea368ec3433ad49e1b9e1c7b70d2e65df upstream.

There is a race condition in tpm_common_write function allowing
two threads on the same /dev/tpm<N>, or two different applications
on the same /dev/tpmrm<N> to overwrite each other commands/responses.
Fixed this by taking the priv->buffer_mutex early in the function.

Also converted the priv->data_pending from atomic to a regular size_t
type. There is no need for it to be atomic since it is only touched
under the protection of the priv->buffer_mutex.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
[bwh: Backported to 3.16: adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -26,7 +26,7 @@ struct file_priv {
 	struct tpm_chip *chip;
 
 	/* Data passed to and from the tpm via the read/write calls */
-	atomic_t data_pending;
+	size_t data_pending;
 	struct mutex buffer_mutex;
 
 	struct timer_list user_read_timer;      /* user needs to claim result */
@@ -47,7 +47,7 @@ static void timeout_work(struct work_str
 	struct file_priv *priv = container_of(work, struct file_priv, work);
 
 	mutex_lock(&priv->buffer_mutex);
-	atomic_set(&priv->data_pending, 0);
+	priv->data_pending = 0;
 	memset(priv->data_buffer, 0, sizeof(priv->data_buffer));
 	mutex_unlock(&priv->buffer_mutex);
 }
@@ -74,7 +74,6 @@ static int tpm_open(struct inode *inode,
 	}
 
 	priv->chip = chip;
-	atomic_set(&priv->data_pending, 0);
 	mutex_init(&priv->buffer_mutex);
 	setup_timer(&priv->user_read_timer, user_reader_timeout,
 			(unsigned long)priv);
@@ -89,28 +88,24 @@ static ssize_t tpm_read(struct file *fil
 			size_t size, loff_t *off)
 {
 	struct file_priv *priv = file->private_data;
-	ssize_t ret_size;
+	ssize_t ret_size = 0;
 	int rc;
 
 	del_singleshot_timer_sync(&priv->user_read_timer);
 	flush_work(&priv->work);
-	ret_size = atomic_read(&priv->data_pending);
-	if (ret_size > 0) {	/* relay data */
-		ssize_t orig_ret_size = ret_size;
-		if (size < ret_size)
-			ret_size = size;
+	mutex_lock(&priv->buffer_mutex);
 
-		mutex_lock(&priv->buffer_mutex);
+	if (priv->data_pending) {
+		ret_size = min_t(ssize_t, size, priv->data_pending);
 		rc = copy_to_user(buf, priv->data_buffer, ret_size);
-		memset(priv->data_buffer, 0, orig_ret_size);
+		memset(priv->data_buffer, 0, priv->data_pending);
 		if (rc)
 			ret_size = -EFAULT;
 
-		mutex_unlock(&priv->buffer_mutex);
+		priv->data_pending = 0;
 	}
 
-	atomic_set(&priv->data_pending, 0);
-
+	mutex_unlock(&priv->buffer_mutex);
 	return ret_size;
 }
 
@@ -121,17 +116,19 @@ static ssize_t tpm_write(struct file *fi
 	size_t in_size = size;
 	ssize_t out_size;
 
+	if (in_size > TPM_BUFSIZE)
+		return -E2BIG;
+
+	mutex_lock(&priv->buffer_mutex);
+
 	/* cannot perform a write until the read has cleared
 	   either via tpm_read or a user_read_timer timeout.
 	   This also prevents splitted buffered writes from blocking here.
 	*/
-	if (atomic_read(&priv->data_pending) != 0)
+	if (priv->data_pending != 0) {
+		mutex_unlock(&priv->buffer_mutex);
 		return -EBUSY;
-
-	if (in_size > TPM_BUFSIZE)
-		return -E2BIG;
-
-	mutex_lock(&priv->buffer_mutex);
+	}
 
 	if (copy_from_user
 	    (priv->data_buffer, (void __user *) buf, in_size)) {
@@ -153,7 +150,7 @@ static ssize_t tpm_write(struct file *fi
 		return out_size;
 	}
 
-	atomic_set(&priv->data_pending, out_size);
+	priv->data_pending = out_size;
 	mutex_unlock(&priv->buffer_mutex);
 
 	/* Set a timeout by which the reader must come claim the result */
@@ -172,7 +169,7 @@ static int tpm_release(struct inode *ino
 	del_singleshot_timer_sync(&priv->user_read_timer);
 	flush_work(&priv->work);
 	file->private_data = NULL;
-	atomic_set(&priv->data_pending, 0);
+	priv->data_pending = 0;
 	clear_bit(0, &priv->chip->is_open);
 	put_device(priv->chip->dev);
 	kfree(priv);

