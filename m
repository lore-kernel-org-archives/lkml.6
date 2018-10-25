Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA34ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A8020873
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZuFlNqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A8020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbeJYWw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730693AbeJYWwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:54 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C06F2085B;
        Thu, 25 Oct 2018 14:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477196;
        bh=mc5sAZh2dZ39zYMDPO+bEe+o2jmvrArx7+M2pTI7+q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZuFlNqmEP2npLOCkaUMeNIT1Fkq9kVVU56kheBdqvRmXX1TUcqkVa4a7/o8r3DjH
         hr+gO64uMRP1A558nZzrl6qV85GvnmVoH21umVy1caCCDnZpkoAdgo0YFowzf+j/e7
         1w1VoFnA5segBXt+u0sKdU9b/vacYL8RJnRWdcAI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 42/98] tracing: Fix enabling of syscall events on the command line
Date:   Thu, 25 Oct 2018 10:17:57 -0400
Message-Id: <20181025141853.214051-42-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

[ Upstream commit ce1039bd3a89e99e4f624e75fb1777fc92d76eb3 ]

Commit 5f893b2639b2 "tracing: Move enabling tracepoints to just after
rcu_init()" broke the enabling of system call events from the command
line. The reason was that the enabling of command line trace events
was moved before PID 1 started, and the syscall tracepoints require
that all tasks have the TIF_SYSCALL_TRACEPOINT flag set. But the
swapper task (pid 0) is not part of that. Since the swapper task is the
only task that is running at this early in boot, no task gets the
flag set, and the tracepoint never gets reached.

Instead of setting the swapper task flag (there should be no reason to
do that), re-enabled trace events again after the init thread (PID 1)
has been started. It requires disabling all command line events and
re-enabling them, as just enabling them again will not reset the logic
to set the TIF_SYSCALL_TRACEPOINT flag, as the syscall tracepoint will
be fooled into thinking that it was already set, and wont try setting
it again. For this reason, we must first disable it and re-enable it.

Link: http://lkml.kernel.org/r/1421188517-18312-1-git-send-email-mpe@ellerman.id.au
Link: http://lkml.kernel.org/r/20150115040506.216066449@goodmis.org

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events.c | 69 +++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 51c47bc832d4..edf6ab4d8650 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2400,12 +2400,39 @@ static __init int event_trace_memsetup(void)
 	return 0;
 }
 
+static __init void
+early_enable_events(struct trace_array *tr, bool disable_first)
+{
+	char *buf = bootup_event_buf;
+	char *token;
+	int ret;
+
+	while (true) {
+		token = strsep(&buf, ",");
+
+		if (!token)
+			break;
+		if (!*token)
+			continue;
+
+		/* Restarting syscalls requires that we stop them first */
+		if (disable_first)
+			ftrace_set_clr_event(tr, token, 0);
+
+		ret = ftrace_set_clr_event(tr, token, 1);
+		if (ret)
+			pr_warn("Failed to enable trace event: %s\n", token);
+
+		/* Put back the comma to allow this to be called again */
+		if (buf)
+			*(buf - 1) = ',';
+	}
+}
+
 static __init int event_trace_enable(void)
 {
 	struct trace_array *tr = top_trace_array();
 	struct ftrace_event_call **iter, *call;
-	char *buf = bootup_event_buf;
-	char *token;
 	int ret;
 
 	if (!tr)
@@ -2427,18 +2454,7 @@ static __init int event_trace_enable(void)
 	 */
 	__trace_early_add_events(tr);
 
-	while (true) {
-		token = strsep(&buf, ",");
-
-		if (!token)
-			break;
-		if (!*token)
-			continue;
-
-		ret = ftrace_set_clr_event(tr, token, 1);
-		if (ret)
-			pr_warn("Failed to enable trace event: %s\n", token);
-	}
+	early_enable_events(tr, false);
 
 	trace_printk_start_comm();
 
@@ -2449,6 +2465,31 @@ static __init int event_trace_enable(void)
 	return 0;
 }
 
+/*
+ * event_trace_enable() is called from trace_event_init() first to
+ * initialize events and perhaps start any events that are on the
+ * command line. Unfortunately, there are some events that will not
+ * start this early, like the system call tracepoints that need
+ * to set the TIF_SYSCALL_TRACEPOINT flag of pid 1. But event_trace_enable()
+ * is called before pid 1 starts, and this flag is never set, making
+ * the syscall tracepoint never get reached, but the event is enabled
+ * regardless (and not doing anything).
+ */
+static __init int event_trace_enable_again(void)
+{
+	struct trace_array *tr;
+
+	tr = top_trace_array();
+	if (!tr)
+		return -ENODEV;
+
+	early_enable_events(tr, true);
+
+	return 0;
+}
+
+early_initcall(event_trace_enable_again);
+
 static __init int event_trace_init(void)
 {
 	struct trace_array *tr;
-- 
2.17.1

