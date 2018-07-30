Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2423AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC85020857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lbIckyNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC85020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbeGaABr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:01:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38732 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeGaABr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:01:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3-v6so7989130pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kTtW2iYbtXb0v2nTHJapmA2cohlt/lwBWUW52hHpp94=;
        b=lbIckyNB0+ebexYhgZTZLXRAn6JX5AFuBpFUEHiQNZTUacOxUW1t3j1N1BJcfpi+HO
         1EJyCePG9MyxHlLLkwSEQ7ewiCtkUFOOh6X5TZ3gW9htwL0VFNSN7GykiDWcm2yArjzK
         f+/dsqbYpmpjg6Nw81Ni61L/S0C41/mvNQdVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kTtW2iYbtXb0v2nTHJapmA2cohlt/lwBWUW52hHpp94=;
        b=JAUnPdgXIiytcMJ2vkJ3xyc+zzSvdKeh1FHnZqTyugrKsqFzSEIKe4T0NhTbEUCbWc
         fDtkWp4cmdPYjOWltGkAwPqPp9XaYSF2ojMmRPx5meZAfa3V0XCzq4FXrJoypxJ2w534
         MJwHJ5eWOffJFEyNaypkuEa0lMAn6VS3CN4DB+REW6FrAbVlwj/cx3V+XpS7VO4kFBXg
         VWTtD+DQtm0aVGuW4epQ/mgOsBXLHEZDGWnT6AmpGBEkw7xkX9n2bGuFkEXmsbM4jjYc
         ZwYrs4Cx7mWR9DYhbkRdEkAZwma0O9H85wp1FN7fB5VMT3QV+LBnsF+0f56eihlRHYvi
         kI0Q==
X-Gm-Message-State: AOUpUlFPI3enQ2RbadA0xKkRao2XVqEN/KqvCmAlltPM6ol+x/b+iq0B
        KK6g3UoF3EJlLJ9yvoMicW+p5CWebO0=
X-Google-Smtp-Source: AAOMgpcMXulFTw18JMdoaL9dnvymr3Z6wo2ouuXnTasWbw87C+ysAcisd6Ing31AAHm4Ybi08zKfzw==
X-Received: by 2002:a63:b213:: with SMTP id x19-v6mr17834923pge.393.1532989481418;
        Mon, 30 Jul 2018 15:24:41 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id t21-v6sm21183914pfi.73.2018.07.30.15.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 15:24:40 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v12 0/3] tracing: Centralize preemptirq tracepoints and unify their usage
Date:   Mon, 30 Jul 2018 15:24:20 -0700
Message-Id: <20180730222423.196630-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This series contains the last 2 patches with minor changes suggested by Peter
and Steven, and an additional clean up of get_lock_stats as suggested by Peter.

The preempt/irq tracepoints exist but not everything in the kernel is using it
whenever they need to be notified that a preempt disable/enable or an irq
disable/enable has occurred.  This makes things not work simultaneously (for
example, only either lockdep or irqsoff trace-events can be used at a time).

This is particularly painful to deal with, since turning on lockdep breaks
tracers that install probes on IRQ events, such as the BCC atomic critical
section tracer [1]. This constraint also makes it not possible to use synthetic
events to trace irqsoff sections with lockdep simulataneously turned on.

This series solves that, and also results in a nice clean up of relevant parts
of the kernel. Several ifdefs are simpler, and the design is more unified and
better. Also as a result of this, we also speeded performance all rcuidle
tracepoints since their handling is simpler.

[1] https://github.com/iovisor/bcc/pull/1801/

v11->v12:
- minor corrections to changelog 
- Added PeterZ's Acks
- Squashed in fix for get_lock_stats

v10->v11:
- Dropped extra unneeded else statement since
  rcu_read_lock_sched_notrace is same as prempt_disable_notrace (PeterZ)

v9->v10:
- Dropped first 3 and last 2 patches that were applied previously
- Folded SPDK license into the main patch introducing trace_preemptirq.c (Steve)
- Dropped lockdep_recursing & use simplify get_cpu_var instead (PeterZ)
- Simplify __DO_TRACE and use rcu_dereference_raw for both RCU and SRCU (PeterZ)

v8->v9:
- Small style changes to tracepoint code (Mathieu)
- Minor style fix to use PTR_ERR_OR_ZERO (0-day bot)
- Minor fix to test_atomic_sections to use unsigned long.
- Added Namhyung's, Mathieu's Reviewed-by to some patches.

v7->v8:
- Refactored irqsoff tracer probe defines (Namhyung)

v6->v7:
- Added a module to simulate an atomic section, a kselftest to load and
  and trigger it which verifies the preempt-tracer and this series.

- Fixed a new warning after I rebased in early boot, this is because
early_boot_irqs_disabled was set too early, I moved it after the lockdep
initialization.

- added back the softirq fix since it appears it wasn't picked up.

- Ran Ingo's locking API selftest suite which are passing with this
  series.

- Mathieu suggested ifdef'ing the tracepoint_synchronize_unregister
  function incase tracepoints aren't enabled, did that.

Joel Fernandes (Google) (3):
  lockdep: use this_cpu_ptr instead of get_cpu_var stats
  tracepoint: Make rcuidle tracepoint callers use SRCU
  tracing: Centralize preemptirq tracepoints and unify their usage

 include/linux/ftrace.h            |  11 +-
 include/linux/irqflags.h          |  11 +-
 include/linux/lockdep.h           |   8 +-
 include/linux/preempt.h           |   2 +-
 include/linux/tracepoint.h        |  41 ++++--
 include/trace/events/preemptirq.h |  23 +--
 init/main.c                       |   5 +-
 kernel/locking/lockdep.c          |  45 ++----
 kernel/sched/core.c               |   2 +-
 kernel/trace/Kconfig              |  22 ++-
 kernel/trace/Makefile             |   2 +-
 kernel/trace/trace_irqsoff.c      | 231 ++++++++----------------------
 kernel/trace/trace_preemptirq.c   |  72 ++++++++++
 kernel/tracepoint.c               |  16 ++-
 14 files changed, 244 insertions(+), 247 deletions(-)
 create mode 100644 kernel/trace/trace_preemptirq.c

-- 
2.18.0.345.g5c9ce644c3-goog
