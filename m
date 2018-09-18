Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968F9ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE7C206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE7C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbeIRPKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:10:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:59396 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729746AbeIRPKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:10:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 02:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="71724173"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2018 02:38:19 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v3 11/20] tpm: factor out tpm_startup function
Date:   Tue, 18 Sep 2018 12:34:50 +0300
Message-Id: <20180918093459.19165-12-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180918093459.19165-1-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tpm manual startup is used only from within tpm1 or tpm2
code, hence remove tpm_startup function from tpm-interface.c
and add two static functions implementations tpm1_startup
and tpm2_startup into to tpm1-cmd.c and tpm2-cmd.c respectively.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2-V3: Rebase

 drivers/char/tpm/tpm-interface.c | 41 ----------------------------------------
 drivers/char/tpm/tpm.h           |  1 -
 drivers/char/tpm/tpm1-cmd.c      | 37 +++++++++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm2-cmd.c      | 34 +++++++++++++++++++++++++++++++--
 4 files changed, 68 insertions(+), 45 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1ddf9d7e2069..3a2eef9e8665 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -403,47 +403,6 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 }
 EXPORT_SYMBOL_GPL(tpm_transmit_cmd);
 
-#define TPM_ORD_STARTUP 153
-#define TPM_ST_CLEAR 1
-
-/**
- * tpm_startup - turn on the TPM
- * @chip: TPM chip to use
- *
- * Normally the firmware should start the TPM. This function is provided as a
- * workaround if this does not happen. A legal case for this could be for
- * example when a TPM emulator is used.
- *
- * Return: same as tpm_transmit_cmd()
- */
-int tpm_startup(struct tpm_chip *chip)
-{
-	struct tpm_buf buf;
-	int rc;
-
-	dev_info(&chip->dev, "starting up the TPM manually\n");
-
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_STARTUP);
-		if (rc < 0)
-			return rc;
-
-		tpm_buf_append_u16(&buf, TPM2_SU_CLEAR);
-	} else {
-		rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_STARTUP);
-		if (rc < 0)
-			return rc;
-
-		tpm_buf_append_u16(&buf, TPM_ST_CLEAR);
-	}
-
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
-			      "attempting to start the TPM");
-
-	tpm_buf_destroy(&buf);
-	return rc;
-}
-
 int tpm_get_timeouts(struct tpm_chip *chip)
 {
 	if (chip->flags & TPM_CHIP_FLAG_HAVE_TIMEOUTS)
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 862c9262e037..fa88102a0cab 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -540,7 +540,6 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 			 void *buf, size_t bufsiz,
 			 size_t min_rsp_body_length, unsigned int flags,
 			 const char *desc);
-int tpm_startup(struct tpm_chip *chip);
 int tpm_get_timeouts(struct tpm_chip *);
 
 int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 5fdc44feea0f..f93776621e49 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -307,6 +307,40 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 		return duration;
 }
 
+#define TPM_ORD_STARTUP 153
+#define TPM_ST_CLEAR 1
+
+/**
+ * tpm_startup - turn on the TPM
+ * @chip: TPM chip to use
+ *
+ * Normally the firmware should start the TPM. This function is provided as a
+ * workaround if this does not happen. A legal case for this could be for
+ * example when a TPM emulator is used.
+ *
+ * Return: same as tpm_transmit_cmd()
+ */
+static int tpm1_startup(struct tpm_chip *chip)
+{
+	struct tpm_buf buf;
+	int rc;
+
+	dev_info(&chip->dev, "starting up the TPM manually\n");
+
+	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_STARTUP);
+	if (rc < 0)
+		return rc;
+
+	tpm_buf_append_u16(&buf, TPM_ST_CLEAR);
+
+	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
+			      "attempting to start the TPM");
+
+	tpm_buf_destroy(&buf);
+
+	return rc;
+}
+
 int tpm1_get_timeouts(struct tpm_chip *chip)
 {
 	cap_t cap;
@@ -316,7 +350,7 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 	rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, NULL,
 			 sizeof(cap.timeout));
 	if (rc == TPM_ERR_INVALID_POSTINIT) {
-		if (tpm_startup(chip))
+		if (tpm1_startup(chip))
 			return rc;
 
 		rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap,
@@ -721,3 +755,4 @@ int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr)
 
 	return rc;
 }
+
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 4ca0555f23c8..333631eab4c7 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -943,6 +943,36 @@ static int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 	return rc;
 }
 
+/**
+ * tpm2_startup - turn on the TPM
+ * @chip: TPM chip to use
+ *
+ * Normally the firmware should start the TPM. This function is provided as a
+ * workaround if this does not happen. A legal case for this could be for
+ * example when a TPM emulator is used.
+ *
+ * Return: same as tpm_transmit_cmd()
+ */
+
+static int tpm2_startup(struct tpm_chip *chip)
+{
+	struct tpm_buf buf;
+	int rc;
+
+	dev_info(&chip->dev, "starting up the TPM manually\n");
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_STARTUP);
+	if (rc < 0)
+		return rc;
+
+	tpm_buf_append_u16(&buf, TPM2_SU_CLEAR);
+	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
+			      "attempting to start the TPM");
+	tpm_buf_destroy(&buf);
+
+	return rc;
+}
+
 /**
  * tpm2_auto_startup - Perform the standard automatic TPM initialization
  *                     sequence
@@ -954,7 +984,7 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 {
 	int rc;
 
-	rc = tpm_get_timeouts(chip);
+	rc = tpm2_get_timeouts(chip);
 	if (rc)
 		goto out;
 
@@ -963,7 +993,7 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 		goto out;
 
 	if (rc == TPM2_RC_INITIALIZE) {
-		rc = tpm_startup(chip);
+		rc = tpm2_startup(chip);
 		if (rc)
 			goto out;
 
-- 
2.14.4

