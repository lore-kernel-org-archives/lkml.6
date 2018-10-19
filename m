Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0B4ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A082B2086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A082B2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeJTCfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:35:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:54192 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbeJTCfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:35:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 11:27:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,401,1534834800"; 
   d="scan'208";a="267150198"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga005.jf.intel.com with ESMTP; 19 Oct 2018 11:27:51 -0700
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
Subject: [PATCH v7 11/21] tpm: factor out tpm 1.x pm suspend flow into tpm1-cmd.c
Date:   Fri, 19 Oct 2018 21:22:57 +0300
Message-Id: <20181019182307.17745-12-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181019182307.17745-1-tomas.winkler@intel.com>
References: <20181019182307.17745-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out TPM 1.x suspend flow from tpm-interface.c into a new function
tpm1_pm_suspend() in tpm1-cmd.c

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2-V3: Rebase.
V4: 1. Add kdoc for tpm1_pm_suspend().
    2. Fix commit message.
V5: Adjust the kdoc to the new standard.
V6: Rebase.
V7: Resend.

 drivers/char/tpm/tpm-interface.c | 55 ++++--------------------------------
 drivers/char/tpm/tpm.h           |  2 ++
 drivers/char/tpm/tpm1-cmd.c      | 61 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 50 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 43d3540a7875..e7f220f691f9 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -586,15 +586,6 @@ int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
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
@@ -602,54 +593,18 @@ static const struct tpm_input_header savestate_header = {
 int tpm_pm_suspend(struct device *dev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(dev);
-	struct tpm_cmd_t cmd;
-	int rc, try;
-
-	u8 dummy_hash[TPM_DIGEST_SIZE] = { 0 };
+	int rc = 0;
 
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
index f284a98a9455..754f7bcb15fa 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -542,6 +542,8 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 			 const char *desc);
 int tpm_startup(struct tpm_chip *chip);
 int tpm_get_timeouts(struct tpm_chip *);
+
+int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr);
 int tpm1_auto_startup(struct tpm_chip *chip);
 int tpm1_do_selftest(struct tpm_chip *chip);
 int tpm1_get_timeouts(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index a69a02366c32..3bd9f1fa77ce 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -666,3 +666,64 @@ int tpm1_auto_startup(struct tpm_chip *chip)
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
+/**
+ * tpm1_pm_suspend() - pm suspend handler
+ * @chip: TPM chip to use.
+ * @tpm_suspend_pcr: flush pcr for buggy TPM chips.
+ *
+ * The functions saves the TPM state to be restored on resume.
+ *
+ * Return:
+ * * 0 on success,
+ * * < 0 on error.
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
+		dev_err(&chip->dev, "Error (%d) sending savestate before suspend\n",
+			rc);
+	else if (try > 0)
+		dev_warn(&chip->dev, "TPM savestate took %dms\n",
+			 try * TPM_TIMEOUT_RETRY);
+
+	return rc;
+}
-- 
2.14.4

