Return-Path: <jarkko.sakkinen@intel.com>
X-Google-Smtp-Source: AG47ELsMUe/IR2MwkHgOAtv7uKLFN637Fg/ZQi8B4GZ84f3IbzkYCpGdADa45erZwUVaHqvUtW1h
ARC-Seal: i=1; a=rsa-sha256; t=1522066476; cv=none;
        d=google.com; s=arc-20160816;
        b=HZNpgKsyvNEPjyF784e7iaoWfDr5XtEXt/4cvI128cXd2ddg/v3FWa4Whdyxh/8gbG
         cYYE0u+sZBmmkH+CsM6hsiLUuScqVi0A8NI/3qrcwG9G6fTP7k8a7gRS98M29K189onB
         YPKibCoRch3uxk/0pie7yMYyDJX15v9IolA9XA/bN2PEp8+65wzbXoRiD4b9HIqriKau
         qm6LZmM7KLMtEuXNxA+LiXxOMn1z6troKoH6qENocAI2BxXk18V2LaeHdPgleLyNbWbz
         B8hlbHnIRFOlTee47yqJtNQfYeGLQnc0apG/e44kHH8TtiSLt6iZ/boU8ZMBKlCFTQlp
         DW3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=pRjvgcqQPJ47BCbb4AtNcvrQhu0BzKSjv0KDGXdVbQw=;
        b=COT/1O5oDjJ6pGnA5XUwokg5noVc2z6doBigo3kLnGvjyFsWIDjFotLUSPAGMDu8By
         zfxOY/ClfV51yHG7uP9cL/NzFrhtBIir2Mc8AU6iVsQstcGYM3nnnIxzFT4MF95uABJC
         OwXs5pWadGQ08rgY24NuBbktFlGIZPi5Ac9fKq/eANhNvMoeHNF1Y7e/sV48rehwMSdj
         OFgRSP2KVQ610UF9NssqaQ33ONqXHaEyCdz4oUewM0LTvNEvoZR68ePLPoq6LoputSlk
         JL3MzVmzGP9Y7Lg6lMmkJtOsNk8t+ifd2DKaXHqL5ckFYgYVTOdY368HQbDI29UF8rdA
         XK5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jarkko.sakkinen@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jarkko.sakkinen@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="41292432"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/4] tpm: migrate tpm2_probe() to use struct tpm_buf
Date: Mon, 26 Mar 2018 15:14:04 +0300
Message-Id: <20180326121406.14548-3-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596002378220804070?=
X-GMAIL-MSGID: =?utf-8?q?1596002378220804070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order to make struct tpm_buf the first class object for constructing TPM
commands, migrate tpm2_probe() to use it.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Acked-by: Jay Freyensee <why2jjj.linux@gmail.com>
---
 drivers/char/tpm/tpm2-cmd.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 7665661d9230..7bffd0fd1dca 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -844,30 +844,35 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
 
 /**
  * tpm2_probe() - probe TPM 2.0
- * @chip: TPM chip to use
+ * @chip: a TPM chip to probe
  *
- * Return: < 0 error and 0 on success.
+ * Return: 0 on success,
+ *         -errno otherwise
  *
- * Send idempotent TPM 2.0 command and see whether TPM 2.0 chip replied based on
- * the reply tag.
+ * Send an idempotent TPM 2.0 command and see whether there is TPM2 chip in the
+ * other end based on the response tag. The flag TPM_CHIP_FLAG_TPM2 is set if
+ * this is the case.
  */
 int tpm2_probe(struct tpm_chip *chip)
 {
-	struct tpm2_cmd cmd;
+	struct tpm_output_header *out;
+	struct tpm_buf buf;
 	int rc;
 
-	cmd.header.in = tpm2_get_tpm_pt_header;
-	cmd.params.get_tpm_pt_in.cap_id = cpu_to_be32(TPM2_CAP_TPM_PROPERTIES);
-	cmd.params.get_tpm_pt_in.property_id = cpu_to_be32(0x100);
-	cmd.params.get_tpm_pt_in.property_cnt = cpu_to_be32(1);
-
-	rc = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd), 0, 0, NULL);
-	if (rc <  0)
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
+	if (rc)
 		return rc;
-
-	if (be16_to_cpu(cmd.header.out.tag) == TPM2_ST_NO_SESSIONS)
-		chip->flags |= TPM_CHIP_FLAG_TPM2;
-
+	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
+	tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
+	tpm_buf_append_u32(&buf, 1);
+	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
+	/* We ignore TPM return codes on purpose. */
+	if (rc >=  0) {
+		out = (struct tpm_output_header *)buf.data;
+		if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
+			chip->flags |= TPM_CHIP_FLAG_TPM2;
+	}
+	tpm_buf_destroy(&buf);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm2_probe);
-- 
2.15.1
