Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELseGj5IuPq6RC7TVk0LuRI/nMduURhnszY4LWdwcQoLhNauOzei+I93DHxZTP6+oXRKPnJm
ARC-Seal: i=1; a=rsa-sha256; t=1520295983; cv=none;
        d=google.com; s=arc-20160816;
        b=Txf6WXvBNLbpcmaMgqgzVkfFlLTw2cckol1akjArSTUe8HiDzyjPDR+/lZu/A2+AZc
         FqBsZvm4RlquzXlj2/BZ9SW4UEK6d7nWmJAdQL5xTJQNxsP7RtafEqU5Fo+KcE0MwHDR
         JQ7VZpilw1esDpikJykL4Eo7igT1gtS9Udk7c2UpWaOBiZV0qLF0A9XhS3XLAgT4A4JE
         9wgMDkLFXU8KlOP52VvPjr8EADj3UUNLU/RHRDVZqrFT58Y5PRj0UjuIRSjD3RaRIa8k
         qLdFEG2Dwt/E3u4yKJBqg42ytFIfEv/YG4mvJ3B4hUWWwYXPVbR2jLgbpLq1AETb2MGU
         pa6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=AdAPjFWp/OAR3GZEyxlSYCIZUWP2TWfAxvEGA5bh314=;
        b=zuOQzFn6UpKaBPala6CFXjI9E+di/WOvPmdKpCAr7WRJSyx7xS/YthcjNeOof3ebJD
         SQhEOwu2taBE48MhzOupoziZE8ow0ZdxkDxyEWlDAKJjrGFekBrdbAH0QemN/YH9kHWS
         nGzmBXp7rd/t6iJrZ7GIeNqWF9sNnl5eXiu1kiVO4tRn8MuLo00udcWQMq/3QxurUtR4
         +6VbMwvf0cC7npIIuJV6TLec+uKash57hEzKqcmbAbnsFznsnU30AjMbDNq5llpna0Re
         jzDi3T2AiijTzzUgeDFZYraQ5zAoyEeIHVLvVw4R0ltsHL3ZxyOAB0KIcp6FFZdY/GeK
         gmyw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=gpsTRcZ0;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=gpsTRcZ0;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 25/65] x86/entry: Define 'cpu_current_top_of_stack' for 64-bit code
Date: Mon,  5 Mar 2018 19:24:58 -0500
Message-Id: <20180306002538.1761-26-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145880810918910?=
X-GMAIL-MSGID: =?utf-8?q?1594145880810918910?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Denys Vlasenko <dvlasenk@redhat.com>

32-bit code has PER_CPU_VAR(cpu_current_top_of_stack).
64-bit code uses somewhat more obscure: PER_CPU_VAR(cpu_tss + TSS_sp0).

Define the 'cpu_current_top_of_stack' macro on CONFIG_X86_64
as well so that the PER_CPU_VAR(cpu_current_top_of_stack)
expression can be used in both 32-bit and 64-bit code.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Alexei Starovoitov <ast@plumgrid.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Drewry <wad@chromium.org>
Link: http://lkml.kernel.org/r/1429889495-27850-3-git-send-email-dvlasenk@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
(cherry picked from commit 3a23208e69679597e767cf3547b1a30dd845d9b5)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/ia32/ia32entry.S          |  4 ++--
 arch/x86/include/asm/thread_info.h | 10 ++++------
 arch/x86/kernel/entry_64.S         |  4 ++--
 arch/x86/xen/xen-asm_64.S          |  5 +++--
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/ia32/ia32entry.S b/arch/x86/ia32/ia32entry.S
index 2ae22c951fa0..b2fafcb37d4e 100644
--- a/arch/x86/ia32/ia32entry.S
+++ b/arch/x86/ia32/ia32entry.S
@@ -119,7 +119,7 @@ ENTRY(ia32_sysenter_target)
 	 * it is too small to ever cause noticeable irq latency.
 	 */
 	SWAPGS_UNSAFE_STACK
-	movq	PER_CPU_VAR(cpu_tss + TSS_sp0), %rsp
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 	ENABLE_INTERRUPTS(CLBR_NONE)
 
 	/* Zero-extending 32-bit regs, do not remove */
@@ -356,7 +356,7 @@ ENTRY(ia32_cstar_target)
 	SWAPGS_UNSAFE_STACK
 	movl	%esp,%r8d
 	CFI_REGISTER	rsp,r8
-	movq	PER_CPU_VAR(cpu_tss + TSS_sp0),%rsp
+	movq	PER_CPU_VAR(cpu_current_top_of_stack),%rsp
 	ENABLE_INTERRUPTS(CLBR_NONE)
 
 	/* Zero-extending 32-bit regs, do not remove */
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 472288962c99..225ee545e1a0 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -195,16 +195,14 @@ static inline unsigned long current_stack_pointer(void)
 
 #else /* !__ASSEMBLY__ */
 
+#ifdef CONFIG_X86_64
+# define cpu_current_top_of_stack (cpu_tss + TSS_sp0)
+#endif
+
 /* Load thread_info address into "reg" */
-#ifdef CONFIG_X86_32
 #define GET_THREAD_INFO(reg) \
 	_ASM_MOV PER_CPU_VAR(cpu_current_top_of_stack),reg ; \
 	_ASM_SUB $(THREAD_SIZE),reg ;
-#else
-#define GET_THREAD_INFO(reg) \
-	_ASM_MOV PER_CPU_VAR(cpu_tss + TSS_sp0),reg ; \
-	_ASM_SUB $(THREAD_SIZE),reg ;
-#endif
 
 /*
  * ASM operand which evaluates to a 'thread_info' address of
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index 99f67a38f7f0..eaf3d4df76d5 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -216,7 +216,7 @@ ENTRY(system_call)
 GLOBAL(system_call_after_swapgs)
 
 	movq	%rsp,PER_CPU_VAR(rsp_scratch)
-	movq	PER_CPU_VAR(cpu_tss + TSS_sp0),%rsp
+	movq	PER_CPU_VAR(cpu_current_top_of_stack),%rsp
 
 	/* Construct struct pt_regs on stack */
 	pushq_cfi $__USER_DS			/* pt_regs->ss */
@@ -1464,7 +1464,7 @@ ENTRY(nmi)
 	SWAPGS_UNSAFE_STACK
 	cld
 	movq	%rsp, %rdx
-	movq	PER_CPU_VAR(cpu_tss + TSS_sp0), %rsp
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 	pushq	5*8(%rdx)	/* pt_regs->ss */
 	pushq	4*8(%rdx)	/* pt_regs->rsp */
 	pushq	3*8(%rdx)	/* pt_regs->flags */
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index acc49e088ec5..5e15e92099de 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -16,6 +16,7 @@
 #include <asm/processor-flags.h>
 #include <asm/segment.h>
 #include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
 
 #include <xen/interface/xen.h>
 
@@ -70,7 +71,7 @@ ENTRY(xen_sysret64)
 	 * still with the kernel gs, so we can easily switch back
 	 */
 	movq %rsp, PER_CPU_VAR(rsp_scratch)
-	movq PER_CPU_VAR(cpu_tss + TSS_sp0), %rsp
+	movq PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 	pushq $__USER_DS
 	pushq PER_CPU_VAR(rsp_scratch)
@@ -89,7 +90,7 @@ ENTRY(xen_sysret32)
 	 * still with the kernel gs, so we can easily switch back
 	 */
 	movq %rsp, PER_CPU_VAR(rsp_scratch)
-	movq PER_CPU_VAR(cpu_tss + TSS_sp0), %rsp
+	movq PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 	pushq $__USER32_DS
 	pushq PER_CPU_VAR(rsp_scratch)
-- 
2.16.2
