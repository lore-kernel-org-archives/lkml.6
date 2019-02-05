Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E98C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041722175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbfBEWsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:48:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:36278 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730853AbfBEWsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:48:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 14:48:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,337,1544515200"; 
   d="scan'208";a="113982243"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.171])
  by orsmga006.jf.intel.com with ESMTP; 05 Feb 2019 14:48:45 -0800
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
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v11 11/16] tpm: remove @space from tpm_transmit()
Date:   Wed,  6 Feb 2019 00:47:18 +0200
Message-Id: <20190205224723.19671-12-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove @space from tpm_transmit() API` in order to completely remove the
bound between low-level transmission functionality and TPM spaces. The
only real dependency existing is the amount of data saved before trying
to send a command to the TPM.

It doesn't really matter if we save always a bit more than needed so
this commit changes the amount saved always to be the size of the TPM
header and three handles.

Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-dev-common.c |  2 +-
 drivers/char/tpm/tpm-interface.c  | 25 +++++++++++--------------
 drivers/char/tpm/tpm-sysfs.c      |  5 ++---
 drivers/char/tpm/tpm.h            | 10 +++++-----
 drivers/char/tpm/tpm1-cmd.c       | 16 +++++++---------
 drivers/char/tpm/tpm2-cmd.c       | 30 ++++++++++++++----------------
 drivers/char/tpm/tpm2-space.c     |  6 ++----
 drivers/char/tpm/tpm_vtpm_proxy.c |  2 +-
 8 files changed, 43 insertions(+), 53 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 327d1dca92c8..95fe652b34ff 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -48,7 +48,7 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	if (ret)
 		goto out_lock;
 
-	len = tpm_transmit(chip, space, buf, bufsiz, TPM_TRANSMIT_UNLOCKED);
+	len = tpm_transmit(chip, buf, bufsiz, TPM_TRANSMIT_UNLOCKED);
 	if (len < 0)
 		ret = len;
 
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index cca0ee47d12d..b4c44b94e832 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -120,8 +120,8 @@ static int tpm_go_idle(struct tpm_chip *chip, unsigned int flags)
 	return chip->ops->go_idle(chip);
 }
 
-static ssize_t tpm_try_transmit(struct tpm_chip *chip, struct tpm_space *space,
-				void *buf, size_t bufsiz, unsigned int flags)
+static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz,
+				unsigned int flags)
 {
 	struct tpm_header *header = buf;
 	int rc;
@@ -190,7 +190,6 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, struct tpm_space *space,
 /**
  * tpm_transmit - Internal kernel interface to transmit TPM commands.
  * @chip:	a TPM chip to use
- * @space:	a TPM space
  * @buf:	a TPM command buffer
  * @bufsiz:	length of the TPM command buffer
  * @flags:	TPM transmit flags
@@ -206,8 +205,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, struct tpm_space *space,
  * * The response length	- OK
  * * -errno			- A system error
  */
-ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
-		     u8 *buf, size_t bufsiz, unsigned int flags)
+ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+		     unsigned int flags)
 {
 	struct tpm_header *header = (struct tpm_header *)buf;
 	/* space for header and handles */
@@ -216,8 +215,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	bool has_locality = false;
 	u32 rc = 0;
 	ssize_t ret;
-	const size_t save_size = min(space ? sizeof(save) : TPM_HEADER_SIZE,
-				     bufsiz);
+	const size_t save_size = min(sizeof(save), bufsiz);
 	/* the command code is where the return code will be */
 	u32 cc = be32_to_cpu(header->return_code);
 
@@ -247,7 +245,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 		if (ret)
 			goto out_locality;
 
-		ret = tpm_try_transmit(chip, space, buf, bufsiz, flags);
+		ret = tpm_try_transmit(chip, buf, bufsiz, flags);
 
 		/* This may fail but do not override ret. */
 		tpm_go_idle(chip, flags);
@@ -293,7 +291,6 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 /**
  * tpm_transmit_cmd - send a tpm command to the device
  * @chip:			a TPM chip to use
- * @space:			a TPM space
  * @buf:			a TPM command buffer
  * @min_rsp_body_length:	minimum expected length of response body
  * @flags:			TPM transmit flags
@@ -304,15 +301,15 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
  * * -errno	- A system error
  * * TPM_RC	- A TPM error
  */
-ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
-			 struct tpm_buf *buf, size_t min_rsp_body_length,
-			 unsigned int flags, const char *desc)
+ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
+			 size_t min_rsp_body_length, unsigned int flags,
+			 const char *desc)
 {
 	const struct tpm_header *header = (struct tpm_header *)buf->data;
 	int err;
 	ssize_t len;
 
-	len = tpm_transmit(chip, space, buf->data, PAGE_SIZE, flags);
+	len = tpm_transmit(chip, buf->data, PAGE_SIZE, flags);
 	if (len <  0)
 		return len;
 
@@ -461,7 +458,7 @@ int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
 		goto out;
 
 	memcpy(buf.data, cmd, buflen);
-	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0,
+	rc = tpm_transmit_cmd(chip, &buf, 0, 0,
 			      "attempting to a send a command");
 	tpm_buf_destroy(&buf);
 out:
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 928d4e839bb7..03e704f99ed6 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -52,9 +52,8 @@ static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
 
 	tpm_buf_append(&tpm_buf, anti_replay, sizeof(anti_replay));
 
-	rc = tpm_transmit_cmd(chip, NULL, &tpm_buf,
-			      READ_PUBEK_RESULT_MIN_BODY_SIZE, 0,
-			      "attempting to read the PUBEK");
+	rc = tpm_transmit_cmd(chip, &tpm_buf, READ_PUBEK_RESULT_MIN_BODY_SIZE,
+			      0, "attempting to read the PUBEK");
 	if (rc) {
 		tpm_buf_destroy(&tpm_buf);
 		return 0;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index e84333259e28..644f1a5c4fdd 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -498,11 +498,11 @@ enum tpm_transmit_flags {
 	TPM_TRANSMIT_NESTED      = BIT(1),
 };
 
-ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
-		     u8 *buf, size_t bufsiz, unsigned int flags);
-ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
-			 struct tpm_buf *buf, size_t min_rsp_body_length,
-			 unsigned int flags, const char *desc);
+ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+		     unsigned int flags);
+ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
+			 size_t min_rsp_body_length, unsigned int flags,
+			 const char *desc);
 int tpm_get_timeouts(struct tpm_chip *);
 int tpm_auto_startup(struct tpm_chip *chip);
 
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 10a0b7683b4b..5b5f8bcc6210 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -334,8 +334,7 @@ static int tpm1_startup(struct tpm_chip *chip)
 
 	tpm_buf_append_u16(&buf, TPM_ST_CLEAR);
 
-	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0,
-			      "attempting to start the TPM");
+	rc = tpm_transmit_cmd(chip, &buf, 0, 0, "attempting to start the TPM");
 	tpm_buf_destroy(&buf);
 	return rc;
 }
@@ -459,7 +458,7 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 	tpm_buf_append_u32(&buf, pcr_idx);
 	tpm_buf_append(&buf, hash, TPM_DIGEST_SIZE);
 
-	rc = tpm_transmit_cmd(chip, NULL, &buf, TPM_DIGEST_SIZE, 0, log_msg);
+	rc = tpm_transmit_cmd(chip, &buf, TPM_DIGEST_SIZE, 0, log_msg);
 	tpm_buf_destroy(&buf);
 	return rc;
 }
@@ -489,7 +488,7 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		tpm_buf_append_u32(&buf, 4);
 		tpm_buf_append_u32(&buf, subcap_id);
 	}
-	rc = tpm_transmit_cmd(chip, NULL, &buf, min_cap_length, 0, desc);
+	rc = tpm_transmit_cmd(chip, &buf, min_cap_length, 0, desc);
 	if (!rc)
 		*cap = *(cap_t *)&buf.data[TPM_HEADER_SIZE + 4];
 	tpm_buf_destroy(&buf);
@@ -530,8 +529,7 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	do {
 		tpm_buf_append_u32(&buf, num_bytes);
 
-		rc = tpm_transmit_cmd(chip, NULL, &buf,
-				      sizeof(out->rng_data_len), 0,
+		rc = tpm_transmit_cmd(chip, &buf, sizeof(out->rng_data_len), 0,
 				      "attempting get random");
 		if (rc)
 			goto out;
@@ -576,7 +574,7 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 
 	tpm_buf_append_u32(&buf, pcr_idx);
 
-	rc = tpm_transmit_cmd(chip, NULL, &buf, TPM_DIGEST_SIZE, 0,
+	rc = tpm_transmit_cmd(chip, &buf, TPM_DIGEST_SIZE, 0,
 			      "attempting to read a pcr value");
 	if (rc)
 		goto out;
@@ -610,7 +608,7 @@ static int tpm1_continue_selftest(struct tpm_chip *chip)
 	if (rc)
 		return rc;
 
-	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0, "continue selftest");
+	rc = tpm_transmit_cmd(chip, &buf, 0, 0, "continue selftest");
 	tpm_buf_destroy(&buf);
 	return rc;
 }
@@ -736,7 +734,7 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 		return rc;
 	/* now do the actual savestate */
 	for (try = 0; try < TPM_RETRY; try++) {
-		rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0, NULL);
+		rc = tpm_transmit_cmd(chip, &buf, 0, 0, NULL);
 		/*
 		 * If the TPM indicates that it is too busy to respond to
 		 * this command then retry before giving up.  It can take
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index ab03f8600f89..f2b0e5c52a57 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -197,7 +197,7 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 	tpm_buf_append(&buf, (const unsigned char *)pcr_select,
 		       sizeof(pcr_select));
 
-	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0, res_buf ?
+	rc = tpm_transmit_cmd(chip, &buf, 0, 0, res_buf ?
 			      "attempting to read a pcr value" : NULL);
 	if (rc == 0 && res_buf) {
 		out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
@@ -264,7 +264,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 		}
 	}
 
-	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0,
+	rc = tpm_transmit_cmd(chip, &buf, 0, 0,
 			      "attempting extend a PCR value");
 
 	tpm_buf_destroy(&buf);
@@ -309,7 +309,7 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	do {
 		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
 		tpm_buf_append_u16(&buf, num_bytes);
-		err = tpm_transmit_cmd(chip, NULL, &buf,
+		err = tpm_transmit_cmd(chip, &buf,
 				       offsetof(struct tpm2_get_random_out,
 						buffer),
 				       0, "attempting get random");
@@ -362,7 +362,7 @@ void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
 
 	tpm_buf_append_u32(&buf, handle);
 
-	tpm_transmit_cmd(chip, NULL, &buf, 0, flags, "flushing context");
+	tpm_transmit_cmd(chip, &buf, 0, flags, "flushing context");
 	tpm_buf_destroy(&buf);
 }
 
@@ -476,7 +476,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 	}
 
-	rc = tpm_transmit_cmd(chip, NULL, &buf, 4, 0, "sealing data");
+	rc = tpm_transmit_cmd(chip, &buf, 4, 0, "sealing data");
 	if (rc)
 		goto out;
 
@@ -558,7 +558,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		goto out;
 	}
 
-	rc = tpm_transmit_cmd(chip, NULL, &buf, 4, flags, "loading blob");
+	rc = tpm_transmit_cmd(chip, &buf, 4, flags, "loading blob");
 	if (!rc)
 		*blob_handle = be32_to_cpup(
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
@@ -608,7 +608,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			     options->blobauth /* hmac */,
 			     TPM_DIGEST_SIZE);
 
-	rc = tpm_transmit_cmd(chip, NULL, &buf, 6, flags, "unsealing");
+	rc = tpm_transmit_cmd(chip, &buf, 6, flags, "unsealing");
 	if (rc > 0)
 		rc = -EPERM;
 
@@ -698,7 +698,7 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
 	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
 	tpm_buf_append_u32(&buf, property_id);
 	tpm_buf_append_u32(&buf, 1);
-	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0, NULL);
+	rc = tpm_transmit_cmd(chip, &buf, 0, 0, NULL);
 	if (!rc) {
 		out = (struct tpm2_get_cap_out *)
 			&buf.data[TPM_HEADER_SIZE];
@@ -728,7 +728,7 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
 	if (rc)
 		return;
 	tpm_buf_append_u16(&buf, shutdown_type);
-	tpm_transmit_cmd(chip, NULL, &buf, 0, 0, "stopping the TPM");
+	tpm_transmit_cmd(chip, &buf, 0, 0, "stopping the TPM");
 	tpm_buf_destroy(&buf);
 }
 
@@ -757,7 +757,7 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
 			return rc;
 
 		tpm_buf_append_u8(&buf, full);
-		rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0,
+		rc = tpm_transmit_cmd(chip, &buf, 0, 0,
 				      "attempting the self test");
 		tpm_buf_destroy(&buf);
 
@@ -794,7 +794,7 @@ int tpm2_probe(struct tpm_chip *chip)
 	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
 	tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
 	tpm_buf_append_u32(&buf, 1);
-	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0, NULL);
+	rc = tpm_transmit_cmd(chip, &buf, 0, 0, NULL);
 	/* We ignore TPM return codes on purpose. */
 	if (rc >=  0) {
 		out = (struct tpm_header *)buf.data;
@@ -833,8 +833,7 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	tpm_buf_append_u32(&buf, 0);
 	tpm_buf_append_u32(&buf, 1);
 
-	rc = tpm_transmit_cmd(chip, NULL, &buf, 9, 0,
-			      "get tpm pcr allocation");
+	rc = tpm_transmit_cmd(chip, &buf, 9, 0, "get tpm pcr allocation");
 	if (rc)
 		goto out;
 
@@ -905,7 +904,7 @@ static int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 	tpm_buf_append_u32(&buf, TPM2_CC_FIRST);
 	tpm_buf_append_u32(&buf, nr_commands);
 
-	rc = tpm_transmit_cmd(chip, NULL, &buf, 9 + 4 * nr_commands, 0, NULL);
+	rc = tpm_transmit_cmd(chip, &buf, 9 + 4 * nr_commands, 0, NULL);
 	if (rc) {
 		tpm_buf_destroy(&buf);
 		goto out;
@@ -962,8 +961,7 @@ static int tpm2_startup(struct tpm_chip *chip)
 		return rc;
 
 	tpm_buf_append_u16(&buf, TPM2_SU_CLEAR);
-	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, 0,
-			      "attempting to start the TPM");
+	rc = tpm_transmit_cmd(chip, &buf, 0, 0, "attempting to start the TPM");
 	tpm_buf_destroy(&buf);
 
 	return rc;
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 8bddda2882ea..b0810a63df12 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -83,8 +83,7 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 	body_size = sizeof(*ctx) + be16_to_cpu(ctx->blob_size);
 	tpm_buf_append(&tbuf, &buf[*offset], body_size);
 
-	rc = tpm_transmit_cmd(chip, NULL, &tbuf, 4,
-			      TPM_TRANSMIT_UNLOCKED, NULL);
+	rc = tpm_transmit_cmd(chip, &tbuf, 4, TPM_TRANSMIT_UNLOCKED, NULL);
 	if (rc < 0) {
 		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
 			 __func__, rc);
@@ -132,8 +131,7 @@ static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
 
 	tpm_buf_append_u32(&tbuf, handle);
 
-	rc = tpm_transmit_cmd(chip, NULL, &tbuf, 0,
-			      TPM_TRANSMIT_UNLOCKED, NULL);
+	rc = tpm_transmit_cmd(chip, &tbuf, 0, TPM_TRANSMIT_UNLOCKED, NULL);
 	if (rc < 0) {
 		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
 			 __func__, rc);
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 28eb5ab15b99..e8a1da2810a9 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -417,7 +417,7 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 
 	proxy_dev->state |= STATE_DRIVER_COMMAND;
 
-	rc = tpm_transmit_cmd(chip, NULL, &buf, 0, TPM_TRANSMIT_NESTED,
+	rc = tpm_transmit_cmd(chip, &buf, 0, TPM_TRANSMIT_NESTED,
 			      "attempting to set locality");
 
 	proxy_dev->state &= ~STATE_DRIVER_COMMAND;
-- 
2.19.1

