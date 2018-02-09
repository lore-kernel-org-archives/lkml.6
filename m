Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x224EcjgvTk+S85CyxTGnn2W4fMAuY7voExDC3FERS+AzHITAN/GiKoe9IRGl9Hp2PgywHc3M
ARC-Seal: i=1; a=rsa-sha256; t=1518168357; cv=none;
        d=google.com; s=arc-20160816;
        b=i8o6Llo5SwhLw9dSoICDQZgDTQVxs1dh5MZ2s84hihQa+/4grV8Q5ug7xLlwxID+pu
         MXVIg3MhP35W3JthvOY2f/0LLkm29+UgZgOsRKkDeVCPN7KyVmP2hQDRRFsfhdnhAtNj
         SNCeFGnVre6TcmR1VLGcMsCEghktrn83PAlYvtKQOK9ru3uMbol8ZpSpUvimV85i49lp
         zttBD8tp8J2Jg3atueI4RwVekDIusyhfEosf68t+MKekH0+8dUpXnEJxNQ3Fvlk3Ees4
         BsPn5KFp6FB6lDif18r+LSvGRSL5m8cGViw2Af/S9q6Bd3j3LEdBKJcD6a5lsqHC2ouM
         Rqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=WnwgFHXjKGccr3MIPKENUCBZzOb6dqg8J3/aVU7vdJE=;
        b=jCTxPlUr/J5Mke/+m2kuwJj/ENH9UMInfWiSHIxOI+nesC/uZQiWiMFohFT/1z1kwc
         CR3qgMws7qTOK7luRCjPNzr7xXUNjzThuT1xaAQ4maN7mb6c6OJne4dQAqxJldmP/mk8
         lEb2uR6OsnqGKIEDJHQyGRgMCE9XA1rLPUvqNhQaITNEsmlGiRRCL0Q5qr7Hu7hduxyd
         v/CFhJ3rXyO3fV9PC0EauC6IOHz8U8zNSP/0kiP7Yl25cxF8ZxksY0mpW903H6gYAu4+
         cMMIyP6GLxF/6i9UlQfr/cwcfB2a4l3rQbQfA/IPjsMY1ydZ1pEnEHStjmeJorHGBQ0T
         txEg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=gYjjVzA4;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=gYjjVzA4;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
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
Subject: [PATCH 09/31] x86/entry/32: Leave the kernel via trampoline stack
Date: Fri,  9 Feb 2018 10:25:18 +0100
Message-Id: <1518168340-9392-10-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904027044040?=
X-GMAIL-MSGID: =?utf-8?q?1591914904027044040?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Switch back to the trampoline stack before returning to
userspace.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index e714b53..ba3d8c2 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -338,6 +338,59 @@
 .endm
 
 /*
+ * Switch back from the kernel stack to the entry stack.
+ *
+ * The %esp register must point to pt_regs on the task stack. It will
+ * first calculate the size of the stack-frame to copy, depending on
+ * whether we return to VM86 mode or not. With that it uses 'rep movsb'
+ * to copy the contents of the stack over to the entry stack.
+ *
+ * We must be very careful here, as we can't trust the contents of the
+ * task-stack once we switched to the entry-stack. When an NMI happens
+ * while on the entry-stack, the NMI handler will switch back to the top
+ * of the task stack, overwriting our stack-frame we are about to copy.
+ * Therefore we switch the stack only after everything is copied over.
+ */
+.macro SWITCH_TO_ENTRY_STACK
+
+	ALTERNATIVE     "", "jmp .Lend_\@", X86_FEATURE_XENPV
+
+	/* Bytes to copy */
+	movl	$PTREGS_SIZE, %ecx
+
+#ifdef CONFIG_VM86
+	testl	$(X86_EFLAGS_VM), PT_EFLAGS(%esp)
+	jz	.Lcopy_pt_regs_\@
+
+	/* Additional 4 registers to copy when returning to VM86 mode */
+	addl    $(4 * 4), %ecx
+
+.Lcopy_pt_regs_\@:
+#endif
+
+	/* Initialize source and destination for movsb */
+	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %edi
+	subl	%ecx, %edi
+	movl	%esp, %esi
+
+	/* Save future stack pointer in %ebx */
+	movl %edi, %ebx
+
+	/* Copy over the stack-frame */
+	cld
+	rep movsb
+
+	/*
+	 * Switch to entry-stack - needs to happen after everything is
+	 * copied because the NMI handler will overwrite the task-stack
+	 * when on entry-stack
+	 */
+	movl	%ebx, %esp
+
+.Lend_\@:
+.endm
+
+/*
  * %eax: prev task
  * %edx: next task
  */
@@ -578,6 +631,7 @@ ENTRY(entry_SYSENTER_32)
 
 /* Opportunistic SYSEXIT */
 	TRACE_IRQS_ON			/* User mode traces as IRQs on. */
+	SWITCH_TO_ENTRY_STACK		/* Switch to per-cpu entry stack */
 	movl	PT_EIP(%esp), %edx	/* pt_regs->ip */
 	movl	PT_OLDESP(%esp), %ecx	/* pt_regs->sp */
 1:	mov	PT_FS(%esp), %fs
@@ -665,6 +719,7 @@ ENTRY(entry_INT80_32)
 
 restore_all:
 	TRACE_IRQS_IRET
+	SWITCH_TO_ENTRY_STACK
 .Lrestore_all_notrace:
 	CHECK_AND_APPLY_ESPFIX
 .Lrestore_nocheck:
-- 
2.7.4
