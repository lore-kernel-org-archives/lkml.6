Return-Path: <jarkko.sakkinen@intel.com>
X-Google-Smtp-Source: AG47ELs1C+RsOnNWf7ml3C5DZ1E+MxBpTKGvvTDue3sBai5SLC87I8vdadXcVZuhoj5juZMIHH0a
ARC-Seal: i=1; a=rsa-sha256; t=1520268992; cv=none;
        d=google.com; s=arc-20160816;
        b=b0zsgralyQ6BCb2bNbz82Y7/mJPUxs6lAX4/+NWrPU8nd6H/QwLGAirne60DEd68ZU
         McvcoabL/jLT8g6ZLnwmDiixNkKr3HVVB0x87hv5p+fbYei7BWmh+wvmOTI0REk8mbqn
         KsW3jRoTvew2w+DUuWn4KRC0JzE5GIAqOukZD+xP3FVvtVDp6J8V1+/zRK+5E1hKMEzt
         mKwTaUdvx8QkAt+FBlKPLJnh9ELKvWcJ69rO80viA2GMnHVAkjv9GL0glJ6PUrmGFVKO
         QdthGsM/Iez1JUYt+pyQgwQTrR6Qbj80rOfBNGg5uoPLDFErux1Do3lSjCUjSvehVKfZ
         kPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=bHMPeEj0//l/ks4Dln0NUjIK9sgUzoTUIdLtOvl6KJk=;
        b=MVeCEsPbdgocyKpSzHfpeRYMmIYq1ep7Jk1eVNuteZcYgmH/X1p8r64WFlNjwYyjXT
         FV17zXzIho838M6HnxEPVdI5fo4+45pYu+5XrL/6LB7ABQg3VTA+epN8nFGUSE99Xamf
         iY/0aYr0mabfORko+H3lbpZjzUTrhgW2MfFaU6ddsms2z0Gf1yjOfNF54w8eOab3onbZ
         VQkitvRbexBG/JF+kAvfLl0KEuuV4WS8upO6d0FWtgCUDlk7VdaBl3wDFgQOGdpJejaP
         tJENMTIP5rKzcDZdnngpTx2EHabbPo4y7nNOdzZ4PcR+hgt3DgcyZyMKIZpo4cp+UZBY
         pTxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="35627909"
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
Subject: [PATCH v3 2/5] tpm: migrate tpm2_shutdown() to use struct tpm_buf
Date: Mon,  5 Mar 2018 18:56:11 +0200
Message-Id: <20180305165614.5469-3-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108954042776434?=
X-GMAIL-MSGID: =?utf-8?q?1594117578975772535?=
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
index 89a5397b18d2..abe6ef4a7a0b 100644
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
@@ -410,11 +405,8 @@ void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
 	int rc;
 
 	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_FLUSH_CONTEXT);
-	if (rc) {
-		dev_warn(&chip->dev, "0x%08x was not flushed, out of memory\n",
-			 handle);
+	if (rc)
 		return;
-	}
 
 	tpm_buf_append_u32(&buf, handle);
 
@@ -760,40 +752,28 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
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
