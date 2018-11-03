Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41148C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 04:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A202081F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 04:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A202081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeKCNTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 09:19:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:18212 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbeKCNS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 09:18:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 21:09:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,458,1534834800"; 
   d="scan'208";a="271027129"
Received: from unknown (HELO localhost) ([10.249.254.143])
  by orsmga005.jf.intel.com with ESMTP; 02 Nov 2018 21:09:00 -0700
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
Subject: [PATCH 4/6] tpm: move tpm_validate_commmand() to tpm2-space.c
Date:   Sat,  3 Nov 2018 06:08:18 +0200
Message-Id: <20181103040820.23360-5-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181103040820.23360-1-jarkko.sakkinen@linux.intel.com>
References: <20181103040820.23360-1-jarkko.sakkinen@linux.intel.com>
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

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-interface.c | 72 +++++++-------------------------
 drivers/char/tpm/tpm.h           |  9 ++--
 drivers/char/tpm/tpm2-space.c    | 54 +++++++++++++++++++++---
 3 files changed, 68 insertions(+), 67 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index dd97a17243e3..dcdf2436ae44 100644
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
-	const struct tpm_input_header *header = (const void *)cmd;
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
 
@@ -244,7 +202,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 	if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
 		return -EFAULT;
 
-	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
+	rc = tpm2_commit_space(chip, space, buf, &len);
 	if (rc) {
 		dev_err(&chip->dev, "%s: commit error %d\n", __func__, rc);
 		return rc;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 49bca4d1e786..d4a5d5ca64b0 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -264,6 +264,7 @@ struct tpm_chip {
 #endif /* CONFIG_ACPI */
 
 	struct tpm_space work_space;
+	u32 last_cc;
 	u32 nr_commands;
 	u32 *cc_attrs_tbl;
 
@@ -579,10 +580,10 @@ int tpm2_probe(struct tpm_chip *chip);
 int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
 int tpm2_init_space(struct tpm_space *space);
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
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
index 1131a8e7b79b..eb8f85b6f485 100644
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
+	const struct tpm_input_header *header = (const void *)cmd;
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
 
@@ -489,8 +531,8 @@ static int tpm2_save_space(struct tpm_chip *chip)
 	return 0;
 }
 
-int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
-		      u32 cc, u8 *buf, size_t *bufsiz)
+int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space, u8 *buf,
+		      size_t *bufsiz)
 {
 	struct tpm_output_header *header = (void *)buf;
 	int rc;
@@ -498,13 +540,13 @@ int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
 	if (!space)
 		return 0;
 
-	rc = tpm2_map_response_header(chip, cc, buf, *bufsiz);
+	rc = tpm2_map_response_header(chip, chip->last_cc, buf, *bufsiz);
 	if (rc) {
 		tpm2_flush_space(chip);
 		return rc;
 	}
 
-	rc = tpm2_map_response_body(chip, cc, buf, *bufsiz);
+	rc = tpm2_map_response_body(chip, chip->last_cc, buf, *bufsiz);
 	if (rc) {
 		tpm2_flush_space(chip);
 		return rc;
-- 
2.19.1

