Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81E2C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0252175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfBEWtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:49:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:54188 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730703AbfBEWt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:49:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 14:49:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,337,1544515200"; 
   d="scan'208";a="113982336"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.171])
  by orsmga006.jf.intel.com with ESMTP; 05 Feb 2019 14:49:20 -0800
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
Subject: [PATCH v11 16/16] tpm: remove @flags from tpm_transmit()
Date:   Wed,  6 Feb 2019 00:47:23 +0200
Message-Id: <20190205224723.19671-17-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove @flags from tpm_transmit() API. It is no longer used for
anything.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-chip.c       | 32 ++++++++++-----------
 drivers/char/tpm/tpm-dev-common.c |  2 +-
 drivers/char/tpm/tpm-interface.c  | 18 ++++--------
 drivers/char/tpm/tpm-sysfs.c      |  2 +-
 drivers/char/tpm/tpm.h            | 13 ++++-----
 drivers/char/tpm/tpm1-cmd.c       | 14 ++++-----
 drivers/char/tpm/tpm2-cmd.c       | 48 ++++++++++++++-----------------
 drivers/char/tpm/tpm2-space.c     | 16 +++++------
 drivers/char/tpm/tpm_vtpm_proxy.c |  2 +-
 9 files changed, 65 insertions(+), 82 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 7ad4d9045e4c..2019635d0f70 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -37,7 +37,7 @@ struct class *tpm_class;
 struct class *tpmrm_class;
 dev_t tpm_devt;
 
-static int tpm_request_locality(struct tpm_chip *chip, unsigned int flags)
+static int tpm_request_locality(struct tpm_chip *chip)
 {
 	int rc;
 
@@ -52,7 +52,7 @@ static int tpm_request_locality(struct tpm_chip *chip, unsigned int flags)
 	return 0;
 }
 
-static void tpm_relinquish_locality(struct tpm_chip *chip, unsigned int flags)
+static void tpm_relinquish_locality(struct tpm_chip *chip)
 {
 	int rc;
 
@@ -66,7 +66,7 @@ static void tpm_relinquish_locality(struct tpm_chip *chip, unsigned int flags)
 	chip->locality = -1;
 }
 
-static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)
+static int tpm_cmd_ready(struct tpm_chip *chip)
 {
 	if (!chip->ops->cmd_ready)
 		return 0;
@@ -74,7 +74,7 @@ static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)
 	return chip->ops->cmd_ready(chip);
 }
 
-static int tpm_go_idle(struct tpm_chip *chip, unsigned int flags)
+static int tpm_go_idle(struct tpm_chip *chip)
 {
 	if (!chip->ops->go_idle)
 		return 0;
@@ -85,13 +85,12 @@ static int tpm_go_idle(struct tpm_chip *chip, unsigned int flags)
 /**
  * tpm_chip_start() - power on the TPM
  * @chip:	a TPM chip to use
- * @flags:	TPM transmit flags
  *
  * Return:
  * * The response length	- OK
  * * -errno			- A system error
  */
-int tpm_chip_start(struct tpm_chip *chip, unsigned int flags)
+int tpm_chip_start(struct tpm_chip *chip)
 {
 	int ret;
 
@@ -99,16 +98,16 @@ int tpm_chip_start(struct tpm_chip *chip, unsigned int flags)
 		chip->ops->clk_enable(chip, true);
 
 	if (chip->locality == -1) {
-		ret = tpm_request_locality(chip, flags);
+		ret = tpm_request_locality(chip);
 		if (ret) {
 			chip->ops->clk_enable(chip, false);
 			return ret;
 		}
 	}
 
-	ret = tpm_cmd_ready(chip, flags);
+	ret = tpm_cmd_ready(chip);
 	if (ret) {
-		tpm_relinquish_locality(chip, flags);
+		tpm_relinquish_locality(chip);
 		if (chip->ops->clk_enable)
 			chip->ops->clk_enable(chip, false);
 		return ret;
@@ -120,16 +119,15 @@ int tpm_chip_start(struct tpm_chip *chip, unsigned int flags)
 /**
  * tpm_chip_stop() - power off the TPM
  * @chip:	a TPM chip to use
- * @flags:	TPM transmit flags
  *
  * Return:
  * * The response length	- OK
  * * -errno			- A system error
  */
-void tpm_chip_stop(struct tpm_chip *chip, unsigned int flags)
+void tpm_chip_stop(struct tpm_chip *chip)
 {
-	tpm_go_idle(chip, flags);
-	tpm_relinquish_locality(chip, flags);
+	tpm_go_idle(chip);
+	tpm_relinquish_locality(chip);
 	if (chip->ops->clk_enable)
 		chip->ops->clk_enable(chip, false);
 }
@@ -157,7 +155,7 @@ int tpm_try_get_ops(struct tpm_chip *chip)
 		goto out_ops;
 
 	mutex_lock(&chip->tpm_mutex);
-	rc = tpm_chip_start(chip, 0);
+	rc = tpm_chip_start(chip);
 	if (rc)
 		goto out_lock;
 
@@ -180,7 +178,7 @@ EXPORT_SYMBOL_GPL(tpm_try_get_ops);
  */
 void tpm_put_ops(struct tpm_chip *chip)
 {
-	tpm_chip_stop(chip, 0);
+	tpm_chip_stop(chip);
 	mutex_unlock(&chip->tpm_mutex);
 	up_read(&chip->ops_sem);
 	put_device(&chip->dev);
@@ -558,11 +556,11 @@ int tpm_chip_register(struct tpm_chip *chip)
 {
 	int rc;
 
-	rc = tpm_chip_start(chip, 0);
+	rc = tpm_chip_start(chip);
 	if (rc)
 		return rc;
 	rc = tpm_auto_startup(chip);
-	tpm_chip_stop(chip, 0);
+	tpm_chip_stop(chip);
 	if (rc)
 		return rc;
 
diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 435c09ec9056..8856cce5a23b 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -47,7 +47,7 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	if (ret)
 		goto out_rc;
 
-	len = tpm_transmit(chip, buf, bufsiz, 0);
+	len = tpm_transmit(chip, buf, bufsiz);
 	if (len < 0)
 		ret = len;
 
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index f20c78055731..ce39fe043bcb 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -62,8 +62,7 @@ unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
 
-static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz,
-				unsigned int flags)
+static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 {
 	struct tpm_header *header = buf;
 	int rc;
@@ -134,7 +133,6 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz,
  * @chip:	a TPM chip to use
  * @buf:	a TPM command buffer
  * @bufsiz:	length of the TPM command buffer
- * @flags:	TPM transmit flags
  *
  * A wrapper around tpm_try_transmit() that handles TPM2_RC_RETRY returns from
  * the TPM and retransmits the command after a delay up to a maximum wait of
@@ -147,8 +145,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz,
  * * The response length	- OK
  * * -errno			- A system error
  */
-ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
-		     unsigned int flags)
+ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
 {
 	struct tpm_header *header = (struct tpm_header *)buf;
 	/* space for header and handles */
@@ -168,7 +165,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 	memcpy(save, buf, save_size);
 
 	for (;;) {
-		ret = tpm_try_transmit(chip, buf, bufsiz, flags);
+		ret = tpm_try_transmit(chip, buf, bufsiz);
 		if (ret < 0)
 			break;
 		rc = be32_to_cpu(header->return_code);
@@ -201,7 +198,6 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
  * @chip:			a TPM chip to use
  * @buf:			a TPM command buffer
  * @min_rsp_body_length:	minimum expected length of response body
- * @flags:			TPM transmit flags
  * @desc:			command description used in the error message
  *
  * Return:
@@ -210,14 +206,13 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
  * * TPM_RC	- A TPM error
  */
 ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
-			 size_t min_rsp_body_length, unsigned int flags,
-			 const char *desc)
+			 size_t min_rsp_body_length, const char *desc)
 {
 	const struct tpm_header *header = (struct tpm_header *)buf->data;
 	int err;
 	ssize_t len;
 
-	len = tpm_transmit(chip, buf->data, PAGE_SIZE, flags);
+	len = tpm_transmit(chip, buf->data, PAGE_SIZE);
 	if (len <  0)
 		return len;
 
@@ -366,8 +361,7 @@ int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
 		goto out;
 
 	memcpy(buf.data, cmd, buflen);
-	rc = tpm_transmit_cmd(chip, &buf, 0, 0,
-			      "attempting to a send a command");
+	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to a send a command");
 	tpm_buf_destroy(&buf);
 out:
 	tpm_put_ops(chip);
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 3733491671ca..533a260d744e 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -55,7 +55,7 @@ static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
 	tpm_buf_append(&tpm_buf, anti_replay, sizeof(anti_replay));
 
 	if (tpm_transmit_cmd(chip, &tpm_buf, READ_PUBEK_RESULT_MIN_BODY_SIZE,
-			      0, "attempting to read the PUBEK"))
+			     "attempting to read the PUBEK"))
 		goto out_buf;
 
 	out = (struct tpm_readpubek_out *)&tpm_buf.data[10];
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 53e4208759ee..183e2b93e0fe 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -485,11 +485,9 @@ extern const struct file_operations tpm_fops;
 extern const struct file_operations tpmrm_fops;
 extern struct idr dev_nums_idr;
 
-ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
-		     unsigned int flags);
+ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz);
 ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
-			 size_t min_rsp_body_length, unsigned int flags,
-			 const char *desc);
+			 size_t min_rsp_body_length, const char *desc);
 int tpm_get_timeouts(struct tpm_chip *);
 int tpm_auto_startup(struct tpm_chip *chip);
 
@@ -514,8 +512,8 @@ static inline void tpm_msleep(unsigned int delay_msec)
 		     delay_msec * 1000);
 };
 
-int tpm_chip_start(struct tpm_chip *chip, unsigned int flags);
-void tpm_chip_stop(struct tpm_chip *chip, unsigned int flags);
+int tpm_chip_start(struct tpm_chip *chip);
+void tpm_chip_stop(struct tpm_chip *chip);
 struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
 __must_check int tpm_try_get_ops(struct tpm_chip *chip);
 void tpm_put_ops(struct tpm_chip *chip);
@@ -548,8 +546,7 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 		    struct tpm2_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
-void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
-			    unsigned int flags);
+void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
 int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_payload *payload,
 		      struct trusted_key_options *options);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 5b5f8bcc6210..ec5f3693c096 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -334,7 +334,7 @@ static int tpm1_startup(struct tpm_chip *chip)
 
 	tpm_buf_append_u16(&buf, TPM_ST_CLEAR);
 
-	rc = tpm_transmit_cmd(chip, &buf, 0, 0, "attempting to start the TPM");
+	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to start the TPM");
 	tpm_buf_destroy(&buf);
 	return rc;
 }
@@ -458,7 +458,7 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 	tpm_buf_append_u32(&buf, pcr_idx);
 	tpm_buf_append(&buf, hash, TPM_DIGEST_SIZE);
 
-	rc = tpm_transmit_cmd(chip, &buf, TPM_DIGEST_SIZE, 0, log_msg);
+	rc = tpm_transmit_cmd(chip, &buf, TPM_DIGEST_SIZE, log_msg);
 	tpm_buf_destroy(&buf);
 	return rc;
 }
@@ -488,7 +488,7 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		tpm_buf_append_u32(&buf, 4);
 		tpm_buf_append_u32(&buf, subcap_id);
 	}
-	rc = tpm_transmit_cmd(chip, &buf, min_cap_length, 0, desc);
+	rc = tpm_transmit_cmd(chip, &buf, min_cap_length, desc);
 	if (!rc)
 		*cap = *(cap_t *)&buf.data[TPM_HEADER_SIZE + 4];
 	tpm_buf_destroy(&buf);
@@ -529,7 +529,7 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	do {
 		tpm_buf_append_u32(&buf, num_bytes);
 
-		rc = tpm_transmit_cmd(chip, &buf, sizeof(out->rng_data_len), 0,
+		rc = tpm_transmit_cmd(chip, &buf, sizeof(out->rng_data_len),
 				      "attempting get random");
 		if (rc)
 			goto out;
@@ -574,7 +574,7 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 
 	tpm_buf_append_u32(&buf, pcr_idx);
 
-	rc = tpm_transmit_cmd(chip, &buf, TPM_DIGEST_SIZE, 0,
+	rc = tpm_transmit_cmd(chip, &buf, TPM_DIGEST_SIZE,
 			      "attempting to read a pcr value");
 	if (rc)
 		goto out;
@@ -608,7 +608,7 @@ static int tpm1_continue_selftest(struct tpm_chip *chip)
 	if (rc)
 		return rc;
 
-	rc = tpm_transmit_cmd(chip, &buf, 0, 0, "continue selftest");
+	rc = tpm_transmit_cmd(chip, &buf, 0, "continue selftest");
 	tpm_buf_destroy(&buf);
 	return rc;
 }
@@ -734,7 +734,7 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 		return rc;
 	/* now do the actual savestate */
 	for (try = 0; try < TPM_RETRY; try++) {
-		rc = tpm_transmit_cmd(chip, &buf, 0, 0, NULL);
+		rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
 		/*
 		 * If the TPM indicates that it is too busy to respond to
 		 * this command then retry before giving up.  It can take
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index d6abc964ef66..971d46efaca5 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -197,7 +197,7 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 	tpm_buf_append(&buf, (const unsigned char *)pcr_select,
 		       sizeof(pcr_select));
 
-	rc = tpm_transmit_cmd(chip, &buf, 0, 0, res_buf ?
+	rc = tpm_transmit_cmd(chip, &buf, 0, res_buf ?
 			      "attempting to read a pcr value" : NULL);
 	if (rc == 0 && res_buf) {
 		out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
@@ -264,8 +264,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 		}
 	}
 
-	rc = tpm_transmit_cmd(chip, &buf, 0, 0,
-			      "attempting extend a PCR value");
+	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value");
 
 	tpm_buf_destroy(&buf);
 
@@ -312,7 +311,7 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 		err = tpm_transmit_cmd(chip, &buf,
 				       offsetof(struct tpm2_get_random_out,
 						buffer),
-				       0, "attempting get random");
+				       "attempting get random");
 		if (err)
 			goto out;
 
@@ -341,14 +340,11 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 }
 
 /**
- * tpm2_flush_context_cmd() - execute a TPM2_FlushContext command
+ * tpm2_flush_context() - execute a TPM2_FlushContext command
  * @chip:	TPM chip to use
  * @handle:	context handle
- * @flags:	tpm transmit flags - bitmap
- *
  */
-void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
-			    unsigned int flags)
+void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 {
 	struct tpm_buf buf;
 	int rc;
@@ -362,7 +358,7 @@ void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
 
 	tpm_buf_append_u32(&buf, handle);
 
-	tpm_transmit_cmd(chip, &buf, 0, flags, "flushing context");
+	tpm_transmit_cmd(chip, &buf, 0, "flushing context");
 	tpm_buf_destroy(&buf);
 }
 
@@ -476,7 +472,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 	}
 
-	rc = tpm_transmit_cmd(chip, &buf, 4, 0, "sealing data");
+	rc = tpm_transmit_cmd(chip, &buf, 4, "sealing data");
 	if (rc)
 		goto out;
 
@@ -513,7 +509,6 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
  * @payload: the key data in clear and encrypted form
  * @options: authentication values and other options
  * @blob_handle: returned blob handle
- * @flags: tpm transmit flags
  *
  * Return: 0 on success.
  *        -E2BIG on wrong payload size.
@@ -523,7 +518,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 static int tpm2_load_cmd(struct tpm_chip *chip,
 			 struct trusted_key_payload *payload,
 			 struct trusted_key_options *options,
-			 u32 *blob_handle, unsigned int flags)
+			 u32 *blob_handle)
 {
 	struct tpm_buf buf;
 	unsigned int private_len;
@@ -558,7 +553,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		goto out;
 	}
 
-	rc = tpm_transmit_cmd(chip, &buf, 4, flags, "loading blob");
+	rc = tpm_transmit_cmd(chip, &buf, 4, "loading blob");
 	if (!rc)
 		*blob_handle = be32_to_cpup(
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
@@ -579,7 +574,6 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
  * @payload: the key data in clear and encrypted form
  * @options: authentication values and other options
  * @blob_handle: blob handle
- * @flags: tpm_transmit_cmd flags
  *
  * Return: 0 on success
  *         -EPERM on tpm error status
@@ -588,7 +582,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			   struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
-			   u32 blob_handle, unsigned int flags)
+			   u32 blob_handle)
 {
 	struct tpm_buf buf;
 	u16 data_len;
@@ -608,7 +602,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			     options->blobauth /* hmac */,
 			     TPM_DIGEST_SIZE);
 
-	rc = tpm_transmit_cmd(chip, &buf, 6, flags, "unsealing");
+	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
 	if (rc > 0)
 		rc = -EPERM;
 
@@ -652,12 +646,12 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 	u32 blob_handle;
 	int rc;
 
-	rc = tpm2_load_cmd(chip, payload, options, &blob_handle, 0);
+	rc = tpm2_load_cmd(chip, payload, options, &blob_handle);
 	if (rc)
 		return rc;
 
-	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle, 0);
-	tpm2_flush_context_cmd(chip, blob_handle, 0);
+	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle);
+	tpm2_flush_context(chip, blob_handle);
 	return rc;
 }
 
@@ -693,7 +687,7 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
 	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
 	tpm_buf_append_u32(&buf, property_id);
 	tpm_buf_append_u32(&buf, 1);
-	rc = tpm_transmit_cmd(chip, &buf, 0, 0, NULL);
+	rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
 	if (!rc) {
 		out = (struct tpm2_get_cap_out *)
 			&buf.data[TPM_HEADER_SIZE];
@@ -723,7 +717,7 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
 	if (rc)
 		return;
 	tpm_buf_append_u16(&buf, shutdown_type);
-	tpm_transmit_cmd(chip, &buf, 0, 0, "stopping the TPM");
+	tpm_transmit_cmd(chip, &buf, 0, "stopping the TPM");
 	tpm_buf_destroy(&buf);
 }
 
@@ -752,7 +746,7 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
 			return rc;
 
 		tpm_buf_append_u8(&buf, full);
-		rc = tpm_transmit_cmd(chip, &buf, 0, 0,
+		rc = tpm_transmit_cmd(chip, &buf, 0,
 				      "attempting the self test");
 		tpm_buf_destroy(&buf);
 
@@ -789,7 +783,7 @@ int tpm2_probe(struct tpm_chip *chip)
 	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
 	tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
 	tpm_buf_append_u32(&buf, 1);
-	rc = tpm_transmit_cmd(chip, &buf, 0, 0, NULL);
+	rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
 	/* We ignore TPM return codes on purpose. */
 	if (rc >=  0) {
 		out = (struct tpm_header *)buf.data;
@@ -828,7 +822,7 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	tpm_buf_append_u32(&buf, 0);
 	tpm_buf_append_u32(&buf, 1);
 
-	rc = tpm_transmit_cmd(chip, &buf, 9, 0, "get tpm pcr allocation");
+	rc = tpm_transmit_cmd(chip, &buf, 9, "get tpm pcr allocation");
 	if (rc)
 		goto out;
 
@@ -899,7 +893,7 @@ static int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 	tpm_buf_append_u32(&buf, TPM2_CC_FIRST);
 	tpm_buf_append_u32(&buf, nr_commands);
 
-	rc = tpm_transmit_cmd(chip, &buf, 9 + 4 * nr_commands, 0, NULL);
+	rc = tpm_transmit_cmd(chip, &buf, 9 + 4 * nr_commands, NULL);
 	if (rc) {
 		tpm_buf_destroy(&buf);
 		goto out;
@@ -956,7 +950,7 @@ static int tpm2_startup(struct tpm_chip *chip)
 		return rc;
 
 	tpm_buf_append_u16(&buf, TPM2_SU_CLEAR);
-	rc = tpm_transmit_cmd(chip, &buf, 0, 0, "attempting to start the TPM");
+	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to start the TPM");
 	tpm_buf_destroy(&buf);
 
 	return rc;
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 6c6ad2d4d31b..a9ced49546ad 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -38,7 +38,7 @@ static void tpm2_flush_sessions(struct tpm_chip *chip, struct tpm_space *space)
 
 	for (i = 0; i < ARRAY_SIZE(space->session_tbl); i++) {
 		if (space->session_tbl[i])
-			tpm2_flush_context_cmd(chip, space->session_tbl[i], 0);
+			tpm2_flush_context(chip, space->session_tbl[i]);
 	}
 }
 
@@ -60,9 +60,9 @@ int tpm2_init_space(struct tpm_space *space)
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
 {
 	mutex_lock(&chip->tpm_mutex);
-	if (!tpm_chip_start(chip, 0)) {
+	if (!tpm_chip_start(chip)) {
 		tpm2_flush_sessions(chip, space);
-		tpm_chip_stop(chip, 0);
+		tpm_chip_stop(chip);
 	}
 	mutex_unlock(&chip->tpm_mutex);
 	kfree(space->context_buf);
@@ -85,7 +85,7 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 	body_size = sizeof(*ctx) + be16_to_cpu(ctx->blob_size);
 	tpm_buf_append(&tbuf, &buf[*offset], body_size);
 
-	rc = tpm_transmit_cmd(chip, &tbuf, 4, 0, NULL);
+	rc = tpm_transmit_cmd(chip, &tbuf, 4, NULL);
 	if (rc < 0) {
 		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
 			 __func__, rc);
@@ -133,7 +133,7 @@ static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
 
 	tpm_buf_append_u32(&tbuf, handle);
 
-	rc = tpm_transmit_cmd(chip, &tbuf, 0, 0, NULL);
+	rc = tpm_transmit_cmd(chip, &tbuf, 0, NULL);
 	if (rc < 0) {
 		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
 			 __func__, rc);
@@ -169,7 +169,7 @@ void tpm2_flush_space(struct tpm_chip *chip)
 
 	for (i = 0; i < ARRAY_SIZE(space->context_tbl); i++)
 		if (space->context_tbl[i] && ~space->context_tbl[i])
-			tpm2_flush_context_cmd(chip, space->context_tbl[i], 0);
+			tpm2_flush_context(chip, space->context_tbl[i]);
 
 	tpm2_flush_sessions(chip, space);
 }
@@ -418,7 +418,7 @@ static int tpm2_map_response_header(struct tpm_chip *chip, u32 cc, u8 *rsp,
 
 	return 0;
 out_no_slots:
-	tpm2_flush_context_cmd(chip, phandle, 0);
+	tpm2_flush_context(chip, phandle);
 	dev_warn(&chip->dev, "%s: out of slots for 0x%08X\n", __func__,
 		 phandle);
 	return -ENOMEM;
@@ -505,7 +505,7 @@ static int tpm2_save_space(struct tpm_chip *chip)
 		} else if (rc)
 			return rc;
 
-		tpm2_flush_context_cmd(chip, space->context_tbl[i], 0);
+		tpm2_flush_context(chip, space->context_tbl[i]);
 		space->context_tbl[i] = ~0;
 	}
 
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index a4bb60e163cc..26a2be555288 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -417,7 +417,7 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 
 	proxy_dev->state |= STATE_DRIVER_COMMAND;
 
-	rc = tpm_transmit_cmd(chip, &buf, 0, 0, "attempting to set locality");
+	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to set locality");
 
 	proxy_dev->state &= ~STATE_DRIVER_COMMAND;
 
-- 
2.19.1

