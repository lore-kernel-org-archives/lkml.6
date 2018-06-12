Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E609BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED4B208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED4B208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934529AbeFLAUX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:20:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:65341 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934348AbeFLAUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:20:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 17:20:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,212,1526367600"; 
   d="scan'208";a="231780790"
Received: from tstruk-mobl1.jf.intel.com ([10.7.196.162])
  by orsmga005.jf.intel.com with ESMTP; 11 Jun 2018 17:20:19 -0700
Subject: [PATCH v2 1/2] tpm: add ptr to the tpm_space struct to file_priv
From:   Tadeusz Struk <tadeusz.struk@intel.com>
To:     jarkko.sakkinen@linux.intel.com
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        tadeusz.struk@intel.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 11 Jun 2018 17:20:19 -0700
Message-ID: <152876281905.19591.11473468647459659104.stgit@tstruk-mobl1.jf.intel.com>
In-Reply-To: <152876281395.19591.3681365717212126222.stgit@tstruk-mobl1.jf.intel.com>
References: <152876281395.19591.3681365717212126222.stgit@tstruk-mobl1.jf.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a ptr to struct tpm_space to the file_priv to have an easy
access to it in the async job without the need to allocate memory.
This also allows to consolidate of the write operations for
the two interfaces.

Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---
 drivers/char/tpm/tpm-dev-common.c |    8 +++++---
 drivers/char/tpm/tpm-dev.c        |   10 ++--------
 drivers/char/tpm/tpm-dev.h        |    5 +++--
 drivers/char/tpm/tpmrm-dev.c      |   14 ++------------
 4 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index e4a04b2d3c32..f0c033b69b62 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -43,9 +43,11 @@ static void timeout_work(struct work_struct *work)
 }
 
 void tpm_common_open(struct file *file, struct tpm_chip *chip,
-		     struct file_priv *priv)
+		     struct file_priv *priv, struct tpm_space *space)
 {
 	priv->chip = chip;
+	priv->space = space;
+
 	mutex_init(&priv->buffer_mutex);
 	timer_setup(&priv->user_read_timer, user_reader_timeout, 0);
 	INIT_WORK(&priv->work, timeout_work);
@@ -79,7 +81,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 }
 
 ssize_t tpm_common_write(struct file *file, const char __user *buf,
-			 size_t size, loff_t *off, struct tpm_space *space)
+			 size_t size, loff_t *off)
 {
 	struct file_priv *priv = file->private_data;
 	size_t in_size = size;
@@ -119,7 +121,7 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 		mutex_unlock(&priv->buffer_mutex);
 		return -EPIPE;
 	}
-	out_size = tpm_transmit(priv->chip, space, priv->data_buffer,
+	out_size = tpm_transmit(priv->chip, priv->space, priv->data_buffer,
 				sizeof(priv->data_buffer), 0);
 
 	tpm_put_ops(priv->chip);
diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
index ebd74ab5abef..98b9630c3a36 100644
--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -39,7 +39,7 @@ static int tpm_open(struct inode *inode, struct file *file)
 	if (priv == NULL)
 		goto out;
 
-	tpm_common_open(file, chip, priv);
+	tpm_common_open(file, chip, priv, NULL);
 
 	return 0;
 
@@ -48,12 +48,6 @@ static int tpm_open(struct inode *inode, struct file *file)
 	return -ENOMEM;
 }
 
-static ssize_t tpm_write(struct file *file, const char __user *buf,
-			 size_t size, loff_t *off)
-{
-	return tpm_common_write(file, buf, size, off, NULL);
-}
-
 /*
  * Called on file close
  */
@@ -73,6 +67,6 @@ const struct file_operations tpm_fops = {
 	.llseek = no_llseek,
 	.open = tpm_open,
 	.read = tpm_common_read,
-	.write = tpm_write,
+	.write = tpm_common_write,
 	.release = tpm_release,
 };
diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
index b24cfb4d3ee1..4048677bbd78 100644
--- a/drivers/char/tpm/tpm-dev.h
+++ b/drivers/char/tpm/tpm-dev.h
@@ -6,6 +6,7 @@
 
 struct file_priv {
 	struct tpm_chip *chip;
+	struct tpm_space *space;
 
 	/* Data passed to and from the tpm via the read/write calls */
 	size_t data_pending;
@@ -18,11 +19,11 @@ struct file_priv {
 };
 
 void tpm_common_open(struct file *file, struct tpm_chip *chip,
-		     struct file_priv *priv);
+		     struct file_priv *priv, struct tpm_space *space);
 ssize_t tpm_common_read(struct file *file, char __user *buf,
 			size_t size, loff_t *off);
 ssize_t tpm_common_write(struct file *file, const char __user *buf,
-			 size_t size, loff_t *off, struct tpm_space *space);
+			 size_t size, loff_t *off);
 void tpm_common_release(struct file *file, struct file_priv *priv);
 
 #endif
diff --git a/drivers/char/tpm/tpmrm-dev.c b/drivers/char/tpm/tpmrm-dev.c
index 1a0e97a5da5a..96006c6b9696 100644
--- a/drivers/char/tpm/tpmrm-dev.c
+++ b/drivers/char/tpm/tpmrm-dev.c
@@ -28,7 +28,7 @@ static int tpmrm_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 
-	tpm_common_open(file, chip, &priv->priv);
+	tpm_common_open(file, chip, &priv->priv, &priv->space);
 
 	return 0;
 }
@@ -45,21 +45,11 @@ static int tpmrm_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t tpmrm_write(struct file *file, const char __user *buf,
-		   size_t size, loff_t *off)
-{
-	struct file_priv *fpriv = file->private_data;
-	struct tpmrm_priv *priv = container_of(fpriv, struct tpmrm_priv, priv);
-
-	return tpm_common_write(file, buf, size, off, &priv->space);
-}
-
 const struct file_operations tpmrm_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 	.open = tpmrm_open,
 	.read = tpm_common_read,
-	.write = tpmrm_write,
+	.write = tpm_common_write,
 	.release = tpmrm_release,
 };
-

