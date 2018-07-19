Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3EAC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1E72084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1E72084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbeGSQgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:36:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:28092 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeGSQgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:36:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 08:52:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,375,1526367600"; 
   d="scan'208";a="57808984"
Received: from mldahl-mobl2.amr.corp.intel.com (HELO tstruk-mobl1.jf.intel.com) ([10.254.107.75])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2018 08:52:33 -0700
Subject: [PATCH] tpm: add support for partial reads
From:   Tadeusz Struk <tadeusz.struk@intel.com>
To:     jarkko.sakkinen@linux.intel.com
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tadeusz.struk@intel.com
Date:   Thu, 19 Jul 2018 08:52:32 -0700
Message-ID: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently to read a response from the TPM device an application needs
provide "big enough" buffer for the whole response and read it in one go.
The application doesn't know how big the response it beforehand so it
always needs to maintain a 4K buffer and read the max (4K).
In case if the user of the TSS library doesn't provide big enough buffer
the TCTI spec says that the library should set the required size and return
TSS2_TCTI_RC_INSUFFICIENT_BUFFER error code so that the application could
allocate a bigger buffer and call receive again.
To make it possible in the TSS library this requires being able to do
partial reads from the driver.
The library would read the header first to get the actual size of the
response from the header and then read the rest of the response.
This patch adds support for partial reads.

The usecase is implemented in this TSS commit:
https://github.com/tpm2-software/tpm2-tss/commit/ce982f67a67dc08e24683d30b05800648d8a264c

Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---
 drivers/char/tpm/tpm-dev-common.c |   32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 3f2089f75c30..f5b614984dbc 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -99,20 +99,34 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 	ssize_t ret_size = 0;
 	int rc;
 
-	del_singleshot_timer_sync(&priv->user_read_timer);
-	flush_work(&priv->timeout_work);
 	mutex_lock(&priv->buffer_mutex);
 
 	if (priv->data_pending) {
-		ret_size = min_t(ssize_t, size, priv->data_pending);
-		if (ret_size > 0) {
-			rc = copy_to_user(buf, priv->data_buffer, ret_size);
-			memset(priv->data_buffer, 0, priv->data_pending);
-			if (rc)
-				ret_size = -EFAULT;
+		ret_size = min_t(ssize_t, size + *off, priv->data_pending);
+		if (ret_size <= 0) {
+			ret_size = 0;
+			priv->data_pending = 0;
+			*off = 0;
+			goto out;
 		}
 
-		priv->data_pending = 0;
+		rc = copy_to_user(buf, priv->data_buffer + *off, ret_size);
+		if (rc) {
+			memset(priv->data_buffer, 0, priv->data_pending);
+			ret_size = -EFAULT;
+			priv->data_pending = 0;
+			*off = 0;
+		} else {
+			memset(priv->data_buffer + *off, 0, ret_size);
+			priv->data_pending -= ret_size;
+			*off += ret_size;
+		}
+	}
+out:
+	if (!priv->data_pending) {
+		del_singleshot_timer_sync(&priv->user_read_timer);
+		flush_work(&priv->timeout_work);
+		*off = 0;
 	}
 
 	mutex_unlock(&priv->buffer_mutex);

