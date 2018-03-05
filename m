Return-Path: <jarkko.sakkinen@intel.com>
X-Google-Smtp-Source: AG47ELuoCqP81DXUyey6DTGM9N+cTyflaRf+8JpckB47WD9VzqBxrvbwDQ2NH6hQnVPJ49FJ3yv2
ARC-Seal: i=1; a=rsa-sha256; t=1520269003; cv=none;
        d=google.com; s=arc-20160816;
        b=nudcHFn2Ckz0KFkuFV30EUiTV1N+ruaaAz24Do+C7VMhDYI8V7hFhF5/hSaVFx4V4d
         /wd1dOk3UMOOMmHlUXOVY63xJfHuGTM+pTsXDXtvJ5MiCJpIdXryboUS7OnFWySVLxT6
         IlZkR+NWKaotF7IEzqLy6LrNXQrryQbSjY7xI1tbSrctjP1yW25CX1kBC5Otqnp6zGto
         iFJqntBcUxYbqKGAhNK8+FVByaJkb5Rj/QXG4Bj62KcQOn4hPTGAxRICnQyMdd106Ykw
         9+C2KyCqujPnrZZJIjsqdIdpJ/U4MgFRjMY/+cnwiDpOFGh+LxY0ypul9L7dFjwz9biZ
         qT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=vd/hZHdZmtGE7BD9Pf8NzmWdcvYMUNmY9HRT8/goVn4=;
        b=gwEREwK9vL4n+3Qg1cjjibsGQXze5Uk/bzR0r5ADnRo50MiOkQmrB5FZ60YXvf3JBQ
         cxGtq8sT5nKLKh8ttfa2ZYjskPw3d5CfOaq9M95nbIqtL0K+azdtAdACWmVQw+5IzX9F
         67KjxembWeY3Qr1dxji8MA8vEwA/cwYWbIIynppI0r6VglhCfQ1qiUiJV4oYGEePA7N6
         /SgLGuUI4N7Y8jVagnl1i1n8LZpfPhqrHHj/83he4FoDxPpMxI4JpZ7XKEIICZX3nguZ
         MkTayVfgrnpSyYcyCCSwkxoKiSgCILoxijAV5Vygat6BXaOEjwZnfB+sJT7W2SrJZn1M
         DPkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="35627958"
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
Subject: [PATCH v3 4/5] tpm: migrate tpm2_get_tpm_pt() to use struct tpm_buf
Date: Mon,  5 Mar 2018 18:56:13 +0200
Message-Id: <20180305165614.5469-5-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108972817157025?=
X-GMAIL-MSGID: =?utf-8?q?1594117590606293901?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order to make struct tpm_buf the first class object for constructing TPM
commands, migrate tpm2_get_tpm_pt() to use it.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm2-cmd.c | 63 +++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 40 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 890d83c5c78b..e02f7d46e9ac 100644
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
@@ -723,6 +694,14 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
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
@@ -735,19 +714,23 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
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
