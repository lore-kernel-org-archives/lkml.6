Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD460C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D023206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D023206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeI2FBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:01:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:9469 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbeI2FBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:01:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 15:35:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,316,1534834800"; 
   d="scan'208";a="267880319"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga006.fm.intel.com with ESMTP; 28 Sep 2018 15:35:23 -0700
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
Subject: [PATCH v5 17/21] tpm1: implement tpm1_pcr_read_dev() using tpm_buf structure
Date:   Sat, 29 Sep 2018 01:30:31 +0300
Message-Id: <20180928223035.14471-18-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180928223035.14471-1-tomas.winkler@intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement tpm1_pcr_read_dev() using tpm_buf and remove
now unneeded structures from tpm.h

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---

V3: New in the series.
V4-V5: Resend.
 drivers/char/tpm/tpm.h      | 18 ++----------------
 drivers/char/tpm/tpm1-cmd.c | 38 +++++++++++++++++++++-----------------
 2 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index d6eca81a011a..d0402aa122ec 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -382,13 +382,10 @@ typedef union {
 	struct	tpm_output_header out;
 } tpm_cmd_header;
 
-struct tpm_pcrread_out {
-	u8	pcr_result[TPM_DIGEST_SIZE];
+struct tpm_cmd_t {
+	tpm_cmd_header	header;
 } __packed;
 
-struct tpm_pcrread_in {
-	__be32	pcr_idx;
-} __packed;
 
 /* 128 bytes is an arbitrary cap. This could be as large as TPM_BUFSIZE - 18
  * bytes, but 128 is still a relatively large number of random bytes and
@@ -396,17 +393,6 @@ struct tpm_pcrread_in {
  * compiler warnings about stack frame size. */
 #define TPM_MAX_RNG_DATA	128
 
-typedef union {
-	struct	tpm_pcrread_in	pcrread_in;
-	struct	tpm_pcrread_out	pcrread_out;
-} tpm_cmd_params;
-
-struct tpm_cmd_t {
-	tpm_cmd_header	header;
-	tpm_cmd_params	params;
-} __packed;
-
-
 /* A string buffer type for constructing TPM commands. This is based on the
  * ideas of string buffer code in security/keys/trusted.h but is heap based
  * in order to keep the stack usage minimal.
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index b5c4fa158c30..d30f336518f6 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -571,29 +571,33 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	return rc;
 }
 
-#define TPM_ORDINAL_PCRREAD 21
-#define READ_PCR_RESULT_SIZE 30
-#define READ_PCR_RESULT_BODY_SIZE 20
-static const struct tpm_input_header pcrread_header = {
-	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
-	.length = cpu_to_be32(14),
-	.ordinal = cpu_to_be32(TPM_ORDINAL_PCRREAD)
-};
-
+#define TPM_ORD_PCRREAD 21
 int tpm1_pcr_read_dev(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
 {
+	struct tpm_buf buf;
 	int rc;
-	struct tpm_cmd_t cmd;
 
-	cmd.header.in = pcrread_header;
-	cmd.params.pcrread_in.pcr_idx = cpu_to_be32(pcr_idx);
-	rc = tpm_transmit_cmd(chip, NULL, &cmd, READ_PCR_RESULT_SIZE,
-			      READ_PCR_RESULT_BODY_SIZE, 0,
+	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCRREAD);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, pcr_idx);
+
+	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
+			      TPM_DIGEST_SIZE, 0,
 			      "attempting to read a pcr value");
+	if (rc)
+		goto out;
 
-	if (rc == 0)
-		memcpy(res_buf, cmd.params.pcrread_out.pcr_result,
-		       TPM_DIGEST_SIZE);
+	if (tpm_buf_length(&buf) < TPM_DIGEST_SIZE) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	memcpy(res_buf, &buf.data[TPM_HEADER_SIZE], TPM_DIGEST_SIZE);
+
+out:
+	tpm_buf_destroy(&buf);
 	return rc;
 }
 
-- 
2.14.4

