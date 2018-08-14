Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A704C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C6721471
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C6721471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391093AbeHNUeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:34:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60456 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390817AbeHNUep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:34:45 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 510EAD08;
        Tue, 14 Aug 2018 17:46:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 4.4 02/43] tpm: fix race condition in tpm_common_write()
Date:   Tue, 14 Aug 2018 19:17:38 +0200
Message-Id: <20180814171517.174295580@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171517.014285600@linuxfoundation.org>
References: <20180814171517.014285600@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm-dev.c |   43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -25,7 +25,7 @@ struct file_priv {
 	struct tpm_chip *chip;
 
 	/* Data passed to and from the tpm via the read/write calls */
-	atomic_t data_pending;
+	size_t data_pending;
 	struct mutex buffer_mutex;
 
 	struct timer_list user_read_timer;      /* user needs to claim result */
@@ -46,7 +46,7 @@ static void timeout_work(struct work_str
 	struct file_priv *priv = container_of(work, struct file_priv, work);
 
 	mutex_lock(&priv->buffer_mutex);
-	atomic_set(&priv->data_pending, 0);
+	priv->data_pending = 0;
 	memset(priv->data_buffer, 0, sizeof(priv->data_buffer));
 	mutex_unlock(&priv->buffer_mutex);
 }
@@ -72,7 +72,6 @@ static int tpm_open(struct inode *inode,
 	}
 
 	priv->chip = chip;
-	atomic_set(&priv->data_pending, 0);
 	mutex_init(&priv->buffer_mutex);
 	setup_timer(&priv->user_read_timer, user_reader_timeout,
 			(unsigned long)priv);
@@ -86,28 +85,24 @@ static ssize_t tpm_read(struct file *fil
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
 
@@ -118,18 +113,20 @@ static ssize_t tpm_write(struct file *fi
 	size_t in_size = size;
 	ssize_t out_size;
 
-	/* cannot perform a write until the read has cleared
-	   either via tpm_read or a user_read_timer timeout.
-	   This also prevents splitted buffered writes from blocking here.
-	*/
-	if (atomic_read(&priv->data_pending) != 0)
-		return -EBUSY;
-
 	if (in_size > TPM_BUFSIZE)
 		return -E2BIG;
 
 	mutex_lock(&priv->buffer_mutex);
 
+	/* Cannot perform a write until the read has cleared either via
+	 * tpm_read or a user_read_timer timeout. This also prevents split
+	 * buffered writes from blocking here.
+	 */
+	if (priv->data_pending != 0) {
+		mutex_unlock(&priv->buffer_mutex);
+		return -EBUSY;
+	}
+
 	if (copy_from_user
 	    (priv->data_buffer, (void __user *) buf, in_size)) {
 		mutex_unlock(&priv->buffer_mutex);
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
 	kfree(priv);
 	return 0;


