Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv8aplzw1PKUCU2hIxX3UUtD3ysx/q2kKFdXgzAcFrKGrLkIAwWcxv5pYpXHLVWQtjhoMxx
ARC-Seal: i=1; a=rsa-sha256; t=1520955193; cv=none;
        d=google.com; s=arc-20160816;
        b=Ku4W9ZEyX1C8Ae4X2RGsKmh00N18Y55mJvMEF4Yhn2LMhl4sm90jHvDOLOzelsLwwn
         RSnVjdZWtoEoSDBPICEbdTeTnz66tXRmn+uCyc42WVlZBgkgMlF17siHM8Eq7JxJGXo3
         wmtXKtpDDXYVt4W7z0aPS0ilhVLTP6Bz5BVLM9D/26DsQ48W7unFmbr9tGwljY5UfJFS
         SD7LXvlUT8dmVzb4y/jpjLg/FHppnppjrS5BELd+SfEXfTPSlTCHGc9C7W56rfUkdlDf
         V3ZFrYboZoXHj0XZf/g6Q7cAwSaJ4KRRmkVMcsDSx1kEfiVATGo82MpaDFBngXqqQeQv
         e9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e3c7R1BQBtGv10IZfCFrK3uyUEwSU0DTnEOFYwDr/BU=;
        b=oR0ao29AYLoKBskn588IA/tS/t026Op8piWSOvRefPzreLzxY9Vz12fweJlTyIs2Rm
         5861f8+hDQ6shTrZgR77w/Ji1eXk7JXr5qi+TzTeMb3I1mS4U5R5oGa7wLK4o+LGuYMI
         iMhHu6WvjKbw5BlpkNxNQLveolS3SmTornKKEOLwp/5lI4UoBlMfuBcqlajA1q+IHOUR
         iIYIAVMsK1aTsRVqYI3TkgazcoJ/ESi9G3l79OMKNEnuc6cg0Q374ELvwnzDSn49dlAW
         JrqMvbagEilQNoQHT+CKeCoVXehHH50nrRgolChOoZeWnt9rXYIqnrnruJKhm8Jdjml2
         xQ7Q==
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
Subject: [PATCH 4.15 120/146] tpm: delete the TPM_TIS_CLK_ENABLE flag
Date: Tue, 13 Mar 2018 16:24:47 +0100
Message-Id: <20180313152329.551210976@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837112829519145?=
X-GMAIL-MSGID: =?utf-8?q?1594837112829519145?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -138,9 +138,6 @@ static int tpm_tcg_read_bytes(struct tpm
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
-		WARN(1, "CLKRUN not enabled!\n");
-
 	while (len--)
 		*result++ = ioread8(phy->iobase + addr);
 
@@ -152,9 +149,6 @@ static int tpm_tcg_write_bytes(struct tp
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
-		WARN(1, "CLKRUN not enabled!\n");
-
 	while (len--)
 		iowrite8(*value++, phy->iobase + addr);
 
@@ -165,9 +159,6 @@ static int tpm_tcg_read16(struct tpm_tis
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
-		WARN(1, "CLKRUN not enabled!\n");
-
 	*result = ioread16(phy->iobase + addr);
 
 	return 0;
@@ -177,9 +168,6 @@ static int tpm_tcg_read32(struct tpm_tis
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
-		WARN(1, "CLKRUN not enabled!\n");
-
 	*result = ioread32(phy->iobase + addr);
 
 	return 0;
@@ -189,9 +177,6 @@ static int tpm_tcg_write32(struct tpm_ti
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
