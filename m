Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELu98dFxKG5vntNUWJzjci2LKanfIcWCbuOe1bY5qgSmadTWaOX+cL3IaSFKLtwqW3Fhcn1S
ARC-Seal: i=1; a=rsa-sha256; t=1520824088; cv=none;
        d=google.com; s=arc-20160816;
        b=JIt5XMrbv2znuwcEmiJipkc1q+8+ohJkdh9tjU8NJgCsjvopI+KmJE2eNFBpCq//bT
         jXwvNWsLFPonfx6LOWKFShXWjsUm+SDmggCzyE7+usB9G/rwIf6lvnQp9k8pr9BYP2iM
         tjcS3fF/FKWinGIVycJ5szJbkdLtvY3uccQfoXs19LNNGn5IeKtkJIi3IahRJAjkA8Ah
         bN64DENBs6u4TlGR7ZFlrz/doyYNnToWo5E80dQToT84lyVTZaDsvKRox18Mm7DPCtwE
         YKpdlCddCsfviJMSsVlCKEMru9Q97VLWBFaJwMy35H+IAi08jP8SfEE4/FHBv6zMNAP3
         vjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=F+ask+L3u2q6IebxhmaxEmOo8vY8svyQzObjFIdlDTw=;
        b=laJf10KRY6VrEEcpuZ7uhmOXMUw2s7iHg0AR5/AAp78qEzPuess2EL52Nuk9OH/iic
         w9I+4eZqP6j9x0/4OFb74P6VUEDD7eTjab+h1kzA9mBmLU4op5PblzfbUWjePUuRnS2f
         9cDqyh15XdV4YJ8kVr9/cq4FgteLeBCYtTjNfdqpjg2pqK7HV3wQFhDVJLF8Y8zVICaS
         jQtQaB7gyZCj9tzqRHcW4KpyqH4euIvtyGiEyZl9avkTCfbrOAY5rTAyO+2m4OEihKOL
         xwZf46/Q3vJgGmlODSogllxEx2ctS2+HrvRtWk0lFWpPdLCFOV3cP4vqccKDsnPT9Taj
         n/nA==
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
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Razvan Ghitulete" <rga@amazon.de>,
 thomas.lendacky@amd.com,
 "Kees Cook" <keescook@google.com>,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Peter Zijlstra" <peterz@infradead.org>,
 gnomes@lxorguk.ukuu.org.uk,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Paul Turner" <pjt@google.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Rik van Riel" <riel@redhat.com>,
 "Ingo Molnar" <mingo@kernel.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.304895281@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 060/104] x86/retpoline/entry: Convert entry assembler
 indirect jumps
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699656515090382?=
X-GMAIL-MSGID: =?utf-8?q?1594699639483613240?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2: adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kernel/entry_32.S
+++ b/arch/x86/kernel/entry_32.S
@@ -55,6 +55,7 @@
 #include <asm/irq_vectors.h>
 #include <asm/cpufeature.h>
 #include <asm/alternative-asm.h>
+#include <asm/nospec-branch.h>
 
 /* Avoid __ASSEMBLER__'ifying <linux/audit.h> just for this.  */
 #include <linux/elf-em.h>
@@ -1017,7 +1018,7 @@ ENTRY(kernel_thread_helper)
 	pushl $0		# fake return address for unwinder
 	CFI_STARTPROC
 	movl %edi,%eax
-	call *%esi
+	CALL_NOSPEC %esi
 	call do_exit
 	ud2			# padding for call trace
 	CFI_ENDPROC
@@ -1274,7 +1275,7 @@ error_code:
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
 #include <asm/alternative-asm.h>
 #include <asm/cpufeature.h>
 #include <asm/kaiser.h>
+#include <asm/nospec-branch.h>
 
 /* Avoid __ASSEMBLER__'ifying <linux/audit.h> just for this.  */
 #include <linux/elf-em.h>
@@ -519,7 +520,12 @@ system_call_fastpath:
 	cmpq $__NR_syscall_max,%rax
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
@@ -643,7 +649,12 @@ tracesys:
 	cmpq $__NR_syscall_max,%rax
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
 
@@ -1219,7 +1230,7 @@ ENTRY(kernel_thread_helper)
 	 * Here we are in the child and the registers are set as they were
 	 * at kernel_thread() invocation in the parent.
 	 */
-	call *%rsi
+	CALL_NOSPEC %rsi
 	# exit
 	mov %eax, %edi
 	call do_exit
