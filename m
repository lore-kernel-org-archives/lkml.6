Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224duGAD4kOIN9rcHNKU3wwIeTCT2F4KL4REmPadp4MsF5RXQbInts3IPpi4QZMVw0amC+dF
ARC-Seal: i=1; a=rsa-sha256; t=1518709280; cv=none;
        d=google.com; s=arc-20160816;
        b=CpGHhCNHJkhGouTGUStgjSdxe6qCqA5lq6Gp5htGLez5L3rGtindRdl8D0L5DcWB02
         bC1P55WZAAr+nqh4p0IA/QoolpPD988nX7tdAolAcOOaeLY3THWwQ5KcKWSHcq/JZrDX
         lURAOnQVtQDp3MlUJ0FwuyjcV5h80e2r/wc2JNZ40yev6vdMqtv8eZXJ1CjQ0eV4WUsx
         RNoRJPbD0q9IL2GUdWnzrtCjJB6FpVDrhDta037KTYw4CN1qagSm3lx4C1kqYi4Vm2KX
         zYXUkAs4VhwkE5cPSkYBugc86QldpjTwqobvjhSomK2GAZOZa3BDBjlpnL/jIRZcaa0p
         M8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1H8Ctw8yqhMOUXYNF8Yq4JgW9Fwjea5qvw41CnvRC40=;
        b=muJWgv040N1NzWhXp9lRFdAHlsZbW212wbR2FYH3t/g69Il1np3D4yzBKn6EGXIMlf
         eIvhwMkxxYOJaIQ+Qr4HvQPus1BpYnfiVPCgGWbefnbG+YI8GeZ+Se9I/L28z68GD2CE
         pDGbs7ZlGHQ7PWwlAC6Y0jyZtSucFkjJxlI89bwLNkyAb/r92h5SMOlXpfYDmLUjV8/q
         mcboHaQM/5kbM6tCWbFoNYhqGhPojJZSX9Ne5ScKLYqPQihQDj57on17ORUDCkurUAGN
         g+89ufH/iRl5wXYC6cNNjbAQnd+64aAEhGsaqf1k9dRALq4+P9j7LvgtoM+20hobqpfI
         bWbw==
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
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 062/202] [Variant 2/Spectre-v2] arm64: Move post_ttbr_update_workaround to C code
Date: Thu, 15 Feb 2018 16:16:02 +0100
Message-Id: <20180215151716.632123836@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481554400820898?=
X-GMAIL-MSGID: =?utf-8?q?1592482102766119232?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit 95e3de3590e3 upstream.

We will soon need to invoke a CPU-specific function pointer after changing
page tables, so move post_ttbr_update_workaround out into C code to make
this possible.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Conflicts:
	arch/arm64/include/asm/assembler.h
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/assembler.h |   13 -------------
 arch/arm64/kernel/entry.S          |    2 +-
 arch/arm64/mm/context.c            |    9 +++++++++
 arch/arm64/mm/proc.S               |    3 +--
 4 files changed, 11 insertions(+), 16 deletions(-)

--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -494,19 +494,6 @@ alternative_endif
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
 	.macro	pte_to_phys, phys, pte
 	and	\phys, \pte, #(((1 << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
 	.endm
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -277,7 +277,7 @@ alternative_else_nop_endif
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
@@ -239,6 +239,15 @@ switch_mm_fastpath:
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
