Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809ACC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4A2224DE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="WZb3vteZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4A2224DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933993AbeFUWd5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:33:57 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33867 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933919AbeFUWdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:33:33 -0400
Received: by mail-pf0-f196.google.com with SMTP id a63-v6so2216863pfl.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 15:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kSp3IhH/4pAsfMRsnkVO9/5eYKfhA0t2sIhKV7K2vMs=;
        b=WZb3vteZr23rQGbirG5V7uodyLB3of6lr0daP1GGh17AFbEn4fz5sy4c46pc24FkUg
         PreNjXD+K9Tf65nSN1fD2YgesOx3h9WE2NDd2ouzlRih42AelLLkLkaDHNlCuP0zKbSS
         +c176CIVT/nkXgDH1uB2kEO45zrNYg9BHcC5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kSp3IhH/4pAsfMRsnkVO9/5eYKfhA0t2sIhKV7K2vMs=;
        b=sXgWm+p5JtPXdxbb44vOQyGLA7TXCTFz4Rhb5iQxWBcyVLjFZ8IUa8aVazPcH2OELS
         i8y9xFm3j0YjknXY+JHWk3C/WcmWQjStIzvb0h/KcJuz75EKW6BpjYE/Sv/3yuBptcA9
         R20Nyj8hCzF7oV1eJdbiYN7InN7WPAUfXAlQzzKURhmCaaUaWlylmEW5ycPE2xs2mU5s
         NBBbCyjpP8L7WUU3FvITLL0UVzr1wJNVH80HiOIYcGA210DU5Nci6j5wFKnD8V0jDMBF
         OUGyHygE/nyfoPuYT9poOIhcbj7pfTO41l6prAINkJOSThAKred0CwaFjB7haUj/6Op1
         AjGg==
X-Gm-Message-State: APt69E3lkhK6VOKhLCNvrwRbi1b/AdXJZHPaGpRiqd4GHB4a9yho0YrC
        PB9HLZD68t5hKxCk6RYYLMNSwfPOIaU=
X-Google-Smtp-Source: ADUXVKLAPm7rm7KbKCrgOlQHjENB7/4KMuc6b3gVFOhocdiPBIGnMlhj5d3ypjwpApDpuYGpaNJKew==
X-Received: by 2002:a63:86c8:: with SMTP id x191-v6mr23553218pgd.2.1529620413092;
        Thu, 21 Jun 2018 15:33:33 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id x19-v6sm11060824pfi.5.2018.06.21.15.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 15:33:32 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v9 7/7] kselftests: Add tests for the preemptoff and irqsoff tracers
Date:   Thu, 21 Jun 2018 15:32:36 -0700
Message-Id: <20180621223236.211495-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180621223236.211495-1-joel@joelfernandes.org>
References: <20180621223236.211495-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Here we add unit tests for the preemptoff and irqsoff tracer by using a
kernel module introduced previously to trigger atomic sections in the
kernel.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/ftrace/config         |  3 +
 .../test.d/preemptirq/irqsoff_tracer.tc       | 74 +++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc

diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index b01924c71c09..29588b328345 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -4,3 +4,6 @@ CONFIG_FUNCTION_PROFILER=y
 CONFIG_TRACER_SNAPSHOT=y
 CONFIG_STACK_TRACER=y
 CONFIG_HIST_TRIGGERS=y
+CONFIG_PREEMPT_TRACER=y
+CONFIG_IRQSOFF_TRACER=y
+CONFIG_TEST_ATOMIC_SECTIONS=m
diff --git a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
new file mode 100644
index 000000000000..1764ff22c02b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
@@ -0,0 +1,74 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: test for the preemptirqsoff tracer
+
+MOD=test_atomic_sections
+
+fail() {
+    reset_tracer
+    rmmod $MOD || true
+    exit_fail
+}
+
+unsup() { #msg
+    reset_tracer
+    rmmod $MOD || true
+    echo $1
+    exit_unsupported
+}
+
+modprobe $MOD || unsup "$MOD module not available"
+rmmod $MOD
+
+grep -q "preemptoff" available_tracers || unsup "preemptoff tracer not enabled"
+grep -q "irqsoff" available_tracers || unsup "irqsoff tracer not enabled"
+
+reset_tracer
+
+# Simulate preemptoff section for half a second couple of times
+echo preemptoff > current_tracer
+sleep 1
+modprobe test_atomic_sections atomic_mode=preempt atomic_time=500000 || fail
+rmmod test_atomic_sections || fail
+modprobe test_atomic_sections atomic_mode=preempt atomic_time=500000 || fail
+rmmod test_atomic_sections || fail
+modprobe test_atomic_sections atomic_mode=preempt atomic_time=500000 || fail
+rmmod test_atomic_sections || fail
+
+cat trace
+
+# Confirm which tracer
+grep -q "tracer: preemptoff" trace || fail
+
+# Check the end of the section
+egrep -q "5.....us : <stack trace>" trace || fail
+
+# Check for 500ms of latency
+egrep -q "latency: 5..... us" trace || fail
+
+reset_tracer
+
+# Simulate irqsoff section for half a second couple of times
+echo irqsoff > current_tracer
+sleep 1
+modprobe test_atomic_sections atomic_mode=irq atomic_time=500000 || fail
+rmmod test_atomic_sections || fail
+modprobe test_atomic_sections atomic_mode=irq atomic_time=500000 || fail
+rmmod test_atomic_sections || fail
+modprobe test_atomic_sections atomic_mode=irq atomic_time=500000 || fail
+rmmod test_atomic_sections || fail
+
+cat trace
+
+# Confirm which tracer
+grep -q "tracer: irqsoff" trace || fail
+
+# Check the end of the section
+egrep -q "5.....us : <stack trace>" trace || fail
+
+# Check for 500ms of latency
+egrep -q "latency: 5..... us" trace || fail
+
+reset_tracer
+exit 0
+
-- 
2.18.0.rc2.346.g013aa6912e-goog

