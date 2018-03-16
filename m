Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELvt126eaaeMSbu1eurOSPET4QNwKrsob0eFaB4psQZfKvkkQkScRzYdrkikqX0Cnjo8X6du
ARC-Seal: i=1; a=rsa-sha256; t=1521228603; cv=none;
        d=google.com; s=arc-20160816;
        b=NpHxViK82X7SF6lmv30w3KR4x795E/l3nedAJ+naH4J9CovGV7LSody6iIfAvYOhsb
         d9jInClyuiLznzW2iluEav8IohL9X4IjH9LJOEQJ6+RfZczaCqPvA1rL7EEMCr6YRENU
         BeMfwynQSX9eg4ZzPgFasqDCduQLiApmiYzL3V3wWD3brBH7j0tAV2sl9vJKKakLiS0b
         vp3nFAPCkE/RNcG8aoakzgSh00un6zxkGZv4k0Lzvfm+rQsZCqJYJZamBk7vffnQ4sJ1
         I+0+PVYJSrLkyfbt9aSGfK5O57opoLYMGItfFr0v5Qawsrsd7EaZPECJWagE+Fjf5HZT
         JX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=2jKrawzABq3WfJU6DRUBRZwDDKr+/Le1EWsmZepdzGI=;
        b=gV02O/J0rldjpHB48MNggXoPWo8ipzDP8vLzmyEd9mUH+SF/OE8OoILMd6eTi3o8jJ
         tKykdA225TLkwsgj5K5Zq9fuLzhFik4bFL4Qr3aJxyWvKaKC2UR4bp8UZmCpTz212VpV
         XNIbFIU0ppHcw7Bcmm7Y5Ase7oA/P7G+wUFYR3kqCwMDFw3/qNZx6HahOQOvLZSmdUDu
         tTdLoaEvr7Hfg3+4ZKtckuWPHK4AGpVuPxePlSOqGw4pVvJ1rNzFt/a52/fr0jhggjF/
         jdfvb9LJpP6pTwouaAujcu2IpErOyn2EOqiwe3U2MEdR1872CoWutm0mNlvHW6VTNSFS
         XEUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=dQ6CNBSF;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=dQ6CNBSF;
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
Subject: [PATCH 09/35] x86/entry/32: Introduce SAVE_ALL_NMI and RESTORE_ALL_NMI
Date: Fri, 16 Mar 2018 20:29:27 +0100
Message-Id: <1521228593-3820-10-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123804123344873?=
X-GMAIL-MSGID: =?utf-8?q?1595123804123344873?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

These macros will be used in the NMI handler code and
replace plain SAVE_ALL and RESTORE_REGS there. We will add
the NMI-specific CR3-switch to these macros later.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 73cde25..b60b3de 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -186,6 +186,9 @@
 
 .endm
 
+.macro SAVE_ALL_NMI
+	SAVE_ALL
+.endm
 /*
  * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
  * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
@@ -232,6 +235,10 @@
 	POP_GS_EX
 .endm
 
+.macro RESTORE_ALL_NMI pop=0
+	RESTORE_REGS pop=\pop
+.endm
+
 .macro CHECK_AND_APPLY_ESPFIX
 #ifdef CONFIG_X86_ESPFIX32
 #define GDT_ESPFIX_SS PER_CPU_VAR(gdt_page) + (GDT_ENTRY_ESPFIX_SS * 8)
@@ -1156,7 +1163,7 @@ ENTRY(nmi)
 #endif
 
 	pushl	%eax				# pt_regs->orig_ax
-	SAVE_ALL
+	SAVE_ALL_NMI
 	ENCODE_FRAME_POINTER
 	xorl	%edx, %edx			# zero error code
 	movl	%esp, %eax			# pt_regs pointer
@@ -1184,7 +1191,7 @@ ENTRY(nmi)
 
 .Lnmi_return:
 	CHECK_AND_APPLY_ESPFIX
-	RESTORE_REGS 4
+	RESTORE_ALL_NMI pop=4
 	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1200,12 +1207,12 @@ ENTRY(nmi)
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
