Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F810C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E7C20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E7C20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbeLMKfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:35:11 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32815 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728367AbeLMKfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:35:10 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id DB4A94C2F276;
        Thu, 13 Dec 2018 10:35:07 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.153)
 by smtpsuk.huawei.com (10.201.108.48) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 13 Dec 2018 10:35:01 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>,
        <david.safford@ge.com>, <monty.wiseman@ge.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v7 5/5] tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()
Date:   Thu, 13 Dec 2018 11:29:45 +0100
Message-ID: <20181213102945.30946-6-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213102945.30946-1-roberto.sassu@huawei.com>
References: <20181213102945.30946-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.153]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, tpm_pcr_extend() accepts as an input only a SHA1 digest.

This patch modifies the definition of tpm_pcr_extend() to allow other
kernel subsystems to pass a digest for each algorithm supported by the TPM.
All digests are processed by the TPM in one operation.

If a tpm_pcr_extend() caller provides a subset of the supported algorithms,
the TPM driver extends the remaining PCR banks with the first digest
passed as an argument to the function.

The new tpm_extend digest structure has been preferred to the tpm_digest
structure, to let the caller specify the size of the digest (which may be
unknown to the TPM driver).

Due to the API change, ima_pcr_extend() and pcrlock() have been modified.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 drivers/char/tpm/tpm-interface.c   | 24 +++++---------------
 drivers/char/tpm/tpm.h             |  5 +++--
 drivers/char/tpm/tpm1-cmd.c        | 13 ++++++++---
 drivers/char/tpm/tpm2-cmd.c        | 35 +++++++++++++++++++++---------
 include/linux/tpm.h                | 13 ++++++++---
 security/integrity/ima/ima_queue.c |  5 ++++-
 security/keys/trusted.c            |  5 ++++-
 7 files changed, 62 insertions(+), 38 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index eb7c79ca8a94..911fea19e408 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -478,42 +478,30 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
  * tpm_pcr_extend - extend a PCR value in SHA1 bank.
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
  * @pcr_idx:	the PCR to be retrieved
- * @hash:	the hash value used to extend the PCR value
+ * @count:	number of tpm_extend_digest structures
+ * @digests:	array of tpm_extend_digest structures used to extend PCRs
  *
  * Note: with TPM 2.0 extends also those banks for which no digest was
  * specified in order to prevent malicious use of those PCR banks.
  *
  * Return: same as with tpm_transmit_cmd()
  */
-int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
+int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
+		   const struct tpm_extend_digest *digests)
 {
 	int rc;
-	struct tpm_digest *digest_list;
-	int i;
 
 	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		digest_list = kcalloc(chip->nr_allocated_banks,
-				      sizeof(*digest_list), GFP_KERNEL);
-		if (!digest_list)
-			return -ENOMEM;
-
-		for (i = 0; i < chip->nr_allocated_banks; i++) {
-			digest_list[i].alg_id = chip->allocated_banks[i].alg_id;
-			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
-		}
-
-		rc = tpm2_pcr_extend(chip, pcr_idx, chip->nr_allocated_banks,
-				     digest_list);
-		kfree(digest_list);
+		rc = tpm2_pcr_extend(chip, pcr_idx, count, digests);
 		tpm_put_ops(chip);
 		return rc;
 	}
 
-	rc = tpm1_pcr_extend(chip, pcr_idx, hash,
+	rc = tpm1_pcr_extend(chip, pcr_idx, count, digests,
 			     "attempting extend a PCR value");
 	tpm_put_ops(chip);
 	return rc;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 64d93d26087f..6b446504d2fe 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -504,7 +504,8 @@ int tpm1_auto_startup(struct tpm_chip *chip);
 int tpm1_do_selftest(struct tpm_chip *chip);
 int tpm1_get_timeouts(struct tpm_chip *chip);
 unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
-int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
+int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
+		    const struct tpm_extend_digest *digests,
 		    const char *log_msg);
 int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
@@ -551,7 +552,7 @@ int tpm2_get_timeouts(struct tpm_chip *chip);
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		  struct tpm_digest *digest, u16 *digest_size_ptr);
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
-		    struct tpm_digest *digests);
+		    const struct tpm_extend_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
 			    unsigned int flags);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 8b70a7f884a7..04ee10284b8c 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -449,12 +449,20 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 }
 
 #define TPM_ORD_PCR_EXTEND 20
-int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
+int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
+		    const struct tpm_extend_digest *digests,
 		    const char *log_msg)
 {
 	struct tpm_buf buf;
+	u8 dummy_hash[TPM_DIGEST_SIZE] = { 0 };
+	const u8 *hash;
 	int rc;
 
+	hash = dummy_hash;
+	if (count)
+		memcpy(dummy_hash, digests[0].data,
+		       min(digests[0].size, (u16)sizeof(dummy_hash)));
+
 	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
 	if (rc)
 		return rc;
@@ -743,7 +751,6 @@ int tpm1_auto_startup(struct tpm_chip *chip)
  */
 int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 {
-	u8 dummy_hash[TPM_DIGEST_SIZE] = { 0 };
 	struct tpm_buf buf;
 	unsigned int try;
 	int rc;
@@ -751,7 +758,7 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 
 	/* for buggy tpm, flush pcrs with extend to selected dummy */
 	if (tpm_suspend_pcr)
-		rc = tpm1_pcr_extend(chip, tpm_suspend_pcr, dummy_hash,
+		rc = tpm1_pcr_extend(chip, tpm_suspend_pcr, 0, NULL,
 				     "extending dummy pcr before suspend");
 
 	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_SAVESTATE);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 6ce5173cf0e5..77b5808270c6 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -247,21 +247,22 @@ struct tpm2_null_auth_area {
  *
  * @chip:	TPM chip to use.
  * @pcr_idx:	index of the PCR.
- * @count:	number of digests passed.
- * @digests:	list of pcr banks and corresponding digest values to extend.
+ * @count:	number of tpm_extend_digest passed.
+ * @digests:	array of tpm_extend_digest with digest values to extend.
  *
  * Return: Same as with tpm_transmit_cmd.
  */
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
-		    struct tpm_digest *digests)
+		    const struct tpm_extend_digest *digests)
 {
 	struct tpm_buf buf;
 	struct tpm2_null_auth_area auth_area;
+	const struct tpm_extend_digest *digest;
+	u8 dummy_hash[SHA512_DIGEST_SIZE] = { 0 };
+	const u8 *hash;
 	int rc;
 	int i;
-
-	if (count > chip->nr_allocated_banks)
-		return -EINVAL;
+	int j;
 
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
 	if (rc)
@@ -277,11 +278,25 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
 	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
 		       sizeof(auth_area));
-	tpm_buf_append_u32(&buf, count);
+	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
+
+	if (count)
+		memcpy(dummy_hash, digests[0].data, digests[0].size);
+
+	for (i = 0; i < chip->nr_allocated_banks; i++) {
+		tpm_buf_append_u16(&buf, chip->allocated_banks[i].alg_id);
+
+		hash = dummy_hash;
+		for (j = 0; j < count; j++) {
+			digest = digests + j;
+
+			if (digest->alg_id == chip->allocated_banks[i].alg_id) {
+				hash = digest->data;
+				break;
+			}
+		}
 
-	for (i = 0; i < count; i++) {
-		tpm_buf_append_u16(&buf, digests[i].alg_id);
-		tpm_buf_append(&buf, (const unsigned char *)&digests[i].digest,
+		tpm_buf_append(&buf, hash,
 			       chip->allocated_banks[i].digest_size);
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 72df8d4252ef..f865bfdc39dc 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -52,6 +52,12 @@ struct tpm_bank_info {
 	u16 crypto_id;
 };
 
+struct tpm_extend_digest {
+	u16 alg_id;
+	u16 size;
+	const u8 *data;
+};
+
 enum TPM_OPS_FLAGS {
 	TPM_OPS_AUTO_STARTUP = BIT(0),
 };
@@ -79,7 +85,8 @@ struct tpm_class_ops {
 extern int tpm_is_tpm2(struct tpm_chip *chip);
 extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 			struct tpm_digest *digest);
-extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash);
+extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
+			  const struct tpm_extend_digest *digests);
 extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
 extern int tpm_seal_trusted(struct tpm_chip *chip,
@@ -101,8 +108,8 @@ static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,
 	return -ENODEV;
 }
 
-static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
-				 const u8 *hash)
+static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
+				 const struct tpm_extend_digest *digests)
 {
 	return -ENODEV;
 }
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index b186819bd5aa..183733cfb5d2 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -140,12 +140,15 @@ unsigned long ima_get_binary_runtime_size(void)
 
 static int ima_pcr_extend(const u8 *hash, int pcr)
 {
+	struct tpm_extend_digest digest = { .alg_id = TPM_ALG_SHA1,
+					    .size = TPM_DIGEST_SIZE,
+					    .data = hash };
 	int result = 0;
 
 	if (!ima_tpm_chip)
 		return result;
 
-	result = tpm_pcr_extend(ima_tpm_chip, pcr, hash);
+	result = tpm_pcr_extend(ima_tpm_chip, pcr, 1, &digest);
 	if (result != 0)
 		pr_err("Error Communicating to TPM chip, result: %d\n", result);
 	return result;
diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index ff6789365a12..208a64a3fe1f 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -380,6 +380,9 @@ EXPORT_SYMBOL_GPL(trusted_tpm_send);
 static int pcrlock(const int pcrnum)
 {
 	unsigned char hash[SHA1_DIGEST_SIZE];
+	struct tpm_extend_digest digest = { .alg_id = TPM_ALG_SHA1,
+					    .size = sizeof(hash),
+					    .data = hash };
 	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -387,7 +390,7 @@ static int pcrlock(const int pcrnum)
 	ret = tpm_get_random(NULL, hash, SHA1_DIGEST_SIZE);
 	if (ret != SHA1_DIGEST_SIZE)
 		return ret;
-	return tpm_pcr_extend(NULL, pcrnum, hash) ? -EINVAL : 0;
+	return tpm_pcr_extend(NULL, pcrnum, 1, &digest) ? -EINVAL : 0;
 }
 
 /*
-- 
2.17.1

