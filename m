Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeEABmV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 21:42:21 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44932 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbeEABmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 21:42:20 -0400
X-Google-Smtp-Source: AB8JxZozshnLXVlvE/tCtl7LwLkRbZVjf9lrLpsrYPH70WppeCx12cFhL0M2A6GD2Q+RgMRt33M9+g==
From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org
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
        Vedang Patel <vedang.patel@intel.com>, kernel-team@android.com
Subject: [PATCH RFC v5 0/6] Centralize and unify usage of preempt/irq tracepoints
Date: Mon, 30 Apr 2018 18:41:58 -0700
Message-Id: <20180501014204.67548-1-joelaf@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the next revision of preempt/irq tracepoint centralization and
unified usage across the kernel [1].
The preempt/irq tracepoints exist but not everything in the kernel is
using it. This makes things not work simultaneously (for ex, only either
lockdep or irqsoff events can be used at a time). This series is an attempt to
solve that, and also results in a nice clean up of kernel in general.
Several ifdefs are simpler, and the design is more unified and better.
Also as a result of this, we also speeded performance all rcuidle
tracepoints since their handling is simpler.

v5:
- Fixed performance issues due to rcu-idle handling

Joel Fernandes (5):
  softirq: reorder trace_softirqs_on to prevent lockdep splat
  srcu: Add notrace variant of srcu_dereference
  trace/irqsoff: Split reset into seperate functions
  tracepoint: Make rcuidle tracepoint callers use SRCU
  tracing: Centralize preemptirq tracepoints and unify their usage

Paul E. McKenney (1):
  srcu: Add notrace variants of srcu_read_{lock,unlock}

 include/linux/ftrace.h            |  11 +-
 include/linux/irqflags.h          |  11 +-
 include/linux/lockdep.h           |   8 +-
 include/linux/preempt.h           |   2 +-
 include/linux/srcu.h              |  22 +++
 include/linux/tracepoint.h        |  47 +++++-
 include/trace/events/preemptirq.h |  23 +--
 init/main.c                       |   5 +-
 kernel/locking/lockdep.c          |  35 ++---
 kernel/sched/core.c               |   2 +-
 kernel/softirq.c                  |   6 +-
 kernel/trace/Kconfig              |  22 ++-
 kernel/trace/Makefile             |   2 +-
 kernel/trace/trace_irqsoff.c      | 235 +++++++++---------------------
 kernel/trace/trace_preemptirq.c   |  71 +++++++++
 kernel/tracepoint.c               |  10 +-
 16 files changed, 283 insertions(+), 229 deletions(-)
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
Cc: kernel-team@android.com
Signed-off-by: Joel Fernandes <joelaf@google.com>
-- 
2.17.0.441.gb46fe60e1d-goog
