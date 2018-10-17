Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D3BC5ACD0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5047621523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5047621523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeJQOpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:45:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:48122 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbeJQOpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:45:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 23:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,391,1534834800"; 
   d="scan'208";a="79371356"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga008.fm.intel.com with ESMTP; 16 Oct 2018 23:51:05 -0700
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
Subject: [PATCH v6 19/20] tpm1: reimplement tpm1_continue_selftest() using tpm_buf
Date:   Wed, 17 Oct 2018 09:46:12 +0300
Message-Id: <20181017064613.19746-20-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181017064613.19746-1-tomas.winkler@intel.com>
References: <20181017064613.19746-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reimplement tpm1_continue_selftest() using tpm_buf structure.
This is the last command using the old tpm_cmd_t structure
and now the structure can be removed.

Cc: Nayna Jain <nayna@linux.vnet.ibm.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---

V3: New in the series.
V4: Resend.
V5: Fix &buf.data -> buf.data in tpm1_continue_selftest()
V6: Rebase.

 drivers/char/tpm/tpm.h      |  9 ---------
 drivers/char/tpm/tpm1-cmd.c | 21 ++++++++++-----------
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index bf2ef1eeda50..e0778d19da98 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -377,15 +377,6 @@ enum tpm_sub_capabilities {
 	TPM_CAP_PROP_TIS_DURATION = 0x120,
 };
 
-typedef union {
-	struct	tpm_input_header in;
-	struct	tpm_output_header out;
-} tpm_cmd_header;
-
-struct tpm_cmd_t {
-	tpm_cmd_header	header;
-} __packed;
-
 
 /* 128 bytes is an arbitrary cap. This could be as large as TPM_BUFSIZE - 18
  * bytes, but 128 is still a relatively large number of random bytes and
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index d418a27a75e0..6b04648f8184 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -602,15 +602,8 @@ int tpm1_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
 }
 
 #define TPM_ORD_CONTINUE_SELFTEST 83
-#define CONTINUE_SELFTEST_RESULT_SIZE 10
-static const struct tpm_input_header continue_selftest_header = {
-	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
-	.length = cpu_to_be32(10),
-	.ordinal = cpu_to_be32(TPM_ORD_CONTINUE_SELFTEST),
-};
-
 /**
- * tpm_continue_selftest -- run TPM's selftest
+ * tpm_continue_selftest() - run TPM's selftest
  * @chip: TPM chip to use
  *
  * Returns 0 on success, < 0 in case of fatal error or a value > 0 representing
@@ -618,12 +611,18 @@ static const struct tpm_input_header continue_selftest_header = {
  */
 static int tpm1_continue_selftest(struct tpm_chip *chip)
 {
+	struct tpm_buf buf;
 	int rc;
-	struct tpm_cmd_t cmd;
 
-	cmd.header.in = continue_selftest_header;
-	rc = tpm_transmit_cmd(chip, NULL, &cmd, CONTINUE_SELFTEST_RESULT_SIZE,
+	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_CONTINUE_SELFTEST);
+	if (rc)
+		return rc;
+
+	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
 			      0, 0, "continue selftest");
+
+	tpm_buf_destroy(&buf);
+
 	return rc;
 }
 
-- 
2.14.4

