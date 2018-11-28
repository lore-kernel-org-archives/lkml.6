Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F710C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF66A2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF66A2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbeK2AGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:06:20 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:59736 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbeK2AGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:06:19 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0187372CC59;
        Wed, 28 Nov 2018 16:04:40 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id EA34D7CD0D7; Wed, 28 Nov 2018 16:04:39 +0300 (MSK)
Date:   Wed, 28 Nov 2018 16:04:39 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        strace-devel@lists.strace.io
Subject: [PATCH v4 0/2] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181128130439.GB28206@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTRACE_GET_SYSCALL_INFO lets ptracer obtain details of the syscall
the tracee is blocked in.  The request succeeds when the tracee is in a
syscall-enter-stop, syscall-exit-stop or PTRACE_EVENT_SECCOMP stop,
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

PTRACE_GET_SYSCALL_INFO returns the following structure:

struct ptrace_syscall_info {
	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
	__u8 __pad0[3];
	__u32 arch;
	union {
		struct {
			__u64 nr;
			__u64 instruction_pointer;
			__u64 stack_pointer;
			__u64 frame_pointer;
			__u64 args[6];
		} entry;
		struct {
			__s64 rval;
			__u8 is_error;
			__u8 __pad1[7];
		} exit;
		struct {
			__u64 nr;
			__u64 instruction_pointer;
			__u64 stack_pointer;
			__u64 frame_pointer;
			__u64 args[6];
			__u32 ret_data;
			__u8 __pad2[4];
		} seccomp;
	};
};

The structure was chosen according to [2], except for the following
changes:
* arch is returned unconditionally to aid with tracing system calls such as
execve();
* the type of nr field was changed from int to __u64 because syscall
numbers are, as a practical matter, 64 bits;
* stack_pointer and frame_pointer fields were added along with
instruction_pointer field since they are readily available and can save
the tracer from extra PTRACE_GETREGSET calls;
* a boolean is_error field was added along with rval field, this way
the tracer can more reliably distinguish a return value
from an error value.

This changeset should be applied on top of [3] and [4].

[1] https://lore.kernel.org/lkml/CA+55aFzcSVmdDj9Lh_gdbz1OzHyEm6ZrGPBDAJnywm2LF_eVyg@mail.gmail.com/
[2] https://lore.kernel.org/lkml/CAObL_7GM0n80N7J_DFw_eQyfLyzq+sf4y2AvsCCV88Tb3AwEHA@mail.gmail.com/
[3] https://lore.kernel.org/lkml/20181119210139.GA8360@altlinux.org/
[4] https://lore.kernel.org/lkml/20181120001128.GA11300@altlinux.org/

v4:
* Re-split into two commits.
* Do not introduce task_struct.ptrace_event, use child->last_siginfo->si_code
  instead.
* Implement PTRACE_SYSCALL_INFO_SECCOMP and ptrace_syscall_info.seccomp
  support along with PTRACE_SYSCALL_INFO_{ENTRY,EXIT} and
  ptrace_syscall_info.{entry,exit}.

v3:
* Split into three commits.
* Change struct ptrace_syscall_info.
* Support PTRACE_EVENT_SECCOMP by adding ptrace_event to task_struct.
* Add proper defines for ptrace_syscall_info.op values.
* Rename PT_SYSCALL_IS_ENTERING and PT_SYSCALL_IS_EXITING to
* PTRACE_EVENTMSG_SYSCALL_ENTRY and PTRACE_EVENTMSG_SYSCALL_EXIT
* and move them to uapi.

v2:
* Do not use task->ptrace.
* Replace entry_info.is_compat with entry_info.arch, use syscall_get_arch().
* Use addr argument of sys_ptrace to get expected size of the struct;
  return full size of the struct.

Elvira Khabirova (2):
  ptrace: save the type of syscall-stop in ptrace_message
  ptrace: add PTRACE_GET_SYSCALL_INFO request

 include/linux/tracehook.h   |   9 ++--
 include/uapi/linux/ptrace.h |  44 +++++++++++++++
 kernel/ptrace.c             | 103 +++++++++++++++++++++++++++++++++++-
 3 files changed, 152 insertions(+), 4 deletions(-)

-- 
ldv
