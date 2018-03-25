Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeCYWWw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:22:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60895 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeCYWWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:22:48 -0400
Date: Sun, 25 Mar 2018 15:22:39 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-wz8d269hxkcwaczr0r4rhyjg@git.kernel.org>
Cc: ak@linux.intel.com, acme@redhat.com, wangnan0@huawei.com,
        jolsa@kernel.org, dsahern@gmail.com, yao.jin@linux.intel.com,
        hpa@zytor.com, adrian.hunter@intel.com, namhyung@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, adrian.hunter@intel.com, namhyung@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, ak@linux.intel.com, wangnan0@huawei.com,
        jolsa@kernel.org, dsahern@gmail.com, yao.jin@linux.intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Introduce --ignore-vmlinux command
 line option
Git-Commit-ID: be316409e9819423fc965e11486e6631734520ba
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  be316409e9819423fc965e11486e6631734520ba
Gitweb:     https://git.kernel.org/tip/be316409e9819423fc965e11486e6631734520ba
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 16 Mar 2018 15:58:35 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Mar 2018 12:53:42 -0300

perf annotate: Introduce --ignore-vmlinux command line option

This is already present in 'perf top', albeit undocumented (will fix),
and is useful to use /proc/kcore instead of vmlinux and then get what is
really in place, not what the kernel starts with, before alternatives,
ftrace .text patching, etc, see the differences:

  # perf annotate --stdio2 _raw_spin_lock_irqsave
  _raw_spin_lock_irqsave() /lib/modules/4.16.0-rc4/build/vmlinux
  Event: anon group { cycles, instructions }

    0.00   3.17      → callq  __fentry__
    0.00   7.94        push   %rbx
    7.69  36.51      → callq  __page_file_index
                       mov    %rax,%rbx
    7.69   3.17      → callq  *ffffffff82225cd0
                       xor    %eax,%eax
                       mov    $0x1,%edx
   80.77  49.21        lock   cmpxchg %edx,(%rdi)
                       test   %eax,%eax
                     ↓ jne    2b
    3.85   0.00        mov    %rbx,%rax
                       pop    %rbx
                     ← retq
                 2b:   mov    %eax,%esi
                     → callq  queued_spin_lock_slowpath
                       mov    %rbx,%rax
                       pop    %rbx
                     ← retq
  [root@jouet ~]# perf annotate --ignore-vmlinux --stdio2 _raw_spin_lock_irqsave
  _raw_spin_lock_irqsave() /proc/kcore
  Event: anon group { cycles, instructions }

    0.00   3.17        nop
    0.00   7.94        push   %rbx
    0.00  23.81        pushfq
    7.69  12.70        pop    %rax
                       nop
                       mov    %rax,%rbx
    7.69   3.17        cli
                       nop
                       xor    %eax,%eax
                       mov    $0x1,%edx
   80.77  49.21        lock   cmpxchg %edx,(%rdi)
                       test   %eax,%eax
                     ↓ jne    2b
    3.85   0.00        mov    %rbx,%rax
                       pop    %rbx
                     ← retq
                 2b:   mov    %eax,%esi
                     → callq  *ffffffff820e96b0
                       mov    %rbx,%rax
                       pop    %rbx
                     ← retq
  #

Diff of the output of those commands:

  # perf annotate --stdio2 _raw_spin_lock_irqsave > /tmp/vmlinux
  # perf annotate --ignore-vmlinux --stdio2 _raw_spin_lock_irqsave > /tmp/kcore
  # diff -y /tmp/vmlinux /tmp/kcore
  _raw_spin_lock_irqsave() vmlinux             | _raw_spin_lock_irqsave() /proc/kcore
  Event: anon group { cycles, instructions }     Event: anon group { cycles, instructions }

   0.00  3.17  → callq __fentry__              |  0.00  3.17     nop
   0.00  7.94    push  %rbx                       0.00  7.94     push  %rbx
   7.69 36.51  → callq __page_file_index       |  0.00 23.81     pushfq
                                               >  7.69 12.70     pop   %rax
                                               >                 nop
                 mov   %rax,%rbx                                 mov   %rax,%rbx
   7.69  3.17  → callq *ffffffff82225cd0       |  7.69  3.17     cli
                                               >                 nop
                 xor   %eax,%eax                                 xor   %eax,%eax
                 mov   $0x1,%edx                                 mov   $0x1,%edx
  80.77 49.21    lock  cmpxchg %edx,(%rdi)       80.77 49.21     lock  cmpxchg %edx,(%rdi)
                 test  %eax,%eax                                 test  %eax,%eax
               ↓ jne   2b                                      ↓ jne   2b
   3.85  0.00    mov   %rbx,%rax                  3.85  0.00     mov   %rbx,%rax
                 pop   %rbx                                      pop   %rbx
               ← retq                                          ← retq
            2b:  mov   %eax,%esi                            2b:  mov   %eax,%esi
               → callq queued_spin_lock_slowpath|              → callq *ffffffff820e96b0
                 mov   %rbx,%rax                                 mov   %rbx,%rax
                 pop   %rbx                                      pop   %rbx
               ← retq                                          ← retq
  #

This should be further streamlined by doing both annotations and
allowing the TUI to toggle initial/current, and show the patched
instructions in a slightly different color.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-wz8d269hxkcwaczr0r4rhyjg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-annotate.txt | 3 +++
 tools/perf/builtin-annotate.c              | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index c29c7fc93023..749cc6055dac 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -55,6 +55,9 @@ OPTIONS
 --vmlinux=<file>::
         vmlinux pathname.
 
+--ignore-vmlinux::
+	Ignore vmlinux files.
+
 -m::
 --modules::
         Load module symbols. WARNING: use only with -k and LIVE kernel.
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index fd5aac3fd949..51709a961496 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -496,6 +496,8 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
 	OPT_BOOLEAN(0, "stdio", &annotate.use_stdio, "Use the stdio interface"),
 	OPT_BOOLEAN(0, "stdio2", &annotate.use_stdio2, "Use the stdio interface"),
+	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
+                    "don't load vmlinux even if found"),
 	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN('m', "modules", &symbol_conf.use_modules,
