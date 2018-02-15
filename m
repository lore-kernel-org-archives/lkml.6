Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227jzpRCXLQKSHfUBRo513xLhvSASyqWefm0tdw7Wvu3ld/xfjGaZ/PIarN8DpXsFK6KB7v4
ARC-Seal: i=1; a=rsa-sha256; t=1518708681; cv=none;
        d=google.com; s=arc-20160816;
        b=JVSVCp72Kb9Msp12+jGK1ogz0rfb8t5jt0MAKzktfltA7sgFPNOrdm9wuNvXidQ0TT
         wolvr9J/BBhkIa0RhbRVUfCGUYW/tHDTaIJeUgzDrm80pHJVfFNwsIUP7KUOeU3+Moo2
         kUhe+woHS59vF8OnuVKwR2hEenri1QyFn3TYyjvPT2NQc8hANi8B0Gblkpbp6lJFnf2g
         ZTkp6oZALnNaszxpUS4c4+Iriz2jZNe2D/Z1qSDhR6rTz98MeY0RKaegev99oyS6hsFS
         wpew1c1VY5d1zseQ7KHazR7wzKrjPD9DDipsCTYEHj7oMa218RnpvWzDAnS/De/2muu2
         zVsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OX2SsjudRhJxf858DwxcHDBstgqwMu1MfAEzay58Qbs=;
        b=0NsDkFj57D028UNbNzB8XXetVyKzT+61tlmhWvDjPV7jBHOMBwaDK57Fg/vrslslgj
         puAODo8DigR0fSFTNf+2DMEsr/VEEKXtGHiCFkeyScCFZ1le0Gw5h/EUsrMVGX4EOZ69
         AKwKVEJWB5s8dgkSln0hZXGHxvVcNDWw0R9fc1eZGyBinR6cbb6g9QE6jP0/ueQVvJ1b
         wBTBjyYwGcJH8BpnSnKaNXUqqt/CcpxLPuBiIVtUZUbt9s35tClsxPJHQ7jo7T/ltrod
         ZqNM1kR35fQs6BrPdZG4p4RbQE27SLACzwEFckjCNFzRchAYgz6C3TY3NQKowkU9/O+H
         EwSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.14 040/195] [Variant 3/Meltdown] arm64: kaslr: Put kernel vectors address in separate data page
Date: Thu, 15 Feb 2018 16:15:31 +0100
Message-Id: <20180215151707.746979820@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481474736313800?=
X-GMAIL-MSGID: =?utf-8?q?1592481474736313800?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 6c27c4082f4f upstream.

The literal pool entry for identifying the vectors base is the only piece
of information in the trampoline page that identifies the true location
of the kernel.

This patch moves it into a page-aligned region of the .rodata section
and maps this adjacent to the trampoline text via an additional fixmap
entry, which protects against any accidental leakage of the trampoline
contents.

Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/fixmap.h |    1 +
 arch/arm64/kernel/entry.S       |   14 ++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S |    5 ++++-
 arch/arm64/mm/mmu.c             |   10 +++++++++-
 4 files changed, 28 insertions(+), 2 deletions(-)

--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -59,6 +59,7 @@ enum fixed_addresses {
 #endif /* CONFIG_ACPI_APEI_GHES */
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	FIX_ENTRY_TRAMP_DATA,
 	FIX_ENTRY_TRAMP_TEXT,
 #define TRAMP_VALIAS		(__fix_to_virt(FIX_ENTRY_TRAMP_TEXT))
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -982,7 +982,13 @@ alternative_else_nop_endif
 	msr	tpidrro_el0, x30	// Restored in kernel_ventry
 	.endif
 	tramp_map_kernel	x30
+#ifdef CONFIG_RANDOMIZE_BASE
+	adr	x30, tramp_vectors + PAGE_SIZE
+alternative_insn isb, nop, ARM64_WORKAROUND_QCOM_FALKOR_E1003
+	ldr	x30, [x30]
+#else
 	ldr	x30, =vectors
+#endif
 	prfm	plil1strm, [x30, #(1b - tramp_vectors)]
 	msr	vbar_el1, x30
 	add	x30, x30, #(1b - tramp_vectors)
@@ -1025,6 +1031,14 @@ END(tramp_exit_compat)
 
 	.ltorg
 	.popsection				// .entry.tramp.text
+#ifdef CONFIG_RANDOMIZE_BASE
+	.pushsection ".rodata", "a"
+	.align PAGE_SHIFT
+	.globl	__entry_tramp_data_start
+__entry_tramp_data_start:
+	.quad	vectors
+	.popsection				// .rodata
+#endif /* CONFIG_RANDOMIZE_BASE */
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
 /*
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -251,7 +251,10 @@ ASSERT(__idmap_text_end - (__idmap_text_
 ASSERT(__hibernate_exit_text_end - (__hibernate_exit_text_start & ~(SZ_4K - 1))
 	<= SZ_4K, "Hibernate exit text too big or misaligned")
 #endif
-
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+ASSERT((__entry_tramp_text_end - __entry_tramp_text_start) == PAGE_SIZE,
+	"Entry trampoline text too big")
+#endif
 /*
  * If padding is applied before .head.text, virt<->phys conversions will fail.
  */
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -541,8 +541,16 @@ static int __init map_entry_trampoline(v
 	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
 			     prot, pgd_pgtable_alloc, 0);
 
-	/* ...as well as the kernel page table */
+	/* Map both the text and data into the kernel page table */
 	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
+		extern char __entry_tramp_data_start[];
+
+		__set_fixmap(FIX_ENTRY_TRAMP_DATA,
+			     __pa_symbol(__entry_tramp_data_start),
+			     PAGE_KERNEL_RO);
+	}
+
 	return 0;
 }
 core_initcall(map_entry_trampoline);
