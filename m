Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELv6vRt5g8Sdy7ws+gp3t2NfSt4NMFJCntPhVhH2647rmJXPy6Z2aaLFJEYpnvn72Y1ccXz7
ARC-Seal: i=1; a=rsa-sha256; t=1521228605; cv=none;
        d=google.com; s=arc-20160816;
        b=CN5uVdZbCaDGkLrk55lrbEdoN+RYA9j3LUuwq7XT5kUwpdlmc3weJD7k7YTlb4EyJe
         F/nnjbPwtUDBxJ4hms0g8zQtGjmWMtO4AyterHMRzSoi1/AokkM5gxCiY0dnta187KvI
         35y3FXFZSbGQ/KBstjjRGBE5L5tT8NOgOULxL8aFkt+yOfWo2vUaxD3GdmZGz9GCctqR
         ACrXtb9tQyXbgOpbiL3liuVcyKtsAVMJaBdx5qwZcM42+vmnqpdA5Y6pUi4I3QQBlJeN
         cxFo3vY4MX6qLHbsFibMdsWLFo69r7xa1SAi7DiENASL/r5FN+QnFWZc12L5PJyOnncY
         hZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=P/7avdWRPq23ii7BDhhKqJ9eSs2btE/xtB/VZszFiVg=;
        b=aO48ICZMmMFaN+sKsH3s9RLJpI+qPrSo8OxUiYnDKG1ARMJwRzIXnGQXG4BiFSwOmo
         aW2EsqQQw+hpPstPyf571oweLMct3G+pr8hhuI70KX3uWZVfl7+xAW6yQ8wB1zXMFoh5
         30641PUmnfhRugqEdq+g2TvJe8juadDRjvdidGWvI00mraiUETs8d1+KuGANd6AZTXot
         sg//H6hOfK6F8678+OQFHawTO8HpKItQVusBlx/iIi0Og6lw96hToIwPGxPPX3/8azSJ
         pEClfjVLL0qfK2VupysggbsLJbxWzvlLM0B1niW4+13RWGcTvT4ncUo7mbCVA+h/696K
         6UFA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=G19usqW+;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=G19usqW+;
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
Subject: [PATCH 11/35] x86/entry/32: Simplify debug entry point
Date: Fri, 16 Mar 2018 20:29:29 +0100
Message-Id: <1521228593-3820-12-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123805895109259?=
X-GMAIL-MSGID: =?utf-8?q?1595123805895109259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

The common exception entry code now handles the
entry-from-sysenter stack situation and makes sure to leave
with the same stack as it entered the kernel.

So there is no need anymore for the special handling in the
debug entry code.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 4133f95..3c4822a 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1221,41 +1221,12 @@ END(common_exception)
 
 ENTRY(debug)
 	/*
-	 * #DB can happen at the first instruction of
-	 * entry_SYSENTER_32 or in Xen's SYSENTER prologue.  If this
-	 * happens, then we will be running on a very small stack.  We
-	 * need to detect this condition and switch to the thread
-	 * stack before calling any C code at all.
-	 *
-	 * If you edit this code, keep in mind that NMIs can happen in here.
+	 * Entry from sysenter is now handled in common_exception
 	 */
 	ASM_CLAC
 	pushl	$-1				# mark this as an int
-
-	SAVE_ALL
-	ENCODE_FRAME_POINTER
-	xorl	%edx, %edx			# error code 0
-	movl	%esp, %eax			# pt_regs pointer
-
-	/* Are we currently on the SYSENTER stack? */
-	movl	PER_CPU_VAR(cpu_entry_area), %ecx
-	addl	$CPU_ENTRY_AREA_entry_stack + SIZEOF_entry_stack, %ecx
-	subl	%eax, %ecx	/* ecx = (end of entry_stack) - esp */
-	cmpl	$SIZEOF_entry_stack, %ecx
-	jb	.Ldebug_from_sysenter_stack
-
-	TRACE_IRQS_OFF
-	call	do_debug
-	jmp	ret_from_exception
-
-.Ldebug_from_sysenter_stack:
-	/* We're on the SYSENTER stack.  Switch off. */
-	movl	%esp, %ebx
-	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esp
-	TRACE_IRQS_OFF
-	call	do_debug
-	movl	%ebx, %esp
-	jmp	ret_from_exception
+	pushl	$do_debug
+	jmp	common_exception
 END(debug)
 
 /*
-- 
2.7.4
