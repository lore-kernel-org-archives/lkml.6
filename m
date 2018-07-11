Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3801AC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE6B20C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="A0OO7qu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE6B20C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeGKGif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:38:35 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38014 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeGKGie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:38:34 -0400
Received: by mail-pf0-f196.google.com with SMTP id x13-v6so7813279pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 23:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h9BHHLcFiHHK/oG6pCAyoLzJSwyk13Cv3ua8XTMoqTA=;
        b=A0OO7qu7JAFZI3DWzJrgyX8EfAwiB/pehDifGl8Yx1pVh0whHd80jbn76DmIqNfcwD
         pYBI9HlunviXHCdAzdS62Oz+WOjUAbeGVqfY9gz/zJsyt1lbkpwunnmts2YtJWV0E8f1
         pzGzLLCrgzBwDHXTbmXptzsyNJXtW2rdV2c+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h9BHHLcFiHHK/oG6pCAyoLzJSwyk13Cv3ua8XTMoqTA=;
        b=HaU9Dr4yUecD6/pvK7BcJcs93ZQyqi1L7TobjZ1gyWIvAR5yKyGg+8VoztZdCyjnqM
         KShoWgpxQYT9+15WXQ2AMgEcZgwVK6Ad43DM9Ps/73hsEdubJ6iYg1VMn866eTCsYrLP
         wu5i+DuopaNyjndufo68u9XPpr7RZPiE7q40MTudG7Qt8Ftw5z51BtLazjT8y+qJHDUc
         XbzH271iP67QXuzy/trFvSjyiyhvmL4vgqmjLzVBTwAlJ3WBli79K2dmSVYMK4fb4Mij
         cAMpWvLgVI+YRaH+cxw7I2xHLXR3sqgTxIfHUKlHEIFlrfcXpz75R9sxpiN2YeFLLbyb
         KHRw==
X-Gm-Message-State: APt69E3lmF3HrQoQWbm6FQyzYdm3gONTK6333lX+BEKzCXb/tC9Mn5y+
        rDMKt73D3I2C4eZCsaVnagkZAlHEuX8=
X-Google-Smtp-Source: AAOMgpeHmykHZbAqB/BhKbaFpalylu7TX1qErhgDksDQIyBJ0pXVEbr1VGTAqB4qk14IPUqwCD5RmQ==
X-Received: by 2002:a62:d39b:: with SMTP id z27-v6mr29119432pfk.182.1531290951782;
        Tue, 10 Jul 2018 23:35:51 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id h190-v6sm24731891pge.85.2018.07.10.23.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 23:35:50 -0700 (PDT)
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
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 2/2] kselftests: Add tests for the preemptoff and irqsoff tracers
Date:   Tue, 10 Jul 2018 23:35:40 -0700
Message-Id: <20180711063540.91101-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180711063540.91101-1-joel@joelfernandes.org>
References: <20180711063540.91101-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Here we add unit tests for the preemptoff and irqsoff tracer by using a
kernel module introduced previously to trigger long preempt or irq
disabled sections in the kernel.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/ftrace/config         |  3 +
 .../test.d/preemptirq/irqsoff_tracer.tc       | 73 +++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc

diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index b01924c71c09..07db5ab09cc7 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -4,3 +4,6 @@ CONFIG_FUNCTION_PROFILER=y
 CONFIG_TRACER_SNAPSHOT=y
 CONFIG_STACK_TRACER=y
 CONFIG_HIST_TRIGGERS=y
+CONFIG_PREEMPT_TRACER=y
+CONFIG_IRQSOFF_TRACER=y
+CONFIG_PREEMPTIRQ_DELAY_TEST=m
diff --git a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
new file mode 100644
index 000000000000..cbd174334a48
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
@@ -0,0 +1,73 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: test for the preemptirqsoff tracer
+
+MOD=preemptirq_delay_test
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
+modprobe $MOD test_mode=preempt delay=500000 || fail
+rmmod $MOD || fail
+modprobe $MOD test_mode=preempt delay=500000 || fail
+rmmod $MOD || fail
+modprobe $MOD test_mode=preempt delay=500000 || fail
+rmmod $MOD || fail
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
+modprobe $MOD test_mode=irq delay=500000 || fail
+rmmod $MOD || fail
+modprobe $MOD test_mode=irq delay=500000 || fail
+rmmod $MOD || fail
+modprobe $MOD test_mode=irq delay=500000 || fail
+rmmod $MOD || fail
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
-- 
2.18.0.203.gfac676dfb9-goog

