Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757230AbeD0BFS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 21:05:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:37459 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757164AbeD0BFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:05:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,333,1520924400";
   d="scan'208";a="223760098"
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 2/3] tracing: Add field parsing hist error for hist triggers
Date: Thu, 26 Apr 2018 20:04:48 -0500
Message-Id: <fdc8746969d16906120f162b99dd71c741e0b62c.1524790601.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1524790601.git.tom.zanussi@linux.intel.com>
References: <cover.1524790601.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1524790601.git.tom.zanussi@linux.intel.com>
References: <cover.1524790601.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the user specifies a nonexistent field for a hist trigger, the
current code correctly flags that as an error, but doesn't tell the
user what happened.

Fix this by invoking hist_err() with an appropriate message when
nonexistent fields are specified.

Before:

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  -su: echo: write error: Invalid argument
  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist

After:

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  -su: echo: write error: Invalid argument
  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
  ERROR: Couldn't find field: pid
    Last command: keys=pid:ts0=common_timestamp.usecs

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 66c87be..f231fa2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2481,6 +2481,7 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 	else {
 		field = trace_find_event_field(file->event_call, field_name);
 		if (!field || !field->size) {
+			hist_err("Couldn't find field: ", field_name);
 			field = ERR_PTR(-EINVAL);
 			goto out;
 		}
-- 
1.9.3
