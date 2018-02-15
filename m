Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226AL2UM31XVNzuVEGWCQKVpNfygLP8Zq8cWEjkPMnlhG0PufsPOHKfukYEQJijhkXC8K53v
ARC-Seal: i=1; a=rsa-sha256; t=1518708657; cv=none;
        d=google.com; s=arc-20160816;
        b=DesW+ZnW5AQQagciRWHMoagl1zW+UtsCBf24CgsIiPmwNpQK1d6Td2mNiGYV4rVaiT
         9sLUDPg6SLolG0hdOnJhlg0Igvz1LOsN/o2sFdmFkuwktDteH1XI+3okHvXhyJpvgCiy
         n377MrIaipWewxMojswBiOULzlQqm7KM0rsjG0B8xkBk7Ap0IJ97xjA444ijNSwRoK/I
         JQn8GodowTbi0rg9vARWGTAMWzR1d7qeXPzyGTZnC+lRwcwi2GqrytEbeT4niWpqhcPT
         tzZsIB4wKnvl3OBHA8wQ1vS1STz8zXLrgCU5InPAKski8fVvPYMwDlIP5ooBUaSc/JQx
         TIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fQvbOhBTTy1zizpIStpbJWXhWBWszhD7Qy9aJbkDMUg=;
        b=rqpgf+idNV4HFkR0Gy30M+PkNjMuedvWSQIACMzPIWxavzj3L1kcZWb8XU4WMrHbJG
         TzhnopIxbZXZbcPbiz85uUD6xmwm8WPfc6BZOeade1hjnuh1NAnbEwFcOsmSoKDcayUg
         iV8JZqB9YY1NUWehnKWypXOqAJNEKE4ADSloDK9db/X/8Nq000hF/li5WTwCLwZkWdPV
         nJaJ8dkMnpvk5LyrlhR/Xw6Xp4M+fsXuk/9gdCCOhgF29aGGRfR+3ZKUlXYSMcC9vDB4
         dMbH1UIKiwJVO6xfFbtL5r5sAHHUIDM3LeoaLznwZHm4P5MsD0JDtMh3WVPz6w+LCble
         Y/NA==
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
Subject: [PATCH 4.14 032/195] [Variant 3/Meltdown] arm64: entry: Add exception trampoline page for exceptions from EL0
Date: Thu, 15 Feb 2018 16:15:23 +0100
Message-Id: <20180215151707.361762437@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481449504188985?=
X-GMAIL-MSGID: =?utf-8?q?1592481449504188985?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit c7b9adaf85f8 upstream.

To allow unmapping of the kernel whilst running at EL0, we need to
point the exception vectors at an entry trampoline that can map/unmap
the kernel on entry/exit respectively.

This patch adds the trampoline page, although it is not yet plugged
into the vector table and is therefore unused.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S       |   86 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S |   17 +++++++
 2 files changed, 103 insertions(+)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -28,6 +28,8 @@
 #include <asm/errno.h>
 #include <asm/esr.h>
 #include <asm/irq.h>
+#include <asm/memory.h>
+#include <asm/mmu.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
@@ -895,6 +897,90 @@ __ni_sys_trace:
 
 	.popsection				// .entry.text
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+/*
+ * Exception vectors trampoline.
+ */
+	.pushsection ".entry.tramp.text", "ax"
+
+	.macro tramp_map_kernel, tmp
+	mrs	\tmp, ttbr1_el1
+	sub	\tmp, \tmp, #(SWAPPER_DIR_SIZE + RESERVED_TTBR0_SIZE)
+	bic	\tmp, \tmp, #USER_ASID_FLAG
+	msr	ttbr1_el1, \tmp
+	.endm
+
+	.macro tramp_unmap_kernel, tmp
+	mrs	\tmp, ttbr1_el1
+	add	\tmp, \tmp, #(SWAPPER_DIR_SIZE + RESERVED_TTBR0_SIZE)
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
@@ -57,6 +57,17 @@ jiffies = jiffies_64;
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
@@ -113,6 +124,7 @@ SECTIONS
 			HYPERVISOR_TEXT
 			IDMAP_TEXT
 			HIBERNATE_TEXT
+			TRAMP_TEXT
 			*(.fixup)
 			*(.gnu.warning)
 		. = ALIGN(16);
@@ -214,6 +226,11 @@ SECTIONS
 	. += RESERVED_TTBR0_SIZE;
 #endif
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	tramp_pg_dir = .;
+	. += PAGE_SIZE;
+#endif
+
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
 	_end = .;
 
