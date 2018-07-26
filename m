Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5FBC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C3020857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OjkLULIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C3020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbeG0BKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 21:10:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39008 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731629AbeG0BKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 21:10:08 -0400
Received: by mail-pl0-f66.google.com with SMTP id m1-v6so1494408plt.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 16:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GvfrsfdXAkmeMkxmrY2UpBnQDemnLC7W3iDiMp5zPps=;
        b=OjkLULIUCxO6JRuVwjGyVJaWwztWFS504JPJSi2TNYzjnn8MZI8WY0U6BaQ/6G6Fim
         5sPUT5pxVO1ePOimuGRDxg/Jq9d0o23AGdF7dL5JIGrzjnOz1MULZ3eMMllOfbg3ZIVu
         9plcaSa4hvk+GNB4A4y8O5MwTO84x4ZfumkJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GvfrsfdXAkmeMkxmrY2UpBnQDemnLC7W3iDiMp5zPps=;
        b=JcsBUU8WFY3iFu7a7UD1LHmshau4EpiLz3gSfRAgPZAlVau2zZFx7/9DhtbLxXPXQ9
         8kvVs25xJYSQtguddWybdFchwk2CBJY15DNUD2vD42Kwzz0CjE4w2zsoMbxDPl56w27p
         ffjWRDFulOvTq1y/ZRPg038lSzSinG9415ozg1wu+Q6tlODmoy4QSb+cdv1MyAofqx6c
         abshkQfVTo8q9t+ho1jWs1ClhafJZI364ObyBHTiQ4ERPg5jQuHoryzW+eh2gNvhRcaE
         kYBcnyn+S4gmfaQ5nhM0qb2AcH6ueweaFeOnFH84iyVQPEA4HyK4YCVXIrjdsUiKyMgf
         9d9Q==
X-Gm-Message-State: AOUpUlHSVThj1A4lIEAHdWK97UKynpEiZ5S/B6INc7hCCo+NTqWsugC2
        kAvOOZ0xx1+ScjkUXzhSYFSkPT13Xrs=
X-Google-Smtp-Source: AAOMgpdSAZhVCLdGY61b/CHH0pp66BqVbqkt7eK1PdQoozu6QVEL4RwBhDR1sXvhHuaJ8/NyKrNmNg==
X-Received: by 2002:a17:902:209:: with SMTP id 9-v6mr3809795plc.270.1532649060879;
        Thu, 26 Jul 2018 16:51:00 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id t76-v6sm3818840pfe.109.2018.07.26.16.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 16:51:00 -0700 (PDT)
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
Subject: [PATCH v11 0/3] tracing: Centralize preemptirq tracepoints and unify their usage
Date:   Thu, 26 Jul 2018 16:50:41 -0700
Message-Id: <20180726235044.10195-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This series contains the last 2 patches with minor changes suggested by
Peter and Steven, and an additional clean up patch for get_lock_stats as
suggested by Peter.

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

v10->v11:
- Dropped extra unneeded else statement in tracepoint code since
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


