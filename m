Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225K+APs8FqZCmrc8nTV/96+Cqj4rNe/a49li7ONva30+LcJLjaCvmKt4ToUBZNU37xjTy29
ARC-Seal: i=1; a=rsa-sha256; t=1518708644; cv=none;
        d=google.com; s=arc-20160816;
        b=rifkdnKuA7pvJvin1Lf2OboUfVZ5wBMhQD9L9LJTdeE0kJDNRhE7Ky+VilMu0k8XDu
         qn7IPiEPLYuKxPgk1QCQF2vgf1GIlqu9YAeEyyyAox1BoJmxa+bDeH1/Yzp2vC8moIng
         rvxdXOX+EUJiy97N6DY+L551fW8tIFn3+s8TDylLHfVLc8dmD8j1h6VlxHvfuuTGAP1R
         U23d0JFbu8UXaVqQ2l86eOBzxo8C6fKiGhrnOPsnEEgna3jM1TDbzInx8Kc3nsecEWM2
         jK8NXY5K6sDoUkF1SiHeJ35kUmeXIeAdYYzHCpbAh7J8ZJDE0WoIBH7oybbA9J+vLgEX
         lS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YF9/rmOsdMn9gqivdLIMl2ScPRUjD2OIu4OtpuC5JQk=;
        b=gD5W1T4PVKV+c5eT84CB6qkoAugo4Vgo51F7KQaKInj+9+6Ce1zQCDsTcysK2fIo2L
         srRzDXJc/JQHf3jBKigg8Zeu+cWxcVq8jK6B7IiKzJkfQvQ8kWmgrU856S4M7zimOAri
         /1WdDzS5pJLrtysNhQOE2Dvklwn3j7Icrdj7rV7SaY11ynh/1v74v6TPpsBFPh8uvcDv
         1K62yVKejKSvo5ga8k32jYcGdvT/j38/pt67fGJfN/iI84aaXNBHA47yEMOkV6aLjIS9
         g19nJyXbS9KRdol8P96JpuB9oSN23zVYZGecGuwj/GcZyjyWjxtk9P2HwRLxvGsYIkmA
         5aNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 027/195] [Variant 3/Meltdown] arm64: mm: Rename post_ttbr0_update_workaround
Date: Thu, 15 Feb 2018 16:15:18 +0100
Message-Id: <20180215151707.113537608@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481435099962033?=
X-GMAIL-MSGID: =?utf-8?q?1592481435099962033?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 158d495899ce upstream.

The post_ttbr0_update_workaround hook applies to any change to TTBRx_EL1.
Since we're using TTBR1 for the ASID, rename the hook to make it clearer
as to what it's doing.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/assembler.h |    5 ++---
 arch/arm64/kernel/entry.S          |    2 +-
 arch/arm64/mm/proc.S               |    2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -464,10 +464,9 @@ alternative_endif
 	.endm
 
 /*
-/*
- * Errata workaround post TTBR0_EL1 update.
+ * Errata workaround post TTBRx_EL1 update.
  */
-	.macro	post_ttbr0_update_workaround
+	.macro	post_ttbr_update_workaround
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
 alternative_if ARM64_WORKAROUND_CAVIUM_27456
 	ic	iallu
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -255,7 +255,7 @@ alternative_else_nop_endif
 	 * Cavium erratum 27456 (broadcast TLBI instructions may cause I-cache
 	 * corruption).
 	 */
-	post_ttbr0_update_workaround
+	post_ttbr_update_workaround
 	.endif
 1:
 	.if	\el != 0
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -145,7 +145,7 @@ ENTRY(cpu_do_switch_mm)
 	isb
 	msr	ttbr0_el1, x0			// now update TTBR0
 	isb
-	post_ttbr0_update_workaround
+	post_ttbr_update_workaround
 	ret
 ENDPROC(cpu_do_switch_mm)
 
