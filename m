Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEF6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A5321708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhU6Y826"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A5321708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeI0WUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727338AbeI0WUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:20:14 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B23F3216FE;
        Thu, 27 Sep 2018 16:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538064078;
        bh=SDcAkjDiR4l8aW7bEvqxxlJseGTrxVERBTnk5CANJCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhU6Y826ib0Ggk/9w75m0R6biLwCZsrK79bgP079gfQS7Git6gS53/qpYbZiLkngI
         eWdbhSw6nHpLou6F3KbkP0fzGcfQfzzipdQtTazZLxKd3Embds6huQVu3syCxAMHlL
         Ce+BgUMlI/FNpBexCO42w2WUJf42aYcBfU+z02PI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [RFC PATCH 5/5] tracing: Add generic event-name based remove event method
Date:   Fri, 28 Sep 2018 01:00:55 +0900
Message-Id: <153806405572.18458.2822431046720480096.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153806391326.18458.3927382953014694981.stgit@devbox>
References: <153806391326.18458.3927382953014694981.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic method to remove event from dynamic event
list. This is same as other system under ftrace. You
just need to pass the event name with '!' prefix, e.g.

  # echo p:new_grp/new_event _do_fork > dynamic_events

  This creates an event, and

  # echo '!new_grp/new_event' > dynamic_events

  Or,

  # echo '!new_event' > dynamic_events

  will remove new_grp/new_event event.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_dynevent.c |   36 +++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_dynevent.h |    2 ++
 kernel/trace/trace_kprobe.c   |   12 ++++++++++++
 kernel/trace/trace_uprobe.c   |   12 ++++++++++++
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index c829742cfe5d..c33551ad0b15 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -19,7 +19,8 @@ static LIST_HEAD(dyn_event_ops_list);
 
 int dyn_event_register(struct dyn_event_operations *ops)
 {
-	if (!ops || !ops->create || !ops->show || !ops->is_busy || !ops->free)
+	if (!ops || !ops->create || !ops->show || !ops->is_busy ||
+	    !ops->free || !ops->match)
 		return -EINVAL;
 
 	INIT_LIST_HEAD(&ops->list);
@@ -29,11 +30,19 @@ int dyn_event_register(struct dyn_event_operations *ops)
 	return 0;
 }
 
+static int delete_dyn_event(int argc, char **argv);
+
 static int create_dyn_event(int argc, char **argv)
 {
 	struct dyn_event_operations *ops;
 	int ret;
 
+	if (argc == 0)
+		return 0;
+
+	if (argv[0][0] == '!')
+		return delete_dyn_event(argc, argv);
+
 	mutex_lock(&dyn_event_ops_mutex);
 	list_for_each_entry(ops, &dyn_event_ops_list, list) {
 		ret = ops->create(argc, argv);
@@ -80,6 +89,31 @@ static const struct seq_operations dyn_event_seq_op = {
 	.show	= dyn_event_seq_show
 };
 
+static int delete_dyn_event(int argc, char **argv)
+{
+	struct dyn_event *pos, *n;
+	char *system = NULL, *event, *p;
+	int ret = -ENOENT;
+
+	event = &argv[0][1];
+	p = strchr(event, '/');
+	if (p) {
+		system = event;
+		event = p + 1;
+		*p = '\0';
+	}
+	mutex_lock(&dyn_event_mutex);
+	for_each_dyn_event_safe(pos, n) {
+		if (pos->ops->match(system, event, pos)) {
+			ret = pos->ops->free(pos);
+			break;
+		}
+	}
+	mutex_unlock(&dyn_event_mutex);
+
+	return ret;
+}
+
 static int release_all_dyn_events(void)
 {
 	struct dyn_event *ev, *tmp;
diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
index 96cf9ca7adb9..705c95b435a3 100644
--- a/kernel/trace/trace_dynevent.h
+++ b/kernel/trace/trace_dynevent.h
@@ -20,6 +20,8 @@ struct dyn_event_operations {
 	int (*show)(struct seq_file *m, struct dyn_event *ev);
 	bool (*is_busy)(struct dyn_event *ev);
 	int (*free)(struct dyn_event *ev);
+	bool (*match)(const char *system, const char *event,
+		      struct dyn_event *ev);
 };
 
 /* Register new dyn_event type -- must be called at first */
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 421b9d71fedf..b1602f3584d5 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -23,12 +23,15 @@ static int trace_kprobe_create(int argc, char **argv);
 static int trace_kprobe_show(struct seq_file *m, struct dyn_event *ev);
 static int trace_kprobe_release(struct dyn_event *ev);
 static bool trace_kprobe_is_busy(struct dyn_event *ev);
+static bool trace_kprobe_match(const char *system, const char *event,
+			       struct dyn_event *ev);
 
 static struct dyn_event_operations trace_kprobe_ops = {
 	.create = trace_kprobe_create,
 	.show = trace_kprobe_show,
 	.is_busy = trace_kprobe_is_busy,
 	.free = trace_kprobe_release,
+	.match = trace_kprobe_match,
 };
 
 /**
@@ -115,6 +118,15 @@ static bool trace_kprobe_is_busy(struct dyn_event *ev)
 	return trace_probe_is_enabled(&tk->tp);
 }
 
+static bool trace_kprobe_match(const char *system, const char *event,
+			       struct dyn_event *ev)
+{
+	struct trace_kprobe *tk = to_trace_kprobe(ev);
+
+	return strcmp(trace_event_name(&tk->tp.call), event) == 0 &&
+	    (!system || strcmp(tk->tp.call.class->system, system) == 0);
+}
+
 static nokprobe_inline unsigned long trace_kprobe_nhit(struct trace_kprobe *tk)
 {
 	unsigned long nhit = 0;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 90d10ef02f6b..7c15e22098af 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -41,12 +41,15 @@ static int trace_uprobe_create(int argc, char **argv);
 static int trace_uprobe_show(struct seq_file *m, struct dyn_event *ev);
 static int trace_uprobe_release(struct dyn_event *ev);
 static bool trace_uprobe_is_busy(struct dyn_event *ev);
+static bool trace_uprobe_match(const char *system, const char *event,
+			       struct dyn_event *ev);
 
 static struct dyn_event_operations trace_uprobe_ops = {
 	.create = trace_uprobe_create,
 	.show = trace_uprobe_show,
 	.is_busy = trace_uprobe_is_busy,
 	.free = trace_uprobe_release,
+	.match = trace_uprobe_match,
 };
 
 /*
@@ -276,6 +279,15 @@ static bool trace_uprobe_is_busy(struct dyn_event *ev)
 	return trace_probe_is_enabled(&tu->tp);
 }
 
+static bool trace_uprobe_match(const char *system, const char *event,
+			       struct dyn_event *ev)
+{
+	struct trace_uprobe *tu = to_trace_uprobe(ev);
+
+	return strcmp(trace_event_name(&tu->tp.call), event) == 0 &&
+	    (!system || strcmp(tu->tp.call.class->system, system) == 0);
+}
+
 /*
  * Allocate new trace_uprobe and initialize it (including uprobes).
  */

