Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9F7C46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7615620685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7615620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbeKGAby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:31:54 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32717 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387593AbeKGAby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:31:54 -0500
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 001AB12F4791E;
        Tue,  6 Nov 2018 15:06:12 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.153)
 by smtpsuk.huawei.com (10.201.108.35) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 6 Nov 2018 15:06:04 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 3/6] tpm: rename and export tpm2_digest and tpm2_algorithms
Date:   Tue, 6 Nov 2018 16:01:56 +0100
Message-ID: <20181106150159.1136-4-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181106150159.1136-1-roberto.sassu@huawei.com>
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.153]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename tpm2_* to tpm_* and move the definitions to include/linux/tpm.h so
that these can be used by other kernel subsystems (e.g. IMA).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
---
 drivers/char/tpm/tpm-interface.c |  2 +-
 drivers/char/tpm/tpm.h           | 13 +------------
 drivers/char/tpm/tpm2-cmd.c      | 18 +++++++++---------
 include/linux/tpm.h              | 18 ++++++++++++++++++
 include/linux/tpm_eventlog.h     |  9 ++-------
 5 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index ba7ca6b3e664..07b62734598c 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -1039,7 +1039,7 @@ static int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
 int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
 {
 	int rc;
-	struct tpm2_digest *digest_list;
+	struct tpm_digest *digest_list;
 	int i;
 
 	chip = tpm_find_get_ops(chip);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 98368c3a6ff7..fc2cc16e5080 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -122,17 +122,6 @@ enum tpm2_return_codes {
 	TPM2_RC_RETRY		= 0x0922,
 };
 
-enum tpm2_algorithms {
-	TPM2_ALG_ERROR		= 0x0000,
-	TPM2_ALG_SHA1		= 0x0004,
-	TPM2_ALG_KEYEDHASH	= 0x0008,
-	TPM2_ALG_SHA256		= 0x000B,
-	TPM2_ALG_SHA384		= 0x000C,
-	TPM2_ALG_SHA512		= 0x000D,
-	TPM2_ALG_NULL		= 0x0010,
-	TPM2_ALG_SM3_256	= 0x0012,
-};
-
 enum tpm2_command_codes {
 	TPM2_CC_FIRST		= 0x011F,
 	TPM2_CC_CREATE_PRIMARY  = 0x0131,
@@ -578,7 +567,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 
 int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
 int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
-		    struct tpm2_digest *digests);
+		    struct tpm_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
 			    unsigned int flags);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 533089cede07..584dba6cdf3e 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -33,11 +33,11 @@ struct tpm2_hash {
 };
 
 static struct tpm2_hash tpm2_hash_map[] = {
-	{HASH_ALGO_SHA1, TPM2_ALG_SHA1},
-	{HASH_ALGO_SHA256, TPM2_ALG_SHA256},
-	{HASH_ALGO_SHA384, TPM2_ALG_SHA384},
-	{HASH_ALGO_SHA512, TPM2_ALG_SHA512},
-	{HASH_ALGO_SM3_256, TPM2_ALG_SM3_256},
+	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
+	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
+	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
+	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
+	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
 };
 
 /*
@@ -200,7 +200,7 @@ int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
 	pcr_select[pcr_idx >> 3] = 1 << (pcr_idx & 0x7);
 
 	tpm_buf_append_u32(&buf, 1);
-	tpm_buf_append_u16(&buf, TPM2_ALG_SHA1);
+	tpm_buf_append_u16(&buf, TPM_ALG_SHA1);
 	tpm_buf_append_u8(&buf, TPM2_PCR_SELECT_MIN);
 	tpm_buf_append(&buf, (const unsigned char *)pcr_select,
 		       sizeof(pcr_select));
@@ -234,7 +234,7 @@ struct tpm2_null_auth_area {
  * Return: Same as with tpm_transmit_cmd.
  */
 int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
-		    struct tpm2_digest *digests)
+		    struct tpm_digest *digests)
 {
 	struct tpm_buf buf;
 	struct tpm2_null_auth_area auth_area;
@@ -457,7 +457,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 
 	/* public */
 	tpm_buf_append_u16(&buf, 14 + options->policydigest_len);
-	tpm_buf_append_u16(&buf, TPM2_ALG_KEYEDHASH);
+	tpm_buf_append_u16(&buf, TPM_ALG_KEYEDHASH);
 	tpm_buf_append_u16(&buf, hash);
 
 	/* policy */
@@ -472,7 +472,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	}
 
 	/* public parameters */
-	tpm_buf_append_u16(&buf, TPM2_ALG_NULL);
+	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
 	tpm_buf_append_u16(&buf, 0);
 
 	/* outside info */
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4609b94142d4..71d7bbf5f690 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -22,12 +22,30 @@
 #ifndef __LINUX_TPM_H__
 #define __LINUX_TPM_H__
 
+#include <crypto/hash_info.h>
+
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
 
 struct tpm_chip;
 struct trusted_key_payload;
 struct trusted_key_options;
 
+enum tpm_algorithms {
+	TPM_ALG_ERROR		= 0x0000,
+	TPM_ALG_SHA1		= 0x0004,
+	TPM_ALG_KEYEDHASH	= 0x0008,
+	TPM_ALG_SHA256		= 0x000B,
+	TPM_ALG_SHA384		= 0x000C,
+	TPM_ALG_SHA512		= 0x000D,
+	TPM_ALG_NULL		= 0x0010,
+	TPM_ALG_SM3_256		= 0x0012,
+};
+
+struct tpm_digest {
+	u16 alg_id;
+	u8 digest[SHA512_DIGEST_SIZE];
+} __packed;
+
 enum TPM_OPS_FLAGS {
 	TPM_OPS_AUTO_STARTUP = BIT(0),
 };
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 3d5d162f09cc..c9f28b4be4ae 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -3,7 +3,7 @@
 #ifndef __LINUX_TPM_EVENTLOG_H__
 #define __LINUX_TPM_EVENTLOG_H__
 
-#include <crypto/hash_info.h>
+#include <linux/tpm.h>
 
 #define TCG_EVENT_NAME_LEN_MAX	255
 #define MAX_TEXT_EVENT		1000	/* Max event string length */
@@ -107,16 +107,11 @@ struct tcg_event_field {
 	u8 event[0];
 } __packed;
 
-struct tpm2_digest {
-	u16 alg_id;
-	u8 digest[SHA512_DIGEST_SIZE];
-} __packed;
-
 struct tcg_pcr_event2 {
 	u32 pcr_idx;
 	u32 event_type;
 	u32 count;
-	struct tpm2_digest digests[0];
+	struct tpm_digest digests[0];
 	struct tcg_event_field event;
 } __packed;
 
-- 
2.17.1

