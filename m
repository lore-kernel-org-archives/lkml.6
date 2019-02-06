Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8B1C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC10218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbfBFQ2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:28:02 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32878 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727082AbfBFQ2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:28:01 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 59E544DA04317A2C0B5F;
        Wed,  6 Feb 2019 16:28:00 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.33) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 6 Feb 2019 16:27:51 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>,
        <david.safford@ge.com>, <monty.wiseman@ge.com>,
        <matthewgarrett@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v10, RESEND 1/6] tpm: dynamically allocate the allocated_banks array
Date:   Wed, 6 Feb 2019 17:24:47 +0100
Message-ID: <20190206162452.7749-2-roberto.sassu@huawei.com>
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

This patch renames active_banks (member of tpm_chip) to allocated_banks,
stores the number of allocated PCR banks in nr_allocated_banks (new member
of tpm_chip), and replaces the static array with a pointer to a dynamically
allocated array.

tpm2_get_pcr_allocation() determines if a PCR bank is allocated by checking
the mask in the TPML_PCR_SELECTION structure returned by the TPM for
TPM2_Get_Capability(). If a bank is not allocated, the TPM returns that
bank in TPML_PCR_SELECTION, with all bits in the mask set to zero. In this
case, the bank is not included in chip->allocated_banks, to avoid that TPM
driver users unnecessarily calculate a digest for that bank.

One PCR bank with algorithm set to SHA1 is always allocated for TPM 1.x.

As a consequence of the introduction of nr_allocated_banks,
tpm_pcr_extend() does not check anymore if the algorithm stored in tpm_chip
is equal to zero.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-chip.c      |  1 +
 drivers/char/tpm/tpm-interface.c | 18 ++++++++++--------
 drivers/char/tpm/tpm.h           |  3 ++-
 drivers/char/tpm/tpm1-cmd.c      | 10 ++++++++++
 drivers/char/tpm/tpm2-cmd.c      | 31 +++++++++++++++++++++----------
 5 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 2019635d0f70..9865776ee2cd 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -265,6 +265,7 @@ static void tpm_dev_release(struct device *dev)
 	kfree(chip->log.bios_event_log);
 	kfree(chip->work_space.context_buf);
 	kfree(chip->work_space.session_buf);
+	kfree(chip->allocated_banks);
 	kfree(chip);
 }
 
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index ce39fe043bcb..24f0eed531a0 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -309,8 +309,7 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
 int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
 {
 	int rc;
-	struct tpm2_digest digest_list[ARRAY_SIZE(chip->active_banks)];
-	u32 count = 0;
+	struct tpm2_digest *digest_list;
 	int i;
 
 	chip = tpm_find_get_ops(chip);
@@ -318,16 +317,19 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
 		return -ENODEV;
 
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		memset(digest_list, 0, sizeof(digest_list));
+		digest_list = kcalloc(chip->nr_allocated_banks,
+				      sizeof(*digest_list), GFP_KERNEL);
+		if (!digest_list)
+			return -ENOMEM;
 
-		for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
-			    chip->active_banks[i] != TPM2_ALG_ERROR; i++) {
-			digest_list[i].alg_id = chip->active_banks[i];
+		for (i = 0; i < chip->nr_allocated_banks; i++) {
+			digest_list[i].alg_id = chip->allocated_banks[i];
 			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
-			count++;
 		}
 
-		rc = tpm2_pcr_extend(chip, pcr_idx, count, digest_list);
+		rc = tpm2_pcr_extend(chip, pcr_idx, chip->nr_allocated_banks,
+				     digest_list);
+		kfree(digest_list);
 		tpm_put_ops(chip);
 		return rc;
 	}
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 183e2b93e0fe..cd330ace6248 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -257,7 +257,8 @@ struct tpm_chip {
 	const struct attribute_group *groups[3];
 	unsigned int groups_cnt;
 
-	u16 active_banks[7];
+	u32 nr_allocated_banks;
+	u16 *allocated_banks;
 #ifdef CONFIG_ACPI
 	acpi_handle acpi_dev_handle;
 	char ppi_version[TPM_PPI_VERSION_LEN + 1];
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index ec5f3693c096..e7d3228a0f37 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -696,6 +696,16 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 		goto out;
 	}
 
+	chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
+					GFP_KERNEL);
+	if (!chip->allocated_banks) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	chip->allocated_banks[0] = TPM2_ALG_SHA1;
+	chip->nr_allocated_banks = 1;
+
 	return rc;
 out:
 	if (rc > 0)
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 971d46efaca5..bd20b9a61fc0 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -234,7 +234,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 	int i;
 	int j;
 
-	if (count > ARRAY_SIZE(chip->active_banks))
+	if (count > chip->nr_allocated_banks)
 		return -EINVAL;
 
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
@@ -808,8 +808,10 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	void *marker;
 	void *end;
 	void *pcr_select_offset;
-	unsigned int count;
 	u32 sizeof_pcr_selection;
+	u32 nr_possible_banks;
+	u32 nr_alloc_banks = 0;
+	u16 hash_alg;
 	u32 rsp_len;
 	int rc;
 	int i = 0;
@@ -826,11 +828,14 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	if (rc)
 		goto out;
 
-	count = be32_to_cpup(
+	nr_possible_banks = be32_to_cpup(
 		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
 
-	if (count > ARRAY_SIZE(chip->active_banks)) {
-		rc = -ENODEV;
+	chip->allocated_banks = kcalloc(nr_possible_banks,
+					sizeof(*chip->allocated_banks),
+					GFP_KERNEL);
+	if (!chip->allocated_banks) {
+		rc = -ENOMEM;
 		goto out;
 	}
 
@@ -839,7 +844,7 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	rsp_len = be32_to_cpup((__be32 *)&buf.data[2]);
 	end = &buf.data[rsp_len];
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < nr_possible_banks; i++) {
 		pcr_select_offset = marker +
 			offsetof(struct tpm2_pcr_selection, size_of_select);
 		if (pcr_select_offset >= end) {
@@ -848,17 +853,23 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 		}
 
 		memcpy(&pcr_selection, marker, sizeof(pcr_selection));
-		chip->active_banks[i] = be16_to_cpu(pcr_selection.hash_alg);
+		hash_alg = be16_to_cpu(pcr_selection.hash_alg);
+
+		pcr_select_offset = memchr_inv(pcr_selection.pcr_select, 0,
+					       pcr_selection.size_of_select);
+		if (pcr_select_offset) {
+			chip->allocated_banks[nr_alloc_banks] = hash_alg;
+			nr_alloc_banks++;
+		}
+
 		sizeof_pcr_selection = sizeof(pcr_selection.hash_alg) +
 			sizeof(pcr_selection.size_of_select) +
 			pcr_selection.size_of_select;
 		marker = marker + sizeof_pcr_selection;
 	}
 
+	chip->nr_allocated_banks = nr_alloc_banks;
 out:
-	if (i < ARRAY_SIZE(chip->active_banks))
-		chip->active_banks[i] = TPM2_ALG_ERROR;
-
 	tpm_buf_destroy(&buf);
 
 	return rc;
-- 
2.17.1

