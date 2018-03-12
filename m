Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELuf1CoOQGf/dEqI9/ljT+uk7vmX/N0QWN+bD1wL8as6l2HX6bhbbyEnX4fKF86uADnvSna8
ARC-Seal: i=1; a=rsa-sha256; t=1520824104; cv=none;
        d=google.com; s=arc-20160816;
        b=BAVW18mUbzniP9n/ygAx/rXRiWZr8S9qwnxEcGYpyLlELNAwwUg+E6kq6+wS0i9dmH
         Sd/FcglGxw6GDzg6P0NvE2BG17sWf1lXlTEULBZUA31p9qZkO1IwOqo4ugvrM7V4QQmI
         RwixLTNsA3WsXca5AKb2hhzK/Mx2vXIOJIQbkQuj7YOsP6ALoFSNEHpoB25FIIh+qRB9
         oeUoktPwzmyV5QwTbpaZsWPqhfBKzs4t3i4/wyneKV/6Nlw1RtrRu5hmQNKb7eCNPSo+
         qXuHKXzOywGvdB6PCErDRp9uU985+UUHUi7zoCmgUEMInmfwHK80e48Im5HPePrc+S0i
         efpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=7DgFCwMtX92qby/LquDW+f0MPeIMYammawf9a5e+rJg=;
        b=jh4jSV4xvBD/5TY3C6rQ/QSfHQOnhcHzM4A5Na57TFXpMGHDpSotsdrEI2o805HByL
         qvflpcXqpr1hBkq7nplo/JZWnmf6+RpXuthMpa6SMjj6ueA+0sqJaEYfQdWitCgiebo5
         3oN4W4Ts6yB4vvaudrI3gBHEGHXTP26fPNmPX1Y3kQBa0RDpQ+OI3G5ZhzwFOxUWcXqB
         C/JYnV5DorEKW7OrlnIhWOk0DhIieNgN+oGYtpMdwjkjCIYUyzIiXUzFm3HEOIdu7Cii
         9MyonAqt4pYJPMELRhTUNRCO1kVwbcPJ6ankVa653ubOlMpmtahSXlXIukw29BwKxFpD
         SYeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Rik van Riel" <riel@redhat.com>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Kees Cook" <keescook@google.com>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 thomas.lendacky@amd.com,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Ingo Molnar" <mingo@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Razvan Ghitulete" <rga@amazon.de>,
 gnomes@lxorguk.ukuu.org.uk,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Paul Turner" <pjt@google.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.527106155@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 26/76] x86/retpoline/entry: Convert entry assembler
 indirect jumps
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699656515090382?=
X-GMAIL-MSGID: =?utf-8?q?1594699656515090382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 2641f08bb7fc63a636a2b18173221d7040a3512e upstream.

Convert indirect jumps in core 32/64bit entry assembler code to use
non-speculative sequences when CONFIG_RETPOLINE is enabled.

Don't use CALL_NOSPEC in entry_SYSCALL_64_fastpath because the return
address after the 'call' instruction must be *precisely* at the
.Lentry_SYSCALL_64_after_fastpath label for stub_ptregs_64 to work,
and the use of alternatives will mess that up unless we play horrid
games to prepend with NOPs and make the variants the same length. It's
not worth it; in the case where we ALTERNATIVE out the retpoline, the
first instruction at __x86.indirect_thunk.rax is going to be a bare
jmp *%rax anyway.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Arjan van de Ven <arjan@linux.intel.com>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: Rik van Riel <riel@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: thomas.lendacky@amd.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <keescook@google.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/1515707194-20531-7-git-send-email-dwmw@amazon.co.uk
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Razvan Ghitulete <rga@amazon.de>
[bwh: Backported to 3.16: adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kernel/entry_32.S
+++ b/arch/x86/kernel/entry_32.S
@@ -58,6 +58,7 @@
 #include <asm/alternative-asm.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
+#include <asm/nospec-branch.h>
 
 /* Avoid __ASSEMBLER__'ifying <linux/audit.h> just for this.  */
 #include <linux/elf-em.h>
@@ -308,7 +309,8 @@ ENTRY(ret_from_kernel_thread)
 	pushl_cfi $0x0202		# Reset kernel eflags
 	popfl_cfi
 	movl PT_EBP(%esp),%eax
-	call *PT_EBX(%esp)
+	movl	PT_EBX(%esp), %edx
+	CALL_NOSPEC %edx
 	movl $0,PT_EAX(%esp)
 	jmp syscall_exit
 	CFI_ENDPROC
@@ -1277,7 +1279,7 @@ error_code:
 	movl %ecx, %es
 	TRACE_IRQS_OFF
 	movl %esp,%eax			# pt_regs pointer
-	call *%edi
+	CALL_NOSPEC %edi
 	jmp ret_from_exception
 	CFI_ENDPROC
 END(page_fault)
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -59,6 +59,7 @@
 #include <asm/smap.h>
 #include <asm/pgtable_types.h>
 #include <asm/kaiser.h>
+#include <asm/nospec-branch.h>
 #include <linux/err.h>
 
 /* Avoid __ASSEMBLER__'ifying <linux/audit.h> just for this.  */
@@ -375,7 +376,7 @@ ENTRY(ret_from_fork)
 	subq $REST_SKIP, %rsp	# leave space for volatiles
 	CFI_ADJUST_CFA_OFFSET	REST_SKIP
 	movq %rbp, %rdi
-	call *%rbx
+	CALL_NOSPEC %rbx
 	movl $0, RAX(%rsp)
 	RESTORE_REST
 	jmp int_ret_from_sys_call
@@ -451,7 +452,12 @@ system_call_fastpath:
 #endif
 	ja badsys
 	movq %r10,%rcx
+#ifdef CONFIG_RETPOLINE
+	movq	sys_call_table(, %rax, 8), %rax
+	call	__x86_indirect_thunk_rax
+#else
 	call *sys_call_table(,%rax,8)  # XXX:	 rip relative
+#endif
 	movq %rax,RAX-ARGOFFSET(%rsp)
 /*
  * Syscall return path ending with SYSRET (fast path)
@@ -578,7 +584,12 @@ tracesys:
 #endif
 	ja   int_ret_from_sys_call	/* RAX(%rsp) set to -ENOSYS above */
 	movq %r10,%rcx	/* fixup for C */
+#ifdef CONFIG_RETPOLINE
+	movq	sys_call_table(, %rax, 8), %rax
+	call	__x86_indirect_thunk_rax
+#else
 	call *sys_call_table(,%rax,8)
+#endif
 	movq %rax,RAX-ARGOFFSET(%rsp)
 	/* Use IRET because user could have changed frame */
 
