Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743C2C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC652175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbfBEWtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:49:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:58251 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730037AbfBEWtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:49:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 14:49:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,337,1544515200"; 
   d="scan'208";a="113982303"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.171])
  by orsmga006.jf.intel.com with ESMTP; 05 Feb 2019 14:49:06 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v11 14/16] tpm: introduce tpm_chip_start() and tpm_chip_stop()
Date:   Wed,  6 Feb 2019 00:47:21 +0200
Message-Id: <20190205224723.19671-15-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Encapsulate power gating and locality functionality to tpm_chip_start()
and tpm_chip_stop() in order to clean up the branching mess in
tpm_transmit().

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-chip.c      | 110 +++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm-interface.c |  84 +----------------------
 drivers/char/tpm/tpm.h           |   2 +
 3 files changed, 115 insertions(+), 81 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 157505b0f755..65f1561eba81 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -37,6 +37,116 @@ struct class *tpm_class;
 struct class *tpmrm_class;
 dev_t tpm_devt;
 
+static int tpm_request_locality(struct tpm_chip *chip, unsigned int flags)
+{
+	int rc;
+
+	if (flags & TPM_TRANSMIT_NESTED)
+		return 0;
+
+	if (!chip->ops->request_locality)
+		return 0;
+
+	rc = chip->ops->request_locality(chip, 0);
+	if (rc < 0)
+		return rc;
+
+	chip->locality = rc;
+	return 0;
+}
+
+static void tpm_relinquish_locality(struct tpm_chip *chip, unsigned int flags)
+{
+	int rc;
+
+	if (flags & TPM_TRANSMIT_NESTED)
+		return;
+
+	if (!chip->ops->relinquish_locality)
+		return;
+
+	rc = chip->ops->relinquish_locality(chip, chip->locality);
+	if (rc)
+		dev_err(&chip->dev, "%s: : error %d\n", __func__, rc);
+
+	chip->locality = -1;
+}
+
+static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)
+{
+	if (flags & TPM_TRANSMIT_NESTED)
+		return 0;
+
+	if (!chip->ops->cmd_ready)
+		return 0;
+
+	return chip->ops->cmd_ready(chip);
+}
+
+static int tpm_go_idle(struct tpm_chip *chip, unsigned int flags)
+{
+	if (flags & TPM_TRANSMIT_NESTED)
+		return 0;
+
+	if (!chip->ops->go_idle)
+		return 0;
+
+	return chip->ops->go_idle(chip);
+}
+
+/**
+ * tpm_chip_start() - power on the TPM
+ * @chip:	a TPM chip to use
+ * @flags:	TPM transmit flags
+ *
+ * Return:
+ * * The response length	- OK
+ * * -errno			- A system error
+ */
+int tpm_chip_start(struct tpm_chip *chip, unsigned int flags)
+{
+	int ret;
+
+	if (chip->ops->clk_enable)
+		chip->ops->clk_enable(chip, true);
+
+	if (chip->locality == -1) {
+		ret = tpm_request_locality(chip, flags);
+		if (ret) {
+			chip->ops->clk_enable(chip, false);
+			return ret;
+		}
+	}
+
+	ret = tpm_cmd_ready(chip, flags);
+	if (ret) {
+		tpm_relinquish_locality(chip, flags);
+		if (chip->ops->clk_enable)
+			chip->ops->clk_enable(chip, false);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * tpm_chip_stop() - power off the TPM
+ * @chip:	a TPM chip to use
+ * @flags:	TPM transmit flags
+ *
+ * Return:
+ * * The response length	- OK
+ * * -errno			- A system error
+ */
+void tpm_chip_stop(struct tpm_chip *chip, unsigned int flags)
+{
+	tpm_go_idle(chip, flags);
+	tpm_relinquish_locality(chip, flags);
+	if (chip->ops->clk_enable)
+		chip->ops->clk_enable(chip, false);
+}
+
+
 /**
  * tpm_try_get_ops() - Get a ref to the tpm_chip
  * @chip: Chip to ref
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 4ac02990bdb2..f7b7e4e75fcf 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -62,64 +62,6 @@ unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
 
-static int tpm_request_locality(struct tpm_chip *chip, unsigned int flags)
-{
-	int rc;
-
-	if (flags & TPM_TRANSMIT_NESTED)
-		return 0;
-
-	if (!chip->ops->request_locality)
-		return 0;
-
-	rc = chip->ops->request_locality(chip, 0);
-	if (rc < 0)
-		return rc;
-
-	chip->locality = rc;
-
-	return 0;
-}
-
-static void tpm_relinquish_locality(struct tpm_chip *chip, unsigned int flags)
-{
-	int rc;
-
-	if (flags & TPM_TRANSMIT_NESTED)
-		return;
-
-	if (!chip->ops->relinquish_locality)
-		return;
-
-	rc = chip->ops->relinquish_locality(chip, chip->locality);
-	if (rc)
-		dev_err(&chip->dev, "%s: : error %d\n", __func__, rc);
-
-	chip->locality = -1;
-}
-
-static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)
-{
-	if (flags & TPM_TRANSMIT_NESTED)
-		return 0;
-
-	if (!chip->ops->cmd_ready)
-		return 0;
-
-	return chip->ops->cmd_ready(chip);
-}
-
-static int tpm_go_idle(struct tpm_chip *chip, unsigned int flags)
-{
-	if (flags & TPM_TRANSMIT_NESTED)
-		return 0;
-
-	if (!chip->ops->go_idle)
-		return 0;
-
-	return chip->ops->go_idle(chip);
-}
-
 static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz,
 				unsigned int flags)
 {
@@ -212,7 +154,6 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 	/* space for header and handles */
 	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
 	unsigned int delay_msec = TPM2_DURATION_SHORT;
-	bool has_locality = false;
 	u32 rc = 0;
 	ssize_t ret;
 	const size_t save_size = min(sizeof(save), bufsiz);
@@ -227,32 +168,13 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 	memcpy(save, buf, save_size);
 
 	for (;;) {
-		if (chip->ops->clk_enable != NULL)
-			chip->ops->clk_enable(chip, true);
-
-		if (chip->locality == -1) {
-			ret = tpm_request_locality(chip, flags);
-			if (ret)
-				goto out_locality;
-			has_locality = true;
-		}
-
-		ret = tpm_cmd_ready(chip, flags);
+		ret = tpm_chip_start(chip, flags);
 		if (ret)
-			goto out_locality;
+			return ret;
 
 		ret = tpm_try_transmit(chip, buf, bufsiz, flags);
 
-		/* This may fail but do not override ret. */
-		tpm_go_idle(chip, flags);
-
-out_locality:
-		if (has_locality)
-			tpm_relinquish_locality(chip, flags);
-
-		if (chip->ops->clk_enable != NULL)
-			chip->ops->clk_enable(chip, false);
-
+		tpm_chip_stop(chip, flags);
 		if (ret < 0)
 			break;
 		rc = be32_to_cpu(header->return_code);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 18ef432a3fde..2d6d934f1c8b 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -523,6 +523,8 @@ static inline void tpm_msleep(unsigned int delay_msec)
 		     delay_msec * 1000);
 };
 
+int tpm_chip_start(struct tpm_chip *chip, unsigned int flags);
+void tpm_chip_stop(struct tpm_chip *chip, unsigned int flags);
 struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
 __must_check int tpm_try_get_ops(struct tpm_chip *chip);
 void tpm_put_ops(struct tpm_chip *chip);
-- 
2.19.1

