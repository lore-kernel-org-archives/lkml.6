Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC1DECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6BE20843
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6BE20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbeKDCU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 22:20:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:44294 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbeKDCU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 22:20:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2018 10:08:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,460,1534834800"; 
   d="scan'208";a="97385565"
Received: from rysgaard-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.46])
  by orsmga003.jf.intel.com with ESMTP; 03 Nov 2018 10:08:29 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/8] tpm: clean up tpm_try_transmit() error handling flow
Date:   Sat,  3 Nov 2018 19:08:00 +0200
Message-Id: <20181103170806.12177-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181103170806.12177-1-jarkko.sakkinen@linux.intel.com>
References: <20181103170806.12177-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move locking, locality handling and power management to tpm_transmit()
in order to simplify the flow and fix the error message formatting in
tpm_try_transmit() to output correct function name by using the
'__func__' macro.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-interface.c | 99 ++++++++++++++------------------
 1 file changed, 44 insertions(+), 55 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 64510ed81b46..a5d6e9dd2998 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -171,7 +171,6 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 	ssize_t len = 0;
 	u32 count, ordinal;
 	unsigned long stop;
-	bool need_locality;
 
 	rc = tpm_validate_command(chip, space, buf, bufsiz);
 	if (rc == -EINVAL)
@@ -201,37 +200,16 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
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
+		return rc;
 	}
 
 	if (chip->flags & TPM_CHIP_FLAG_IRQ)
@@ -246,8 +224,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 
 		if (chip->ops->req_canceled(chip, status)) {
 			dev_err(&chip->dev, "Operation Canceled\n");
-			rc = -ECANCELED;
-			goto out;
+			return -ECANCELED;
 		}
 
 		tpm_msleep(TPM_TIMEOUT_POLL);
@@ -256,44 +233,22 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 
 	chip->ops->cancel(chip);
 	dev_err(&chip->dev, "Operation Timed out\n");
-	rc = -ETIME;
-	goto out;
+	return -ETIME;
 
 out_recv:
 	len = chip->ops->recv(chip, buf, bufsiz);
 	if (len < 0) {
-		rc = len;
-		dev_err(&chip->dev,
-			"tpm_transmit: tpm_recv: error %d\n", rc);
-		goto out;
-	} else if (len < TPM_HEADER_SIZE) {
-		rc = -EFAULT;
-		goto out;
-	}
-
-	if (len != be32_to_cpu(header->length)) {
-		rc = -EFAULT;
-		goto out;
+		dev_err(&chip->dev, "%s: recv error %d\n", __func__, len);
+		return len;
 	}
+	if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
+		return -EFAULT;
 
 	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
 	if (rc)
-		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
-
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
+		return rc;
 
-	if (!(flags & TPM_TRANSMIT_UNLOCKED) && !(flags & TPM_TRANSMIT_NESTED))
-		mutex_unlock(&chip->tpm_mutex);
-	return rc ? rc : len;
+	return len;
 }
 
 /**
@@ -322,6 +277,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	/* space for header and handles */
 	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
 	unsigned int delay_msec = TPM2_DURATION_SHORT;
+	bool has_locality = false;
 	u32 rc = 0;
 	ssize_t ret;
 	const size_t save_size = min(space ? sizeof(save) : TPM_HEADER_SIZE,
@@ -337,7 +293,40 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
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
-- 
2.19.1

