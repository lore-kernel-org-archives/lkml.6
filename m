Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4ABC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234B4216E3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234B4216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeHGWn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:43:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:42740 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbeHGWn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:43:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 13:27:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="63088755"
Received: from tstruk-mobl1.jf.intel.com ([10.7.196.170])
  by orsmga007.jf.intel.com with ESMTP; 07 Aug 2018 13:27:49 -0700
Subject: [PATCH v4 2/2] tpm: add support for nonblocking operation
From:   Tadeusz Struk <tadeusz.struk@intel.com>
To:     jarkko.sakkinen@linux.intel.com
Cc:     flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tadeusz.struk@intel.com
Date:   Tue, 07 Aug 2018 13:27:49 -0700
Message-ID: <153367366969.18015.14742040525393494830.stgit@tstruk-mobl1.jf.intel.com>
In-Reply-To: <153367365951.18015.11320230309813817454.stgit@tstruk-mobl1.jf.intel.com>
References: <153367365951.18015.11320230309813817454.stgit@tstruk-mobl1.jf.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the TPM driver only supports blocking calls, which doesn't allow
asynchronous IO operations to the TPM hardware.
This patch changes it and adds support for nonblocking write and a new poll
function to enable applications, which want to take advantage of this.

Tested-by: Philip Tricca <philip.b.tricca@intel.com>
Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---
 drivers/char/tpm/tpm-dev-common.c |  149 ++++++++++++++++++++++++++++---------
 drivers/char/tpm/tpm-dev.c        |   16 +++-
 drivers/char/tpm/tpm-dev.h        |   17 +++-
 drivers/char/tpm/tpm-interface.c  |    1 
 drivers/char/tpm/tpm.h            |    1 
 drivers/char/tpm/tpmrm-dev.c      |   19 +++--
 6 files changed, 150 insertions(+), 53 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index f0c033b69b62..f71d80b94451 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -17,11 +17,36 @@
  * License.
  *
  */
+#include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/workqueue.h>
 #include "tpm.h"
 #include "tpm-dev.h"
 
+static struct workqueue_struct *tpm_dev_wq;
+static DEFINE_MUTEX(tpm_dev_wq_lock);
+
+static void tpm_async_work(struct work_struct *work)
+{
+	struct file_priv *priv =
+			container_of(work, struct file_priv, async_work);
+	ssize_t ret;
+
+	mutex_lock(&priv->buffer_mutex);
+	priv->command_enqueued = false;
+	ret = tpm_transmit(priv->chip, priv->space, priv->data_buffer,
+			   sizeof(priv->data_buffer), 0);
+
+	tpm_put_ops(priv->chip);
+	if (ret > 0) {
+		priv->data_pending = ret;
+		mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
+	}
+	mutex_unlock(&priv->buffer_mutex);
+	wake_up_interruptible(&priv->async_wait);
+}
+
 static void user_reader_timeout(struct timer_list *t)
 {
 	struct file_priv *priv = from_timer(priv, t, user_read_timer);
@@ -29,30 +54,44 @@ static void user_reader_timeout(struct timer_list *t)
 	pr_warn("TPM user space timeout is deprecated (pid=%d)\n",
 		task_tgid_nr(current));
 
-	schedule_work(&priv->work);
+	schedule_work(&priv->timeout_work);
 }
 
-static void timeout_work(struct work_struct *work)
+static void tpm_timeout_work(struct work_struct *work)
 {
-	struct file_priv *priv = container_of(work, struct file_priv, work);
+	struct file_priv *priv = container_of(work, struct file_priv,
+					      timeout_work);
 
 	mutex_lock(&priv->buffer_mutex);
 	priv->data_pending = 0;
 	memset(priv->data_buffer, 0, sizeof(priv->data_buffer));
 	mutex_unlock(&priv->buffer_mutex);
+	wake_up_interruptible(&priv->async_wait);
 }
 
-void tpm_common_open(struct file *file, struct tpm_chip *chip,
-		     struct file_priv *priv, struct tpm_space *space)
+int tpm_common_open(struct file *file, struct tpm_chip *chip,
+		    struct file_priv *priv, struct tpm_space *space)
 {
 	priv->chip = chip;
 	priv->space = space;
 
 	mutex_init(&priv->buffer_mutex);
 	timer_setup(&priv->user_read_timer, user_reader_timeout, 0);
-	INIT_WORK(&priv->work, timeout_work);
-
+	INIT_WORK(&priv->timeout_work, tpm_timeout_work);
+	INIT_WORK(&priv->async_work, tpm_async_work);
+	init_waitqueue_head(&priv->async_wait);
 	file->private_data = priv;
+	mutex_lock(&tpm_dev_wq_lock);
+	if (!tpm_dev_wq) {
+		tpm_dev_wq = alloc_workqueue("tpm_dev_wq", WQ_MEM_RECLAIM, 0);
+		if (!tpm_dev_wq) {
+			mutex_unlock(&tpm_dev_wq_lock);
+			return -ENOMEM;
+		}
+	}
+
+	mutex_unlock(&tpm_dev_wq_lock);
+	return 0;
 }
 
 ssize_t tpm_common_read(struct file *file, char __user *buf,
@@ -63,15 +102,17 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 	int rc;
 
 	del_singleshot_timer_sync(&priv->user_read_timer);
-	flush_work(&priv->work);
+	flush_work(&priv->timeout_work);
 	mutex_lock(&priv->buffer_mutex);
 
 	if (priv->data_pending) {
 		ret_size = min_t(ssize_t, size, priv->data_pending);
-		rc = copy_to_user(buf, priv->data_buffer, ret_size);
-		memset(priv->data_buffer, 0, priv->data_pending);
-		if (rc)
-			ret_size = -EFAULT;
+		if (ret_size > 0) {
+			rc = copy_to_user(buf, priv->data_buffer, ret_size);
+			memset(priv->data_buffer, 0, priv->data_pending);
+			if (rc)
+				ret_size = -EFAULT;
+		}
 
 		priv->data_pending = 0;
 	}
@@ -84,10 +125,9 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 			 size_t size, loff_t *off)
 {
 	struct file_priv *priv = file->private_data;
-	size_t in_size = size;
-	ssize_t out_size;
+	int ret = 0;
 
-	if (in_size > TPM_BUFSIZE)
+	if (size > TPM_BUFSIZE)
 		return -E2BIG;
 
 	mutex_lock(&priv->buffer_mutex);
@@ -96,21 +136,20 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	 * tpm_read or a user_read_timer timeout. This also prevents split
 	 * buffered writes from blocking here.
 	 */
-	if (priv->data_pending != 0) {
-		mutex_unlock(&priv->buffer_mutex);
-		return -EBUSY;
+	if (priv->data_pending != 0 || priv->command_enqueued) {
+		ret = -EBUSY;
+		goto out;
 	}
 
-	if (copy_from_user
-	    (priv->data_buffer, (void __user *) buf, in_size)) {
-		mutex_unlock(&priv->buffer_mutex);
-		return -EFAULT;
+	if (copy_from_user(priv->data_buffer, buf, size)) {
+		ret = -EFAULT;
+		goto out;
 	}
 
-	if (in_size < 6 ||
-	    in_size < be32_to_cpu(*((__be32 *) (priv->data_buffer + 2)))) {
-		mutex_unlock(&priv->buffer_mutex);
-		return -EINVAL;
+	if (size < 6 ||
+	    size < be32_to_cpu(*((__be32 *)(priv->data_buffer + 2)))) {
+		ret = -EINVAL;
+		goto out;
 	}
 
 	/* atomic tpm command send and result receive. We only hold the ops
@@ -118,25 +157,50 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	 * the char dev is held open.
 	 */
 	if (tpm_try_get_ops(priv->chip)) {
-		mutex_unlock(&priv->buffer_mutex);
-		return -EPIPE;
+		ret = -EPIPE;
+		goto out;
 	}
-	out_size = tpm_transmit(priv->chip, priv->space, priv->data_buffer,
-				sizeof(priv->data_buffer), 0);
 
-	tpm_put_ops(priv->chip);
-	if (out_size < 0) {
+	/*
+	 * If in nonblocking mode schedule an async job to send
+	 * the command return the size.
+	 * In case of error the err code will be returned in
+	 * the subsequent read call.
+	 */
+	if (file->f_flags & O_NONBLOCK) {
+		priv->command_enqueued = true;
+		queue_work(tpm_dev_wq, &priv->async_work);
 		mutex_unlock(&priv->buffer_mutex);
-		return out_size;
+		return size;
 	}
 
-	priv->data_pending = out_size;
+	ret = tpm_transmit(priv->chip, priv->space, priv->data_buffer,
+			   sizeof(priv->data_buffer), 0);
+	tpm_put_ops(priv->chip);
+
+	if (ret > 0) {
+		priv->data_pending = ret;
+		mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
+		ret = size;
+	}
+out:
 	mutex_unlock(&priv->buffer_mutex);
+	return ret;
+}
 
-	/* Set a timeout by which the reader must come claim the result */
-	mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
+__poll_t tpm_common_poll(struct file *file, poll_table *wait)
+{
+	struct file_priv *priv = file->private_data;
+	__poll_t mask = 0;
+
+	poll_wait(file, &priv->async_wait, wait);
 
-	return in_size;
+	if (priv->data_pending)
+		mask = EPOLLIN | EPOLLRDNORM;
+	else
+		mask = EPOLLOUT | EPOLLWRNORM;
+
+	return mask;
 }
 
 /*
@@ -144,8 +208,17 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
  */
 void tpm_common_release(struct file *file, struct file_priv *priv)
 {
+	flush_work(&priv->async_work);
 	del_singleshot_timer_sync(&priv->user_read_timer);
-	flush_work(&priv->work);
+	flush_work(&priv->timeout_work);
 	file->private_data = NULL;
 	priv->data_pending = 0;
 }
+
+void __exit tpm_dev_common_exit(void)
+{
+	if (tpm_dev_wq) {
+		destroy_workqueue(tpm_dev_wq);
+		tpm_dev_wq = NULL;
+	}
+}
diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
index 98b9630c3a36..1e353a4f4b7e 100644
--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -24,6 +24,7 @@ static int tpm_open(struct inode *inode, struct file *file)
 {
 	struct tpm_chip *chip;
 	struct file_priv *priv;
+	int rc = -ENOMEM;
 
 	chip = container_of(inode->i_cdev, struct tpm_chip, cdev);
 
@@ -37,15 +38,21 @@ static int tpm_open(struct inode *inode, struct file *file)
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (priv == NULL)
-		goto out;
+		goto out_clear;
 
-	tpm_common_open(file, chip, priv, NULL);
+	rc = tpm_common_open(file, chip, priv, NULL);
+	if (rc)
+		goto out_free;
 
 	return 0;
 
- out:
+out_free:
+	kfree(priv);
+
+out_clear:
 	clear_bit(0, &chip->is_open);
-	return -ENOMEM;
+
+	return rc;
 }
 
 /*
@@ -68,5 +75,6 @@ const struct file_operations tpm_fops = {
 	.open = tpm_open,
 	.read = tpm_common_read,
 	.write = tpm_common_write,
+	.poll = tpm_common_poll,
 	.release = tpm_release,
 };
diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
index 4048677bbd78..2f0aeff57002 100644
--- a/drivers/char/tpm/tpm-dev.h
+++ b/drivers/char/tpm/tpm-dev.h
@@ -2,28 +2,33 @@
 #ifndef _TPM_DEV_H
 #define _TPM_DEV_H
 
+#include <linux/poll.h>
 #include "tpm.h"
 
 struct file_priv {
 	struct tpm_chip *chip;
 	struct tpm_space *space;
 
-	/* Data passed to and from the tpm via the read/write calls */
-	size_t data_pending;
+	/* Holds the amount of data passed or an error code from async op */
+	ssize_t data_pending;
 	struct mutex buffer_mutex;
 
 	struct timer_list user_read_timer;      /* user needs to claim result */
-	struct work_struct work;
+	struct work_struct timeout_work;
+	struct work_struct async_work;
+	wait_queue_head_t async_wait;
+	bool command_enqueued;
 
 	u8 data_buffer[TPM_BUFSIZE];
 };
 
-void tpm_common_open(struct file *file, struct tpm_chip *chip,
-		     struct file_priv *priv, struct tpm_space *space);
+int tpm_common_open(struct file *file, struct tpm_chip *chip,
+		    struct file_priv *priv, struct tpm_space *space);
 ssize_t tpm_common_read(struct file *file, char __user *buf,
 			size_t size, loff_t *off);
 ssize_t tpm_common_write(struct file *file, const char __user *buf,
 			 size_t size, loff_t *off);
-void tpm_common_release(struct file *file, struct file_priv *priv);
+__poll_t tpm_common_poll(struct file *file, poll_table *wait);
 
+void tpm_common_release(struct file *file, struct file_priv *priv);
 #endif
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1a803b0cf980..9e3de6447512 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -1428,6 +1428,7 @@ static void __exit tpm_exit(void)
 	class_destroy(tpm_class);
 	class_destroy(tpmrm_class);
 	unregister_chrdev_region(tpm_devt, 2*TPM_NUM_DEVICES);
+	tpm_dev_common_exit();
 }
 
 subsys_initcall(tpm_init);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index f3501d05264f..b909dc9e251f 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -604,4 +604,5 @@ int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
 
 int tpm_bios_log_setup(struct tpm_chip *chip);
 void tpm_bios_log_teardown(struct tpm_chip *chip);
+void tpm_dev_common_exit(void);
 #endif
diff --git a/drivers/char/tpm/tpmrm-dev.c b/drivers/char/tpm/tpmrm-dev.c
index 96006c6b9696..f131c97c1577 100644
--- a/drivers/char/tpm/tpmrm-dev.c
+++ b/drivers/char/tpm/tpmrm-dev.c
@@ -23,14 +23,22 @@ static int tpmrm_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 
 	rc = tpm2_init_space(&priv->space);
-	if (rc) {
-		kfree(priv);
-		return -ENOMEM;
-	}
+	if (rc)
+		goto out_free;
 
-	tpm_common_open(file, chip, &priv->priv, &priv->space);
+	rc = tpm_common_open(file, chip, &priv->priv, &priv->space);
+	if (rc)
+		goto out_del_space;
 
 	return 0;
+
+out_del_space:
+	tpm2_del_space(chip, &priv->space);
+
+out_free:
+	kfree(priv);
+
+	return rc;
 }
 
 static int tpmrm_release(struct inode *inode, struct file *file)
@@ -51,5 +59,6 @@ const struct file_operations tpmrm_fops = {
 	.open = tpmrm_open,
 	.read = tpm_common_read,
 	.write = tpm_common_write,
+	.poll = tpm_common_poll,
 	.release = tpmrm_release,
 };

