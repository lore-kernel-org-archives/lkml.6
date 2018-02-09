Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x224FTdGEhT4J8tQ/qkbzQnL6m045ku8V89X03OmKY7XsFg3DPeaOhPDQfU6UVtimqDsG3gLl
ARC-Seal: i=1; a=rsa-sha256; t=1518168359; cv=none;
        d=google.com; s=arc-20160816;
        b=Ip/xKIR6TzhTAUc3o9pls0VJwSRlXc3x9pTq+zvw9eAPcw7oHUraJyEXA/q7rd/qDq
         wrJGQCaik5hxSar6XTGk5dc5sGeFn+eii4fI0ZCyymrNkpacfazyUbgUmOpxdhu0QAr8
         3m7rRh1Mbky3f+uTnXlmshvo1sCQLWNVgQHSFkQcgjuwYqY/x+EfrYTWD12Pe9EH0ii6
         iYiyvvEx+OSocYpKpXVityPI+nJxBIeduc/GXVGLaPnZhGMnJ51XUm1dS3N6SQs1dLSi
         gsmsz+C93ifrlWIeGl49cQDlGYVOM8ysW1nWMPTcdec2LeSkkADOR7Mj0W0DqFG4azvW
         cp5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=9KTRuSx/r+96S1uyk96OvYxonlJ2rVE9rGTZcS4J7y8=;
        b=rZ5TZPWUqh3zyqIXmnbnNhZNGZdO/34MairhIlTDUEuW35l5VTqzEE1wjbWv44g5Q/
         SXG0YiXi7GFcD2UE5/Mii/93HwQN4crLopF+hiY+C97pyeS0uWDHETHVG3/RNqgg32L8
         ca4CIV3iXAOB17RbfcaCxtTe1WonKwp97zA1SHERltn8WU9mcOo8L6xhn7KrfPxzL8ol
         hlbqlrtD1Gh7fh5ZOOjSFTh+MgTO9yRSSHr70yUC2sZm7yI9cSY5fqN8WTGpO12iHAWK
         v74v96WFiSaFaNzdXVl0cAnPzLVEtKuIuZrODaK5NV4GtM+3omxED9DdzKLxCMyHco9I
         4Usg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=k46sgjGD;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=k46sgjGD;
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
Subject: [PATCH 10/31] x86/entry/32: Introduce SAVE_ALL_NMI and RESTORE_ALL_NMI
Date: Fri,  9 Feb 2018 10:25:19 +0100
Message-Id: <1518168340-9392-11-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914905255660193?=
X-GMAIL-MSGID: =?utf-8?q?1591914905255660193?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

These macros will be used in the NMI handler code and
replace plain SAVE_ALL and RESTORE_REGS there. We will add
the NMI-specific CR3-switch to these macros later.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index ba3d8c2..be1d814 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -167,6 +167,9 @@
 
 .endm
 
+.macro SAVE_ALL_NMI
+	SAVE_ALL
+.endm
 /*
  * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
  * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
@@ -224,6 +227,18 @@
 	RESTORE_SKIP_SEGMENTS \pop
 .endm
 
+.macro RESTORE_ALL_NMI pop=0
+	/*
+	 * Restore segments - might cause exceptions when loading
+	 * user-space segments
+	 */
+	RESTORE_SEGMENTS
+
+	/* Restore integer registers and unwind stack to iret frame */
+	RESTORE_INT_REGS
+	RESTORE_SKIP_SEGMENTS \pop
+.endm
+
 .macro CHECK_AND_APPLY_ESPFIX
 #ifdef CONFIG_X86_ESPFIX32
 #define GDT_ESPFIX_SS PER_CPU_VAR(gdt_page) + (GDT_ENTRY_ESPFIX_SS * 8)
@@ -1127,7 +1142,7 @@ ENTRY(nmi)
 #endif
 
 	pushl	%eax				# pt_regs->orig_ax
-	SAVE_ALL
+	SAVE_ALL_NMI
 	ENCODE_FRAME_POINTER
 	xorl	%edx, %edx			# zero error code
 	movl	%esp, %eax			# pt_regs pointer
@@ -1155,7 +1170,7 @@ ENTRY(nmi)
 
 .Lnmi_return:
 	CHECK_AND_APPLY_ESPFIX
-	RESTORE_REGS 4
+	RESTORE_ALL_NMI pop=4
 	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1171,12 +1186,12 @@ ENTRY(nmi)
 	pushl	16(%esp)
 	.endr
 	pushl	%eax
-	SAVE_ALL
+	SAVE_ALL_NMI
 	ENCODE_FRAME_POINTER
 	FIXUP_ESPFIX_STACK			# %eax == %esp
 	xorl	%edx, %edx			# zero error code
 	call	do_nmi
-	RESTORE_REGS
+	RESTORE_ALL_NMI
 	lss	12+4(%esp), %esp		# back to espfix stack
 	jmp	.Lirq_return
 #endif
-- 
2.7.4
