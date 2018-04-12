Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753409AbeDLTuW convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 15:50:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753068AbeDLTuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 15:50:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7E021737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 12 Apr 2018 15:50:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Ryabitsev <mricon@kernel.org>
Subject: [GIT PULL v2] tracing: A few last minute clean up and fixes
Message-ID: <20180412155018.04f1c5bf@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

[
  Yeah, I used bash up arrow to get the last tag I made, and added to
  it (without noticing it was ktest). Then I used Esc-. to get the tag
  name for the script, which handles both ktest and trace so it didn't
  realize it was wrong either, and just used it.

  Note, I'm using the Nitrokey for this, which does not support 3k keys
  (my old subkey). I had to create a new subkey. Lets see how that
  works out. Konstantin wanted me to use a ECC key, so I had to create
  another one: subkey == 29E574109AEBFAAA 
]


A few clean ups and bug fixes

 - Replace open coded "ARRAY_SIZE()" with macro

 - Updates to uprobes

 - Bug fix for perf event filter on error path


Please pull the latest trace-v4.17-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.17-2

Tag SHA1: 58cb571bac97bd5f3bb063d537102e485c9e6592
Head SHA1: 0b3dec05dbbce023f4f25aba975b5d253c313ebb


Howard McLauchlan (1):
      tracing/uprobe: Add support for overlayfs

Jérémy Lefaure (1):
      tracing: Use ARRAY_SIZE() macro instead of open coding it

Ravi Bangoria (2):
      trace_uprobe: Use %lx to display offset
      trace_uprobe: Simplify probes_seq_show()

Steven Rostedt (VMware) (1):
      tracing: Enforce passing in filter=NULL to create_filter()

----
 kernel/trace/trace_events_filter.c | 26 +++++++++++---------------
 kernel/trace/trace_uprobe.c        | 23 ++++-------------------
 2 files changed, 15 insertions(+), 34 deletions(-)
---------------------------
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 1bda4ec95e18..9b4716bb8bb0 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1704,18 +1704,16 @@ static int create_filter(struct trace_event_call *call,
 			 struct event_filter **filterp)
 {
 	struct filter_parse_error *pe = NULL;
-	struct event_filter *filter = NULL;
 	int err;
 
-	err = create_filter_start(filter_string, set_str, &pe, &filter);
+	err = create_filter_start(filter_string, set_str, &pe, filterp);
 	if (err)
 		return err;
 
-	err = process_preds(call, filter_string, filter, pe);
+	err = process_preds(call, filter_string, *filterp, pe);
 	if (err && set_str)
-		append_filter_err(pe, filter);
+		append_filter_err(pe, *filterp);
 
-	*filterp = filter;
 	return err;
 }
 
@@ -1739,24 +1737,22 @@ static int create_system_filter(struct trace_subsystem_dir *dir,
 				struct trace_array *tr,
 				char *filter_str, struct event_filter **filterp)
 {
-	struct event_filter *filter = NULL;
 	struct filter_parse_error *pe = NULL;
 	int err;
 
-	err = create_filter_start(filter_str, true, &pe, &filter);
+	err = create_filter_start(filter_str, true, &pe, filterp);
 	if (!err) {
 		err = process_system_preds(dir, tr, pe, filter_str);
 		if (!err) {
 			/* System filters just show a default message */
-			kfree(filter->filter_string);
-			filter->filter_string = NULL;
+			kfree((*filterp)->filter_string);
+			(*filterp)->filter_string = NULL;
 		} else {
-			append_filter_err(pe, filter);
+			append_filter_err(pe, *filterp);
 		}
 	}
 	create_filter_finish(pe);
 
-	*filterp = filter;
 	return err;
 }
 
@@ -1764,7 +1760,7 @@ static int create_system_filter(struct trace_subsystem_dir *dir,
 int apply_event_filter(struct trace_event_file *file, char *filter_string)
 {
 	struct trace_event_call *call = file->event_call;
-	struct event_filter *filter;
+	struct event_filter *filter = NULL;
 	int err;
 
 	if (!strcmp(strstrip(filter_string), "0")) {
@@ -1817,7 +1813,7 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 {
 	struct event_subsystem *system = dir->subsystem;
 	struct trace_array *tr = dir->tr;
-	struct event_filter *filter;
+	struct event_filter *filter = NULL;
 	int err = 0;
 
 	mutex_lock(&event_mutex);
@@ -2024,7 +2020,7 @@ int ftrace_profile_set_filter(struct perf_event *event, int event_id,
 			      char *filter_str)
 {
 	int err;
-	struct event_filter *filter;
+	struct event_filter *filter = NULL;
 	struct trace_event_call *call;
 
 	mutex_lock(&event_mutex);
@@ -2140,7 +2136,7 @@ static struct test_filter_data_t {
 #undef YES
 #undef NO
 
-#define DATA_CNT (sizeof(test_filter_data)/sizeof(struct test_filter_data_t))
+#define DATA_CNT ARRAY_SIZE(test_filter_data)
 
 static int test_pred_visited;
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 268029ae1be6..21604754bb79 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -446,7 +446,7 @@ static int create_trace_uprobe(int argc, char **argv)
 	if (ret)
 		goto fail_address_parse;
 
-	inode = igrab(d_inode(path.dentry));
+	inode = igrab(d_real_inode(path.dentry));
 	path_put(&path);
 
 	if (!inode || !S_ISREG(inode->i_mode)) {
@@ -602,24 +602,9 @@ static int probes_seq_show(struct seq_file *m, void *v)
 	char c = is_ret_probe(tu) ? 'r' : 'p';
 	int i;
 
-	seq_printf(m, "%c:%s/%s", c, tu->tp.call.class->system,
-			trace_event_name(&tu->tp.call));
-	seq_printf(m, " %s:", tu->filename);
-
-	/* Don't print "0x  (null)" when offset is 0 */
-	if (tu->offset) {
-		seq_printf(m, "0x%px", (void *)tu->offset);
-	} else {
-		switch (sizeof(void *)) {
-		case 4:
-			seq_printf(m, "0x00000000");
-			break;
-		case 8:
-		default:
-			seq_printf(m, "0x0000000000000000");
-			break;
-		}
-	}
+	seq_printf(m, "%c:%s/%s %s:0x%0*lx", c, tu->tp.call.class->system,
+			trace_event_name(&tu->tp.call), tu->filename,
+			(int)(sizeof(void *) * 2), tu->offset);
 
 	for (i = 0; i < tu->tp.nr_args; i++)
 		seq_printf(m, " %s=%s", tu->tp.args[i].name, tu->tp.args[i].comm);
