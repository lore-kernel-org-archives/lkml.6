Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF96C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9A8223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9A8223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbeKMWZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:25:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:40690 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732592AbeKMWZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:25:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 04:27:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="108176545"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.77])
  by orsmga002.jf.intel.com with ESMTP; 13 Nov 2018 04:27:05 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 06/17] tpm: clean up tpm_try_transmit() error handling flow
Date:   Tue, 13 Nov 2018 14:25:55 +0200
Message-Id: <20181113122609.21643-7-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113122609.21643-1-jarkko.sakkinen@linux.intel.com>
References: <20181113122609.21643-1-jarkko.sakkinen@linux.intel.com>
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
---
 drivers/char/tpm/tpm-interface.c | 71 ++++++++++++++++----------------
 1 file changed, 35 insertions(+), 36 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 7ffb16edab6f..28d48799b044 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -171,7 +171,6 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 	ssize_t len = 0;
 	u32 count, ordinal;
 	unsigned long stop;
-	bool need_locality;
 
 	rc = tpm_validate_command(chip, space, buf, bufsiz);
 	if (rc == -EINVAL)
@@ -201,30 +200,9 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
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
-		goto out_idle;
+		return rc;
 
 	rc = chip->ops->send(chip, buf, count);
 	if (rc < 0) {
@@ -273,19 +251,6 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 	else
 		rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
 
-out_idle:
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
 
@@ -315,6 +280,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	/* space for header and handles */
 	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
 	unsigned int delay_msec = TPM2_DURATION_SHORT;
+	bool has_locality = false;
 	u32 rc = 0;
 	ssize_t ret;
 	const size_t save_size = min(space ? sizeof(save) : TPM_HEADER_SIZE,
@@ -330,7 +296,40 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
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

