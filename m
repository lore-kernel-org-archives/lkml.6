Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753363AbeCFJeT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:34:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:24940 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753300AbeCFJeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:34:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="205860710"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 2/4] tmp: move tpm_getcap to tpm1-cmd.c
Date: Tue,  6 Mar 2018 11:30:39 +0200
Message-Id: <20180306093041.11996-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180306093041.11996-1-tomas.winkler@intel.com>
References: <20180306093041.11996-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Move tpm_getcap to tpm1-cmd. Rename the function to tpm1_getcap.
2. Remove unsed tpm_getcap_header with unused constant
as the functionality is implemented using tpm_buf construct.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm-interface.c | 47 +-----------------------------------
 drivers/char/tpm/tpm-sysfs.c     | 48 ++++++++++++++++++-------------------
 drivers/char/tpm/tpm.h           |  4 ++--
 drivers/char/tpm/tpm1-cmd.c      | 51 +++++++++++++++++++++++++++++++++-------
 drivers/char/tpm/tpm_tis_core.c  |  2 +-
 5 files changed, 71 insertions(+), 81 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 83eeefb2a4af..6b70cefed505 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -354,52 +354,6 @@ int tpm_startup(struct tpm_chip *chip)
 	return rc;
 }
 
-#define TPM_DIGEST_SIZE 20
-#define TPM_RET_CODE_IDX 6
-#define TPM_INTERNAL_RESULT_SIZE 200
-#define TPM_ORD_GET_CAP 101
-#define TPM_ORD_GET_RANDOM 70
-
-static const struct tpm_input_header tpm_getcap_header = {
-	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
-	.length = cpu_to_be32(22),
-	.ordinal = cpu_to_be32(TPM_ORD_GET_CAP)
-};
-
-ssize_t tpm_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
-		   const char *desc, size_t min_cap_length)
-{
-	struct tpm_buf buf;
-	int rc;
-
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_CAP);
-	if (rc)
-		return rc;
-
-	if (subcap_id == TPM_CAP_VERSION_1_1 ||
-	    subcap_id == TPM_CAP_VERSION_1_2) {
-		tpm_buf_append_u32(&buf, subcap_id);
-		tpm_buf_append_u32(&buf, 0);
-	} else {
-		if (subcap_id == TPM_CAP_FLAG_PERM ||
-		    subcap_id == TPM_CAP_FLAG_VOL)
-			tpm_buf_append_u32(&buf, TPM_CAP_FLAG);
-		else
-			tpm_buf_append_u32(&buf, TPM_CAP_PROP);
-
-		tpm_buf_append_u32(&buf, 4);
-		tpm_buf_append_u32(&buf, subcap_id);
-	}
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
-			      min_cap_length, 0, desc);
-	if (!rc)
-		*cap = *(cap_t *)&buf.data[TPM_HEADER_SIZE + 4];
-
-	tpm_buf_destroy(&buf);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(tpm_getcap);
-
 int tpm_get_timeouts(struct tpm_chip *chip)
 {
 	if (chip->flags & TPM_CHIP_FLAG_HAVE_TIMEOUTS)
@@ -753,6 +707,7 @@ int tpm_pm_resume(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(tpm_pm_resume);
 
+#define TPM_ORD_GET_RANDOM 70
 #define TPM_GETRANDOM_RESULT_SIZE	18
 static const struct tpm_input_header tpm_getrandom_header = {
 	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 83a77a445538..008515314ae3 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -106,9 +106,9 @@ static ssize_t pcrs_show(struct device *dev, struct device_attribute *attr,
 	char *str = buf;
 	struct tpm_chip *chip = to_tpm_chip(dev);
 
-	rc = tpm_getcap(chip, TPM_CAP_PROP_PCR, &cap,
-			"attempting to determine the number of PCRS",
-			sizeof(cap.num_pcrs));
+	rc = tpm1_getcap(chip, TPM_CAP_PROP_PCR, &cap,
+			 "attempting to determine the number of PCRS",
+			 sizeof(cap.num_pcrs));
 	if (rc)
 		return 0;
 
@@ -132,9 +132,9 @@ static ssize_t enabled_show(struct device *dev, struct device_attribute *attr,
 	cap_t cap;
 	ssize_t rc;
 
-	rc = tpm_getcap(to_tpm_chip(dev), TPM_CAP_FLAG_PERM, &cap,
-			"attempting to determine the permanent enabled state",
-			sizeof(cap.perm_flags));
+	rc = tpm1_getcap(to_tpm_chip(dev), TPM_CAP_FLAG_PERM, &cap,
+			 "attempting to determine the permanent enabled state",
+			 sizeof(cap.perm_flags));
 	if (rc)
 		return 0;
 
@@ -149,9 +149,9 @@ static ssize_t active_show(struct device *dev, struct device_attribute *attr,
 	cap_t cap;
 	ssize_t rc;
 
-	rc = tpm_getcap(to_tpm_chip(dev), TPM_CAP_FLAG_PERM, &cap,
-			"attempting to determine the permanent active state",
-			sizeof(cap.perm_flags));
+	rc = tpm1_getcap(to_tpm_chip(dev), TPM_CAP_FLAG_PERM, &cap,
+			 "attempting to determine the permanent active state",
+			 sizeof(cap.perm_flags));
 	if (rc)
 		return 0;
 
@@ -166,9 +166,9 @@ static ssize_t owned_show(struct device *dev, struct device_attribute *attr,
 	cap_t cap;
 	ssize_t rc;
 
-	rc = tpm_getcap(to_tpm_chip(dev), TPM_CAP_PROP_OWNER, &cap,
-			"attempting to determine the owner state",
-			sizeof(cap.owned));
+	rc = tpm1_getcap(to_tpm_chip(dev), TPM_CAP_PROP_OWNER, &cap,
+			 "attempting to determine the owner state",
+			 sizeof(cap.owned));
 	if (rc)
 		return 0;
 
@@ -183,9 +183,9 @@ static ssize_t temp_deactivated_show(struct device *dev,
 	cap_t cap;
 	ssize_t rc;
 
-	rc = tpm_getcap(to_tpm_chip(dev), TPM_CAP_FLAG_VOL, &cap,
-			"attempting to determine the temporary state",
-			sizeof(cap.stclear_flags));
+	rc = tpm1_getcap(to_tpm_chip(dev), TPM_CAP_FLAG_VOL, &cap,
+			 "attempting to determine the temporary state",
+			 sizeof(cap.stclear_flags));
 	if (rc)
 		return 0;
 
@@ -202,18 +202,18 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
 	ssize_t rc;
 	char *str = buf;
 
-	rc = tpm_getcap(chip, TPM_CAP_PROP_MANUFACTURER, &cap,
-			"attempting to determine the manufacturer",
-			sizeof(cap.manufacturer_id));
+	rc = tpm1_getcap(chip, TPM_CAP_PROP_MANUFACTURER, &cap,
+			 "attempting to determine the manufacturer",
+			 sizeof(cap.manufacturer_id));
 	if (rc)
 		return 0;
 	str += sprintf(str, "Manufacturer: 0x%x\n",
 		       be32_to_cpu(cap.manufacturer_id));
 
 	/* Try to get a TPM version 1.2 TPM_CAP_VERSION_INFO */
-	rc = tpm_getcap(chip, TPM_CAP_VERSION_1_2, &cap,
-			"attempting to determine the 1.2 version",
-			sizeof(cap.tpm_version_1_2));
+	rc = tpm1_getcap(chip, TPM_CAP_VERSION_1_2, &cap,
+			 "attempting to determine the 1.2 version",
+			 sizeof(cap.tpm_version_1_2));
 	if (!rc) {
 		str += sprintf(str,
 			       "TCG version: %d.%d\nFirmware version: %d.%d\n",
@@ -223,9 +223,9 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
 			       cap.tpm_version_1_2.revMinor);
 	} else {
 		/* Otherwise just use TPM_STRUCT_VER */
-		rc = tpm_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
-				"attempting to determine the 1.1 version",
-				sizeof(cap.tpm_version));
+		rc = tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
+				 "attempting to determine the 1.1 version",
+				 sizeof(cap.tpm_version));
 		if (rc)
 			return 0;
 		str += sprintf(str,
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 4306c878f1d9..1a8ef4d3cb1c 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -527,8 +527,6 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 			 size_t min_rsp_body_length, unsigned int flags,
 			 const char *desc);
 int tpm_startup(struct tpm_chip *chip);
-ssize_t tpm_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
-		   const char *desc, size_t min_cap_length);
 int tpm_get_timeouts(struct tpm_chip *);
 int tpm_do_selftest(struct tpm_chip *chip);
 
@@ -537,6 +535,8 @@ int tpm1_get_timeouts(struct tpm_chip *chip);
 unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
 		    const char *log_msg);
+ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
+		    const char *desc, size_t min_cap_length);
 int tpm_pm_suspend(struct device *dev);
 int tpm_pm_resume(struct device *dev);
 
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index dc07eafe9d69..0e10a40b28b1 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -313,15 +313,15 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 	unsigned long timeout_old[4], timeout_chip[4], timeout_eff[4];
 	ssize_t rc;
 
-	rc = tpm_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, NULL,
-			sizeof(cap.timeout));
+	rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, NULL,
+			 sizeof(cap.timeout));
 	if (rc == TPM_ERR_INVALID_POSTINIT) {
 		if (tpm_startup(chip))
 			return rc;
 
-		rc = tpm_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap,
-				"attempting to determine the timeouts",
-				sizeof(cap.timeout));
+		rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap,
+				 "attempting to determine the timeouts",
+				 sizeof(cap.timeout));
 	}
 
 	if (rc) {
@@ -384,9 +384,9 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 	chip->timeout_c = usecs_to_jiffies(timeout_eff[2]);
 	chip->timeout_d = usecs_to_jiffies(timeout_eff[3]);
 
-	rc = tpm_getcap(chip, TPM_CAP_PROP_TIS_DURATION, &cap,
-			"attempting to determine the durations",
-			sizeof(cap.duration));
+	rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_DURATION, &cap,
+			 "attempting to determine the durations",
+			  sizeof(cap.duration));
 	if (rc)
 		return rc;
 
@@ -437,3 +437,38 @@ int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
 	return rc;
 }
 
+#define TPM_DIGEST_SIZE 20
+#define TPM_ORD_GET_CAP 101
+ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
+		    const char *desc, size_t min_cap_length)
+{
+	struct tpm_buf buf;
+	int rc;
+
+	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_CAP);
+	if (rc)
+		return rc;
+
+	if (subcap_id == TPM_CAP_VERSION_1_1 ||
+	    subcap_id == TPM_CAP_VERSION_1_2) {
+		tpm_buf_append_u32(&buf, subcap_id);
+		tpm_buf_append_u32(&buf, 0);
+	} else {
+		if (subcap_id == TPM_CAP_FLAG_PERM ||
+		    subcap_id == TPM_CAP_FLAG_VOL)
+			tpm_buf_append_u32(&buf, TPM_CAP_FLAG);
+		else
+			tpm_buf_append_u32(&buf, TPM_CAP_PROP);
+
+		tpm_buf_append_u32(&buf, 4);
+		tpm_buf_append_u32(&buf, subcap_id);
+	}
+	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
+			      min_cap_length, 0, desc);
+	if (!rc)
+		*cap = *(cap_t *)&buf.data[TPM_HEADER_SIZE + 4];
+
+	tpm_buf_destroy(&buf);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(tpm1_getcap);
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 222e45a5a762..9278478b109b 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -628,7 +628,7 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		return tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
 	else
-		return tpm_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc,
+		return tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc,
 				  0);
 }
 
-- 
2.14.3
