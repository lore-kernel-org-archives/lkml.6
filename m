Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x227tGEKEBnkdue84WNV4mkY+IrfI0vcGCZxz6+z3HYD0/AtRnw5/6JHqNtrVDnKoP3GWNFZD
ARC-Seal: i=1; a=rsa-sha256; t=1518168357; cv=none;
        d=google.com; s=arc-20160816;
        b=mEKksbbYQQNxCJUdj+qVqDttsB90YiUf3UUTCLiG/+HqrC9lgJWpwZhZyYu45Fh8Be
         lN9FwfRpKIi/lFo8S3K3d7q50DaPo0AbHx3VmsSNsS6eUdj+rkvvOOk/+QpnNV0Hye/0
         TqRVvYKibPfdY+XBYzF28JnUT8aLsBp4AhxfGVXBrAamJx5rJRcjqeh79iFHLHQwJSRp
         6Qi0UB+CjWN+hyTRsj2FqwWZrKJRlYtPqWyJUvlPStxqsQDxUtRssCKotfvRAejjLVDy
         TZR+jB9I+IyjqWQIyGoa0xZ74sFHNB2e+1YRBzy/B/Zqjqq4obfG7ulRKLwL4GPhrYgV
         cBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=lFVEWZD8iyFBLPwCnkcx5rWQZtK2TQ+3za/aoOilQ44=;
        b=prmKQ0QhZBkygoOP1Zq0M3ExE9yfIIAE6luyjd35Jtew8XqtVDmlK1DVYBISDQJ8AG
         s9Ve2z8exLcv1g0JCeNTGjKu3aKof+cPBsfPuPLCoedi0ofARJXNAOdbAIFtqgU/o/KH
         5e6HHVhJWgaOEzqxq+yGwWQ3uMnkxjnXCLEgZ11zH8QY9yDY+tLs50OmxwfhxMxRvISk
         oSS85DmDr0wceuPjcgIKikzOm3seVs/2YBEyoBNyknm8w4KRjhVFt2CC9iQm4RUuZiGn
         Qnw6ZeBFaSwFDrgWRh5qiYAEPp8ZRLr7HHy6dOHbRFG6Fkt0LZLdcS4fz6hYPDHdkbQN
         Jo7A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Zk9J6ua8;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Zk9J6ua8;
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
Subject: [PATCH 04/31] x86/entry/32: Put ESPFIX code into a macro
Date: Fri,  9 Feb 2018 10:25:13 +0100
Message-Id: <1518168340-9392-5-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914903392005228?=
X-GMAIL-MSGID: =?utf-8?q?1591914903392005228?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

This makes it easier to split up the shared iret code path.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 97 ++++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 48 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index e659776..0289bde 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -221,6 +221,54 @@
 	POP_GS_EX
 .endm
 
+.macro CHECK_AND_APPLY_ESPFIX
+#ifdef CONFIG_X86_ESPFIX32
+#define GDT_ESPFIX_SS PER_CPU_VAR(gdt_page) + (GDT_ENTRY_ESPFIX_SS * 8)
+
+	ALTERNATIVE	"jmp .Lend_\@", "", X86_BUG_ESPFIX
+
+	movl	PT_EFLAGS(%esp), %eax		# mix EFLAGS, SS and CS
+	/*
+	 * Warning: PT_OLDSS(%esp) contains the wrong/random values if we
+	 * are returning to the kernel.
+	 * See comments in process.c:copy_thread() for details.
+	 */
+	movb	PT_OLDSS(%esp), %ah
+	movb	PT_CS(%esp), %al
+	andl	$(X86_EFLAGS_VM | (SEGMENT_TI_MASK << 8) | SEGMENT_RPL_MASK), %eax
+	cmpl	$((SEGMENT_LDT << 8) | USER_RPL), %eax
+	jne	.Lend_\@	# returning to user-space with LDT SS
+
+	/*
+	 * Setup and switch to ESPFIX stack
+	 *
+	 * We're returning to userspace with a 16 bit stack. The CPU will not
+	 * restore the high word of ESP for us on executing iret... This is an
+	 * "official" bug of all the x86-compatible CPUs, which we can work
+	 * around to make dosemu and wine happy. We do this by preloading the
+	 * high word of ESP with the high word of the userspace ESP while
+	 * compensating for the offset by changing to the ESPFIX segment with
+	 * a base address that matches for the difference.
+	 */
+	mov	%esp, %edx			/* load kernel esp */
+	mov	PT_OLDESP(%esp), %eax		/* load userspace esp */
+	mov	%dx, %ax			/* eax: new kernel esp */
+	sub	%eax, %edx			/* offset (low word is 0) */
+	shr	$16, %edx
+	mov	%dl, GDT_ESPFIX_SS + 4		/* bits 16..23 */
+	mov	%dh, GDT_ESPFIX_SS + 7		/* bits 24..31 */
+	pushl	$__ESPFIX_SS
+	pushl	%eax				/* new kernel esp */
+	/*
+	 * Disable interrupts, but do not irqtrace this section: we
+	 * will soon execute iret and the tracer was already set to
+	 * the irqstate after the IRET:
+	 */
+	DISABLE_INTERRUPTS(CLBR_ANY)
+	lss	(%esp), %esp			/* switch to espfix segment */
+.Lend_\@:
+#endif /* CONFIG_X86_ESPFIX32 */
+.endm
 /*
  * %eax: prev task
  * %edx: next task
@@ -548,21 +596,7 @@ ENTRY(entry_INT80_32)
 restore_all:
 	TRACE_IRQS_IRET
 .Lrestore_all_notrace:
-#ifdef CONFIG_X86_ESPFIX32
-	ALTERNATIVE	"jmp .Lrestore_nocheck", "", X86_BUG_ESPFIX
-
-	movl	PT_EFLAGS(%esp), %eax		# mix EFLAGS, SS and CS
-	/*
-	 * Warning: PT_OLDSS(%esp) contains the wrong/random values if we
-	 * are returning to the kernel.
-	 * See comments in process.c:copy_thread() for details.
-	 */
-	movb	PT_OLDSS(%esp), %ah
-	movb	PT_CS(%esp), %al
-	andl	$(X86_EFLAGS_VM | (SEGMENT_TI_MASK << 8) | SEGMENT_RPL_MASK), %eax
-	cmpl	$((SEGMENT_LDT << 8) | USER_RPL), %eax
-	je .Lldt_ss				# returning to user-space with LDT SS
-#endif
+	CHECK_AND_APPLY_ESPFIX
 .Lrestore_nocheck:
 	RESTORE_REGS 4				# skip orig_eax/error_code
 .Lirq_return:
@@ -575,39 +609,6 @@ ENTRY(iret_exc	)
 	jmp	common_exception
 .previous
 	_ASM_EXTABLE(.Lirq_return, iret_exc)
-
-#ifdef CONFIG_X86_ESPFIX32
-.Lldt_ss:
-/*
- * Setup and switch to ESPFIX stack
- *
- * We're returning to userspace with a 16 bit stack. The CPU will not
- * restore the high word of ESP for us on executing iret... This is an
- * "official" bug of all the x86-compatible CPUs, which we can work
- * around to make dosemu and wine happy. We do this by preloading the
- * high word of ESP with the high word of the userspace ESP while
- * compensating for the offset by changing to the ESPFIX segment with
- * a base address that matches for the difference.
- */
-#define GDT_ESPFIX_SS PER_CPU_VAR(gdt_page) + (GDT_ENTRY_ESPFIX_SS * 8)
-	mov	%esp, %edx			/* load kernel esp */
-	mov	PT_OLDESP(%esp), %eax		/* load userspace esp */
-	mov	%dx, %ax			/* eax: new kernel esp */
-	sub	%eax, %edx			/* offset (low word is 0) */
-	shr	$16, %edx
-	mov	%dl, GDT_ESPFIX_SS + 4		/* bits 16..23 */
-	mov	%dh, GDT_ESPFIX_SS + 7		/* bits 24..31 */
-	pushl	$__ESPFIX_SS
-	pushl	%eax				/* new kernel esp */
-	/*
-	 * Disable interrupts, but do not irqtrace this section: we
-	 * will soon execute iret and the tracer was already set to
-	 * the irqstate after the IRET:
-	 */
-	DISABLE_INTERRUPTS(CLBR_ANY)
-	lss	(%esp), %esp			/* switch to espfix segment */
-	jmp	.Lrestore_nocheck
-#endif
 ENDPROC(entry_INT80_32)
 
 .macro FIXUP_ESPFIX_STACK
-- 
2.7.4
