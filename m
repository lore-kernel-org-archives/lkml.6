Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932480AbeCOUoP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:44:15 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36226 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeCOUoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:44:13 -0400
X-Google-Smtp-Source: AG47ELtsQJuFEHb+5zH4fullBrDMmRCoE2UGpNPFM2tasHyCN95lPQMVErqdPT3B9yiKbjxb6OPZIA==
From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 0/2] Improve preemptirq tracepoint usage
Date: Thu, 15 Mar 2018 13:43:59 -0700
Message-Id: <20180315204401.68282-1-joelaf@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
These patches improve the design of preemptirq tracepoints, clean up
several of the ifdeffery and overall makes the feature configuration
cleaner and less confusing. It also uses the tracepoints infra for
the lockdep hooks for irqs on/off thus making a central point for all
users of the event (kernel/trace/trace_preemptirq.c).
Patches based on v4.16-rc5.

Changes since v1:
- Make PROVE_LOCKING depend on FTRACE since PROVE_LOCKING needs to
  register hooks in this series which needs PREEMPTIRQ_TRACEPOINTS.

Changes since RFC [1]:
- handle case where lockdep warnings occur in tracepoint code (2/2)
- protect tracepoint probe registration in lockdep init by ifdef.

Joel Fernandes (2):
  tracing: Improve design of preemptirq tracepoints and its users
  tracepoint: Prevent false-positive lockdep warnings

[1] https://patchwork.kernel.org/patch/10202163/

 include/linux/ftrace.h            |  11 +-
 include/linux/irqflags.h          |  11 +-
 include/linux/lockdep.h           |   6 +-
 include/linux/preempt.h           |   2 +-
 include/linux/tracepoint.h        |  23 +++-
 include/trace/events/preemptirq.h |  23 ++--
 init/main.c                       |   2 +-
 kernel/locking/lockdep.c          |  31 ++---
 kernel/sched/core.c               |   2 +-
 kernel/trace/Kconfig              |  19 ++-
 kernel/trace/Makefile             |   2 +-
 kernel/trace/trace_irqsoff.c      | 206 +++++++-----------------------
 kernel/trace/trace_preemptirq.c   |  70 ++++++++++
 lib/Kconfig.debug                 |   2 +-
 14 files changed, 192 insertions(+), 218 deletions(-)
 create mode 100644 kernel/trace/trace_preemptirq.c

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zilstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Joel Fernandes <joelaf@google.com>

-- 
2.16.2.804.g6dcf76e118-goog
