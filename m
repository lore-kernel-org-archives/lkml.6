Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634C1C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E602175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbfBEWsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:48:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:62937 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729902AbfBEWsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:48:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 14:48:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,337,1544515200"; 
   d="scan'208";a="113982206"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.171])
  by orsmga006.jf.intel.com with ESMTP; 05 Feb 2019 14:48:30 -0800
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
Subject: [PATCH v11 09/16] tpm: move tpm_validate_commmand() to tpm2-space.c
Date:   Wed,  6 Feb 2019 00:47:16 +0200
Message-Id: <20190205224723.19671-10-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move tpm_validate_command() to tpm2-space.c and make it part of the
tpm2_prepare_space() flow. Make cc resolution as part of the TPM space
functionality in order to detach it from rest of the tpm_transmit()
flow.

Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-interface.c | 70 +++++++-------------------------
 drivers/char/tpm/tpm.h           |  9 ++--
 drivers/char/tpm/tpm2-space.c    | 52 +++++++++++++++++++++---
 3 files changed, 67 insertions(+), 64 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index f5f5224f68b0..669e702540e1 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -62,45 +62,6 @@ unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
 
-static int tpm_validate_command(struct tpm_chip *chip, struct tpm_space *space,
-				const void *cmd, size_t len)
-{
-	const struct tpm_header *header = cmd;
-	int i;
-	u32 cc;
-	u32 attrs;
-	unsigned int nr_handles;
-
-	if (len < TPM_HEADER_SIZE)
-		return -EINVAL;
-
-	if (!space)
-		return 0;
-
-	if (chip->flags & TPM_CHIP_FLAG_TPM2 && chip->nr_commands) {
-		cc = be32_to_cpu(header->ordinal);
-
-		i = tpm2_find_cc(chip, cc);
-		if (i < 0) {
-			dev_dbg(&chip->dev, "0x%04X is an invalid command\n",
-				cc);
-			return -EOPNOTSUPP;
-		}
-
-		attrs = chip->cc_attrs_tbl[i];
-		nr_handles =
-			4 * ((attrs >> TPM2_CC_ATTR_CHANDLES) & GENMASK(2, 0));
-		if (len < TPM_HEADER_SIZE + 4 * nr_handles)
-			goto err_len;
-	}
-
-	return 0;
-err_len:
-	dev_dbg(&chip->dev,
-		"%s: insufficient command length %zu", __func__, len);
-	return -EINVAL;
-}
-
 static int tpm_request_locality(struct tpm_chip *chip, unsigned int flags)
 {
 	int rc;
@@ -168,20 +129,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	u32 count, ordinal;
 	unsigned long stop;
 
-	rc = tpm_validate_command(chip, space, buf, bufsiz);
-	if (rc == -EINVAL)
-		return rc;
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
+	if (bufsiz < TPM_HEADER_SIZE)
+		return -EINVAL;
 
 	if (bufsiz > TPM_BUFSIZE)
 		bufsiz = TPM_BUFSIZE;
@@ -196,7 +145,18 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, struct tpm_space *space,
 		return -E2BIG;
 	}
 
-	rc = tpm2_prepare_space(chip, space, ordinal, buf);
+	rc = tpm2_prepare_space(chip, space, buf, bufsiz);
+	/*
+	 * If the command is not implemented by the TPM, synthesize a
+	 * response with a TPM2_RC_COMMAND_CODE return for user-space.
+	 */
+	if (rc == -EOPNOTSUPP) {
+		header->length = cpu_to_be32(sizeof(*header));
+		header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
+		header->return_code = cpu_to_be32(TPM2_RC_COMMAND_CODE |
+						  TSS2_RESMGR_TPM_RC_LAYER);
+		return sizeof(*header);
+	}
 	if (rc)
 		return rc;
 
@@ -243,7 +203,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, struct tpm_space *space,
 
 out_rc:
 	if (!rc)
-		rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
+		rc = tpm2_commit_space(chip, space, buf, &len);
 
 	return rc ? rc : len;
 }
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 6eb67ccad2a3..e84333259e28 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -264,6 +264,7 @@ struct tpm_chip {
 #endif /* CONFIG_ACPI */
 
 	struct tpm_space work_space;
+	u32 last_cc;
 	u32 nr_commands;
 	u32 *cc_attrs_tbl;
 
@@ -577,10 +578,10 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
 int tpm2_init_space(struct tpm_space *space);
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
 void tpm2_flush_space(struct tpm_chip *chip);
-int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u32 cc,
-		       u8 *cmd);
-int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
-		      u32 cc, void *buf, size_t *bufsiz);
+int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u8 *cmd,
+		       size_t cmdsiz);
+int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space, void *buf,
+		      size_t *bufsiz);
 
 int tpm_bios_log_setup(struct tpm_chip *chip);
 void tpm_bios_log_teardown(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 5d6487575074..88f6d0df5c3d 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -264,14 +264,55 @@ static int tpm2_map_command(struct tpm_chip *chip, u32 cc, u8 *cmd)
 	return 0;
 }
 
-int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u32 cc,
-		       u8 *cmd)
+static int tpm_validate_command(struct tpm_chip *chip, struct tpm_space *space,
+				const void *cmd, size_t len)
+{
+	const struct tpm_header *header = (const void *)cmd;
+	int i;
+	u32 cc;
+	u32 attrs;
+	unsigned int nr_handles;
+
+	if (len < TPM_HEADER_SIZE)
+		return -EINVAL;
+
+	if (chip->nr_commands) {
+		cc = be32_to_cpu(header->ordinal);
+
+		i = tpm2_find_cc(chip, cc);
+		if (i < 0) {
+			dev_dbg(&chip->dev, "0x%04X is an invalid command\n",
+				cc);
+			return -EOPNOTSUPP;
+		}
+
+		attrs = chip->cc_attrs_tbl[i];
+		nr_handles =
+			4 * ((attrs >> TPM2_CC_ATTR_CHANDLES) & GENMASK(2, 0));
+		if (len < TPM_HEADER_SIZE + 4 * nr_handles)
+			goto err_len;
+	}
+
+	return cc;
+err_len:
+	dev_dbg(&chip->dev, "%s: insufficient command length %zu", __func__,
+		len);
+	return -EINVAL;
+}
+
+int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u8 *cmd,
+		       size_t cmdsiz)
 {
 	int rc;
+	int cc;
 
 	if (!space)
 		return 0;
 
+	cc = tpm_validate_command(chip, space, cmd, cmdsiz);
+	if (cc < 0)
+		return cc;
+
 	memcpy(&chip->work_space.context_tbl, &space->context_tbl,
 	       sizeof(space->context_tbl));
 	memcpy(&chip->work_space.session_tbl, &space->session_tbl,
@@ -291,6 +332,7 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u32 cc,
 		return rc;
 	}
 
+	chip->last_cc = cc;
 	return 0;
 }
 
@@ -490,7 +532,7 @@ static int tpm2_save_space(struct tpm_chip *chip)
 }
 
 int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
-		      u32 cc, void *buf, size_t *bufsiz)
+		      void *buf, size_t *bufsiz)
 {
 	struct tpm_header *header = buf;
 	int rc;
@@ -498,13 +540,13 @@ int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
 	if (!space)
 		return 0;
 
-	rc = tpm2_map_response_header(chip, cc, buf, *bufsiz);
+	rc = tpm2_map_response_header(chip, chip->last_cc, buf, *bufsiz);
 	if (rc) {
 		tpm2_flush_space(chip);
 		goto out;
 	}
 
-	rc = tpm2_map_response_body(chip, cc, buf, *bufsiz);
+	rc = tpm2_map_response_body(chip, chip->last_cc, buf, *bufsiz);
 	if (rc) {
 		tpm2_flush_space(chip);
 		goto out;
-- 
2.19.1

