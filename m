Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52048C67790
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 02:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F7520873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 02:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCW/p7Yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F7520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389455AbeG1DrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 23:47:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389421AbeG1DrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 23:47:05 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C705A20862;
        Sat, 28 Jul 2018 02:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532744546;
        bh=L0YIVJZJop9/NDGsnlHoA0HnUq8hXUNd+PQTWpsrXVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aCW/p7YqFi1sEBZ6gv+BkXbmF3KjOdSAjQi+MaI+4QWZ4asDAQlmP0grRgQW7oMd1
         18mFoY18dDm5mw4RCvgjfHKfhYyoqa+8e4s5O5tZfuqkwDJ3EMhN6iGcwOJw+kvKf/
         ioNNhjSNxiOCEp/nVTxicMWTK1vzJeubF+h4remc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     rostedt@goodmis.org,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, Shuah Khan <shuah@kernel.org>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] selftest/ftrace: Move kprobe selftest function to separate compile unit
Date:   Sat, 28 Jul 2018 11:22:03 +0900
Message-Id: <153274452364.14940.1143014651562773078.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153274446603.14940.16028811307915635132.stgit@devbox>
References: <153274446603.14940.16028811307915635132.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francis Deslauriers <francis.deslauriers@efficios.com>

Move selftest function to its own compile unit so it can be compiled
with the ftrace cflags (CC_FLAGS_FTRACE) allowing it to be probed
during the ftrace startup tests.

Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/Makefile                |    5 +++++
 kernel/trace/trace_kprobe.c          |   12 +-----------
 kernel/trace/trace_kprobe_selftest.c |   10 ++++++++++
 kernel/trace/trace_kprobe_selftest.h |    7 +++++++
 4 files changed, 23 insertions(+), 11 deletions(-)
 create mode 100644 kernel/trace/trace_kprobe_selftest.c
 create mode 100644 kernel/trace/trace_kprobe_selftest.h

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index e2538c7638d4..e38771eccb2f 100644
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
index 2bf75af92f16..88b49396ba08 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -23,6 +23,7 @@
 #include <linux/rculist.h>
 #include <linux/error-injection.h>
 
+#include "trace_kprobe_selftest.h"
 #include "trace_probe.h"
 
 #define KPROBE_EVENT_SYSTEM "kprobes"
@@ -1578,17 +1579,6 @@ fs_initcall(init_kprobe_trace);
 
 
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
index 000000000000..16548ee4c8c6
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
index 000000000000..4e10ec41c013
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

