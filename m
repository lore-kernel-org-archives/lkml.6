Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935380AbeEXBW3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 21:22:29 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33753 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935324AbeEXBW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 21:22:27 -0400
X-Google-Smtp-Source: AB8JxZoCDKQy3Gz0iwgLiM3hldB+66wZBJ6p2mDAF/LLGGT0UOWOYiAFEW/gTpQIT5A3jc7b2LIk0g==
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>, Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>, linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>, Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v7 0/8] Centralize and unify usage of preempt/irq tracepoints
Date: Wed, 23 May 2018 18:21:49 -0700
Message-Id: <20180524012157.181277-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This is the next revision of preempt/irq tracepoint centralization and
unified usage across the kernel.
The preempt/irq tracepoints exist but not everything in the kernel is
using it. This makes things not work simultaneously (for ex, only either
lockdep or irqsoff events can be used at a time). This series is an attempt to
solve that, and also results in a nice clean up of kernel in general.
Several ifdefs are simpler, and the design is more unified and better.
Also as a result of this, we also speeded performance all rcuidle
tracepoints since their handling is simpler.

Few changes since v6:
- Added a module to simulate an atomic section, a kselftest to load and
  and trigger it which verifies the preempt-tracer and this series.

- there is a new warning after I rebased in early boot, this is because
early_boot_irqs_disabled was set too early, I moved it after the lockdep
initialization.

- added back the softirq fix since it appears it wasn't picked up.

- Ran Ingo's locking API selftest suite which are passing with this
  series.

- Mathieu suggested ifdef'ing the tracepoint_synchronize_unregister
  function incase tracepoints aren't enabled, did that.


Joel Fernandes (Google) (7):
  softirq: reorder trace_softirqs_on to prevent lockdep splat
  srcu: Add notrace variant of srcu_dereference
  trace/irqsoff: Split reset into separate functions
  tracepoint: Make rcuidle tracepoint callers use SRCU
  tracing: Centralize preemptirq tracepoints and unify their usage
  lib: Add module to simulate atomic sections for testing preemptoff
    tracers
  kselftests: Add tests for the preemptoff and irqsoff tracers

Paul McKenney (1):
  srcu: Add notrace variants of srcu_read_{lock,unlock}

 include/linux/ftrace.h                        |  11 +-
 include/linux/irqflags.h                      |  11 +-
 include/linux/lockdep.h                       |   8 +-
 include/linux/preempt.h                       |   2 +-
 include/linux/srcu.h                          |  22 ++
 include/linux/tracepoint.h                    |  48 +++-
 include/trace/events/preemptirq.h             |  23 +-
 init/main.c                                   |   5 +-
 kernel/locking/lockdep.c                      |  35 ++-
 kernel/sched/core.c                           |   2 +-
 kernel/softirq.c                              |   6 +-
 kernel/trace/Kconfig                          |  22 +-
 kernel/trace/Makefile                         |   2 +-
 kernel/trace/trace_irqsoff.c                  | 235 ++++++------------
 kernel/trace/trace_preemptirq.c               |  71 ++++++
 kernel/tracepoint.c                           |  15 +-
 lib/Kconfig.debug                             |   8 +
 lib/Makefile                                  |   1 +
 lib/test_atomic_sections.c                    |  79 ++++++
 tools/testing/selftests/ftrace/config         |   3 +
 .../test.d/preemptirq/irqsoff_tracer.tc       |  74 ++++++
 21 files changed, 454 insertions(+), 229 deletions(-)
 create mode 100644 kernel/trace/trace_preemptirq.c
 create mode 100644 lib/test_atomic_sections.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc

-- 
2.17.0.441.gb46fe60e1d-goog
