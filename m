Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20827C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE042175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfBEWro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:47:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:58100 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbfBEWrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:47:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 14:47:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,337,1544515200"; 
   d="scan'208";a="113982067"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.171])
  by orsmga006.jf.intel.com with ESMTP; 05 Feb 2019 14:47:35 -0800
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
Subject: [PATCH v11 01/16] tpm: use tpm_buf in tpm_transmit_cmd() as the IO parameter
Date:   Wed,  6 Feb 2019 00:47:08 +0200
Message-Id: <20190205224723.19671-2-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we pass an initialized struct tpm_buf instance in every call site
now, it is cleaner to pass that directly to the tpm_transmit_cmd() as
the TPM command/response buffer.

Fine-tune a little bit tpm_transmit() and tpm_transmit_cmd() comments
while doing this.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-interface.c  | 67 +++++++++++++++++--------------
 drivers/char/tpm/tpm-sysfs.c      |  2 +-
 drivers/char/tpm/tpm.h            |  5 +--
 drivers/char/tpm/tpm1-cmd.c       | 26 ++++--------
 drivers/char/tpm/tpm2-cmd.c       | 37 +++++++----------
 drivers/char/tpm/tpm2-space.c     |  4 +-
 drivers/char/tpm/tpm_vtpm_proxy.c |  3 +-
 7 files changed, 64 insertions(+), 80 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 6339a2e289ae..5ef5c1e6947d 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -298,23 +298,22 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 
 /**
  * tpm_transmit - Internal kernel interface to transmit TPM commands.
+ * @chip:	a TPM chip to use
+ * @space:	a TPM space
+ * @buf:	a TPM command buffer
+ * @bufsiz:	length of the TPM command buffer
+ * @flags:	TPM transmit flags
  *
- * @chip: TPM chip to use
- * @space: tpm space
- * @buf: TPM command buffer
- * @bufsiz: length of the TPM command buffer
- * @flags: tpm transmit flags - bitmap
+ * A wrapper around tpm_try_transmit() that handles TPM2_RC_RETRY returns from
+ * the TPM and retransmits the command after a delay up to a maximum wait of
+ * TPM2_DURATION_LONG.
  *
- * A wrapper around tpm_try_transmit that handles TPM2_RC_RETRY
- * returns from the TPM and retransmits the command after a delay up
- * to a maximum wait of TPM2_DURATION_LONG.
- *
- * Note: TPM1 never returns TPM2_RC_RETRY so the retry logic is TPM2
- * only
+ * Note that TPM 1.x never returns TPM2_RC_RETRY so the retry logic is TPM 2.0
+ * only.
  *
  * Return:
- *     the length of the return when the operation is successful.
- *     A negative number for system errors (errno).
+ * * The response length	- OK
+ * * -errno			- A system error
  */
 ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 		     u8 *buf, size_t bufsiz, unsigned int flags)
@@ -365,33 +364,31 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	}
 	return ret;
 }
+
 /**
  * tpm_transmit_cmd - send a tpm command to the device
- *    The function extracts tpm out header return code
- *
- * @chip: TPM chip to use
- * @space: tpm space
- * @buf: TPM command buffer
- * @bufsiz: length of the buffer
- * @min_rsp_body_length: minimum expected length of response body
- * @flags: tpm transmit flags - bitmap
- * @desc: command description used in the error message
+ * @chip:			a TPM chip to use
+ * @space:			a TPM space
+ * @buf:			a TPM command buffer
+ * @min_rsp_body_length:	minimum expected length of response body
+ * @flags:			TPM transmit flags
+ * @desc:			command description used in the error message
  *
  * Return:
- *     0 when the operation is successful.
- *     A negative number for system errors (errno).
- *     A positive number for a TPM error.
+ * * 0		- OK
+ * * -errno	- A system error
+ * * TPM_RC	- A TPM error
  */
 ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
-			 void *buf, size_t bufsiz,
-			 size_t min_rsp_body_length, unsigned int flags,
-			 const char *desc)
+			 struct tpm_buf *buf, size_t min_rsp_body_length,
+			 unsigned int flags, const char *desc)
 {
-	const struct tpm_output_header *header = buf;
+	const struct tpm_output_header *header =
+		(struct tpm_output_header *)buf->data;
 	int err;
 	ssize_t len;
 
-	len = tpm_transmit(chip, space, buf, bufsiz, flags);
+	len = tpm_transmit(chip, space, buf->data, PAGE_SIZE, flags);
 	if (len <  0)
 		return len;
 
@@ -528,14 +525,22 @@ EXPORT_SYMBOL_GPL(tpm_pcr_extend);
  */
 int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
 {
+	struct tpm_buf buf;
 	int rc;
 
 	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
-	rc = tpm_transmit_cmd(chip, NULL, cmd, buflen, 0, 0,
+	rc = tpm_buf_init(&buf, 0, 0);
+	if (rc)
+		goto out;
+
+	memcpy(buf.data, cmd, buflen);
+	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0,
 			      "attempting to a send a command");
+	tpm_buf_destroy(&buf);
+out:
 	tpm_put_ops(chip);
 	return rc;
 }
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index b88e08ec2c59..c2769e55cb6c 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -53,7 +53,7 @@ static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
 
 	tpm_buf_append(&tpm_buf, anti_replay, sizeof(anti_replay));
 
-	rc = tpm_transmit_cmd(chip, NULL, tpm_buf.data, PAGE_SIZE,
+	rc = tpm_transmit_cmd(chip, NULL, &tpm_buf,
 			      READ_PUBEK_RESULT_MIN_BODY_SIZE, 0,
 			      "attempting to read the PUBEK");
 	if (rc) {
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index f27d1f38a93d..49bca4d1e786 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -503,9 +503,8 @@ enum tpm_transmit_flags {
 ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 		     u8 *buf, size_t bufsiz, unsigned int flags);
 ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
-			 void *buf, size_t bufsiz,
-			 size_t min_rsp_body_length, unsigned int flags,
-			 const char *desc);
+			 struct tpm_buf *buf, size_t min_rsp_body_length,
+			 unsigned int flags, const char *desc);
 int tpm_get_timeouts(struct tpm_chip *);
 int tpm_auto_startup(struct tpm_chip *chip);
 
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index bda9a16b44f6..10a0b7683b4b 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -334,11 +334,9 @@ static int tpm1_startup(struct tpm_chip *chip)
 
 	tpm_buf_append_u16(&buf, TPM_ST_CLEAR);
 
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
+	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0,
 			      "attempting to start the TPM");
-
 	tpm_buf_destroy(&buf);
-
 	return rc;
 }
 
@@ -461,9 +459,7 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 	tpm_buf_append_u32(&buf, pcr_idx);
 	tpm_buf_append(&buf, hash, TPM_DIGEST_SIZE);
 
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
-			      TPM_DIGEST_SIZE, 0, log_msg);
-
+	rc = tpm_transmit_cmd(chip, NULL, &buf, TPM_DIGEST_SIZE, 0, log_msg);
 	tpm_buf_destroy(&buf);
 	return rc;
 }
@@ -493,11 +489,9 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		tpm_buf_append_u32(&buf, 4);
 		tpm_buf_append_u32(&buf, subcap_id);
 	}
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
-			      min_cap_length, 0, desc);
+	rc = tpm_transmit_cmd(chip, NULL, &buf, min_cap_length, 0, desc);
 	if (!rc)
 		*cap = *(cap_t *)&buf.data[TPM_HEADER_SIZE + 4];
-
 	tpm_buf_destroy(&buf);
 	return rc;
 }
@@ -536,7 +530,7 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	do {
 		tpm_buf_append_u32(&buf, num_bytes);
 
-		rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
+		rc = tpm_transmit_cmd(chip, NULL, &buf,
 				      sizeof(out->rng_data_len), 0,
 				      "attempting get random");
 		if (rc)
@@ -582,8 +576,7 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 
 	tpm_buf_append_u32(&buf, pcr_idx);
 
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
-			      TPM_DIGEST_SIZE, 0,
+	rc = tpm_transmit_cmd(chip, NULL, &buf, TPM_DIGEST_SIZE, 0,
 			      "attempting to read a pcr value");
 	if (rc)
 		goto out;
@@ -617,11 +610,8 @@ static int tpm1_continue_selftest(struct tpm_chip *chip)
 	if (rc)
 		return rc;
 
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
-			      0, 0, "continue selftest");
-
+	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0, "continue selftest");
 	tpm_buf_destroy(&buf);
-
 	return rc;
 }
 
@@ -746,9 +736,7 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 		return rc;
 	/* now do the actual savestate */
 	for (try = 0; try < TPM_RETRY; try++) {
-		rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
-				      0, 0, NULL);
-
+		rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0, NULL);
 		/*
 		 * If the TPM indicates that it is too busy to respond to
 		 * this command then retry before giving up.  It can take
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index a6bec13afa69..2bcf470c8e5d 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -197,8 +197,8 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 	tpm_buf_append(&buf, (const unsigned char *)pcr_select,
 		       sizeof(pcr_select));
 
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
-			res_buf ? "attempting to read a pcr value" : NULL);
+	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0, res_buf ?
+			      "attempting to read a pcr value" : NULL);
 	if (rc == 0 && res_buf) {
 		out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
 		memcpy(res_buf, out->digest, SHA1_DIGEST_SIZE);
@@ -264,7 +264,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 		}
 	}
 
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
+	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0,
 			      "attempting extend a PCR value");
 
 	tpm_buf_destroy(&buf);
@@ -309,7 +309,7 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	do {
 		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
 		tpm_buf_append_u16(&buf, num_bytes);
-		err = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
+		err = tpm_transmit_cmd(chip, NULL, &buf,
 				       offsetof(struct tpm2_get_random_out,
 						buffer),
 				       0, "attempting get random");
@@ -362,9 +362,7 @@ void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
 
 	tpm_buf_append_u32(&buf, handle);
 
-	(void) tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, flags,
-				"flushing context");
-
+	tpm_transmit_cmd(chip, NULL, &buf, 0, flags, "flushing context");
 	tpm_buf_destroy(&buf);
 }
 
@@ -478,8 +476,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 	}
 
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 4, 0,
-			      "sealing data");
+	rc = tpm_transmit_cmd(chip, NULL, &buf, 4, 0, "sealing data");
 	if (rc)
 		goto out;
 
@@ -561,8 +558,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		goto out;
 	}
 
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 4, flags,
-			      "loading blob");
+	rc = tpm_transmit_cmd(chip, NULL, &buf, 4, flags, "loading blob");
 	if (!rc)
 		*blob_handle = be32_to_cpup(
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
@@ -612,8 +608,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			     options->blobauth /* hmac */,
 			     TPM_DIGEST_SIZE);
 
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 6, flags,
-			      "unsealing");
+	rc = tpm_transmit_cmd(chip, NULL, &buf, 6, flags, "unsealing");
 	if (rc > 0)
 		rc = -EPERM;
 
@@ -703,7 +698,7 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
 	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
 	tpm_buf_append_u32(&buf, property_id);
 	tpm_buf_append_u32(&buf, 1);
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
+	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0, NULL);
 	if (!rc) {
 		out = (struct tpm2_get_cap_out *)
 			&buf.data[TPM_HEADER_SIZE];
@@ -733,8 +728,7 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
 	if (rc)
 		return;
 	tpm_buf_append_u16(&buf, shutdown_type);
-	tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
-			 "stopping the TPM");
+	tpm_transmit_cmd(chip, NULL, &buf, 0, 0, "stopping the TPM");
 	tpm_buf_destroy(&buf);
 }
 
@@ -763,7 +757,7 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
 			return rc;
 
 		tpm_buf_append_u8(&buf, full);
-		rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
+		rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0,
 				      "attempting the self test");
 		tpm_buf_destroy(&buf);
 
@@ -800,7 +794,7 @@ int tpm2_probe(struct tpm_chip *chip)
 	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
 	tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
 	tpm_buf_append_u32(&buf, 1);
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
+	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0, NULL);
 	/* We ignore TPM return codes on purpose. */
 	if (rc >=  0) {
 		out = (struct tpm_output_header *)buf.data;
@@ -839,7 +833,7 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	tpm_buf_append_u32(&buf, 0);
 	tpm_buf_append_u32(&buf, 1);
 
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 9, 0,
+	rc = tpm_transmit_cmd(chip, NULL, &buf, 9, 0,
 			      "get tpm pcr allocation");
 	if (rc)
 		goto out;
@@ -911,8 +905,7 @@ static int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 	tpm_buf_append_u32(&buf, TPM2_CC_FIRST);
 	tpm_buf_append_u32(&buf, nr_commands);
 
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
-			      9 + 4 * nr_commands, 0, NULL);
+	rc = tpm_transmit_cmd(chip, NULL, &buf, 9 + 4 * nr_commands, 0, NULL);
 	if (rc) {
 		tpm_buf_destroy(&buf);
 		goto out;
@@ -969,7 +962,7 @@ static int tpm2_startup(struct tpm_chip *chip)
 		return rc;
 
 	tpm_buf_append_u16(&buf, TPM2_SU_CLEAR);
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
+	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0,
 			      "attempting to start the TPM");
 	tpm_buf_destroy(&buf);
 
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index dcdfde3c253e..1131a8e7b79b 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -83,7 +83,7 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 	body_size = sizeof(*ctx) + be16_to_cpu(ctx->blob_size);
 	tpm_buf_append(&tbuf, &buf[*offset], body_size);
 
-	rc = tpm_transmit_cmd(chip, NULL, tbuf.data, PAGE_SIZE, 4,
+	rc = tpm_transmit_cmd(chip, NULL, &tbuf, 4,
 			      TPM_TRANSMIT_NESTED, NULL);
 	if (rc < 0) {
 		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
@@ -132,7 +132,7 @@ static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
 
 	tpm_buf_append_u32(&tbuf, handle);
 
-	rc = tpm_transmit_cmd(chip, NULL, tbuf.data, PAGE_SIZE, 0,
+	rc = tpm_transmit_cmd(chip, NULL, &tbuf, 0,
 			      TPM_TRANSMIT_NESTED, NULL);
 	if (rc < 0) {
 		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 87a0ce47f201..5f95fbfb7f6b 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -417,8 +417,7 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 
 	proxy_dev->state |= STATE_DRIVER_COMMAND;
 
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, tpm_buf_length(&buf), 0,
-			      TPM_TRANSMIT_NESTED,
+	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, TPM_TRANSMIT_NESTED,
 			      "attempting to set locality");
 
 	proxy_dev->state &= ~STATE_DRIVER_COMMAND;
-- 
2.19.1

