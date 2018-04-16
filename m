Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx49aeAib7ZxKFqGuRTxXPX/ARc3R+UNDtBW7QkSgr1SHqCWV6pMp0pX/14VfLCA/SBrmeFFG
ARC-Seal: i=1; a=rsa-sha256; t=1523892345; cv=none;
        d=google.com; s=arc-20160816;
        b=VUwIpBfiABisMcEVXtbhBhNAKhR9zR3pCp8T464mF42Rbdm91kQn7rc511ifVQnHX0
         +LXwcEjsibu0jPdI4IYUb9O8N0n744JCuqK+xIrLYP8OdO40087MS8FjzEnkXwKA22IK
         vbwni26lGy/xr893wDV2JHDq4tth1UzO/YiyEnU/4ryL60MxhK2cfAnW6ShFP5nhi1dw
         YmAYvIzDiKmJqembVUvEQy3p4+KWFGJHV2tn6IJe2plAVq8UmirCnYcp8ZW7+Bf4Gk48
         oU42taF1WkhLikEKe+Aq0eN3el352TcziA9fAKNrCCFsVq3llgVcdjO0NK2ITb+21mYi
         Pm0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=5MAYDMDeYiDxuXE5s4LEJcEc5BqHNOgZCeQPhRYBVSk=;
        b=L4vVnSiv86Q07djij8aSpCEdCDu4qvcSgE9RrF4I5wWLrsAp99sPMxggqCSC/qD1s7
         fbJ+C3do0Hc1dFpKLebbpEaVdBiX6eWGIxu2GJRLQwtlzDkGfw4FxY/V60y6D1pOcaaM
         xCHEJF70JpaZmQD4sFXLuUC5q2OLw9s5jvbTz4SdRtJC+qaegpZauWQ3Td4C8MSgLIaH
         nkYC2UCp9fPMt6+kUmkmjlFmUQPAxyroCKzbb5GYQDutsLsne+0GWmdGsmU+lYlgObx1
         /aN76C+NTCxdFTvbJ8jFGAN7R9zw7AzCTU7jtHshIBX0WnUhGLdDq9QY8UkJY1Iu6S3H
         CFSg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=fqoYvgX0;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=fqoYvgX0;
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
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 13/35] x86/entry/32: Add PTI cr3 switch to non-NMI entry/exit points
Date: Mon, 16 Apr 2018 17:25:01 +0200
Message-Id: <1523892323-14741-14-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916940276077246?=
X-GMAIL-MSGID: =?utf-8?q?1597916940276077246?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Add unconditional cr3 switches between user and kernel cr3
to all non-NMI entry and exit points.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 83 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 71e1cb3..b2b0ecb 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -154,6 +154,33 @@
 
 #endif /* CONFIG_X86_32_LAZY_GS */
 
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
+/*
+ * Switch to kernel cr3 if not already loaded and return current cr3 in
+ * \scratch_reg
+ */
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
 .macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0
 	cld
 	/* Push segment registers and %eax */
@@ -288,7 +315,6 @@
 #endif /* CONFIG_X86_ESPFIX32 */
 .endm
 
-
 /*
  * Called with pt_regs fully populated and kernel segments loaded,
  * so we can access PER_CPU and use the integer registers.
@@ -301,11 +327,19 @@
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
@@ -374,7 +408,8 @@
 	 * but switch back to the entry-stack again when we approach
 	 * iret and return to the interrupted code-path. This usually
 	 * happens when we hit an exception while restoring user-space
-	 * segment registers on the way back to user-space.
+	 * segment registers on the way back to user-space or when the
+	 * sysenter handler runs with eflags.tf set.
 	 *
 	 * When we switch to the task-stack here, we can't trust the
 	 * contents of the entry-stack anymore, as the exception handler
@@ -391,6 +426,7 @@
 	 *
 	 * %esi: Entry-Stack pointer (same as %esp)
 	 * %edi: Top of the task stack
+	 * %eax: CR3 on kernel entry
 	 */
 
 	/* Calculate number of bytes on the entry stack in %ecx */
@@ -407,6 +443,14 @@
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
@@ -472,7 +516,7 @@
 
 /*
  * This macro handles the case when we return to kernel-mode on the iret
- * path and have to switch back to the entry stack.
+ * path and have to switch back to the entry stack and/or user-cr3
  *
  * See the comments below the .Lentry_from_kernel_\@ label in the
  * SWITCH_TO_KERNEL_STACK macro for more details.
@@ -518,6 +562,18 @@
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
@@ -711,6 +767,18 @@ ENTRY(xen_sysenter_target)
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
@@ -791,6 +859,9 @@ ENTRY(entry_SYSENTER_32)
 	/* Switch to entry stack */
 	movl	%eax, %esp
 
+	/* Now ready to switch the cr3 */
+	SWITCH_TO_USER_CR3 scratch_reg=%eax
+
 	/*
 	 * Restore all flags except IF. (We restore IF separately because
 	 * STI gives a one-instruction window in which we won't be interrupted,
@@ -871,7 +942,11 @@ restore_all:
 .Lrestore_all_notrace:
 	CHECK_AND_APPLY_ESPFIX
 .Lrestore_nocheck:
-	RESTORE_REGS 4				# skip orig_eax/error_code
+	/* Switch back to user CR3 */
+	SWITCH_TO_USER_CR3 scratch_reg=%eax
+
+	/* Restore user state */
+	RESTORE_REGS pop=4			# skip orig_eax/error_code
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
-- 
2.7.4
