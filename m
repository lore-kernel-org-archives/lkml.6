Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48+AffO1+ZQfRGdc0hJbVl4vURDcwHpVnOhTrM/vKSNhwHz2jHokp6DXJmzY69OZ5EAnOZQ
ARC-Seal: i=1; a=rsa-sha256; t=1523399734; cv=none;
        d=google.com; s=arc-20160816;
        b=euYFmQvNfpyPq2bkYig3uGFOaUVEz+ba8xhw1ZbjAiFMuYfyYFS6xzT+w5SIXBku+4
         9eIgyotFI5GVVdrCRh73tJns9Il4IUz/1TL1iD4D69KJeRnuJZD6zpukt8lFv0ipf7pV
         Z0xqFeRVPEDquO59k+QNr3gN0t78gUJeB5RdJtcxIh4vXM+AdyqHPI71rovGDQ+B7NgC
         Bj7Ceywb0rcfYUzisA+PxS7QDcZHZM+IkdbpuTzW7BBCTIFmBCjNXcdHHHf1HEoTfdCz
         xMaGfIFhLRIx/azYiwKn3Lye5HrV9hIBj8wUySyQ1Eo6mn7EAvZPen9GSzJBvSpL8LNC
         hDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=21gzbpCqpAZyV6qkbJv8yGEg1NK2OTG8DUbExni2wb8=;
        b=nvoH7OcQpikegiNXMJ0Zl6DQN6KFd9F0Mkoo964pr+sNl1kcJbkw5YfYhcArUuaaj2
         sRRTLtKJdWRveMlj2zs9dF9Bq1goXQYfCUUzmBgt+OS7xlZ4GEfC3T0nXe+vQieG+pzq
         u4TTnOIZo3brQZoZEOR2KvnEHcmN+LL4BLt2apeQIPKfslWkI+JlQy+JrD0sCKHLPDED
         x/9IkffbRFx4RsbUhsPBVa0s+rMqcZ0ILZluKHpndufV9XZ/Vo10ADVgorL5oiSzCIVF
         Ik0Aj2/Knge+GDT1RfSoiPJu9775qmSMHNPsyZQk2+PXKSqpxqo8/sysec+gYG1tgU5B
         VmQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Javier Martinez Canillas <javierm@redhat.com>,
	William Roberts <william.c.roberts@intel.com>,
	Philip Tricca <philip.b.tricca@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 045/138] tpm: return a TPM_RC_COMMAND_CODE response if command is not implemented
Date: Wed, 11 Apr 2018 00:23:55 +0200
Message-Id: <20180410212907.338094843@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400004824783636?=
X-GMAIL-MSGID: =?utf-8?q?1597400400286474938?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Martinez Canillas <javierm@redhat.com>


[ Upstream commit 095531f891e627e408606f2da4008d3d53e6748a ]

According to the TPM Library Specification, a TPM device must do a command
header validation before processing and return a TPM_RC_COMMAND_CODE code
if the command is not implemented.

So user-space will expect to handle that response as an error. But if the
in-kernel resource manager is used (/dev/tpmrm?), an -EINVAL errno code is
returned instead if the command isn't implemented. This confuses userspace
since it doesn't expect that error value.

This also isn't consistent with the behavior when not using TPM spaces and
accessing the TPM directly (/dev/tpm?). In this case, the command is sent
to the TPM even when not implemented and the TPM responds with an error.

Instead of returning an -EINVAL errno code when the tpm_validate_command()
function fails, synthesize a TPM command response so user-space can get a
TPM_RC_COMMAND_CODE as expected when a chip doesn't implement the command.

The TPM only sets 12 of the 32 bits in the TPM_RC response, so the TSS and
TAB specifications define that higher layers in the stack should use some
of the unused 20 bits to specify from which level of the stack the error
is coming from.

Since the TPM_RC_COMMAND_CODE response code is sent by the kernel resource
manager, set the error level to the TAB/RM layer so user-space is aware of
this.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: William Roberts <william.c.roberts@intel.com>
Reviewed-by: Philip Tricca <philip.b.tricca@intel.com>
Reviewed-by: Jarkko Sakkinen  <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen  <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen  <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm-interface.c |   28 ++++++++++++++++++++--------
 drivers/char/tpm/tpm.h           |    5 +++++
 2 files changed, 25 insertions(+), 8 deletions(-)

--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -328,7 +328,7 @@ unsigned long tpm_calc_ordinal_duration(
 }
 EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
 
-static bool tpm_validate_command(struct tpm_chip *chip,
+static int tpm_validate_command(struct tpm_chip *chip,
 				 struct tpm_space *space,
 				 const u8 *cmd,
 				 size_t len)
@@ -340,10 +340,10 @@ static bool tpm_validate_command(struct
 	unsigned int nr_handles;
 
 	if (len < TPM_HEADER_SIZE)
-		return false;
+		return -EINVAL;
 
 	if (!space)
-		return true;
+		return 0;
 
 	if (chip->flags & TPM_CHIP_FLAG_TPM2 && chip->nr_commands) {
 		cc = be32_to_cpu(header->ordinal);
@@ -352,7 +352,7 @@ static bool tpm_validate_command(struct
 		if (i < 0) {
 			dev_dbg(&chip->dev, "0x%04X is an invalid command\n",
 				cc);
-			return false;
+			return -EOPNOTSUPP;
 		}
 
 		attrs = chip->cc_attrs_tbl[i];
@@ -362,11 +362,11 @@ static bool tpm_validate_command(struct
 			goto err_len;
 	}
 
-	return true;
+	return 0;
 err_len:
 	dev_dbg(&chip->dev,
 		"%s: insufficient command length %zu", __func__, len);
-	return false;
+	return -EINVAL;
 }
 
 /**
@@ -391,8 +391,20 @@ ssize_t tpm_transmit(struct tpm_chip *ch
 	unsigned long stop;
 	bool need_locality;
 
-	if (!tpm_validate_command(chip, space, buf, bufsiz))
-		return -EINVAL;
+	rc = tpm_validate_command(chip, space, buf, bufsiz);
+	if (rc == -EINVAL)
+		return rc;
+	/*
+	 * If the command is not implemented by the TPM, synthesize a
+	 * response with a TPM2_RC_COMMAND_CODE return for user-space.
+	 */
+	if (rc == -EOPNOTSUPP) {
+		header->length = cpu_to_be32(sizeof(*header));
+		header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
+		header->return_code = cpu_to_be32(TPM2_RC_COMMAND_CODE |
+						  TSS2_RESMGR_TPM_RC_LAYER);
+		return bufsiz;
+	}
 
 	if (bufsiz > TPM_BUFSIZE)
 		bufsiz = TPM_BUFSIZE;
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -93,12 +93,17 @@ enum tpm2_structures {
 	TPM2_ST_SESSIONS	= 0x8002,
 };
 
+/* Indicates from what layer of the software stack the error comes from */
+#define TSS2_RC_LAYER_SHIFT	 16
+#define TSS2_RESMGR_TPM_RC_LAYER (11 << TSS2_RC_LAYER_SHIFT)
+
 enum tpm2_return_codes {
 	TPM2_RC_SUCCESS		= 0x0000,
 	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
 	TPM2_RC_HANDLE		= 0x008B,
 	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
 	TPM2_RC_DISABLED	= 0x0120,
+	TPM2_RC_COMMAND_CODE    = 0x0143,
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
 	TPM2_RC_REFERENCE_H0	= 0x0910,
 };
