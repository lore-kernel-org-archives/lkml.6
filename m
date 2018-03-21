Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeCUCYe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752005AbeCUCVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2ADE21858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022129.700959357@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>
Subject: [for-next][PATCH 34/46] tracing: Add a clock attribute for hist triggers
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0034-tracing-Add-a-clock-attribute-for-hist-triggers.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

The default clock if timestamps are used in a histogram is "global".
If timestamps aren't used, the clock is irrelevant.

Use the "clock=" param only if you want to override the default
"global" clock for a histogram with timestamps.

Link: http://lkml.kernel.org/r/427bed1389c5d22aa40c3e0683e30cc3d151e260.1516069914.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/histogram.txt | 11 +++++++++-
 kernel/trace/trace_events_hist.c  | 42 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/histogram.txt b/Documentation/trace/histogram.txt
index df08882d091c..6e05510afc28 100644
--- a/Documentation/trace/histogram.txt
+++ b/Documentation/trace/histogram.txt
@@ -1671,7 +1671,16 @@ features have been added to the hist trigger support:
     it is in units of nanoseconds; appending '.usecs' to a
     common_timestamp field changes the units to microseconds.
 
-These features are decribed in more detail in the following sections.
+A note on inter-event timestamps: If common_timestamp is used in a
+histogram, the trace buffer is automatically switched over to using
+absolute timestamps and the "global" trace clock, in order to avoid
+bogus timestamp differences with other clocks that aren't coherent
+across CPUs.  This can be overridden by specifying one of the other
+trace clocks instead, using the "clock=XXX" hist trigger attribute,
+where XXX is any of the clocks listed in the tracing/trace_clock
+pseudo-file.
+
+These features are described in more detail in the following sections.
 
 2.2.1 Histogram Variables
 -------------------------
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8719b0ea672f..f7d0da20c5c8 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -242,6 +242,7 @@ struct hist_trigger_attrs {
 	char		*vals_str;
 	char		*sort_key_str;
 	char		*name;
+	char		*clock;
 	bool		pause;
 	bool		cont;
 	bool		clear;
@@ -1776,6 +1777,7 @@ static void destroy_hist_trigger_attrs(struct hist_trigger_attrs *attrs)
 	kfree(attrs->sort_key_str);
 	kfree(attrs->keys_str);
 	kfree(attrs->vals_str);
+	kfree(attrs->clock);
 	kfree(attrs);
 }
 
@@ -1831,6 +1833,19 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 			ret = -ENOMEM;
 			goto out;
 		}
+	} else if (strncmp(str, "clock=", strlen("clock=")) == 0) {
+		strsep(&str, "=");
+		if (!str) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		str = strstrip(str);
+		attrs->clock = kstrdup(str, GFP_KERNEL);
+		if (!attrs->clock) {
+			ret = -ENOMEM;
+			goto out;
+		}
 	} else if (strncmp(str, "size=", strlen("size=")) == 0) {
 		int map_bits = parse_map_size(str);
 
@@ -1895,6 +1910,14 @@ static struct hist_trigger_attrs *parse_hist_trigger_attrs(char *trigger_str)
 		goto free;
 	}
 
+	if (!attrs->clock) {
+		attrs->clock = kstrdup("global", GFP_KERNEL);
+		if (!attrs->clock) {
+			ret = -ENOMEM;
+			goto free;
+		}
+	}
+
 	return attrs;
  free:
 	destroy_hist_trigger_attrs(attrs);
@@ -4934,6 +4957,8 @@ static int event_hist_trigger_print(struct seq_file *m,
 			seq_puts(m, ".descending");
 	}
 	seq_printf(m, ":size=%u", (1 << hist_data->map->map_bits));
+	if (hist_data->enable_timestamps)
+		seq_printf(m, ":clock=%s", hist_data->attrs->clock);
 
 	print_actions_spec(m, hist_data);
 
@@ -5201,7 +5226,6 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 		data->paused = true;
 
 	if (named_data) {
-		destroy_hist_data(data->private_data);
 		data->private_data = named_data->private_data;
 		set_named_trigger_data(data, named_data);
 		data->ops = &event_hist_trigger_named_ops;
@@ -5213,10 +5237,22 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 			goto out;
 	}
 
-	ret++;
+	if (hist_data->enable_timestamps) {
+		char *clock = hist_data->attrs->clock;
+
+		ret = tracing_set_clock(file->tr, hist_data->attrs->clock);
+		if (ret) {
+			hist_err("Couldn't set trace_clock: ", clock);
+			goto out;
+		}
 
-	if (hist_data->enable_timestamps)
 		tracing_set_time_stamp_abs(file->tr, true);
+	}
+
+	if (named_data)
+		destroy_hist_data(hist_data);
+
+	ret++;
  out:
 	return ret;
 }
-- 
2.15.1
