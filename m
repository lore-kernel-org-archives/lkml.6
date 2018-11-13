Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE91C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6FA223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6FA223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbeKNEhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:37:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:30091 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbeKNEg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:36:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 10:37:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,229,1539673200"; 
   d="scan'208";a="107948925"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.77])
  by orsmga001.jf.intel.com with ESMTP; 13 Nov 2018 10:37:33 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 07/17] tpm: encapsulate tpm_dev_transmit()
Date:   Tue, 13 Nov 2018 20:36:06 +0200
Message-Id: <20181113183620.27447-8-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113183620.27447-1-jarkko.sakkinen@linux.intel.com>
References: <20181113183620.27447-1-jarkko.sakkinen@linux.intel.com>
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
---
 drivers/char/tpm/tpm-dev-common.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 99b5133a9d05..cbb0ee30b511 100644
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
 		priv->data_pending = ret;
@@ -78,7 +89,7 @@ void tpm_common_open(struct file *file, struct tpm_chip *chip,
 	mutex_init(&priv->buffer_mutex);
 	timer_setup(&priv->user_read_timer, user_reader_timeout, 0);
 	INIT_WORK(&priv->timeout_work, tpm_timeout_work);
-	INIT_WORK(&priv->async_work, tpm_async_work);
+	INIT_WORK(&priv->async_work, tpm_dev_async_work);
 	init_waitqueue_head(&priv->async_wait);
 	file->private_data = priv;
 }
@@ -163,8 +174,8 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
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

