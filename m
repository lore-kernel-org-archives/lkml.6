Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2427C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787BD2175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfBEWs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:48:27 -0500
Received: from mga06.intel.com ([134.134.136.31]:62932 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729902AbfBEWsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:48:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 14:48:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,337,1544515200"; 
   d="scan'208";a="113982181"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.171])
  by orsmga006.jf.intel.com with ESMTP; 05 Feb 2019 14:48:17 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v11 07/16] tpm: encapsulate tpm_dev_transmit()
Date:   Wed,  6 Feb 2019 00:47:14 +0200
Message-Id: <20190205224723.19671-8-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Encapsulate tpm_transmit() call pattern to tpm_dev_transmit() because it
is identically used from two places. Use unlocked version of
tpm_transmit() so that we are able to move the calls to
tpm2_prepare_space() and tpm2_commit_space() later on to this new
function.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-dev-common.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 5eecad233ea1..759796953d84 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -27,7 +27,19 @@
 static struct workqueue_struct *tpm_dev_wq;
 static DEFINE_MUTEX(tpm_dev_wq_lock);
 
-static void tpm_async_work(struct work_struct *work)
+static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
+				u8 *buf, size_t bufsiz)
+{
+	ssize_t ret;
+
+	mutex_lock(&chip->tpm_mutex);
+	ret = tpm_transmit(chip, space, buf, bufsiz, TPM_TRANSMIT_UNLOCKED);
+	mutex_unlock(&chip->tpm_mutex);
+
+	return ret;
+}
+
+static void tpm_dev_async_work(struct work_struct *work)
 {
 	struct file_priv *priv =
 			container_of(work, struct file_priv, async_work);
@@ -35,9 +47,8 @@ static void tpm_async_work(struct work_struct *work)
 
 	mutex_lock(&priv->buffer_mutex);
 	priv->command_enqueued = false;
-	ret = tpm_transmit(priv->chip, priv->space, priv->data_buffer,
-			   sizeof(priv->data_buffer), 0);
-
+	ret = tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
+			       sizeof(priv->data_buffer));
 	tpm_put_ops(priv->chip);
 	if (ret > 0) {
 		priv->response_length = ret;
@@ -80,7 +91,7 @@ void tpm_common_open(struct file *file, struct tpm_chip *chip,
 	mutex_init(&priv->buffer_mutex);
 	timer_setup(&priv->user_read_timer, user_reader_timeout, 0);
 	INIT_WORK(&priv->timeout_work, tpm_timeout_work);
-	INIT_WORK(&priv->async_work, tpm_async_work);
+	INIT_WORK(&priv->async_work, tpm_dev_async_work);
 	init_waitqueue_head(&priv->async_wait);
 	file->private_data = priv;
 }
@@ -183,8 +194,8 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 		return size;
 	}
 
-	ret = tpm_transmit(priv->chip, priv->space, priv->data_buffer,
-			   sizeof(priv->data_buffer), 0);
+	ret = tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
+			       sizeof(priv->data_buffer));
 	tpm_put_ops(priv->chip);
 
 	if (ret > 0) {
-- 
2.19.1

