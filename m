Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752443AbeEPNij (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752215AbeEPNih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:38:37 -0400
Message-Id: <20180516133836.230519111@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 16 May 2018 09:36:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>, tom.zanussi@linux.intel.com
Subject: [PATCH RT 1/5] tracing: Add field modifier parsing hist error for hist triggers
References: <20180516133642.521479369@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0001-tracing-Add-field-modifier-parsing-hist-error-for-hi.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.40-rt31-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Tom Zanussi <tom.zanussi@linux.intel.com>

[ commit dcf234577cd31fa16874e828b90659166ad6b80d ]

If the user specifies an invalid field modifier for a hist trigger,
the current code correctly flags that as an error, but doesn't tell
the user what happened.

Fix this by invoking hist_err() with an appropriate message when
invalid modifiers are specified.

Before:

  # echo 'hist:keys=pid:ts0=common_timestamp.junkusecs' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  -su: echo: write error: Invalid argument
  # cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/hist

After:

  # echo 'hist:keys=pid:ts0=common_timestamp.junkusecs' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  -su: echo: write error: Invalid argument
  # cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/hist
  ERROR: Invalid field modifier: junkusecs
    Last command: keys=pid:ts0=common_timestamp.junkusecs

Link: http://lkml.kernel.org/r/b043c59fa79acd06a5f14a1d44dee9e5a3cd1248.1524790601.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 37db86145c8b..b8fee11b5be9 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2466,6 +2466,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 		else if (strcmp(modifier, "usecs") == 0)
 			*flags |= HIST_FIELD_FL_TIMESTAMP_USECS;
 		else {
+			hist_err("Invalid field modifier: ", modifier);
 			field = ERR_PTR(-EINVAL);
 			goto out;
 		}
-- 
2.17.0
