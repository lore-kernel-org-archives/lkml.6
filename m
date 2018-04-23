Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4+XxRmazqy09caqDEh2agOMYaueQUNSJ5DTccRO+4tPPFyezZdZhDAMvIW/apkBlodmquQ0
ARC-Seal: i=1; a=rsa-sha256; t=1524498471; cv=none;
        d=google.com; s=arc-20160816;
        b=ZmXGQe189yWPpdC98P+HEHt9C46a0bZBfZSkjxUEnVtqTxAHKYQWsi8fmTJt3P5PiW
         Ufr4WXWX/mlIARf4LhV7id7KL1F/CymsmUoD8lxsp20yw2qJdGkWgUVU0jQlFqnBwTnC
         3HkAnhdtNfJU7elbT9X2rgG8SX3XJlqEPQSXk4ou3npG2EwaRGaQAEQhspO+LNOJngkF
         +VcqE5ZKLGl3AzRENI51PqwHS7kyA9aMPlynkIcLiEgSq01XAiaS7+4bZObTZr3LLC5F
         T08Th3Np4uthDn+6RfFbEnJQZSHpcJhW5BJFkQhoksJ6Rj5fAeFhR6EpwMZ0HpElTt+D
         zrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=rTwp+7cyC+ifomD+bjEqgAZMZ9DruB4hIDWDUgoZRqs=;
        b=UGHIVsUgqsGMtBzV7t085PWdAPLExPHq/TQekOJraKEqADE2Tl6FAHqoWk5zQCiplK
         oWFyKFlCVdnqdT3z1D5Z9btq+yHPiGY3eh3/MWnuIyfXvllUgsUaBdpyqxtstReKwq1P
         fBxNQWVJI+W52gljTB/wRgJZ/+xNvdrJ5n1D7sFG1ioLRwhUTWTIQ5FMwDgO5c0aaIDk
         cSqCDrZyY02Pu7BdCZlhbzdhfw+uCURs2ra5sr/9oJ6f0A0/vWX15ZE39RBJOzNniHMg
         0IGxLlumWj2L6plvRreobMMCJ1l4nqfDqsvSEFgGj2iIgSadggdowFz147PhUcuoorAL
         P9Aw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=pIfyFSb6;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=pIfyFSb6;
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
Subject: [PATCH 11/37] x86/entry/32: Simplify debug entry point
Date: Mon, 23 Apr 2018 17:47:14 +0200
Message-Id: <1524498460-25530-12-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552509272776798?=
X-GMAIL-MSGID: =?utf-8?q?1598552509272776798?=
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
index b3477ff..71e1cb3 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1231,41 +1231,12 @@ END(common_exception)
 
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
