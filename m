Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77817C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE592073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE592073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeI2FBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:01:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:9469 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbeI2FBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:01:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 15:35:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,316,1534834800"; 
   d="scan'208";a="267880293"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga006.fm.intel.com with ESMTP; 28 Sep 2018 15:35:20 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v5 16/21] tpm: tpm1: rewrite tpm1_get_random() using tpm_buf structure
Date:   Sat, 29 Sep 2018 01:30:30 +0300
Message-Id: <20180928223035.14471-17-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180928223035.14471-1-tomas.winkler@intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Use tpm_buf in tpm1_get_random()
2. Fix comment in tpm_get_random() so it is clear that
the function is expected to return number of random bytes.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
V3: New in the series.
V4: Resend.
V5: A small adjustment in the kdoc.

 drivers/char/tpm/tpm-interface.c |  2 +-
 drivers/char/tpm/tpm.h           | 11 ------
 drivers/char/tpm/tpm1-cmd.c      | 84 +++++++++++++++++++++++-----------------
 3 files changed, 49 insertions(+), 48 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 98f9a0bbeed9..0af71d53d129 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -586,7 +586,7 @@ EXPORT_SYMBOL_GPL(tpm_pm_resume);
  * @out:	destination buffer for the random bytes
  * @max:	the max number of bytes to write to @out
  *
- * Return: same as with tpm_transmit_cmd()
+ * Return: number of random bytes read or a negative error value.
  */
 int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 {
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 4ccffbb56864..d6eca81a011a 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -396,20 +396,9 @@ struct tpm_pcrread_in {
  * compiler warnings about stack frame size. */
 #define TPM_MAX_RNG_DATA	128
 
-struct tpm_getrandom_out {
-	__be32 rng_data_len;
-	u8     rng_data[TPM_MAX_RNG_DATA];
-} __packed;
-
-struct tpm_getrandom_in {
-	__be32 num_bytes;
-} __packed;
-
 typedef union {
 	struct	tpm_pcrread_in	pcrread_in;
 	struct	tpm_pcrread_out	pcrread_out;
-	struct	tpm_getrandom_in getrandom_in;
-	struct	tpm_getrandom_out getrandom_out;
 } tpm_cmd_params;
 
 struct tpm_cmd_t {
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 8a84db315676..b5c4fa158c30 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -505,58 +505,70 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 EXPORT_SYMBOL_GPL(tpm1_getcap);
 
 #define TPM_ORD_GET_RANDOM 70
-#define TPM_GETRANDOM_RESULT_SIZE	18
-static const struct tpm_input_header tpm_getrandom_header = {
-	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
-	.length = cpu_to_be32(14),
-	.ordinal = cpu_to_be32(TPM_ORD_GET_RANDOM)
-};
+struct tpm1_get_random_out {
+	__be32 rng_data_len;
+	u8 rng_data[TPM_MAX_RNG_DATA];
+} __packed;
 
-int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max)
+/**
+ * tpm1_get_random() - get random bytes from the TPM's RNG
+ * @chip:	a &struct tpm_chip instance
+ * @dest:	destination buffer for the random bytes
+ * @max:	the maximum number of bytes to write to @dest
+ *
+ * Return:
+ * *  number of bytes read
+ * * -errno or a TPM return code otherwise
+ */
+int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
-	struct tpm_cmd_t tpm_cmd;
+	struct tpm1_get_random_out *out;
+	u32 num_bytes =  min_t(u32, max, TPM_MAX_RNG_DATA);
+	struct tpm_buf buf;
+	u32 total = 0;
+	int retries = 5;
 	u32 recd;
-	u32 num_bytes = min_t(u32, max, TPM_MAX_RNG_DATA);
-	u32 rlength;
-	int err, total = 0, retries = 5;
-	u8 *dest = out;
+	int rc;
 
-	if (!out || !num_bytes || max > TPM_MAX_RNG_DATA)
-		return -EINVAL;
+	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
+	if (rc)
+		return rc;
 
 	do {
-		tpm_cmd.header.in = tpm_getrandom_header;
-		tpm_cmd.params.getrandom_in.num_bytes = cpu_to_be32(num_bytes);
-
-		err = tpm_transmit_cmd(chip, NULL, &tpm_cmd,
-				       TPM_GETRANDOM_RESULT_SIZE + num_bytes,
-				       offsetof(struct tpm_getrandom_out,
-						rng_data),
-				       0, "attempting get random");
-		if (err)
-			break;
+		tpm_buf_append_u32(&buf, num_bytes);
+
+		rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
+				      sizeof(out->rng_data_len), 0,
+				      "attempting get random");
+		if (rc)
+			goto out;
 
-		recd = be32_to_cpu(tpm_cmd.params.getrandom_out.rng_data_len);
+		out = (struct tpm1_get_random_out *)&buf.data[TPM_HEADER_SIZE];
+
+		recd = be32_to_cpu(out->rng_data_len);
 		if (recd > num_bytes) {
-			total = -EFAULT;
-			break;
+			rc = -EFAULT;
+			goto out;
 		}
 
-		rlength = be32_to_cpu(tpm_cmd.header.out.length);
-		if (rlength < TPM_HEADER_SIZE +
-			      offsetof(struct tpm_getrandom_out, rng_data) +
-			      recd) {
-			total = -EFAULT;
-			break;
+		if (tpm_buf_length(&buf) < TPM_HEADER_SIZE +
+					   sizeof(out->rng_data_len) + recd) {
+			rc = -EFAULT;
+			goto out;
 		}
-		memcpy(dest, tpm_cmd.params.getrandom_out.rng_data, recd);
+		memcpy(dest, out->rng_data, recd);
 
 		dest += recd;
 		total += recd;
 		num_bytes -= recd;
-	} while (retries-- && (size_t)total < max);
 
-	return total ? total : -EIO;
+		tpm_buf_reset(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
+	} while (retries-- && total < max);
+
+	rc = total ? (int)total : -EIO;
+out:
+	tpm_buf_destroy(&buf);
+	return rc;
 }
 
 #define TPM_ORDINAL_PCRREAD 21
-- 
2.14.4

