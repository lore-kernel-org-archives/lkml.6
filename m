Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95470C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571C3218AE
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbfBFQat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:30:49 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32883 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726306AbfBFQat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:30:49 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id A2E35E778654D3EA408B;
        Wed,  6 Feb 2019 16:30:47 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.33) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 6 Feb 2019 16:30:36 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>,
        <david.safford@ge.com>, <monty.wiseman@ge.com>,
        <matthewgarrett@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v10, RESEND 6/6] tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()
Date:   Wed, 6 Feb 2019 17:24:52 +0100
Message-ID: <20190206162452.7749-7-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206162452.7749-1-roberto.sassu@huawei.com>
References: <20190206162452.7749-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, tpm_pcr_extend() accepts as an input only a SHA1 digest.

This patch replaces the hash parameter of tpm_pcr_extend() with an array of
tpm_digest structures, so that the caller can provide a digest for each PCR
bank currently allocated in the TPM.

tpm_pcr_extend() will not extend banks for which no digest was provided,
as it happened before this patch, but instead it requires that callers
provide the full set of digests. Since the number of digests will always be
chip->nr_allocated_banks, the count parameter has been removed.

Due to the API change, ima_pcr_extend() and pcrlock() have been modified.
Since the number of allocated banks is not known in advance, the memory for
the digests must be dynamically allocated. To avoid performance degradation
and to avoid that a PCR extend is not done due to lack of memory, the array
of tpm_digest structures is allocated by the users of the TPM driver at
initialization time.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Mimi Zohar <zohar@linux.ibm.com> (on x86 for TPM 1.2 & PTT TPM 2.0)
---
 drivers/char/tpm/tpm-interface.c   | 30 ++++++++--------------
 drivers/char/tpm/tpm.h             |  2 +-
 drivers/char/tpm/tpm2-cmd.c        | 10 +++-----
 include/linux/tpm.h                |  5 ++--
 security/integrity/ima/ima.h       |  1 +
 security/integrity/ima/ima_init.c  |  4 +++
 security/integrity/ima/ima_queue.c | 27 +++++++++++++++++++-
 security/keys/trusted.c            | 41 ++++++++++++++++++++++++------
 8 files changed, 82 insertions(+), 38 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 8d19040d6c2a..02e8cffd1163 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -299,42 +299,34 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
  * tpm_pcr_extend - extend a PCR value in SHA1 bank.
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
  * @pcr_idx:	the PCR to be retrieved
- * @hash:	the hash value used to extend the PCR value
+ * @digests:	array of tpm_digest structures used to extend PCRs
  *
- * Note: with TPM 2.0 extends also those banks for which no digest was
- * specified in order to prevent malicious use of those PCR banks.
+ * Note: callers must pass a digest for every allocated PCR bank, in the same
+ * order of the banks in chip->allocated_banks.
  *
  * Return: same as with tpm_transmit_cmd()
  */
-int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
+int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
+		   struct tpm_digest *digests)
 {
 	int rc;
-	struct tpm_digest *digest_list;
 	int i;
 
 	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		digest_list = kcalloc(chip->nr_allocated_banks,
-				      sizeof(*digest_list), GFP_KERNEL);
-		if (!digest_list)
-			return -ENOMEM;
-
-		for (i = 0; i < chip->nr_allocated_banks; i++) {
-			digest_list[i].alg_id = chip->allocated_banks[i].alg_id;
-			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
-		}
+	for (i = 0; i < chip->nr_allocated_banks; i++)
+		if (digests[i].alg_id != chip->allocated_banks[i].alg_id)
+			return -EINVAL;
 
-		rc = tpm2_pcr_extend(chip, pcr_idx, chip->nr_allocated_banks,
-				     digest_list);
-		kfree(digest_list);
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+		rc = tpm2_pcr_extend(chip, pcr_idx, digests);
 		tpm_put_ops(chip);
 		return rc;
 	}
 
-	rc = tpm1_pcr_extend(chip, pcr_idx, hash,
+	rc = tpm1_pcr_extend(chip, pcr_idx, digests[0].digest,
 			     "attempting extend a PCR value");
 	tpm_put_ops(chip);
 	return rc;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 4f85ce909122..2cce072f25b5 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -441,7 +441,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 int tpm2_get_timeouts(struct tpm_chip *chip);
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		  struct tpm_digest *digest, u16 *digest_size_ptr);
-int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
+int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 6967f15a6585..e74c5b7b64bf 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -246,12 +246,11 @@ struct tpm2_null_auth_area {
  *
  * @chip:	TPM chip to use.
  * @pcr_idx:	index of the PCR.
- * @count:	number of digests passed.
  * @digests:	list of pcr banks and corresponding digest values to extend.
  *
  * Return: Same as with tpm_transmit_cmd.
  */
-int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
+int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests)
 {
 	struct tpm_buf buf;
@@ -259,9 +258,6 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 	int rc;
 	int i;
 
-	if (count > chip->nr_allocated_banks)
-		return -EINVAL;
-
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
 	if (rc)
 		return rc;
@@ -276,9 +272,9 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
 	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
 		       sizeof(auth_area));
-	tpm_buf_append_u32(&buf, count);
+	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < chip->nr_allocated_banks; i++) {
 		tpm_buf_append_u16(&buf, digests[i].alg_id);
 		tpm_buf_append(&buf, (const unsigned char *)&digests[i].digest,
 			       chip->allocated_banks[i].digest_size);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 816e686a73ac..1b5436b213a2 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -171,7 +171,8 @@ struct tpm_chip {
 extern int tpm_is_tpm2(struct tpm_chip *chip);
 extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 			struct tpm_digest *digest);
-extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash);
+extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
+			  struct tpm_digest *digests);
 extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
 extern int tpm_seal_trusted(struct tpm_chip *chip,
@@ -194,7 +195,7 @@ static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,
 }
 
 static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
-				 const u8 *hash)
+				 struct tpm_digest *digests)
 {
 	return -ENODEV;
 }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index cc12f3449a72..89d65cf8053d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -153,6 +153,7 @@ int ima_measurements_show(struct seq_file *m, void *v);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 void ima_init_template_list(void);
+int __init ima_init_digests(void);
 
 /*
  * used to protect h_table and sha_table
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 6bb42a9c5e47..6c9295449751 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -123,8 +123,12 @@ int __init ima_init(void)
 	if (rc != 0)
 		return rc;
 
+	/* It can be called before ima_init_digests(), it does not use TPM. */
 	ima_load_kexec_buffer();
 
+	rc = ima_init_digests();
+	if (rc != 0)
+		return rc;
 	rc = ima_add_boot_aggregate();	/* boot aggregate must be first entry */
 	if (rc != 0)
 		return rc;
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 0e41dc1df1d4..6b6d044e0440 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -27,6 +27,9 @@
 
 #define AUDIT_CAUSE_LEN_MAX 32
 
+/* pre-allocated array of tpm_digest structures to extend a PCR */
+static struct tpm_digest *digests;
+
 LIST_HEAD(ima_measurements);	/* list of all measurements */
 #ifdef CONFIG_IMA_KEXEC
 static unsigned long binary_runtime_size;
@@ -140,11 +143,15 @@ unsigned long ima_get_binary_runtime_size(void)
 static int ima_pcr_extend(const u8 *hash, int pcr)
 {
 	int result = 0;
+	int i;
 
 	if (!ima_tpm_chip)
 		return result;
 
-	result = tpm_pcr_extend(ima_tpm_chip, pcr, hash);
+	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++)
+		memcpy(digests[i].digest, hash, TPM_DIGEST_SIZE);
+
+	result = tpm_pcr_extend(ima_tpm_chip, pcr, digests);
 	if (result != 0)
 		pr_err("Error Communicating to TPM chip, result: %d\n", result);
 	return result;
@@ -211,3 +218,21 @@ int ima_restore_measurement_entry(struct ima_template_entry *entry)
 	mutex_unlock(&ima_extend_list_mutex);
 	return result;
 }
+
+int __init ima_init_digests(void)
+{
+	int i;
+
+	if (!ima_tpm_chip)
+		return 0;
+
+	digests = kcalloc(ima_tpm_chip->nr_allocated_banks, sizeof(*digests),
+			  GFP_NOFS);
+	if (!digests)
+		return -ENOMEM;
+
+	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++)
+		digests[i].alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
+
+	return 0;
+}
diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index 5b852263eae1..bcc9c6ead7fd 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -35,6 +35,7 @@
 static const char hmac_alg[] = "hmac(sha1)";
 static const char hash_alg[] = "sha1";
 static struct tpm_chip *chip;
+static struct tpm_digest *digests;
 
 struct sdesc {
 	struct shash_desc shash;
@@ -380,15 +381,10 @@ EXPORT_SYMBOL_GPL(trusted_tpm_send);
  */
 static int pcrlock(const int pcrnum)
 {
-	unsigned char hash[SHA1_DIGEST_SIZE];
-	int ret;
-
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	ret = tpm_get_random(chip, hash, SHA1_DIGEST_SIZE);
-	if (ret != SHA1_DIGEST_SIZE)
-		return ret;
-	return tpm_pcr_extend(chip, pcrnum, hash) ? -EINVAL : 0;
+
+	return tpm_pcr_extend(chip, pcrnum, digests) ? -EINVAL : 0;
 }
 
 /*
@@ -1222,6 +1218,29 @@ static int __init trusted_shash_alloc(void)
 	return ret;
 }
 
+static int __init init_digests(void)
+{
+	u8 digest[TPM_MAX_DIGEST_SIZE];
+	int ret;
+	int i;
+
+	ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
+	if (ret < 0)
+		return ret;
+	if (ret < TPM_MAX_DIGEST_SIZE)
+		return -EFAULT;
+
+	digests = kcalloc(chip->nr_allocated_banks, sizeof(*digests),
+			  GFP_KERNEL);
+	if (!digests)
+		return -ENOMEM;
+
+	for (i = 0; i < chip->nr_allocated_banks; i++)
+		memcpy(digests[i].digest, digest, TPM_MAX_DIGEST_SIZE);
+
+	return 0;
+}
+
 static int __init init_trusted(void)
 {
 	int ret;
@@ -1229,15 +1248,20 @@ static int __init init_trusted(void)
 	chip = tpm_default_chip();
 	if (!chip)
 		return -ENOENT;
-	ret = trusted_shash_alloc();
+	ret = init_digests();
 	if (ret < 0)
 		goto err_put;
+	ret = trusted_shash_alloc();
+	if (ret < 0)
+		goto err_free;
 	ret = register_key_type(&key_type_trusted);
 	if (ret < 0)
 		goto err_release;
 	return 0;
 err_release:
 	trusted_shash_release();
+err_free:
+	kfree(digests);
 err_put:
 	put_device(&chip->dev);
 	return ret;
@@ -1246,6 +1270,7 @@ static int __init init_trusted(void)
 static void __exit cleanup_trusted(void)
 {
 	put_device(&chip->dev);
+	kfree(digests);
 	trusted_shash_release();
 	unregister_key_type(&key_type_trusted);
 }
-- 
2.17.1

