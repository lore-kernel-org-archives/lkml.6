Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F51C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2CD2082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2CD2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbeLDI0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:26:37 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32794 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbeLDI0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:26:36 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 3C49041DC124E;
        Tue,  4 Dec 2018 08:26:33 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.153)
 by smtpsuk.huawei.com (10.201.108.42) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 4 Dec 2018 08:26:27 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>,
        <david.safford@ge.com>, <monty.wiseman@ge.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v6 4/7] tpm: modify tpm_pcr_read() definition to pass a TPM hash algorithm
Date:   Tue, 4 Dec 2018 09:21:35 +0100
Message-ID: <20181204082138.24600-5-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204082138.24600-1-roberto.sassu@huawei.com>
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.153]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the TPM driver allows other kernel subsystems to read only the
SHA1 PCR bank. This patch modifies the parameters of tpm_pcr_read() and
tpm2_pcr_read() to pass a tpm_digest structure, which contains the desired
hash algorithm. Also, since commit 125a22105410 ("tpm: React correctly to
RC_TESTING from TPM 2.0 self tests") removed the call to tpm2_pcr_read(),
the new parameter is expected to be always not NULL.

Due to the API change, IMA functions have been modified.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
---
 drivers/char/tpm/tpm-interface.c    |  9 +++++----
 drivers/char/tpm/tpm.h              |  3 ++-
 drivers/char/tpm/tpm2-cmd.c         | 23 ++++++++++++++++-------
 include/linux/tpm.h                 |  6 ++++--
 security/integrity/ima/ima_crypto.c | 10 +++++-----
 5 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 96c8261d0f04..cea4c8d75ad0 100644
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
+		rc = tpm2_pcr_read(chip, pcr_idx, digest);
 	else
-		rc = tpm1_pcr_read(chip, pcr_idx, res_buf);
+		rc = tpm1_pcr_read(chip, pcr_idx, digest->digest);
 
 	tpm_put_ops(chip);
 	return rc;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index e961e5c5d197..343aa58424f7 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -548,7 +548,8 @@ static inline u32 tpm2_rc_value(u32 rc)
 }
 
 int tpm2_get_timeouts(struct tpm_chip *chip);
-int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
+int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
+		  struct tpm_digest *digest);
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 		    struct tpm_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 4afd14892cbf..81740d55f19c 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -171,16 +171,18 @@ struct tpm2_pcr_read_out {
  * tpm2_pcr_read() - read a PCR value
  * @chip:	TPM chip to use.
  * @pcr_idx:	index of the PCR to read.
- * @res_buf:	buffer to store the resulting hash.
+ * @digest:	PCR bank and buffer current PCR value is written to.
  *
  * Return: Same as with tpm_transmit_cmd.
  */
-int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
+int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
+		  struct tpm_digest *digest)
 {
 	int rc;
 	struct tpm_buf buf;
 	struct tpm2_pcr_read_out *out;
 	u8 pcr_select[TPM2_PCR_SELECT_MIN] = {0};
+	u16 digest_size;
 
 	if (pcr_idx >= TPM2_PLATFORM_PCR)
 		return -EINVAL;
@@ -192,18 +194,25 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
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
+	if (digest_size > sizeof(digest->digest)) {
+		rc = -EINVAL;
+		goto out;
 	}
 
+	memcpy(digest->digest, out->digest, digest_size);
+out:
 	tpm_buf_destroy(&buf);
 	return rc;
 }
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 330c0a481581..95e11688826e 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -71,7 +71,8 @@ struct tpm_class_ops {
 #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
 
 extern int tpm_is_tpm2(struct tpm_chip *chip);
-extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
+extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
+			struct tpm_digest *digest);
 extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash);
 extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
@@ -88,7 +89,8 @@ static inline int tpm_is_tpm2(struct tpm_chip *chip)
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

