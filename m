Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D2FC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2542086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfBAKQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:16:17 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32852 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfBAKQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:16:16 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 41C069B1DCA3F4D75212;
        Fri,  1 Feb 2019 10:16:14 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.141)
 by smtpsuk.huawei.com (10.201.108.32) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 1 Feb 2019 10:16:08 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>,
        <david.safford@ge.com>, <monty.wiseman@ge.com>,
        <matthewgarrett@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v9 3/6] tpm: retrieve digest size of unknown algorithms with PCR read
Date:   Fri, 1 Feb 2019 11:06:38 +0100
Message-ID: <20190201100641.26936-4-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201100641.26936-1-roberto.sassu@huawei.com>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.141]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the TPM driver retrieves the digest size from a table mapping
TPM algorithms identifiers to identifiers defined by the crypto subsystem.
If the algorithm is not defined by the latter, the digest size can be
retrieved from the output of the PCR read command.

The patch modifies the definition of tpm_pcr_read() and tpm2_pcr_read() to
pass the desired hash algorithm and obtain the digest size at TPM startup.
Algorithms and corresponding digest sizes are stored in the new structure
tpm_bank_info, member of tpm_chip, so that the information can be used by
other kernel subsystems.

tpm_bank_info contains: the TPM algorithm identifier, necessary to generate
the event log as defined by Trusted Computing Group (TCG); the digest size,
to pad/truncate a digest calculated with a different algorithm; the crypto
subsystem identifier, to calculate the digest of event data.

This patch also protects against data corruption that could happen in the
bus, by checking that the digest size returned by the TPM during a PCR read
matches the size of the algorithm passed to tpm2_pcr_read().

For the initial PCR read, when digest sizes are not yet available, this
patch ensures that the amount of data copied from the output returned by
the TPM does not exceed the size of the array data are copied to.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
---
 drivers/char/tpm/tpm-interface.c    | 16 +++---
 drivers/char/tpm/tpm.h              |  5 +-
 drivers/char/tpm/tpm1-cmd.c         |  4 +-
 drivers/char/tpm/tpm2-cmd.c         | 84 +++++++++++++++++++++++------
 include/linux/tpm.h                 | 12 ++++-
 security/integrity/ima/ima_crypto.c | 10 ++--
 6 files changed, 96 insertions(+), 35 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 2a85194413e2..cde2f7cbe0cf 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -451,11 +451,12 @@ EXPORT_SYMBOL_GPL(tpm_is_tpm2);
  * tpm_pcr_read - read a PCR value from SHA1 bank
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
  * @pcr_idx:	the PCR to be retrieved
- * @res_buf:	the value of the PCR
+ * @digest:	the PCR bank and buffer current PCR value is written to
  *
  * Return: same as with tpm_transmit_cmd()
  */
-int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
+int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
+		 struct tpm_digest *digest)
 {
 	int rc;
 
@@ -464,9 +465,9 @@ int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 		return -ENODEV;
 
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		rc = tpm2_pcr_read(chip, pcr_idx, res_buf);
+		rc = tpm2_pcr_read(chip, pcr_idx, digest, NULL);
 	else
-		rc = tpm1_pcr_read(chip, pcr_idx, res_buf);
+		rc = tpm1_pcr_read(chip, pcr_idx, digest->digest);
 
 	tpm_put_ops(chip);
 	return rc;
@@ -479,9 +480,8 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
  * @pcr_idx:	the PCR to be retrieved
  * @hash:	the hash value used to extend the PCR value
  *
- * Note: with TPM 2.0 extends also those banks with a known digest size to the
- * cryto subsystem in order to prevent malicious use of those PCR banks. In the
- * future we should dynamically determine digest sizes.
+ * Note: with TPM 2.0 extends also those banks for which no digest was
+ * specified in order to prevent malicious use of those PCR banks.
  *
  * Return: same as with tpm_transmit_cmd()
  */
@@ -502,7 +502,7 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
 			return -ENOMEM;
 
 		for (i = 0; i < chip->nr_allocated_banks; i++) {
-			digest_list[i].alg_id = chip->allocated_banks[i];
+			digest_list[i].alg_id = chip->allocated_banks[i].alg_id;
 			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
 		}
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index e961e5c5d197..64d93d26087f 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -247,7 +247,7 @@ struct tpm_chip {
 	unsigned int groups_cnt;
 
 	u32 nr_allocated_banks;
-	u16 *allocated_banks;
+	struct tpm_bank_info *allocated_banks;
 #ifdef CONFIG_ACPI
 	acpi_handle acpi_dev_handle;
 	char ppi_version[TPM_PPI_VERSION_LEN + 1];
@@ -548,7 +548,8 @@ static inline u32 tpm2_rc_value(u32 rc)
 }
 
 int tpm2_get_timeouts(struct tpm_chip *chip);
-int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
+int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
+		  struct tpm_digest *digest, u16 *digest_size_ptr);
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 		    struct tpm_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 1f8699d428be..51ac06d1d2be 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -715,7 +715,9 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 		goto out;
 	}
 
-	chip->allocated_banks[0] = TPM_ALG_SHA1;
+	chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
+	chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
+	chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
 	chip->nr_allocated_banks = 1;
 
 	return rc;
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index db8e05c8dad3..760893957f13 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -171,20 +171,36 @@ struct tpm2_pcr_read_out {
  * tpm2_pcr_read() - read a PCR value
  * @chip:	TPM chip to use.
  * @pcr_idx:	index of the PCR to read.
- * @res_buf:	buffer to store the resulting hash.
+ * @digest:	PCR bank and buffer current PCR value is written to.
+ * @digest_size_ptr:	pointer to variable that stores the digest size.
  *
  * Return: Same as with tpm_transmit_cmd.
  */
-int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
+int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
+		  struct tpm_digest *digest, u16 *digest_size_ptr)
 {
+	int i;
 	int rc;
 	struct tpm_buf buf;
 	struct tpm2_pcr_read_out *out;
 	u8 pcr_select[TPM2_PCR_SELECT_MIN] = {0};
+	u16 digest_size;
+	u16 expected_digest_size = 0;
 
 	if (pcr_idx >= TPM2_PLATFORM_PCR)
 		return -EINVAL;
 
+	if (!digest_size_ptr) {
+		for (i = 0; i < chip->nr_allocated_banks &&
+		     chip->allocated_banks[i].alg_id != digest->alg_id; i++)
+			;
+
+		if (i == chip->nr_allocated_banks)
+			return -EINVAL;
+
+		expected_digest_size = chip->allocated_banks[i].digest_size;
+	}
+
 	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
 	if (rc)
 		return rc;
@@ -192,18 +208,29 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 	pcr_select[pcr_idx >> 3] = 1 << (pcr_idx & 0x7);
 
 	tpm_buf_append_u32(&buf, 1);
-	tpm_buf_append_u16(&buf, TPM_ALG_SHA1);
+	tpm_buf_append_u16(&buf, digest->alg_id);
 	tpm_buf_append_u8(&buf, TPM2_PCR_SELECT_MIN);
 	tpm_buf_append(&buf, (const unsigned char *)pcr_select,
 		       sizeof(pcr_select));
 
 	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
-			res_buf ? "attempting to read a pcr value" : NULL);
-	if (rc == 0 && res_buf) {
-		out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
-		memcpy(res_buf, out->digest, SHA1_DIGEST_SIZE);
+			      "attempting to read a pcr value");
+	if (rc)
+		goto out;
+
+	out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
+	digest_size = be16_to_cpu(out->digest_size);
+	if (digest_size > sizeof(digest->digest) ||
+	    (!digest_size_ptr && digest_size != expected_digest_size)) {
+		rc = -EINVAL;
+		goto out;
 	}
 
+	if (digest_size_ptr)
+		*digest_size_ptr = digest_size;
+
+	memcpy(digest->digest, out->digest, digest_size);
+out:
 	tpm_buf_destroy(&buf);
 	return rc;
 }
@@ -232,7 +259,6 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 	struct tpm2_null_auth_area auth_area;
 	int rc;
 	int i;
-	int j;
 
 	if (count > chip->nr_allocated_banks)
 		return -EINVAL;
@@ -254,14 +280,9 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 	tpm_buf_append_u32(&buf, count);
 
 	for (i = 0; i < count; i++) {
-		for (j = 0; j < ARRAY_SIZE(tpm2_hash_map); j++) {
-			if (digests[i].alg_id != tpm2_hash_map[j].tpm_id)
-				continue;
-			tpm_buf_append_u16(&buf, digests[i].alg_id);
-			tpm_buf_append(&buf, (const unsigned char
-					      *)&digests[i].digest,
-			       hash_digest_size[tpm2_hash_map[j].crypto_id]);
-		}
+		tpm_buf_append_u16(&buf, digests[i].alg_id);
+		tpm_buf_append(&buf, (const unsigned char *)&digests[i].digest,
+			       chip->allocated_banks[i].digest_size);
 	}
 
 	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
@@ -812,6 +833,30 @@ int tpm2_probe(struct tpm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(tpm2_probe);
 
+static int tpm2_init_bank_info(struct tpm_chip *chip, u32 bank_index)
+{
+	struct tpm_bank_info *bank = chip->allocated_banks + bank_index;
+	struct tpm_digest digest = { .alg_id = bank->alg_id };
+	int i;
+
+	/*
+	 * Avoid unnecessary PCR read operations to reduce overhead
+	 * and obtain identifiers of the crypto subsystem.
+	 */
+	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
+		enum hash_algo crypto_algo = tpm2_hash_map[i].crypto_id;
+
+		if (bank->alg_id != tpm2_hash_map[i].tpm_id)
+			continue;
+
+		bank->digest_size = hash_digest_size[crypto_algo];
+		bank->crypto_id = crypto_algo;
+		return 0;
+	}
+
+	return tpm2_pcr_read(chip, 0, &digest, &bank->digest_size);
+}
+
 struct tpm2_pcr_selection {
 	__be16  hash_alg;
 	u8  size_of_select;
@@ -876,7 +921,12 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 		pcr_select_offset = memchr_inv(pcr_selection.pcr_select, 0,
 					       pcr_selection.size_of_select);
 		if (pcr_select_offset) {
-			chip->allocated_banks[nr_alloc_banks] = hash_alg;
+			chip->allocated_banks[nr_alloc_banks].alg_id = hash_alg;
+
+			rc = tpm2_init_bank_info(chip, nr_alloc_banks);
+			if (rc < 0)
+				break;
+
 			nr_alloc_banks++;
 		}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 9fe8c9816cf0..afd022fc9d3d 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -47,6 +47,12 @@ struct tpm_digest {
 	u8 digest[TPM_MAX_DIGEST_SIZE];
 } __packed;
 
+struct tpm_bank_info {
+	u16 alg_id;
+	u16 digest_size;
+	u16 crypto_id;
+};
+
 enum TPM_OPS_FLAGS {
 	TPM_OPS_AUTO_STARTUP = BIT(0),
 };
@@ -72,7 +78,8 @@ struct tpm_class_ops {
 #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
 
 extern int tpm_is_tpm2(struct tpm_chip *chip);
-extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
+extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
+			struct tpm_digest *digest);
 extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash);
 extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
@@ -89,7 +96,8 @@ static inline int tpm_is_tpm2(struct tpm_chip *chip)
 	return -ENODEV;
 }
 
-static inline int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
+static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,
+			       struct tpm_digest *digest)
 {
 	return -ENODEV;
 }
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index acf2c7df7145..16a4f45863b1 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -643,12 +643,12 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
 	return calc_buffer_shash(buf, len, hash);
 }
 
-static void __init ima_pcrread(u32 idx, u8 *pcr)
+static void __init ima_pcrread(u32 idx, struct tpm_digest *d)
 {
 	if (!ima_tpm_chip)
 		return;
 
-	if (tpm_pcr_read(ima_tpm_chip, idx, pcr) != 0)
+	if (tpm_pcr_read(ima_tpm_chip, idx, d) != 0)
 		pr_err("Error Communicating to TPM chip\n");
 }
 
@@ -658,7 +658,7 @@ static void __init ima_pcrread(u32 idx, u8 *pcr)
 static int __init ima_calc_boot_aggregate_tfm(char *digest,
 					      struct crypto_shash *tfm)
 {
-	u8 pcr_i[TPM_DIGEST_SIZE];
+	struct tpm_digest d = { .alg_id = TPM_ALG_SHA1, .digest = {0} };
 	int rc;
 	u32 i;
 	SHASH_DESC_ON_STACK(shash, tfm);
@@ -672,9 +672,9 @@ static int __init ima_calc_boot_aggregate_tfm(char *digest,
 
 	/* cumulative sha1 over tpm registers 0-7 */
 	for (i = TPM_PCR0; i < TPM_PCR8; i++) {
-		ima_pcrread(i, pcr_i);
+		ima_pcrread(i, &d);
 		/* now accumulate with current aggregate */
-		rc = crypto_shash_update(shash, pcr_i, TPM_DIGEST_SIZE);
+		rc = crypto_shash_update(shash, d.digest, TPM_DIGEST_SIZE);
 	}
 	if (!rc)
 		crypto_shash_final(shash, digest);
-- 
2.17.1

