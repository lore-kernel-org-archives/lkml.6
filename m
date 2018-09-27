Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F18C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45F921571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhvH3IZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45F921571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeI0WSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbeI0WSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:18:50 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE4C221571;
        Thu, 27 Sep 2018 15:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538063993;
        bh=iEDOS/f6Ns6ftsxOMSEJcNtk32j45ytpSJsTo3QsIlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IhvH3IZVLfw7wgfFNEHAAhakAGUDc5K/ePwzwkkJd99JCs8xpz9K9QecvRO04NQBV
         eDC/qb1SRTCXknEKV/yyYOZZXeuld8VFrxMVHPjVKJLXX0s+s2fOuQN/IlGIlL4/nv
         ob2DuHTgUMYzUfzFSBoK/pmK5nz//B2kltspo/kI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [RFC PATCH 2/5] tracing: Add a unified dynamic event framework
Date:   Fri, 28 Sep 2018 00:59:31 +0900
Message-Id: <153806397091.18458.2219122534159227498.stgit@devbox>
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

Add an unified dynamic event framework for kprobes
and uprobes. Those dynamic events can be co-exist on
same file because those syntax doesn't over-wrapped.

This introduces a framework part which provides a
unified tracefs interface and operations.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/Kconfig          |    3 +
 kernel/trace/Makefile         |    1 
 kernel/trace/trace.c          |    4 +
 kernel/trace/trace_dynevent.c |  149 +++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_dynevent.h |   87 ++++++++++++++++++++++++
 5 files changed, 244 insertions(+)
 create mode 100644 kernel/trace/trace_dynevent.c
 create mode 100644 kernel/trace/trace_dynevent.h

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 5e3de28c7677..bf2e8a5a91f1 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -518,6 +518,9 @@ config BPF_EVENTS
 	help
 	  This allows the user to attach BPF programs to kprobe events.
 
+config DYNAMIC_EVENTS
+	def_bool n
+
 config PROBE_EVENTS
 	def_bool n
 
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index f81dadbc7c4a..9ff3c4fa91b6 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -78,6 +78,7 @@ endif
 ifeq ($(CONFIG_TRACING),y)
 obj-$(CONFIG_KGDB_KDB) += trace_kdb.o
 endif
+obj-$(CONFIG_DYNAMIC_EVENTS) += trace_dynevent.o
 obj-$(CONFIG_PROBE_EVENTS) += trace_probe.o
 obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 147be8523560..8368dea25762 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4603,6 +4603,10 @@ static const char readme_msg[] =
 	"\t\t\t  traces\n"
 #endif
 #endif /* CONFIG_STACK_TRACER */
+#ifdef CONFIG_DYNAMIC_EVENTS
+	"  dynamic_events\t\t- Add/remove/show the generic dynamic events\n"
+	"\t\t\t  Write into this file to define/undefine new trace events.\n"
+#endif
 #ifdef CONFIG_KPROBE_EVENTS
 	"  kprobe_events\t\t- Add/remove/show the kernel dynamic events\n"
 	"\t\t\t  Write into this file to define/undefine new trace events.\n"
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
new file mode 100644
index 000000000000..c829742cfe5d
--- /dev/null
+++ b/kernel/trace/trace_dynevent.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic dynamic event control interface
+ *
+ * Copyright (C) 2018 Masami Hiramatsu <mhiramat@kernel.org>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/tracefs.h>
+
+#include "trace.h"
+#include "trace_dynevent.h"
+
+static DEFINE_MUTEX(dyn_event_ops_mutex);
+static LIST_HEAD(dyn_event_ops_list);
+
+int dyn_event_register(struct dyn_event_operations *ops)
+{
+	if (!ops || !ops->create || !ops->show || !ops->is_busy || !ops->free)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&ops->list);
+	mutex_lock(&dyn_event_ops_mutex);
+	list_add_tail(&ops->list, &dyn_event_ops_list);
+	mutex_unlock(&dyn_event_ops_mutex);
+	return 0;
+}
+
+static int create_dyn_event(int argc, char **argv)
+{
+	struct dyn_event_operations *ops;
+	int ret;
+
+	mutex_lock(&dyn_event_ops_mutex);
+	list_for_each_entry(ops, &dyn_event_ops_list, list) {
+		ret = ops->create(argc, argv);
+		if (!ret)
+			break;
+	}
+	mutex_unlock(&dyn_event_ops_mutex);
+	return ret;
+}
+
+DEFINE_MUTEX(dyn_event_mutex);
+LIST_HEAD(dyn_event_list);
+
+void *dyn_event_seq_start(struct seq_file *m, loff_t *pos)
+{
+	mutex_lock(&dyn_event_mutex);
+	return seq_list_start(&dyn_event_list, *pos);
+}
+
+void *dyn_event_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return seq_list_next(v, &dyn_event_list, pos);
+}
+
+void dyn_event_seq_stop(struct seq_file *m, void *v)
+{
+	mutex_unlock(&dyn_event_mutex);
+}
+
+static int dyn_event_seq_show(struct seq_file *m, void *v)
+{
+	struct dyn_event *ev = v;
+
+	if (ev && ev->ops)
+		return ev->ops->show(m, ev);
+
+	return 0;
+}
+
+static const struct seq_operations dyn_event_seq_op = {
+	.start	= dyn_event_seq_start,
+	.next	= dyn_event_seq_next,
+	.stop	= dyn_event_seq_stop,
+	.show	= dyn_event_seq_show
+};
+
+static int release_all_dyn_events(void)
+{
+	struct dyn_event *ev, *tmp;
+	int ret = 0;
+
+	for_each_dyn_event(ev) {
+		if (ev->ops->is_busy(ev))
+			return -EBUSY;
+	}
+	for_each_dyn_event_safe(ev, tmp) {
+		ret = ev->ops->free(ev);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int dyn_event_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
+		ret = release_all_dyn_events();
+		if (ret < 0)
+			return ret;
+	}
+
+	return seq_open(file, &dyn_event_seq_op);
+}
+
+static ssize_t dyn_event_write(struct file *file, const char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	return trace_parse_run_command(file, buffer, count, ppos,
+				       create_dyn_event);
+}
+
+static const struct file_operations dynamic_events_ops = {
+	.owner          = THIS_MODULE,
+	.open           = dyn_event_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = seq_release,
+	.write		= dyn_event_write,
+};
+
+/* Make a tracefs interface for controlling dynamic events */
+static __init int init_dynamic_event(void)
+{
+	struct dentry *d_tracer;
+	struct dentry *entry;
+
+	d_tracer = tracing_init_dentry();
+	if (IS_ERR(d_tracer))
+		return 0;
+
+	entry = tracefs_create_file("dynamic_events", 0644, d_tracer,
+				    NULL, &dynamic_events_ops);
+
+	/* Event list interface */
+	if (!entry)
+		pr_warn("Could not create tracefs 'dynamic_events' entry\n");
+
+	return 0;
+}
+fs_initcall(init_dynamic_event);
diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
new file mode 100644
index 000000000000..96cf9ca7adb9
--- /dev/null
+++ b/kernel/trace/trace_dynevent.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common header file for generic dynamic events.
+ */
+
+#ifndef _TRACE_DYNEVENT_H
+#define _TRACE_DYNEVENT_H
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/seq_file.h>
+
+struct dyn_event;
+
+/* These ops must be set. No default operations */
+struct dyn_event_operations {
+	struct list_head	list;
+	int (*create)(int argc, char **argv);
+	int (*show)(struct seq_file *m, struct dyn_event *ev);
+	bool (*is_busy)(struct dyn_event *ev);
+	int (*free)(struct dyn_event *ev);
+};
+
+/* Register new dyn_event type -- must be called at first */
+int dyn_event_register(struct dyn_event_operations *ops);
+
+/* Dynamic event list header -- include this in each event structure */
+struct dyn_event {
+	struct list_head		list;
+	struct dyn_event_operations	*ops;
+};
+
+extern struct mutex dyn_event_mutex;
+extern struct list_head dyn_event_list;
+
+static inline
+int dyn_event_init(struct dyn_event *ev, struct dyn_event_operations *ops)
+{
+	if (!ev || !ops)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&ev->list);
+	ev->ops = ops;
+	return 0;
+}
+
+static inline int dyn_event_add(struct dyn_event *ev)
+{
+	lockdep_assert_held(&dyn_event_mutex);
+
+	if (!ev || !ev->ops)
+		return -EINVAL;
+
+	list_add_tail(&ev->list, &dyn_event_list);
+	return 0;
+}
+
+static inline void dyn_event_remove(struct dyn_event *ev)
+{
+	lockdep_assert_held(&dyn_event_mutex);
+	list_del_init(&ev->list);
+}
+
+void *dyn_event_seq_start(struct seq_file *m, loff_t *pos);
+void *dyn_event_seq_next(struct seq_file *m, void *v, loff_t *pos);
+void dyn_event_seq_stop(struct seq_file *m, void *v);
+
+/*
+ * for_each_dyn_event	-	iterate over the dyn_event list
+ * @pos:	the struct dyn_event * to use as a loop cursor
+ *
+ * This is just a basement of for_each macro. Wrap this for
+ * each actual event structure with ops filtering.
+ */
+#define for_each_dyn_event(pos)	\
+	list_for_each_entry(pos, &dyn_event_list, list)
+
+/*
+ * for_each_dyn_event	-	iterate over the dyn_event list safely
+ * @pos:	the struct dyn_event * to use as a loop cursor
+ * @n:		the struct dyn_event * to use as temporary storage
+ */
+#define for_each_dyn_event_safe(pos, n)	\
+	list_for_each_entry_safe(pos, n, &dyn_event_list, list)
+
+#endif

