Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48pl3AFsWFaHrcsUEzAf395Ax9hJZP71qelLlA/t7i9xnjB2jd2M/QEaCrIaMcz7a7/N6/8
ARC-Seal: i=1; a=rsa-sha256; t=1523021695; cv=none;
        d=google.com; s=arc-20160816;
        b=oLRNhdHjyq4dVAR92VIV7TJ/6BzcLxrwbDUjnR2LLkeRptPubi+1CingvQG5e2EB74
         /r2l9reZu3cuavMTGI0eFFbP+OSU/Oos2xfbaitqHSKRM/8Ag1cGcd3dKWOq1AeFGcIU
         CsVKqgSwZW+SHUX31vKlBNBIfPlRLaPF2XhzWXnaw8ENSxf3Pn6IQbU1mUdmbbIR+3Ps
         MA0+2ZGCCcgwh1s/h5+RsREFjjRm+6lnb9nz+PxJloI1QtCpr8WIGJ23H2LasEpoJ7UY
         PUlYuuRjnef4D+NTZtzmkSQq0FduTxZRYz1jlZFMhWMOCdcV2IRWNKES34C3cqpew2jV
         JJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qhVsLXoSJ0ABwSv9uwVXIxEEEqRGpYC7+GLcDG57cSg=;
        b=RGvg/hv/G/Ngr04GTI8ED8okVFT6eDfkNhsnOLYTP3+wQYhwdoyEDLrv+mwO+6vNjx
         T/IYFsufpiImFp7QqFX43G4ZZQ9bt6WMbebNdr79zXXBFTIKECRS0vn7N/sTmrvY/vGP
         TAX9USfVFZlfKFwPrh+ByqRd+vxnm1A8Qqx7SJohdXji4Pu+KI/voWraiMyF49MIhgKN
         +DTnw/uypzH0Cza/GHU60fyJNwL15l0m/adOk6DK52JmMt2JWTtaT358rB/50gtv198j
         JjZQZR1TlaLIWZuMEWDQQdgdcmeDhHiYHQ4pWS2JsvACdMUyR1xvQwz/VRwchIAfXxdK
         s1ZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 4.9 057/102] arm64: entry: Add exception trampoline page for exceptions from EL0
Date: Fri,  6 Apr 2018 15:23:38 +0200
Message-Id: <20180406084339.657969938@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003997399302878?=
X-GMAIL-MSGID: =?utf-8?q?1597003997399302878?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit c7b9adaf85f8 upstream.

To allow unmapping of the kernel whilst running at EL0, we need to
point the exception vectors at an entry trampoline that can map/unmap
the kernel on entry/exit respectively.

This patch adds the trampoline page, although it is not yet plugged
into the vector table and is therefore unused.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
[Alex: avoid dependency on SW PAN patches]
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
[Mark: remove dummy SW PAN definitions]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S       |   86 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S |   17 +++++++
 2 files changed, 103 insertions(+)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -29,9 +29,11 @@
 #include <asm/esr.h>
 #include <asm/irq.h>
 #include <asm/memory.h>
+#include <asm/mmu.h>
 #include <asm/thread_info.h>
 #include <asm/asm-uaccess.h>
 #include <asm/unistd.h>
+#include <asm/kernel-pgtable.h>
 
 /*
  * Context tracking subsystem.  Used to instrument transitions
@@ -806,6 +808,90 @@ __ni_sys_trace:
 
 	.popsection				// .entry.text
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+/*
+ * Exception vectors trampoline.
+ */
+	.pushsection ".entry.tramp.text", "ax"
+
+	.macro tramp_map_kernel, tmp
+	mrs	\tmp, ttbr1_el1
+	sub	\tmp, \tmp, #SWAPPER_DIR_SIZE
+	bic	\tmp, \tmp, #USER_ASID_FLAG
+	msr	ttbr1_el1, \tmp
+	.endm
+
+	.macro tramp_unmap_kernel, tmp
+	mrs	\tmp, ttbr1_el1
+	add	\tmp, \tmp, #SWAPPER_DIR_SIZE
+	orr	\tmp, \tmp, #USER_ASID_FLAG
+	msr	ttbr1_el1, \tmp
+	/*
+	 * We avoid running the post_ttbr_update_workaround here because the
+	 * user and kernel ASIDs don't have conflicting mappings, so any
+	 * "blessing" as described in:
+	 *
+	 *   http://lkml.kernel.org/r/56BB848A.6060603@caviumnetworks.com
+	 *
+	 * will not hurt correctness. Whilst this may partially defeat the
+	 * point of using split ASIDs in the first place, it avoids
+	 * the hit of invalidating the entire I-cache on every return to
+	 * userspace.
+	 */
+	.endm
+
+	.macro tramp_ventry, regsize = 64
+	.align	7
+1:
+	.if	\regsize == 64
+	msr	tpidrro_el0, x30	// Restored in kernel_ventry
+	.endif
+	tramp_map_kernel	x30
+	ldr	x30, =vectors
+	prfm	plil1strm, [x30, #(1b - tramp_vectors)]
+	msr	vbar_el1, x30
+	add	x30, x30, #(1b - tramp_vectors)
+	isb
+	br	x30
+	.endm
+
+	.macro tramp_exit, regsize = 64
+	adr	x30, tramp_vectors
+	msr	vbar_el1, x30
+	tramp_unmap_kernel	x30
+	.if	\regsize == 64
+	mrs	x30, far_el1
+	.endif
+	eret
+	.endm
+
+	.align	11
+ENTRY(tramp_vectors)
+	.space	0x400
+
+	tramp_ventry
+	tramp_ventry
+	tramp_ventry
+	tramp_ventry
+
+	tramp_ventry	32
+	tramp_ventry	32
+	tramp_ventry	32
+	tramp_ventry	32
+END(tramp_vectors)
+
+ENTRY(tramp_exit_native)
+	tramp_exit
+END(tramp_exit_native)
+
+ENTRY(tramp_exit_compat)
+	tramp_exit	32
+END(tramp_exit_compat)
+
+	.ltorg
+	.popsection				// .entry.tramp.text
+#endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
+
 /*
  * Special system call wrappers.
  */
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -56,6 +56,17 @@ jiffies = jiffies_64;
 #define HIBERNATE_TEXT
 #endif
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+#define TRAMP_TEXT					\
+	. = ALIGN(PAGE_SIZE);				\
+	VMLINUX_SYMBOL(__entry_tramp_text_start) = .;	\
+	*(.entry.tramp.text)				\
+	. = ALIGN(PAGE_SIZE);				\
+	VMLINUX_SYMBOL(__entry_tramp_text_end) = .;
+#else
+#define TRAMP_TEXT
+#endif
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from stext to _edata, must be a round multiple of the PE/COFF
@@ -128,6 +139,7 @@ SECTIONS
 			HYPERVISOR_TEXT
 			IDMAP_TEXT
 			HIBERNATE_TEXT
+			TRAMP_TEXT
 			*(.fixup)
 			*(.gnu.warning)
 		. = ALIGN(16);
@@ -216,6 +228,11 @@ SECTIONS
 	swapper_pg_dir = .;
 	. += SWAPPER_DIR_SIZE;
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	tramp_pg_dir = .;
+	. += PAGE_SIZE;
+#endif
+
 	_end = .;
 
 	STABS_DEBUG
