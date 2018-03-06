Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750907AbeCFJeQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:34:16 -0500
Received: from mga07.intel.com ([134.134.136.100]:24940 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753263AbeCFJeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:34:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="205860700"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 1/4] tmp: move tpm1_pcr_extend to tpm1-cmd.c
Date: Tue,  6 Mar 2018 11:30:38 +0200
Message-Id: <20180306093041.11996-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180306093041.11996-1-tomas.winkler@intel.com>
References: <20180306093041.11996-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move tpm1_pcr_extend to tpm1-cmd.c and remove
unused pcrextend_header structure.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm-interface.c | 28 ----------------------------
 drivers/char/tpm/tpm.h           |  2 ++
 drivers/char/tpm/tpm1-cmd.c      | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 7f6968b750c8..83eeefb2a4af 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -514,34 +514,6 @@ int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
 }
 EXPORT_SYMBOL_GPL(tpm_pcr_read);
 
-#define TPM_ORD_PCR_EXTEND 20
-#define EXTEND_PCR_RESULT_SIZE 34
-#define EXTEND_PCR_RESULT_BODY_SIZE 20
-static const struct tpm_input_header pcrextend_header = {
-	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
-	.length = cpu_to_be32(34),
-	.ordinal = cpu_to_be32(TPM_ORD_PCR_EXTEND)
-};
-
-static int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
-			   char *log_msg)
-{
-	struct tpm_buf buf;
-	int rc;
-
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
-	if (rc)
-		return rc;
-
-	tpm_buf_append_u32(&buf, pcr_idx);
-	tpm_buf_append(&buf, hash, TPM_DIGEST_SIZE);
-
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, EXTEND_PCR_RESULT_SIZE,
-			      EXTEND_PCR_RESULT_BODY_SIZE, 0, log_msg);
-	tpm_buf_destroy(&buf);
-	return rc;
-}
-
 /**
  * tpm_pcr_extend - extend a PCR value in SHA1 bank.
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 48706f091856..4306c878f1d9 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -535,6 +535,8 @@ int tpm_do_selftest(struct tpm_chip *chip);
 int tpm1_auto_startup(struct tpm_chip *chip);
 int tpm1_get_timeouts(struct tpm_chip *chip);
 unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
+int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
+		    const char *log_msg);
 int tpm_pm_suspend(struct device *dev);
 int tpm_pm_resume(struct device *dev);
 
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index e48be0c09131..dc07eafe9d69 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -414,3 +414,26 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
 	return 0;
 }
+
+#define TPM_ORD_PCR_EXTEND 20
+#define EXTEND_PCR_RESULT_SIZE 34
+#define EXTEND_PCR_RESULT_BODY_SIZE 20
+int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
+		    const char *log_msg)
+{
+	struct tpm_buf buf;
+	int rc;
+
+	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, pcr_idx);
+	tpm_buf_append(&buf, hash, TPM_DIGEST_SIZE);
+
+	rc = tpm_transmit_cmd(chip, NULL, buf.data, EXTEND_PCR_RESULT_SIZE,
+			      EXTEND_PCR_RESULT_BODY_SIZE, 0, log_msg);
+	tpm_buf_destroy(&buf);
+	return rc;
+}
+
-- 
2.14.3
