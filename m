Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081CEC169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5301214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5301214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbeKNEh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:37:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:63547 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbeKNEh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:37:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 10:38:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,229,1539673200"; 
   d="scan'208";a="107949007"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.77])
  by orsmga001.jf.intel.com with ESMTP; 13 Nov 2018 10:37:59 -0800
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
Subject: [PATCH v7 10/17] tpm: move tpm_validate_commmand() to tpm2-space.c
Date:   Tue, 13 Nov 2018 20:36:09 +0200
Message-Id: <20181113183620.27447-11-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113183620.27447-1-jarkko.sakkinen@linux.intel.com>
References: <20181113183620.27447-1-jarkko.sakkinen@linux.intel.com>
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
---
 drivers/char/tpm/tpm-interface.c | 72 +++++++-------------------------
 drivers/char/tpm/tpm.h           |  9 ++--
 drivers/char/tpm/tpm2-space.c    | 54 +++++++++++++++++++++---
 3 files changed, 68 insertions(+), 67 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index f2280bf15339..a6ffd0960ae5 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -62,47 +62,6 @@ unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
 
-static int tpm_validate_command(struct tpm_chip *chip,
-				 struct tpm_space *space,
-				 const u8 *cmd,
-				 size_t len)
-{
-	const struct tpm_header *header = (const void *)cmd;
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
@@ -172,20 +131,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
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
@@ -200,7 +147,18 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
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
 
@@ -249,7 +207,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 	if (rc)
 		tpm2_flush_space(chip);
 	else
-		rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
+		rc = tpm2_commit_space(chip, space, buf, &len);
 
 	return rc ? rc : len;
 }
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 92638ec6ec97..68d78ebba032 100644
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
-		      u32 cc, u8 *buf, size_t *bufsiz);
+int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u8 *cmd,
+		       size_t cmdsiz);
+int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space, u8 *buf,
+		       size_t *bufsiz);
 
 int tpm_bios_log_setup(struct tpm_chip *chip);
 void tpm_bios_log_teardown(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 393d9aadadce..172c9f9d4c29 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -264,14 +264,55 @@ static int tpm2_map_command(struct tpm_chip *chip, u32 cc, u8 *cmd)
 	return 0;
 }
 
-int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u32 cc,
-		       u8 *cmd)
+static int tpm_validate_command(struct tpm_chip *chip, struct tpm_space *space,
+				const u8 *cmd, size_t len)
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
+	return 0;
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
 
@@ -489,8 +531,8 @@ static int tpm2_save_space(struct tpm_chip *chip)
 	return 0;
 }
 
-int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
-		      u32 cc, u8 *buf, size_t *bufsiz)
+int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space, u8 *buf,
+		      size_t *bufsiz)
 {
 	struct tpm_header *header = (void *)buf;
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

