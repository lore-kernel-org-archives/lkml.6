Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FA9C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A3D27795
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YWuf6O75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A3D27795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967791AbeF1SWH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:22:07 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38561 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030465AbeF1SWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:22:05 -0400
Received: by mail-pl0-f65.google.com with SMTP id d10-v6so3159279plo.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gag227hePDfIGVTZWUYWhRUYWZH54U22ruXf0gi5J0k=;
        b=YWuf6O75iI3D5iHwrIMaghaxHacrqha8YhzwsMuX3hPez43UTaMjOoMtaXXPSpoJgv
         89FdckHQkBKpybim75/Sjg+D7y0+WaoFMBmN2HEy4h9VshMT9PLcSKax5LYtdQv9KEJ9
         FMJ4TiM+JaBq8EsRjvnI9oMBc5+oOY4Xwnjlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gag227hePDfIGVTZWUYWhRUYWZH54U22ruXf0gi5J0k=;
        b=cG30A0ao82joDFwuCuFG6dqZ9Iaq5raG34aLy8Khsq4hiUd5D6zr/mb/NpN/Ale1wP
         gCpIf6rTG6mYEZwpiLwWcoba3gYPPw5+cN3aKwKfHjoHB14uvjmdfwndMcCBf70eMOyD
         L2k0VM7ab8botd2yhOnL44dStU5tuDzoSdeTeKpXn3RI0DcZCDI1WAUeRYjjb1Io+Z7H
         VnMkkcgsp/JbKZDbrM698671HEy8ZsvjNEVBXwAEEMGrC1H1b/Db9YYCcY+M+JsHQDIV
         ms6B4ehdTNvNrD/tBFV9DfiEM12Dr88cQ3oyH7aaFAAbVAqNzLXqgEvmDuJdubc+zq/N
         ZgdQ==
X-Gm-Message-State: APt69E0l7xnwuSqXO5Y/1PN/m2ilEtbPq5p924z90yOEswq5v8Lw6FSJ
        u4X6sHhTlIkCimkWO4OdS8bI1N44Sgg=
X-Google-Smtp-Source: ADUXVKJJyUrRrca5tIM88ESxbjvrTee6MR0f8H7r/DebHgN/WbA5wpz0jpsgEeqHHjsDhL4h7Piiag==
X-Received: by 2002:a17:902:903:: with SMTP id 3-v6mr11440508plm.106.1530210124519;
        Thu, 28 Jun 2018 11:22:04 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id q10-v6sm13686027pfj.7.2018.06.28.11.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 11:22:03 -0700 (PDT)
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
Subject: [PATCH v9 7/7] kselftests: Add tests for the preemptoff and irqsoff tracers
Date:   Thu, 28 Jun 2018 11:21:49 -0700
Message-Id: <20180628182149.226164-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180628182149.226164-1-joel@joelfernandes.org>
References: <20180628182149.226164-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Here we add unit tests for the preemptoff and irqsoff tracer by using a
kernel module introduced previously to trigger atomic sections in the
kernel.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/ftrace/config         |  3 +
 .../test.d/preemptirq/irqsoff_tracer.tc       | 73 +++++++++++++++++++
 2 files changed, 76 insertions(+)
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
index 000000000000..1806d340035d
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
@@ -0,0 +1,73 @@
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
+modprobe $MOD atomic_mode=preempt atomic_time=500000 || fail
+rmmod $MOD || fail
+modprobe $MOD atomic_mode=preempt atomic_time=500000 || fail
+rmmod $MOD || fail
+modprobe $MOD atomic_mode=preempt atomic_time=500000 || fail
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
+modprobe $MOD atomic_mode=irq atomic_time=500000 || fail
+rmmod $MOD || fail
+modprobe $MOD atomic_mode=irq atomic_time=500000 || fail
+rmmod $MOD || fail
+modprobe $MOD atomic_mode=irq atomic_time=500000 || fail
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
2.18.0.rc2.346.g013aa6912e-goog

