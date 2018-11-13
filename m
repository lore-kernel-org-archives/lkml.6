Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFAEC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCC6214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCC6214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbeKNEhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:37:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:40336 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbeKNEhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:37:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 10:37:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,229,1539673200"; 
   d="scan'208";a="107948957"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.77])
  by orsmga001.jf.intel.com with ESMTP; 13 Nov 2018 10:37:42 -0800
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
Subject: [PATCH v7 08/17] tpm: call tpm2_flush_space() on error in tpm_try_transmit()
Date:   Tue, 13 Nov 2018 20:36:07 +0200
Message-Id: <20181113183620.27447-9-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113183620.27447-1-jarkko.sakkinen@linux.intel.com>
References: <20181113183620.27447-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always call tpm2_flush_space() on failure in tpm_try_transmit() so that
the volatile memory of the TPM gets cleared. If /dev/tpm0 does not have
sufficient permissions (usually it has), this could lead to the leakage
of TPM objects. Through /dev/tpmrm0 this issue does not raise any new
security concerns.

Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: stable@vger.kernel.org
Fixes: 745b361e989a ("tpm:tpm: infrastructure for TPM spaces")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/tpm-interface.c | 29 ++++++++++++-----------------
 drivers/char/tpm/tpm.h           |  1 +
 drivers/char/tpm/tpm2-space.c    |  2 +-
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 11af50646ed1..ef00b698ec02 100644
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
@@ -257,28 +257,23 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 	chip->ops->cancel(chip);
 	dev_err(&chip->dev, "Operation Timed out\n");
 	rc = -ETIME;
-	goto out;
+	goto out_space;
 
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
+out_space:
+	if (rc)
+		tpm2_flush_space(chip);
+	else
+		rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
 
-out:
+out_idle:
 	/* may fail but do not override previous error value in rc */
 	tpm_go_idle(chip, flags);
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 86fa8ac0ae20..92638ec6ec97 100644
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
index 862ee1ce1755..393d9aadadce 100644
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

