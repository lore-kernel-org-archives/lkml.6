Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B146C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4B620811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4B620811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbeLMKeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:34:12 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32813 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728392AbeLMKeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:34:11 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id EE52382358FE6;
        Thu, 13 Dec 2018 10:34:06 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.153)
 by smtpsuk.huawei.com (10.201.108.48) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 13 Dec 2018 10:34:01 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>,
        <david.safford@ge.com>, <monty.wiseman@ge.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v7 3/5] tpm: rename and export tpm2_digest and tpm2_algorithms
Date:   Thu, 13 Dec 2018 11:29:43 +0100
Message-ID: <20181213102945.30946-4-roberto.sassu@huawei.com>
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

Rename tpm2_* to tpm_* and move the definitions to include/linux/tpm.h so
that these can be used by other kernel subsystems (e.g. IMA).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
---
 drivers/char/tpm/tpm-interface.c |  2 +-
 drivers/char/tpm/tpm.h           | 13 +------------
 drivers/char/tpm/tpm1-cmd.c      |  2 +-
 drivers/char/tpm/tpm2-cmd.c      | 18 +++++++++---------
 include/linux/tpm.h              | 18 ++++++++++++++++++
 include/linux/tpm_eventlog.h     |  9 ++-------
 6 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 7b80919228be..96c8261d0f04 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -488,7 +488,7 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
 int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
 {
 	int rc;
-	struct tpm2_digest *digest_list;
+	struct tpm_digest *digest_list;
 	int i;
 
 	chip = tpm_find_get_ops(chip);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 6b94306ab7c5..e961e5c5d197 100644
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
 	TPM2_CC_FIRST		        = 0x011F,
 	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
@@ -561,7 +550,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 int tpm2_get_timeouts(struct tpm_chip *chip);
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
-		    struct tpm2_digest *digests);
+		    struct tpm_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
 			    unsigned int flags);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 0874743ca96d..ec4f197bae0a 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -716,7 +716,7 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 		goto out;
 	}
 
-	chip->allocated_banks[0] = TPM2_ALG_SHA1;
+	chip->allocated_banks[0] = TPM_ALG_SHA1;
 	chip->nr_allocated_banks = 1;
 
 	return rc;
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 245669a7aba5..4afd14892cbf 100644
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
 
 int tpm2_get_timeouts(struct tpm_chip *chip)
@@ -192,7 +192,7 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 	pcr_select[pcr_idx >> 3] = 1 << (pcr_idx & 0x7);
 
 	tpm_buf_append_u32(&buf, 1);
-	tpm_buf_append_u16(&buf, TPM2_ALG_SHA1);
+	tpm_buf_append_u16(&buf, TPM_ALG_SHA1);
 	tpm_buf_append_u8(&buf, TPM2_PCR_SELECT_MIN);
 	tpm_buf_append(&buf, (const unsigned char *)pcr_select,
 		       sizeof(pcr_select));
@@ -226,7 +226,7 @@ struct tpm2_null_auth_area {
  * Return: Same as with tpm_transmit_cmd.
  */
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
-		    struct tpm2_digest *digests)
+		    struct tpm_digest *digests)
 {
 	struct tpm_buf buf;
 	struct tpm2_null_auth_area auth_area;
@@ -449,7 +449,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 
 	/* public */
 	tpm_buf_append_u16(&buf, 14 + options->policydigest_len);
-	tpm_buf_append_u16(&buf, TPM2_ALG_KEYEDHASH);
+	tpm_buf_append_u16(&buf, TPM_ALG_KEYEDHASH);
 	tpm_buf_append_u16(&buf, hash);
 
 	/* policy */
@@ -464,7 +464,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	}
 
 	/* public parameters */
-	tpm_buf_append_u16(&buf, TPM2_ALG_NULL);
+	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
 	tpm_buf_append_u16(&buf, 0);
 
 	/* outside info */
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index b49a55cf775f..330c0a481581 100644
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
index f47342361e87..81519f163211 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -3,7 +3,7 @@
 #ifndef __LINUX_TPM_EVENTLOG_H__
 #define __LINUX_TPM_EVENTLOG_H__
 
-#include <crypto/hash_info.h>
+#include <linux/tpm.h>
 
 #define TCG_EVENT_NAME_LEN_MAX	255
 #define MAX_TEXT_EVENT		1000	/* Max event string length */
@@ -105,16 +105,11 @@ struct tcg_event_field {
 	u8 event[0];
 } __packed;
 
-struct tpm2_digest {
-	u16 alg_id;
-	u8 digest[SHA512_DIGEST_SIZE];
-} __packed;
-
 struct tcg_pcr_event2_head {
 	u32 pcr_idx;
 	u32 event_type;
 	u32 count;
-	struct tpm2_digest digests[];
+	struct tpm_digest digests[];
 } __packed;
 
 #endif
-- 
2.17.1

