Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B30FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9C120894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiVkpRCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9C120894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeG3LzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbeG3LzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:55:23 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0CEA20881;
        Mon, 30 Jul 2018 10:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532946065;
        bh=kNL1QI/M8Ccqj69fzqYOby94ZMb9qB/qX/MuAny/HiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TiVkpRCKPb1DvfchrlBGUv2YlEKMK/L7/2D99V3F6fV1sCVicPKkZwnkPY0opcJzT
         fxs5REDttaqqSUyrpm4J97OXHyFTbkudh1bb7+0tP3qn0LGdKLpT5YIXO8QxSq/FSV
         P4HO1JH+gZe1Fw+unz/RVD1EH6Ltx77Y6STMQIN0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     rostedt@goodmis.org,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, Shuah Khan <shuah@kernel.org>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] selftest/ftrace: Move kprobe selftest function to separate compile unit
Date:   Mon, 30 Jul 2018 19:20:42 +0900
Message-Id: <153294604271.32740.16490677128630177030.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153294598465.32740.17737878083872427008.stgit@devbox>
References: <153294598465.32740.17737878083872427008.stgit@devbox>
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
index 10fdf1605e01..d314b843beca 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -23,6 +23,7 @@
 #include <linux/rculist.h>
 #include <linux/error-injection.h>
 
+#include "trace_kprobe_selftest.h"
 #include "trace_probe.h"
 
 #define KPROBE_EVENT_SYSTEM "kprobes"
@@ -1565,17 +1566,6 @@ fs_initcall(init_kprobe_trace);
 
 
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

