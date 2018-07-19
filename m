Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC57ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B6C20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B6C20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbeGTAJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:09:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46283 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeGTAJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:09:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNNZkT2451390
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:23:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNNZtE2451387;
        Thu, 19 Jul 2018 16:23:35 -0700
Date:   Thu, 19 Jul 2018 16:23:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-b92a165df17ee6e616e43107730f06bf6ecf5d8d@git.kernel.org>
Cc:     luto@kernel.org, dave.hansen@intel.com, aarcange@redhat.com,
        llong@redhat.com, peterz@infradead.org, eduval@amazon.com,
        brgerst@gmail.com, mingo@kernel.org, tglx@linutronix.de,
        dvlasenk@redhat.com, linux-kernel@vger.kernel.org, jroedel@suse.de,
        bp@alien8.de, dhgutteridge@sympatico.ca, David.Laight@aculab.com,
        jkosina@suse.cz, pavel@ucw.cz, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, boris.ostrovsky@oracle.com,
        will.deacon@arm.com, jpoimboe@redhat.com, hpa@zytor.com,
        jgross@suse.com
Reply-To: jkosina@suse.cz, David.Laight@aculab.com,
          dhgutteridge@sympatico.ca, jgross@suse.com, hpa@zytor.com,
          jpoimboe@redhat.com, will.deacon@arm.com,
          boris.ostrovsky@oracle.com, gregkh@linuxfoundation.org,
          torvalds@linux-foundation.org, pavel@ucw.cz, dvlasenk@redhat.com,
          tglx@linutronix.de, mingo@kernel.org, brgerst@gmail.com,
          eduval@amazon.com, peterz@infradead.org, aarcange@redhat.com,
          llong@redhat.com, dave.hansen@intel.com, luto@kernel.org,
          jroedel@suse.de, bp@alien8.de, linux-kernel@vger.kernel.org
In-Reply-To: <1531906876-13451-11-git-send-email-joro@8bytes.org>
References: <1531906876-13451-11-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/32: Handle Entry from Kernel-Mode on
 Entry-Stack
Git-Commit-ID: b92a165df17ee6e616e43107730f06bf6ecf5d8d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b92a165df17ee6e616e43107730f06bf6ecf5d8d
Gitweb:     https://git.kernel.org/tip/b92a165df17ee6e616e43107730f06bf6ecf5d8d
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:40:47 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:38 +0200

x86/entry/32: Handle Entry from Kernel-Mode on Entry-Stack

It is possible that the kernel is entered from kernel-mode and on the
entry-stack. The most common way this happens is when an exception is
triggered while loading the user-space segment registers on the
kernel-to-userspace exit path.

The segment loading needs to be done after the entry-stack switch, because
the stack-switch needs kernel %fs for per_cpu access.

When this happens, make sure to leave the kernel with the entry-stack
again, so that the interrupted code-path runs on the right stack when
switching to the user-cr3.

Detect this condition on kernel-entry by checking CS.RPL and %esp, and if
it happens, copy over the complete content of the entry stack to the
task-stack.  This needs to be done because once the exception handler is
entereed, the task might be scheduled out or even migrated to a different
CPU, so this cannot rely on the entry-stack contents. Leave a marker in the
stack-frame to detect this condition on the exit path.

On the exit path the copy is reversed, copy all of the remaining task-stack
back to the entry-stack and switch to it.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavel Machek <pavel@ucw.cz>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Waiman Long <llong@redhat.com>
Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1531906876-13451-11-git-send-email-joro@8bytes.org

---
 arch/x86/entry/entry_32.S | 116 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 763592596727..9d6eceba0461 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -294,6 +294,9 @@
  * copied there. So allocate the stack-frame on the task-stack and
  * switch to it before we do any copying.
  */
+
+#define CS_FROM_ENTRY_STACK	(1 << 31)
+
 .macro SWITCH_TO_KERNEL_STACK
 
 	ALTERNATIVE     "", "jmp .Lend_\@", X86_FEATURE_XENPV
@@ -316,6 +319,16 @@
 	/* Load top of task-stack into %edi */
 	movl	TSS_entry2task_stack(%edi), %edi
 
+	/*
+	 * Clear unused upper bits of the dword containing the word-sized CS
+	 * slot in pt_regs in case hardware didn't clear it for us.
+	 */
+	andl	$(0x0000ffff), PT_CS(%esp)
+
+	/* Special case - entry from kernel mode via entry stack */
+	testl	$SEGMENT_RPL_MASK, PT_CS(%esp)
+	jz	.Lentry_from_kernel_\@
+
 	/* Bytes to copy */
 	movl	$PTREGS_SIZE, %ecx
 
@@ -329,8 +342,8 @@
 	 */
 	addl	$(4 * 4), %ecx
 
-.Lcopy_pt_regs_\@:
 #endif
+.Lcopy_pt_regs_\@:
 
 	/* Allocate frame on task-stack */
 	subl	%ecx, %edi
@@ -346,6 +359,56 @@
 	cld
 	rep movsl
 
+	jmp .Lend_\@
+
+.Lentry_from_kernel_\@:
+
+	/*
+	 * This handles the case when we enter the kernel from
+	 * kernel-mode and %esp points to the entry-stack. When this
+	 * happens we need to switch to the task-stack to run C code,
+	 * but switch back to the entry-stack again when we approach
+	 * iret and return to the interrupted code-path. This usually
+	 * happens when we hit an exception while restoring user-space
+	 * segment registers on the way back to user-space.
+	 *
+	 * When we switch to the task-stack here, we can't trust the
+	 * contents of the entry-stack anymore, as the exception handler
+	 * might be scheduled out or moved to another CPU. Therefore we
+	 * copy the complete entry-stack to the task-stack and set a
+	 * marker in the iret-frame (bit 31 of the CS dword) to detect
+	 * what we've done on the iret path.
+	 *
+	 * On the iret path we copy everything back and switch to the
+	 * entry-stack, so that the interrupted kernel code-path
+	 * continues on the same stack it was interrupted with.
+	 *
+	 * Be aware that an NMI can happen anytime in this code.
+	 *
+	 * %esi: Entry-Stack pointer (same as %esp)
+	 * %edi: Top of the task stack
+	 */
+
+	/* Calculate number of bytes on the entry stack in %ecx */
+	movl	%esi, %ecx
+
+	/* %ecx to the top of entry-stack */
+	andl	$(MASK_entry_stack), %ecx
+	addl	$(SIZEOF_entry_stack), %ecx
+
+	/* Number of bytes on the entry stack to %ecx */
+	sub	%esi, %ecx
+
+	/* Mark stackframe as coming from entry stack */
+	orl	$CS_FROM_ENTRY_STACK, PT_CS(%esp)
+
+	/*
+	 * %esi and %edi are unchanged, %ecx contains the number of
+	 * bytes to copy. The code at .Lcopy_pt_regs_\@ will allocate
+	 * the stack-frame on task-stack and copy everything over
+	 */
+	jmp .Lcopy_pt_regs_\@
+
 .Lend_\@:
 .endm
 
@@ -403,6 +466,56 @@
 .Lend_\@:
 .endm
 
+/*
+ * This macro handles the case when we return to kernel-mode on the iret
+ * path and have to switch back to the entry stack.
+ *
+ * See the comments below the .Lentry_from_kernel_\@ label in the
+ * SWITCH_TO_KERNEL_STACK macro for more details.
+ */
+.macro PARANOID_EXIT_TO_KERNEL_MODE
+
+	/*
+	 * Test if we entered the kernel with the entry-stack. Most
+	 * likely we did not, because this code only runs on the
+	 * return-to-kernel path.
+	 */
+	testl	$CS_FROM_ENTRY_STACK, PT_CS(%esp)
+	jz	.Lend_\@
+
+	/* Unlikely slow-path */
+
+	/* Clear marker from stack-frame */
+	andl	$(~CS_FROM_ENTRY_STACK), PT_CS(%esp)
+
+	/* Copy the remaining task-stack contents to entry-stack */
+	movl	%esp, %esi
+	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %edi
+
+	/* Bytes on the task-stack to ecx */
+	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp1), %ecx
+	subl	%esi, %ecx
+
+	/* Allocate stack-frame on entry-stack */
+	subl	%ecx, %edi
+
+	/*
+	 * Save future stack-pointer, we must not switch until the
+	 * copy is done, otherwise the NMI handler could destroy the
+	 * contents of the task-stack we are about to copy.
+	 */
+	movl	%edi, %ebx
+
+	/* Do the copy */
+	shrl	$2, %ecx
+	cld
+	rep movsl
+
+	/* Safe to switch to entry-stack now */
+	movl	%ebx, %esp
+
+.Lend_\@:
+.endm
 /*
  * %eax: prev task
  * %edx: next task
@@ -764,6 +877,7 @@ restore_all:
 
 restore_all_kernel:
 	TRACE_IRQS_IRET
+	PARANOID_EXIT_TO_KERNEL_MODE
 	RESTORE_REGS 4
 	jmp	.Lirq_return
 
