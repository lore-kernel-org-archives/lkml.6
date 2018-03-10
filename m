Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932999AbeCJI2T (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 03:28:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:63004 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751974AbeCJI2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 03:28:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,450,1515484800";
   d="scan'208";a="24039468"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v2 7/8] tpm: Move pcr extend to tpm2-cmd.c
Date: Sat, 10 Mar 2018 10:24:27 +0200
Message-Id: <20180310082428.31519-8-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180310082428.31519-1-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tpm2_pcr_extend function to tpm2-cmd.c with signature required
by tpm-interface.c. It wraps the original open code
implementation. The original original tpm2_pcr_extend function
is renamed and made static, called only from new tpm2_pcr_extend.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm-interface.c | 25 +++++--------------------
 drivers/char/tpm/tpm.h           |  3 +--
 drivers/char/tpm/tpm2-cmd.c      | 25 +++++++++++++++++++++++--
 3 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 90e14462500a..d347ad8325c6 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -391,31 +391,16 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
 int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
 {
 	int rc;
-	struct tpm2_digest digest_list[ARRAY_SIZE(chip->active_banks)];
-	u32 count = 0;
-	int i;
 
 	chip = tpm_chip_find_get(chip);
 	if (!chip)
 		return -ENODEV;
 
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		memset(digest_list, 0, sizeof(digest_list));
-
-		for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
-			    chip->active_banks[i] != TPM2_ALG_ERROR; i++) {
-			digest_list[i].alg_id = chip->active_banks[i];
-			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
-			count++;
-		}
-
-		rc = tpm2_pcr_extend(chip, pcr_idx, count, digest_list);
-		tpm_put_ops(chip);
-		return rc;
-	}
-
-	rc = tpm1_pcr_extend(chip, pcr_idx, hash,
-			     "attempting extend a PCR value");
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		rc = tpm2_pcr_extend(chip, pcr_idx, hash);
+	else
+		rc = tpm1_pcr_extend(chip, pcr_idx, hash,
+				     "attempting extend a PCR value");
 	tpm_put_ops(chip);
 	return rc;
 }
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 434f11c23e3e..2b88aadc4743 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -578,8 +578,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 
 int tpm2_get_timeouts(struct tpm_chip *chip);
 int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
-int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
-		    struct tpm2_digest *digests);
+int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash);
 int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max);
 void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
 			    unsigned int flags);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 07636aa6f1a9..80eb4bb5feef 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -223,8 +223,8 @@ struct tpm2_null_auth_area {
  *
  * Return: Same as with tpm_transmit_cmd.
  */
-int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
-		    struct tpm2_digest *digests)
+static int __tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
+			     struct tpm2_digest *digests)
 {
 	struct tpm_buf buf;
 	struct tpm2_null_auth_area auth_area;
@@ -270,6 +270,27 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
 	return rc;
 }
 
+int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
+{
+	int rc;
+	struct tpm2_digest digest_list[ARRAY_SIZE(chip->active_banks)];
+	u32 count = 0;
+	int i;
+
+	memset(digest_list, 0, sizeof(digest_list));
+
+	for (i = 0; i < ARRAY_SIZE(chip->active_banks); i++) {
+		if (chip->active_banks[i] == TPM2_ALG_ERROR)
+			break;
+		digest_list[i].alg_id = chip->active_banks[i];
+		memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
+		count++;
+	}
+
+	rc = __tpm2_pcr_extend(chip, pcr_idx, count, digest_list);
+	return rc;
+}
+
 
 #define TPM2_GETRANDOM_IN_SIZE \
 	(sizeof(struct tpm_input_header) + \
-- 
2.14.3
