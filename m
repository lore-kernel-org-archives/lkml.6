Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BDAECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C291320664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C291320664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeJaApQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:45:16 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32707 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbeJaApQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:45:16 -0400
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 83D28D21C2631;
        Tue, 30 Oct 2018 15:51:13 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.153)
 by smtpsuk.huawei.com (10.201.108.44) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 30 Oct 2018 15:51:05 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 4/5] tpm: retrieve digest size of unknown algorithms with PCR read
Date:   Tue, 30 Oct 2018 16:47:10 +0100
Message-ID: <20181030154711.2782-5-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030154711.2782-1-roberto.sassu@huawei.com>
References: <20181030154711.2782-1-roberto.sassu@huawei.com>
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
 drivers/char/tpm/tpm-interface.c | 10 ++++---
 drivers/char/tpm/tpm.h           |  4 +--
 drivers/char/tpm/tpm2-cmd.c      | 45 ++++++++++++++++++++++++--------
 include/linux/tpm.h              |  6 +++++
 4 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 4d0f5da5bf98..49761c88c21e 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -989,7 +989,7 @@ int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,
 	if (!chip)
 		return -ENODEV;
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		rc = tpm2_pcr_read(chip, pcr_idx, digest_struct);
+		rc = tpm2_pcr_read(chip, pcr_idx, digest_struct, NULL);
 	else
 		rc = tpm_pcr_read_dev(chip, pcr_idx, digest_struct->digest);
 	tpm_put_ops(chip);
@@ -1052,8 +1052,8 @@ int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
 		memset(digest_list, 0, sizeof(digest_list));
 
 		for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
-			    chip->active_banks[i]; i++) {
-			digest_list[i].alg_id = chip->active_banks[i];
+			    chip->active_banks[i].alg_id; i++) {
+			digest_list[i].alg_id = chip->active_banks[i].alg_id;
 			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
 			count++;
 		}
@@ -1154,6 +1154,10 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 		goto out;
 	}
 
+	chip->active_banks[0].alg_id = TPM_ALG_SHA1;
+	chip->active_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
+	chip->active_banks[0].crypto_id = HASH_ALGO_SHA1;
+
 	return rc;
 out:
 	if (rc > 0)
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 633e16f42107..8662e8587dce 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -237,7 +237,7 @@ struct tpm_chip {
 	const struct attribute_group *groups[3];
 	unsigned int groups_cnt;
 
-	u16 active_banks[7];
+	struct tpm_bank_info active_banks[7];
 #ifdef CONFIG_ACPI
 	acpi_handle acpi_dev_handle;
 	char ppi_version[TPM_PPI_VERSION_LEN + 1];
@@ -565,7 +565,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 }
 
 int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx,
-		  struct tpm_digest *digest_struct);
+		  struct tpm_digest *digest_struct, u16 *digest_size_ptr);
 int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
 		    struct tpm_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 8babd826ad27..8e821e7b4674 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -180,11 +180,12 @@ struct tpm2_pcr_read_out {
  * @chip:	TPM chip to use.
  * @pcr_idx:	index of the PCR to read.
  * @digest_struct:	pcr bank and buffer current PCR value is written to.
+ * @digest_size_ptr:	pointer to variable that stores the digest size.
  *
  * Return: Same as with tpm_transmit_cmd.
  */
 int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx,
-		  struct tpm_digest *digest_struct)
+		  struct tpm_digest *digest_struct, u16 *digest_size_ptr)
 {
 	int rc;
 	struct tpm_buf buf;
@@ -219,6 +220,9 @@ int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx,
 		goto out;
 	}
 
+	if (digest_size_ptr)
+		*digest_size_ptr = digest_size;
+
 	memcpy(digest_struct->digest, out->digest, digest_size);
 out:
 	tpm_buf_destroy(&buf);
@@ -249,7 +253,6 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
 	struct tpm2_null_auth_area auth_area;
 	int rc;
 	int i;
-	int j;
 
 	if (count > ARRAY_SIZE(chip->active_banks))
 		return -EINVAL;
@@ -271,14 +274,9 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
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
+			       chip->active_banks[i].digest_size);
 	}
 
 	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
@@ -855,6 +853,26 @@ int tpm2_probe(struct tpm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(tpm2_probe);
 
+static int tpm2_init_bank_info(struct tpm_chip *chip,
+			       struct tpm_bank_info *bank)
+{
+	struct tpm_digest digest = {.alg_id = bank->alg_id};
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
@@ -909,7 +927,12 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 		}
 
 		memcpy(&pcr_selection, marker, sizeof(pcr_selection));
-		chip->active_banks[i] = be16_to_cpu(pcr_selection.hash_alg);
+		chip->active_banks[i].alg_id =
+			be16_to_cpu(pcr_selection.hash_alg);
+		rc =  tpm2_init_bank_info(chip, &chip->active_banks[i]);
+		if (rc)
+			break;
+
 		sizeof_pcr_selection = sizeof(pcr_selection.hash_alg) +
 			sizeof(pcr_selection.size_of_select) +
 			pcr_selection.size_of_select;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4f00daf44dd2..3f91124837cf 100644
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

