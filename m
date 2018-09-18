Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34B4ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71F0206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71F0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeIRPKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:10:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:59396 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728936AbeIRPKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:10:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 02:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="71724142"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2018 02:38:07 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v3 06/20] tpm: move tpm1_pcr_extend to tpm1-cmd.c
Date:   Tue, 18 Sep 2018 12:34:45 +0300
Message-Id: <20180918093459.19165-7-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180918093459.19165-1-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move tpm1_pcr_extend to tpm1-cmd.c and remove
unused pcrextend_header structure.

Fixes warning:
drivers/char/tpm/tpm-interface.c:609:38: warning: ‘pcrextend_header’ defined but not used [-Wunused-const-variable=]
 static const struct tpm_input_header pcrextend_header = {
                                      ^~~~~~~~~~~~~~~~
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2-V3: Rebase
 drivers/char/tpm/tpm-interface.c | 28 ----------------------------
 drivers/char/tpm/tpm.h           |  2 ++
 drivers/char/tpm/tpm1-cmd.c      | 22 ++++++++++++++++++++++
 3 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 55f9094a8f11..03134f2e1c39 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -604,34 +604,6 @@ int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
 }
 EXPORT_SYMBOL_GPL(tpm_pcr_read);
 
-#define TPM_ORD_PCR_EXTEND 20
-#define EXTEND_PCR_RESULT_SIZE 34
-#define EXTEND_PCR_RESULT_BODY_SIZE 20
-static const struct tpm_input_header pcrextend_header = {
-	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
-	.length = cpu_to_be32(34),
-	.ordinal = cpu_to_be32(TPM_ORD_PCR_EXTEND)
-};
-
-static int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
-			   char *log_msg)
-{
-	struct tpm_buf buf;
-	int rc;
-
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
-	if (rc)
-		return rc;
-
-	tpm_buf_append_u32(&buf, pcr_idx);
-	tpm_buf_append(&buf, hash, TPM_DIGEST_SIZE);
-
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, EXTEND_PCR_RESULT_SIZE,
-			      EXTEND_PCR_RESULT_BODY_SIZE, 0, log_msg);
-	tpm_buf_destroy(&buf);
-	return rc;
-}
-
 /**
  * tpm_pcr_extend - extend a PCR value in SHA1 bank.
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index a97d72fcda5b..3fb268f43955 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -549,6 +549,8 @@ int tpm_do_selftest(struct tpm_chip *chip);
 int tpm1_auto_startup(struct tpm_chip *chip);
 int tpm1_get_timeouts(struct tpm_chip *chip);
 unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
+int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
+		    const char *log_msg);
 unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm_pm_suspend(struct device *dev);
 int tpm_pm_resume(struct device *dev);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index cce2f83d90e3..5c441e1ad8a8 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -413,3 +413,25 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
 	return 0;
 }
+
+#define TPM_ORD_PCR_EXTEND 20
+#define EXTEND_PCR_RESULT_SIZE 34
+#define EXTEND_PCR_RESULT_BODY_SIZE 20
+int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
+		    const char *log_msg)
+{
+	struct tpm_buf buf;
+	int rc;
+
+	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, pcr_idx);
+	tpm_buf_append(&buf, hash, TPM_DIGEST_SIZE);
+
+	rc = tpm_transmit_cmd(chip, NULL, buf.data, EXTEND_PCR_RESULT_SIZE,
+			      EXTEND_PCR_RESULT_BODY_SIZE, 0, log_msg);
+	tpm_buf_destroy(&buf);
+	return rc;
+}
-- 
2.14.4

