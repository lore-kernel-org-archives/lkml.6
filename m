Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04839C04ABA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC69206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC69206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbeIRPLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:11:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:59396 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729279AbeIRPKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:10:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 02:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="71724154"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2018 02:38:11 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v3 08/20] tpm: factor out tpm1_get_random into tpm1-cmd.c
Date:   Tue, 18 Sep 2018 12:34:47 +0300
Message-Id: <20180918093459.19165-9-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180918093459.19165-1-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out get random implementation from tpm-interface.c
into tpm1_get_random function in tpm1-cmd.c.
No functional changes.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2-V3: Rebase

 drivers/char/tpm/tpm-interface.c | 58 +++++-----------------------------------
 drivers/char/tpm/tpm.h           |  1 +
 drivers/char/tpm/tpm1-cmd.c      | 55 +++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 51 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 59ca0cdda811..c15957fef08f 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -801,14 +801,6 @@ int tpm_pm_resume(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(tpm_pm_resume);
 
-#define TPM_ORD_GET_RANDOM 70
-#define TPM_GETRANDOM_RESULT_SIZE	18
-static const struct tpm_input_header tpm_getrandom_header = {
-	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
-	.length = cpu_to_be32(14),
-	.ordinal = cpu_to_be32(TPM_ORD_GET_RANDOM)
-};
-
 /**
  * tpm_get_random() - get random bytes from the TPM's RNG
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
@@ -819,58 +811,22 @@ static const struct tpm_input_header tpm_getrandom_header = {
  */
 int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 {
-	struct tpm_cmd_t tpm_cmd;
-	u32 recd, num_bytes = min_t(u32, max, TPM_MAX_RNG_DATA), rlength;
-	int err, total = 0, retries = 5;
-	u8 *dest = out;
+	int rc;
 
-	if (!out || !num_bytes || max > TPM_MAX_RNG_DATA)
+	if (!out || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
 	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		err = tpm2_get_random(chip, out, max);
-		tpm_put_ops(chip);
-		return err;
-	}
-
-	do {
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
-
-		recd = be32_to_cpu(tpm_cmd.params.getrandom_out.rng_data_len);
-		if (recd > num_bytes) {
-			total = -EFAULT;
-			break;
-		}
-
-		rlength = be32_to_cpu(tpm_cmd.header.out.length);
-		if (rlength < TPM_HEADER_SIZE +
-			      offsetof(struct tpm_getrandom_out, rng_data) +
-			      recd) {
-			total = -EFAULT;
-			break;
-		}
-		memcpy(dest, tpm_cmd.params.getrandom_out.rng_data, recd);
-
-		dest += recd;
-		total += recd;
-		num_bytes -= recd;
-	} while (retries-- && total < max);
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		rc = tpm2_get_random(chip, out, max);
+	else
+		rc = tpm1_get_random(chip, out, max);
 
 	tpm_put_ops(chip);
-	return total ? total : -EIO;
+	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm_get_random);
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 1c1980c79c30..496a56156e77 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -551,6 +551,7 @@ int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
 		    const char *log_msg);
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length);
+int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
 unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm_pm_suspend(struct device *dev);
 int tpm_pm_resume(struct device *dev);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 8aa3e3cfed71..e7e0528e2e06 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -470,3 +470,58 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm1_getcap);
+
+#define TPM_ORD_GET_RANDOM 70
+#define TPM_GETRANDOM_RESULT_SIZE	18
+static const struct tpm_input_header tpm_getrandom_header = {
+	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
+	.length = cpu_to_be32(14),
+	.ordinal = cpu_to_be32(TPM_ORD_GET_RANDOM)
+};
+
+int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max)
+{
+	struct tpm_cmd_t tpm_cmd;
+	u32 recd;
+	u32 num_bytes = min_t(u32, max, TPM_MAX_RNG_DATA);
+	u32 rlength;
+	int err, total = 0, retries = 5;
+	u8 *dest = out;
+
+	if (!out || !num_bytes || max > TPM_MAX_RNG_DATA)
+		return -EINVAL;
+
+	do {
+		tpm_cmd.header.in = tpm_getrandom_header;
+		tpm_cmd.params.getrandom_in.num_bytes = cpu_to_be32(num_bytes);
+
+		err = tpm_transmit_cmd(chip, NULL, &tpm_cmd,
+				       TPM_GETRANDOM_RESULT_SIZE + num_bytes,
+				       offsetof(struct tpm_getrandom_out,
+						rng_data),
+				       0, "attempting get random");
+		if (err)
+			break;
+
+		recd = be32_to_cpu(tpm_cmd.params.getrandom_out.rng_data_len);
+		if (recd > num_bytes) {
+			total = -EFAULT;
+			break;
+		}
+
+		rlength = be32_to_cpu(tpm_cmd.header.out.length);
+		if (rlength < TPM_HEADER_SIZE +
+			      offsetof(struct tpm_getrandom_out, rng_data) +
+			      recd) {
+			total = -EFAULT;
+			break;
+		}
+		memcpy(dest, tpm_cmd.params.getrandom_out.rng_data, recd);
+
+		dest += recd;
+		total += recd;
+		num_bytes -= recd;
+	} while (retries-- && (size_t)total < max);
+
+	return total ? total : -EIO;
+}
-- 
2.14.4

