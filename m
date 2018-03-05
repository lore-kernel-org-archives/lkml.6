Return-Path: <jarkko.sakkinen@intel.com>
X-Google-Smtp-Source: AG47ELuqnVGP82sI9yP8FeqORApHfgwyVb/zDC2gPxFUUGih3xdq7riG4yVlj2WtANzH+f3T3FnZ
ARC-Seal: i=1; a=rsa-sha256; t=1520260767; cv=none;
        d=google.com; s=arc-20160816;
        b=kVA3Nhj+yqLxHE7oEn1rnAW+/gL7oWwJtnuvsXFj4D+qpm3hkcIg9ynp9elVN/QTPc
         f57nFLrVz91tsSaxw6ztT0XUF8pXy2mn1Iiy1eMadTg6yWLGN2B0Q+Q6xOoQSamy9hBS
         IEwrgQbV3Gm+x6bL0VKDhu1XZAxUa7LR896YSQ2svwqp/UxM75em94hjF8/Z2F5S9lCz
         u9ioAnBA8dVmdEKW9DVe/hQHs+CWwYTaU7CNv7RpWEDAq/tKz8zOkcchPy0KdFuGzxeV
         w+Ba2/XFy+kb6ObkEiQOHuFE/ZMCGTIwnozqT6dj8PFTpiSWtXD5lSkQKcr5/pyu5xhj
         YVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=bHMPeEj0//l/ks4Dln0NUjIK9sgUzoTUIdLtOvl6KJk=;
        b=VJWJYqqZ3ftTVUZr8oka++nt6JeUH2CkqQYcqn+pcBr2vMBIqh9x3+wUE1IucqZB5n
         +98LFzQyJ58XR4rzu9Akt82eKEtufzvtESi2K4e1axZvhpZ6DkK4184v8W3C3tROuxCh
         VUc6kB1OFccSIyHp2zYvwCLXvL05UmBIGP4x8RGg+lJ+Of1wsAn/oDmC1olhUeUdlY7T
         gnJMlYBKTAXpJAcJkX/9tp22UZ4RKIQdgclOV+BjISa8vNtVaiFsJmDFr0DI1V3Z8EtZ
         +yPxsphyG4cq8YkRXXkGCRlLrLCaf0FG6KbpX4U8CHg4ie7pI2bkxaxXDocBpzofI9IG
         XbCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="39325812"
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
Subject: [PATCH v2 2/5] tpm: migrate tpm2_shutdown() to use struct tpm_buf
Date: Mon,  5 Mar 2018 16:39:00 +0200
Message-Id: <20180305143904.7477-3-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305143904.7477-1-jarkko.sakkinen@linux.intel.com>
References: <20180305143904.7477-1-jarkko.sakkinen@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108954042776434?=
X-GMAIL-MSGID: =?utf-8?q?1594108954042776434?=
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
