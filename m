Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbeBQFtW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:49:22 -0500
Received: from mga18.intel.com ([134.134.136.126]:1052 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751134AbeBQFtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:49:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,523,1511856000";
   d="scan'208";a="20863368"
From: changbin.du@intel.com
To: corbet@lwn.net, rostedt@goodmis.org
Cc: mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 09/17] trace doc: convert trace/events.txt to rst format
Date: Sat, 17 Feb 2018 13:39:42 +0800
Message-Id: <1518845990-20733-10-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
References: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

This converts the plain text documentation to reStructuredText format and
add it into Sphinx TOC tree. No essential content change.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 Documentation/trace/{events.txt => events.rst} | 669 +++++++++++++------------
 Documentation/trace/index.rst                  |   1 +
 2 files changed, 337 insertions(+), 333 deletions(-)
 rename Documentation/trace/{events.txt => events.rst} (82%)

diff --git a/Documentation/trace/events.txt b/Documentation/trace/events.rst
similarity index 82%
rename from Documentation/trace/events.txt
rename to Documentation/trace/events.rst
index 2cc08d4..3d6fdea 100644
--- a/Documentation/trace/events.txt
+++ b/Documentation/trace/events.rst
@@ -1,7 +1,9 @@
-			     Event Tracing
+=============
+Event Tracing
+=============
 
-		Documentation written by Theodore Ts'o
-		Updated by Li Zefan and Tom Zanussi
+:Author: Theodore Ts'o
+:Updated: Li Zefan and Tom Zanussi
 
 1. Introduction
 ===============
@@ -25,23 +27,22 @@ The events which are available for tracing can be found in the file
 /sys/kernel/debug/tracing/available_events.
 
 To enable a particular event, such as 'sched_wakeup', simply echo it
-to /sys/kernel/debug/tracing/set_event. For example:
+to /sys/kernel/debug/tracing/set_event. For example::
 
 	# echo sched_wakeup >> /sys/kernel/debug/tracing/set_event
 
-[ Note: '>>' is necessary, otherwise it will firstly disable
-  all the events. ]
+.. Note:: '>>' is necessary, otherwise it will firstly disable all the events.
 
 To disable an event, echo the event name to the set_event file prefixed
-with an exclamation point:
+with an exclamation point::
 
 	# echo '!sched_wakeup' >> /sys/kernel/debug/tracing/set_event
 
-To disable all events, echo an empty line to the set_event file:
+To disable all events, echo an empty line to the set_event file::
 
 	# echo > /sys/kernel/debug/tracing/set_event
 
-To enable all events, echo '*:*' or '*:' to the set_event file:
+To enable all events, echo '*:*' or '*:' to the set_event file::
 
 	# echo *:* > /sys/kernel/debug/tracing/set_event
 
@@ -50,7 +51,7 @@ etc., and a full event name looks like this: <subsystem>:<event>.  The
 subsystem name is optional, but it is displayed in the available_events
 file.  All of the events in a subsystem can be specified via the syntax
 "<subsystem>:*"; for example, to enable all irq events, you can use the
-command:
+command::
 
 	# echo 'irq:*' > /sys/kernel/debug/tracing/set_event
 
@@ -60,33 +61,33 @@ command:
 The events available are also listed in /sys/kernel/debug/tracing/events/ hierarchy
 of directories.
 
-To enable event 'sched_wakeup':
+To enable event 'sched_wakeup'::
 
 	# echo 1 > /sys/kernel/debug/tracing/events/sched/sched_wakeup/enable
 
-To disable it:
+To disable it::
 
 	# echo 0 > /sys/kernel/debug/tracing/events/sched/sched_wakeup/enable
 
-To enable all events in sched subsystem:
+To enable all events in sched subsystem::
 
 	# echo 1 > /sys/kernel/debug/tracing/events/sched/enable
 
-To enable all events:
+To enable all events::
 
 	# echo 1 > /sys/kernel/debug/tracing/events/enable
 
 When reading one of these enable files, there are four results:
 
- 0 - all events this file affects are disabled
- 1 - all events this file affects are enabled
- X - there is a mixture of events enabled and disabled
- ? - this file does not affect any event
+ - 0 - all events this file affects are disabled
+ - 1 - all events this file affects are enabled
+ - X - there is a mixture of events enabled and disabled
+ - ? - this file does not affect any event
 
 2.3 Boot option
 ---------------
 
-In order to facilitate early boot debugging, use boot option:
+In order to facilitate early boot debugging, use boot option::
 
 	trace_event=[event-list]
 
@@ -115,7 +116,7 @@ the fields prefixed with 'common_'.  The other fields vary between
 events and correspond to the fields defined in the TRACE_EVENT
 definition for that event.
 
-Each field in the format has the form:
+Each field in the format has the form::
 
      field:field-type field-name; offset:N; size:N;
 
@@ -123,27 +124,27 @@ where offset is the offset of the field in the trace record and size
 is the size of the data item, in bytes.
 
 For example, here's the information displayed for the 'sched_wakeup'
-event:
+event::
 
-# cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/format
+	# cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/format
 
-name: sched_wakeup
-ID: 60
-format:
-	field:unsigned short common_type;	offset:0;	size:2;
-	field:unsigned char common_flags;	offset:2;	size:1;
-	field:unsigned char common_preempt_count;	offset:3;	size:1;
-	field:int common_pid;	offset:4;	size:4;
-	field:int common_tgid;	offset:8;	size:4;
+	name: sched_wakeup
+	ID: 60
+	format:
+		field:unsigned short common_type;	offset:0;	size:2;
+		field:unsigned char common_flags;	offset:2;	size:1;
+		field:unsigned char common_preempt_count;	offset:3;	size:1;
+		field:int common_pid;	offset:4;	size:4;
+		field:int common_tgid;	offset:8;	size:4;
 
-	field:char comm[TASK_COMM_LEN];	offset:12;	size:16;
-	field:pid_t pid;	offset:28;	size:4;
-	field:int prio;	offset:32;	size:4;
-	field:int success;	offset:36;	size:4;
-	field:int cpu;	offset:40;	size:4;
+		field:char comm[TASK_COMM_LEN];	offset:12;	size:16;
+		field:pid_t pid;	offset:28;	size:4;
+		field:int prio;	offset:32;	size:4;
+		field:int success;	offset:36;	size:4;
+		field:int cpu;	offset:40;	size:4;
 
-print fmt: "task %s:%d [%d] success=%d [%03d]", REC->comm, REC->pid,
-	   REC->prio, REC->success, REC->cpu
+	print fmt: "task %s:%d [%d] success=%d [%03d]", REC->comm, REC->pid,
+		   REC->prio, REC->success, REC->cpu
 
 This event contains 10 fields, the first 5 common and the remaining 5
 event-specific.  All the fields for this event are numeric, except for
@@ -168,7 +169,7 @@ A filter expression consists of one or more 'predicates' that can be
 combined using the logical operators '&&' and '||'.  A predicate is
 simply a clause that compares the value of a field contained within a
 logged event with a constant value and returns either 0 or 1 depending
-on whether the field value matched (1) or didn't match (0):
+on whether the field value matched (1) or didn't match (0)::
 
 	  field-name relational-operator value
 
@@ -190,7 +191,7 @@ And for string fields they are:
 ==, !=, ~
 
 The glob (~) accepts a wild card character (*,?) and character classes
-([). For example:
+([). For example::
 
   prev_comm ~ "*sh"
   prev_comm ~ "sh*"
@@ -203,27 +204,27 @@ The glob (~) accepts a wild card character (*,?) and character classes
 A filter for an individual event is set by writing a filter expression
 to the 'filter' file for the given event.
 
-For example:
+For example::
 
-# cd /sys/kernel/debug/tracing/events/sched/sched_wakeup
-# echo "common_preempt_count > 4" > filter
+	# cd /sys/kernel/debug/tracing/events/sched/sched_wakeup
+	# echo "common_preempt_count > 4" > filter
 
-A slightly more involved example:
+A slightly more involved example::
 
-# cd /sys/kernel/debug/tracing/events/signal/signal_generate
-# echo "((sig >= 10 && sig < 15) || sig == 17) && comm != bash" > filter
+	# cd /sys/kernel/debug/tracing/events/signal/signal_generate
+	# echo "((sig >= 10 && sig < 15) || sig == 17) && comm != bash" > filter
 
 If there is an error in the expression, you'll get an 'Invalid
 argument' error when setting it, and the erroneous string along with
-an error message can be seen by looking at the filter e.g.:
+an error message can be seen by looking at the filter e.g.::
 
-# cd /sys/kernel/debug/tracing/events/signal/signal_generate
-# echo "((sig >= 10 && sig < 15) || dsig == 17) && comm != bash" > filter
--bash: echo: write error: Invalid argument
-# cat filter
-((sig >= 10 && sig < 15) || dsig == 17) && comm != bash
-^
-parse_error: Field not found
+	# cd /sys/kernel/debug/tracing/events/signal/signal_generate
+	# echo "((sig >= 10 && sig < 15) || dsig == 17) && comm != bash" > filter
+	-bash: echo: write error: Invalid argument
+	# cat filter
+	((sig >= 10 && sig < 15) || dsig == 17) && comm != bash
+	^
+	parse_error: Field not found
 
 Currently the caret ('^') for an error always appears at the beginning of
 the filter string; the error message should still be useful though
@@ -255,35 +256,35 @@ fields can be guaranteed to propagate successfully to all events.
 Here are a few subsystem filter examples that also illustrate the
 above points:
 
-Clear the filters on all events in the sched subsystem:
+Clear the filters on all events in the sched subsystem::
 
-# cd /sys/kernel/debug/tracing/events/sched
-# echo 0 > filter
-# cat sched_switch/filter
-none
-# cat sched_wakeup/filter
-none
+	# cd /sys/kernel/debug/tracing/events/sched
+	# echo 0 > filter
+	# cat sched_switch/filter
+	none
+	# cat sched_wakeup/filter
+	none
 
 Set a filter using only common fields for all events in the sched
-subsystem (all events end up with the same filter):
+subsystem (all events end up with the same filter)::
 
-# cd /sys/kernel/debug/tracing/events/sched
-# echo common_pid == 0 > filter
-# cat sched_switch/filter
-common_pid == 0
-# cat sched_wakeup/filter
-common_pid == 0
+	# cd /sys/kernel/debug/tracing/events/sched
+	# echo common_pid == 0 > filter
+	# cat sched_switch/filter
+	common_pid == 0
+	# cat sched_wakeup/filter
+	common_pid == 0
 
 Attempt to set a filter using a non-common field for all events in the
 sched subsystem (all events but those that have a prev_pid field retain
-their old filters):
+their old filters)::
 
-# cd /sys/kernel/debug/tracing/events/sched
-# echo prev_pid == 0 > filter
-# cat sched_switch/filter
-prev_pid == 0
-# cat sched_wakeup/filter
-common_pid == 0
+	# cd /sys/kernel/debug/tracing/events/sched
+	# echo prev_pid == 0 > filter
+	# cat sched_switch/filter
+	prev_pid == 0
+	# cat sched_wakeup/filter
+	common_pid == 0
 
 5.4 PID filtering
 -----------------
@@ -291,16 +292,18 @@ common_pid == 0
 The set_event_pid file in the same directory as the top events directory
 exists, will filter all events from tracing any task that does not have the
 PID listed in the set_event_pid file.
+::
 
-# cd /sys/kernel/debug/tracing
-# echo $$ > set_event_pid
-# echo 1 > events/enabled
+	# cd /sys/kernel/debug/tracing
+	# echo $$ > set_event_pid
+	# echo 1 > events/enabled
 
 Will only trace events for the current task.
 
 To add more PIDs without losing the PIDs already included, use '>>'.
+::
 
-# echo 123 244 1 >> set_event_pid
+	# echo 123 244 1 >> set_event_pid
 
 
 6. Event triggers
@@ -342,12 +345,12 @@ way, so beware about making generalizations between the two.
 6.1 Expression syntax
 ---------------------
 
-Triggers are added by echoing the command to the 'trigger' file:
+Triggers are added by echoing the command to the 'trigger' file::
 
   # echo 'command[:count] [if filter]' > trigger
 
 Triggers are removed by echoing the same command but starting with '!'
-to the 'trigger' file:
+to the 'trigger' file::
 
   # echo '!command[:count] [if filter]' > trigger
 
@@ -379,30 +382,30 @@ The following commands are supported:
 
   For example, the following trigger causes kmalloc events to be
   traced when a read system call is entered, and the :1 at the end
-  specifies that this enablement happens only once:
+  specifies that this enablement happens only once::
 
-  # echo 'enable_event:kmem:kmalloc:1' > \
-      /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/trigger
+	  # echo 'enable_event:kmem:kmalloc:1' > \
+	      /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/trigger
 
   The following trigger causes kmalloc events to stop being traced
   when a read system call exits.  This disablement happens on every
-  read system call exit:
+  read system call exit::
 
-  # echo 'disable_event:kmem:kmalloc' > \
-      /sys/kernel/debug/tracing/events/syscalls/sys_exit_read/trigger
+	  # echo 'disable_event:kmem:kmalloc' > \
+	      /sys/kernel/debug/tracing/events/syscalls/sys_exit_read/trigger
 
-  The format is:
+  The format is::
 
       enable_event:<system>:<event>[:count]
       disable_event:<system>:<event>[:count]
 
-  To remove the above commands:
+  To remove the above commands::
 
-  # echo '!enable_event:kmem:kmalloc:1' > \
-      /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/trigger
+	  # echo '!enable_event:kmem:kmalloc:1' > \
+	      /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/trigger
 
-  # echo '!disable_event:kmem:kmalloc' > \
-      /sys/kernel/debug/tracing/events/syscalls/sys_exit_read/trigger
+	  # echo '!disable_event:kmem:kmalloc' > \
+	      /sys/kernel/debug/tracing/events/syscalls/sys_exit_read/trigger
 
   Note that there can be any number of enable/disable_event triggers
   per triggering event, but there can only be one trigger per
@@ -418,34 +421,34 @@ The following commands are supported:
   triggering event occurs.
 
   For example, the following trigger dumps a stacktrace every time the
-  kmalloc tracepoint is hit:
+  kmalloc tracepoint is hit::
 
-  # echo 'stacktrace' > \
-        /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+	  # echo 'stacktrace' > \
+		/sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
 
   The following trigger dumps a stacktrace the first 5 times a kmalloc
-  request happens with a size >= 64K
+  request happens with a size >= 64K::
 
-  # echo 'stacktrace:5 if bytes_req >= 65536' > \
-        /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+	  # echo 'stacktrace:5 if bytes_req >= 65536' > \
+		/sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
 
-  The format is:
+  The format is::
 
       stacktrace[:count]
 
-  To remove the above commands:
+  To remove the above commands::
 
-  # echo '!stacktrace' > \
-        /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+	  # echo '!stacktrace' > \
+		/sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
 
-  # echo '!stacktrace:5 if bytes_req >= 65536' > \
-        /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+	  # echo '!stacktrace:5 if bytes_req >= 65536' > \
+		/sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
 
   The latter can also be removed more simply by the following (without
-  the filter):
+  the filter)::
 
-  # echo '!stacktrace:5' > \
-        /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+	  # echo '!stacktrace:5' > \
+		/sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
 
   Note that there can be only one stacktrace trigger per triggering
   event.
@@ -458,23 +461,23 @@ The following commands are supported:
   The following command creates a snapshot every time a block request
   queue is unplugged with a depth > 1.  If you were tracing a set of
   events or functions at the time, the snapshot trace buffer would
-  capture those events when the trigger event occurred:
+  capture those events when the trigger event occurred::
 
-  # echo 'snapshot if nr_rq > 1' > \
-        /sys/kernel/debug/tracing/events/block/block_unplug/trigger
+	  # echo 'snapshot if nr_rq > 1' > \
+		/sys/kernel/debug/tracing/events/block/block_unplug/trigger
 
-  To only snapshot once:
+  To only snapshot once::
 
-  # echo 'snapshot:1 if nr_rq > 1' > \
-        /sys/kernel/debug/tracing/events/block/block_unplug/trigger
+	  # echo 'snapshot:1 if nr_rq > 1' > \
+		/sys/kernel/debug/tracing/events/block/block_unplug/trigger
 
-  To remove the above commands:
+  To remove the above commands::
 
-  # echo '!snapshot if nr_rq > 1' > \
-        /sys/kernel/debug/tracing/events/block/block_unplug/trigger
+	  # echo '!snapshot if nr_rq > 1' > \
+		/sys/kernel/debug/tracing/events/block/block_unplug/trigger
 
-  # echo '!snapshot:1 if nr_rq > 1' > \
-        /sys/kernel/debug/tracing/events/block/block_unplug/trigger
+	  # echo '!snapshot:1 if nr_rq > 1' > \
+		/sys/kernel/debug/tracing/events/block/block_unplug/trigger
 
   Note that there can be only one snapshot trigger per triggering
   event.
@@ -489,23 +492,23 @@ The following commands are supported:
   request queue is unplugged with a depth > 1.  If you were tracing a
   set of events or functions at the time, you could then examine the
   trace buffer to see the sequence of events that led up to the
-  trigger event:
+  trigger event::
 
-  # echo 'traceoff:1 if nr_rq > 1' > \
-        /sys/kernel/debug/tracing/events/block/block_unplug/trigger
+	  # echo 'traceoff:1 if nr_rq > 1' > \
+		/sys/kernel/debug/tracing/events/block/block_unplug/trigger
 
-  To always disable tracing when nr_rq  > 1 :
+  To always disable tracing when nr_rq  > 1::
 
-  # echo 'traceoff if nr_rq > 1' > \
-        /sys/kernel/debug/tracing/events/block/block_unplug/trigger
+	  # echo 'traceoff if nr_rq > 1' > \
+		/sys/kernel/debug/tracing/events/block/block_unplug/trigger
 
-  To remove the above commands:
+  To remove the above commands::
 
-  # echo '!traceoff:1 if nr_rq > 1' > \
-        /sys/kernel/debug/tracing/events/block/block_unplug/trigger
+	  # echo '!traceoff:1 if nr_rq > 1' > \
+		/sys/kernel/debug/tracing/events/block/block_unplug/trigger
 
-  # echo '!traceoff if nr_rq > 1' > \
-        /sys/kernel/debug/tracing/events/block/block_unplug/trigger
+	  # echo '!traceoff if nr_rq > 1' > \
+		/sys/kernel/debug/tracing/events/block/block_unplug/trigger
 
   Note that there can be only one traceon or traceoff trigger per
   triggering event.
@@ -517,7 +520,7 @@ The following commands are supported:
   totals derived from one or more trace event format fields and/or
   event counts (hitcount).
 
-  The format of a hist trigger is as follows:
+  The format of a hist trigger is as follows::
 
         hist:keys=<field1[,field2,...]>[:values=<field1[,field2,...]>]
           [:sort=<field1[,field2,...]>][:size=#entries][:pause][:continue]
@@ -566,11 +569,11 @@ The following commands are supported:
   modified by appending any of the following modifiers to the field
   name:
 
-        .hex        display a number as a hex value
-	.sym        display an address as a symbol
-	.sym-offset display an address as a symbol and offset
-	.syscall    display a syscall id as a system call name
-	.execname   display a common_pid as a program name
+        - .hex        display a number as a hex value
+	- .sym        display an address as a symbol
+	- .sym-offset display an address as a symbol and offset
+	- .syscall    display a syscall id as a system call name
+	- .execname   display a common_pid as a program name
 
   Note that in general the semantics of a given field aren't
   interpreted when applying a modifier to it, but there are some
@@ -588,15 +591,15 @@ The following commands are supported:
       pid-specific comm fields in the event itself.
 
   A typical usage scenario would be the following to enable a hist
-  trigger, read its current contents, and then turn it off:
+  trigger, read its current contents, and then turn it off::
 
-  # echo 'hist:keys=skbaddr.hex:vals=len' > \
-    /sys/kernel/debug/tracing/events/net/netif_rx/trigger
+	  # echo 'hist:keys=skbaddr.hex:vals=len' > \
+	    /sys/kernel/debug/tracing/events/net/netif_rx/trigger
 
-  # cat /sys/kernel/debug/tracing/events/net/netif_rx/hist
+	  # cat /sys/kernel/debug/tracing/events/net/netif_rx/hist
 
-  # echo '!hist:keys=skbaddr.hex:vals=len' > \
-    /sys/kernel/debug/tracing/events/net/netif_rx/trigger
+	  # echo '!hist:keys=skbaddr.hex:vals=len' > \
+	    /sys/kernel/debug/tracing/events/net/netif_rx/trigger
 
   The trigger file itself can be read to show the details of the
   currently attached hist trigger.  This information is also displayed
@@ -636,7 +639,7 @@ The following commands are supported:
   can be attached to a given event, allowing that event to kick off
   and stop aggregations on a host of other events.
 
-  The format is very similar to the enable/disable_event triggers:
+  The format is very similar to the enable/disable_event triggers::
 
       enable_hist:<system>:<event>[:count]
       disable_hist:<system>:<event>[:count]
@@ -649,16 +652,16 @@ The following commands are supported:
   A typical usage scenario for the enable_hist/disable_hist triggers
   would be to first set up a paused hist trigger on some event,
   followed by an enable_hist/disable_hist pair that turns the hist
-  aggregation on and off when conditions of interest are hit:
+  aggregation on and off when conditions of interest are hit::
 
-  # echo 'hist:keys=skbaddr.hex:vals=len:pause' > \
-    /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+	  # echo 'hist:keys=skbaddr.hex:vals=len:pause' > \
+	    /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
 
-  # echo 'enable_hist:net:netif_receive_skb if filename==/usr/bin/wget' > \
-    /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
+	  # echo 'enable_hist:net:netif_receive_skb if filename==/usr/bin/wget' > \
+	    /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
 
-  # echo 'disable_hist:net:netif_receive_skb if comm==wget' > \
-    /sys/kernel/debug/tracing/events/sched/sched_process_exit/trigger
+	  # echo 'disable_hist:net:netif_receive_skb if comm==wget' > \
+	    /sys/kernel/debug/tracing/events/sched/sched_process_exit/trigger
 
   The above sets up an initially paused hist trigger which is unpaused
   and starts aggregating events when a given program is executed, and
@@ -674,7 +677,7 @@ The following commands are supported:
 
   The first set of examples creates aggregations using the kmalloc
   event.  The fields that can be used for the hist trigger are listed
-  in the kmalloc event's format file:
+  in the kmalloc event's format file::
 
     # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/format
     name: kmalloc
@@ -693,7 +696,7 @@ The following commands are supported:
 
   We'll start by creating a hist trigger that generates a simple table
   that lists the total number of bytes requested for each function in
-  the kernel that made one or more calls to kmalloc:
+  the kernel that made one or more calls to kmalloc::
 
     # echo 'hist:key=call_site:val=bytes_req' > \
             /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
@@ -708,7 +711,7 @@ The following commands are supported:
 
   We'll let it run for awhile and then dump the contents of the 'hist'
   file in the kmalloc event's subdirectory (for readability, a number
-  of entries have been omitted):
+  of entries have been omitted)::
 
     # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
     # trigger info: hist:keys=call_site:vals=bytes_req:sort=hitcount:size=2048 [active]
@@ -748,7 +751,7 @@ The following commands are supported:
   specified in the trigger, followed by the value(s) also specified in
   the trigger.  At the beginning of the output is a line that displays
   the trigger info, which can also be displayed by reading the
-  'trigger' file:
+  'trigger' file::
 
     # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
     hist:keys=call_site:vals=bytes_req:sort=hitcount:size=2048 [active]
@@ -778,7 +781,7 @@ The following commands are supported:
   frequencies.
 
   To turn the hist trigger off, simply call up the trigger in the
-  command history and re-execute it with a '!' prepended:
+  command history and re-execute it with a '!' prepended::
 
     # echo '!hist:key=call_site:val=bytes_req' > \
            /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
@@ -786,7 +789,7 @@ The following commands are supported:
   Finally, notice that the call_site as displayed in the output above
   isn't really very useful.  It's an address, but normally addresses
   are displayed in hex.  To have a numeric field displayed as a hex
-  value, simply append '.hex' to the field name in the trigger:
+  value, simply append '.hex' to the field name in the trigger::
 
     # echo 'hist:key=call_site.hex:val=bytes_req' > \
            /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
@@ -831,7 +834,7 @@ The following commands are supported:
   when looking at text addresses are the corresponding symbols
   instead.  To have an address displayed as symbolic value instead,
   simply append '.sym' or '.sym-offset' to the field name in the
-  trigger:
+  trigger::
 
     # echo 'hist:key=call_site.sym:val=bytes_req' > \
            /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
@@ -881,7 +884,7 @@ The following commands are supported:
   run.  If instead we we wanted to see the top kmalloc callers in
   terms of the number of bytes requested rather than the number of
   calls, and we wanted the top caller to appear at the top, we can use
-  the 'sort' parameter, along with the 'descending' modifier:
+  the 'sort' parameter, along with the 'descending' modifier::
 
     # echo 'hist:key=call_site.sym:val=bytes_req:sort=bytes_req.descending' > \
            /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
@@ -922,7 +925,7 @@ The following commands are supported:
         Dropped: 0
 
   To display the offset and size information in addition to the symbol
-  name, just use 'sym-offset' instead:
+  name, just use 'sym-offset' instead::
 
     # echo 'hist:key=call_site.sym-offset:val=bytes_req:sort=bytes_req.descending' > \
            /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
@@ -961,7 +964,7 @@ The following commands are supported:
   We can also add multiple fields to the 'values' parameter.  For
   example, we might want to see the total number of bytes allocated
   alongside bytes requested, and display the result sorted by bytes
-  allocated in a descending order:
+  allocated in a descending order::
 
     # echo 'hist:keys=call_site.sym:values=bytes_req,bytes_alloc:sort=bytes_alloc.descending' > \
            /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
@@ -1004,7 +1007,7 @@ The following commands are supported:
   the hist trigger display symbolic call_sites, we can have the hist
   trigger additionally display the complete set of kernel stack traces
   that led to each call_site.  To do that, we simply use the special
-  value 'stacktrace' for the key parameter:
+  value 'stacktrace' for the key parameter::
 
     # echo 'hist:keys=stacktrace:values=bytes_req,bytes_alloc:sort=bytes_alloc' > \
            /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
@@ -1015,7 +1018,7 @@ The following commands are supported:
   event, along with a running total of any of the event fields for
   that event.  Here we tally bytes requested and bytes allocated for
   every callpath in the system that led up to a kmalloc (in this case
-  every callpath to a kmalloc for a kernel compile):
+  every callpath to a kmalloc for a kernel compile)::
 
     # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
     # trigger info: hist:keys=stacktrace:vals=bytes_req,bytes_alloc:sort=bytes_alloc:size=2048 [active]
@@ -1113,7 +1116,7 @@ The following commands are supported:
   gather and display sorted totals for each process, you can use the
   special .execname modifier to display the executable names for the
   processes in the table rather than raw pids.  The example below
-  keeps a per-process sum of total bytes read:
+  keeps a per-process sum of total bytes read::
 
     # echo 'hist:key=common_pid.execname:val=count:sort=count.descending' > \
            /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/trigger
@@ -1154,7 +1157,7 @@ The following commands are supported:
   gather and display a list of systemwide syscall hits, you can use
   the special .syscall modifier to display the syscall names rather
   than raw ids.  The example below keeps a running total of syscall
-  counts for the system during the run:
+  counts for the system during the run::
 
     # echo 'hist:key=id.syscall:val=hitcount' > \
            /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger
@@ -1196,155 +1199,155 @@ The following commands are supported:
         Entries: 72
         Dropped: 0
 
-    The syscall counts above provide a rough overall picture of system
-    call activity on the system; we can see for example that the most
-    popular system call on this system was the 'sys_ioctl' system call.
-
-    We can use 'compound' keys to refine that number and provide some
-    further insight as to which processes exactly contribute to the
-    overall ioctl count.
-
-    The command below keeps a hitcount for every unique combination of
-    system call id and pid - the end result is essentially a table
-    that keeps a per-pid sum of system call hits.  The results are
-    sorted using the system call id as the primary key, and the
-    hitcount sum as the secondary key:
-
-    # echo 'hist:key=id.syscall,common_pid.execname:val=hitcount:sort=id,hitcount' > \
-           /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger
-
-    # cat /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/hist
-    # trigger info: hist:keys=id.syscall,common_pid.execname:vals=hitcount:sort=id.syscall,hitcount:size=2048 [active]
-
-    { id: sys_read                      [  0], common_pid: rtkit-daemon    [      1877] } hitcount:          1
-    { id: sys_read                      [  0], common_pid: gdbus           [      2976] } hitcount:          1
-    { id: sys_read                      [  0], common_pid: console-kit-dae [      3400] } hitcount:          1
-    { id: sys_read                      [  0], common_pid: postgres        [      1865] } hitcount:          1
-    { id: sys_read                      [  0], common_pid: deja-dup-monito [      3543] } hitcount:          2
-    { id: sys_read                      [  0], common_pid: NetworkManager  [       890] } hitcount:          2
-    { id: sys_read                      [  0], common_pid: evolution-calen [      3048] } hitcount:          2
-    { id: sys_read                      [  0], common_pid: postgres        [      1864] } hitcount:          2
-    { id: sys_read                      [  0], common_pid: nm-applet       [      3022] } hitcount:          2
-    { id: sys_read                      [  0], common_pid: whoopsie        [      1212] } hitcount:          2
-    .
-    .
-    .
-    { id: sys_ioctl                     [ 16], common_pid: bash            [      8479] } hitcount:          1
-    { id: sys_ioctl                     [ 16], common_pid: bash            [      3472] } hitcount:         12
-    { id: sys_ioctl                     [ 16], common_pid: gnome-terminal  [      3199] } hitcount:         16
-    { id: sys_ioctl                     [ 16], common_pid: Xorg            [      1267] } hitcount:       1808
-    { id: sys_ioctl                     [ 16], common_pid: compiz          [      2994] } hitcount:       5580
-    .
-    .
-    .
-    { id: sys_waitid                    [247], common_pid: upstart-dbus-br [      2690] } hitcount:          3
-    { id: sys_waitid                    [247], common_pid: upstart-dbus-br [      2688] } hitcount:         16
-    { id: sys_inotify_add_watch         [254], common_pid: gmain           [       975] } hitcount:          2
-    { id: sys_inotify_add_watch         [254], common_pid: gmain           [      3204] } hitcount:          4
-    { id: sys_inotify_add_watch         [254], common_pid: gmain           [      2888] } hitcount:          4
-    { id: sys_inotify_add_watch         [254], common_pid: gmain           [      3003] } hitcount:          4
-    { id: sys_inotify_add_watch         [254], common_pid: gmain           [      2873] } hitcount:          4
-    { id: sys_inotify_add_watch         [254], common_pid: gmain           [      3196] } hitcount:          6
-    { id: sys_openat                    [257], common_pid: java            [      2623] } hitcount:          2
-    { id: sys_eventfd2                  [290], common_pid: ibus-ui-gtk3    [      2760] } hitcount:          4
-    { id: sys_eventfd2                  [290], common_pid: compiz          [      2994] } hitcount:          6
-
-    Totals:
-        Hits: 31536
-        Entries: 323
-        Dropped: 0
-
-    The above list does give us a breakdown of the ioctl syscall by
-    pid, but it also gives us quite a bit more than that, which we
-    don't really care about at the moment.  Since we know the syscall
-    id for sys_ioctl (16, displayed next to the sys_ioctl name), we
-    can use that to filter out all the other syscalls:
-
-    # echo 'hist:key=id.syscall,common_pid.execname:val=hitcount:sort=id,hitcount if id == 16' > \
-           /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger
-
-    # cat /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/hist
-    # trigger info: hist:keys=id.syscall,common_pid.execname:vals=hitcount:sort=id.syscall,hitcount:size=2048 if id == 16 [active]
-
-    { id: sys_ioctl                     [ 16], common_pid: gmain           [      2769] } hitcount:          1
-    { id: sys_ioctl                     [ 16], common_pid: evolution-addre [      8571] } hitcount:          1
-    { id: sys_ioctl                     [ 16], common_pid: gmain           [      3003] } hitcount:          1
-    { id: sys_ioctl                     [ 16], common_pid: gmain           [      2781] } hitcount:          1
-    { id: sys_ioctl                     [ 16], common_pid: gmain           [      2829] } hitcount:          1
-    { id: sys_ioctl                     [ 16], common_pid: bash            [      8726] } hitcount:          1
-    { id: sys_ioctl                     [ 16], common_pid: bash            [      8508] } hitcount:          1
-    { id: sys_ioctl                     [ 16], common_pid: gmain           [      2970] } hitcount:          1
-    { id: sys_ioctl                     [ 16], common_pid: gmain           [      2768] } hitcount:          1
-    .
-    .
-    .
-    { id: sys_ioctl                     [ 16], common_pid: pool            [      8559] } hitcount:         45
-    { id: sys_ioctl                     [ 16], common_pid: pool            [      8555] } hitcount:         48
-    { id: sys_ioctl                     [ 16], common_pid: pool            [      8551] } hitcount:         48
-    { id: sys_ioctl                     [ 16], common_pid: avahi-daemon    [       896] } hitcount:         66
-    { id: sys_ioctl                     [ 16], common_pid: Xorg            [      1267] } hitcount:      26674
-    { id: sys_ioctl                     [ 16], common_pid: compiz          [      2994] } hitcount:      73443
-
-    Totals:
-        Hits: 101162
-        Entries: 103
-        Dropped: 0
-
-    The above output shows that 'compiz' and 'Xorg' are far and away
-    the heaviest ioctl callers (which might lead to questions about
-    whether they really need to be making all those calls and to
-    possible avenues for further investigation.)
-
-    The compound key examples used a key and a sum value (hitcount) to
-    sort the output, but we can just as easily use two keys instead.
-    Here's an example where we use a compound key composed of the the
-    common_pid and size event fields.  Sorting with pid as the primary
-    key and 'size' as the secondary key allows us to display an
-    ordered summary of the recvfrom sizes, with counts, received by
-    each process:
-
-    # echo 'hist:key=common_pid.execname,size:val=hitcount:sort=common_pid,size' > \
-           /sys/kernel/debug/tracing/events/syscalls/sys_enter_recvfrom/trigger
-
-    # cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_recvfrom/hist
-    # trigger info: hist:keys=common_pid.execname,size:vals=hitcount:sort=common_pid.execname,size:size=2048 [active]
-
-    { common_pid: smbd            [       784], size:          4 } hitcount:          1
-    { common_pid: dnsmasq         [      1412], size:       4096 } hitcount:        672
-    { common_pid: postgres        [      1796], size:       1000 } hitcount:          6
-    { common_pid: postgres        [      1867], size:       1000 } hitcount:         10
-    { common_pid: bamfdaemon      [      2787], size:         28 } hitcount:          2
-    { common_pid: bamfdaemon      [      2787], size:      14360 } hitcount:          1
-    { common_pid: compiz          [      2994], size:          8 } hitcount:          1
-    { common_pid: compiz          [      2994], size:         20 } hitcount:         11
-    { common_pid: gnome-terminal  [      3199], size:          4 } hitcount:          2
-    { common_pid: firefox         [      8817], size:          4 } hitcount:          1
-    { common_pid: firefox         [      8817], size:          8 } hitcount:          5
-    { common_pid: firefox         [      8817], size:        588 } hitcount:          2
-    { common_pid: firefox         [      8817], size:        628 } hitcount:          1
-    { common_pid: firefox         [      8817], size:       6944 } hitcount:          1
-    { common_pid: firefox         [      8817], size:     408880 } hitcount:          2
-    { common_pid: firefox         [      8822], size:          8 } hitcount:          2
-    { common_pid: firefox         [      8822], size:        160 } hitcount:          2
-    { common_pid: firefox         [      8822], size:        320 } hitcount:          2
-    { common_pid: firefox         [      8822], size:        352 } hitcount:          1
-    .
-    .
-    .
-    { common_pid: pool            [      8923], size:       1960 } hitcount:         10
-    { common_pid: pool            [      8923], size:       2048 } hitcount:         10
-    { common_pid: pool            [      8924], size:       1960 } hitcount:         10
-    { common_pid: pool            [      8924], size:       2048 } hitcount:         10
-    { common_pid: pool            [      8928], size:       1964 } hitcount:          4
-    { common_pid: pool            [      8928], size:       1965 } hitcount:          2
-    { common_pid: pool            [      8928], size:       2048 } hitcount:          6
-    { common_pid: pool            [      8929], size:       1982 } hitcount:          1
-    { common_pid: pool            [      8929], size:       2048 } hitcount:          1
-
-    Totals:
-        Hits: 2016
-        Entries: 224
-        Dropped: 0
+  The syscall counts above provide a rough overall picture of system
+  call activity on the system; we can see for example that the most
+  popular system call on this system was the 'sys_ioctl' system call.
+
+  We can use 'compound' keys to refine that number and provide some
+  further insight as to which processes exactly contribute to the
+  overall ioctl count.
+
+  The command below keeps a hitcount for every unique combination of
+  system call id and pid - the end result is essentially a table
+  that keeps a per-pid sum of system call hits.  The results are
+  sorted using the system call id as the primary key, and the
+  hitcount sum as the secondary key::
+
+      # echo 'hist:key=id.syscall,common_pid.execname:val=hitcount:sort=id,hitcount' > \
+             /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger
+
+      # cat /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/hist
+      # trigger info: hist:keys=id.syscall,common_pid.execname:vals=hitcount:sort=id.syscall,hitcount:size=2048 [active]
+
+      { id: sys_read                      [  0], common_pid: rtkit-daemon    [      1877] } hitcount:          1
+      { id: sys_read                      [  0], common_pid: gdbus           [      2976] } hitcount:          1
+      { id: sys_read                      [  0], common_pid: console-kit-dae [      3400] } hitcount:          1
+      { id: sys_read                      [  0], common_pid: postgres        [      1865] } hitcount:          1
+      { id: sys_read                      [  0], common_pid: deja-dup-monito [      3543] } hitcount:          2
+      { id: sys_read                      [  0], common_pid: NetworkManager  [       890] } hitcount:          2
+      { id: sys_read                      [  0], common_pid: evolution-calen [      3048] } hitcount:          2
+      { id: sys_read                      [  0], common_pid: postgres        [      1864] } hitcount:          2
+      { id: sys_read                      [  0], common_pid: nm-applet       [      3022] } hitcount:          2
+      { id: sys_read                      [  0], common_pid: whoopsie        [      1212] } hitcount:          2
+      .
+      .
+      .
+      { id: sys_ioctl                     [ 16], common_pid: bash            [      8479] } hitcount:          1
+      { id: sys_ioctl                     [ 16], common_pid: bash            [      3472] } hitcount:         12
+      { id: sys_ioctl                     [ 16], common_pid: gnome-terminal  [      3199] } hitcount:         16
+      { id: sys_ioctl                     [ 16], common_pid: Xorg            [      1267] } hitcount:       1808
+      { id: sys_ioctl                     [ 16], common_pid: compiz          [      2994] } hitcount:       5580
+      .
+      .
+      .
+      { id: sys_waitid                    [247], common_pid: upstart-dbus-br [      2690] } hitcount:          3
+      { id: sys_waitid                    [247], common_pid: upstart-dbus-br [      2688] } hitcount:         16
+      { id: sys_inotify_add_watch         [254], common_pid: gmain           [       975] } hitcount:          2
+      { id: sys_inotify_add_watch         [254], common_pid: gmain           [      3204] } hitcount:          4
+      { id: sys_inotify_add_watch         [254], common_pid: gmain           [      2888] } hitcount:          4
+      { id: sys_inotify_add_watch         [254], common_pid: gmain           [      3003] } hitcount:          4
+      { id: sys_inotify_add_watch         [254], common_pid: gmain           [      2873] } hitcount:          4
+      { id: sys_inotify_add_watch         [254], common_pid: gmain           [      3196] } hitcount:          6
+      { id: sys_openat                    [257], common_pid: java            [      2623] } hitcount:          2
+      { id: sys_eventfd2                  [290], common_pid: ibus-ui-gtk3    [      2760] } hitcount:          4
+      { id: sys_eventfd2                  [290], common_pid: compiz          [      2994] } hitcount:          6
+
+      Totals:
+          Hits: 31536
+          Entries: 323
+          Dropped: 0
+
+  The above list does give us a breakdown of the ioctl syscall by
+  pid, but it also gives us quite a bit more than that, which we
+  don't really care about at the moment.  Since we know the syscall
+  id for sys_ioctl (16, displayed next to the sys_ioctl name), we
+  can use that to filter out all the other syscalls::
+
+      # echo 'hist:key=id.syscall,common_pid.execname:val=hitcount:sort=id,hitcount if id == 16' > \
+             /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger
+
+      # cat /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/hist
+      # trigger info: hist:keys=id.syscall,common_pid.execname:vals=hitcount:sort=id.syscall,hitcount:size=2048 if id == 16 [active]
+
+      { id: sys_ioctl                     [ 16], common_pid: gmain           [      2769] } hitcount:          1
+      { id: sys_ioctl                     [ 16], common_pid: evolution-addre [      8571] } hitcount:          1
+      { id: sys_ioctl                     [ 16], common_pid: gmain           [      3003] } hitcount:          1
+      { id: sys_ioctl                     [ 16], common_pid: gmain           [      2781] } hitcount:          1
+      { id: sys_ioctl                     [ 16], common_pid: gmain           [      2829] } hitcount:          1
+      { id: sys_ioctl                     [ 16], common_pid: bash            [      8726] } hitcount:          1
+      { id: sys_ioctl                     [ 16], common_pid: bash            [      8508] } hitcount:          1
+      { id: sys_ioctl                     [ 16], common_pid: gmain           [      2970] } hitcount:          1
+      { id: sys_ioctl                     [ 16], common_pid: gmain           [      2768] } hitcount:          1
+      .
+      .
+      .
+      { id: sys_ioctl                     [ 16], common_pid: pool            [      8559] } hitcount:         45
+      { id: sys_ioctl                     [ 16], common_pid: pool            [      8555] } hitcount:         48
+      { id: sys_ioctl                     [ 16], common_pid: pool            [      8551] } hitcount:         48
+      { id: sys_ioctl                     [ 16], common_pid: avahi-daemon    [       896] } hitcount:         66
+      { id: sys_ioctl                     [ 16], common_pid: Xorg            [      1267] } hitcount:      26674
+      { id: sys_ioctl                     [ 16], common_pid: compiz          [      2994] } hitcount:      73443
+
+      Totals:
+          Hits: 101162
+          Entries: 103
+          Dropped: 0
+
+  The above output shows that 'compiz' and 'Xorg' are far and away
+  the heaviest ioctl callers (which might lead to questions about
+  whether they really need to be making all those calls and to
+  possible avenues for further investigation.)
+
+  The compound key examples used a key and a sum value (hitcount) to
+  sort the output, but we can just as easily use two keys instead.
+  Here's an example where we use a compound key composed of the the
+  common_pid and size event fields.  Sorting with pid as the primary
+  key and 'size' as the secondary key allows us to display an
+  ordered summary of the recvfrom sizes, with counts, received by
+  each process::
+
+      # echo 'hist:key=common_pid.execname,size:val=hitcount:sort=common_pid,size' > \
+             /sys/kernel/debug/tracing/events/syscalls/sys_enter_recvfrom/trigger
+
+      # cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_recvfrom/hist
+      # trigger info: hist:keys=common_pid.execname,size:vals=hitcount:sort=common_pid.execname,size:size=2048 [active]
+
+      { common_pid: smbd            [       784], size:          4 } hitcount:          1
+      { common_pid: dnsmasq         [      1412], size:       4096 } hitcount:        672
+      { common_pid: postgres        [      1796], size:       1000 } hitcount:          6
+      { common_pid: postgres        [      1867], size:       1000 } hitcount:         10
+      { common_pid: bamfdaemon      [      2787], size:         28 } hitcount:          2
+      { common_pid: bamfdaemon      [      2787], size:      14360 } hitcount:          1
+      { common_pid: compiz          [      2994], size:          8 } hitcount:          1
+      { common_pid: compiz          [      2994], size:         20 } hitcount:         11
+      { common_pid: gnome-terminal  [      3199], size:          4 } hitcount:          2
+      { common_pid: firefox         [      8817], size:          4 } hitcount:          1
+      { common_pid: firefox         [      8817], size:          8 } hitcount:          5
+      { common_pid: firefox         [      8817], size:        588 } hitcount:          2
+      { common_pid: firefox         [      8817], size:        628 } hitcount:          1
+      { common_pid: firefox         [      8817], size:       6944 } hitcount:          1
+      { common_pid: firefox         [      8817], size:     408880 } hitcount:          2
+      { common_pid: firefox         [      8822], size:          8 } hitcount:          2
+      { common_pid: firefox         [      8822], size:        160 } hitcount:          2
+      { common_pid: firefox         [      8822], size:        320 } hitcount:          2
+      { common_pid: firefox         [      8822], size:        352 } hitcount:          1
+      .
+      .
+      .
+      { common_pid: pool            [      8923], size:       1960 } hitcount:         10
+      { common_pid: pool            [      8923], size:       2048 } hitcount:         10
+      { common_pid: pool            [      8924], size:       1960 } hitcount:         10
+      { common_pid: pool            [      8924], size:       2048 } hitcount:         10
+      { common_pid: pool            [      8928], size:       1964 } hitcount:          4
+      { common_pid: pool            [      8928], size:       1965 } hitcount:          2
+      { common_pid: pool            [      8928], size:       2048 } hitcount:          6
+      { common_pid: pool            [      8929], size:       1982 } hitcount:          1
+      { common_pid: pool            [      8929], size:       2048 } hitcount:          1
+
+      Totals:
+          Hits: 2016
+          Entries: 224
+          Dropped: 0
 
   The above example also illustrates the fact that although a compound
   key is treated as a single entity for hashing purposes, the sub-keys
@@ -1354,7 +1357,7 @@ The following commands are supported:
   demonstrates how you can manually pause and continue a hist trigger.
   In this example, we'll aggregate fork counts and don't expect a
   large number of entries in the hash table, so we'll drop it to a
-  much smaller number, say 256:
+  much smaller number, say 256::
 
     # echo 'hist:key=child_comm:val=hitcount:size=256' > \
            /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
@@ -1390,7 +1393,7 @@ The following commands are supported:
 
   If we want to pause the hist trigger, we can simply append :pause to
   the command that started the trigger.  Notice that the trigger info
-  displays as [paused]:
+  displays as [paused]::
 
     # echo 'hist:key=child_comm:val=hitcount:size=256:pause' >> \
            /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
@@ -1427,7 +1430,7 @@ The following commands are supported:
 
   To manually continue having the trigger aggregate events, append
   :cont instead.  Notice that the trigger info displays as [active]
-  again, and the data has changed:
+  again, and the data has changed::
 
     # echo 'hist:key=child_comm:val=hitcount:size=256:cont' >> \
            /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
@@ -1481,7 +1484,7 @@ The following commands are supported:
   wget.
 
   First we set up an initially paused stacktrace trigger on the
-  netif_receive_skb event:
+  netif_receive_skb event::
 
     # echo 'hist:key=stacktrace:vals=len:pause' > \
            /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
@@ -1492,7 +1495,7 @@ The following commands are supported:
   set up on netif_receive_skb if and only if it sees a
   sched_process_exec event with a filename of '/usr/bin/wget'.  When
   that happens, all netif_receive_skb events are aggregated into a
-  hash table keyed on stacktrace:
+  hash table keyed on stacktrace::
 
     # echo 'enable_hist:net:netif_receive_skb if filename==/usr/bin/wget' > \
            /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
@@ -1500,7 +1503,7 @@ The following commands are supported:
   The aggregation continues until the netif_receive_skb is paused
   again, which is what the following disable_hist event does by
   creating a similar setup on the sched_process_exit event, using the
-  filter 'comm==wget':
+  filter 'comm==wget'::
 
     # echo 'disable_hist:net:netif_receive_skb if comm==wget' > \
            /sys/kernel/debug/tracing/events/sched/sched_process_exit/trigger
@@ -1512,7 +1515,7 @@ The following commands are supported:
   The overall effect is that netif_receive_skb events are aggregated
   into the hash table for only the duration of the wget.  Executing a
   wget command and then listing the 'hist' file will display the
-  output generated by the wget command:
+  output generated by the wget command::
 
     $ wget https://www.kernel.org/pub/linux/kernel/v3.x/patch-3.19.xz
 
@@ -1597,13 +1600,13 @@ The following commands are supported:
   Suppose we wanted to try another run of the previous example but
   this time also wanted to see the complete list of events that went
   into the histogram.  In order to avoid having to set everything up
-  again, we can just clear the histogram first:
+  again, we can just clear the histogram first::
 
     # echo 'hist:key=stacktrace:vals=len:clear' >> \
            /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
 
   Just to verify that it is in fact cleared, here's what we now see in
-  the hist file:
+  the hist file::
 
     # cat /sys/kernel/debug/tracing/events/net/netif_receive_skb/hist
     # trigger info: hist:keys=stacktrace:vals=len:sort=hitcount:size=2048 [paused]
@@ -1617,7 +1620,7 @@ The following commands are supported:
   event occurring during the new run, which are in fact the same
   events being aggregated into the hash table, we add some additional
   'enable_event' events to the triggering sched_process_exec and
-  sched_process_exit events as such:
+  sched_process_exit events as such::
 
     # echo 'enable_event:net:netif_receive_skb if filename==/usr/bin/wget' > \
            /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
@@ -1628,7 +1631,7 @@ The following commands are supported:
   If you read the trigger files for the sched_process_exec and
   sched_process_exit triggers, you should see two triggers for each:
   one enabling/disabling the hist aggregation and the other
-  enabling/disabling the logging of events:
+  enabling/disabling the logging of events::
 
     # cat /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
     enable_event:net:netif_receive_skb:unlimited if filename==/usr/bin/wget
@@ -1642,13 +1645,13 @@ The following commands are supported:
   sched_process_exit events is hit and matches 'wget', it enables or
   disables both the histogram and the event log, and what you end up
   with is a hash table and set of events just covering the specified
-  duration.  Run the wget command again:
+  duration.  Run the wget command again::
 
     $ wget https://www.kernel.org/pub/linux/kernel/v3.x/patch-3.19.xz
 
   Displaying the 'hist' file should show something similar to what you
   saw in the last run, but this time you should also see the
-  individual events in the trace file:
+  individual events in the trace file::
 
     # cat /sys/kernel/debug/tracing/trace
 
@@ -1673,15 +1676,15 @@ The following commands are supported:
       irq/29-iwlwifi-559   [002] ..s. 31772.032196: netif_receive_skb: dev=wlan0 skbaddr=ffff88009d433100 len=2948
       irq/29-iwlwifi-559   [002] ..s. 31772.032761: netif_receive_skb: dev=wlan0 skbaddr=ffff88009d433000 len=2948
       irq/29-iwlwifi-559   [002] ..s. 31772.033220: netif_receive_skb: dev=wlan0 skbaddr=ffff88009d432e00 len=1500
-    .
-    .
-    .
+    ....
+
 
   The following example demonstrates how multiple hist triggers can be
   attached to a given event.  This capability can be useful for
   creating a set of different summaries derived from the same set of
   events, or for comparing the effects of different filters, among
   other things.
+  ::
 
     # echo 'hist:keys=skbaddr.hex:vals=len if len < 0' >> \
            /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
@@ -1702,7 +1705,7 @@ The following commands are supported:
   any existing hist triggers beforehand).
 
   Displaying the contents of the 'hist' file for the event shows the
-  contents of all five histograms:
+  contents of all five histograms::
 
     # cat /sys/kernel/debug/tracing/events/net/netif_receive_skb/hist
 
@@ -1822,7 +1825,7 @@ The following commands are supported:
   output of events generated by tracepoints contained inside inline
   functions, but names can be used in a hist trigger on any event.
   For example, these two triggers when hit will update the same 'len'
-  field in the shared 'foo' histogram data:
+  field in the shared 'foo' histogram data::
 
     # echo 'hist:name=foo:keys=skbaddr.hex:vals=len' > \
            /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
@@ -1830,7 +1833,7 @@ The following commands are supported:
            /sys/kernel/debug/tracing/events/net/netif_rx/trigger
 
   You can see that they're updating common histogram data by reading
-  each event's hist files at the same time:
+  each event's hist files at the same time::
 
     # cat /sys/kernel/debug/tracing/events/net/netif_receive_skb/hist;
       cat /sys/kernel/debug/tracing/events/net/netif_rx/hist
@@ -1943,7 +1946,7 @@ The following commands are supported:
   And here's an example that shows how to combine histogram data from
   any two events even if they don't share any 'compatible' fields
   other than 'hitcount' and 'stacktrace'.  These commands create a
-  couple of triggers named 'bar' using those fields:
+  couple of triggers named 'bar' using those fields::
 
     # echo 'hist:name=bar:key=stacktrace:val=hitcount' > \
            /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
@@ -1951,7 +1954,7 @@ The following commands are supported:
           /sys/kernel/debug/tracing/events/net/netif_rx/trigger
 
   And displaying the output of either shows some interesting if
-  somewhat confusing output:
+  somewhat confusing output::
 
     # cat /sys/kernel/debug/tracing/events/sched/sched_process_fork/hist
     # cat /sys/kernel/debug/tracing/events/net/netif_rx/hist
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index c8bbdfc..b1cb484 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -12,3 +12,4 @@ Linux Tracing Technologies
    kprobetrace
    uprobetracer
    tracepoints
+   events
-- 
2.7.4
