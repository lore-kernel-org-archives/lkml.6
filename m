Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D28EC5ACCE
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E4521523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E4521523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJQOop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:44:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:4079 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbeJQOop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:44:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 23:50:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,391,1534834800"; 
   d="scan'208";a="79371154"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga008.fm.intel.com with ESMTP; 16 Oct 2018 23:50:30 -0700
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
Subject: [PATCH v6 07/20] tpm: move tpm_getcap to tpm1-cmd.c
Date:   Wed, 17 Oct 2018 09:46:00 +0300
Message-Id: <20181017064613.19746-8-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181017064613.19746-1-tomas.winkler@intel.com>
References: <20181017064613.19746-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Move tpm_getcap to tpm1-cmd. Rename the function to tpm1_getcap.
2. Remove unused tpm_getcap_header with unused constant
as this functionality is already implemented using tpm_buf construct.

Fixes warning:
drivers/char/tpm/tpm-interface.c:452:38: warning: ‘tpm_getcap_header’ defined but not used [-Wunused-const-variable=]
 static const struct tpm_input_header tpm_getcap_header = {
                                      ^~~~~~~~~~~~~~~~~
3. Drop unused TPM_DIGEST_SIZE. It's already defined in
include/linux/tpm.h

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
V2-V3: Rebase
V4-V6: Resend

 drivers/char/tpm/tpm-interface.c | 47 +-----------------------------------
 drivers/char/tpm/tpm-sysfs.c     | 48 ++++++++++++++++++-------------------
 drivers/char/tpm/tpm.h           |  4 ++--
 drivers/char/tpm/tpm1-cmd.c      | 51 +++++++++++++++++++++++++++++++++-------
 drivers/char/tpm/tpm_tis_core.c  |  2 +-
 5 files changed, 71 insertions(+), 81 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 177795b408ff..486e211b03a0 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -455,52 +455,6 @@ int tpm_startup(struct tpm_chip *chip)
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
@@ -858,6 +812,7 @@ int tpm_pm_resume(struct device *dev)
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
index 221b6dcd15a1..05c386b3ab12 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -541,8 +541,6 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 			 size_t min_rsp_body_length, unsigned int flags,
 			 const char *desc);
 int tpm_startup(struct tpm_chip *chip);
-ssize_t tpm_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
-		   const char *desc, size_t min_cap_length);
 int tpm_get_timeouts(struct tpm_chip *);
 int tpm1_auto_startup(struct tpm_chip *chip);
 int tpm_do_selftest(struct tpm_chip *chip);
@@ -551,6 +549,8 @@ int tpm1_get_timeouts(struct tpm_chip *chip);
 unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
 		    const char *log_msg);
+ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
+		    const char *desc, size_t min_cap_length);
 unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm_pm_suspend(struct device *dev);
 int tpm_pm_resume(struct device *dev);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index ec242397e6dc..3bd079587ef5 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -314,15 +314,15 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
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
@@ -383,9 +383,9 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
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
 
@@ -434,3 +434,38 @@ int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
 	tpm_buf_destroy(&buf);
 	return rc;
 }
+
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
index f9e73d0f9386..ced01ec146b5 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -664,7 +664,7 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		return tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
 	else
-		return tpm_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc,
+		return tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc,
 				  0);
 }
 
-- 
2.14.4

