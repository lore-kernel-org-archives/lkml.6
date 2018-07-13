Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAC2ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC5C2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="chCuB2Na"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC5C2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbeGMWMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 18:12:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33995 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeGMWMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 18:12:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so5397715pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 14:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MsX+HWIIPb1R7fqeX1mJgAQ0JMUrfG+DlEr7hwaNJbw=;
        b=chCuB2Na0FlTk3Za8BQ9JRsPvJyBJa5KhvGDVYlOkpfibNvHy4eCFc1PHaWnlIG/QC
         eBaLipTk5ByjoPOS9L0qN2Lq/2Kh3o6oDFfRKuG0HEil/1nJM9W91fcb95mKTRGHbYSt
         vUgbHOrBQLzPbc/3zodt9Leum2C/3IPPYmKOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MsX+HWIIPb1R7fqeX1mJgAQ0JMUrfG+DlEr7hwaNJbw=;
        b=jijGxLvfnzyF9b3QgfHvXBdlHMSpzPU1UZM9U1h9pHvFv5YaWj927J6p6ba+AVkB1C
         wES4GTnwFtxhNMlmMZELkCfvmna/UC5rrLv0H0jOqR2QZdPdaqss/rdHJO2Y0b8hsT52
         b7F2iM1eTb9y+mZx9UVjLrgTmAkWq9B0w5pq7faFv/PGqNcl6Y0aiLBJlBpVDYAc8bfs
         pQ7N9y7S7wwjTvjpYPRPn/G1rllyfMqpOXYm+m/50dwcmokZimI7zMuAulolh+MiF8hP
         aBPJRYnbqt1g9kQoNHdkMQUuyR3ZVrARJO32ZaNFJZlYaqsA6oyuBMjnCInxB4S6rzKv
         +xAA==
X-Gm-Message-State: AOUpUlHSHD9n1BxZ9qa/aiuIZAAoTX5xxIHHSJDESEHqKNnLCo/loDm+
        GHQcHJpsMGgNK1qzFrhptO0HIpALYHQ=
X-Google-Smtp-Source: AAOMgpeeYEcJtqld+HakU9zRfmxH2Yl1/zy2DUd7VbdHXT/I0DpOu8rGOsApmbt0EXd5JYThlbOa4A==
X-Received: by 2002:a62:fd06:: with SMTP id p6-v6mr8588265pfh.167.1531518954502;
        Fri, 13 Jul 2018 14:55:54 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id k4-v6sm35232990pgo.49.2018.07.13.14.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 14:55:53 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v10 0/3] tracing: Centralize preemptirq tracepoints and unify their usage
Date:   Fri, 13 Jul 2018 14:55:44 -0700
Message-Id: <20180713215547.255620-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This series contains the last 2 patches of the previous series, with
minor changes suggested by Peter and Steven, and an additional patch for
get_lock_stats cleanup suggested by Peter.

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
 include/linux/tracepoint.h        |  45 ++++--
 include/trace/events/preemptirq.h |  23 +--
 init/main.c                       |   5 +-
 kernel/locking/lockdep.c          |  45 ++----
 kernel/sched/core.c               |   2 +-
 kernel/trace/Kconfig              |  22 ++-
 kernel/trace/Makefile             |   2 +-
 kernel/trace/trace_irqsoff.c      | 231 ++++++++----------------------
 kernel/trace/trace_preemptirq.c   |  72 ++++++++++
 kernel/tracepoint.c               |  16 ++-
 14 files changed, 248 insertions(+), 247 deletions(-)
 create mode 100644 kernel/trace/trace_preemptirq.c

-- 
2.18.0.203.gfac676dfb9-goog
