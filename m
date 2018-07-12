Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1871EA4F99
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F89C21471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="gNuF7tUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F89C21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeGLSFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:05:12 -0400
Received: from mail.efficios.com ([167.114.142.138]:55398 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeGLSFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:05:10 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 77560233C31;
        Thu, 12 Jul 2018 13:54:33 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id BQIBqTAz1bAQ; Thu, 12 Jul 2018 13:54:33 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 302F4233C2D;
        Thu, 12 Jul 2018 13:54:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 302F4233C2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1531418073;
        bh=iQEKUa+R2ouO896fhsniSMqxUXBRQ/tE0gbr8xXlCqw=;
        h=From:To:Date:Message-Id;
        b=gNuF7tUeG950gevnJnr9K2k2FacJncwv3MXEN04/b6pZ5Je6JgApgj1ToHESJCt60
         NffOflWdRLrCl3FPislj3mpFOIJCvAX8StKr3A/c/IgZSlZt936nTAZg9LdhBDc6rF
         AaM/3H2HCGYWfFeWo3/2vsdHGV9IuTs3pqDNlhbLLRiTjOA4nvbkKM7tZ9Pxz6Tto7
         Q3KYRa8HlOL2/OJTVcLPB2zPigBm9prX1jwhiIgVdVEtPEpepUZEZWOUkfuGngokZx
         pllXmKzUT8g2aUugcd5EcmtrKoXvn2S7+1+gG2qftTkpvgSprQe+qJCrRqy6CA+wZx
         mlarhFjuV572g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id jTHeqtS6gSxK; Thu, 12 Jul 2018 13:54:33 -0400 (EDT)
Received: from raton.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 6542E233C26;
        Thu, 12 Jul 2018 13:54:32 -0400 (EDT)
From:   Francis Deslauriers <francis.deslauriers@efficios.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org
Cc:     mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH 2/2] selftest/ftrace: Move kprobe selftest function to separate compile unit
Date:   Thu, 12 Jul 2018 13:54:13 -0400
Message-Id: <1531418053-21414-3-git-send-email-francis.deslauriers@efficios.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531418053-21414-1-git-send-email-francis.deslauriers@efficios.com>
References: <1500044315-9508-3-git-send-email-francis.deslauriers@efficios.com>
 <1531418053-21414-1-git-send-email-francis.deslauriers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move selftest function to its own compile unit so it can be compiled
with the ftrace cflags (CC_FLAGS_FTRACE) allowing it to be probed
during the ftrace startup tests.

Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/Makefile                |  5 +++++
 kernel/trace/trace_kprobe.c          | 12 +-----------
 kernel/trace/trace_kprobe_selftest.c | 10 ++++++++++
 kernel/trace/trace_kprobe_selftest.h |  7 +++++++
 4 files changed, 23 insertions(+), 11 deletions(-)
 create mode 100644 kernel/trace/trace_kprobe_selftest.c
 create mode 100644 kernel/trace/trace_kprobe_selftest.h

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index e2538c7..e38771e 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -13,6 +13,11 @@ obj-y += trace_selftest_dynamic.o
 endif
 endif
 
+ifdef CONFIG_FTRACE_STARTUP_TEST
+CFLAGS_trace_kprobe_selftest.o = $(CC_FLAGS_FTRACE)
+obj-$(CONFIG_KPROBE_EVENTS) += trace_kprobe_selftest.o
+endif
+
 # If unlikely tracing is enabled, do not trace these files
 ifdef CONFIG_TRACING_BRANCHES
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 952dc2a..d12be53 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -23,6 +23,7 @@
 #include <linux/rculist.h>
 #include <linux/error-injection.h>
 
+#include "trace_kprobe_selftest.h"
 #include "trace_probe.h"
 
 #define KPROBE_EVENT_SYSTEM "kprobes"
@@ -1560,17 +1561,6 @@ fs_initcall(init_kprobe_trace);
 
 
 #ifdef CONFIG_FTRACE_STARTUP_TEST
-/*
- * The "__used" keeps gcc from removing the function symbol
- * from the kallsyms table. 'noinline' makes sure that there
- * isn't an inlined version used by the test method below
- */
-static __used __init noinline int
-kprobe_trace_selftest_target(int a1, int a2, int a3, int a4, int a5, int a6)
-{
-	return a1 + a2 + a3 + a4 + a5 + a6;
-}
-
 static __init struct trace_event_file *
 find_trace_probe_file(struct trace_kprobe *tk, struct trace_array *tr)
 {
diff --git a/kernel/trace/trace_kprobe_selftest.c b/kernel/trace/trace_kprobe_selftest.c
new file mode 100644
index 0000000..16548ee
--- /dev/null
+++ b/kernel/trace/trace_kprobe_selftest.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Function used during the kprobe self test. This function is in a separate
+ * compile unit so it can be compile with CC_FLAGS_FTRACE to ensure that it
+ * can be probed by the selftests.
+ */
+int kprobe_trace_selftest_target(int a1, int a2, int a3, int a4, int a5, int a6)
+{
+	return a1 + a2 + a3 + a4 + a5 + a6;
+}
diff --git a/kernel/trace/trace_kprobe_selftest.h b/kernel/trace/trace_kprobe_selftest.h
new file mode 100644
index 0000000..4e10ec4
--- /dev/null
+++ b/kernel/trace/trace_kprobe_selftest.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Function used during the kprobe self test. This function is in a separate
+ * compile unit so it can be compile with CC_FLAGS_FTRACE to ensure that it
+ * can be probed by the selftests.
+ */
+int kprobe_trace_selftest_target(int a1, int a2, int a3, int a4, int a5, int a6);
-- 
2.7.4

