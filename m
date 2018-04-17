Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48it7Nuyc7p7T+HWN+fubZn+lfSNPspu7NNLbYfUB6hGjzd25WYnO0iNaFI3srZYAqQjjRt
ARC-Seal: i=1; a=rsa-sha256; t=1523981327; cv=none;
        d=google.com; s=arc-20160816;
        b=K+VVYK0YJFYxSbUKMZYiEJ/OwAQrPdsn3PNo2IldkPTs2dv/KmLe7ZzxIcH1QBlnUz
         ovvlJhn+iJ/qbL2HYrdh2dOD3FX72u7U9TkdHp0FFk/CZKlyW6pDI1ncYIMRXq/g5EFb
         sfH+9yVzA8dRoV0nGB4nMKhtEKg3CnjE/vsDUWVCXMUaKtHyALiZcVBNJXIh9TG+jIC+
         WSaiSzjAlfsE0wktw20UPX0dbz7tGXcvEJuhqYRdYlnOPM4LRllFoE7wxHbCKSxrUyH8
         R7jIm/xWSeJ7Py2yVnYS46ZisYP5rUZ1p505PPbzEEvjlCsTvBrDc/mdhAM96xb1RbAW
         d/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7433tfIY7Y5zXE1TxFiDM/H36Ifmi4qHyVER1fI7Ihw=;
        b=hQQ8SgdCj/Ll++S0gvJ6ulYvbfi6aupnd1ATV2Re3A2AdAJiraH/QYu1ZDfAydBtCA
         xP6QKgeq0w98NAmoSfj66hqSE57LoryW/r6pAJB39BBpDbv8R1F9eQR4ms4JmWKXgIyt
         eVFqYjSIdcLZWBAUEFxf31SHIBbHrDRpOnr1SM+pKdCNXq67435C2m7hAnW+9AltcqDN
         VAgwyeUbomY0CcDIgdOuR3+IS/jcu+G0n120Ou9TdKRSBLMb674JSD1Ck9eCRCkS25l5
         dgzqRqCTyklBkKghOQcryp46TXXvhs71XMJyJfvWpG6Lc1ZexNfHsol4+QXcMaxDbbET
         c74g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 24/66] arm64: Move post_ttbr_update_workaround to C code
Date: Tue, 17 Apr 2018 17:58:57 +0200
Message-Id: <20180417155646.903350204@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010244517411315?=
X-GMAIL-MSGID: =?utf-8?q?1598010244517411315?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Marc Zyngier <marc.zyngier@arm.com>

commit 95e3de3590e3f2358bb13f013911bc1bfa5d3f53 upstream.

We will soon need to invoke a CPU-specific function pointer after changing
page tables, so move post_ttbr_update_workaround out into C code to make
this possible.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/assembler.h |   13 -------------
 arch/arm64/mm/context.c            |    9 +++++++++
 arch/arm64/mm/proc.S               |    3 +--
 3 files changed, 10 insertions(+), 15 deletions(-)

--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -435,17 +435,4 @@ alternative_endif
 	and	\phys, \pte, #(((1 << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
 	.endm
 
-/*
- * Errata workaround post TTBR0_EL1 update.
- */
-	.macro	post_ttbr0_update_workaround
-#ifdef CONFIG_CAVIUM_ERRATUM_27456
-alternative_if ARM64_WORKAROUND_CAVIUM_27456
-	ic	iallu
-	dsb	nsh
-	isb
-alternative_else_nop_endif
-#endif
-	.endm
-
 #endif	/* __ASM_ASSEMBLER_H */
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -233,6 +233,15 @@ switch_mm_fastpath:
 	cpu_switch_mm(mm->pgd, mm);
 }
 
+/* Errata workaround post TTBRx_EL1 update. */
+asmlinkage void post_ttbr_update_workaround(void)
+{
+	asm(ALTERNATIVE("nop; nop; nop",
+			"ic iallu; dsb nsh; isb",
+			ARM64_WORKAROUND_CAVIUM_27456,
+			CONFIG_CAVIUM_ERRATUM_27456));
+}
+
 static int asids_init(void)
 {
 	asid_bits = get_cpu_asid_bits();
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -139,8 +139,7 @@ ENTRY(cpu_do_switch_mm)
 	isb
 	msr	ttbr0_el1, x0			// now update TTBR0
 	isb
-	post_ttbr0_update_workaround
-	ret
+	b	post_ttbr_update_workaround	// Back to C code...
 ENDPROC(cpu_do_switch_mm)
 
 	.pushsection ".idmap.text", "awx"
