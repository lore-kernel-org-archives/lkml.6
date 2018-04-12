Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754145AbeDLPNi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:13:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:8698 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754133AbeDLPNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:13:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,442,1517904000";
   d="scan'208";a="46391422"
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 2/6] tracing: Add trace event error log
Date: Thu, 12 Apr 2018 10:13:17 -0500
Message-Id: <194bd34e689dd6df9e48855111fd6c5c66e37fc9.1523545519.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1523545519.git.tom.zanussi@linux.intel.com>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1523545519.git.tom.zanussi@linux.intel.com>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new trace event file, tracing/events/error_log, for trace
event commands to log non-critical errors.  This is useful for
allowing more complex commands such as hist trigger and kprobe_event
commands to point out specifically where something may have gone wrong
without forcing them to resort to more ad hoc methods such as tacking
error messages onto existing output files.

To log a trace event error, call the event_log_err() function with the
event_mutex held, passing it a location string describing where it
came from e.g. kprobe_events or system:event, the command that caused
the error, and a format string and variable-length number of
corresponding snprintf args.

Reading the log displays the last (currently) 8 errors logged in the
following format:

  ERROR(<loc>): <error text ala snprintf>
    Command: <command that caused the error>

Memory for the error log isn't allocated unless there has been a trace
event error, and the error log can be cleared and have its memory
freed by writing the empty string in truncation mode to it:

  # echo > error_log.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace.h        |   3 +
 kernel/trace/trace_events.c | 172 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6fb46a0..f2dc7e6 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1765,6 +1765,9 @@ extern ssize_t trace_parse_run_command(struct file *file,
 		const char __user *buffer, size_t count, loff_t *ppos,
 		int (*createfn)(int, char**));
 
+extern void event_log_err(const char *loc, const char *cmd, const char *fmt,
+			  ...);
+
 /*
  * Normal trace_printk() and friends allocates special buffers
  * to do the manipulation, as well as saves the print formats
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 05c7172..fd02e22 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1668,6 +1668,164 @@ static void ignore_task_cpu(void *data)
 	return ret;
 }
 
+#define EVENT_LOG_ERRS_MAX	(PAGE_SIZE / sizeof(struct event_log_err))
+#define EVENT_ERR_LOG_MASK	(EVENT_LOG_ERRS_MAX - 1)
+
+struct event_log_err {
+	char			err[MAX_FILTER_STR_VAL];
+	char			cmd[MAX_FILTER_STR_VAL];
+};
+
+static char *event_err_log;
+static unsigned int event_err_log_tail;
+
+struct event_log_err *get_event_log_err(void)
+{
+	struct event_log_err *err;
+	char *errpos;
+
+	if (!event_err_log) {
+		event_err_log = (char *)get_zeroed_page(GFP_KERNEL);
+		if (!event_err_log)
+			return NULL;
+	}
+
+	errpos = event_err_log + event_err_log_tail * sizeof(*err);
+	err = (struct event_log_err *)errpos;
+
+	event_err_log_tail = (event_err_log_tail + 1) & EVENT_ERR_LOG_MASK;
+
+	return err;
+}
+
+/**
+ * event_log_err - write an error to the trace event error log
+ * @loc: A string describing where the error occurred
+ * @cmd: The trace event command that caused the error
+ * @fmt: snprintf format string
+ * @...: variable length list of snprintf args
+ *
+ * Writes an error into tracing/events/error_log of the form:
+ *
+ * ERROR(<loc>): <error text ala snprintf>
+ *   Command: <command that caused the error>
+ *
+ * tracing/events/error_log is a small log file containing the last
+ * EVENT_LOG_ERRS_MAX errors (8).  Memory for the error log isn't
+ * allocated unless there has been a trace event error, and the error
+ * log can be cleared and have its memory freed by writing the empty
+ * string in truncation mode to it i.e. echo > error_log.
+ *
+ * Must be called with event_mutex held.
+ */
+void event_log_err(const char *loc, const char *cmd, const char *fmt, ...)
+{
+	struct event_log_err *err;
+	va_list args;
+	int len;
+
+	err = get_event_log_err();
+	if (!err)
+		return;
+
+	snprintf(err->cmd, MAX_FILTER_STR_VAL,"\n  Command: %s\n", cmd);
+
+	len = snprintf(err->err, MAX_FILTER_STR_VAL, "ERROR(%s): ", loc);
+	if (len >= MAX_FILTER_STR_VAL)
+		return;
+
+	va_start(args, fmt);
+	vsnprintf(err->err + len, MAX_FILTER_STR_VAL - len, fmt, args);
+	va_end(args);
+}
+
+static void clear_event_err_log(void)
+{
+	free_page((long unsigned int)event_err_log);
+	event_err_log_tail = 0;
+	event_err_log = NULL;
+}
+
+static void *event_err_log_inc(loff_t *pos)
+{
+	struct event_log_err *err = NULL;
+	char *errpos = NULL;
+	int i = *pos;
+
+	++*pos;
+
+	if (i >= EVENT_LOG_ERRS_MAX)
+		return NULL;
+
+	i += event_err_log_tail;
+	i &= EVENT_ERR_LOG_MASK;
+
+	errpos = event_err_log + (i * sizeof(*err));
+	err = (struct event_log_err *)errpos;
+
+	return err;
+}
+
+static void *event_err_log_seq_start(struct seq_file *m, loff_t *pos)
+{
+	mutex_lock(&event_mutex);
+
+	return event_err_log_inc(pos);
+}
+
+static void *event_err_log_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return event_err_log_inc(pos);
+}
+
+static void event_err_log_seq_stop(struct seq_file *m, void *v)
+{
+	mutex_unlock(&event_mutex);
+}
+
+static int event_err_log_seq_show(struct seq_file *m, void *v)
+{
+	struct event_log_err *err = v;
+
+	if (err)
+		seq_printf(m, "%s%s", err->err, err->cmd);
+
+	return 0;
+}
+
+static const struct seq_operations event_err_log_seq_op = {
+	.start  = event_err_log_seq_start,
+	.next   = event_err_log_seq_next,
+	.stop   = event_err_log_seq_stop,
+	.show   = event_err_log_seq_show
+};
+
+static int event_err_log_open(struct inode *inode, struct file *file)
+{
+	if (file->f_mode & FMODE_WRITE) {
+		if (file->f_flags & O_TRUNC)
+			return 0;
+		else
+			return -EINVAL;
+	}
+
+	return seq_open(file, &event_err_log_seq_op);
+}
+
+static ssize_t event_err_log_write(struct file *file,
+				   const char __user *buffer,
+				   size_t count, loff_t *ppos)
+{
+	if (count == 1)
+		clear_event_err_log();
+	else
+		return -EINVAL;
+
+	*ppos += count;
+
+	return count;
+}
+
 static int ftrace_event_avail_open(struct inode *inode, struct file *file);
 static int ftrace_event_set_open(struct inode *inode, struct file *file);
 static int ftrace_event_set_pid_open(struct inode *inode, struct file *file);
@@ -1767,6 +1925,13 @@ static void ignore_task_cpu(void *data)
 	.release = subsystem_release,
 };
 
+static const struct file_operations ftrace_event_err_log_fops = {
+	.open           = event_err_log_open,
+	.write		= event_err_log_write,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+};
+
 static const struct file_operations ftrace_show_header_fops = {
 	.open = tracing_open_generic,
 	.read = show_header,
@@ -2927,6 +3092,13 @@ static __init int setup_trace_event(char *str)
 		return -ENOMEM;
 	}
 
+	entry = trace_create_file("error_log", 0644, d_events,
+				  tr, &ftrace_event_err_log_fops);
+	if (!entry) {
+		pr_warn("Could not create tracefs 'error_log' entry\n");
+		return -ENOMEM;
+	}
+
 	/* There are not as crucial, just warn if they are not created */
 
 	entry = tracefs_create_file("set_event_pid", 0644, parent,
-- 
1.9.3
