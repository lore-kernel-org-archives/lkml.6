Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELuvkaHahMJ7RRiFZ96y5W5xMlOwkqryRXeNdsmR/RFmb8Zm/7zuJSz+zF05ZAwsApQkAnlR
ARC-Seal: i=1; a=rsa-sha256; t=1520295981; cv=none;
        d=google.com; s=arc-20160816;
        b=I3WBxw5xzlfZBcrWdU7sxrgPuuMSfOdIjx/K11XixU9EOnrCL8axftZvv8Iq54WdcF
         DRSZnbTebMqaPSLiUeVb7Os/GDDQkqhFNXjIZlPeqmeONfiU3Aa+/zfa9Ov83YhayTAt
         EEFku9o3Qf5R2BENLK+VJu70R98If90KqioLvL0C+1WdNft9tY8je0HsKc0tmKM4BWxC
         5waGWN+WDoNVRp9R7eF0eaGEs8Eb2W2AFd+sda09qCIrE3UV7U3UNLpv3vL9XXHK8XFk
         vvyqf2Y8OAakHMMI0mXFwhQhxdjqbfPYVIAGuuhsoVfICP4HDmoCBIHF2458+D0rqvkQ
         ASPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=FgiTRexofsgHhhW+f6GjVCgwwlAS0PXe5RJCA3neXRs=;
        b=wZHjr/SUBfQre9qm/lU4my+q3rFbNkzWF4HA9dYikMmuSykQ51BYJJJTUDbByigp/o
         TUqJ/a4qeiJtY+3Vs7MYBAavnSvlhBmeitY82McCtaNhvxUqv54ZVZZo0/b83Z7BjKzE
         2ZqDZxy4GEmSs89fmEEXBomut5NE5g//WjF2Sad2Qd/uKhK75+Iu4Vesl/k+HFCD4lqO
         pQMSPTLSYY1HQvBQ70k7iragTjVte6FIfFSgxydxU4ZrQvhXSC80jyfUIcBzW3ovbGkp
         j9ArZB6Xp9wnm+ToBGLLXNOC/1GeZtMDSJSLlZ6nZTGxAJGbL7CXWWVqgEMx6BU1GT9w
         mtRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=P2Q15uu9;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=P2Q15uu9;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 23/65] x86/entry: Stop using PER_CPU_VAR(kernel_stack)
Date: Mon,  5 Mar 2018 19:24:56 -0500
Message-Id: <20180306002538.1761-24-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145878437542798?=
X-GMAIL-MSGID: =?utf-8?q?1594145878437542798?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Denys Vlasenko <dvlasenk@redhat.com>

PER_CPU_VAR(kernel_stack) is redundant:

  - On the 64-bit build, we can use PER_CPU_VAR(cpu_tss + TSS_sp0).
  - On the 32-bit build, we can use PER_CPU_VAR(cpu_current_top_of_stack).

PER_CPU_VAR(kernel_stack) will be deleted by a separate change.

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
Link: http://lkml.kernel.org/r/1429889495-27850-1-git-send-email-dvlasenk@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
(cherry picked from commit 63332a8455d8310b77d38779c6c21a660a8d9feb)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/ia32/ia32entry.S          | 2 +-
 arch/x86/include/asm/thread_info.h | 8 +++++++-
 arch/x86/kernel/entry_64.S         | 4 ++--
 arch/x86/xen/xen-asm_64.S          | 5 +++--
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/ia32/ia32entry.S b/arch/x86/ia32/ia32entry.S
index 27e54946ef35..2ae22c951fa0 100644
--- a/arch/x86/ia32/ia32entry.S
+++ b/arch/x86/ia32/ia32entry.S
@@ -356,7 +356,7 @@ ENTRY(ia32_cstar_target)
 	SWAPGS_UNSAFE_STACK
 	movl	%esp,%r8d
 	CFI_REGISTER	rsp,r8
-	movq	PER_CPU_VAR(kernel_stack),%rsp
+	movq	PER_CPU_VAR(cpu_tss + TSS_sp0),%rsp
 	ENABLE_INTERRUPTS(CLBR_NONE)
 
 	/* Zero-extending 32-bit regs, do not remove */
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index b4bdec3e9523..d656a363e1eb 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -198,9 +198,15 @@ static inline unsigned long current_stack_pointer(void)
 #else /* !__ASSEMBLY__ */
 
 /* Load thread_info address into "reg" */
+#ifdef CONFIG_X86_32
 #define GET_THREAD_INFO(reg) \
-	_ASM_MOV PER_CPU_VAR(kernel_stack),reg ; \
+	_ASM_MOV PER_CPU_VAR(cpu_current_top_of_stack),reg ; \
 	_ASM_SUB $(THREAD_SIZE),reg ;
+#else
+#define GET_THREAD_INFO(reg) \
+	_ASM_MOV PER_CPU_VAR(cpu_tss + TSS_sp0),reg ; \
+	_ASM_SUB $(THREAD_SIZE),reg ;
+#endif
 
 /*
  * ASM operand which evaluates to a 'thread_info' address of
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index 6c9cb6073832..99f67a38f7f0 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -216,7 +216,7 @@ ENTRY(system_call)
 GLOBAL(system_call_after_swapgs)
 
 	movq	%rsp,PER_CPU_VAR(rsp_scratch)
-	movq	PER_CPU_VAR(kernel_stack),%rsp
+	movq	PER_CPU_VAR(cpu_tss + TSS_sp0),%rsp
 
 	/* Construct struct pt_regs on stack */
 	pushq_cfi $__USER_DS			/* pt_regs->ss */
@@ -1464,7 +1464,7 @@ ENTRY(nmi)
 	SWAPGS_UNSAFE_STACK
 	cld
 	movq	%rsp, %rdx
-	movq	PER_CPU_VAR(kernel_stack), %rsp
+	movq	PER_CPU_VAR(cpu_tss + TSS_sp0), %rsp
 	pushq	5*8(%rdx)	/* pt_regs->ss */
 	pushq	4*8(%rdx)	/* pt_regs->rsp */
 	pushq	3*8(%rdx)	/* pt_regs->flags */
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 985fc3ee0973..acc49e088ec5 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -15,6 +15,7 @@
 #include <asm/percpu.h>
 #include <asm/processor-flags.h>
 #include <asm/segment.h>
+#include <asm/asm-offsets.h>
 
 #include <xen/interface/xen.h>
 
@@ -69,7 +70,7 @@ ENTRY(xen_sysret64)
 	 * still with the kernel gs, so we can easily switch back
 	 */
 	movq %rsp, PER_CPU_VAR(rsp_scratch)
-	movq PER_CPU_VAR(kernel_stack), %rsp
+	movq PER_CPU_VAR(cpu_tss + TSS_sp0), %rsp
 
 	pushq $__USER_DS
 	pushq PER_CPU_VAR(rsp_scratch)
@@ -88,7 +89,7 @@ ENTRY(xen_sysret32)
 	 * still with the kernel gs, so we can easily switch back
 	 */
 	movq %rsp, PER_CPU_VAR(rsp_scratch)
-	movq PER_CPU_VAR(kernel_stack), %rsp
+	movq PER_CPU_VAR(cpu_tss + TSS_sp0), %rsp
 
 	pushq $__USER32_DS
 	pushq PER_CPU_VAR(rsp_scratch)
-- 
2.16.2
