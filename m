Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751118AbeDQEIL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 00:08:11 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37462 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeDQEIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 00:08:10 -0400
X-Google-Smtp-Source: AIpwx4+kRN2WwQzjSLZhskb7w3IIhaLDYSO4qlnT+T6O/xyMt+karn+ar4AC1h5AZFMFg8l8/2R0FQ==
From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc: Joel Fernandes <joelaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>
Subject: [RFC v4 0/4] Centralize and unify usage of preempt/irq tracepoints
Date: Mon, 16 Apr 2018 21:07:44 -0700
Message-Id: <20180417040748.212236-1-joelaf@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
This is the next revision of preempt/irq tracepoint centralization and
unified usage across the kernel [1].
The preempt/irq tracepoints exist but not everything in the kernel is
using it. This makes things not work simultaneously (for ex, only
lockdep or irqsoff events can be used). This series is an attempt to
solve that.

I fixed several issues since last rev and I'm posting it slightly early
than I wanted to for some feedback especially for the new patches 1-3 in
this series. Also any testing is deeply appreciated.

Status:
Currently I'm noticing a performance issue with "enabling" of the
preemptoff tracer (not during its running but the enabling/startup of
it). I narrowed this down to rcu_irq_enter_irqson and
rcu_irq_exit_irqson calls in tracepoint.h. Commenting these out makes
the perf issue go away. I also notice that disabling function tracer
also makes the issue go away. Note that I ran hackbench and don't notice
any performance issues with my patch itself per-se, however the
preemptoff tracer startup seems slow and I'm debugging that. If you have
a clue why this might be happening, please let me know.

Note that I skipped v3 because I used that number already for some
internal reviews of these patches. Also I changed the subject back to
RFC in light of the lockdep issues I fixed this time and added some more
folks for review. Thanks much for any review or testing.

[1] https://www.spinics.net/lists/kernel/msg2750826.html

Joel Fernandes (4):
  tracepoint: Add API to not do lockdep checks during RCU ops
  softirq: reorder trace_softirqs_on to prevent lockdep splat
  irqflags: Avoid unnecessary calls to trace_ if you can
  tracing: Centralize preemptirq tracepoints and unify their usage

 include/linux/ftrace.h            |  11 +-
 include/linux/irqflags.h          |  32 +++--
 include/linux/lockdep.h           |   8 +-
 include/linux/preempt.h           |   2 +-
 include/linux/tracepoint.h        |  32 ++++-
 include/trace/events/preemptirq.h |  23 ++--
 init/main.c                       |   5 +-
 kernel/locking/lockdep.c          |  35 ++---
 kernel/sched/core.c               |   2 +-
 kernel/softirq.c                  |   6 +-
 kernel/trace/Kconfig              |  22 +++-
 kernel/trace/Makefile             |   2 +-
 kernel/trace/trace_irqsoff.c      | 206 +++++++-----------------------
 kernel/trace/trace_preemptirq.c   |  73 +++++++++++
 14 files changed, 229 insertions(+), 230 deletions(-)
 create mode 100644 kernel/trace/trace_preemptirq.c

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zilstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Glexiner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Fenguang Wu <fengguang.wu@intel.com>
Cc: Baohong Liu <baohong.liu@intel.com>
Cc: Vedang Patel <vedang.patel@intel.com>
-- 
2.17.0.484.g0c8726318c-goog
