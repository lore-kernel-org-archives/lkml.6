Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeDLPNf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:13:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:8698 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753279AbeDLPNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:13:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,442,1517904000";
   d="scan'208";a="219909058"
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 1/6] tracing: Restore proper field flag printing when displaying triggers
Date: Thu, 12 Apr 2018 10:13:16 -0500
Message-Id: <dc44e7dcacb91b4378c5326a9a20e09263868444.1523545519.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1523545519.git.tom.zanussi@linux.intel.com>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1523545519.git.tom.zanussi@linux.intel.com>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flag-printing code used when displaying hist triggers somehow got
dropped during refactoring of the inter-event patchset.  This restores
it.

Below are a couple examples - in the first case, .usecs wasn't being
displayed properly for common_timestamps and the second illustrates
the same for other flags such as .execname.

Before:

  # echo 'hist:key=common_pid.execname:val=count:sort=count' > /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/trigger
  # cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/trigger
  hist:keys=common_pid:vals=hitcount,count:sort=count:size=2048 [active]

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  # cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  hist:keys=pid:vals=hitcount:ts0=common_timestamp:sort=hitcount:size=2048:clock=global if comm=="cyclictest" [active]

After:

  # echo 'hist:key=common_pid.execname:val=count:sort=count' > /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/trigger
  # cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/trigger
  hist:keys=common_pid.execname:vals=hitcount,count:sort=count:size=2048 [active]

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  # cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  hist:keys=pid:vals=hitcount:ts0=common_timestamp.usecs:sort=hitcount:size=2048:clock=global if comm=="cyclictest" [active]

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0d7b3ff..66c87be 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4913,6 +4913,16 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 		seq_printf(m, "%s", field_name);
 	} else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP)
 		seq_puts(m, "common_timestamp");
+
+	if (hist_field->flags) {
+		if (!(hist_field->flags & HIST_FIELD_FL_VAR_REF) &&
+		    !(hist_field->flags & HIST_FIELD_FL_EXPR)) {
+			const char *flags = get_hist_field_flags(hist_field);
+
+			if (flags)
+				seq_printf(m, ".%s", flags);
+		}
+	}
 }
 
 static int event_hist_trigger_print(struct seq_file *m,
-- 
1.9.3
