Return-Path: <jarkko.sakkinen@intel.com>
X-Google-Smtp-Source: AG47ELv9M3afkJVPgv9hk2ozWfgaveaYdmqHhE2uaYEVpl7CwgDFQvZsUGlLwu1igU76G3YHCA+L
ARC-Seal: i=1; a=rsa-sha256; t=1522066483; cv=none;
        d=google.com; s=arc-20160816;
        b=rV7pGRbwbERTI1EstJ9n+Y00SmpBAhOd6Qe3rMjt7XWaQkjgYpDil5+Hz0Tc5vJ/tq
         i4T4DUX6TqeyGZQsTwWesIl5uwLiWS+MkDFW5mUKz1wvJfGfqb3/SHJQRcs5G+wARfG6
         svmFT6S3wcEtE6s98fG652e92+OVwWsBX4YAhQvYRBL4hNQQmGnEZ+2m78DPSe/64T2y
         SWby/HvhbnHzNVKnwEAR9HDfH2WXizfAU7zE1Kfv7mk6qBmx0FQlE5LhMF4Y023yJYhi
         4t8FF0bUUDjbSIWU+DbOdRROAC71Dsl/KUz1/ju8L36t6e19v8k7rO041uZelra6R+RQ
         CelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=+3pbbnYgsNEM+LzAFahBMJqCqVj7M1HcOslQn497mWY=;
        b=FzlibrWCy7ZWfs0kEevbfCkY/9O2hdm+VEmoXqE/XsbaWWWF1teDdLk685ei+9AwsX
         PnH3omkweyRvfYW7sP+bawk65isn34QnyUC2ZXo5kB9tBCsxFCXqCz6p+fdKR/pg1BP8
         b9pmAGuWPnkRMBplL/ipCVp7YY9oWIt/yG1S+sqeg6Nm9bmljt1F8txzmqUw9sXfh4Va
         vrOfqzWJ9aBAIXCu7vqccfyrKOIcsB2uCQC40sOivu/6dyyqng5pIcldh/X7bcdDpNSX
         QgwD7mb6M9GtYvERHLXRTUuau0qo09AlpHX0zIdpt0jMV5FHZNABwWQCvaFUEfNd5KMg
         Nlvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="41292452"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 3/4] tpm: migrate tpm2_get_tpm_pt() to use struct tpm_buf
Date: Mon, 26 Mar 2018 15:14:05 +0300
Message-Id: <20180326121406.14548-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596002384835671162?=
X-GMAIL-MSGID: =?utf-8?q?1596002384835671162?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order to make struct tpm_buf the first class object for constructing TPM
commands, migrate tpm2_get_tpm_pt() to use it.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm2-cmd.c | 63 +++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 40 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 7bffd0fd1dca..b3b52f9eb65f 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -27,20 +27,6 @@ enum tpm2_session_attributes {
 	TPM2_SA_CONTINUE_SESSION	= BIT(0),
 };
 
-struct tpm2_get_tpm_pt_in {
-	__be32	cap_id;
-	__be32	property_id;
-	__be32	property_cnt;
-} __packed;
-
-struct tpm2_get_tpm_pt_out {
-	u8	more_data;
-	__be32	subcap_id;
-	__be32	property_cnt;
-	__be32	property_id;
-	__be32	value;
-} __packed;
-
 struct tpm2_get_random_in {
 	__be16	size;
 } __packed;
@@ -51,8 +37,6 @@ struct tpm2_get_random_out {
 } __packed;
 
 union tpm2_cmd_params {
-	struct	tpm2_get_tpm_pt_in	get_tpm_pt_in;
-	struct	tpm2_get_tpm_pt_out	get_tpm_pt_out;
 	struct	tpm2_get_random_in	getrandom_in;
 	struct	tpm2_get_random_out	getrandom_out;
 };
@@ -379,19 +363,6 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 	return total ? total : -EIO;
 }
 
-#define TPM2_GET_TPM_PT_IN_SIZE \
-	(sizeof(struct tpm_input_header) + \
-	 sizeof(struct tpm2_get_tpm_pt_in))
-
-#define TPM2_GET_TPM_PT_OUT_BODY_SIZE \
-	 sizeof(struct tpm2_get_tpm_pt_out)
-
-static const struct tpm_input_header tpm2_get_tpm_pt_header = {
-	.tag = cpu_to_be16(TPM2_ST_NO_SESSIONS),
-	.length = cpu_to_be32(TPM2_GET_TPM_PT_IN_SIZE),
-	.ordinal = cpu_to_be32(TPM2_CC_GET_CAPABILITY)
-};
-
 /**
  * tpm2_flush_context_cmd() - execute a TPM2_FlushContext command
  * @chip: TPM chip to use
@@ -725,6 +696,14 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 	return rc;
 }
 
+struct tpm2_get_cap_out {
+	u8 more_data;
+	__be32 subcap_id;
+	__be32 property_cnt;
+	__be32 property_id;
+	__be32 value;
+} __packed;
+
 /**
  * tpm2_get_tpm_pt() - get value of a TPM_CAP_TPM_PROPERTIES type property
  * @chip:		TPM chip to use.
@@ -737,19 +716,23 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
 			const char *desc)
 {
-	struct tpm2_cmd cmd;
+	struct tpm2_get_cap_out *out;
+	struct tpm_buf buf;
 	int rc;
 
-	cmd.header.in = tpm2_get_tpm_pt_header;
-	cmd.params.get_tpm_pt_in.cap_id = cpu_to_be32(TPM2_CAP_TPM_PROPERTIES);
-	cmd.params.get_tpm_pt_in.property_id = cpu_to_be32(property_id);
-	cmd.params.get_tpm_pt_in.property_cnt = cpu_to_be32(1);
-
-	rc = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd),
-			      TPM2_GET_TPM_PT_OUT_BODY_SIZE, 0, desc);
-	if (!rc)
-		*value = be32_to_cpu(cmd.params.get_tpm_pt_out.value);
-
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
+	if (rc)
+		return rc;
+	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
+	tpm_buf_append_u32(&buf, property_id);
+	tpm_buf_append_u32(&buf, 1);
+	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
+	if (!rc) {
+		out = (struct tpm2_get_cap_out *)
+			&buf.data[TPM_HEADER_SIZE];
+		*value = be32_to_cpu(out->value);
+	}
+	tpm_buf_destroy(&buf);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
-- 
2.15.1
