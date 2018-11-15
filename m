Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0DAC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5892086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5892086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388948AbeKPGvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:51:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:65333 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbeKPGvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:51:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 12:42:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,237,1539673200"; 
   d="scan'208";a="89654745"
Received: from tstruk-mobl1.jf.intel.com ([10.7.196.53])
  by orsmga007.jf.intel.com with ESMTP; 15 Nov 2018 12:42:22 -0800
Subject: [PATCH v3] tpm: add support for partial reads
From:   Tadeusz Struk <tadeusz.struk@intel.com>
To:     jarkko.sakkinen@linux.intel.com
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tadeusz.struk@intel.com
Date:   Thu, 15 Nov 2018 12:42:22 -0800
Message-ID: <154231454280.17567.455994477207265338.stgit@tstruk-mobl1.jf.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently to read a response from the TPM device an application needs
provide big enough buffer for the whole response and read it in one go.
The application doesn't know how big the response it beforehand so it
always needs to maintain a 4K buffer and read the max (4K).
In case if the user of the TSS library doesn't provide big enough
buffer the TCTI spec says that the library should set the required
size and return TSS2_TCTI_RC_INSUFFICIENT_BUFFER error code so that the
application could allocate a bigger buffer and call receive again.
To make it possible in the TSS library, this requires being able to do
partial reads from the driver.
The library would read the 10 bytes header first to get the actual size
of the response from the header, and then read the rest of the response.

This patch adds support for partial reads, i.e. the user can read the
response in one or multiple reads, until the whole response is consumed.
The user can also read only part of the response and ignore
the rest by issuing a new write to send a new command.

Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---
The usecase is implemented in this TSS commit:
https://github.com/tpm2-software/tpm2-tss/commit/ce982f67a67dc08e24683d30b05800648d8a264c

Changes in v3:
 - Remove link to usecase implemented in TSS out of the commit message.
 - Update the conddition in tpm_common_poll() to take into account
   the partial_data also.

Changes in v2:
 - Allow writes after only partial response is consumed to maintain
   backwords compatibility.
---
 drivers/char/tpm/tpm-dev-common.c |   41 ++++++++++++++++++++++++++++---------
 drivers/char/tpm/tpm-dev.h        |    2 ++
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 99b5133a9d05..5d43b0c28565 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -64,6 +64,7 @@ static void tpm_timeout_work(struct work_struct *work)
 
 	mutex_lock(&priv->buffer_mutex);
 	priv->data_pending = 0;
+	priv->partial_data = 0;
 	memset(priv->data_buffer, 0, sizeof(priv->data_buffer));
 	mutex_unlock(&priv->buffer_mutex);
 	wake_up_interruptible(&priv->async_wait);
@@ -90,22 +91,39 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 	ssize_t ret_size = 0;
 	int rc;
 
-	del_singleshot_timer_sync(&priv->user_read_timer);
-	flush_work(&priv->timeout_work);
 	mutex_lock(&priv->buffer_mutex);
+	if (priv->data_pending || priv->partial_data) {
+		if (*off == 0)
+			priv->partial_data = priv->data_pending;
+
+		ret_size = min_t(ssize_t, size, priv->partial_data);
+		if (ret_size <= 0) {
+			ret_size = 0;
+			priv->data_pending = 0;
+			priv->partial_data = 0;
+			goto out;
+		}
 
-	if (priv->data_pending) {
-		ret_size = min_t(ssize_t, size, priv->data_pending);
-		if (ret_size > 0) {
-			rc = copy_to_user(buf, priv->data_buffer, ret_size);
-			memset(priv->data_buffer, 0, priv->data_pending);
-			if (rc)
-				ret_size = -EFAULT;
+		rc = copy_to_user(buf, priv->data_buffer + *off, ret_size);
+		if (rc) {
+			memset(priv->data_buffer, 0, TPM_BUFSIZE);
+			priv->partial_data = 0;
+			ret_size = -EFAULT;
+		} else {
+			memset(priv->data_buffer + *off, 0, ret_size);
+			priv->partial_data -= ret_size;
+			*off += ret_size;
 		}
 
 		priv->data_pending = 0;
 	}
 
+out:
+	if (!priv->partial_data) {
+		*off = 0;
+		del_singleshot_timer_sync(&priv->user_read_timer);
+		flush_work(&priv->timeout_work);
+	}
 	mutex_unlock(&priv->buffer_mutex);
 	return ret_size;
 }
@@ -150,6 +168,9 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 		goto out;
 	}
 
+	priv->partial_data = 0;
+	*off = 0;
+
 	/*
 	 * If in nonblocking mode schedule an async job to send
 	 * the command return the size.
@@ -184,7 +205,7 @@ __poll_t tpm_common_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &priv->async_wait, wait);
 
-	if (priv->data_pending)
+	if (priv->data_pending || priv->partial_data)
 		mask = EPOLLIN | EPOLLRDNORM;
 	else
 		mask = EPOLLOUT | EPOLLWRNORM;
diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
index a126b575cb8c..a2ca6a7a06f1 100644
--- a/drivers/char/tpm/tpm-dev.h
+++ b/drivers/char/tpm/tpm-dev.h
@@ -11,6 +11,8 @@ struct file_priv {
 
 	/* Holds the amount of data passed or an error code from async op */
 	ssize_t data_pending;
+	/* For partial reads, holds the reminder of a response */
+	ssize_t partial_data;
 	struct mutex buffer_mutex;
 
 	struct timer_list user_read_timer;      /* user needs to claim result */

