Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E476BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96C82145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96C82145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbeKVCdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:33:32 -0500
Received: from air.basealt.ru ([194.107.17.39]:47904 "EHLO air.basealt.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730072AbeKVCdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:33:32 -0500
Received: by air.basealt.ru (Postfix, from userid 490)
        id DF2B2589ACD; Wed, 21 Nov 2018 15:58:14 +0000 (UTC)
Received: from akathisia (ip4-83-240-49-150.cust.nbox.cz [83.240.49.150])
        by air.basealt.ru (Postfix) with ESMTPSA id 3F37D589ACC;
        Wed, 21 Nov 2018 15:58:09 +0000 (UTC)
Date:   Wed, 21 Nov 2018 16:58:06 +0100
From:   Elvira Khabirova <lineprinter@altlinux.org>
To:     oleg@redhat.com, rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, ldv@altlinux.org, esyr@redhat.com,
        luto@kernel.org, strace-devel@lists.strace.io
Subject: [RFC PATCH v2] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181121165806.07da7c98@akathisia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTRACE_GET_SYSCALL_INFO lets ptracer obtain details of the syscall
the tracee is blocked in.  The request returns meaningful data only
when the tracee is in a syscall-enter-stop or a syscall-exit-stop.

There are two reasons for a special syscall-related ptrace request.

Firstly, with the current ptrace API there are cases when ptracer cannot
retrieve necessary information about syscalls.  Some examples include:
* The notorious int-0x80-from-64-bit-task issue.  See [1] for details.
In short, if a 64-bit task performs a syscall through int 0x80, its tracer
has no reliable means to find out that the syscall was, in fact,
a compat syscall, and misidentifies it.
* Syscall-enter-stop and syscall-exit-stop look the same for the tracer.
Common practice is to keep track of the sequence of ptrace-stops in order
not to mix the two syscall-stops up.  But it is not as simple as it looks;
for example, strace had a (just recently fixed) long-standing bug where
attaching strace to a tracee that is performing the execve system call
led to the tracer identifying the following syscall-exit-stop as
syscall-enter-stop, which messed up all the state tracking.
* Since the introduction of commit 84d77d3f06e7e8dea057d10e8ec77ad71f721be3
("ptrace: Don't allow accessing an undumpable mm"), both PTRACE_PEEKDATA
and process_vm_readv become unavailable when the process dumpable flag
is cleared.  On such architectures as ia64 this results in all syscall
arguments being unavailable.

Secondly, ptracers also have to support a lot of arch-specific code for
obtaining information about the tracee.  For some architectures, this
requires a ptrace(PTRACE_PEEKUSER, ...) invocation for every syscall
argument and return value.

PTRACE_GET_SYSCALL_INFO returns the following structure:

struct ptrace_syscall_info {
	__u8 op; /* 0 for entry, 1 for exit */
	__u8 __pad0[7];
	union {
		struct {
			__s32 nr;
			__u32 arch;
			__u64 instruction_pointer;
			__u64 args[6];
		} entry_info;
		struct {
			__s64 rval;
			__u8 is_error;
			__u8 __pad1[7];
		} exit_info;
	};
};

The structure was chosen according to [2], except for one change:
a boolean is_error field is added along with rval.  This way the tracer
can more reliably distinguish a return value from an error value.

This patch should be applied on top of [3] and [4].

[1] https://lore.kernel.org/lkml/CA+55aFzcSVmdDj9Lh_gdbz1OzHyEm6ZrGPBDAJnywm2LF_eVyg@mail.gmail.com/
[2] https://lore.kernel.org/lkml/CAObL_7GM0n80N7J_DFw_eQyfLyzq+sf4y2AvsCCV88Tb3AwEHA@mail.gmail.com/
[3] https://lore.kernel.org/lkml/20181119210139.GA8360@altlinux.org/
[4] https://lore.kernel.org/lkml/20181120001128.GA11300@altlinux.org/

Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
Changes since v1:
 * Do not use task->ptrace.
 * Replace entry_info.is_compat with entry_info.arch, use syscall_get_arch().
 * Use addr argument of sys_ptrace to get expected size of the struct;
   return full size of the struct.

 include/linux/ptrace.h      |  8 ++++++
 include/linux/tracehook.h   |  9 ++++--
 include/uapi/linux/ptrace.h | 20 +++++++++++++
 kernel/ptrace.c             | 56 +++++++++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 6c2ffed907f5..909930c893d0 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -46,6 +46,14 @@ extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
 #define PT_BLOCKSTEP_BIT	30
 #define PT_BLOCKSTEP		(1<<PT_BLOCKSTEP_BIT)
 
+/*
+ * These values are used by tracehook_report_syscall_* to store
+ * information about current syscall-stop in task->ptrace_message
+ * for later use by PTRACE_GET_SYSCALL_INFO.
+ */
+#define PT_SYSCALL_IS_ENTERING  0x80000000U
+#define PT_SYSCALL_IS_EXITING   0x90000000U
+
 extern long arch_ptrace(struct task_struct *child, long request,
 			unsigned long addr, unsigned long data);
 extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char __user *dst, int len);
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 40b0b4c1bf7b..24d0e2215ed2 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -57,13 +57,15 @@ struct linux_binprm;
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
 
+	current->ptrace_message = message;
 	ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));
 
 	/*
@@ -76,6 +78,7 @@ static inline int ptrace_report_syscall(struct pt_regs *regs)
 		current->exit_code = 0;
 	}
 
+	current->ptrace_message = 0;
 	return fatal_signal_pending(current);
 }
 
@@ -101,7 +104,7 @@ static inline int ptrace_report_syscall(struct pt_regs *regs)
 static inline __must_check int tracehook_report_syscall_entry(
 	struct pt_regs *regs)
 {
-	return ptrace_report_syscall(regs);
+	return ptrace_report_syscall(regs, PT_SYSCALL_IS_ENTERING);
 }
 
 /**
@@ -126,7 +129,7 @@ static inline void tracehook_report_syscall_exit(struct pt_regs *regs, int step)
 	if (step)
 		user_single_step_report(regs);
 	else
-		ptrace_report_syscall(regs);
+		ptrace_report_syscall(regs, PT_SYSCALL_IS_EXITING);
 }
 
 /**
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index d5a1b8a492b9..3f19a4458309 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -73,6 +73,26 @@ struct seccomp_metadata {
 	__u64 flags;		/* Output: filter's flags */
 };
 
+#define PTRACE_GET_SYSCALL_INFO 0x420f
+
+struct ptrace_syscall_info {
+	__u8 op; /* 0 for entry, 1 for exit */
+	__u8 __pad0[7];
+	union {
+		struct {
+			__s32 nr;
+			__u32 arch;
+			__u64 instruction_pointer;
+			__u64 args[6];
+		} entry_info;
+		struct {
+			__s64 rval;
+			__u8 is_error;
+			__u8 __pad1[7];
+		} exit_info;
+	};
+};
+
 /* Read signals from a shared (process wide) queue */
 #define PTRACE_PEEKSIGINFO_SHARED	(1 << 0)
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 80b34dffdfb9..7c2e92b6c762 100644
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
@@ -890,6 +894,52 @@ static int ptrace_regset(struct task_struct *task, int req, unsigned int type,
 EXPORT_SYMBOL_GPL(task_user_regset_view);
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_TRACEHOOK
+static int ptrace_get_syscall(struct task_struct *child,
+			      unsigned long user_size, void __user *datavp)
+{
+	struct ptrace_syscall_info info;
+	struct pt_regs *regs = task_pt_regs(child);
+	unsigned long args[ARRAY_SIZE(info.entry_info.args)];
+	unsigned long actual_size;
+	unsigned long write_size;
+	int i;
+
+	switch (child->ptrace_message) {
+	case PT_SYSCALL_IS_ENTERING:
+		info.op = 0;
+		info.entry_info.arch = syscall_get_arch(child);
+		info.entry_info.nr = syscall_get_nr(child, regs);
+		info.entry_info.instruction_pointer =
+			instruction_pointer(task_pt_regs(child));
+		syscall_get_arguments(child, regs, 0, ARRAY_SIZE(args), args);
+		for (i = 0; i < ARRAY_SIZE(args); i++)
+			info.entry_info.args[i] = args[i];
+		actual_size =
+			offsetofend(struct ptrace_syscall_info, entry_info);
+		break;
+
+	case PT_SYSCALL_IS_EXITING:
+		info.op = 1;
+		info.exit_info.rval = syscall_get_error(child, regs);
+		info.exit_info.is_error = !!info.exit_info.rval;
+		if (!info.exit_info.is_error) {
+			info.exit_info.rval =
+				syscall_get_return_value(child, regs);
+		}
+		actual_size =
+			offsetofend(struct ptrace_syscall_info, exit_info);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	write_size = min(actual_size, user_size);
+	return copy_to_user(datavp, &info, write_size) ? -EFAULT : actual_size;
+}
+#endif
+
 int ptrace_request(struct task_struct *child, long request,
 		   unsigned long addr, unsigned long data)
 {
@@ -1105,6 +1155,12 @@ int ptrace_request(struct task_struct *child, long request,
 		ret = seccomp_get_metadata(child, addr, datavp);
 		break;
 
+#ifdef CONFIG_HAVE_ARCH_TRACEHOOK
+	case PTRACE_GET_SYSCALL_INFO:
+		ret = ptrace_get_syscall(child, addr, datavp);
+		break;
+#endif
+
 	default:
 		break;
 	}
-- 
ldv
