Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4/Yvz2GjPn9zptH+d7oxKDkBuVHtawgk+fkB9HSBJnDzkv4XYh0+VqlSwMiKrwhoxQBC6g1
ARC-Seal: i=1; a=rsa-sha256; t=1524498473; cv=none;
        d=google.com; s=arc-20160816;
        b=pCKO8xVHviXHWnLle6XpAadOtpj77KrXRHUNqWcsxIGYNLOgQjUmrxh3mjsiyrs77E
         BrMcTsQ9L6HU4k+p9BXII0xFVlxQPC6ZujgvM4tOyd77AHYJGgt17gmOFZmXbSQAm0ME
         /dbXz+sPu/NeQWbOC2uVZXyea3Z3VU3DYaqdST4rVNU9hQgkqQS2lp8T+DpyMXU8mokg
         dli0J2ChVT9yyByHwbr2LKXOyTe7O+Lv2Lg5YEQzmN+FK7V13Cg2otBknqmP7nmyKvSX
         D5iAA+VTn/bhTLguwE0UUebDXfJ5T3H7aeA8Gf53VL0okwSdkokt6X28ykj2zgpTaiUu
         fizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=OcvQhocRGo8adLG5spe7U+na6Cqu9Y9MpjcgHIpoCVg=;
        b=UHeS4/rZEKRLj7BOu7P+AxIZd4p/+9p7+7s/MM63EAmENr3vtEQJUbCmCUQiLo0uGy
         /gPwaKtJ4kFbdFvwyIWf9hp2dMlWz4oO6i9qiyBuQrsCMXr1wR93pm2eaUJQRkA3H0xN
         bP0mCLXr/eVqvZwrpdTIZ6UNy6ew8qPbug4MlwQozJ7yE+VnPO9YcZnlelbevYEZXPo7
         yrdDJtdSI6k9GbaZnh5srU52E/iE0TtMWIAEHYAMoF/YB8B8dsr3WZ7NXQvlPAhus0VT
         huqb3F5f8SJ5tRwvMyE+e9YrZZc8dRf/KV/+KIu5e9/y01/BETJnod+aOtn8Gml3M30n
         6Uvg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=FAJuawDA;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=FAJuawDA;
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
Subject: [PATCH 14/37] x86/entry/32: Add PTI cr3 switches to NMI handler code
Date: Mon, 23 Apr 2018 17:47:17 +0200
Message-Id: <1524498460-25530-15-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552510843022690?=
X-GMAIL-MSGID: =?utf-8?q?1598552510843022690?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

The NMI handler is special, as it needs to leave with the
same cr3 as it was entered with. We need to do this because
we could enter the NMI handler from kernel code with
user-cr3 already loaded.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index b2b0ecb..f47e535 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -77,6 +77,8 @@
 #endif
 .endm
 
+#define PTI_SWITCH_MASK         (1 << PAGE_SHIFT)
+
 /*
  * User gs save/restore
  *
@@ -213,8 +215,19 @@
 
 .endm
 
-.macro SAVE_ALL_NMI
+.macro SAVE_ALL_NMI cr3_reg:req
 	SAVE_ALL
+
+	/*
+	 * Now switch the CR3 when PTI is enabled.
+	 *
+	 * We can enter with either user or kernel cr3, the code will
+	 * store the old cr3 in \cr3_reg and switches to the kernel cr3
+	 * if necessary.
+	 */
+	SWITCH_TO_KERNEL_CR3 scratch_reg=\cr3_reg
+
+.Lend_\@:
 .endm
 /*
  * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
@@ -262,7 +275,23 @@
 	POP_GS_EX
 .endm
 
-.macro RESTORE_ALL_NMI pop=0
+.macro RESTORE_ALL_NMI cr3_reg:req pop=0
+	/*
+	 * Now switch the CR3 when PTI is enabled.
+	 *
+	 * We enter with kernel cr3 and switch the cr3 to the value
+	 * stored on \cr3_reg, which is either a user or a kernel cr3.
+	 */
+	ALTERNATIVE "jmp .Lswitched_\@", "", X86_FEATURE_PTI
+
+	testl	$PTI_SWITCH_MASK, \cr3_reg
+	jz	.Lswitched_\@
+
+	/* User cr3 in \cr3_reg - write it to hardware cr3 */
+	movl	\cr3_reg, %cr3
+
+.Lswitched_\@:
+
 	RESTORE_REGS pop=\pop
 .endm
 
@@ -1333,7 +1362,7 @@ ENTRY(nmi)
 #endif
 
 	pushl	%eax				# pt_regs->orig_ax
-	SAVE_ALL_NMI
+	SAVE_ALL_NMI cr3_reg=%edi
 	ENCODE_FRAME_POINTER
 	xorl	%edx, %edx			# zero error code
 	movl	%esp, %eax			# pt_regs pointer
@@ -1361,7 +1390,7 @@ ENTRY(nmi)
 
 .Lnmi_return:
 	CHECK_AND_APPLY_ESPFIX
-	RESTORE_ALL_NMI pop=4
+	RESTORE_ALL_NMI cr3_reg=%edi pop=4
 	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1377,12 +1406,12 @@ ENTRY(nmi)
 	pushl	16(%esp)
 	.endr
 	pushl	%eax
-	SAVE_ALL_NMI
+	SAVE_ALL_NMI cr3_reg=%edi
 	ENCODE_FRAME_POINTER
 	FIXUP_ESPFIX_STACK			# %eax == %esp
 	xorl	%edx, %edx			# zero error code
 	call	do_nmi
-	RESTORE_ALL_NMI
+	RESTORE_ALL_NMI cr3_reg=%edi
 	lss	12+4(%esp), %esp		# back to espfix stack
 	jmp	.Lirq_return
 #endif
-- 
2.7.4
