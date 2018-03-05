Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELtXn3cJXCGXRPOGg2xpIKBKMdzqlQSz138MQ2Qh9VoD9RFrcMwAf3u2G9dEdqNDiSsDuCAX
ARC-Seal: i=1; a=rsa-sha256; t=1520245576; cv=none;
        d=google.com; s=arc-20160816;
        b=Q6esvyV331KWEGQAEyHf2wqj0y4bJesO+CvK7m095VU7FSjYBndMToHQeEYHqQB8Jc
         kK7pao+algIi0QcEGEToCFftXVBHgUCYHv3kNLkr+y7bN3vKrYOPwpeIkDFsJl3UYUef
         B6qtRWcvAFy8ymvBUDGQZl+7Otn5/e6++SvPN/5fCzPvTyu6lsOSB4H7s1dRMuwi+XOr
         T3KbGsoBOU6VxSpg07l63xZ71nyF6No9hm04xBYsv9ixgSVkXWRPf13Y/VQFMjeNXECe
         m/QTT7KBMpME1srRITGYLxiTu3ZRNCzK1v4gp64Sxy/e4JULKYdPNgjCTe171xCCUhrx
         IV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=wbV5tAu0wTyAC9OBsjsZxEDpC5ifUQw0rFsnbh3Eu9o=;
        b=SiqUgFn3UZ16qUo61rDfUoAs2G+w+VIIO5ERllJhA1dzRsjIcWukL5mvQmhcimadnq
         hCpNpqyYVqN3s10a9zVdFjiAL0cB91YcoQKJAGY/rQRwU+jJaPhyo3trk3zn8HTtWadh
         sigi6rWz8Z81lyxGtUZPL5PoJe5chZmtrJC8RcP5SVOE1n0ssmu0lAM7UAzv7ZmHFjej
         xyy397d5i+QhF+5vFHGdrVeaHkw7E7Mql9iAQ6uXyuQULHLHiaHDZ7abgdQyofFhYEny
         318PeMNOCqCCQDZtGI9hXonhyFf1e3cnX70Y7Ivvtp4qVHYb0nhQjQG5XWXpu37uNggM
         R1UQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=qVf7Rtk4;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=qVf7Rtk4;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at,
	hughd@google.com,
	keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 14/34] x86/entry/32: Add PTI cr3 switch to non-NMI entry/exit points
Date: Mon,  5 Mar 2018 11:25:43 +0100
Message-Id: <1520245563-8444-15-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093025228329287?=
X-GMAIL-MSGID: =?utf-8?q?1594093025228329287?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Add unconditional cr3 switches between user and kernel cr3
to all non-NMI entry and exit points.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 91 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 35379e5..8f78abc 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -328,6 +328,30 @@
 #endif /* CONFIG_X86_ESPFIX32 */
 .endm
 
+/* Unconditionally switch to user cr3 */
+.macro SWITCH_TO_USER_CR3 scratch_reg:req
+	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
+
+	movl	%cr3, \scratch_reg
+	orl	$PTI_SWITCH_MASK, \scratch_reg
+	movl	\scratch_reg, %cr3
+.Lend_\@:
+.endm
+
+/* Unconditionally switch to kernel cr3 */
+.macro SWITCH_TO_KERNEL_CR3 scratch_reg:req
+	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
+	movl	%cr3, \scratch_reg
+	/* Test if we are already on kernel CR3 */
+	testl	$PTI_SWITCH_MASK, \scratch_reg
+	jz	.Lend_\@
+	andl	$(~PTI_SWITCH_MASK), \scratch_reg
+	movl	\scratch_reg, %cr3
+	/* Return original CR3 in \scratch_reg */
+	orl	$PTI_SWITCH_MASK, \scratch_reg
+.Lend_\@:
+.endm
+
 
 /*
  * Called with pt_regs fully populated and kernel segments loaded,
@@ -341,11 +365,19 @@
  */
 
 #define CS_FROM_ENTRY_STACK	(1 << 31)
+#define CS_FROM_USER_CR3	(1 << 30)
 
 .macro SWITCH_TO_KERNEL_STACK
 
 	ALTERNATIVE     "", "jmp .Lend_\@", X86_FEATURE_XENPV
 
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
+
+	/*
+	 * %eax now contains the entry cr3 and we carry it forward in
+	 * that register for the time this macro runs
+	 */
+
 	/* Are we on the entry stack? Bail out if not! */
 	movl	PER_CPU_VAR(cpu_entry_area), %edi
 	addl	$CPU_ENTRY_AREA_entry_stack, %edi
@@ -408,7 +440,8 @@
 	 * but switch back to the entry-stack again when we approach
 	 * iret and return to the interrupted code-path. This usually
 	 * happens when we hit an exception while restoring user-space
-	 * segment registers on the way back to user-space.
+	 * segment registers on the way back to user-space or when the
+	 * sysenter handler runs with eflags.tf set.
 	 *
 	 * When we switch to the task-stack here, we can't trust the
 	 * contents of the entry-stack anymore, as the exception handler
@@ -425,6 +458,7 @@
 	 *
 	 * %esi: Entry-Stack pointer (same as %esp)
 	 * %edi: Top of the task stack
+	 * %eax: CR3 on kernel entry
 	 */
 
 	/* Calculate number of bytes on the entry stack in %ecx */
@@ -441,6 +475,14 @@
 	orl	$CS_FROM_ENTRY_STACK, PT_CS(%esp)
 
 	/*
+	 * Test the cr3 used to enter the kernel and add a marker
+	 * so that we can switch back to it before iret.
+	 */
+	testl	$PTI_SWITCH_MASK, %eax
+	jz	.Lcopy_pt_regs_\@
+	orl	$CS_FROM_USER_CR3, PT_CS(%esp)
+
+	/*
 	 * %esi and %edi are unchanged, %ecx contains the number of
 	 * bytes to copy. The code at .Lcopy_pt_regs_\@ will allocate
 	 * the stack-frame on task-stack and copy everything over
@@ -506,7 +548,7 @@
 
 /*
  * This macro handles the case when we return to kernel-mode on the iret
- * path and have to switch back to the entry stack.
+ * path and have to switch back to the entry stack and/or user-cr3
  *
  * See the comments below the .Lentry_from_kernel_\@ label in the
  * SWITCH_TO_KERNEL_STACK macro for more details.
@@ -552,6 +594,18 @@
 	/* Safe to switch to entry-stack now */
 	movl	%ebx, %esp
 
+	/*
+	 * We came from entry-stack and need to check if we also need to
+	 * switch back to user cr3.
+	 */
+	testl	$CS_FROM_USER_CR3, PT_CS(%esp)
+	jz	.Lend_\@
+
+	/* Clear marker from stack-frame */
+	andl	$(~CS_FROM_USER_CR3), PT_CS(%esp)
+
+	SWITCH_TO_USER_CR3 scratch_reg=%eax
+
 .Lend_\@:
 .endm
 /*
@@ -746,6 +800,18 @@ ENTRY(xen_sysenter_target)
  * 0(%ebp) arg6
  */
 ENTRY(entry_SYSENTER_32)
+	/*
+	 * On entry-stack with all userspace-regs live - save and
+	 * restore eflags and %eax to use it as scratch-reg for the cr3
+	 * switch.
+	 */
+	pushfl
+	pushl	%eax
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
+	popl	%eax
+	popfl
+
+	/* Stack empty again, switch to task stack */
 	movl	TSS_entry_stack(%esp), %esp
 
 .Lsysenter_past_esp:
@@ -826,6 +892,9 @@ ENTRY(entry_SYSENTER_32)
 	/* Switch to entry stack */
 	movl	%eax, %esp
 
+	/* Now ready to switch the cr3 */
+	SWITCH_TO_USER_CR3 scratch_reg=%eax
+
 	/*
 	 * Restore all flags except IF. (We restore IF separately because
 	 * STI gives a one-instruction window in which we won't be interrupted,
@@ -906,7 +975,23 @@ restore_all:
 .Lrestore_all_notrace:
 	CHECK_AND_APPLY_ESPFIX
 .Lrestore_nocheck:
-	RESTORE_REGS 4				# skip orig_eax/error_code
+	/*
+	 * First restore user segments. This can cause exceptions, so we
+	 * run it with kernel cr3.
+	 */
+	RESTORE_SEGMENTS
+
+	/*
+	 * Segments are restored - no more exceptions from here on except on
+	 * iret, but that handled safely.
+	 */
+	SWITCH_TO_USER_CR3 scratch_reg=%eax
+
+	/* Restore rest */
+	RESTORE_INT_REGS
+
+	/* Unwind stack to the iret frame */
+	RESTORE_SKIP_SEGMENTS 4			# skip orig_eax/error_code
 .Lirq_return:
 	INTERRUPT_RETURN
 
-- 
2.7.4
