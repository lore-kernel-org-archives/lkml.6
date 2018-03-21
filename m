Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeCUC1D (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:27:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751963AbeCUCVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFFE21837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022126.391026492@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 19/46] tracing: Generalize per-element hist trigger data
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0019-tracing-Generalize-per-element-hist-trigger-data.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Up until now, hist triggers only needed per-element support for saving
'comm' data, which was saved directly as a private data pointer.

In anticipation of the need to save other data besides 'comm', add a
new hist_elt_data struct for the purpose, and switch the current
'comm'-related code over to that.

Link: http://lkml.kernel.org/r/4502c338c965ddf5fc19fb1ec4764391e001ed4b.1516069914.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 76 +++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 4c3c7d784bfd..f072ed3122c8 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -289,6 +289,10 @@ static struct hist_field *find_var(struct hist_trigger_data *hist_data,
 	return NULL;
 }
 
+struct hist_elt_data {
+	char *comm;
+};
+
 static const char *hist_field_name(struct hist_field *field,
 				   unsigned int level)
 {
@@ -503,45 +507,61 @@ static inline void save_comm(char *comm, struct task_struct *task)
 	memcpy(comm, task->comm, TASK_COMM_LEN);
 }
 
-static void hist_trigger_elt_comm_free(struct tracing_map_elt *elt)
+static void hist_elt_data_free(struct hist_elt_data *elt_data)
+{
+	kfree(elt_data->comm);
+	kfree(elt_data);
+}
+
+static void hist_trigger_elt_data_free(struct tracing_map_elt *elt)
 {
-	kfree((char *)elt->private_data);
+	struct hist_elt_data *elt_data = elt->private_data;
+
+	hist_elt_data_free(elt_data);
 }
 
-static int hist_trigger_elt_comm_alloc(struct tracing_map_elt *elt)
+static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 {
 	struct hist_trigger_data *hist_data = elt->map->private_data;
+	unsigned int size = TASK_COMM_LEN;
+	struct hist_elt_data *elt_data;
 	struct hist_field *key_field;
 	unsigned int i;
 
+	elt_data = kzalloc(sizeof(*elt_data), GFP_KERNEL);
+	if (!elt_data)
+		return -ENOMEM;
+
 	for_each_hist_key_field(i, hist_data) {
 		key_field = hist_data->fields[i];
 
 		if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
-			unsigned int size = TASK_COMM_LEN + 1;
-
-			elt->private_data = kzalloc(size, GFP_KERNEL);
-			if (!elt->private_data)
+			elt_data->comm = kzalloc(size, GFP_KERNEL);
+			if (!elt_data->comm) {
+				kfree(elt_data);
 				return -ENOMEM;
+			}
 			break;
 		}
 	}
 
+	elt->private_data = elt_data;
+
 	return 0;
 }
 
-static void hist_trigger_elt_comm_init(struct tracing_map_elt *elt)
+static void hist_trigger_elt_data_init(struct tracing_map_elt *elt)
 {
-	char *comm = elt->private_data;
+	struct hist_elt_data *elt_data = elt->private_data;
 
-	if (comm)
-		save_comm(comm, current);
+	if (elt_data->comm)
+		save_comm(elt_data->comm, current);
 }
 
-static const struct tracing_map_ops hist_trigger_elt_comm_ops = {
-	.elt_alloc	= hist_trigger_elt_comm_alloc,
-	.elt_free	= hist_trigger_elt_comm_free,
-	.elt_init	= hist_trigger_elt_comm_init,
+static const struct tracing_map_ops hist_trigger_elt_data_ops = {
+	.elt_alloc	= hist_trigger_elt_data_alloc,
+	.elt_free	= hist_trigger_elt_data_free,
+	.elt_init	= hist_trigger_elt_data_init,
 };
 
 static const char *get_hist_field_flags(struct hist_field *hist_field)
@@ -1484,21 +1504,6 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
 	return 0;
 }
 
-static bool need_tracing_map_ops(struct hist_trigger_data *hist_data)
-{
-	struct hist_field *key_field;
-	unsigned int i;
-
-	for_each_hist_key_field(i, hist_data) {
-		key_field = hist_data->fields[i];
-
-		if (key_field->flags & HIST_FIELD_FL_EXECNAME)
-			return true;
-	}
-
-	return false;
-}
-
 static struct hist_trigger_data *
 create_hist_data(unsigned int map_bits,
 		 struct hist_trigger_attrs *attrs,
@@ -1524,8 +1529,7 @@ create_hist_data(unsigned int map_bits,
 	if (ret)
 		goto free;
 
-	if (need_tracing_map_ops(hist_data))
-		map_ops = &hist_trigger_elt_comm_ops;
+	map_ops = &hist_trigger_elt_data_ops;
 
 	hist_data->map = tracing_map_create(map_bits, hist_data->key_size,
 					    map_ops, hist_data);
@@ -1713,7 +1717,13 @@ hist_trigger_entry_print(struct seq_file *m,
 			seq_printf(m, "%s: [%llx] %-55s", field_name,
 				   uval, str);
 		} else if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
-			char *comm = elt->private_data;
+			struct hist_elt_data *elt_data = elt->private_data;
+			char *comm;
+
+			if (WARN_ON_ONCE(!elt_data))
+				return;
+
+			comm = elt_data->comm;
 
 			uval = *(u64 *)(key + key_field->offset);
 			seq_printf(m, "%s: %-16s[%10llu]", field_name,
-- 
2.15.1
