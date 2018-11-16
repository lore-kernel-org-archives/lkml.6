Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97378C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A97A2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A97A2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390250AbeKQEEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:04:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:63004 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbeKQEEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:04:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 09:51:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,240,1539673200"; 
   d="scan'208";a="108894630"
Received: from tstruk-mobl1.jf.intel.com ([10.7.196.53])
  by orsmga001.jf.intel.com with ESMTP; 16 Nov 2018 09:51:13 -0800
Subject: [PATCH 1/2] tpm: rename data_pending to transmit_result
From:   Tadeusz Struk <tadeusz.struk@intel.com>
To:     jarkko.sakkinen@linux.intel.com
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tadeusz.struk@intel.com
Date:   Fri, 16 Nov 2018 09:51:13 -0800
Message-ID: <154239067364.2880.13752725056462237016.stgit@tstruk-mobl1.jf.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file_priv->data_pending name is not adequate as it
doesn't contain any data, but the result from the last
successful call to tpm_transmit() function, so rename it
to transmit_result. Also its type should be size_t instead
of ssize_t as it will never be negative. Change it as well.

Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---
 drivers/char/tpm/tpm-dev-common.c |   20 ++++++++++----------
 drivers/char/tpm/tpm-dev.h        |    4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 99b5133a9d05..67a70e2fde7f 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -40,7 +40,7 @@ static void tpm_async_work(struct work_struct *work)
 
 	tpm_put_ops(priv->chip);
 	if (ret > 0) {
-		priv->data_pending = ret;
+		priv->transmit_result = ret;
 		mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
 	}
 	mutex_unlock(&priv->buffer_mutex);
@@ -63,7 +63,7 @@ static void tpm_timeout_work(struct work_struct *work)
 					      timeout_work);
 
 	mutex_lock(&priv->buffer_mutex);
-	priv->data_pending = 0;
+	priv->transmit_result = 0;
 	memset(priv->data_buffer, 0, sizeof(priv->data_buffer));
 	mutex_unlock(&priv->buffer_mutex);
 	wake_up_interruptible(&priv->async_wait);
@@ -94,16 +94,16 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 	flush_work(&priv->timeout_work);
 	mutex_lock(&priv->buffer_mutex);
 
-	if (priv->data_pending) {
-		ret_size = min_t(ssize_t, size, priv->data_pending);
+	if (priv->transmit_result) {
+		ret_size = min_t(ssize_t, size, priv->transmit_result);
 		if (ret_size > 0) {
 			rc = copy_to_user(buf, priv->data_buffer, ret_size);
-			memset(priv->data_buffer, 0, priv->data_pending);
+			memset(priv->data_buffer, 0, priv->transmit_result);
 			if (rc)
 				ret_size = -EFAULT;
 		}
 
-		priv->data_pending = 0;
+		priv->transmit_result = 0;
 	}
 
 	mutex_unlock(&priv->buffer_mutex);
@@ -125,7 +125,7 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	 * tpm_read or a user_read_timer timeout. This also prevents split
 	 * buffered writes from blocking here.
 	 */
-	if (priv->data_pending != 0 || priv->command_enqueued) {
+	if (priv->transmit_result != 0 || priv->command_enqueued) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -168,7 +168,7 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	tpm_put_ops(priv->chip);
 
 	if (ret > 0) {
-		priv->data_pending = ret;
+		priv->transmit_result = ret;
 		mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
 		ret = size;
 	}
@@ -184,7 +184,7 @@ __poll_t tpm_common_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &priv->async_wait, wait);
 
-	if (priv->data_pending)
+	if (priv->transmit_result)
 		mask = EPOLLIN | EPOLLRDNORM;
 	else
 		mask = EPOLLOUT | EPOLLWRNORM;
@@ -201,7 +201,7 @@ void tpm_common_release(struct file *file, struct file_priv *priv)
 	del_singleshot_timer_sync(&priv->user_read_timer);
 	flush_work(&priv->timeout_work);
 	file->private_data = NULL;
-	priv->data_pending = 0;
+	priv->transmit_result = 0;
 }
 
 int __init tpm_dev_common_init(void)
diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
index a126b575cb8c..3ff1dc9f3d75 100644
--- a/drivers/char/tpm/tpm-dev.h
+++ b/drivers/char/tpm/tpm-dev.h
@@ -9,8 +9,8 @@ struct file_priv {
 	struct tpm_chip *chip;
 	struct tpm_space *space;
 
-	/* Holds the amount of data passed or an error code from async op */
-	ssize_t data_pending;
+	/* Holds the resul of the last successful call to tpm_transmit() */
+	size_t transmit_result;
 	struct mutex buffer_mutex;
 
 	struct timer_list user_read_timer;      /* user needs to claim result */

