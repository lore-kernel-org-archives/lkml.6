Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49g3GBYDe4+hvkWxg0oZ9yZkZn4x5UsIo1iSk5KafDopxyNBEBli+rqI4Yr3iuQzdEZV48a
ARC-Seal: i=1; a=rsa-sha256; t=1523021715; cv=none;
        d=google.com; s=arc-20160816;
        b=XCMi1YjzaIindGdKgVqd2/+taSolwHUUnC5q8dOZ4eD0m5VD9Ey40bH01DCQNemZ8n
         1f6cxmPtg83SEQNJg1O/tDHHXah3Hv+ocxHPCp+9jIKL3l5ucGuxh9ITVXxw094+dE9a
         qgo/+glb/tYZk6AMFzzhuML1AzpS/jzKs22PqBDmvpmtS/4mLJT2zcr2G84XuEqiV6MM
         V73qDzMbR+bH3ggfSwMfgvSB1D0KqIaxSrcfCNeVpCSyug6Xvc8DtOKmzXdHKeHHxtAm
         BQFLF1DVexRF7iH+gbiWsKArLlQXMOUiK/pQ2RCH5o2iAgoTwpUb3djXClXqygUkVpRo
         Snjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lSraJohI5wQCRbV8LH1JtziLZXV40zo7Oh87UdoqmDc=;
        b=XhsNT6KmRkb6KRlvSDrqUljttoiWeGKhL5+KpmAVX0CNXIqVV3r7Zhq9ZMUEeGzdH2
         PF3T8BQpAmMr4OJzwk+9IhivZp12Oycc4pRlVke0SIDO5rVPLH+Wl2Mfr31G+2wlvXom
         ztazKe1Yk6tceP7/CzTSzaOlqFNNDjnfHgLnhOXfBlh6j1oMznkGgOV95HEgl8UjP2Py
         rRS7o+hwYBDiC7tNZOLbJkqMNgE8HELMlFhPSyls2fiPpkjUCAX8U0opY1R9jG3/iyZp
         nibY7UGDVADmmeU7jixa5wYmAnbNs4WlgDQkMtiEpouhNeJcK9S5hueqQgquxhV50Jm8
         T48g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Alex Shi <alex.shi@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 063/102] arm64: kaslr: Put kernel vectors address in separate data page
Date: Fri,  6 Apr 2018 15:23:44 +0200
Message-Id: <20180406084340.398994234@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004018372044681?=
X-GMAIL-MSGID: =?utf-8?q?1597004018372044681?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 6c27c4082f4f upstream.

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
[Alex: avoid ARM64_WORKAROUND_QCOM_FALKOR_E1003 dependency]
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/fixmap.h |    1 +
 arch/arm64/kernel/entry.S       |   14 ++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S |    5 ++++-
 arch/arm64/mm/mmu.c             |   10 +++++++++-
 4 files changed, 28 insertions(+), 2 deletions(-)

--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -53,6 +53,7 @@ enum fixed_addresses {
 	FIX_TEXT_POKE0,
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	FIX_ENTRY_TRAMP_DATA,
 	FIX_ENTRY_TRAMP_TEXT,
 #define TRAMP_VALIAS		(__fix_to_virt(FIX_ENTRY_TRAMP_TEXT))
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -881,7 +881,13 @@ __ni_sys_trace:
 	msr	tpidrro_el0, x30	// Restored in kernel_ventry
 	.endif
 	tramp_map_kernel	x30
+#ifdef CONFIG_RANDOMIZE_BASE
+	adr	x30, tramp_vectors + PAGE_SIZE
+	isb
+	ldr	x30, [x30]
+#else
 	ldr	x30, =vectors
+#endif
 	prfm	plil1strm, [x30, #(1b - tramp_vectors)]
 	msr	vbar_el1, x30
 	add	x30, x30, #(1b - tramp_vectors)
@@ -924,6 +930,14 @@ END(tramp_exit_compat)
 
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
@@ -252,7 +252,10 @@ ASSERT(__idmap_text_end - (__idmap_text_
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
@@ -435,8 +435,16 @@ static int __init map_entry_trampoline(v
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
