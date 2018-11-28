Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE19C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDE820832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDE820832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeK2AI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:08:58 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:36258 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbeK2AI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:08:58 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id BA7E272CC6D;
        Wed, 28 Nov 2018 16:07:15 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id B1DDC7CD0D7; Wed, 28 Nov 2018 16:07:15 +0300 (MSK)
Date:   Wed, 28 Nov 2018 16:07:15 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        strace-devel@lists.strace.io
Subject: [PATCH v4 2/2] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181128130715.GD28206@altlinux.org>
References: <20181128130439.GB28206@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128130439.GB28206@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elvira Khabirova <lineprinter@altlinux.org>

PTRACE_GET_SYSCALL_INFO lets ptracer obtain details of the syscall
the tracee is blocked in.  The request succeeds when the tracee is
in a syscall-enter-stop, syscall-exit-stop, or PTRACE_EVENT_SECCOMP,
and fails with -EINVAL otherwise.

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
       by "data" argument (i.e., sizeof(struct ptrace_syscall_info)).
       The return value contains the number of bytes available
       to be written by the kernel.
       If the size of data to be written by the kernel exceeds the size
       specified by "addr" argument, the output is truncated.
       This operation fails with EINVAL if the tracee is not
       in a syscall-enter-stop, a syscall-exit-stop, or
       a PTRACE_EVENT_SECCOMP stop.

Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/uapi/linux/ptrace.h |  34 +++++++++++
 kernel/ptrace.c             | 110 +++++++++++++++++++++++++++++++++++-
 2 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index cb138902d042..ef42149e77f4 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -73,6 +73,40 @@ struct seccomp_metadata {
 	__u64 flags;		/* Output: filter's flags */
 };
 
+#define PTRACE_GET_SYSCALL_INFO		0x420f
+#define PTRACE_SYSCALL_INFO_ENTRY	0
+#define PTRACE_SYSCALL_INFO_EXIT	1
+#define PTRACE_SYSCALL_INFO_SECCOMP	2
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
+		struct {
+			__u64 nr;
+			__u64 instruction_pointer;
+			__u64 stack_pointer;
+			__u64 frame_pointer;
+			__u64 args[6];
+			__u32 ret_data;
+			__u8 __pad2[4];
+		} seccomp;
+	};
+};
+
 /* Read signals from a shared (process wide) queue */
 #define PTRACE_PEEKSIGINFO_SHARED	(1 << 0)
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 80b34dffdfb9..32ff9c97f941 100644
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
@@ -888,7 +892,105 @@ static int ptrace_regset(struct task_struct *task, int req, unsigned int type,
  * to ensure no machine forgets it.
  */
 EXPORT_SYMBOL_GPL(task_user_regset_view);
-#endif
+
+static unsigned long
+ptrace_get_syscall_info_entry(struct task_struct *child,
+			      struct ptrace_syscall_info *info)
+{
+	struct pt_regs *regs = task_pt_regs(child);
+	unsigned long args[ARRAY_SIZE(info->entry.args)];
+	int i;
+
+	info->op = PTRACE_SYSCALL_INFO_ENTRY;
+	info->arch = syscall_get_arch(child);
+	info->entry.nr = syscall_get_nr(child, regs);
+	info->entry.instruction_pointer = instruction_pointer(regs);
+	info->entry.stack_pointer = user_stack_pointer(regs);
+	info->entry.frame_pointer = frame_pointer(regs);
+	syscall_get_arguments(child, regs, 0, ARRAY_SIZE(args), args);
+	for (i = 0; i < ARRAY_SIZE(args); i++)
+		info->entry.args[i] = args[i];
+
+	return offsetofend(struct ptrace_syscall_info, entry);
+}
+
+static unsigned long
+ptrace_get_syscall_info_seccomp(struct task_struct *child,
+				struct ptrace_syscall_info *info)
+{
+	/*
+	 * As struct ptrace_syscall_info.entry is currently a subset
+	 * of struct ptrace_syscall_info.seccomp, it makes sense to
+	 * initialize that subset using ptrace_get_syscall_info_entry().
+	 * This can be reconsidered in the future if these structures
+	 * diverge significantly enough.
+	 */
+	ptrace_get_syscall_info_entry(child, info);
+	info->op = PTRACE_SYSCALL_INFO_SECCOMP;
+	info->seccomp.ret_data = child->ptrace_message;
+
+	return offsetofend(struct ptrace_syscall_info, seccomp);
+}
+
+static unsigned long
+ptrace_get_syscall_info_exit(struct task_struct *child,
+			     struct ptrace_syscall_info *info)
+{
+	struct pt_regs *regs = task_pt_regs(child);
+
+	info->op = PTRACE_SYSCALL_INFO_EXIT;
+	info->arch = syscall_get_arch(child);
+	info->exit.rval = syscall_get_error(child, regs);
+	info->exit.is_error = !!info->exit.rval;
+	if (!info->exit.is_error)
+		info->exit.rval = syscall_get_return_value(child, regs);
+
+	return offsetofend(struct ptrace_syscall_info, exit);
+}
+
+static int
+ptrace_get_syscall_info(struct task_struct *child, unsigned long user_size,
+			void __user *datavp)
+{
+	unsigned long actual_size = 0;
+	unsigned long write_size;
+	struct ptrace_syscall_info info;
+
+	if (!child->last_siginfo)
+		return -EINVAL;
+
+	/*
+	 * This does not need lock_task_sighand() to access
+	 * child->last_siginfo because ptrace_freeze_traced()
+	 * called earlier by ptrace_check_attach() ensures that
+	 * the tracee cannot go away and clear its last_siginfo.
+	 */
+
+	switch (child->last_siginfo->si_code) {
+	case SIGTRAP | 0x80:
+		switch (child->ptrace_message) {
+		case PTRACE_EVENTMSG_SYSCALL_ENTRY:
+			actual_size =
+				ptrace_get_syscall_info_entry(child, &info);
+			break;
+		case PTRACE_EVENTMSG_SYSCALL_EXIT:
+			actual_size =
+				ptrace_get_syscall_info_exit(child, &info);
+			break;
+		}
+		break;
+	case SIGTRAP | (PTRACE_EVENT_SECCOMP << 8):
+		actual_size = ptrace_get_syscall_info_seccomp(child, &info);
+		break;
+	}
+
+	if (!actual_size)
+		return -EINVAL;
+
+	write_size = min(actual_size, user_size);
+	return copy_to_user(datavp, &info, write_size) ? -EFAULT : actual_size;
+}
+#endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
 
 int ptrace_request(struct task_struct *child, long request,
 		   unsigned long addr, unsigned long data)
@@ -1105,6 +1207,12 @@ int ptrace_request(struct task_struct *child, long request,
 		ret = seccomp_get_metadata(child, addr, datavp);
 		break;
 
+#ifdef CONFIG_HAVE_ARCH_TRACEHOOK
+	case PTRACE_GET_SYSCALL_INFO:
+		ret = ptrace_get_syscall_info(child, addr, datavp);
+		break;
+#endif
+
 	default:
 		break;
 	}
-- 
ldv
