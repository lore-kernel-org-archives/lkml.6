Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeCJI2N (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 03:28:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:63004 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932337AbeCJI2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 03:28:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,450,1515484800";
   d="scan'208";a="24039444"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v2 5/8] tpm: factor out tpm1 pm suspend flow into tpm1-cmd.c
Date: Sat, 10 Mar 2018 10:24:25 +0200
Message-Id: <20180310082428.31519-6-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180310082428.31519-1-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out tpm1 suspend flow from tpm-interface.c into a new function
tpm1_pm_suspend in tpm1-cmd.c

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm-interface.c | 55 ++++------------------------------------
 drivers/char/tpm/tpm.h           |  1 +
 drivers/char/tpm/tpm1-cmd.c      | 54 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 50 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index a7dfe286b343..11899ef32457 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -485,15 +485,6 @@ int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
 }
 EXPORT_SYMBOL_GPL(tpm_send);
 
-#define TPM_ORD_SAVESTATE 152
-#define SAVESTATE_RESULT_SIZE 10
-
-static const struct tpm_input_header savestate_header = {
-	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
-	.length = cpu_to_be32(10),
-	.ordinal = cpu_to_be32(TPM_ORD_SAVESTATE)
-};
-
 /*
  * We are about to suspend. Save the TPM state
  * so that it can be restored.
@@ -501,54 +492,18 @@ static const struct tpm_input_header savestate_header = {
 int tpm_pm_suspend(struct device *dev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(dev);
-	struct tpm_cmd_t cmd;
-	int rc, try;
+	int rc = 0;
 
-	u8 dummy_hash[TPM_DIGEST_SIZE] = { 0 };
-
-	if (chip == NULL)
+	if (!chip)
 		return -ENODEV;
 
 	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
 		return 0;
 
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		tpm2_shutdown(chip, TPM2_SU_STATE);
-		return 0;
-	}
-
-	/* for buggy tpm, flush pcrs with extend to selected dummy */
-	if (tpm_suspend_pcr)
-		rc = tpm1_pcr_extend(chip, tpm_suspend_pcr, dummy_hash,
-				     "extending dummy pcr before suspend");
-
-	/* now do the actual savestate */
-	for (try = 0; try < TPM_RETRY; try++) {
-		cmd.header.in = savestate_header;
-		rc = tpm_transmit_cmd(chip, NULL, &cmd, SAVESTATE_RESULT_SIZE,
-				      0, 0, NULL);
-
-		/*
-		 * If the TPM indicates that it is too busy to respond to
-		 * this command then retry before giving up.  It can take
-		 * several seconds for this TPM to be ready.
-		 *
-		 * This can happen if the TPM has already been sent the
-		 * SaveState command before the driver has loaded.  TCG 1.2
-		 * specification states that any communication after SaveState
-		 * may cause the TPM to invalidate previously saved state.
-		 */
-		if (rc != TPM_WARN_RETRY)
-			break;
-		tpm_msleep(TPM_TIMEOUT_RETRY);
-	}
-
-	if (rc)
-		dev_err(&chip->dev,
-			"Error (%d) sending savestate before suspend\n", rc);
-	else if (try > 0)
-		dev_warn(&chip->dev, "TPM savestate took %dms\n",
-			 try * TPM_TIMEOUT_RETRY);
+	else
+		rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
 
 	return rc;
 }
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 6922fdfc4274..1bed9b5441c5 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -529,6 +529,7 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 int tpm_startup(struct tpm_chip *chip);
 int tpm_get_timeouts(struct tpm_chip *);
 
+int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr);
 int tpm1_do_selftest(struct tpm_chip *chip);
 int tpm1_auto_startup(struct tpm_chip *chip);
 int tpm1_get_timeouts(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 6dde18c46820..e2c9f609fe64 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -665,3 +665,57 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 		rc = -ENODEV;
 	return rc;
 }
+
+#define TPM_ORD_SAVESTATE 152
+#define SAVESTATE_RESULT_SIZE 10
+static const struct tpm_input_header savestate_header = {
+	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
+	.length = cpu_to_be32(10),
+	.ordinal = cpu_to_be32(TPM_ORD_SAVESTATE)
+};
+
+/*
+ * We are about to suspend. Save the TPM state
+ * so that it can be restored.
+ */
+int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr)
+{
+	u8 dummy_hash[TPM_DIGEST_SIZE] = { 0 };
+	struct tpm_cmd_t cmd;
+	int rc, try;
+
+	/* for buggy tpm, flush pcrs with extend to selected dummy */
+	if (tpm_suspend_pcr)
+		rc = tpm1_pcr_extend(chip, tpm_suspend_pcr, dummy_hash,
+				     "extending dummy pcr before suspend");
+
+	/* now do the actual savestate */
+	for (try = 0; try < TPM_RETRY; try++) {
+		cmd.header.in = savestate_header;
+		rc = tpm_transmit_cmd(chip, NULL, &cmd, SAVESTATE_RESULT_SIZE,
+				      0, 0, NULL);
+
+		/*
+		 * If the TPM indicates that it is too busy to respond to
+		 * this command then retry before giving up.  It can take
+		 * several seconds for this TPM to be ready.
+		 *
+		 * This can happen if the TPM has already been sent the
+		 * SaveState command before the driver has loaded.  TCG 1.2
+		 * specification states that any communication after SaveState
+		 * may cause the TPM to invalidate previously saved state.
+		 */
+		if (rc != TPM_WARN_RETRY)
+			break;
+		tpm_msleep(TPM_TIMEOUT_RETRY);
+	}
+
+	if (rc)
+		dev_err(&chip->dev,
+			"Error (%d) sending savestate before suspend\n", rc);
+	else if (try > 0)
+		dev_warn(&chip->dev, "TPM savestate took %dms\n",
+			 try * TPM_TIMEOUT_RETRY);
+
+	return rc;
+}
-- 
2.14.3
