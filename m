Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98771ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60279206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60279206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbeIRPK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:10:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:59400 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729915AbeIRPK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:10:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 02:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="71724216"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2018 02:38:37 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v3 19/20] tpm1: reimplement SAVESTATE using tpm_buf
Date:   Tue, 18 Sep 2018 12:34:58 +0300
Message-Id: <20180918093459.19165-20-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180918093459.19165-1-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tpm1_pm_suspend() function reimplement,
TPM_ORD_SAVESTATE comamnd using tpm_buf.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V3: new in the series

 drivers/char/tpm/tpm1-cmd.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 777b1158e1b5..c4a0bacb1378 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -719,12 +719,6 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 }
 
 #define TPM_ORD_SAVESTATE 152
-#define SAVESTATE_RESULT_SIZE 10
-static const struct tpm_input_header savestate_header = {
-	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
-	.length = cpu_to_be32(10),
-	.ordinal = cpu_to_be32(TPM_ORD_SAVESTATE)
-};
 
 /*
  * We are about to suspend. Save the TPM state
@@ -733,18 +727,22 @@ static const struct tpm_input_header savestate_header = {
 int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 {
 	u8 dummy_hash[TPM_DIGEST_SIZE] = { 0 };
-	struct tpm_cmd_t cmd;
-	int rc, try;
+	struct tpm_buf buf;
+	unsigned int try;
+	int rc;
+
 
 	/* for buggy tpm, flush pcrs with extend to selected dummy */
 	if (tpm_suspend_pcr)
 		rc = tpm1_pcr_extend(chip, tpm_suspend_pcr, dummy_hash,
 				     "extending dummy pcr before suspend");
 
+	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_SAVESTATE);
+	if (rc)
+		return rc;
 	/* now do the actual savestate */
 	for (try = 0; try < TPM_RETRY; try++) {
-		cmd.header.in = savestate_header;
-		rc = tpm_transmit_cmd(chip, NULL, &cmd, SAVESTATE_RESULT_SIZE,
+		rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
 				      0, 0, NULL);
 
 		/*
@@ -760,6 +758,8 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 		if (rc != TPM_WARN_RETRY)
 			break;
 		tpm_msleep(TPM_TIMEOUT_RETRY);
+
+		tpm_buf_reset(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_SAVESTATE);
 	}
 
 	if (rc)
@@ -769,6 +769,8 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 		dev_warn(&chip->dev, "TPM savestate took %dms\n",
 			 try * TPM_TIMEOUT_RETRY);
 
+	tpm_buf_destroy(&buf);
+
 	return rc;
 }
 
-- 
2.14.4

