Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELtyHerQt9+JKFEUJGjtx2HrcW3z+HxY1CByTlbOAQU+cEG7yWJozX018JPa82F2rBbkxk69
ARC-Seal: i=1; a=rsa-sha256; t=1520245573; cv=none;
        d=google.com; s=arc-20160816;
        b=Hj8m6EkbDtSmDe8bWiAACxGx7iVt2wEQwckc1HoC/CspI0VcKLGn+m7IFkMKM1iiAV
         xcS8uZHw3Et7tAd3M+b/dARbtGJObDvEOmepslczEFrSVLy7O+4pImDUPxmQ1FzUC5NF
         kWeI4p72US+ASeXH2Ux1q5rryLvyawe3pD/e39VyYlNn02bS788v33rnr+G13HIw6aGX
         nqCqweYdbUKarP+jzkCL6AAB5Lh5ZAgRxhbVJCTHJXdE4hOYdClLxONDyxv+MORfvLdE
         SfPsgQCmgLvGbvrBrGFptROqJ6PbpKeUSU8X3eRPAbmEM/cfE6VErB5ZxYNsir+8MvOf
         TrbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=bee9tXo+hRrFajk/kdCRhIPd4RZwBk3eFmYPaaGYwNU=;
        b=EJwNvxS+hxfXkRS9zEOibMXsuIiYWjP5NKfrY1aguQzoJYHuRJbzfHjdtGpNnlIyi7
         Md8RZt0tRJg+yaRtMysLtC/0yJsBiK3GDXh0VYxfU1SYTDMdq/4zu3hLhFPhI2hQHtcX
         iinrUmeOrnbzTGOc41HsM2XvrS863gBe+Isw79USthZiTByaz+wBc1npMDyZMWegvXPD
         Ro9d3/eNIyb2vi3qS7GMpgQtgBHNoH2bnXCHeywv8FFxN5CxfcdbsR+LTS6+MyyJL719
         jcOjXhhdAUrtzvw1zBaHviQB5PaJLDfHzARrDJDp2g0cCz68m1E6Gbb81irKcBH/+lj4
         86gg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=jS5r6B1+;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=jS5r6B1+;
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
Subject: [PATCH 12/34] x86/entry/32: Simplify debug entry point
Date: Mon,  5 Mar 2018 11:25:41 +0100
Message-Id: <1520245563-8444-13-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093022548148093?=
X-GMAIL-MSGID: =?utf-8?q?1594093022548148093?=
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
index 3a84945..b1a5f34ee 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1215,41 +1215,12 @@ END(common_exception)
 
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
