Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeCLOlV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:41:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751255AbeCLOlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:41:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F25204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Yang Bo <yangbo@deepin.com>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH -tip v2 0/5] kprobes: x86: Cleanup jprobe implementation on x86
Date: Mon, 12 Mar 2018 23:40:55 +0900
Message-Id: <152086565510.32679.6953754320525763743.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since we decided to remove jprobe from kernel last year,
its APIs are disabled and we worked on moving in-kernel
jprobe users to kprobes or trace-events. And now no jprobe
users are here anymore.

This series removes jprobe implementation from x86 and
generic code. I would like to send other series for each
arch. After all those patches are merged, I will remove
jprobes APIs and data structures, since changing those
definitions will break build on other archs.

Here is the series of patches to show how to do that.
I've dropped arch-independent header changes from this
version and merged kprobe-user code changes into the
last patch since that changed the kprobes expected
behavior when the kprobes modifies execution path.
(no need to enable preempt anymore)

 - Remove jprobe functions (register/unregister,
   setjump/longjump) from generic/arch-dependent code.
   [1/5][2/5]
 - Remove break_handler related code.
   [3/5][4/5]
 - Do not disable preemption on exception handler
   [5/5]

As I said above, the last patch [5/5] will change the
expected behavior on x86. Other archs also have to change
it. But anyway, currently such execution-path modifying
users in tree are very limited and only works on x86.
So we can safely modify it.

Thank you,

---

Masami Hiramatsu (5):
      kprobes: Remove jprobe API implementation
      x86: kprobes: Remove jprobe implementation
      kprobes: Ignore break_handler
      x86: kprobes: Ignore break_handler
      x86: kprobes: Do not disable preempt on int3 path


 Documentation/kprobes.txt        |   13 ++--
 arch/x86/include/asm/kprobes.h   |    3 -
 arch/x86/kernel/kprobes/common.h |   10 ---
 arch/x86/kernel/kprobes/core.c   |  114 ++------------------------------------
 arch/x86/kernel/kprobes/ftrace.c |   21 +------
 arch/x86/kernel/kprobes/opt.c    |    1 
 include/linux/kprobes.h          |    3 -
 kernel/fail_function.c           |    1 
 kernel/kprobes.c                 |  115 ++------------------------------------
 kernel/trace/trace_kprobe.c      |    3 -
 10 files changed, 20 insertions(+), 264 deletions(-)

--
Masami Hiramatsu (Linaro)
