Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AC8C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C2E20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C2E20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbeKELDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 06:03:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:1500 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbeKELDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 06:03:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 17:46:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,466,1534834800"; 
   d="scan'208";a="271354214"
Received: from unknown (HELO localhost) ([10.249.254.144])
  by orsmga005.jf.intel.com with ESMTP; 04 Nov 2018 17:46:33 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 04/16] tpm: call tpm2_flush_space() on error in tpm_try_transmit()
Date:   Mon,  5 Nov 2018 03:45:37 +0200
Message-Id: <20181105014552.20262-5-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105014552.20262-1-jarkko.sakkinen@linux.intel.com>
References: <20181105014552.20262-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always call tpm2_flush_space() on failure in tpm_try_transmit() so that
the volatile memory of the TPM gets cleared. If /dev/tpm0 does not have
sufficient permissions (usually it has), this could leak to the leakage
of TPM objects. Through /dev/tpmrm0 this issue does not raise new
security concerns.

Cc: stable@vger.kernel.org
Fixes: 745b361e989a ("tpm:tpm: infrastructure for TPM spaces")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-interface.c | 28 +++++++++++++++++-----------
 drivers/char/tpm/tpm.h           |  1 +
 drivers/char/tpm/tpm2-space.c    |  2 +-
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 64510ed81b46..ecda6f96cde0 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -224,14 +224,14 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 
 	rc = tpm2_prepare_space(chip, space, ordinal, buf);
 	if (rc)
-		goto out;
+		goto out_idle;
 
 	rc = chip->ops->send(chip, buf, count);
 	if (rc < 0) {
 		if (rc != -EPIPE)
 			dev_err(&chip->dev,
 				"%s: tpm_send: error %d\n", __func__, rc);
-		goto out;
+		goto out_space;
 	}
 
 	if (chip->flags & TPM_CHIP_FLAG_IRQ)
@@ -247,7 +247,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 		if (chip->ops->req_canceled(chip, status)) {
 			dev_err(&chip->dev, "Operation Canceled\n");
 			rc = -ECANCELED;
-			goto out;
+			goto out_space;
 		}
 
 		tpm_msleep(TPM_TIMEOUT_POLL);
@@ -257,7 +257,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 	chip->ops->cancel(chip);
 	dev_err(&chip->dev, "Operation Timed out\n");
 	rc = -ETIME;
-	goto out;
+	goto out_space;
 
 out_recv:
 	len = chip->ops->recv(chip, buf, bufsiz);
@@ -265,22 +265,28 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 		rc = len;
 		dev_err(&chip->dev,
 			"tpm_transmit: tpm_recv: error %d\n", rc);
-		goto out;
+		goto out_idle;
 	} else if (len < TPM_HEADER_SIZE) {
 		rc = -EFAULT;
-		goto out;
+		goto out_idle;
 	}
 
 	if (len != be32_to_cpu(header->length)) {
 		rc = -EFAULT;
-		goto out;
+		goto out_idle;
 	}
 
-	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
-	if (rc)
-		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
+out_space:
+	if (rc) {
+		tpm2_flush_space(chip);
+	} else {
+		rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
+		if (rc)
+			dev_err(&chip->dev, "tpm2_commit_space: error %d\n",
+				rc);
+	}
 
-out:
+out_idle:
 	/* may fail but do not override previous error value in rc */
 	tpm_go_idle(chip, flags);
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 49bca4d1e786..229ac42b644e 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -579,6 +579,7 @@ int tpm2_probe(struct tpm_chip *chip);
 int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
 int tpm2_init_space(struct tpm_space *space);
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
+void tpm2_flush_space(struct tpm_chip *chip);
 int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u32 cc,
 		       u8 *cmd);
 int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 1131a8e7b79b..d53c882268ff 100644
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

