Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04DCC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763AF217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbfBEWse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:48:34 -0500
Received: from mga06.intel.com ([134.134.136.31]:62937 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729902AbfBEWsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:48:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 14:48:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,337,1544515200"; 
   d="scan'208";a="113982193"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.171])
  by orsmga006.jf.intel.com with ESMTP; 05 Feb 2019 14:48:23 -0800
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
Subject: [PATCH v11 08/16] tpm: clean up tpm_try_transmit() error handling flow
Date:   Wed,  6 Feb 2019 00:47:15 +0200
Message-Id: <20190205224723.19671-9-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move locking, locality handling and power management to tpm_transmit()
in order to simplify the flow.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-interface.c | 94 +++++++++++++++-----------------
 drivers/char/tpm/tpm.h           |  1 +
 drivers/char/tpm/tpm2-space.c    |  2 +-
 3 files changed, 45 insertions(+), 52 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index c28ffef92f1a..f5f5224f68b0 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -167,7 +167,6 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	ssize_t len = 0;
 	u32 count, ordinal;
 	unsigned long stop;
-	bool need_locality;
 
 	rc = tpm_validate_command(chip, space, buf, bufsiz);
 	if (rc == -EINVAL)
@@ -197,37 +196,16 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, struct tpm_space *space,
 		return -E2BIG;
 	}
 
-	if (!(flags & TPM_TRANSMIT_UNLOCKED) && !(flags & TPM_TRANSMIT_NESTED))
-		mutex_lock(&chip->tpm_mutex);
-
-	if (chip->ops->clk_enable != NULL)
-		chip->ops->clk_enable(chip, true);
-
-	/* Store the decision as chip->locality will be changed. */
-	need_locality = chip->locality == -1;
-
-	if (need_locality) {
-		rc = tpm_request_locality(chip, flags);
-		if (rc < 0) {
-			need_locality = false;
-			goto out_locality;
-		}
-	}
-
-	rc = tpm_cmd_ready(chip, flags);
-	if (rc)
-		goto out_locality;
-
 	rc = tpm2_prepare_space(chip, space, ordinal, buf);
 	if (rc)
-		goto out;
+		return rc;
 
 	rc = chip->ops->send(chip, buf, count);
 	if (rc < 0) {
 		if (rc != -EPIPE)
 			dev_err(&chip->dev,
 				"%s: tpm_send: error %d\n", __func__, rc);
-		goto out;
+		goto out_rc;
 	}
 
 	if (chip->flags & TPM_CHIP_FLAG_IRQ)
@@ -243,7 +221,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, struct tpm_space *space,
 		if (chip->ops->req_canceled(chip, status)) {
 			dev_err(&chip->dev, "Operation Canceled\n");
 			rc = -ECANCELED;
-			goto out;
+			goto out_rc;
 		}
 
 		tpm_msleep(TPM_TIMEOUT_POLL);
@@ -253,40 +231,20 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	chip->ops->cancel(chip);
 	dev_err(&chip->dev, "Operation Timed out\n");
 	rc = -ETIME;
-	goto out;
+	goto out_rc;
 
 out_recv:
 	len = chip->ops->recv(chip, buf, bufsiz);
 	if (len < 0) {
 		rc = len;
-		dev_err(&chip->dev,
-			"tpm_transmit: tpm_recv: error %d\n", rc);
-		goto out;
-	} else if (len < TPM_HEADER_SIZE) {
+		dev_err(&chip->dev, "tpm_transmit: tpm_recv: error %d\n", rc);
+	} else if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
 		rc = -EFAULT;
-		goto out;
-	}
 
-	if (len != be32_to_cpu(header->length)) {
-		rc = -EFAULT;
-		goto out;
-	}
-
-	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
+out_rc:
+	if (!rc)
+		rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
 
-out:
-	/* may fail but do not override previous error value in rc */
-	tpm_go_idle(chip, flags);
-
-out_locality:
-	if (need_locality)
-		tpm_relinquish_locality(chip, flags);
-
-	if (chip->ops->clk_enable != NULL)
-		chip->ops->clk_enable(chip, false);
-
-	if (!(flags & TPM_TRANSMIT_UNLOCKED) && !(flags & TPM_TRANSMIT_NESTED))
-		mutex_unlock(&chip->tpm_mutex);
 	return rc ? rc : len;
 }
 
@@ -316,6 +274,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	/* space for header and handles */
 	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
 	unsigned int delay_msec = TPM2_DURATION_SHORT;
+	bool has_locality = false;
 	u32 rc = 0;
 	ssize_t ret;
 	const size_t save_size = min(space ? sizeof(save) : TPM_HEADER_SIZE,
@@ -331,7 +290,40 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	memcpy(save, buf, save_size);
 
 	for (;;) {
+		if (!(flags & TPM_TRANSMIT_UNLOCKED) &&
+		    !(flags & TPM_TRANSMIT_NESTED))
+			mutex_lock(&chip->tpm_mutex);
+
+		if (chip->ops->clk_enable != NULL)
+			chip->ops->clk_enable(chip, true);
+
+		if (chip->locality == -1) {
+			ret = tpm_request_locality(chip, flags);
+			if (ret)
+				goto out_locality;
+			has_locality = true;
+		}
+
+		ret = tpm_cmd_ready(chip, flags);
+		if (ret)
+			goto out_locality;
+
 		ret = tpm_try_transmit(chip, space, buf, bufsiz, flags);
+
+		/* This may fail but do not override ret. */
+		tpm_go_idle(chip, flags);
+
+out_locality:
+		if (has_locality)
+			tpm_relinquish_locality(chip, flags);
+
+		if (chip->ops->clk_enable != NULL)
+			chip->ops->clk_enable(chip, false);
+
+		if (!(flags & TPM_TRANSMIT_UNLOCKED) &&
+		    !(flags & TPM_TRANSMIT_NESTED))
+			mutex_unlock(&chip->tpm_mutex);
+
 		if (ret < 0)
 			break;
 		rc = be32_to_cpu(header->return_code);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 1454ef19d2f4..6eb67ccad2a3 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -576,6 +576,7 @@ int tpm2_probe(struct tpm_chip *chip);
 int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
 int tpm2_init_space(struct tpm_space *space);
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
+void tpm2_flush_space(struct tpm_chip *chip);
 int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u32 cc,
 		       u8 *cmd);
 int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 39cb3915771e..5d6487575074 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -162,7 +162,7 @@ static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
 	return 0;
 }
 
-static void tpm2_flush_space(struct tpm_chip *chip)
+void tpm2_flush_space(struct tpm_chip *chip)
 {
 	struct tpm_space *space = &chip->work_space;
 	int i;
-- 
2.19.1

