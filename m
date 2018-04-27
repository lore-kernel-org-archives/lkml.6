Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo3XlOAcAaPxjC7d1lp5eganpNwuly4dnAe9HKfGvbjAYBKENAkgMNGQOdjtMLI47WoQhde
ARC-Seal: i=1; a=rsa-sha256; t=1524838253; cv=none;
        d=google.com; s=arc-20160816;
        b=rYRDgL95r9gETUH5MJnxF9h92fPQbr+twNzjGOvhQLeyyK+FYNJEfCt7do8vb9ZPT6
         51zhRwaBp0wvMPe95a1fXGlc6/KrMVyjiEMqYY1Br3JYEtDC0o7xUOuLL4cDvSWq21UJ
         ukB+h/8AXtmMM8de9lybZgaEkrPngyJtX7IKbZgoDZCXxDSWERgf1G8ZDYikekRGCEbu
         RlgXTpLSVVQxvzX9/106RvYrTkAyiDbCl4V++w/c5+dC/mjSfG8a89J1ruIVbiCwam5N
         fmGCPSGQX9mvnF4DHbVabx+VyQFSO7LDP4BNUqrvlJu4tby7S3YK3opbiin+IaLL5RTm
         EjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=v330I6AoCtuc4xQLZvQRwTrXpC3evAQMuOoJErx6AgM=;
        b=P1a/0XdLafaYU55HUaHKXGLBcpn7UQtR7FzrIgfWhOH1+DT2DKy803gf9axLCrjrWe
         VyvhsZrGru37+7ho00Prlq/me37rBMLgO9nXim8RKFHK+J+jm5Fc5IBUswG3KWCQM1kX
         zKxg8JiArZ0rsN9lrN8klzBWIhSJq+T/Iz2CkOR7/ECTwtuL3FAiuaKdD1SQNL+2l4EY
         xBlA9OnOKYt6cf0Kdc9bqWlhv05/WnaJ4OOwdiBEx9lXs63EOnNdHHk++YikcEX8k6QP
         MIDT1/2SAHRTTWk9LuJ8dyaJnfqJ89Ylz+TTcM3Id7sGevmm58Gkg9iQmLH9Un3DHFki
         QHoA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0629B2189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 4.16 06/81] tpm: add retry logic
Date: Fri, 27 Apr 2018 15:58:08 +0200
Message-Id: <20180427135743.625154551@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908571168840888?=
X-GMAIL-MSGID: =?utf-8?q?1598908796562125030?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Bottomley <James.Bottomley@HansenPartnership.com>

commit e2fb992d82c626c43ed0566e07c410e56a087af3 upstream.

TPM2 can return TPM2_RC_RETRY to any command and when it does we get
unexpected failures inside the kernel that surprise users (this is
mostly observed in the trusted key handling code).  The UEFI 2.6 spec
has advice on how to handle this:

    The firmware SHALL not return TPM2_RC_RETRY prior to the completion
    of the call to ExitBootServices().

    Implementer’s Note: the implementation of this function should check
    the return value in the TPM response and, if it is TPM2_RC_RETRY,
    resend the command. The implementation may abort if a sufficient
    number of retries has been done.

So we follow that advice in our tpm_transmit() code using
TPM2_DURATION_SHORT as the initial wait duration and
TPM2_DURATION_LONG as the maximum wait time.  This should fix all the
in-kernel use cases and also means that user space TSS implementations
don't have to have their own retry handling.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm-interface.c |   75 +++++++++++++++++++++++++++++++--------
 drivers/char/tpm/tpm.h           |    1 
 2 files changed, 61 insertions(+), 15 deletions(-)

--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -399,21 +399,10 @@ static void tpm_relinquish_locality(stru
 	chip->locality = -1;
 }
 
-/**
- * tpm_transmit - Internal kernel interface to transmit TPM commands.
- *
- * @chip: TPM chip to use
- * @space: tpm space
- * @buf: TPM command buffer
- * @bufsiz: length of the TPM command buffer
- * @flags: tpm transmit flags - bitmap
- *
- * Return:
- *     0 when the operation is successful.
- *     A negative number for system errors (errno).
- */
-ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
-		     u8 *buf, size_t bufsiz, unsigned int flags)
+static ssize_t tpm_try_transmit(struct tpm_chip *chip,
+				struct tpm_space *space,
+				u8 *buf, size_t bufsiz,
+				unsigned int flags)
 {
 	struct tpm_output_header *header = (void *)buf;
 	int rc;
@@ -545,6 +534,62 @@ out_no_locality:
 }
 
 /**
+ * tpm_transmit - Internal kernel interface to transmit TPM commands.
+ *
+ * @chip: TPM chip to use
+ * @space: tpm space
+ * @buf: TPM command buffer
+ * @bufsiz: length of the TPM command buffer
+ * @flags: tpm transmit flags - bitmap
+ *
+ * A wrapper around tpm_try_transmit that handles TPM2_RC_RETRY
+ * returns from the TPM and retransmits the command after a delay up
+ * to a maximum wait of TPM2_DURATION_LONG.
+ *
+ * Note: TPM1 never returns TPM2_RC_RETRY so the retry logic is TPM2
+ * only
+ *
+ * Return:
+ *     the length of the return when the operation is successful.
+ *     A negative number for system errors (errno).
+ */
+ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
+		     u8 *buf, size_t bufsiz, unsigned int flags)
+{
+	struct tpm_output_header *header = (struct tpm_output_header *)buf;
+	/* space for header and handles */
+	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
+	unsigned int delay_msec = TPM2_DURATION_SHORT;
+	u32 rc = 0;
+	ssize_t ret;
+	const size_t save_size = min(space ? sizeof(save) : TPM_HEADER_SIZE,
+				     bufsiz);
+
+	/*
+	 * Subtlety here: if we have a space, the handles will be
+	 * transformed, so when we restore the header we also have to
+	 * restore the handles.
+	 */
+	memcpy(save, buf, save_size);
+
+	for (;;) {
+		ret = tpm_try_transmit(chip, space, buf, bufsiz, flags);
+		if (ret < 0)
+			break;
+		rc = be32_to_cpu(header->return_code);
+		if (rc != TPM2_RC_RETRY)
+			break;
+		delay_msec *= 2;
+		if (delay_msec > TPM2_DURATION_LONG) {
+			dev_err(&chip->dev, "TPM is in retry loop\n");
+			break;
+		}
+		tpm_msleep(delay_msec);
+		memcpy(buf, save, save_size);
+	}
+	return ret;
+}
+/**
  * tpm_transmit_cmd - send a tpm command to the device
  *    The function extracts tpm out header return code
  *
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -108,6 +108,7 @@ enum tpm2_return_codes {
 	TPM2_RC_COMMAND_CODE    = 0x0143,
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
 	TPM2_RC_REFERENCE_H0	= 0x0910,
+	TPM2_RC_RETRY		= 0x0922,
 };
 
 enum tpm2_algorithms {
