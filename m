Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeEPNim (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752243AbeEPNih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:38:37 -0400
Message-Id: <20180516133836.375029832@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 16 May 2018 09:36:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>, tom.zanussi@linux.intel.com,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH RT 2/5] tracing: Add field parsing hist error for hist triggers
References: <20180516133642.521479369@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0002-tracing-Add-field-parsing-hist-error-for-hist-trigge.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.40-rt31-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Tom Zanussi <tom.zanussi@linux.intel.com>

[ commit 5ec432d7bf9dd3b4a2b84f8974e3adb71f45fb1d ]

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

Link: http://lkml.kernel.org/r/fdc8746969d16906120f162b99dd71c741e0b62c.1524790601.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index b8fee11b5be9..9dac8bae4f34 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2482,6 +2482,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 	else {
 		field = trace_find_event_field(file->event_call, field_name);
 		if (!field || !field->size) {
+			hist_err("Couldn't find field: ", field_name);
 			field = ERR_PTR(-EINVAL);
 			goto out;
 		}
-- 
2.17.0
