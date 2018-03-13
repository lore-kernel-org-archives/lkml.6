Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtu/QYCkJMWYizwNWMerMSnwIOQmNrmeFLF32hIzVSoCSU1m9Ag9h/Zkp7TnKbhQiwvRggH
ARC-Seal: i=1; a=rsa-sha256; t=1520955367; cv=none;
        d=google.com; s=arc-20160816;
        b=IE+iDr2NwJ4gQ7WUjlRAA00y7cbC2rnBZfpBfxciV2XeM6N9Iqnjx6wsgeotdGYcjO
         bdZEKV3K1hlzBe0Y6i+gjdtzEtEfy/ZJdz5EJ/CK3esZShle5S4G5WgvLXr64o0RdmFi
         alk8nqBsJK3U5NxrYGu/pLBjprg3QUMEk3hbSSH6SaRo7sImzwU/nVDeen2GQIjBSlCs
         qOUedzfodR798FxZniq5y1SqgiasbXSWwpQ5jeohBFBIaDUj3P5dMZAmfPrLeqJlSUyT
         NrMQaTdxJNN/LEkl5JfiXotE54Gxf4jAinKxzOzPhnvMwLstgAZSbXlw6glBQuUfFUmB
         gFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=l0r+8iwwSIIF58jq+9ip7Az7PU9SNAq2t3wIV8auk0k=;
        b=eEOpPLQR8B/KaXmQLEux9qaU63AYapKb5t9ElNBzbSfIiiFFPX+jnTC3umhGiioj44
         73xlQnv5fniscwE2wYME2UJm4aMNhsREmSR8tJnqxOvHBy+cZX/C7wJcP6vJTGH+Rn4C
         0YS2nd+U32xa3rUchJIanGNhHEizOSZdm3PEk+S3pjtOMM4MaQQpnYSKcTfBszQXIKIj
         GlBq7ktzS8rQo35vHVl70KFDq4Zr6ZOwaNxLIzDOt2FpSGxWVga7Bgy8UuUAX53m4ato
         zvhrFpPru2qKGYq82tvJKMLrP1bat6eWLVGIoHwII5dDdph/m+G3zlhIqY3dM/eD2ZT5
         5Qdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 4.14 021/140] tpm: delete the TPM_TIS_CLK_ENABLE flag
Date: Tue, 13 Mar 2018 16:23:44 +0100
Message-Id: <20180313152459.480229460@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837112829519145?=
X-GMAIL-MSGID: =?utf-8?q?1594837295844924007?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Martinez Canillas <javierm@redhat.com>

commit 764325add6c2ad1641199edde7b2995495fc2d7c upstream.

This flag is only used to warn if CLKRUN_EN wasn't disabled on Braswell
systems, but the only way this can happen is if the code is not correct.

So it's an unnecessary check that just makes the code harder to read.

Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm_tis.c      |   15 ---------------
 drivers/char/tpm/tpm_tis_core.c |    2 --
 drivers/char/tpm/tpm_tis_core.h |    1 -
 3 files changed, 18 deletions(-)

--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -137,9 +137,6 @@ static int tpm_tcg_read_bytes(struct tpm
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
-		WARN(1, "CLKRUN not enabled!\n");
-
 	while (len--)
 		*result++ = ioread8(phy->iobase + addr);
 
@@ -151,9 +148,6 @@ static int tpm_tcg_write_bytes(struct tp
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
-		WARN(1, "CLKRUN not enabled!\n");
-
 	while (len--)
 		iowrite8(*value++, phy->iobase + addr);
 
@@ -164,9 +158,6 @@ static int tpm_tcg_read16(struct tpm_tis
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
-		WARN(1, "CLKRUN not enabled!\n");
-
 	*result = ioread16(phy->iobase + addr);
 
 	return 0;
@@ -176,9 +167,6 @@ static int tpm_tcg_read32(struct tpm_tis
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
-		WARN(1, "CLKRUN not enabled!\n");
-
 	*result = ioread32(phy->iobase + addr);
 
 	return 0;
@@ -188,9 +176,6 @@ static int tpm_tcg_write32(struct tpm_ti
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
-		WARN(1, "CLKRUN not enabled!\n");
-
 	iowrite32(value, phy->iobase + addr);
 
 	return 0;
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -698,7 +698,6 @@ static void tpm_tis_clkrun_enable(struct
 		return;
 
 	if (value) {
-		data->flags |= TPM_TIS_CLK_ENABLE;
 		data->clkrun_enabled++;
 		if (data->clkrun_enabled > 1)
 			return;
@@ -729,7 +728,6 @@ static void tpm_tis_clkrun_enable(struct
 		 * sure LPC clock is running before sending any TPM command.
 		 */
 		outb(0xCC, 0x80);
-		data->flags &= ~TPM_TIS_CLK_ENABLE;
 	}
 }
 
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -86,7 +86,6 @@ enum tis_defaults {
 
 enum tpm_tis_flags {
 	TPM_TIS_ITPM_WORKAROUND		= BIT(0),
-	TPM_TIS_CLK_ENABLE		= BIT(1),
 };
 
 struct tpm_tis_data {
