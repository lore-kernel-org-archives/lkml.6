Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932337AbeCJI2P (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 03:28:15 -0500
Received: from mga12.intel.com ([192.55.52.136]:63004 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751871AbeCJI2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 03:28:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,450,1515484800";
   d="scan'208";a="24039456"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v2 6/8] tpm: factor out tpm_startup function
Date: Sat, 10 Mar 2018 10:24:26 +0200
Message-Id: <20180310082428.31519-7-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180310082428.31519-1-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tpm manual startup is used only from within tpm1 or tpm2
code, hence remove tpm_startup function from tpm-interface.c
and add two static functions implementations tpm1_startup
and tpm2_startup into to tpm1-cmd.c and tpm2-cmd.c respectively.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm-interface.c | 41 ----------------------------------------
 drivers/char/tpm/tpm.h           |  1 -
 drivers/char/tpm/tpm1-cmd.c      | 37 +++++++++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm2-cmd.c      | 34 +++++++++++++++++++++++++++++++--
 4 files changed, 68 insertions(+), 45 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 11899ef32457..90e14462500a 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -313,47 +313,6 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
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
index 1bed9b5441c5..434f11c23e3e 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -526,7 +526,6 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 			 void *buf, size_t bufsiz,
 			 size_t min_rsp_body_length, unsigned int flags,
 			 const char *desc);
-int tpm_startup(struct tpm_chip *chip);
 int tpm_get_timeouts(struct tpm_chip *);
 
 int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index e2c9f609fe64..85dd0fcbd4cc 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -307,6 +307,40 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm1_calc_ordinal_duration);
 
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
@@ -719,3 +753,4 @@ int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr)
 
 	return rc;
 }
+
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 8114fd59e2c5..07636aa6f1a9 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -1006,6 +1006,36 @@ static int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
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
@@ -1017,7 +1047,7 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 {
 	int rc;
 
-	rc = tpm_get_timeouts(chip);
+	rc = tpm2_get_timeouts(chip);
 	if (rc)
 		goto out;
 
@@ -1028,7 +1058,7 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 	}
 
 	if (rc == TPM2_RC_INITIALIZE) {
-		rc = tpm_startup(chip);
+		rc = tpm2_startup(chip);
 		if (rc)
 			goto out;
 
-- 
2.14.3
