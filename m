Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4584BECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8F32089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxyXf7OW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8F32089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeKIHdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727633AbeKIHdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:05 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B76492089F;
        Thu,  8 Nov 2018 21:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714137;
        bh=nN28tH+xMkPbeOmvgjXHGvm/iXKM4O3VW9xeJ7DfTD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OxyXf7OWwtaL4GHUNO98YcL/49J0k5+7bc2cTBmMXX1NE4sIUzVqPXHCCEloOHOR4
         rkitpOlRLwUWAluwGdbavi77j7SEkRN3baXpK/UG/FjvqMgKV0lWwdNFJdweElaJ+R
         8REDe24bPLTJNw+PqRfdIwciTL7Vlk0MlWhQE9bQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 071/144] tracing: Fix enabling of syscall events on the command line
Date:   Thu,  8 Nov 2018 13:50:42 -0800
Message-Id: <20181108215100.235364805@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



