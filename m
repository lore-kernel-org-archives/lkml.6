Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x227HLUXuJEFBwA4Vo0n13c4EZp+lnXbw+1T6XndSM+rWF4Tk9fr1yTc+C3Z26AF9k3svT86t
ARC-Seal: i=1; a=rsa-sha256; t=1518168358; cv=none;
        d=google.com; s=arc-20160816;
        b=WalgS14h5YQJtJMh9otqRLKFKaUYxhQE+2jz7pTdAphM6Io4bNWBFniJJUZyjiTOXc
         FuDkWoCGitZXYEQknDJC1IvrlQ1MC3q/NzYcHjfskM/+dsuII3it2T7OtFRfHiKiA8Xt
         AVph/6pd8DDTWbm8tNFQYkWxhxUi49OTQ/hdmqsHmCLVcaWZ/hbXQt365avRYrD5GiuG
         EvcAMJnRWeiZGkhxGgwiwNg0WZJrnHO4hM7tqkMZfHi0nI+BiLcNm17CQrKu4uEhnOhk
         jcwRKttqa7EFq1WF7jY3vhI+HTqWb3PPz0prP3N8VSQBhbBbapFyBrTl1MaFgRJ0WAfl
         uw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=FOGcjZdCJswE4mbEpM6qn1i3rwOsDJ4PA+EewLYsZVk=;
        b=rSraFozechUmuPlvpTBP7WVKvC+kFcXk6AK7U4Bt/+VsaE26QT2m8cu4CNTr3bZ/76
         7tfT6Jgj+iZGTpzwsk54cA/XXW0dLRigK3V1xc+AtkZLwKF9OBjFE60d/fOGm8G+q7K+
         e4/KhnpqYtZhI/6UQgCSGQA9gtQOyDD0XF1HktYfYfj3DrzIUfqsx+pl1sXMcIOXS83d
         yBJzuw5wKXCejINMflLv0nkqR01O8Xi9AE2ndVqv8S1b26lrALWO3SiQ/9bltm87qu7a
         bqOLNB3ptdQIGitHGt6DGXaLvyshQ4p7m7vLEhxBzLvWnBe9KEWIYpoKJsW1FjQv25Oe
         jtKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=NEGSudBf;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=NEGSudBf;
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
Subject: [PATCH 12/31] x86/entry/32: Add PTI cr3 switch to non-NMI entry/exit points
Date: Fri,  9 Feb 2018 10:25:21 +0100
Message-Id: <1518168340-9392-13-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904588119761?=
X-GMAIL-MSGID: =?utf-8?q?1591914904588119761?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Add unconditional cr3 switches between user and kernel cr3
to all non-NMI entry and exit points.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 59 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 9693485..b5ef003 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -328,6 +328,25 @@
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
+	andl	$(~PTI_SWITCH_MASK), \scratch_reg
+	movl	\scratch_reg, %cr3
+.Lend_\@:
+.endm
+
 
 /*
  * Called with pt_regs fully populated and kernel segments loaded,
@@ -343,6 +362,8 @@
 
 	ALTERNATIVE     "", "jmp .Lend_\@", X86_FEATURE_XENPV
 
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
+
 	/* Are we on the entry stack? Bail out if not! */
 	movl	PER_CPU_VAR(cpu_entry_area), %edi
 	addl	$CPU_ENTRY_AREA_entry_stack, %edi
@@ -637,6 +658,18 @@ ENTRY(xen_sysenter_target)
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
@@ -691,6 +724,10 @@ ENTRY(entry_SYSENTER_32)
 	movl	PT_OLDESP(%esp), %ecx	/* pt_regs->sp */
 1:	mov	PT_FS(%esp), %fs
 	PTGS_TO_GS
+
+	/* Segments are restored - switch to user cr3 */
+	SWITCH_TO_USER_CR3 scratch_reg=%eax
+
 	popl	%ebx			/* pt_regs->bx */
 	addl	$2*4, %esp		/* skip pt_regs->cx and pt_regs->dx */
 	popl	%esi			/* pt_regs->si */
@@ -778,7 +815,23 @@ restore_all:
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
 
@@ -1139,6 +1192,10 @@ ENTRY(debug)
 
 	SAVE_ALL
 	ENCODE_FRAME_POINTER
+
+	/* Make sure we are running on kernel cr3 */
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
+
 	xorl	%edx, %edx			# error code 0
 	movl	%esp, %eax			# pt_regs pointer
 
-- 
2.7.4
