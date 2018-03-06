Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbeCFJfS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:35:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:24940 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753263AbeCFJeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:34:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="205860717"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 3/4] tmp: factor out tpm1_get_random into tpm1-cmd.c
Date: Tue,  6 Mar 2018 11:30:40 +0200
Message-Id: <20180306093041.11996-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180306093041.11996-1-tomas.winkler@intel.com>
References: <20180306093041.11996-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out get random implementation from tpm-interface.c
into tpm1_get_random function in tpm1-cmd.c.
No functional changes.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm-interface.c | 56 ++++------------------------------------
 drivers/char/tpm/tpm.h           |  2 ++
 drivers/char/tpm/tpm1-cmd.c      | 54 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 51 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 6b70cefed505..59ca2e30b4d2 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -707,14 +707,6 @@ int tpm_pm_resume(struct device *dev)
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
@@ -725,57 +717,19 @@ static const struct tpm_input_header tpm_getrandom_header = {
  */
 int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 {
-	struct tpm_cmd_t tpm_cmd;
-	u32 recd, num_bytes = min_t(u32, max, TPM_MAX_RNG_DATA), rlength;
-	int err, total = 0, retries = 5;
-	u8 *dest = out;
-
-	if (!out || !num_bytes || max > TPM_MAX_RNG_DATA)
-		return -EINVAL;
+	int err;
 
 	chip = tpm_chip_find_get(chip);
 	if (!chip)
 		return -ENODEV;
 
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		err = tpm2_get_random(chip, out, max);
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
-		if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
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
+	else
+		err = tpm1_get_random(chip, out, max);
 
 	tpm_put_ops(chip);
-	return total ? total : -EIO;
+	return err;
 }
 EXPORT_SYMBOL_GPL(tpm_get_random);
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 1a8ef4d3cb1c..b5fe0269a833 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -537,6 +537,8 @@ int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
 		    const char *log_msg);
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length);
+int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
+
 int tpm_pm_suspend(struct device *dev);
 int tpm_pm_resume(struct device *dev);
 
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 0e10a40b28b1..2c075a03a17a 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -472,3 +472,57 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
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
+		if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
+			      recd) {
+			total = -EFAULT;
+			break;
+		}
+		memcpy(dest, tpm_cmd.params.getrandom_out.rng_data, recd);
+
+		dest += recd;
+		total += recd;
+		num_bytes -= recd;
+	} while (retries-- && total < max);
+
+	return total ? total : -EIO;
+}
-- 
2.14.3
