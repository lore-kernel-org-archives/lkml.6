Return-Path: <jarkko.sakkinen@intel.com>
X-Google-Smtp-Source: AH8x225jQ384HxIPYUmTdipcMmWPjjxFkAHuXYzaz5QV4PCAZClEFtnCvS81/jY9MRrpGFHXhkRF
ARC-Seal: i=1; a=rsa-sha256; t=1519847938; cv=none;
        d=google.com; s=arc-20160816;
        b=ahKLGe76dwOtYjl2B/BoRxBfMTL/THBwaTXfD7ODQkLIwt4U5oc4X9N9AIYljmu8O3
         MytHx8M/yAkwSiSjXAanGHgSXz41JTloMxgQuEXarD2yg308HkIAEK2tbtF/X1s9s0LD
         /pd39qr086txF525FHFDLwW1JYo3wvDVtUxTBiBWCgOCUdNQ3i/1JlPFEPBkO9HygNdA
         SKlpLd4/EQy838X7ZfsVFyopBmSu5ZI5y4QkIOXXklG/C8zVaJDWLm/2VLg7y6RzKaE8
         Swabk6xJvS59qxO5tgr1FWo05+DIKbhIyhqiR4IIR8MXVgw0SHy+l2EXZW5t7OV+o25Z
         TUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ymxgh626LGyuVoviv8Q+JZhxG10nJ8Kwk8ronjueZ+E=;
        b=UmVasxMXPFlhRXLXuNuIkz2Ht9ylOsCEiAiAqHU1f454AriQ9dmlnqJ3S/eEV0c46o
         i1icQqrqc9pS434VxZx2aGNhBbKeQmqiSLKTtS/eGNVE0OEWZSkKRex79CnQp/zh61HW
         EVLvSLYSGSG4nLKlP7WW3VbYerBwyYDYNiFLntLgY2bHf+lLQrOv+NtU5t7f5xXj3ePG
         F8OoKz8ZdXNeJBKjlrxJ/LxFW3IOtfGQArqq5PG9/qbGk7Lh5zMAM8Dy3BTe1/Oa7d57
         5yN2nI6WiNfXy6QM7du3koPzUdJvLuwKGuE+UP9MAQPf4RZP+b6wjIMLbEFfQmvcYM8m
         bf4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="scan'208";a="20929745"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] tpm: migrate tpm2_get_tpm_pt() to use struct tpm_buf
Date: Wed, 28 Feb 2018 21:58:17 +0200
Message-Id: <20180228195819.22231-5-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676072454936612?=
X-GMAIL-MSGID: =?utf-8?q?1593676072454936612?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order to make struct tpm_buf the first class object for constructing TPM
commands, migrate tpm2_get_tpm_pt() to use it.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm2-cmd.c | 63 +++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 40 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 36f6b0ac412b..43791947b8e1 100644
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
@@ -377,19 +361,6 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max)
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
@@ -726,6 +697,14 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
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
@@ -738,19 +717,23 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
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
