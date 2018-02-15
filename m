Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225SboU1wEfCkDnH6+1fY2E2rBW10EOBPeFrYKNkdECCKPRZR8LhpiiGOht30WYmjGLWpFIB
ARC-Seal: i=1; a=rsa-sha256; t=1518708757; cv=none;
        d=google.com; s=arc-20160816;
        b=fTi/rVYkCKyuTGQphy2jMb6gYsNGzvRt60Y7l5lII7CDTUb3IJFT8vXWolENJ2M9M7
         KrvhxD9CqhbCzXBUCDKNW2MgjXOLKSg6GkzyBBRU4YtVBMlcz5WBFedaM9DcbWukAmgB
         xbYd4LLP+fKxiWC/NP26izG5fgR8e0SWKtLxxJUF0VO1qraSEDNLYHcYm1ZlTS9S/kOq
         ow+4xUP37nKo1ksgcex/NCKX4Er1V/5y6nGW1e9WchruZSgCSKLeaxRnyK1HlPP1Ke7v
         TKCkYztb7w5HAJslvr02MCrzffskqbj01AIurpTvVq9FKPMgj19aNASiT1U+WtcuUO9z
         icgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SZMHYkhOEyQ6kUwX7CSkH1jZP9P5OA4YJHyPqocepWI=;
        b=GNSS+03x6slxsAaZ+MMDwdxdtztTJYbH3iUoAVn9dBeRXQ1zrMvVTK5fdCT1erxjzx
         BK7FFdH/Ua1LBNV+9zgTfzU2sJ3UMwQpp1MrT5zq/RUPJ/Riis6gKe0ZH2/za5WnmkIj
         K50YpxC1qRvy6CmZ3+QKILngUqbWSBB6TJZ8B/1MsdEUcVATWiEpHwyo9QAHbMR0hoaL
         /xRbBopE+6GlVNGwICOYSxEGgAocB5SlIQV4HbOPcR0QfIvJp6Gl7xnqqXRhGi/GV7/2
         s978QAEnyZgm8sRUG0KMhB12puYqX5QzUUJSWVQJgQ9MoM8lsoJe5aqwszoV9qIEwUng
         eOjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 069/195] [Variant 2/Spectre-v2] arm64: Move post_ttbr_update_workaround to C code
Date: Thu, 15 Feb 2018 16:16:00 +0100
Message-Id: <20180215151709.160256379@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481554400820898?=
X-GMAIL-MSGID: =?utf-8?q?1592481554400820898?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

Commit 95e3de3590e3 upstream.

We will soon need to invoke a CPU-specific function pointer after changing
page tables, so move post_ttbr_update_workaround out into C code to make
this possible.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/assembler.h |   13 -------------
 arch/arm64/kernel/entry.S          |    2 +-
 arch/arm64/mm/context.c            |    9 +++++++++
 arch/arm64/mm/proc.S               |    3 +--
 4 files changed, 11 insertions(+), 16 deletions(-)

--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -481,19 +481,6 @@ alternative_endif
 	mrs	\rd, sp_el0
 	.endm
 
-/*
- * Errata workaround post TTBRx_EL1 update.
- */
-	.macro	post_ttbr_update_workaround
-#ifdef CONFIG_CAVIUM_ERRATUM_27456
-alternative_if ARM64_WORKAROUND_CAVIUM_27456
-	ic	iallu
-	dsb	nsh
-	isb
-alternative_else_nop_endif
-#endif
-	.endm
-
 /**
  * Errata workaround prior to disable MMU. Insert an ISB immediately prior
  * to executing the MSR that will change SCTLR_ELn[M] from a value of 1 to 0.
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -275,7 +275,7 @@ alternative_else_nop_endif
 	 * Cavium erratum 27456 (broadcast TLBI instructions may cause I-cache
 	 * corruption).
 	 */
-	post_ttbr_update_workaround
+	bl	post_ttbr_update_workaround
 	.endif
 1:
 	.if	\el != 0
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -235,6 +235,15 @@ switch_mm_fastpath:
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
@@ -148,8 +148,7 @@ ENTRY(cpu_do_switch_mm)
 	isb
 	msr	ttbr0_el1, x0			// now update TTBR0
 	isb
-	post_ttbr_update_workaround
-	ret
+	b	post_ttbr_update_workaround	// Back to C code...
 ENDPROC(cpu_do_switch_mm)
 
 	.pushsection ".idmap.text", "awx"
