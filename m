Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72C8C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD5021565
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD5021565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390354AbeIUTvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:51:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:4671 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389657AbeIUTvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:51:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 07:02:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,285,1534834800"; 
   d="scan'208";a="71839139"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga007.fm.intel.com with ESMTP; 21 Sep 2018 07:02:14 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v4 11/21] tpm: factor out tpm_startup function
Date:   Fri, 21 Sep 2018 16:58:10 +0300
Message-Id: <20180921135820.20549-12-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180921135820.20549-1-tomas.winkler@intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPM manual startup is used only from within TPM 1.x or TPM 2.x
code, hence remove tpm_startup() function from tpm-interface.c
and add two static functions implementations tpm1_startup()
and tpm2_startup() into to tpm1-cmd.c and tpm2-cmd.c respectively.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Tested-by: Jarkko Sakkine <jarkko.sakkinen@linux.intel.com>
---
V2-V3: Resend.
V4: Fix the commit message.

 drivers/char/tpm/tpm-interface.c | 41 ----------------------------------------
 drivers/char/tpm/tpm.h           |  1 -
 drivers/char/tpm/tpm1-cmd.c      | 37 +++++++++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm2-cmd.c      | 34 +++++++++++++++++++++++++++++++--
 4 files changed, 68 insertions(+), 45 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index dfa972bbdd81..686b5316dad5 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -413,47 +413,6 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
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
index d118adbcd2a7..6deae4595277 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -308,6 +308,40 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
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
@@ -317,7 +351,7 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 	rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, NULL,
 			 sizeof(cap.timeout));
 	if (rc == TPM_ERR_INVALID_POSTINIT) {
-		if (tpm_startup(chip))
+		if (tpm1_startup(chip))
 			return rc;
 
 		rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap,
@@ -726,3 +760,4 @@ int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr)
 
 	return rc;
 }
+
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 65ce463a6f92..8da5a16e7c8c 100644
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

