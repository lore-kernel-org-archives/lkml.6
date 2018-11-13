Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAFBC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053592243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053592243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733217AbeKMWZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:25:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:21581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732743AbeKMWZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:25:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 04:27:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="108176636"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.77])
  by orsmga002.jf.intel.com with ESMTP; 13 Nov 2018 04:27:50 -0800
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
Subject: [PATCH v6 11/17] tpm: move TPM space code out of tpm_transmit()
Date:   Tue, 13 Nov 2018 14:26:00 +0200
Message-Id: <20181113122609.21643-12-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113122609.21643-1-jarkko.sakkinen@linux.intel.com>
References: <20181113122609.21643-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare and commit TPM space before and after calling tpm_transmit()
instead of doing that inside tpm_transmit(). After this change we can
remove TPM_TRANSMIT_NESTED flag from tpm2_prepare_space() and
tpm2_commit_space() and replace it with TPM_TRANSMIT_UNLOCKED.

Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-dev-common.c | 30 ++++++++++++++++++++++++++----
 drivers/char/tpm/tpm-interface.c  | 29 +++--------------------------
 drivers/char/tpm/tpm2-space.c     | 12 ++++++------
 3 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index cbb0ee30b511..40c1cb09ebd2 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -30,13 +30,35 @@ static DEFINE_MUTEX(tpm_dev_wq_lock);
 static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
 				u8 *buf, size_t bufsiz)
 {
-	ssize_t ret;
+	struct tpm_header *header = (void *)buf;
+	ssize_t ret, len;
 
 	mutex_lock(&chip->tpm_mutex);
-	ret = tpm_transmit(chip, space, buf, bufsiz, TPM_TRANSMIT_UNLOCKED);
-	mutex_unlock(&chip->tpm_mutex);
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
+	}
+	if (ret)
+		goto out_lock;
 
-	return ret;
+	len = tpm_transmit(chip, space, buf, bufsiz, TPM_TRANSMIT_UNLOCKED);
+	if (len < 0)
+		ret = len;
+
+	if (ret)
+		tpm2_flush_space(chip);
+	else
+		ret = tpm2_commit_space(chip, space, buf, &len);
+out_lock:
+	mutex_unlock(&chip->tpm_mutex);
+	return ret ? ret : len;
 }
 
 static void tpm_dev_async_work(struct work_struct *work)
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index a6ffd0960ae5..7bec03e46043 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -147,27 +147,12 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
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
 			dev_err(&chip->dev,
 				"%s: tpm_send: error %d\n", __func__, rc);
-		goto out_space;
+		return rc;
 	}
 
 	if (chip->flags & TPM_CHIP_FLAG_IRQ)
@@ -182,8 +167,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 
 		if (chip->ops->req_canceled(chip, status)) {
 			dev_err(&chip->dev, "Operation Canceled\n");
-			rc = -ECANCELED;
-			goto out_space;
+			return -ECANCELED;
 		}
 
 		tpm_msleep(TPM_TIMEOUT_POLL);
@@ -192,8 +176,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 
 	chip->ops->cancel(chip);
 	dev_err(&chip->dev, "Operation Timed out\n");
-	rc = -ETIME;
-	goto out_space;
+	return -ETIME;
 
 out_recv:
 	len = chip->ops->recv(chip, buf, bufsiz);
@@ -203,12 +186,6 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 	} else if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
 		rc = -EFAULT;
 
-out_space:
-	if (rc)
-		tpm2_flush_space(chip);
-	else
-		rc = tpm2_commit_space(chip, space, buf, &len);
-
 	return rc ? rc : len;
 }
 
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 172c9f9d4c29..995c8b963d65 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -39,7 +39,7 @@ static void tpm2_flush_sessions(struct tpm_chip *chip, struct tpm_space *space)
 	for (i = 0; i < ARRAY_SIZE(space->session_tbl); i++) {
 		if (space->session_tbl[i])
 			tpm2_flush_context_cmd(chip, space->session_tbl[i],
-					       TPM_TRANSMIT_NESTED);
+					       TPM_TRANSMIT_UNLOCKED);
 	}
 }
 
@@ -84,7 +84,7 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 	tpm_buf_append(&tbuf, &buf[*offset], body_size);
 
 	rc = tpm_transmit_cmd(chip, NULL, &tbuf, 4,
-			      TPM_TRANSMIT_NESTED, NULL);
+			      TPM_TRANSMIT_UNLOCKED, NULL);
 	if (rc < 0) {
 		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
 			 __func__, rc);
@@ -133,7 +133,7 @@ static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
 	tpm_buf_append_u32(&tbuf, handle);
 
 	rc = tpm_transmit_cmd(chip, NULL, &tbuf, 0,
-			      TPM_TRANSMIT_NESTED, NULL);
+			      TPM_TRANSMIT_UNLOCKED, NULL);
 	if (rc < 0) {
 		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
 			 __func__, rc);
@@ -170,7 +170,7 @@ void tpm2_flush_space(struct tpm_chip *chip)
 	for (i = 0; i < ARRAY_SIZE(space->context_tbl); i++)
 		if (space->context_tbl[i] && ~space->context_tbl[i])
 			tpm2_flush_context_cmd(chip, space->context_tbl[i],
-					       TPM_TRANSMIT_NESTED);
+					       TPM_TRANSMIT_UNLOCKED);
 
 	tpm2_flush_sessions(chip, space);
 }
@@ -419,7 +419,7 @@ static int tpm2_map_response_header(struct tpm_chip *chip, u32 cc, u8 *rsp,
 
 	return 0;
 out_no_slots:
-	tpm2_flush_context_cmd(chip, phandle, TPM_TRANSMIT_NESTED);
+	tpm2_flush_context_cmd(chip, phandle, TPM_TRANSMIT_UNLOCKED);
 	dev_warn(&chip->dev, "%s: out of slots for 0x%08X\n", __func__,
 		 phandle);
 	return -ENOMEM;
@@ -507,7 +507,7 @@ static int tpm2_save_space(struct tpm_chip *chip)
 			return rc;
 
 		tpm2_flush_context_cmd(chip, space->context_tbl[i],
-				       TPM_TRANSMIT_NESTED);
+				       TPM_TRANSMIT_UNLOCKED);
 		space->context_tbl[i] = ~0;
 	}
 
-- 
2.19.1

