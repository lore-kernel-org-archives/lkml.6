Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELs7jau1v2h/MzDOmX/ls/1fUcBI/BSVVs6TMLJww+qkpWvO4Ko48bvxHq4TrqZEFtj3KhIu
ARC-Seal: i=1; a=rsa-sha256; t=1520245573; cv=none;
        d=google.com; s=arc-20160816;
        b=P2IlxSlkyko4psz8anpOdpF0Eq86Rt9KshXlppvPy5Drrd3z5SDhC0eDztX8C0CenS
         7Qb5dEpU/v2GgGmcetpA4TUaUalgobEzQ715EU5cVRIs93prrbN5Udl7fVFqPYXdNR6u
         rjHomYy6HExkE3Iu/40YlocVAdj9dLLRjnd0bDlExLXg9EDRx3plyHIJNDozyuQLQ0U4
         au+Z2oUgIr9ucmqSkPSD2PZ28rol6Sg5pmWwNXQmXMErYcoqnuki6e/c5cSKAwLy7jqc
         EG/tEJqTilkON5J0A0+jTMRbxTppZTc2ASpfiu5940nry+PcNvWS2iaP3kbqK7nOK/as
         3Otw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=RTCSI4LBCeZ83zvPmZKkwnhJMNZmduT3Jg6qpsJ2ftA=;
        b=ZzNmucxjusTp/i0S9zAxy3tEFuA3ysE2q8RYpKo3bDYyCyGvf6/CYViZPT8aTEhCp4
         r3nOx4qtuNpvXzCSGXrXbHbLKMwkhEOU1xaW9FJAhoZ9xRhJSRQJzHAkEY+uPeyNDW34
         zIf1Iycy3Rq6884SbA2bVvSNak2I/uwl+IEcWxIsfd6bWnc6dxW+65Ojb0fzlLVd44VH
         PtMvIi1xoDDa5zbg+k9tPeVrNDIAx4hV+k4hA9RxhVMEslltrso6s3dW+IurVxPFPJxT
         lf496WBv7pV9T9uUKiQtGudEwhdH8IQkVPwRMs7TjC7shon05DnkAA5niugL1V/dnsIC
         b9Xg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=i/vNGdLL;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=i/vNGdLL;
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
Subject: [PATCH 10/34] x86/entry/32: Introduce SAVE_ALL_NMI and RESTORE_ALL_NMI
Date: Mon,  5 Mar 2018 11:25:39 +0100
Message-Id: <1520245563-8444-11-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093023121299654?=
X-GMAIL-MSGID: =?utf-8?q?1594093023121299654?=
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
index 1b5656d..bb0bd896 100644
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
@@ -1148,7 +1163,7 @@ ENTRY(nmi)
 #endif
 
 	pushl	%eax				# pt_regs->orig_ax
-	SAVE_ALL
+	SAVE_ALL_NMI
 	ENCODE_FRAME_POINTER
 	xorl	%edx, %edx			# zero error code
 	movl	%esp, %eax			# pt_regs pointer
@@ -1176,7 +1191,7 @@ ENTRY(nmi)
 
 .Lnmi_return:
 	CHECK_AND_APPLY_ESPFIX
-	RESTORE_REGS 4
+	RESTORE_ALL_NMI pop=4
 	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1192,12 +1207,12 @@ ENTRY(nmi)
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
