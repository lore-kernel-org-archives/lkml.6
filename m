Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E118DC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDED22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDED22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbeKOBjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:39:54 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32769 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727731AbeKOBjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:39:54 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id F0A705EEB3D67;
        Wed, 14 Nov 2018 15:36:07 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.153)
 by smtpsuk.huawei.com (10.201.108.37) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 14 Nov 2018 15:36:03 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>,
        <david.safford@ge.com>, <monty.wiseman@ge.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v5 5/7] tpm: retrieve digest size of unknown algorithms with PCR read
Date:   Wed, 14 Nov 2018 16:31:06 +0100
Message-ID: <20181114153108.12907-6-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114153108.12907-1-roberto.sassu@huawei.com>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.153]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the TPM driver retrieves the digest size from a table mapping
TPM algorithms identifiers to identifiers defined by the crypto subsystem.
If the algorithm is not defined by the latter, the digest size can be
retrieved from the output of the PCR read command.

The patch retrieves at TPM startup the digest sizes for each PCR bank and
stores them in the new structure tpm_bank_info, member of tpm_chip, so that
the information can be passed to other kernel subsystems.

tpm_bank_info contains: the TPM algorithm identifier, necessary to generate
the event log as defined by Trusted Computing Group (TCG); the digest size,
to pad/truncate a digest calculated with a different algorithm; the crypto
subsystem identifier, to calculate the digest of event data.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
---
 drivers/char/tpm/tpm-interface.c |  9 +++----
 drivers/char/tpm/tpm.h           |  4 +--
 drivers/char/tpm/tpm1-cmd.c      |  4 ++-
 drivers/char/tpm/tpm2-cmd.c      | 45 ++++++++++++++++++++++++--------
 include/linux/tpm.h              |  6 +++++
 5 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 04aa39432f58..f0e1456440d7 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -465,7 +465,7 @@ int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		return -ENODEV;
 
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		rc = tpm2_pcr_read(chip, pcr_idx, digest_struct);
+		rc = tpm2_pcr_read(chip, pcr_idx, digest_struct, NULL);
 	else
 		rc = tpm1_pcr_read(chip, pcr_idx, digest_struct->digest);
 
@@ -480,9 +480,8 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
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
@@ -503,7 +502,7 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
 			return -ENOMEM;
 
 		for (i = 0; i < chip->nr_allocated_banks; i++) {
-			digest_list[i].alg_id = chip->allocated_banks[i];
+			digest_list[i].alg_id = chip->allocated_banks[i].alg_id;
 			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
 		}
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 33b293da69d6..023ddf42038b 100644
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
@@ -549,7 +549,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 
 int tpm2_get_timeouts(struct tpm_chip *chip);
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
-		  struct tpm_digest *digest_struct);
+		  struct tpm_digest *digest_struct, u16 *digest_size_ptr);
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 		    struct tpm_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index ec4f197bae0a..8b70a7f884a7 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -716,7 +716,9 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 		goto out;
 	}
 
-	chip->allocated_banks[0] = TPM_ALG_SHA1;
+	chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
+	chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
+	chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
 	chip->nr_allocated_banks = 1;
 
 	return rc;
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 0d72c2f98bd6..acaaab72ef2e 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -172,11 +172,12 @@ struct tpm2_pcr_read_out {
  * @chip:	TPM chip to use.
  * @pcr_idx:	index of the PCR to read.
  * @digest_struct:	PCR bank and buffer current PCR value is written to.
+ * @digest_size_ptr:	pointer to variable that stores the digest size.
  *
  * Return: Same as with tpm_transmit_cmd.
  */
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
-		  struct tpm_digest *digest_struct)
+		  struct tpm_digest *digest_struct, u16 *digest_size_ptr)
 {
 	int rc;
 	struct tpm_buf buf;
@@ -211,6 +212,9 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		goto out;
 	}
 
+	if (digest_size_ptr)
+		*digest_size_ptr = digest_size;
+
 	memcpy(digest_struct->digest, out->digest, digest_size);
 out:
 	tpm_buf_destroy(&buf);
@@ -241,7 +245,6 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 	struct tpm2_null_auth_area auth_area;
 	int rc;
 	int i;
-	int j;
 
 	if (count > chip->nr_allocated_banks)
 		return -EINVAL;
@@ -263,14 +266,9 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
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
@@ -821,6 +819,26 @@ int tpm2_probe(struct tpm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(tpm2_probe);
 
+static int tpm2_init_bank_info(struct tpm_chip *chip, u32 bank_index)
+{
+	struct tpm_bank_info *bank = chip->allocated_banks + bank_index;
+	struct tpm_digest digest = { .alg_id = bank->alg_id };
+	int i;
+
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
@@ -888,7 +906,12 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 				break;
 
 		if (j < pcr_selection.size_of_select) {
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
index 077fd31783ad..fcdd33ae9969 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -46,6 +46,12 @@ struct tpm_digest {
 	u8 digest[SHA512_DIGEST_SIZE];
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
-- 
2.17.1

