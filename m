Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224mdBUClbS7NZ/WBdfkVGOEXZ1NJ2IGmtHP2rxbN55l9UsNcmlsOAFcilXgKLnGyDzhw+Qf
ARC-Seal: i=1; a=rsa-sha256; t=1518709199; cv=none;
        d=google.com; s=arc-20160816;
        b=diKqIY57kelqK9pbHpa7zkX/G9Nv7H6jue8ZIUkn4GdjpKOVGpHgI14n3X1Bf46hWW
         xqvHOOwShora1Dv2QyPqR+Y2XoQ+Ork+Hckp8l5JzoC0LbxUlNFIcC7Yr+Nl4/s7q24q
         CrT6/LikPx17Z9J+rZw3+yUB+TQcdcfr1lQgHUbv/v6tCa5E8AHhU1qJZYTBRZD9eemb
         KG4RemMY3TA9jNNMKCVK2b9QKHw6KK2rVURPbv2RNR2XazutCBdmwSubQYfVK+KWeso2
         zlDvnJtr5PIRACWIOjQyJjPDqdav+84gqi/vfHAV2TCgVIxb4grJpZXWql5ll97VwCOV
         gj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8d48o6B1kQEOtzL61sO/XHYzme+7TUfgnE2OZgtjv3s=;
        b=oV46YftTOnJ1ySCmVRZMv1/srgrAxU53BloilDgTt6WwMImhRsVKiRgVrolKLRyjoq
         romd1z58Amz6EMb+yY/om97l1iCkTXoLiAYzyp34UmIMi+A9CcJ+PiVXJXfmowtoP5Xu
         X5qwtXq848lK9nZkt1jz3iQ0ok/fakTcsXX0TK7DZ4ubMYnI9TphHwSyXE/7mdbuk0ro
         SdLjgcAnzgA2RRPdd+qSEMK57glbXJjmyxeSnWfY3C12lE/puuIFGe5OgkpuR5TpKTse
         mAG5iR2F0ETQ/J6qJ3iP0s5qOdpDVNT57Esrs/s9QSAz3qqpN5jcsFT5s+w9L76UchIk
         lp6g==
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
Subject: [PATCH 4.15 032/202] [Variant 3/Meltdown] arm64: kaslr: Put kernel vectors address in separate data page
Date: Thu, 15 Feb 2018 16:15:32 +0100
Message-Id: <20180215151714.661239569@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481474736313800?=
X-GMAIL-MSGID: =?utf-8?q?1592482018484135858?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1030,7 +1030,13 @@ alternative_else_nop_endif
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
@@ -1073,6 +1079,14 @@ END(tramp_exit_compat)
 
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
