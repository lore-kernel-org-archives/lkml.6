Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD87C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8B02086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfBAKRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:17:53 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32855 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfBAKRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:17:52 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 91A333F7649F99A33138;
        Fri,  1 Feb 2019 10:17:50 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.141)
 by smtpsuk.huawei.com (10.201.108.32) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 1 Feb 2019 10:17:43 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>,
        <david.safford@ge.com>, <monty.wiseman@ge.com>,
        <matthewgarrett@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v9 6/6] tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()
Date:   Fri, 1 Feb 2019 11:06:41 +0100
Message-ID: <20190201100641.26936-7-roberto.sassu@huawei.com>
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
---
 drivers/char/tpm/tpm-interface.c   | 30 ++++++++--------------
 drivers/char/tpm/tpm.h             |  2 +-
 drivers/char/tpm/tpm2-cmd.c        | 10 +++-----
 include/linux/tpm.h                |  5 ++--
 security/integrity/ima/ima.h       |  1 +
 security/integrity/ima/ima_init.c  | 22 ++++++++++++++++
 security/integrity/ima/ima_queue.c |  6 ++++-
 security/keys/trusted.c            | 41 ++++++++++++++++++++++++------
 8 files changed, 79 insertions(+), 38 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index cde2f7cbe0cf..1cef63d6519e 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -478,42 +478,34 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
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
index 001a626ca4c3..43835c2f1b09 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -458,7 +458,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 int tpm2_get_timeouts(struct tpm_chip *chip);
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		  struct tpm_digest *digest, u16 *digest_size_ptr);
-int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
+int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 760893957f13..dc115096e280 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -247,12 +247,11 @@ struct tpm2_null_auth_area {
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
@@ -260,9 +259,6 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 	int rc;
 	int i;
 
-	if (count > chip->nr_allocated_banks)
-		return -EINVAL;
-
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
 	if (rc)
 		return rc;
@@ -277,9 +273,9 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
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
index f9fea1e4075e..6051d479a44d 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -170,7 +170,8 @@ struct tpm_chip {
 extern int tpm_is_tpm2(struct tpm_chip *chip);
 extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 			struct tpm_digest *digest);
-extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash);
+extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
+			  struct tpm_digest *digests);
 extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
 extern int tpm_seal_trusted(struct tpm_chip *chip,
@@ -193,7 +194,7 @@ static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,
 }
 
 static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
-				 const u8 *hash)
+				 struct tpm_digest *digests)
 {
 	return -ENODEV;
 }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index cc12f3449a72..e6b2dcb0846a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -56,6 +56,7 @@ extern int ima_policy_flag;
 extern int ima_hash_algo;
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
+extern struct tpm_digest *digests;
 
 /* IMA event related data */
 struct ima_event_data {
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 6bb42a9c5e47..296a965b11ef 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -27,6 +27,7 @@
 /* name for boot aggregate entry */
 static const char boot_aggregate_name[] = "boot_aggregate";
 struct tpm_chip *ima_tpm_chip;
+struct tpm_digest *digests;
 
 /* Add the boot aggregate to the IMA measurement list and extend
  * the PCR register.
@@ -104,6 +105,24 @@ void __init ima_load_x509(void)
 }
 #endif
 
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
+
 int __init ima_init(void)
 {
 	int rc;
@@ -125,6 +144,9 @@ int __init ima_init(void)
 
 	ima_load_kexec_buffer();
 
+	rc = ima_init_digests();
+	if (rc != 0)
+		return rc;
 	rc = ima_add_boot_aggregate();	/* boot aggregate must be first entry */
 	if (rc != 0)
 		return rc;
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 0e41dc1df1d4..719e88ca58f6 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -140,11 +140,15 @@ unsigned long ima_get_binary_runtime_size(void)
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

