Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeDEXeR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 19:34:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:35307 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbeDEXeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 19:34:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,412,1517904000";
   d="scan'208";a="45316428"
Message-ID: <1522971253.32118.47.camel@tzanussi-mobl.amr.corp.intel.com>
Subject: Re: [PATCH 3/4] tracing: Add action comparisons when testing
 matching hist triggers
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date: Thu, 05 Apr 2018 18:34:13 -0500
In-Reply-To: <20180405125016.6460a0ab372061ecf49f471a@kernel.org>
References: <cover.1522256721.git.tom.zanussi@linux.intel.com>
         <a7fd668b87ec10736c8f016ac4279c8480d50c2b.1522256721.git.tom.zanussi@linux.intel.com>
         <20180403001025.6dfed9403d50d20104e54458@kernel.org>
         <1522688973.3254.8.camel@tzanussi-mobl.amr.corp.intel.com>
         <20180404213338.5bcd14994d8e0142b5bfefc6@kernel.org>
         <1522855023.32118.14.camel@tzanussi-mobl.amr.corp.intel.com>
         <20180405125016.6460a0ab372061ecf49f471a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Thu, 2018-04-05 at 12:50 +0900, Masami Hiramatsu wrote:

[...]

> Can you print out the error with which event we should see? e.g.
> 
>   ERROR: Variable already defined at sched_wakeup: ts0
> 

How about printing the event name along with the last command, for any
error? :

  ERROR: Variable already defined: ts0
    Last command: [sched:sched_wakeup] keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"

If that seems fine to you (more detailed explanation below), I'll test
the patch below and submit it along with a couple others after testing.


[PATCH 2/3] tracing: Add system:event_name to hist trigger 'last
 command' error info

In order to help users determine what might have gone wrong when
entering a hist trigger command, a simple 'last error' facility was
added which simply displays the last error that occurred at the end of
whatever hist file is read.

The assumption is that the user would normally read the hist file for
the event that caused the error, but in some cases a user may become
confused about which was the command that caused the error and read a
different hist file.  In that case it's still useful to be able to
access the error info, but can cause even more confusion if the user
thinks the error is associated with that event.

So, along with the 'last cmd' itself, we explicitly add the event
associated with it and clearly show which event the error was
triggered on.

Before:

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger

  # echo '!hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

And other commands making us think we cleared everything out so the
below error is a surprise

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  -su: echo: write error: Invalid argument

Wait, we think, we cleared it all out, how can there still be
something defined?

  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
  ERROR: Variable already defined: ts0
    Last command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"

Confusion because there's nothing defined on sched_switch, we did
clear it all out.

After:

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger

  # echo '!hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

And other commands making us think we cleared everything out so the
below error is a surprise

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  -su: echo: write error: Invalid argument

Wait, we think, we cleared it all out, how can there still be
something defined?

  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
  ERROR: Variable already defined: ts0
    Last command: [sched:sched_wakeup] keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"

Oh, that's saying it's defined on sched_wakeup, let's look there...

  # cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/hist
  # event histogram
  #
  # trigger info: hist:keys=pid:vals=hitcount:ts0=common_timestamp.usecs:sort=hitcount:size=2048:clock=global if comm=="cyclictest" [active]
  #

  Totals:
      Hits: 0
      Entries: 0
      Dropped: 0

  ERROR: Variable already defined: ts0
    Last command: [sched:sched_wakeup] keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"

Yeah, the sched_wakeup command defining ts0 is still there so what
happened was that the last command to sched_wakeup again defining ts0
failed because we hadn't actually cleared the previous sched_wakeup
command like we thought we had.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 66c87be4ebb2..38a4566f74a7 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -356,12 +356,37 @@ struct action_data {
 static char last_hist_cmd[MAX_FILTER_STR_VAL];
 static char hist_err_str[MAX_FILTER_STR_VAL];
 
-static void last_cmd_set(char *str)
+static void last_cmd_set(struct trace_event_file *file, char *str)
 {
+	int event_len = 0, maxlen = MAX_FILTER_STR_VAL - 1;
+	const char *system = NULL, *name = NULL;
+	char event_name[MAX_FILTER_STR_VAL];
+	struct trace_event_call *call;
+
 	if (!str)
 		return;
 
-	strncpy(last_hist_cmd, str, MAX_FILTER_STR_VAL - 1);
+	if (file) {
+		call = file->event_call;
+
+		system = call->class->system;
+		if (system) {
+			name = trace_event_name(call);
+			if (!name)
+				system = NULL;
+		}
+	}
+
+	if (system)
+		event_len = snprintf(event_name, MAX_FILTER_STR_VAL, "[%s:%s] ", system, name);
+
+	if (event_len + strlen(str) > maxlen)
+		return;
+
+	if (event_len)
+		strcat(last_hist_cmd, event_name);
+
+	strcat(last_hist_cmd, str);
 }
 
 static void hist_err(char *str, char *var)
@@ -401,6 +426,7 @@ static void hist_err_event(char *str, char *system, char *event, char *var)
 static void hist_err_clear(void)
 {
 	hist_err_str[0] = '\0';
+	last_hist_cmd[0] = '\0';
 }
 
 static bool have_hist_err(void)
@@ -5478,8 +5504,8 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	int ret = 0;
 
 	if (glob && strlen(glob)) {
-		last_cmd_set(param);
 		hist_err_clear();
+		last_cmd_set(file, param);
 	}
 
 	if (!param)
-- 
2.14.1


> And this shows the good reason why we should reject removing
> unexist trigger (with -ENOENT). If I find I can not remove
> 'hist:keys=pid:ts0=...' from sched_switch, it helps me to
> notice my mistake.

That's very easy to implement, see the patch below, but it changes
existing behavior (which makes some sense, see below), and the -ENOENT
would seem to cause more confusion for the user, who would probably
think it refers to the trigger file not existing, which it clearly
does...

Anyway, I hope the above patch to explicitly show the event name will be
sufficient to avoid confusion in cases like this.


[PATCH 3/3] tracing: Return error when trying to delete nonexistent
 hist trigger

Rather than being silent about it, explicitly let the user know it
doesn't exist and so can't be removed.

The current behavior is to just be silent about it - if there's no
error like -EBUSY, the user can be assured the trigger no longer
exists whether or not it did before.

Before:

  # echo '!hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

After:

  # echo '!hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  -su: echo: write error: No such file or directory

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 38a4566f74a7..f5c85ba6f580 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5584,8 +5584,10 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	}
 
 	if (remove) {
-		if (!have_hist_trigger_match(trigger_data, file))
+		if (!have_hist_trigger_match(trigger_data, file)) {
+			ret = -ENOENT;
 			goto out_free;
+		}
 
 		if (hist_trigger_check_refs(trigger_data, file)) {
 			ret = -EBUSY;
-- 
2.14.1






> 
> > > Hmm, how can I undef ts0 and test it again?
> > 
> > You should be able to remove the sched_wakeup trigger defining ts0 and
> > after doing that test again.  At least I was able to:
> > 
> > # echo '!hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> 
> > events/sched/sched_wakeup/trigger
> > 
> > # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"'
> > >> events/sched/sched_wakeup/trigger
> 
> OK, anyway this works good to me too.
> 
> Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
> 

Thanks!

Tom
