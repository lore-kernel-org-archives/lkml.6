Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD936C65C22
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 04:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEEA2081F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 04:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEEA2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeKCNTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 09:19:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:7957 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbeKCNTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 09:19:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 21:09:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,458,1534834800"; 
   d="scan'208";a="271027154"
Received: from unknown (HELO localhost) ([10.249.254.143])
  by orsmga005.jf.intel.com with ESMTP; 02 Nov 2018 21:09:15 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 6/6] tpm: move TPM space code out of tpm_transmit()
Date:   Sat,  3 Nov 2018 06:08:20 +0200
Message-Id: <20181103040820.23360-7-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181103040820.23360-1-jarkko.sakkinen@linux.intel.com>
References: <20181103040820.23360-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare and commit TPM space before and after calling tpm_transmit()
instead of doing that inside tpm_transmit(). After this change we can
remove TPM_TRANSMIT_NESTED flag.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-dev-common.c | 31 ++++++++++++++++++++++++++++---
 drivers/char/tpm/tpm-interface.c  | 21 ---------------------
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index cbb0ee30b511..22c7ac819662 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -30,13 +30,38 @@ static DEFINE_MUTEX(tpm_dev_wq_lock);
 static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
 				u8 *buf, size_t bufsiz)
 {
-	ssize_t ret;
+	struct tpm_output_header *header = (void *)buf;
+	ssize_t ret, len;
 
 	mutex_lock(&chip->tpm_mutex);
-	ret = tpm_transmit(chip, space, buf, bufsiz, TPM_TRANSMIT_UNLOCKED);
+	ret = tpm2_prepare_space(chip, space, buf, bufsiz);
+	/* If the command is not implemented by the TPM, synthesize a
+	 * response with a TPM2_RC_COMMAND_CODE return for user-space.
+	 */
+	if (ret == -EOPNOTSUPP) {
+		header->length = cpu_to_be32(sizeof(*header));
+		header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
+		header->return_code = cpu_to_be32(TPM2_RC_COMMAND_CODE |
+						  TSS2_RESMGR_TPM_RC_LAYER);
+		ret = sizeof(*header);
+		goto out;
+	}
+	if (ret)
+		goto out;
+
+	len = tpm_transmit(chip, space, buf, bufsiz, TPM_TRANSMIT_UNLOCKED);
+	if (len < 0) {
+		ret = len;
+		goto out;
+	}
+
+	ret = tpm2_commit_space(chip, space, buf, &len);
+out:
 	mutex_unlock(&chip->tpm_mutex);
+	if (ret)
+		return ret;
 
-	return ret;
+	return len;
 }
 
 static void tpm_dev_async_work(struct work_struct *work)
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index dcdf2436ae44..cb21880d957c 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -147,21 +147,6 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 		return -E2BIG;
 	}
 
-	rc = tpm2_prepare_space(chip, space, buf, bufsiz);
-	/*
-	 * If the command is not implemented by the TPM, synthesize a
-	 * response with a TPM2_RC_COMMAND_CODE return for user-space.
-	 */
-	if (rc == -EOPNOTSUPP) {
-		header->length = cpu_to_be32(sizeof(*header));
-		header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
-		header->return_code = cpu_to_be32(TPM2_RC_COMMAND_CODE |
-						  TSS2_RESMGR_TPM_RC_LAYER);
-		return sizeof(*header);
-	}
-	if (rc)
-		return rc;
-
 	rc = chip->ops->send(chip, buf, count);
 	if (rc < 0) {
 		if (rc != -EPIPE)
@@ -202,12 +187,6 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 	if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
 		return -EFAULT;
 
-	rc = tpm2_commit_space(chip, space, buf, &len);
-	if (rc) {
-		dev_err(&chip->dev, "%s: commit error %d\n", __func__, rc);
-		return rc;
-	}
-
 	return len;
 }
 
-- 
2.19.1

