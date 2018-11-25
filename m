Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D385FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA5820865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA5820865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeKYL6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 06:58:50 -0500
Received: from air.basealt.ru ([194.107.17.39]:58928 "EHLO air.basealt.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeKYL6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 06:58:50 -0500
Received: by air.basealt.ru (Postfix, from userid 490)
        id 9A0F4589AE8; Sun, 25 Nov 2018 01:09:01 +0000 (UTC)
Received: from akathisia (broadband-46-188-15-144.2com.net [46.188.15.144])
        by air.basealt.ru (Postfix) with ESMTPSA id 139F4589AE8;
        Sun, 25 Nov 2018 01:08:59 +0000 (UTC)
Date:   Sun, 25 Nov 2018 02:08:58 +0100
From:   Elvira Khabirova <lineprinter@altlinux.org>
To:     oleg@redhat.com, rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, ldv@altlinux.org, esyr@redhat.com,
        luto@kernel.org, strace-devel@lists.strace.io
Subject: [PATCH v3 2/3] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181125020858.039d9c45@akathisia>
In-Reply-To: <20181125020659.785c7b29@akathisia>
References: <20181125020659.785c7b29@akathisia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTRACE_GET_SYSCALL_INFO lets ptracer obtain details of the syscall
the tracee is blocked in.  The request succeeds when the tracee is in a
syscall-enter-stop or syscall-exit-stop, and fails with -EINVAL otherwise.
A subsequent change may extend PTRACE_GET_SYSCALL_INFO for the case
of PTRACE_EVENT_SECCOMP stop.

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

ptrace(2) man page:

long ptrace(enum __ptrace_request request, pid_t pid,
            void *addr, void *data);
...
PTRACE_GET_SYSCALL_INFO
       Retrieve information about the syscall that caused the stop.
       The information is placed into the buffer pointed by "data"
       argument, which should be a pointer to a buffer of type
       "struct ptrace_syscall_info".
       The "addr" argument contains the size of the buffer pointed to
       by "data" (i.e., sizeof(struct ptrace_syscall_info)).
       The return value contains the number of bytes available
       to be written by the kernel.
       If the size of data to be written by the kernel exceeds the size
       specified by "addr" argument, the output is truncated.
       This operation fails with EINVAL if the tracee is not
       in a syscall-enter-stop, a syscall-exit-stop, or
       a PTRACE_EVENT_SECCOMP stop.

Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/uapi/linux/ptrace.h | 24 ++++++++++++++++++
 kernel/ptrace.c             | 50 +++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index cb138902d042..49b0b1b41943 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -73,6 +73,30 @@ struct seccomp_metadata {
 	__u64 flags;		/* Output: filter's flags */
 };
 
+#define PTRACE_GET_SYSCALL_INFO		0x420f
+#define PTRACE_SYSCALL_INFO_ENTRY	0
+#define PTRACE_SYSCALL_INFO_EXIT	1
+
+struct ptrace_syscall_info {
+	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
+	__u8 __pad0[3];
+	__u32 arch;
+	union {
+		struct {
+			__u64 nr;
+			__u64 instruction_pointer;
+			__u64 stack_pointer;
+			__u64 frame_pointer;
+			__u64 args[6];
+		} entry;
+		struct {
+			__s64 rval;
+			__u8 is_error;
+			__u8 __pad1[7];
+		} exit;
+	};
+};
+
 /* Read signals from a shared (process wide) queue */
 #define PTRACE_PEEKSIGINFO_SHARED	(1 << 0)
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 80b34dffdfb9..92c47cd5ad84 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -30,6 +30,10 @@
 #include <linux/cn_proc.h>
 #include <linux/compat.h>
 
+#ifdef CONFIG_HAVE_ARCH_TRACEHOOK
+#include <asm/syscall.h>	/* For syscall_get_* */
+#endif
+
 /*
  * Access another process' address space via ptrace.
  * Source/target buffer must be kernel space,
@@ -890,6 +894,46 @@ static int ptrace_regset(struct task_struct *task, int req, unsigned int type,
 EXPORT_SYMBOL_GPL(task_user_regset_view);
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_TRACEHOOK
+static int ptrace_get_syscall(struct task_struct *child,
+			      unsigned long user_size, void __user *datavp)
+{
+	struct ptrace_syscall_info info;
+	struct pt_regs *regs = task_pt_regs(child);
+	unsigned long args[ARRAY_SIZE(info.entry.args)];
+	unsigned long actual_size;
+	unsigned long write_size;
+
+	if (child->ptrace_message == PTRACE_EVENTMSG_SYSCALL_ENTRY) {
+		int i;
+
+		info.op = PTRACE_SYSCALL_INFO_ENTRY;
+		info.arch = syscall_get_arch(child);
+		info.entry.nr = syscall_get_nr(child, regs);
+		info.entry.instruction_pointer = instruction_pointer(regs);
+		info.entry.stack_pointer = user_stack_pointer(regs);
+		info.entry.frame_pointer = frame_pointer(regs);
+		syscall_get_arguments(child, regs, 0, ARRAY_SIZE(args), args);
+		for (i = 0; i < ARRAY_SIZE(args); i++)
+			info.entry.args[i] = args[i];
+		actual_size = offsetofend(struct ptrace_syscall_info, entry);
+	} else if (child->ptrace_message == PTRACE_EVENTMSG_SYSCALL_EXIT) {
+		info.op = PTRACE_SYSCALL_INFO_EXIT;
+		info.arch = syscall_get_arch(child);
+		info.exit.rval = syscall_get_error(child, regs);
+		info.exit.is_error = !!info.exit.rval;
+		if (!info.exit.is_error)
+			info.exit.rval = syscall_get_return_value(child, regs);
+		actual_size = offsetofend(struct ptrace_syscall_info, exit);
+	} else {
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
@@ -1105,6 +1149,12 @@ int ptrace_request(struct task_struct *child, long request,
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
2.19.1

