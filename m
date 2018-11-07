Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A142C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8AB20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8AB20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeKGNUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:20:05 -0500
Received: from air.basealt.ru ([194.107.17.39]:56548 "EHLO air.basealt.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbeKGNUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 08:20:04 -0500
X-Greylist: delayed 330 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Nov 2018 08:01:57 EST
Received: by air.basealt.ru (Postfix, from userid 490)
        id EC23D589A94; Wed,  7 Nov 2018 03:27:56 +0000 (UTC)
Received: from akathisia (ip4-83-240-49-150.cust.nbox.cz [83.240.49.150])
        by air.basealt.ru (Postfix) with ESMTPSA id 7933C589A92;
        Wed,  7 Nov 2018 03:27:53 +0000 (UTC)
Date:   Wed, 7 Nov 2018 04:27:51 +0100
From:   Elvira Khabirova <lineprinter@altlinux.org>
To:     oleg@redhat.com, rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, ldv@altlinux.org, esyr@redhat.com,
        luto@kernel.org, strace-devel@lists.strace.io
Subject: [RFC PATCH] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181107042751.3b519062@akathisia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTRACE_GET_SYSCALL_INFO lets ptracer obtain details of the syscall
the tracee is blocked in. The request returns meaningful data only
when the tracee is in a syscall-enter-stop or a syscall-exit-stop.

There are two reasons for a special syscall-related ptrace request.

Firstly, with the current ptrace API there are cases when ptracer cannot
retrieve necessary information about syscalls. Some examples include:
* The notorious int-0x80-from-64-bit-task issue. See [1] for details.
In short, if a 64-bit task performs a syscall through int 0x80, its tracer
has no reliable means to find out that the syscall was, in fact,
a compat syscall, and misidentifies it.
* Syscall-enter-stop and syscall-exit-stop look the same for the tracer.
Common practice is to keep track of the sequence of ptrace-stops in order
not to mix the two syscall-stops up. But it is not as simple as it looks;
for example, strace had a (just recently fixed) long-standing bug where
attaching strace to a tracee that is performing the execve system call
led to the tracer identifying the following syscall-exit-stop as
syscall-enter-stop, which messed up all the state tracking.
* Since the introduction of commit 84d77d3f06e7e8dea057d10e8ec77ad71f721be3
("ptrace: Don't allow accessing an undumpable mm"), both PTRACE_PEEKDATA
and process_vm_readv become unavailable when the process dumpable flag
is cleared. On ia64 this results in all syscall arguments being unavailable.

Secondly, ptracers also have to support a lot of arch-specific code for
obtaining information about the tracee. For some architectures, this
requires a ptrace(PTRACE_PEEKUSER, ...) invocation for every syscall
argument and return value.

PTRACE_GET_SYSCALL_INFO returns the following structure:

struct ptrace_syscall_info {
	__u8 op; /* 0 for entry, 1 for exit */
	__u8 __pad0[7];
	union {
		struct {
			__u64 nr;
			__u64 ip;
			__u64 args[6];
			__u8 is_compat;
			__u8 __pad1[7];
		} entry_info;
		struct {
			__s64 rval;
			__u8 is_error;
			__u8 __pad2[7];
		} exit_info;
	};
};

The structure was chosen according to [2], except for two changes.
First: instead of an arch field with a value of AUDIT_ARCH_*, a boolean
is_compat value is returned, because a) not all arches have an AUDIT_ARCH_*
defined for them, b) the tracer already knows what *arch* it is running on,
but it does not know whether the tracee/syscall is in compat mode or not.
Second: a boolean is_error value is added to rval. This way the tracer can
more reliably distinguish a return value from an error value.

[1] https://lkml.kernel.org/r/CA+55aFzcSVmdDj9Lh_gdbz1OzHyEm6ZrGPBDAJnywm2LF_eVyg@mail.gmail.com
[2] http://lkml.kernel.org/r/CAObL_7GM0n80N7J_DFw_eQyfLyzq+sf4y2AvsCCV88Tb3AwEHA@mail.gmail.com

Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
---
 arch/alpha/kernel/ptrace.c      |  2 +-
 arch/arc/kernel/ptrace.c        |  2 +-
 arch/arm/kernel/ptrace.c        |  2 +-
 arch/arm64/kernel/ptrace.c      |  2 +-
 arch/c6x/kernel/ptrace.c        |  2 +-
 arch/h8300/kernel/ptrace.c      |  2 +-
 arch/hexagon/kernel/traps.c     |  2 +-
 arch/ia64/kernel/ptrace.c       |  2 +-
 arch/m68k/kernel/ptrace.c       |  3 ++-
 arch/microblaze/kernel/ptrace.c |  2 +-
 arch/mips/kernel/ptrace.c       |  2 +-
 arch/nds32/kernel/ptrace.c      |  2 +-
 arch/nios2/kernel/ptrace.c      |  3 ++-
 arch/openrisc/kernel/ptrace.c   |  2 +-
 arch/parisc/kernel/ptrace.c     |  2 +-
 arch/powerpc/kernel/ptrace.c    |  2 +-
 arch/riscv/kernel/ptrace.c      |  2 +-
 arch/s390/kernel/ptrace.c       |  2 +-
 arch/sh/kernel/ptrace_32.c      |  2 +-
 arch/sh/kernel/ptrace_64.c      |  2 +-
 arch/sparc/kernel/ptrace_32.c   |  2 +-
 arch/sparc/kernel/ptrace_64.c   |  2 +-
 arch/um/kernel/ptrace.c         |  2 +-
 arch/x86/entry/common.c         |  2 +-
 arch/xtensa/kernel/ptrace.c     |  2 +-
 include/linux/ptrace.h          | 16 ++++++++++---
 include/linux/tracehook.h       | 13 ++++++----
 include/uapi/linux/ptrace.h     | 22 +++++++++++++++++
 kernel/ptrace.c                 | 42 +++++++++++++++++++++++++++++++++
 29 files changed, 113 insertions(+), 32 deletions(-)

diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
index cb8d599e72d6..970c0719b4d1 100644
--- a/arch/alpha/kernel/ptrace.c
+++ b/arch/alpha/kernel/ptrace.c
@@ -324,7 +324,7 @@ asmlinkage unsigned long syscall_trace_enter(void)
 	unsigned long ret = 0;
 	struct pt_regs *regs = current_pt_regs();
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(current_pt_regs()))
+	    tracehook_report_syscall_entry(current_pt_regs(), false))
 		ret = -1UL;
 	audit_syscall_entry(regs->r0, regs->r16, regs->r17, regs->r18, regs->r19);
 	return ret ?: current_pt_regs()->r0;
diff --git a/arch/arc/kernel/ptrace.c b/arch/arc/kernel/ptrace.c
index 5ee4676f135d..d12c37c3da80 100644
--- a/arch/arc/kernel/ptrace.c
+++ b/arch/arc/kernel/ptrace.c
@@ -293,7 +293,7 @@ long arch_ptrace(struct task_struct *child, long request,
 
 asmlinkage int syscall_trace_entry(struct pt_regs *regs)
 {
-	if (tracehook_report_syscall_entry(regs))
+	if (tracehook_report_syscall_entry(regs, false))
 		return ULONG_MAX;
 
 	return regs->r8;
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 6fa5b6387556..686513749ac5 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -911,7 +911,7 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 
 	if (dir == PTRACE_SYSCALL_EXIT)
 		tracehook_report_syscall_exit(regs, 0);
-	else if (tracehook_report_syscall_entry(regs))
+	else if (tracehook_report_syscall_entry(regs, false))
 		current_thread_info()->syscall = -1;
 
 	regs->ARM_ip = ip;
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 1710a2d01669..667d7d96ae0a 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1626,7 +1626,7 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 
 	if (dir == PTRACE_SYSCALL_EXIT)
 		tracehook_report_syscall_exit(regs, 0);
-	else if (tracehook_report_syscall_entry(regs))
+	else if (tracehook_report_syscall_entry(regs, is_compat_task()))
 		forget_syscall(regs);
 
 	regs->regs[regno] = saved_reg;
diff --git a/arch/c6x/kernel/ptrace.c b/arch/c6x/kernel/ptrace.c
index 8801dc98fd44..169b2bf4176d 100644
--- a/arch/c6x/kernel/ptrace.c
+++ b/arch/c6x/kernel/ptrace.c
@@ -127,7 +127,7 @@ long arch_ptrace(struct task_struct *child, long request,
  */
 asmlinkage unsigned long syscall_trace_entry(struct pt_regs *regs)
 {
-	if (tracehook_report_syscall_entry(regs))
+	if (tracehook_report_syscall_entry(regs, false))
 		/* tracing decided this syscall should not happen, so
 		 * We'll return a bogus call number to get an ENOSYS
 		 * error, but leave the original number in
diff --git a/arch/h8300/kernel/ptrace.c b/arch/h8300/kernel/ptrace.c
index 0dc1c8f622bc..238918546603 100644
--- a/arch/h8300/kernel/ptrace.c
+++ b/arch/h8300/kernel/ptrace.c
@@ -179,7 +179,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 	long ret = 0;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs))
+	    tracehook_report_syscall_entry(regs, false))
 		/*
 		 * Tracing decided this syscall should not happen.
 		 * We'll return a bogus call number to get an ENOSYS
diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 91ee04842c22..840f880760b7 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -368,7 +368,7 @@ void do_trap0(struct pt_regs *regs)
 
 		/* allow strace to catch syscall args  */
 		if (unlikely(test_thread_flag(TIF_SYSCALL_TRACE) &&
-			tracehook_report_syscall_entry(regs)))
+			tracehook_report_syscall_entry(regs, false)))
 			return;  /*  return -ENOSYS somewhere?  */
 
 		/* Interrupts should be re-enabled for syscall processing */
diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index 427cd565fd61..6c12265aed65 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -1218,7 +1218,7 @@ syscall_trace_enter (long arg0, long arg1, long arg2, long arg3,
 		     struct pt_regs regs)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		if (tracehook_report_syscall_entry(&regs))
+		if (tracehook_report_syscall_entry(&regs, false))
 			return -ENOSYS;
 
 	/* copy user rbs to kernel rbs */
diff --git a/arch/m68k/kernel/ptrace.c b/arch/m68k/kernel/ptrace.c
index 748c63bd0081..cdfd21325a62 100644
--- a/arch/m68k/kernel/ptrace.c
+++ b/arch/m68k/kernel/ptrace.c
@@ -293,7 +293,8 @@ asmlinkage int syscall_trace_enter(void)
 	int ret = 0;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		ret = tracehook_report_syscall_entry(task_pt_regs(current));
+		ret = tracehook_report_syscall_entry(task_pt_regs(current),
+						     false);
 	return ret;
 }
 
diff --git a/arch/microblaze/kernel/ptrace.c b/arch/microblaze/kernel/ptrace.c
index badd286882ae..50b6bd6e2222 100644
--- a/arch/microblaze/kernel/ptrace.c
+++ b/arch/microblaze/kernel/ptrace.c
@@ -140,7 +140,7 @@ asmlinkage unsigned long do_syscall_trace_enter(struct pt_regs *regs)
 	secure_computing_strict(regs->r12);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs))
+	    tracehook_report_syscall_entry(regs, false))
 		/*
 		 * Tracing decided this syscall should not happen.
 		 * We'll return a bogus call number to get an ENOSYS
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index e5ba56c01ee0..633390fcca6a 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -1260,7 +1260,7 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 	current_thread_info()->syscall = syscall;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
-		if (tracehook_report_syscall_entry(regs))
+		if (tracehook_report_syscall_entry(regs, is_compat_task()))
 			return -1;
 		syscall = current_thread_info()->syscall;
 	}
diff --git a/arch/nds32/kernel/ptrace.c b/arch/nds32/kernel/ptrace.c
index eaaf7a999b20..fe5870aa88ba 100644
--- a/arch/nds32/kernel/ptrace.c
+++ b/arch/nds32/kernel/ptrace.c
@@ -104,7 +104,7 @@ void user_disable_single_step(struct task_struct *child)
 asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
-		if (tracehook_report_syscall_entry(regs))
+		if (tracehook_report_syscall_entry(regs, false))
 			forget_syscall(regs);
 	}
 	return regs->syscallno;
diff --git a/arch/nios2/kernel/ptrace.c b/arch/nios2/kernel/ptrace.c
index de97bcb7dd44..900daf87c771 100644
--- a/arch/nios2/kernel/ptrace.c
+++ b/arch/nios2/kernel/ptrace.c
@@ -155,7 +155,8 @@ asmlinkage int do_syscall_trace_enter(void)
 	int ret = 0;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		ret = tracehook_report_syscall_entry(task_pt_regs(current));
+		ret = tracehook_report_syscall_entry(task_pt_regs(current),
+						     false);
 
 	return ret;
 }
diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
index eb97a8e7c8aa..2c6bdff65fdb 100644
--- a/arch/openrisc/kernel/ptrace.c
+++ b/arch/openrisc/kernel/ptrace.c
@@ -179,7 +179,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 	long ret = 0;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs))
+	    tracehook_report_syscall_entry(regs, false))
 		/*
 		 * Tracing decided this syscall should not happen.
 		 * We'll return a bogus call number to get an ENOSYS
diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index 2582df1c529b..a074efef61f2 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -309,7 +309,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 long do_syscall_trace_enter(struct pt_regs *regs)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs)) {
+	    tracehook_report_syscall_entry(regs, is_compat_task())) {
 		/*
 		 * Tracing decided this syscall should not happen or the
 		 * debugger stored an invalid system call number. Skip
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index afb819f4ca68..e38374716866 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3282,7 +3282,7 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 	 * below on the exit path.
 	 */
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs))
+	    tracehook_report_syscall_entry(regs, is_compat_task()))
 		goto skip;
 
 	/* Run seccomp after ptrace; allow it to set gpr[3]. */
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 60f1e02eed36..51fc4ba43e90 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -156,7 +156,7 @@ long arch_ptrace(struct task_struct *child, long request,
 void do_syscall_trace_enter(struct pt_regs *regs)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		if (tracehook_report_syscall_entry(regs))
+		if (tracehook_report_syscall_entry(regs, false))
 			syscall_set_nr(current, regs, -1);
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index cd3df5514552..567b6fdb389f 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -845,7 +845,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 	 * call number to gprs[2].
 	 */
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    (tracehook_report_syscall_entry(regs) ||
+	    (tracehook_report_syscall_entry(regs, is_compat_task()) ||
 	     regs->gprs[2] >= NR_syscalls)) {
 		/*
 		 * Tracing decided this syscall should not happen or the
diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index 5fc3ff606210..d521976a0817 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -492,7 +492,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 	secure_computing_strict(regs->regs[0]);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs))
+	    tracehook_report_syscall_entry(regs, false))
 		/*
 		 * Tracing decided this syscall should not happen.
 		 * We'll return a bogus call number to get an ENOSYS
diff --git a/arch/sh/kernel/ptrace_64.c b/arch/sh/kernel/ptrace_64.c
index 1e0656d9e7af..11f3e22f13df 100644
--- a/arch/sh/kernel/ptrace_64.c
+++ b/arch/sh/kernel/ptrace_64.c
@@ -512,7 +512,7 @@ asmlinkage long long do_syscall_trace_enter(struct pt_regs *regs)
 	secure_computing_strict(regs->regs[9]);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs))
+	    tracehook_report_syscall_entry(regs, false))
 		/*
 		 * Tracing decided this syscall should not happen.
 		 * We'll return a bogus call number to get an ENOSYS
diff --git a/arch/sparc/kernel/ptrace_32.c b/arch/sparc/kernel/ptrace_32.c
index 16b50afe7b52..5ab2b55b3db6 100644
--- a/arch/sparc/kernel/ptrace_32.c
+++ b/arch/sparc/kernel/ptrace_32.c
@@ -452,7 +452,7 @@ asmlinkage int syscall_trace(struct pt_regs *regs, int syscall_exit_p)
 		if (syscall_exit_p)
 			tracehook_report_syscall_exit(regs, 0);
 		else
-			ret = tracehook_report_syscall_entry(regs);
+			ret = tracehook_report_syscall_entry(regs, false);
 	}
 
 	return ret;
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index e1d965e90e16..8ad2b7183b88 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -1117,7 +1117,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 		user_exit();
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		ret = tracehook_report_syscall_entry(regs);
+		ret = tracehook_report_syscall_entry(regs, is_compat_task());
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->u_regs[UREG_G1]);
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 1a1d88a4d940..36b847b10814 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -136,7 +136,7 @@ int syscall_trace_enter(struct pt_regs *regs)
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return 0;
 
-	return tracehook_report_syscall_entry(regs);
+	return tracehook_report_syscall_entry(regs, false);
 }
 
 void syscall_trace_leave(struct pt_regs *regs)
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 3b2490b81918..f4593e17cc6f 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -82,7 +82,7 @@ static long syscall_trace_enter(struct pt_regs *regs)
 		emulated = true;
 
 	if ((emulated || (work & _TIF_SYSCALL_TRACE)) &&
-	    tracehook_report_syscall_entry(regs))
+	    tracehook_report_syscall_entry(regs, in_ia32_syscall()))
 		return -1L;
 
 	if (emulated)
diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index c0845cb1cbb9..4bd0babe5536 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -466,7 +466,7 @@ long arch_ptrace(struct task_struct *child, long request,
 unsigned long do_syscall_trace_enter(struct pt_regs *regs)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs))
+	    tracehook_report_syscall_entry(regs, false))
 		return -1;
 
 	return regs->areg[2];
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 6c2ffed907f5..8c95adccb64e 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -21,9 +21,10 @@ extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
  * flags.  When the a task is stopped the ptracer owns task->ptrace.
  */
 
-#define PT_SEIZED	0x00010000	/* SEIZE used, enable new behavior */
-#define PT_PTRACED	0x00000001
-#define PT_DTRACE	0x00000002	/* delayed trace (used on m68k, i386) */
+#define PT_SEIZED		0x00010000	/* SEIZE used, enable new behavior */
+#define PT_PTRACED		0x00000001
+#define PT_DTRACE		0x00000002	/* delayed trace (used on m68k, i386) */
+#define PT_IN_SYSCALL_STOP	0x00000004	/* task is in a syscall-stop */
 
 #define PT_OPT_FLAG_SHIFT	3
 /* PT_TRACE_* event enable flags */
@@ -46,6 +47,15 @@ extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
 #define PT_BLOCKSTEP_BIT	30
 #define PT_BLOCKSTEP		(1<<PT_BLOCKSTEP_BIT)
 
+/*
+ * These flags are used in tracehook_report_syscall_* to store
+ * some information about current syscall-stop in task->ptrace_message.
+ * We can use ptrace_message because ptrace_message doesn't have to contain
+ * any specific value during syscall-stops.
+ */
+#define PT_SYSCALL_ISCOMPAT	0x00000001
+#define PT_SYSCALL_ISENTERING	0x00000002
+
 extern long arch_ptrace(struct task_struct *child, long request,
 			unsigned long addr, unsigned long data);
 extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char __user *dst, int len);
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 40b0b4c1bf7b..e02ca656d2c9 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -57,13 +57,16 @@ struct linux_binprm;
 /*
  * ptrace report for syscall entry and exit looks identical.
  */
-static inline int ptrace_report_syscall(struct pt_regs *regs)
+static inline int ptrace_report_syscall(struct pt_regs *regs,
+					unsigned long message)
 {
 	int ptrace = current->ptrace;
 
 	if (!(ptrace & PT_PTRACED))
 		return 0;
+	current->ptrace |= PT_IN_SYSCALL_STOP;
 
+	current->ptrace_message = message;
 	ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));
 
 	/*
@@ -76,6 +79,7 @@ static inline int ptrace_report_syscall(struct pt_regs *regs)
 		current->exit_code = 0;
 	}
 
+	current->ptrace &= ~PT_IN_SYSCALL_STOP;
 	return fatal_signal_pending(current);
 }
 
@@ -99,9 +103,10 @@ static inline int ptrace_report_syscall(struct pt_regs *regs)
  * Called without locks, just after entering kernel mode.
  */
 static inline __must_check int tracehook_report_syscall_entry(
-	struct pt_regs *regs)
+	struct pt_regs *regs, bool is_compat)
 {
-	return ptrace_report_syscall(regs);
+	return ptrace_report_syscall(regs, PT_SYSCALL_ISENTERING |
+		(is_compat ? PT_SYSCALL_ISCOMPAT : 0));
 }
 
 /**
@@ -126,7 +131,7 @@ static inline void tracehook_report_syscall_exit(struct pt_regs *regs, int step)
 	if (step)
 		user_single_step_report(regs);
 	else
-		ptrace_report_syscall(regs);
+		ptrace_report_syscall(regs, 0);
 }
 
 /**
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index d5a1b8a492b9..c2d30ae74de6 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -73,6 +73,28 @@ struct seccomp_metadata {
 	__u64 flags;		/* Output: filter's flags */
 };
 
+#define PTRACE_GET_SYSCALL_INFO 0x420f
+
+struct ptrace_syscall_info {
+	__u8 op; /* 0 for entry, 1 for exit */
+	__u8 __pad0[7];
+	union {
+		struct {
+			__u64 nr;
+			__u64 ip;
+			__u64 args[6];
+			__u8 is_compat;
+			__u8 __pad1[7];
+		} entry_info;
+		struct {
+			__s64 rval;
+			__u8 is_error;
+			__u8 __pad2[7];
+		} exit_info;
+	};
+};
+
+
 /* Read signals from a shared (process wide) queue */
 #define PTRACE_PEEKSIGINFO_SHARED	(1 << 0)
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 80b34dffdfb9..05fa5977bed3 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -30,6 +30,10 @@
 #include <linux/cn_proc.h>
 #include <linux/compat.h>
 
+#ifdef CONFIG_HAVE_ARCH_TRACEHOOK
+#include <asm/syscall.h> /* For syscall_get_* */
+#endif
+
 /*
  * Access another process' address space via ptrace.
  * Source/target buffer must be kernel space,
@@ -890,6 +894,37 @@ static int ptrace_regset(struct task_struct *task, int req, unsigned int type,
 EXPORT_SYMBOL_GPL(task_user_regset_view);
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_TRACEHOOK
+static int ptrace_get_syscall(struct task_struct *child, void __user *datavp)
+{
+	struct ptrace_syscall_info info;
+	struct pt_regs *regs = task_pt_regs(child);
+	unsigned long args[ARRAY_SIZE(info.entry_info.args)];
+	int i;
+
+	if (child->ptrace_message & PT_SYSCALL_ISENTERING) {
+		info.op = 0;
+		info.entry_info.nr = syscall_get_nr(child, regs);
+		info.entry_info.ip = instruction_pointer(task_pt_regs(child));
+		syscall_get_arguments(child, regs, 0, ARRAY_SIZE(args), args);
+		for (i = 0; i < ARRAY_SIZE(args); i++)
+			info.entry_info.args[i] = args[i];
+		info.entry_info.is_compat =
+			!!(child->ptrace_message & PT_SYSCALL_ISCOMPAT);
+	} else {
+		info.op = 1;
+		info.exit_info.rval = syscall_get_error(child, regs);
+		info.exit_info.is_error = !!info.exit_info.rval;
+		if (!info.exit_info.is_error) {
+			info.exit_info.rval =
+				syscall_get_return_value(child, regs);
+		}
+	}
+
+	return copy_to_user(datavp, &info, sizeof(info)) ? -EFAULT : 0;
+}
+#endif
+
 int ptrace_request(struct task_struct *child, long request,
 		   unsigned long addr, unsigned long data)
 {
@@ -1105,6 +1140,13 @@ int ptrace_request(struct task_struct *child, long request,
 		ret = seccomp_get_metadata(child, addr, datavp);
 		break;
 
+#ifdef CONFIG_HAVE_ARCH_TRACEHOOK
+	case PTRACE_GET_SYSCALL_INFO:
+		if (child->ptrace & PT_IN_SYSCALL_STOP)
+			ret = ptrace_get_syscall(child, datavp);
+		break;
+#endif
+
 	default:
 		break;
 	}
-- 
2.19.1

