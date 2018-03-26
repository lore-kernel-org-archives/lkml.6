Return-Path: <jarkko.sakkinen@intel.com>
X-Google-Smtp-Source: AG47ELs+aeKeOXSczPjuoOHpRr3wzNeN8nLDEaDY68l9JOTZAr5az7PmDnD526MfehFhUFV3O6p5
ARC-Seal: i=1; a=rsa-sha256; t=1522066469; cv=none;
        d=google.com; s=arc-20160816;
        b=y+zw6/C6urW6vC6jA0+0bs2B7T2aJbSfI+fGvFuwqR0siLyVeBaLdV1/2zGP9HTJ1R
         mD3cRmdHzRD+DYdJHtq2nisvWccq/vTyqkEqHpVUWU5AsEcL9/uD2E66TxyDqMDP0wNQ
         FYXOYJn/AljBwq6cpegc/TQW5/NJoxpQuENSFl5wyM0CD70+UOhWzvbfYLNJJv33d8Is
         vNCYWwnVupr17GrCKmwBAqABOWfTb3BT0ZXopkKeFVG7CqpTJiAvN1rmXYhf5NQ/rLMz
         VGnJo2TRrPNpEW0iPN+yQpcLCAVjXU+GWY9UbxiBiutB/dSoyB2L7zWNJjLjWlUxJO9S
         Y8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Sl2dgE0yUZM4GR5M3Cz72WRVkejBcnbjaFCDGUW/4HU=;
        b=bLmframIpiUICbDBbEc7RMXrQfySyW/RHJtUK1O57bVcprMtvJDy6ViGTQLZnRlFGV
         8plxREYBf9M+p1gVlDwVe9z+zFO/aCJxEmJe8fpj/U8FqbYXnY7Iu8ZwXOH26ifzk1Bl
         2IGfD5rn6EblHa5tQpQi6ciLSAkdGZS2QD6cul471jltILpqnKXUBww7iBGc2Jc3P6oq
         iboSCJW3V7NHYC3F5pQmOpf8W8nUf2nkiFKLxTB6EpFB+uwi68vSf4sA7sazWlj+gDxN
         HTenZYbxZI5yLJH6cV+3TFYAu+vhCfnY1v46lt62/VCDH8tIppCrik+gkPDNQ7rHEvba
         JtZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="41292391"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/4] tpm: migrate tpm2_shutdown() to use struct tpm_buf
Date: Mon, 26 Mar 2018 15:14:03 +0300
Message-Id: <20180326121406.14548-2-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596002370872973909?=
X-GMAIL-MSGID: =?utf-8?q?1596002370872973909?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order to make struct tpm_buf the first class object for constructing TPM
commands, migrate tpm2_shutdown() to use it. In addition, removed the klog
entry when tpm_transmit_cmd() fails because tpm_tansmit_cmd() already
prints an error message.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm2-cmd.c | 44 ++++++++++++--------------------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 96c77c8e7f40..7665661d9230 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -27,10 +27,6 @@ enum tpm2_session_attributes {
 	TPM2_SA_CONTINUE_SESSION	= BIT(0),
 };
 
-struct tpm2_startup_in {
-	__be16	startup_type;
-} __packed;
-
 struct tpm2_get_tpm_pt_in {
 	__be32	cap_id;
 	__be32	property_id;
@@ -55,7 +51,6 @@ struct tpm2_get_random_out {
 } __packed;
 
 union tpm2_cmd_params {
-	struct	tpm2_startup_in		startup_in;
 	struct	tpm2_get_tpm_pt_in	get_tpm_pt_in;
 	struct	tpm2_get_tpm_pt_out	get_tpm_pt_out;
 	struct	tpm2_get_random_in	getrandom_in;
@@ -412,11 +407,8 @@ void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
 	int rc;
 
 	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_FLUSH_CONTEXT);
-	if (rc) {
-		dev_warn(&chip->dev, "0x%08x was not flushed, out of memory\n",
-			 handle);
+	if (rc)
 		return;
-	}
 
 	tpm_buf_append_u32(&buf, handle);
 
@@ -762,40 +754,28 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
 }
 EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
 
-#define TPM2_SHUTDOWN_IN_SIZE \
-	(sizeof(struct tpm_input_header) + \
-	 sizeof(struct tpm2_startup_in))
-
-static const struct tpm_input_header tpm2_shutdown_header = {
-	.tag = cpu_to_be16(TPM2_ST_NO_SESSIONS),
-	.length = cpu_to_be32(TPM2_SHUTDOWN_IN_SIZE),
-	.ordinal = cpu_to_be32(TPM2_CC_SHUTDOWN)
-};
-
 /**
  * tpm2_shutdown() - send shutdown command to the TPM chip
  *
+ * In places where shutdown command is sent there's no much we can do except
+ * print the error code on a system failure.
+ *
  * @chip:		TPM chip to use.
  * @shutdown_type:	shutdown type. The value is either
  *			TPM_SU_CLEAR or TPM_SU_STATE.
  */
 void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
 {
-	struct tpm2_cmd cmd;
+	struct tpm_buf buf;
 	int rc;
 
-	cmd.header.in = tpm2_shutdown_header;
-	cmd.params.startup_in.startup_type = cpu_to_be16(shutdown_type);
-
-	rc = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd), 0, 0,
-			      "stopping the TPM");
-
-	/* In places where shutdown command is sent there's no much we can do
-	 * except print the error code on a system failure.
-	 */
-	if (rc < 0 && rc != -EPIPE)
-		dev_warn(&chip->dev, "transmit returned %d while stopping the TPM",
-			 rc);
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SHUTDOWN);
+	if (rc)
+		return;
+	tpm_buf_append_u16(&buf, shutdown_type);
+	tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
+			 "stopping the TPM");
+	tpm_buf_destroy(&buf);
 }
 
 /*
-- 
2.15.1
