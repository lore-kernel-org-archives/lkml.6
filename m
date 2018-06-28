Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC29C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F51924A22
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="USCUEO+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F51924A22
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030407AbeF1SVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:21:32 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43395 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965457AbeF1SVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:21:30 -0400
Received: by mail-pf0-f193.google.com with SMTP id y8-v6so2977379pfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Zaejbqw1osbMk8CgEOkUED5o4cXLwmE8ecrw4BOhdfc=;
        b=USCUEO+IW5TIpqFLzi1dXqNTPDby9s4bUvOv+9VcVWgePbFA4EdT+yz0Q9fNTcKkqv
         WQdI8jSKLWAOuLbaj6rZv6T+EY2xOSRU/OHrfnlG+eGVaWFgXxSg/+NEduIyV/8KFOxJ
         emeyqv7GRQhSN7ZEPVxW2qV2kpb7PyxVEajdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Zaejbqw1osbMk8CgEOkUED5o4cXLwmE8ecrw4BOhdfc=;
        b=pHGmIFPPI3o43JUGWOcW1sNTy3dod4O10rFKHWEa11NtCe7Gq3jSWiLO8/+mpmYMPw
         ibUYrZKlwUOZ18EJ6SqhGp0bGL85ICQuKAI01DjXF6iWJtm5TG9EueL1bpqQu51co9oq
         sxG3g2Cv20ZK0r2WnHcpd7cxkerBDRKadLkNxbuA2TcojyfxdLnz8ZrlE5P1zDUA9stv
         3YQRWzUm/33xh6+guUjF6o/ieKEqvPVix3SWEiWK/Tr9V2SMkydkW1SmP+oegqN/yFiz
         KUlTwO/iv7GNr2eKJM1cQPPaBQ2Q5rqu1TJ1U6dchrfcSSS6E78sN+zlz2aqyMK54dW+
         ZEcA==
X-Gm-Message-State: APt69E0L/+B5plFh1WLw7GUPv43bDrfvIpQoEDK5M6UzuXCcd1Y5gxyl
        8nyPcVSVAvwibsFypSik+klPnvhsRWA=
X-Google-Smtp-Source: AAOMgpd2UShAqrmcez6v5c2bNn5lOjJl789S6XznHZLc4YOTqAsTEI13qbqXY/2q4XX/Nq2h1MlnTQ==
X-Received: by 2002:a62:4015:: with SMTP id n21-v6mr11172194pfa.198.1530210089534;
        Thu, 28 Jun 2018 11:21:29 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id o4-v6sm16055767pfa.128.2018.06.28.11.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 11:21:28 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v9 0/7] Centralize and unify usage of preempt/irq tracepoints
Date:   Thu, 28 Jun 2018 11:21:12 -0700
Message-Id: <20180628182119.226030-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This is a posting of v9 preempt/irq tracepoint clean up series rebased
onto v4.18-rc2. No changes in the series, just a rebase + repost.

All patches have a Reviewed-by tags now from reviewers. This series has
been well tested and is a simplification/refactoring of existing code,
along with giving a speed-up for tracepoints using the rcu-idle API.
With this our users will find it easier to use tools depending on
existing preempt tracepoints since it simplifies the configuration for
them.

Future enhancements/fixes I am developing for preempt-off tracer will
depend on these patches, so I suggest prioritizing these well reviewed
and tested patches for that reason as well.

Introduction to the series:
The preempt/irq tracepoints exist but not everything in the kernel is using it
whenever they need to be notified that a preempt disable/enable or an irq
disable/enable has occurred.  This makes things not work simultaneously (for
example, only either lockdep or irqsoff trace-events can be used at a time).

This is particularly painful to deal with, since turning on lockdep breaks
tracers that install probes on IRQ events, such as the BCC atomic critical
section tracer [1]. This constraint also makes it impossible to use synthetic
events to trace irqsoff sections with lockdep simulataneously turned on.

This series solves that, and also results in a nice clean up of relevant parts
of the kernel. Several ifdefs are simpler, and the design is more unified and
better. Also as a result of this, we also speeded performance all rcuidle
tracepoints since their handling is simpler.

[1] https://github.com/iovisor/bcc/blob/master/tools/criticalstat_example.txt

v8->v9:
- Small style changes to tracepoint code (Mathieu)
- Minor style fix to use PTR_ERR_OR_ZERO (0-day bot)
- Minor fix to test_atomic_sections to use unsigned long.
- Added Namhyung's, Mathieu's Reviewed-by to some patches.
- Added Acks from Matsami

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


Joel Fernandes (Google) (6):
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
 include/linux/tracepoint.h                    |  49 +++-
 include/trace/events/preemptirq.h             |  23 +-
 init/main.c                                   |   5 +-
 kernel/locking/lockdep.c                      |  35 +--
 kernel/sched/core.c                           |   2 +-
 kernel/trace/Kconfig                          |  22 +-
 kernel/trace/Makefile                         |   2 +-
 kernel/trace/trace_irqsoff.c                  | 253 ++++++------------
 kernel/trace/trace_preemptirq.c               |  71 +++++
 kernel/tracepoint.c                           |  16 +-
 lib/Kconfig.debug                             |   8 +
 lib/Makefile                                  |   1 +
 lib/test_atomic_sections.c                    |  77 ++++++
 tools/testing/selftests/ftrace/config         |   3 +
 .../test.d/preemptirq/irqsoff_tracer.tc       |  73 +++++
 20 files changed, 453 insertions(+), 241 deletions(-)
 create mode 100644 kernel/trace/trace_preemptirq.c
 create mode 100644 lib/test_atomic_sections.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc

-- 
2.18.0.rc2.346.g013aa6912e-goog


