Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbeDIRXQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 13:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751505AbeDIRXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 13:23:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EE820838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 9 Apr 2018 13:23:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Updates for v4.17
Message-ID: <20180409132305.16e8f956@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

New features:

 - Tom Zanussi's extended histogram work
   This adds the synthetic events to have histograms from multiple event data
   Adds triggers "onmatch" and "onmax" to call the synthetic events
   Several updates to the histogram code from this

 - Allow way to nest ring buffer calls in the same context

 - Allow absolute time stamps in ring buffer

 - Rewrite of filter code parsing based on Al Viro's suggestions

 - Setting of trace_clock to global if TSC is unstable (on boot)

 - Better OOM handling when allocating large ring buffers

 - Added initcall tracepoints (consolidated initcall_debug code with them)

And other various fixes and clean ups


Please pull the latest trace-v4.17 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.17

Tag SHA1: 54407c728fabad9047695c2c534df652c0a156ad
Head SHA1: b0dc52f15e7fe2b973ecfe4f3706f1b35ce3943a


Abderrahmane Benbachir (1):
      init, tracing: instrument security and console initcall trace events

Chris Wilson (3):
      tracing: Default to using trace_global_clock if sched_clock is unstable
      tracing: Mention trace_clock=global when warning about unstable clocks
      tracing: Fixup logic inversion on setting trace_global_clock defaults

Dan Carpenter (2):
      tracing: Fix a potential NULL dereference
      tracing: Uninitialized variable in create_tracing_map_fields()

Rajvi Jingar (1):
      selftests: ftrace: Add inter-event hist triggers testcases

Salvatore Mesoraca (1):
      ftrace: Drop a VLA in module_exists()

Steven Rostedt (VMware) (21):
      ring-buffer: Add nesting for adding events within events
      tracing: Use the ring-buffer nesting to allow synthetic events to be traced
      tracing: Remove BUG_ON() from append_filter_string()
      tracing: Use trace_seq instead of open code string appending
      tracing: Remove filter allocator helper
      tracing: Only add filter list when needed
      tracing: Embed replace_filter_string() helper function
      tracing: Combine enum and arrays into single macro in filter code
      tracing: Clean up and document pred_funcs_##type creation and use
      tracing: Rewrite filter logic to be simpler and faster
      init: Fix initcall0 name as it is "pure" not "early"
      vsprintf: Do not preprocess non-dereferenced pointers for bprintf (%px and %pK)
      lockdep: Add print_irqtrace_events() to __warn
      ring-buffer: Check if memory is available before allocation
      ring-buffer: Add set/clear_current_oom_origin() during allocations
      tracing: Hide global trace clock from lockdep
      tracing: Add rcu dereference annotation for filter->prog
      tracing: Add rcu dereference annotation for test func that touches filter->prog
      init, tracing: Add initcall trace events
      init, tracing: Have printk come through the trace events for initcall_debug
      init: Have initcall_debug still work without CONFIG_TRACEPOINTS

Tom Zanussi (37):
      tracing: Move hist trigger Documentation to histogram.txt
      tracing: Add Documentation for log2 modifier
      ring-buffer: Add interface for setting absolute time stamps
      ring-buffer: Redefine the unimplemented RINGBUF_TYPE_TIME_STAMP
      tracing: Add timestamp_mode trace file
      tracing: Give event triggers access to ring_buffer_event
      tracing: Add ring buffer event param to hist field functions
      tracing: Break out hist trigger assignment parsing
      tracing: Add hist trigger timestamp support
      tracing: Add per-element variable support to tracing_map
      tracing: Add hist_data member to hist_field
      tracing: Add usecs modifier for hist trigger timestamps
      tracing: Add variable support to hist triggers
      tracing: Account for variables in named trigger compatibility
      tracing: Move get_hist_field_flags()
      tracing: Add simple expression support to hist triggers
      tracing: Generalize per-element hist trigger data
      tracing: Pass tracing_map_elt to hist_field accessor functions
      tracing: Add hist_field 'type' field
      tracing: Add variable reference handling to hist triggers
      tracing: Add hist trigger action hook
      tracing: Add support for 'synthetic' events
      tracing: Add support for 'field variables'
      tracing: Add 'onmatch' hist trigger action support
      tracing: Add 'onmax' hist trigger action support
      tracing: Allow whitespace to surround hist trigger filter
      tracing: Add cpu field for hist triggers
      tracing: Add hist trigger support for variable reference aliases
      tracing: Add 'last error' error facility for hist triggers
      tracing: Add inter-event hist trigger Documentation
      tracing: Make tracing_set_clock() non-static
      tracing: Add a clock attribute for hist triggers
      tracing: Add inter-event blurb to HIST_TRIGGERS config option
      tracing: Fix display of hist trigger expressions containing timestamps
      tracing: Don't add flag strings when displaying variable references
      tracing: Add action comparisons when testing matching hist triggers
      tracing: Make sure variable string fields are NULL-terminated

Vedang Patel (2):
      tracing: Add support to detect and avoid duplicates
      tracing: Remove code which merges duplicates

----
 Documentation/trace/events.txt                     | 1548 +------
 Documentation/trace/ftrace.txt                     |   24 +
 Documentation/trace/histogram.txt                  | 1995 ++++++++
 include/linux/ring_buffer.h                        |   17 +-
 include/linux/trace_events.h                       |   14 +-
 include/trace/events/initcall.h                    |   66 +
 init/main.c                                        |   84 +-
 kernel/panic.c                                     |    2 +
 kernel/printk/printk.c                             |    7 +-
 kernel/trace/Kconfig                               |    5 +-
 kernel/trace/ftrace.c                              |    7 +-
 kernel/trace/ring_buffer.c                         |  226 +-
 kernel/trace/trace.c                               |  116 +-
 kernel/trace/trace.h                               |   33 +-
 kernel/trace/trace_clock.c                         |    4 +-
 kernel/trace/trace_events_filter.c                 | 2501 +++++-----
 kernel/trace/trace_events_hist.c                   | 4782 ++++++++++++++++++--
 kernel/trace/trace_events_trigger.c                |   53 +-
 kernel/trace/tracing_map.c                         |  232 +-
 kernel/trace/tracing_map.h                         |   18 +-
 lib/vsprintf.c                                     |    4 +
 security/security.c                                |    8 +-
 tools/testing/selftests/ftrace/test.d/functions    |    7 +
 .../inter-event/trigger-extended-error-support.tc  |   39 +
 .../inter-event/trigger-field-variable-support.tc  |   54 +
 .../trigger-inter-event-combined-hist.tc           |   58 +
 .../inter-event/trigger-onmatch-action-hist.tc     |   50 +
 .../trigger-onmatch-onmax-action-hist.tc           |   50 +
 .../inter-event/trigger-onmax-action-hist.tc       |   48 +
 .../trigger-synthetic-event-createremove.tc        |   54 +
 30 files changed, 8605 insertions(+), 3501 deletions(-)
 create mode 100644 Documentation/trace/histogram.txt
 create mode 100644 include/trace/events/initcall.h
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
---------------------------
diff --git a/Documentation/trace/events.txt b/Documentation/trace/events.txt
index 2cc08d4a326e..e28f7f29f2b3 100644
--- a/Documentation/trace/events.txt
+++ b/Documentation/trace/events.txt
@@ -517,1550 +517,4 @@ The following commands are supported:
   totals derived from one or more trace event format fields and/or
   event counts (hitcount).
 
-  The format of a hist trigger is as follows:
-
-        hist:keys=<field1[,field2,...]>[:values=<field1[,field2,...]>]
-          [:sort=<field1[,field2,...]>][:size=#entries][:pause][:continue]
-          [:clear][:name=histname1] [if <filter>]
-
-  When a matching event is hit, an entry is added to a hash table
-  using the key(s) and value(s) named.  Keys and values correspond to
-  fields in the event's format description.  Values must correspond to
-  numeric fields - on an event hit, the value(s) will be added to a
-  sum kept for that field.  The special string 'hitcount' can be used
-  in place of an explicit value field - this is simply a count of
-  event hits.  If 'values' isn't specified, an implicit 'hitcount'
-  value will be automatically created and used as the only value.
-  Keys can be any field, or the special string 'stacktrace', which
-  will use the event's kernel stacktrace as the key.  The keywords
-  'keys' or 'key' can be used to specify keys, and the keywords
-  'values', 'vals', or 'val' can be used to specify values.  Compound
-  keys consisting of up to two fields can be specified by the 'keys'
-  keyword.  Hashing a compound key produces a unique entry in the
-  table for each unique combination of component keys, and can be
-  useful for providing more fine-grained summaries of event data.
-  Additionally, sort keys consisting of up to two fields can be
-  specified by the 'sort' keyword.  If more than one field is
-  specified, the result will be a 'sort within a sort': the first key
-  is taken to be the primary sort key and the second the secondary
-  key.  If a hist trigger is given a name using the 'name' parameter,
-  its histogram data will be shared with other triggers of the same
-  name, and trigger hits will update this common data.  Only triggers
-  with 'compatible' fields can be combined in this way; triggers are
-  'compatible' if the fields named in the trigger share the same
-  number and type of fields and those fields also have the same names.
-  Note that any two events always share the compatible 'hitcount' and
-  'stacktrace' fields and can therefore be combined using those
-  fields, however pointless that may be.
-
-  'hist' triggers add a 'hist' file to each event's subdirectory.
-  Reading the 'hist' file for the event will dump the hash table in
-  its entirety to stdout.  If there are multiple hist triggers
-  attached to an event, there will be a table for each trigger in the
-  output.  The table displayed for a named trigger will be the same as
-  any other instance having the same name. Each printed hash table
-  entry is a simple list of the keys and values comprising the entry;
-  keys are printed first and are delineated by curly braces, and are
-  followed by the set of value fields for the entry.  By default,
-  numeric fields are displayed as base-10 integers.  This can be
-  modified by appending any of the following modifiers to the field
-  name:
-
-        .hex        display a number as a hex value
-	.sym        display an address as a symbol
-	.sym-offset display an address as a symbol and offset
-	.syscall    display a syscall id as a system call name
-	.execname   display a common_pid as a program name
-
-  Note that in general the semantics of a given field aren't
-  interpreted when applying a modifier to it, but there are some
-  restrictions to be aware of in this regard:
-
-    - only the 'hex' modifier can be used for values (because values
-      are essentially sums, and the other modifiers don't make sense
-      in that context).
-    - the 'execname' modifier can only be used on a 'common_pid'.  The
-      reason for this is that the execname is simply the 'comm' value
-      saved for the 'current' process when an event was triggered,
-      which is the same as the common_pid value saved by the event
-      tracing code.  Trying to apply that comm value to other pid
-      values wouldn't be correct, and typically events that care save
-      pid-specific comm fields in the event itself.
-
-  A typical usage scenario would be the following to enable a hist
-  trigger, read its current contents, and then turn it off:
-
-  # echo 'hist:keys=skbaddr.hex:vals=len' > \
-    /sys/kernel/debug/tracing/events/net/netif_rx/trigger
-
-  # cat /sys/kernel/debug/tracing/events/net/netif_rx/hist
-
-  # echo '!hist:keys=skbaddr.hex:vals=len' > \
-    /sys/kernel/debug/tracing/events/net/netif_rx/trigger
-
-  The trigger file itself can be read to show the details of the
-  currently attached hist trigger.  This information is also displayed
-  at the top of the 'hist' file when read.
-
-  By default, the size of the hash table is 2048 entries.  The 'size'
-  parameter can be used to specify more or fewer than that.  The units
-  are in terms of hashtable entries - if a run uses more entries than
-  specified, the results will show the number of 'drops', the number
-  of hits that were ignored.  The size should be a power of 2 between
-  128 and 131072 (any non- power-of-2 number specified will be rounded
-  up).
-
-  The 'sort' parameter can be used to specify a value field to sort
-  on.  The default if unspecified is 'hitcount' and the default sort
-  order is 'ascending'.  To sort in the opposite direction, append
-  .descending' to the sort key.
-
-  The 'pause' parameter can be used to pause an existing hist trigger
-  or to start a hist trigger but not log any events until told to do
-  so.  'continue' or 'cont' can be used to start or restart a paused
-  hist trigger.
-
-  The 'clear' parameter will clear the contents of a running hist
-  trigger and leave its current paused/active state.
-
-  Note that the 'pause', 'cont', and 'clear' parameters should be
-  applied using 'append' shell operator ('>>') if applied to an
-  existing trigger, rather than via the '>' operator, which will cause
-  the trigger to be removed through truncation.
-
-- enable_hist/disable_hist
-
-  The enable_hist and disable_hist triggers can be used to have one
-  event conditionally start and stop another event's already-attached
-  hist trigger.  Any number of enable_hist and disable_hist triggers
-  can be attached to a given event, allowing that event to kick off
-  and stop aggregations on a host of other events.
-
-  The format is very similar to the enable/disable_event triggers:
-
-      enable_hist:<system>:<event>[:count]
-      disable_hist:<system>:<event>[:count]
-
-  Instead of enabling or disabling the tracing of the target event
-  into the trace buffer as the enable/disable_event triggers do, the
-  enable/disable_hist triggers enable or disable the aggregation of
-  the target event into a hash table.
-
-  A typical usage scenario for the enable_hist/disable_hist triggers
-  would be to first set up a paused hist trigger on some event,
-  followed by an enable_hist/disable_hist pair that turns the hist
-  aggregation on and off when conditions of interest are hit:
-
-  # echo 'hist:keys=skbaddr.hex:vals=len:pause' > \
-    /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
-
-  # echo 'enable_hist:net:netif_receive_skb if filename==/usr/bin/wget' > \
-    /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
-
-  # echo 'disable_hist:net:netif_receive_skb if comm==wget' > \
-    /sys/kernel/debug/tracing/events/sched/sched_process_exit/trigger
-
-  The above sets up an initially paused hist trigger which is unpaused
-  and starts aggregating events when a given program is executed, and
-  which stops aggregating when the process exits and the hist trigger
-  is paused again.
-
-  The examples below provide a more concrete illustration of the
-  concepts and typical usage patterns discussed above.
-
-
-6.2 'hist' trigger examples
----------------------------
-
-  The first set of examples creates aggregations using the kmalloc
-  event.  The fields that can be used for the hist trigger are listed
-  in the kmalloc event's format file:
-
-    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/format
-    name: kmalloc
-    ID: 374
-    format:
-	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
-	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
-	field:unsigned char common_preempt_count;		offset:3;	size:1;	signed:0;
-	field:int common_pid;					offset:4;	size:4;	signed:1;
-
-	field:unsigned long call_site;				offset:8;	size:8;	signed:0;
-	field:const void * ptr;					offset:16;	size:8;	signed:0;
-	field:size_t bytes_req;					offset:24;	size:8;	signed:0;
-	field:size_t bytes_alloc;				offset:32;	size:8;	signed:0;
-	field:gfp_t gfp_flags;					offset:40;	size:4;	signed:0;
-
-  We'll start by creating a hist trigger that generates a simple table
-  that lists the total number of bytes requested for each function in
-  the kernel that made one or more calls to kmalloc:
-
-    # echo 'hist:key=call_site:val=bytes_req' > \
-            /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
-
-  This tells the tracing system to create a 'hist' trigger using the
-  call_site field of the kmalloc event as the key for the table, which
-  just means that each unique call_site address will have an entry
-  created for it in the table.  The 'val=bytes_req' parameter tells
-  the hist trigger that for each unique entry (call_site) in the
-  table, it should keep a running total of the number of bytes
-  requested by that call_site.
-
-  We'll let it run for awhile and then dump the contents of the 'hist'
-  file in the kmalloc event's subdirectory (for readability, a number
-  of entries have been omitted):
-
-    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
-    # trigger info: hist:keys=call_site:vals=bytes_req:sort=hitcount:size=2048 [active]
-
-    { call_site: 18446744072106379007 } hitcount:          1  bytes_req:        176
-    { call_site: 18446744071579557049 } hitcount:          1  bytes_req:       1024
-    { call_site: 18446744071580608289 } hitcount:          1  bytes_req:      16384
-    { call_site: 18446744071581827654 } hitcount:          1  bytes_req:         24
-    { call_site: 18446744071580700980 } hitcount:          1  bytes_req:          8
-    { call_site: 18446744071579359876 } hitcount:          1  bytes_req:        152
-    { call_site: 18446744071580795365 } hitcount:          3  bytes_req:        144
-    { call_site: 18446744071581303129 } hitcount:          3  bytes_req:        144
-    { call_site: 18446744071580713234 } hitcount:          4  bytes_req:       2560
-    { call_site: 18446744071580933750 } hitcount:          4  bytes_req:        736
-    .
-    .
-    .
-    { call_site: 18446744072106047046 } hitcount:         69  bytes_req:       5576
-    { call_site: 18446744071582116407 } hitcount:         73  bytes_req:       2336
-    { call_site: 18446744072106054684 } hitcount:        136  bytes_req:     140504
-    { call_site: 18446744072106224230 } hitcount:        136  bytes_req:      19584
-    { call_site: 18446744072106078074 } hitcount:        153  bytes_req:       2448
-    { call_site: 18446744072106062406 } hitcount:        153  bytes_req:      36720
-    { call_site: 18446744071582507929 } hitcount:        153  bytes_req:      37088
-    { call_site: 18446744072102520590 } hitcount:        273  bytes_req:      10920
-    { call_site: 18446744071582143559 } hitcount:        358  bytes_req:        716
-    { call_site: 18446744072106465852 } hitcount:        417  bytes_req:      56712
-    { call_site: 18446744072102523378 } hitcount:        485  bytes_req:      27160
-    { call_site: 18446744072099568646 } hitcount:       1676  bytes_req:      33520
-
-    Totals:
-        Hits: 4610
-        Entries: 45
-        Dropped: 0
-
-  The output displays a line for each entry, beginning with the key
-  specified in the trigger, followed by the value(s) also specified in
-  the trigger.  At the beginning of the output is a line that displays
-  the trigger info, which can also be displayed by reading the
-  'trigger' file:
-
-    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
-    hist:keys=call_site:vals=bytes_req:sort=hitcount:size=2048 [active]
-
-  At the end of the output are a few lines that display the overall
-  totals for the run.  The 'Hits' field shows the total number of
-  times the event trigger was hit, the 'Entries' field shows the total
-  number of used entries in the hash table, and the 'Dropped' field
-  shows the number of hits that were dropped because the number of
-  used entries for the run exceeded the maximum number of entries
-  allowed for the table (normally 0, but if not a hint that you may
-  want to increase the size of the table using the 'size' parameter).
-
-  Notice in the above output that there's an extra field, 'hitcount',
-  which wasn't specified in the trigger.  Also notice that in the
-  trigger info output, there's a parameter, 'sort=hitcount', which
-  wasn't specified in the trigger either.  The reason for that is that
-  every trigger implicitly keeps a count of the total number of hits
-  attributed to a given entry, called the 'hitcount'.  That hitcount
-  information is explicitly displayed in the output, and in the
-  absence of a user-specified sort parameter, is used as the default
-  sort field.
-
-  The value 'hitcount' can be used in place of an explicit value in
-  the 'values' parameter if you don't really need to have any
-  particular field summed and are mainly interested in hit
-  frequencies.
-
-  To turn the hist trigger off, simply call up the trigger in the
-  command history and re-execute it with a '!' prepended:
-
-    # echo '!hist:key=call_site:val=bytes_req' > \
-           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
-
-  Finally, notice that the call_site as displayed in the output above
-  isn't really very useful.  It's an address, but normally addresses
-  are displayed in hex.  To have a numeric field displayed as a hex
-  value, simply append '.hex' to the field name in the trigger:
-
-    # echo 'hist:key=call_site.hex:val=bytes_req' > \
-           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
-
-    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
-    # trigger info: hist:keys=call_site.hex:vals=bytes_req:sort=hitcount:size=2048 [active]
-
-    { call_site: ffffffffa026b291 } hitcount:          1  bytes_req:        433
-    { call_site: ffffffffa07186ff } hitcount:          1  bytes_req:        176
-    { call_site: ffffffff811ae721 } hitcount:          1  bytes_req:      16384
-    { call_site: ffffffff811c5134 } hitcount:          1  bytes_req:          8
-    { call_site: ffffffffa04a9ebb } hitcount:          1  bytes_req:        511
-    { call_site: ffffffff8122e0a6 } hitcount:          1  bytes_req:         12
-    { call_site: ffffffff8107da84 } hitcount:          1  bytes_req:        152
-    { call_site: ffffffff812d8246 } hitcount:          1  bytes_req:         24
-    { call_site: ffffffff811dc1e5 } hitcount:          3  bytes_req:        144
-    { call_site: ffffffffa02515e8 } hitcount:          3  bytes_req:        648
-    { call_site: ffffffff81258159 } hitcount:          3  bytes_req:        144
-    { call_site: ffffffff811c80f4 } hitcount:          4  bytes_req:        544
-    .
-    .
-    .
-    { call_site: ffffffffa06c7646 } hitcount:        106  bytes_req:       8024
-    { call_site: ffffffffa06cb246 } hitcount:        132  bytes_req:      31680
-    { call_site: ffffffffa06cef7a } hitcount:        132  bytes_req:       2112
-    { call_site: ffffffff8137e399 } hitcount:        132  bytes_req:      23232
-    { call_site: ffffffffa06c941c } hitcount:        185  bytes_req:     171360
-    { call_site: ffffffffa06f2a66 } hitcount:        185  bytes_req:      26640
-    { call_site: ffffffffa036a70e } hitcount:        265  bytes_req:      10600
-    { call_site: ffffffff81325447 } hitcount:        292  bytes_req:        584
-    { call_site: ffffffffa072da3c } hitcount:        446  bytes_req:      60656
-    { call_site: ffffffffa036b1f2 } hitcount:        526  bytes_req:      29456
-    { call_site: ffffffffa0099c06 } hitcount:       1780  bytes_req:      35600
-
-    Totals:
-        Hits: 4775
-        Entries: 46
-        Dropped: 0
-
-  Even that's only marginally more useful - while hex values do look
-  more like addresses, what users are typically more interested in
-  when looking at text addresses are the corresponding symbols
-  instead.  To have an address displayed as symbolic value instead,
-  simply append '.sym' or '.sym-offset' to the field name in the
-  trigger:
-
-    # echo 'hist:key=call_site.sym:val=bytes_req' > \
-           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
-
-    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
-    # trigger info: hist:keys=call_site.sym:vals=bytes_req:sort=hitcount:size=2048 [active]
-
-    { call_site: [ffffffff810adcb9] syslog_print_all                              } hitcount:          1  bytes_req:       1024
-    { call_site: [ffffffff8154bc62] usb_control_msg                               } hitcount:          1  bytes_req:          8
-    { call_site: [ffffffffa00bf6fe] hidraw_send_report [hid]                      } hitcount:          1  bytes_req:          7
-    { call_site: [ffffffff8154acbe] usb_alloc_urb                                 } hitcount:          1  bytes_req:        192
-    { call_site: [ffffffffa00bf1ca] hidraw_report_event [hid]                     } hitcount:          1  bytes_req:          7
-    { call_site: [ffffffff811e3a25] __seq_open_private                            } hitcount:          1  bytes_req:         40
-    { call_site: [ffffffff8109524a] alloc_fair_sched_group                        } hitcount:          2  bytes_req:        128
-    { call_site: [ffffffff811febd5] fsnotify_alloc_group                          } hitcount:          2  bytes_req:        528
-    { call_site: [ffffffff81440f58] __tty_buffer_request_room                     } hitcount:          2  bytes_req:       2624
-    { call_site: [ffffffff81200ba6] inotify_new_group                             } hitcount:          2  bytes_req:         96
-    { call_site: [ffffffffa05e19af] ieee80211_start_tx_ba_session [mac80211]      } hitcount:          2  bytes_req:        464
-    { call_site: [ffffffff81672406] tcp_get_metrics                               } hitcount:          2  bytes_req:        304
-    { call_site: [ffffffff81097ec2] alloc_rt_sched_group                          } hitcount:          2  bytes_req:        128
-    { call_site: [ffffffff81089b05] sched_create_group                            } hitcount:          2  bytes_req:       1424
-    .
-    .
-    .
-    { call_site: [ffffffffa04a580c] intel_crtc_page_flip [i915]                   } hitcount:       1185  bytes_req:     123240
-    { call_site: [ffffffffa0287592] drm_mode_page_flip_ioctl [drm]                } hitcount:       1185  bytes_req:     104280
-    { call_site: [ffffffffa04c4a3c] intel_plane_duplicate_state [i915]            } hitcount:       1402  bytes_req:     190672
-    { call_site: [ffffffff812891ca] ext4_find_extent                              } hitcount:       1518  bytes_req:     146208
-    { call_site: [ffffffffa029070e] drm_vma_node_allow [drm]                      } hitcount:       1746  bytes_req:      69840
-    { call_site: [ffffffffa045e7c4] i915_gem_do_execbuffer.isra.23 [i915]         } hitcount:       2021  bytes_req:     792312
-    { call_site: [ffffffffa02911f2] drm_modeset_lock_crtc [drm]                   } hitcount:       2592  bytes_req:     145152
-    { call_site: [ffffffffa0489a66] intel_ring_begin [i915]                       } hitcount:       2629  bytes_req:     378576
-    { call_site: [ffffffffa046041c] i915_gem_execbuffer2 [i915]                   } hitcount:       2629  bytes_req:    3783248
-    { call_site: [ffffffff81325607] apparmor_file_alloc_security                  } hitcount:       5192  bytes_req:      10384
-    { call_site: [ffffffffa00b7c06] hid_report_raw_event [hid]                    } hitcount:       5529  bytes_req:     110584
-    { call_site: [ffffffff8131ebf7] aa_alloc_task_context                         } hitcount:      21943  bytes_req:     702176
-    { call_site: [ffffffff8125847d] ext4_htree_store_dirent                       } hitcount:      55759  bytes_req:    5074265
-
-    Totals:
-        Hits: 109928
-        Entries: 71
-        Dropped: 0
-
-  Because the default sort key above is 'hitcount', the above shows a
-  the list of call_sites by increasing hitcount, so that at the bottom
-  we see the functions that made the most kmalloc calls during the
-  run.  If instead we we wanted to see the top kmalloc callers in
-  terms of the number of bytes requested rather than the number of
-  calls, and we wanted the top caller to appear at the top, we can use
-  the 'sort' parameter, along with the 'descending' modifier:
-
-    # echo 'hist:key=call_site.sym:val=bytes_req:sort=bytes_req.descending' > \
-           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
-
-    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
-    # trigger info: hist:keys=call_site.sym:vals=bytes_req:sort=bytes_req.descending:size=2048 [active]
-
-    { call_site: [ffffffffa046041c] i915_gem_execbuffer2 [i915]                   } hitcount:       2186  bytes_req:    3397464
-    { call_site: [ffffffffa045e7c4] i915_gem_do_execbuffer.isra.23 [i915]         } hitcount:       1790  bytes_req:     712176
-    { call_site: [ffffffff8125847d] ext4_htree_store_dirent                       } hitcount:       8132  bytes_req:     513135
-    { call_site: [ffffffff811e2a1b] seq_buf_alloc                                 } hitcount:        106  bytes_req:     440128
-    { call_site: [ffffffffa0489a66] intel_ring_begin [i915]                       } hitcount:       2186  bytes_req:     314784
-    { call_site: [ffffffff812891ca] ext4_find_extent                              } hitcount:       2174  bytes_req:     208992
-    { call_site: [ffffffff811ae8e1] __kmalloc                                     } hitcount:          8  bytes_req:     131072
-    { call_site: [ffffffffa04c4a3c] intel_plane_duplicate_state [i915]            } hitcount:        859  bytes_req:     116824
-    { call_site: [ffffffffa02911f2] drm_modeset_lock_crtc [drm]                   } hitcount:       1834  bytes_req:     102704
-    { call_site: [ffffffffa04a580c] intel_crtc_page_flip [i915]                   } hitcount:        972  bytes_req:     101088
-    { call_site: [ffffffffa0287592] drm_mode_page_flip_ioctl [drm]                } hitcount:        972  bytes_req:      85536
-    { call_site: [ffffffffa00b7c06] hid_report_raw_event [hid]                    } hitcount:       3333  bytes_req:      66664
-    { call_site: [ffffffff8137e559] sg_kmalloc                                    } hitcount:        209  bytes_req:      61632
-    .
-    .
-    .
-    { call_site: [ffffffff81095225] alloc_fair_sched_group                        } hitcount:          2  bytes_req:        128
-    { call_site: [ffffffff81097ec2] alloc_rt_sched_group                          } hitcount:          2  bytes_req:        128
-    { call_site: [ffffffff812d8406] copy_semundo                                  } hitcount:          2  bytes_req:         48
-    { call_site: [ffffffff81200ba6] inotify_new_group                             } hitcount:          1  bytes_req:         48
-    { call_site: [ffffffffa027121a] drm_getmagic [drm]                            } hitcount:          1  bytes_req:         48
-    { call_site: [ffffffff811e3a25] __seq_open_private                            } hitcount:          1  bytes_req:         40
-    { call_site: [ffffffff811c52f4] bprm_change_interp                            } hitcount:          2  bytes_req:         16
-    { call_site: [ffffffff8154bc62] usb_control_msg                               } hitcount:          1  bytes_req:          8
-    { call_site: [ffffffffa00bf1ca] hidraw_report_event [hid]                     } hitcount:          1  bytes_req:          7
-    { call_site: [ffffffffa00bf6fe] hidraw_send_report [hid]                      } hitcount:          1  bytes_req:          7
-
-    Totals:
-        Hits: 32133
-        Entries: 81
-        Dropped: 0
-
-  To display the offset and size information in addition to the symbol
-  name, just use 'sym-offset' instead:
-
-    # echo 'hist:key=call_site.sym-offset:val=bytes_req:sort=bytes_req.descending' > \
-           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
-
-    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
-    # trigger info: hist:keys=call_site.sym-offset:vals=bytes_req:sort=bytes_req.descending:size=2048 [active]
-
-    { call_site: [ffffffffa046041c] i915_gem_execbuffer2+0x6c/0x2c0 [i915]                  } hitcount:       4569  bytes_req:    3163720
-    { call_site: [ffffffffa0489a66] intel_ring_begin+0xc6/0x1f0 [i915]                      } hitcount:       4569  bytes_req:     657936
-    { call_site: [ffffffffa045e7c4] i915_gem_do_execbuffer.isra.23+0x694/0x1020 [i915]      } hitcount:       1519  bytes_req:     472936
-    { call_site: [ffffffffa045e646] i915_gem_do_execbuffer.isra.23+0x516/0x1020 [i915]      } hitcount:       3050  bytes_req:     211832
-    { call_site: [ffffffff811e2a1b] seq_buf_alloc+0x1b/0x50                                 } hitcount:         34  bytes_req:     148384
-    { call_site: [ffffffffa04a580c] intel_crtc_page_flip+0xbc/0x870 [i915]                  } hitcount:       1385  bytes_req:     144040
-    { call_site: [ffffffff811ae8e1] __kmalloc+0x191/0x1b0                                   } hitcount:          8  bytes_req:     131072
-    { call_site: [ffffffffa0287592] drm_mode_page_flip_ioctl+0x282/0x360 [drm]              } hitcount:       1385  bytes_req:     121880
-    { call_site: [ffffffffa02911f2] drm_modeset_lock_crtc+0x32/0x100 [drm]                  } hitcount:       1848  bytes_req:     103488
-    { call_site: [ffffffffa04c4a3c] intel_plane_duplicate_state+0x2c/0xa0 [i915]            } hitcount:        461  bytes_req:      62696
-    { call_site: [ffffffffa029070e] drm_vma_node_allow+0x2e/0xd0 [drm]                      } hitcount:       1541  bytes_req:      61640
-    { call_site: [ffffffff815f8d7b] sk_prot_alloc+0xcb/0x1b0                                } hitcount:         57  bytes_req:      57456
-    .
-    .
-    .
-    { call_site: [ffffffff8109524a] alloc_fair_sched_group+0x5a/0x1a0                       } hitcount:          2  bytes_req:        128
-    { call_site: [ffffffffa027b921] drm_vm_open_locked+0x31/0xa0 [drm]                      } hitcount:          3  bytes_req:         96
-    { call_site: [ffffffff8122e266] proc_self_follow_link+0x76/0xb0                         } hitcount:          8  bytes_req:         96
-    { call_site: [ffffffff81213e80] load_elf_binary+0x240/0x1650                            } hitcount:          3  bytes_req:         84
-    { call_site: [ffffffff8154bc62] usb_control_msg+0x42/0x110                              } hitcount:          1  bytes_req:          8
-    { call_site: [ffffffffa00bf6fe] hidraw_send_report+0x7e/0x1a0 [hid]                     } hitcount:          1  bytes_req:          7
-    { call_site: [ffffffffa00bf1ca] hidraw_report_event+0x8a/0x120 [hid]                    } hitcount:          1  bytes_req:          7
-
-    Totals:
-        Hits: 26098
-        Entries: 64
-        Dropped: 0
-
-  We can also add multiple fields to the 'values' parameter.  For
-  example, we might want to see the total number of bytes allocated
-  alongside bytes requested, and display the result sorted by bytes
-  allocated in a descending order:
-
-    # echo 'hist:keys=call_site.sym:values=bytes_req,bytes_alloc:sort=bytes_alloc.descending' > \
-           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
-
-    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
-    # trigger info: hist:keys=call_site.sym:vals=bytes_req,bytes_alloc:sort=bytes_alloc.descending:size=2048 [active]
-
-    { call_site: [ffffffffa046041c] i915_gem_execbuffer2 [i915]                   } hitcount:       7403  bytes_req:    4084360  bytes_alloc:    5958016
-    { call_site: [ffffffff811e2a1b] seq_buf_alloc                                 } hitcount:        541  bytes_req:    2213968  bytes_alloc:    2228224
-    { call_site: [ffffffffa0489a66] intel_ring_begin [i915]                       } hitcount:       7404  bytes_req:    1066176  bytes_alloc:    1421568
-    { call_site: [ffffffffa045e7c4] i915_gem_do_execbuffer.isra.23 [i915]         } hitcount:       1565  bytes_req:     557368  bytes_alloc:    1037760
-    { call_site: [ffffffff8125847d] ext4_htree_store_dirent                       } hitcount:       9557  bytes_req:     595778  bytes_alloc:     695744
-    { call_site: [ffffffffa045e646] i915_gem_do_execbuffer.isra.23 [i915]         } hitcount:       5839  bytes_req:     430680  bytes_alloc:     470400
-    { call_site: [ffffffffa04c4a3c] intel_plane_duplicate_state [i915]            } hitcount:       2388  bytes_req:     324768  bytes_alloc:     458496
-    { call_site: [ffffffffa02911f2] drm_modeset_lock_crtc [drm]                   } hitcount:       3911  bytes_req:     219016  bytes_alloc:     250304
-    { call_site: [ffffffff815f8d7b] sk_prot_alloc                                 } hitcount:        235  bytes_req:     236880  bytes_alloc:     240640
-    { call_site: [ffffffff8137e559] sg_kmalloc                                    } hitcount:        557  bytes_req:     169024  bytes_alloc:     221760
-    { call_site: [ffffffffa00b7c06] hid_report_raw_event [hid]                    } hitcount:       9378  bytes_req:     187548  bytes_alloc:     206312
-    { call_site: [ffffffffa04a580c] intel_crtc_page_flip [i915]                   } hitcount:       1519  bytes_req:     157976  bytes_alloc:     194432
-    .
-    .
-    .
-    { call_site: [ffffffff8109bd3b] sched_autogroup_create_attach                 } hitcount:          2  bytes_req:        144  bytes_alloc:        192
-    { call_site: [ffffffff81097ee8] alloc_rt_sched_group                          } hitcount:          2  bytes_req:        128  bytes_alloc:        128
-    { call_site: [ffffffff8109524a] alloc_fair_sched_group                        } hitcount:          2  bytes_req:        128  bytes_alloc:        128
-    { call_site: [ffffffff81095225] alloc_fair_sched_group                        } hitcount:          2  bytes_req:        128  bytes_alloc:        128
-    { call_site: [ffffffff81097ec2] alloc_rt_sched_group                          } hitcount:          2  bytes_req:        128  bytes_alloc:        128
-    { call_site: [ffffffff81213e80] load_elf_binary                               } hitcount:          3  bytes_req:         84  bytes_alloc:         96
-    { call_site: [ffffffff81079a2e] kthread_create_on_node                        } hitcount:          1  bytes_req:         56  bytes_alloc:         64
-    { call_site: [ffffffffa00bf6fe] hidraw_send_report [hid]                      } hitcount:          1  bytes_req:          7  bytes_alloc:          8
-    { call_site: [ffffffff8154bc62] usb_control_msg                               } hitcount:          1  bytes_req:          8  bytes_alloc:          8
-    { call_site: [ffffffffa00bf1ca] hidraw_report_event [hid]                     } hitcount:          1  bytes_req:          7  bytes_alloc:          8
-
-    Totals:
-        Hits: 66598
-        Entries: 65
-        Dropped: 0
-
-  Finally, to finish off our kmalloc example, instead of simply having
-  the hist trigger display symbolic call_sites, we can have the hist
-  trigger additionally display the complete set of kernel stack traces
-  that led to each call_site.  To do that, we simply use the special
-  value 'stacktrace' for the key parameter:
-
-    # echo 'hist:keys=stacktrace:values=bytes_req,bytes_alloc:sort=bytes_alloc' > \
-           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
-
-  The above trigger will use the kernel stack trace in effect when an
-  event is triggered as the key for the hash table.  This allows the
-  enumeration of every kernel callpath that led up to a particular
-  event, along with a running total of any of the event fields for
-  that event.  Here we tally bytes requested and bytes allocated for
-  every callpath in the system that led up to a kmalloc (in this case
-  every callpath to a kmalloc for a kernel compile):
-
-    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
-    # trigger info: hist:keys=stacktrace:vals=bytes_req,bytes_alloc:sort=bytes_alloc:size=2048 [active]
-
-    { stacktrace:
-         __kmalloc_track_caller+0x10b/0x1a0
-         kmemdup+0x20/0x50
-         hidraw_report_event+0x8a/0x120 [hid]
-         hid_report_raw_event+0x3ea/0x440 [hid]
-         hid_input_report+0x112/0x190 [hid]
-         hid_irq_in+0xc2/0x260 [usbhid]
-         __usb_hcd_giveback_urb+0x72/0x120
-         usb_giveback_urb_bh+0x9e/0xe0
-         tasklet_hi_action+0xf8/0x100
-         __do_softirq+0x114/0x2c0
-         irq_exit+0xa5/0xb0
-         do_IRQ+0x5a/0xf0
-         ret_from_intr+0x0/0x30
-         cpuidle_enter+0x17/0x20
-         cpu_startup_entry+0x315/0x3e0
-         rest_init+0x7c/0x80
-    } hitcount:          3  bytes_req:         21  bytes_alloc:         24
-    { stacktrace:
-         __kmalloc_track_caller+0x10b/0x1a0
-         kmemdup+0x20/0x50
-         hidraw_report_event+0x8a/0x120 [hid]
-         hid_report_raw_event+0x3ea/0x440 [hid]
-         hid_input_report+0x112/0x190 [hid]
-         hid_irq_in+0xc2/0x260 [usbhid]
-         __usb_hcd_giveback_urb+0x72/0x120
-         usb_giveback_urb_bh+0x9e/0xe0
-         tasklet_hi_action+0xf8/0x100
-         __do_softirq+0x114/0x2c0
-         irq_exit+0xa5/0xb0
-         do_IRQ+0x5a/0xf0
-         ret_from_intr+0x0/0x30
-    } hitcount:          3  bytes_req:         21  bytes_alloc:         24
-    { stacktrace:
-         kmem_cache_alloc_trace+0xeb/0x150
-         aa_alloc_task_context+0x27/0x40
-         apparmor_cred_prepare+0x1f/0x50
-         security_prepare_creds+0x16/0x20
-         prepare_creds+0xdf/0x1a0
-         SyS_capset+0xb5/0x200
-         system_call_fastpath+0x12/0x6a
-    } hitcount:          1  bytes_req:         32  bytes_alloc:         32
-    .
-    .
-    .
-    { stacktrace:
-         __kmalloc+0x11b/0x1b0
-         i915_gem_execbuffer2+0x6c/0x2c0 [i915]
-         drm_ioctl+0x349/0x670 [drm]
-         do_vfs_ioctl+0x2f0/0x4f0
-         SyS_ioctl+0x81/0xa0
-         system_call_fastpath+0x12/0x6a
-    } hitcount:      17726  bytes_req:   13944120  bytes_alloc:   19593808
-    { stacktrace:
-         __kmalloc+0x11b/0x1b0
-         load_elf_phdrs+0x76/0xa0
-         load_elf_binary+0x102/0x1650
-         search_binary_handler+0x97/0x1d0
-         do_execveat_common.isra.34+0x551/0x6e0
-         SyS_execve+0x3a/0x50
-         return_from_execve+0x0/0x23
-    } hitcount:      33348  bytes_req:   17152128  bytes_alloc:   20226048
-    { stacktrace:
-         kmem_cache_alloc_trace+0xeb/0x150
-         apparmor_file_alloc_security+0x27/0x40
-         security_file_alloc+0x16/0x20
-         get_empty_filp+0x93/0x1c0
-         path_openat+0x31/0x5f0
-         do_filp_open+0x3a/0x90
-         do_sys_open+0x128/0x220
-         SyS_open+0x1e/0x20
-         system_call_fastpath+0x12/0x6a
-    } hitcount:    4766422  bytes_req:    9532844  bytes_alloc:   38131376
-    { stacktrace:
-         __kmalloc+0x11b/0x1b0
-         seq_buf_alloc+0x1b/0x50
-         seq_read+0x2cc/0x370
-         proc_reg_read+0x3d/0x80
-         __vfs_read+0x28/0xe0
-         vfs_read+0x86/0x140
-         SyS_read+0x46/0xb0
-         system_call_fastpath+0x12/0x6a
-    } hitcount:      19133  bytes_req:   78368768  bytes_alloc:   78368768
-
-    Totals:
-        Hits: 6085872
-        Entries: 253
-        Dropped: 0
-
-  If you key a hist trigger on common_pid, in order for example to
-  gather and display sorted totals for each process, you can use the
-  special .execname modifier to display the executable names for the
-  processes in the table rather than raw pids.  The example below
-  keeps a per-process sum of total bytes read:
-
-    # echo 'hist:key=common_pid.execname:val=count:sort=count.descending' > \
-           /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/trigger
-
-    # cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/hist
-    # trigger info: hist:keys=common_pid.execname:vals=count:sort=count.descending:size=2048 [active]
-
-    { common_pid: gnome-terminal  [      3196] } hitcount:        280  count:    1093512
-    { common_pid: Xorg            [      1309] } hitcount:        525  count:     256640
-    { common_pid: compiz          [      2889] } hitcount:         59  count:     254400
-    { common_pid: bash            [      8710] } hitcount:          3  count:      66369
-    { common_pid: dbus-daemon-lau [      8703] } hitcount:         49  count:      47739
-    { common_pid: irqbalance      [      1252] } hitcount:         27  count:      27648
-    { common_pid: 01ifupdown      [      8705] } hitcount:          3  count:      17216
-    { common_pid: dbus-daemon     [       772] } hitcount:         10  count:      12396
-    { common_pid: Socket Thread   [      8342] } hitcount:         11  count:      11264
-    { common_pid: nm-dhcp-client. [      8701] } hitcount:          6  count:       7424
-    { common_pid: gmain           [      1315] } hitcount:         18  count:       6336
-    .
-    .
-    .
-    { common_pid: postgres        [      1892] } hitcount:          2  count:         32
-    { common_pid: postgres        [      1891] } hitcount:          2  count:         32
-    { common_pid: gmain           [      8704] } hitcount:          2  count:         32
-    { common_pid: upstart-dbus-br [      2740] } hitcount:         21  count:         21
-    { common_pid: nm-dispatcher.a [      8696] } hitcount:          1  count:         16
-    { common_pid: indicator-datet [      2904] } hitcount:          1  count:         16
-    { common_pid: gdbus           [      2998] } hitcount:          1  count:         16
-    { common_pid: rtkit-daemon    [      2052] } hitcount:          1  count:          8
-    { common_pid: init            [         1] } hitcount:          2  count:          2
-
-    Totals:
-        Hits: 2116
-        Entries: 51
-        Dropped: 0
-
-  Similarly, if you key a hist trigger on syscall id, for example to
-  gather and display a list of systemwide syscall hits, you can use
-  the special .syscall modifier to display the syscall names rather
-  than raw ids.  The example below keeps a running total of syscall
-  counts for the system during the run:
-
-    # echo 'hist:key=id.syscall:val=hitcount' > \
-           /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger
-
-    # cat /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/hist
-    # trigger info: hist:keys=id.syscall:vals=hitcount:sort=hitcount:size=2048 [active]
-
-    { id: sys_fsync                     [ 74] } hitcount:          1
-    { id: sys_newuname                  [ 63] } hitcount:          1
-    { id: sys_prctl                     [157] } hitcount:          1
-    { id: sys_statfs                    [137] } hitcount:          1
-    { id: sys_symlink                   [ 88] } hitcount:          1
-    { id: sys_sendmmsg                  [307] } hitcount:          1
-    { id: sys_semctl                    [ 66] } hitcount:          1
-    { id: sys_readlink                  [ 89] } hitcount:          3
-    { id: sys_bind                      [ 49] } hitcount:          3
-    { id: sys_getsockname               [ 51] } hitcount:          3
-    { id: sys_unlink                    [ 87] } hitcount:          3
-    { id: sys_rename                    [ 82] } hitcount:          4
-    { id: unknown_syscall               [ 58] } hitcount:          4
-    { id: sys_connect                   [ 42] } hitcount:          4
-    { id: sys_getpid                    [ 39] } hitcount:          4
-    .
-    .
-    .
-    { id: sys_rt_sigprocmask            [ 14] } hitcount:        952
-    { id: sys_futex                     [202] } hitcount:       1534
-    { id: sys_write                     [  1] } hitcount:       2689
-    { id: sys_setitimer                 [ 38] } hitcount:       2797
-    { id: sys_read                      [  0] } hitcount:       3202
-    { id: sys_select                    [ 23] } hitcount:       3773
-    { id: sys_writev                    [ 20] } hitcount:       4531
-    { id: sys_poll                      [  7] } hitcount:       8314
-    { id: sys_recvmsg                   [ 47] } hitcount:      13738
-    { id: sys_ioctl                     [ 16] } hitcount:      21843
-
-    Totals:
-        Hits: 67612
-        Entries: 72
-        Dropped: 0
-
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
-
-  The above example also illustrates the fact that although a compound
-  key is treated as a single entity for hashing purposes, the sub-keys
-  it's composed of can be accessed independently.
-
-  The next example uses a string field as the hash key and
-  demonstrates how you can manually pause and continue a hist trigger.
-  In this example, we'll aggregate fork counts and don't expect a
-  large number of entries in the hash table, so we'll drop it to a
-  much smaller number, say 256:
-
-    # echo 'hist:key=child_comm:val=hitcount:size=256' > \
-           /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
-
-    # cat /sys/kernel/debug/tracing/events/sched/sched_process_fork/hist
-    # trigger info: hist:keys=child_comm:vals=hitcount:sort=hitcount:size=256 [active]
-
-    { child_comm: dconf worker                        } hitcount:          1
-    { child_comm: ibus-daemon                         } hitcount:          1
-    { child_comm: whoopsie                            } hitcount:          1
-    { child_comm: smbd                                } hitcount:          1
-    { child_comm: gdbus                               } hitcount:          1
-    { child_comm: kthreadd                            } hitcount:          1
-    { child_comm: dconf worker                        } hitcount:          1
-    { child_comm: evolution-alarm                     } hitcount:          2
-    { child_comm: Socket Thread                       } hitcount:          2
-    { child_comm: postgres                            } hitcount:          2
-    { child_comm: bash                                } hitcount:          3
-    { child_comm: compiz                              } hitcount:          3
-    { child_comm: evolution-sourc                     } hitcount:          4
-    { child_comm: dhclient                            } hitcount:          4
-    { child_comm: pool                                } hitcount:          5
-    { child_comm: nm-dispatcher.a                     } hitcount:          8
-    { child_comm: firefox                             } hitcount:          8
-    { child_comm: dbus-daemon                         } hitcount:          8
-    { child_comm: glib-pacrunner                      } hitcount:         10
-    { child_comm: evolution                           } hitcount:         23
-
-    Totals:
-        Hits: 89
-        Entries: 20
-        Dropped: 0
-
-  If we want to pause the hist trigger, we can simply append :pause to
-  the command that started the trigger.  Notice that the trigger info
-  displays as [paused]:
-
-    # echo 'hist:key=child_comm:val=hitcount:size=256:pause' >> \
-           /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
-
-    # cat /sys/kernel/debug/tracing/events/sched/sched_process_fork/hist
-    # trigger info: hist:keys=child_comm:vals=hitcount:sort=hitcount:size=256 [paused]
-
-    { child_comm: dconf worker                        } hitcount:          1
-    { child_comm: kthreadd                            } hitcount:          1
-    { child_comm: dconf worker                        } hitcount:          1
-    { child_comm: gdbus                               } hitcount:          1
-    { child_comm: ibus-daemon                         } hitcount:          1
-    { child_comm: Socket Thread                       } hitcount:          2
-    { child_comm: evolution-alarm                     } hitcount:          2
-    { child_comm: smbd                                } hitcount:          2
-    { child_comm: bash                                } hitcount:          3
-    { child_comm: whoopsie                            } hitcount:          3
-    { child_comm: compiz                              } hitcount:          3
-    { child_comm: evolution-sourc                     } hitcount:          4
-    { child_comm: pool                                } hitcount:          5
-    { child_comm: postgres                            } hitcount:          6
-    { child_comm: firefox                             } hitcount:          8
-    { child_comm: dhclient                            } hitcount:         10
-    { child_comm: emacs                               } hitcount:         12
-    { child_comm: dbus-daemon                         } hitcount:         20
-    { child_comm: nm-dispatcher.a                     } hitcount:         20
-    { child_comm: evolution                           } hitcount:         35
-    { child_comm: glib-pacrunner                      } hitcount:         59
-
-    Totals:
-        Hits: 199
-        Entries: 21
-        Dropped: 0
-
-  To manually continue having the trigger aggregate events, append
-  :cont instead.  Notice that the trigger info displays as [active]
-  again, and the data has changed:
-
-    # echo 'hist:key=child_comm:val=hitcount:size=256:cont' >> \
-           /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
-
-    # cat /sys/kernel/debug/tracing/events/sched/sched_process_fork/hist
-    # trigger info: hist:keys=child_comm:vals=hitcount:sort=hitcount:size=256 [active]
-
-    { child_comm: dconf worker                        } hitcount:          1
-    { child_comm: dconf worker                        } hitcount:          1
-    { child_comm: kthreadd                            } hitcount:          1
-    { child_comm: gdbus                               } hitcount:          1
-    { child_comm: ibus-daemon                         } hitcount:          1
-    { child_comm: Socket Thread                       } hitcount:          2
-    { child_comm: evolution-alarm                     } hitcount:          2
-    { child_comm: smbd                                } hitcount:          2
-    { child_comm: whoopsie                            } hitcount:          3
-    { child_comm: compiz                              } hitcount:          3
-    { child_comm: evolution-sourc                     } hitcount:          4
-    { child_comm: bash                                } hitcount:          5
-    { child_comm: pool                                } hitcount:          5
-    { child_comm: postgres                            } hitcount:          6
-    { child_comm: firefox                             } hitcount:          8
-    { child_comm: dhclient                            } hitcount:         11
-    { child_comm: emacs                               } hitcount:         12
-    { child_comm: dbus-daemon                         } hitcount:         22
-    { child_comm: nm-dispatcher.a                     } hitcount:         22
-    { child_comm: evolution                           } hitcount:         35
-    { child_comm: glib-pacrunner                      } hitcount:         59
-
-    Totals:
-        Hits: 206
-        Entries: 21
-        Dropped: 0
-
-  The previous example showed how to start and stop a hist trigger by
-  appending 'pause' and 'continue' to the hist trigger command.  A
-  hist trigger can also be started in a paused state by initially
-  starting the trigger with ':pause' appended.  This allows you to
-  start the trigger only when you're ready to start collecting data
-  and not before.  For example, you could start the trigger in a
-  paused state, then unpause it and do something you want to measure,
-  then pause the trigger again when done.
-
-  Of course, doing this manually can be difficult and error-prone, but
-  it is possible to automatically start and stop a hist trigger based
-  on some condition, via the enable_hist and disable_hist triggers.
-
-  For example, suppose we wanted to take a look at the relative
-  weights in terms of skb length for each callpath that leads to a
-  netif_receieve_skb event when downloading a decent-sized file using
-  wget.
-
-  First we set up an initially paused stacktrace trigger on the
-  netif_receive_skb event:
-
-    # echo 'hist:key=stacktrace:vals=len:pause' > \
-           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
-
-  Next, we set up an 'enable_hist' trigger on the sched_process_exec
-  event, with an 'if filename==/usr/bin/wget' filter.  The effect of
-  this new trigger is that it will 'unpause' the hist trigger we just
-  set up on netif_receive_skb if and only if it sees a
-  sched_process_exec event with a filename of '/usr/bin/wget'.  When
-  that happens, all netif_receive_skb events are aggregated into a
-  hash table keyed on stacktrace:
-
-    # echo 'enable_hist:net:netif_receive_skb if filename==/usr/bin/wget' > \
-           /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
-
-  The aggregation continues until the netif_receive_skb is paused
-  again, which is what the following disable_hist event does by
-  creating a similar setup on the sched_process_exit event, using the
-  filter 'comm==wget':
-
-    # echo 'disable_hist:net:netif_receive_skb if comm==wget' > \
-           /sys/kernel/debug/tracing/events/sched/sched_process_exit/trigger
-
-  Whenever a process exits and the comm field of the disable_hist
-  trigger filter matches 'comm==wget', the netif_receive_skb hist
-  trigger is disabled.
-
-  The overall effect is that netif_receive_skb events are aggregated
-  into the hash table for only the duration of the wget.  Executing a
-  wget command and then listing the 'hist' file will display the
-  output generated by the wget command:
-
-    $ wget https://www.kernel.org/pub/linux/kernel/v3.x/patch-3.19.xz
-
-    # cat /sys/kernel/debug/tracing/events/net/netif_receive_skb/hist
-    # trigger info: hist:keys=stacktrace:vals=len:sort=hitcount:size=2048 [paused]
-
-    { stacktrace:
-         __netif_receive_skb_core+0x46d/0x990
-         __netif_receive_skb+0x18/0x60
-         netif_receive_skb_internal+0x23/0x90
-         napi_gro_receive+0xc8/0x100
-         ieee80211_deliver_skb+0xd6/0x270 [mac80211]
-         ieee80211_rx_handlers+0xccf/0x22f0 [mac80211]
-         ieee80211_prepare_and_rx_handle+0x4e7/0xc40 [mac80211]
-         ieee80211_rx+0x31d/0x900 [mac80211]
-         iwlagn_rx_reply_rx+0x3db/0x6f0 [iwldvm]
-         iwl_rx_dispatch+0x8e/0xf0 [iwldvm]
-         iwl_pcie_irq_handler+0xe3c/0x12f0 [iwlwifi]
-         irq_thread_fn+0x20/0x50
-         irq_thread+0x11f/0x150
-         kthread+0xd2/0xf0
-         ret_from_fork+0x42/0x70
-    } hitcount:         85  len:      28884
-    { stacktrace:
-         __netif_receive_skb_core+0x46d/0x990
-         __netif_receive_skb+0x18/0x60
-         netif_receive_skb_internal+0x23/0x90
-         napi_gro_complete+0xa4/0xe0
-         dev_gro_receive+0x23a/0x360
-         napi_gro_receive+0x30/0x100
-         ieee80211_deliver_skb+0xd6/0x270 [mac80211]
-         ieee80211_rx_handlers+0xccf/0x22f0 [mac80211]
-         ieee80211_prepare_and_rx_handle+0x4e7/0xc40 [mac80211]
-         ieee80211_rx+0x31d/0x900 [mac80211]
-         iwlagn_rx_reply_rx+0x3db/0x6f0 [iwldvm]
-         iwl_rx_dispatch+0x8e/0xf0 [iwldvm]
-         iwl_pcie_irq_handler+0xe3c/0x12f0 [iwlwifi]
-         irq_thread_fn+0x20/0x50
-         irq_thread+0x11f/0x150
-         kthread+0xd2/0xf0
-    } hitcount:         98  len:     664329
-    { stacktrace:
-         __netif_receive_skb_core+0x46d/0x990
-         __netif_receive_skb+0x18/0x60
-         process_backlog+0xa8/0x150
-         net_rx_action+0x15d/0x340
-         __do_softirq+0x114/0x2c0
-         do_softirq_own_stack+0x1c/0x30
-         do_softirq+0x65/0x70
-         __local_bh_enable_ip+0xb5/0xc0
-         ip_finish_output+0x1f4/0x840
-         ip_output+0x6b/0xc0
-         ip_local_out_sk+0x31/0x40
-         ip_send_skb+0x1a/0x50
-         udp_send_skb+0x173/0x2a0
-         udp_sendmsg+0x2bf/0x9f0
-         inet_sendmsg+0x64/0xa0
-         sock_sendmsg+0x3d/0x50
-    } hitcount:        115  len:      13030
-    { stacktrace:
-         __netif_receive_skb_core+0x46d/0x990
-         __netif_receive_skb+0x18/0x60
-         netif_receive_skb_internal+0x23/0x90
-         napi_gro_complete+0xa4/0xe0
-         napi_gro_flush+0x6d/0x90
-         iwl_pcie_irq_handler+0x92a/0x12f0 [iwlwifi]
-         irq_thread_fn+0x20/0x50
-         irq_thread+0x11f/0x150
-         kthread+0xd2/0xf0
-         ret_from_fork+0x42/0x70
-    } hitcount:        934  len:    5512212
-
-    Totals:
-        Hits: 1232
-        Entries: 4
-        Dropped: 0
-
-  The above shows all the netif_receive_skb callpaths and their total
-  lengths for the duration of the wget command.
-
-  The 'clear' hist trigger param can be used to clear the hash table.
-  Suppose we wanted to try another run of the previous example but
-  this time also wanted to see the complete list of events that went
-  into the histogram.  In order to avoid having to set everything up
-  again, we can just clear the histogram first:
-
-    # echo 'hist:key=stacktrace:vals=len:clear' >> \
-           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
-
-  Just to verify that it is in fact cleared, here's what we now see in
-  the hist file:
-
-    # cat /sys/kernel/debug/tracing/events/net/netif_receive_skb/hist
-    # trigger info: hist:keys=stacktrace:vals=len:sort=hitcount:size=2048 [paused]
-
-    Totals:
-        Hits: 0
-        Entries: 0
-        Dropped: 0
-
-  Since we want to see the detailed list of every netif_receive_skb
-  event occurring during the new run, which are in fact the same
-  events being aggregated into the hash table, we add some additional
-  'enable_event' events to the triggering sched_process_exec and
-  sched_process_exit events as such:
-
-    # echo 'enable_event:net:netif_receive_skb if filename==/usr/bin/wget' > \
-           /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
-
-    # echo 'disable_event:net:netif_receive_skb if comm==wget' > \
-           /sys/kernel/debug/tracing/events/sched/sched_process_exit/trigger
-
-  If you read the trigger files for the sched_process_exec and
-  sched_process_exit triggers, you should see two triggers for each:
-  one enabling/disabling the hist aggregation and the other
-  enabling/disabling the logging of events:
-
-    # cat /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
-    enable_event:net:netif_receive_skb:unlimited if filename==/usr/bin/wget
-    enable_hist:net:netif_receive_skb:unlimited if filename==/usr/bin/wget
-
-    # cat /sys/kernel/debug/tracing/events/sched/sched_process_exit/trigger
-    enable_event:net:netif_receive_skb:unlimited if comm==wget
-    disable_hist:net:netif_receive_skb:unlimited if comm==wget
-
-  In other words, whenever either of the sched_process_exec or
-  sched_process_exit events is hit and matches 'wget', it enables or
-  disables both the histogram and the event log, and what you end up
-  with is a hash table and set of events just covering the specified
-  duration.  Run the wget command again:
-
-    $ wget https://www.kernel.org/pub/linux/kernel/v3.x/patch-3.19.xz
-
-  Displaying the 'hist' file should show something similar to what you
-  saw in the last run, but this time you should also see the
-  individual events in the trace file:
-
-    # cat /sys/kernel/debug/tracing/trace
-
-    # tracer: nop
-    #
-    # entries-in-buffer/entries-written: 183/1426   #P:4
-    #
-    #                              _-----=> irqs-off
-    #                             / _----=> need-resched
-    #                            | / _---=> hardirq/softirq
-    #                            || / _--=> preempt-depth
-    #                            ||| /     delay
-    #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
-    #              | |       |   ||||       |         |
-                wget-15108 [000] ..s1 31769.606929: netif_receive_skb: dev=lo skbaddr=ffff88009c353100 len=60
-                wget-15108 [000] ..s1 31769.606999: netif_receive_skb: dev=lo skbaddr=ffff88009c353200 len=60
-             dnsmasq-1382  [000] ..s1 31769.677652: netif_receive_skb: dev=lo skbaddr=ffff88009c352b00 len=130
-             dnsmasq-1382  [000] ..s1 31769.685917: netif_receive_skb: dev=lo skbaddr=ffff88009c352200 len=138
-    ##### CPU 2 buffer started ####
-      irq/29-iwlwifi-559   [002] ..s. 31772.031529: netif_receive_skb: dev=wlan0 skbaddr=ffff88009d433d00 len=2948
-      irq/29-iwlwifi-559   [002] ..s. 31772.031572: netif_receive_skb: dev=wlan0 skbaddr=ffff88009d432200 len=1500
-      irq/29-iwlwifi-559   [002] ..s. 31772.032196: netif_receive_skb: dev=wlan0 skbaddr=ffff88009d433100 len=2948
-      irq/29-iwlwifi-559   [002] ..s. 31772.032761: netif_receive_skb: dev=wlan0 skbaddr=ffff88009d433000 len=2948
-      irq/29-iwlwifi-559   [002] ..s. 31772.033220: netif_receive_skb: dev=wlan0 skbaddr=ffff88009d432e00 len=1500
-    .
-    .
-    .
-
-  The following example demonstrates how multiple hist triggers can be
-  attached to a given event.  This capability can be useful for
-  creating a set of different summaries derived from the same set of
-  events, or for comparing the effects of different filters, among
-  other things.
-
-    # echo 'hist:keys=skbaddr.hex:vals=len if len < 0' >> \
-           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
-    # echo 'hist:keys=skbaddr.hex:vals=len if len > 4096' >> \
-           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
-    # echo 'hist:keys=skbaddr.hex:vals=len if len == 256' >> \
-           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
-    # echo 'hist:keys=skbaddr.hex:vals=len' >> \
-           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
-    # echo 'hist:keys=len:vals=common_preempt_count' >> \
-           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
-
-  The above set of commands create four triggers differing only in
-  their filters, along with a completely different though fairly
-  nonsensical trigger.  Note that in order to append multiple hist
-  triggers to the same file, you should use the '>>' operator to
-  append them ('>' will also add the new hist trigger, but will remove
-  any existing hist triggers beforehand).
-
-  Displaying the contents of the 'hist' file for the event shows the
-  contents of all five histograms:
-
-    # cat /sys/kernel/debug/tracing/events/net/netif_receive_skb/hist
-
-    # event histogram
-    #
-    # trigger info: hist:keys=len:vals=hitcount,common_preempt_count:sort=hitcount:size=2048 [active]
-    #
-
-    { len:        176 } hitcount:          1  common_preempt_count:          0
-    { len:        223 } hitcount:          1  common_preempt_count:          0
-    { len:       4854 } hitcount:          1  common_preempt_count:          0
-    { len:        395 } hitcount:          1  common_preempt_count:          0
-    { len:        177 } hitcount:          1  common_preempt_count:          0
-    { len:        446 } hitcount:          1  common_preempt_count:          0
-    { len:       1601 } hitcount:          1  common_preempt_count:          0
-    .
-    .
-    .
-    { len:       1280 } hitcount:         66  common_preempt_count:          0
-    { len:        116 } hitcount:         81  common_preempt_count:         40
-    { len:        708 } hitcount:        112  common_preempt_count:          0
-    { len:         46 } hitcount:        221  common_preempt_count:          0
-    { len:       1264 } hitcount:        458  common_preempt_count:          0
-
-    Totals:
-        Hits: 1428
-        Entries: 147
-        Dropped: 0
-
-
-    # event histogram
-    #
-    # trigger info: hist:keys=skbaddr.hex:vals=hitcount,len:sort=hitcount:size=2048 [active]
-    #
-
-    { skbaddr: ffff8800baee5e00 } hitcount:          1  len:        130
-    { skbaddr: ffff88005f3d5600 } hitcount:          1  len:       1280
-    { skbaddr: ffff88005f3d4900 } hitcount:          1  len:       1280
-    { skbaddr: ffff88009fed6300 } hitcount:          1  len:        115
-    { skbaddr: ffff88009fe0ad00 } hitcount:          1  len:        115
-    { skbaddr: ffff88008cdb1900 } hitcount:          1  len:         46
-    { skbaddr: ffff880064b5ef00 } hitcount:          1  len:        118
-    { skbaddr: ffff880044e3c700 } hitcount:          1  len:         60
-    { skbaddr: ffff880100065900 } hitcount:          1  len:         46
-    { skbaddr: ffff8800d46bd500 } hitcount:          1  len:        116
-    { skbaddr: ffff88005f3d5f00 } hitcount:          1  len:       1280
-    { skbaddr: ffff880100064700 } hitcount:          1  len:        365
-    { skbaddr: ffff8800badb6f00 } hitcount:          1  len:         60
-    .
-    .
-    .
-    { skbaddr: ffff88009fe0be00 } hitcount:         27  len:      24677
-    { skbaddr: ffff88009fe0a400 } hitcount:         27  len:      23052
-    { skbaddr: ffff88009fe0b700 } hitcount:         31  len:      25589
-    { skbaddr: ffff88009fe0b600 } hitcount:         32  len:      27326
-    { skbaddr: ffff88006a462800 } hitcount:         68  len:      71678
-    { skbaddr: ffff88006a463700 } hitcount:         70  len:      72678
-    { skbaddr: ffff88006a462b00 } hitcount:         71  len:      77589
-    { skbaddr: ffff88006a463600 } hitcount:         73  len:      71307
-    { skbaddr: ffff88006a462200 } hitcount:         81  len:      81032
-
-    Totals:
-        Hits: 1451
-        Entries: 318
-        Dropped: 0
-
-
-    # event histogram
-    #
-    # trigger info: hist:keys=skbaddr.hex:vals=hitcount,len:sort=hitcount:size=2048 if len == 256 [active]
-    #
-
-
-    Totals:
-        Hits: 0
-        Entries: 0
-        Dropped: 0
-
-
-    # event histogram
-    #
-    # trigger info: hist:keys=skbaddr.hex:vals=hitcount,len:sort=hitcount:size=2048 if len > 4096 [active]
-    #
-
-    { skbaddr: ffff88009fd2c300 } hitcount:          1  len:       7212
-    { skbaddr: ffff8800d2bcce00 } hitcount:          1  len:       7212
-    { skbaddr: ffff8800d2bcd700 } hitcount:          1  len:       7212
-    { skbaddr: ffff8800d2bcda00 } hitcount:          1  len:      21492
-    { skbaddr: ffff8800ae2e2d00 } hitcount:          1  len:       7212
-    { skbaddr: ffff8800d2bcdb00 } hitcount:          1  len:       7212
-    { skbaddr: ffff88006a4df500 } hitcount:          1  len:       4854
-    { skbaddr: ffff88008ce47b00 } hitcount:          1  len:      18636
-    { skbaddr: ffff8800ae2e2200 } hitcount:          1  len:      12924
-    { skbaddr: ffff88005f3e1000 } hitcount:          1  len:       4356
-    { skbaddr: ffff8800d2bcdc00 } hitcount:          2  len:      24420
-    { skbaddr: ffff8800d2bcc200 } hitcount:          2  len:      12996
-
-    Totals:
-        Hits: 14
-        Entries: 12
-        Dropped: 0
-
-
-    # event histogram
-    #
-    # trigger info: hist:keys=skbaddr.hex:vals=hitcount,len:sort=hitcount:size=2048 if len < 0 [active]
-    #
-
-
-    Totals:
-        Hits: 0
-        Entries: 0
-        Dropped: 0
-
-  Named triggers can be used to have triggers share a common set of
-  histogram data.  This capability is mostly useful for combining the
-  output of events generated by tracepoints contained inside inline
-  functions, but names can be used in a hist trigger on any event.
-  For example, these two triggers when hit will update the same 'len'
-  field in the shared 'foo' histogram data:
-
-    # echo 'hist:name=foo:keys=skbaddr.hex:vals=len' > \
-           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
-    # echo 'hist:name=foo:keys=skbaddr.hex:vals=len' > \
-           /sys/kernel/debug/tracing/events/net/netif_rx/trigger
-
-  You can see that they're updating common histogram data by reading
-  each event's hist files at the same time:
-
-    # cat /sys/kernel/debug/tracing/events/net/netif_receive_skb/hist;
-      cat /sys/kernel/debug/tracing/events/net/netif_rx/hist
-
-    # event histogram
-    #
-    # trigger info: hist:name=foo:keys=skbaddr.hex:vals=hitcount,len:sort=hitcount:size=2048 [active]
-    #
-
-    { skbaddr: ffff88000ad53500 } hitcount:          1  len:         46
-    { skbaddr: ffff8800af5a1500 } hitcount:          1  len:         76
-    { skbaddr: ffff8800d62a1900 } hitcount:          1  len:         46
-    { skbaddr: ffff8800d2bccb00 } hitcount:          1  len:        468
-    { skbaddr: ffff8800d3c69900 } hitcount:          1  len:         46
-    { skbaddr: ffff88009ff09100 } hitcount:          1  len:         52
-    { skbaddr: ffff88010f13ab00 } hitcount:          1  len:        168
-    { skbaddr: ffff88006a54f400 } hitcount:          1  len:         46
-    { skbaddr: ffff8800d2bcc500 } hitcount:          1  len:        260
-    { skbaddr: ffff880064505000 } hitcount:          1  len:         46
-    { skbaddr: ffff8800baf24e00 } hitcount:          1  len:         32
-    { skbaddr: ffff88009fe0ad00 } hitcount:          1  len:         46
-    { skbaddr: ffff8800d3edff00 } hitcount:          1  len:         44
-    { skbaddr: ffff88009fe0b400 } hitcount:          1  len:        168
-    { skbaddr: ffff8800a1c55a00 } hitcount:          1  len:         40
-    { skbaddr: ffff8800d2bcd100 } hitcount:          1  len:         40
-    { skbaddr: ffff880064505f00 } hitcount:          1  len:        174
-    { skbaddr: ffff8800a8bff200 } hitcount:          1  len:        160
-    { skbaddr: ffff880044e3cc00 } hitcount:          1  len:         76
-    { skbaddr: ffff8800a8bfe700 } hitcount:          1  len:         46
-    { skbaddr: ffff8800d2bcdc00 } hitcount:          1  len:         32
-    { skbaddr: ffff8800a1f64800 } hitcount:          1  len:         46
-    { skbaddr: ffff8800d2bcde00 } hitcount:          1  len:        988
-    { skbaddr: ffff88006a5dea00 } hitcount:          1  len:         46
-    { skbaddr: ffff88002e37a200 } hitcount:          1  len:         44
-    { skbaddr: ffff8800a1f32c00 } hitcount:          2  len:        676
-    { skbaddr: ffff88000ad52600 } hitcount:          2  len:        107
-    { skbaddr: ffff8800a1f91e00 } hitcount:          2  len:         92
-    { skbaddr: ffff8800af5a0200 } hitcount:          2  len:        142
-    { skbaddr: ffff8800d2bcc600 } hitcount:          2  len:        220
-    { skbaddr: ffff8800ba36f500 } hitcount:          2  len:         92
-    { skbaddr: ffff8800d021f800 } hitcount:          2  len:         92
-    { skbaddr: ffff8800a1f33600 } hitcount:          2  len:        675
-    { skbaddr: ffff8800a8bfff00 } hitcount:          3  len:        138
-    { skbaddr: ffff8800d62a1300 } hitcount:          3  len:        138
-    { skbaddr: ffff88002e37a100 } hitcount:          4  len:        184
-    { skbaddr: ffff880064504400 } hitcount:          4  len:        184
-    { skbaddr: ffff8800a8bfec00 } hitcount:          4  len:        184
-    { skbaddr: ffff88000ad53700 } hitcount:          5  len:        230
-    { skbaddr: ffff8800d2bcdb00 } hitcount:          5  len:        196
-    { skbaddr: ffff8800a1f90000 } hitcount:          6  len:        276
-    { skbaddr: ffff88006a54f900 } hitcount:          6  len:        276
-
-    Totals:
-        Hits: 81
-        Entries: 42
-        Dropped: 0
-    # event histogram
-    #
-    # trigger info: hist:name=foo:keys=skbaddr.hex:vals=hitcount,len:sort=hitcount:size=2048 [active]
-    #
-
-    { skbaddr: ffff88000ad53500 } hitcount:          1  len:         46
-    { skbaddr: ffff8800af5a1500 } hitcount:          1  len:         76
-    { skbaddr: ffff8800d62a1900 } hitcount:          1  len:         46
-    { skbaddr: ffff8800d2bccb00 } hitcount:          1  len:        468
-    { skbaddr: ffff8800d3c69900 } hitcount:          1  len:         46
-    { skbaddr: ffff88009ff09100 } hitcount:          1  len:         52
-    { skbaddr: ffff88010f13ab00 } hitcount:          1  len:        168
-    { skbaddr: ffff88006a54f400 } hitcount:          1  len:         46
-    { skbaddr: ffff8800d2bcc500 } hitcount:          1  len:        260
-    { skbaddr: ffff880064505000 } hitcount:          1  len:         46
-    { skbaddr: ffff8800baf24e00 } hitcount:          1  len:         32
-    { skbaddr: ffff88009fe0ad00 } hitcount:          1  len:         46
-    { skbaddr: ffff8800d3edff00 } hitcount:          1  len:         44
-    { skbaddr: ffff88009fe0b400 } hitcount:          1  len:        168
-    { skbaddr: ffff8800a1c55a00 } hitcount:          1  len:         40
-    { skbaddr: ffff8800d2bcd100 } hitcount:          1  len:         40
-    { skbaddr: ffff880064505f00 } hitcount:          1  len:        174
-    { skbaddr: ffff8800a8bff200 } hitcount:          1  len:        160
-    { skbaddr: ffff880044e3cc00 } hitcount:          1  len:         76
-    { skbaddr: ffff8800a8bfe700 } hitcount:          1  len:         46
-    { skbaddr: ffff8800d2bcdc00 } hitcount:          1  len:         32
-    { skbaddr: ffff8800a1f64800 } hitcount:          1  len:         46
-    { skbaddr: ffff8800d2bcde00 } hitcount:          1  len:        988
-    { skbaddr: ffff88006a5dea00 } hitcount:          1  len:         46
-    { skbaddr: ffff88002e37a200 } hitcount:          1  len:         44
-    { skbaddr: ffff8800a1f32c00 } hitcount:          2  len:        676
-    { skbaddr: ffff88000ad52600 } hitcount:          2  len:        107
-    { skbaddr: ffff8800a1f91e00 } hitcount:          2  len:         92
-    { skbaddr: ffff8800af5a0200 } hitcount:          2  len:        142
-    { skbaddr: ffff8800d2bcc600 } hitcount:          2  len:        220
-    { skbaddr: ffff8800ba36f500 } hitcount:          2  len:         92
-    { skbaddr: ffff8800d021f800 } hitcount:          2  len:         92
-    { skbaddr: ffff8800a1f33600 } hitcount:          2  len:        675
-    { skbaddr: ffff8800a8bfff00 } hitcount:          3  len:        138
-    { skbaddr: ffff8800d62a1300 } hitcount:          3  len:        138
-    { skbaddr: ffff88002e37a100 } hitcount:          4  len:        184
-    { skbaddr: ffff880064504400 } hitcount:          4  len:        184
-    { skbaddr: ffff8800a8bfec00 } hitcount:          4  len:        184
-    { skbaddr: ffff88000ad53700 } hitcount:          5  len:        230
-    { skbaddr: ffff8800d2bcdb00 } hitcount:          5  len:        196
-    { skbaddr: ffff8800a1f90000 } hitcount:          6  len:        276
-    { skbaddr: ffff88006a54f900 } hitcount:          6  len:        276
-
-    Totals:
-        Hits: 81
-        Entries: 42
-        Dropped: 0
-
-  And here's an example that shows how to combine histogram data from
-  any two events even if they don't share any 'compatible' fields
-  other than 'hitcount' and 'stacktrace'.  These commands create a
-  couple of triggers named 'bar' using those fields:
-
-    # echo 'hist:name=bar:key=stacktrace:val=hitcount' > \
-           /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
-    # echo 'hist:name=bar:key=stacktrace:val=hitcount' > \
-          /sys/kernel/debug/tracing/events/net/netif_rx/trigger
-
-  And displaying the output of either shows some interesting if
-  somewhat confusing output:
-
-    # cat /sys/kernel/debug/tracing/events/sched/sched_process_fork/hist
-    # cat /sys/kernel/debug/tracing/events/net/netif_rx/hist
-
-    # event histogram
-    #
-    # trigger info: hist:name=bar:keys=stacktrace:vals=hitcount:sort=hitcount:size=2048 [active]
-    #
-
-    { stacktrace:
-             _do_fork+0x18e/0x330
-             kernel_thread+0x29/0x30
-             kthreadd+0x154/0x1b0
-             ret_from_fork+0x3f/0x70
-    } hitcount:          1
-    { stacktrace:
-             netif_rx_internal+0xb2/0xd0
-             netif_rx_ni+0x20/0x70
-             dev_loopback_xmit+0xaa/0xd0
-             ip_mc_output+0x126/0x240
-             ip_local_out_sk+0x31/0x40
-             igmp_send_report+0x1e9/0x230
-             igmp_timer_expire+0xe9/0x120
-             call_timer_fn+0x39/0xf0
-             run_timer_softirq+0x1e1/0x290
-             __do_softirq+0xfd/0x290
-             irq_exit+0x98/0xb0
-             smp_apic_timer_interrupt+0x4a/0x60
-             apic_timer_interrupt+0x6d/0x80
-             cpuidle_enter+0x17/0x20
-             call_cpuidle+0x3b/0x60
-             cpu_startup_entry+0x22d/0x310
-    } hitcount:          1
-    { stacktrace:
-             netif_rx_internal+0xb2/0xd0
-             netif_rx_ni+0x20/0x70
-             dev_loopback_xmit+0xaa/0xd0
-             ip_mc_output+0x17f/0x240
-             ip_local_out_sk+0x31/0x40
-             ip_send_skb+0x1a/0x50
-             udp_send_skb+0x13e/0x270
-             udp_sendmsg+0x2bf/0x980
-             inet_sendmsg+0x67/0xa0
-             sock_sendmsg+0x38/0x50
-             SYSC_sendto+0xef/0x170
-             SyS_sendto+0xe/0x10
-             entry_SYSCALL_64_fastpath+0x12/0x6a
-    } hitcount:          2
-    { stacktrace:
-             netif_rx_internal+0xb2/0xd0
-             netif_rx+0x1c/0x60
-             loopback_xmit+0x6c/0xb0
-             dev_hard_start_xmit+0x219/0x3a0
-             __dev_queue_xmit+0x415/0x4f0
-             dev_queue_xmit_sk+0x13/0x20
-             ip_finish_output2+0x237/0x340
-             ip_finish_output+0x113/0x1d0
-             ip_output+0x66/0xc0
-             ip_local_out_sk+0x31/0x40
-             ip_send_skb+0x1a/0x50
-             udp_send_skb+0x16d/0x270
-             udp_sendmsg+0x2bf/0x980
-             inet_sendmsg+0x67/0xa0
-             sock_sendmsg+0x38/0x50
-             ___sys_sendmsg+0x14e/0x270
-    } hitcount:         76
-    { stacktrace:
-             netif_rx_internal+0xb2/0xd0
-             netif_rx+0x1c/0x60
-             loopback_xmit+0x6c/0xb0
-             dev_hard_start_xmit+0x219/0x3a0
-             __dev_queue_xmit+0x415/0x4f0
-             dev_queue_xmit_sk+0x13/0x20
-             ip_finish_output2+0x237/0x340
-             ip_finish_output+0x113/0x1d0
-             ip_output+0x66/0xc0
-             ip_local_out_sk+0x31/0x40
-             ip_send_skb+0x1a/0x50
-             udp_send_skb+0x16d/0x270
-             udp_sendmsg+0x2bf/0x980
-             inet_sendmsg+0x67/0xa0
-             sock_sendmsg+0x38/0x50
-             ___sys_sendmsg+0x269/0x270
-    } hitcount:         77
-    { stacktrace:
-             netif_rx_internal+0xb2/0xd0
-             netif_rx+0x1c/0x60
-             loopback_xmit+0x6c/0xb0
-             dev_hard_start_xmit+0x219/0x3a0
-             __dev_queue_xmit+0x415/0x4f0
-             dev_queue_xmit_sk+0x13/0x20
-             ip_finish_output2+0x237/0x340
-             ip_finish_output+0x113/0x1d0
-             ip_output+0x66/0xc0
-             ip_local_out_sk+0x31/0x40
-             ip_send_skb+0x1a/0x50
-             udp_send_skb+0x16d/0x270
-             udp_sendmsg+0x2bf/0x980
-             inet_sendmsg+0x67/0xa0
-             sock_sendmsg+0x38/0x50
-             SYSC_sendto+0xef/0x170
-    } hitcount:         88
-    { stacktrace:
-             _do_fork+0x18e/0x330
-             SyS_clone+0x19/0x20
-             entry_SYSCALL_64_fastpath+0x12/0x6a
-    } hitcount:        244
-
-    Totals:
-        Hits: 489
-        Entries: 7
-        Dropped: 0
+  See Documentation/trace/histogram.txt for details and examples.
diff --git a/Documentation/trace/ftrace.txt b/Documentation/trace/ftrace.txt
index d4601df6e72e..54213e5c23f6 100644
--- a/Documentation/trace/ftrace.txt
+++ b/Documentation/trace/ftrace.txt
@@ -539,6 +539,30 @@ of ftrace. Here is a list of some of the key files:
 
 	See events.txt for more information.
 
+  timestamp_mode:
+
+	Certain tracers may change the timestamp mode used when
+	logging trace events into the event buffer.  Events with
+	different modes can coexist within a buffer but the mode in
+	effect when an event is logged determines which timestamp mode
+	is used for that event.  The default timestamp mode is
+	'delta'.
+
+	Usual timestamp modes for tracing:
+
+	  # cat timestamp_mode
+	  [delta] absolute
+
+	  The timestamp mode with the square brackets around it is the
+	  one in effect.
+
+	  delta: Default timestamp mode - timestamp is a delta against
+	         a per-buffer timestamp.
+
+	  absolute: The timestamp is a full timestamp, not a delta
+                 against some other value.  As such it takes up more
+                 space and is less efficient.
+
   hwlat_detector:
 
 	Directory for the Hardware Latency Detector.
diff --git a/Documentation/trace/histogram.txt b/Documentation/trace/histogram.txt
new file mode 100644
index 000000000000..6e05510afc28
--- /dev/null
+++ b/Documentation/trace/histogram.txt
@@ -0,0 +1,1995 @@
+			     Event Histograms
+
+		    Documentation written by Tom Zanussi
+
+1. Introduction
+===============
+
+  Histogram triggers are special event triggers that can be used to
+  aggregate trace event data into histograms.  For information on
+  trace events and event triggers, see Documentation/trace/events.txt.
+
+
+2. Histogram Trigger Command
+============================
+
+  A histogram trigger command is an event trigger command that
+  aggregates event hits into a hash table keyed on one or more trace
+  event format fields (or stacktrace) and a set of running totals
+  derived from one or more trace event format fields and/or event
+  counts (hitcount).
+
+  The format of a hist trigger is as follows:
+
+        hist:keys=<field1[,field2,...]>[:values=<field1[,field2,...]>]
+          [:sort=<field1[,field2,...]>][:size=#entries][:pause][:continue]
+          [:clear][:name=histname1] [if <filter>]
+
+  When a matching event is hit, an entry is added to a hash table
+  using the key(s) and value(s) named.  Keys and values correspond to
+  fields in the event's format description.  Values must correspond to
+  numeric fields - on an event hit, the value(s) will be added to a
+  sum kept for that field.  The special string 'hitcount' can be used
+  in place of an explicit value field - this is simply a count of
+  event hits.  If 'values' isn't specified, an implicit 'hitcount'
+  value will be automatically created and used as the only value.
+  Keys can be any field, or the special string 'stacktrace', which
+  will use the event's kernel stacktrace as the key.  The keywords
+  'keys' or 'key' can be used to specify keys, and the keywords
+  'values', 'vals', or 'val' can be used to specify values.  Compound
+  keys consisting of up to two fields can be specified by the 'keys'
+  keyword.  Hashing a compound key produces a unique entry in the
+  table for each unique combination of component keys, and can be
+  useful for providing more fine-grained summaries of event data.
+  Additionally, sort keys consisting of up to two fields can be
+  specified by the 'sort' keyword.  If more than one field is
+  specified, the result will be a 'sort within a sort': the first key
+  is taken to be the primary sort key and the second the secondary
+  key.  If a hist trigger is given a name using the 'name' parameter,
+  its histogram data will be shared with other triggers of the same
+  name, and trigger hits will update this common data.  Only triggers
+  with 'compatible' fields can be combined in this way; triggers are
+  'compatible' if the fields named in the trigger share the same
+  number and type of fields and those fields also have the same names.
+  Note that any two events always share the compatible 'hitcount' and
+  'stacktrace' fields and can therefore be combined using those
+  fields, however pointless that may be.
+
+  'hist' triggers add a 'hist' file to each event's subdirectory.
+  Reading the 'hist' file for the event will dump the hash table in
+  its entirety to stdout.  If there are multiple hist triggers
+  attached to an event, there will be a table for each trigger in the
+  output.  The table displayed for a named trigger will be the same as
+  any other instance having the same name. Each printed hash table
+  entry is a simple list of the keys and values comprising the entry;
+  keys are printed first and are delineated by curly braces, and are
+  followed by the set of value fields for the entry.  By default,
+  numeric fields are displayed as base-10 integers.  This can be
+  modified by appending any of the following modifiers to the field
+  name:
+
+        .hex        display a number as a hex value
+	.sym        display an address as a symbol
+	.sym-offset display an address as a symbol and offset
+	.syscall    display a syscall id as a system call name
+	.execname   display a common_pid as a program name
+	.log2       display log2 value rather than raw number
+	.usecs      display a common_timestamp in microseconds
+
+  Note that in general the semantics of a given field aren't
+  interpreted when applying a modifier to it, but there are some
+  restrictions to be aware of in this regard:
+
+    - only the 'hex' modifier can be used for values (because values
+      are essentially sums, and the other modifiers don't make sense
+      in that context).
+    - the 'execname' modifier can only be used on a 'common_pid'.  The
+      reason for this is that the execname is simply the 'comm' value
+      saved for the 'current' process when an event was triggered,
+      which is the same as the common_pid value saved by the event
+      tracing code.  Trying to apply that comm value to other pid
+      values wouldn't be correct, and typically events that care save
+      pid-specific comm fields in the event itself.
+
+  A typical usage scenario would be the following to enable a hist
+  trigger, read its current contents, and then turn it off:
+
+  # echo 'hist:keys=skbaddr.hex:vals=len' > \
+    /sys/kernel/debug/tracing/events/net/netif_rx/trigger
+
+  # cat /sys/kernel/debug/tracing/events/net/netif_rx/hist
+
+  # echo '!hist:keys=skbaddr.hex:vals=len' > \
+    /sys/kernel/debug/tracing/events/net/netif_rx/trigger
+
+  The trigger file itself can be read to show the details of the
+  currently attached hist trigger.  This information is also displayed
+  at the top of the 'hist' file when read.
+
+  By default, the size of the hash table is 2048 entries.  The 'size'
+  parameter can be used to specify more or fewer than that.  The units
+  are in terms of hashtable entries - if a run uses more entries than
+  specified, the results will show the number of 'drops', the number
+  of hits that were ignored.  The size should be a power of 2 between
+  128 and 131072 (any non- power-of-2 number specified will be rounded
+  up).
+
+  The 'sort' parameter can be used to specify a value field to sort
+  on.  The default if unspecified is 'hitcount' and the default sort
+  order is 'ascending'.  To sort in the opposite direction, append
+  .descending' to the sort key.
+
+  The 'pause' parameter can be used to pause an existing hist trigger
+  or to start a hist trigger but not log any events until told to do
+  so.  'continue' or 'cont' can be used to start or restart a paused
+  hist trigger.
+
+  The 'clear' parameter will clear the contents of a running hist
+  trigger and leave its current paused/active state.
+
+  Note that the 'pause', 'cont', and 'clear' parameters should be
+  applied using 'append' shell operator ('>>') if applied to an
+  existing trigger, rather than via the '>' operator, which will cause
+  the trigger to be removed through truncation.
+
+- enable_hist/disable_hist
+
+  The enable_hist and disable_hist triggers can be used to have one
+  event conditionally start and stop another event's already-attached
+  hist trigger.  Any number of enable_hist and disable_hist triggers
+  can be attached to a given event, allowing that event to kick off
+  and stop aggregations on a host of other events.
+
+  The format is very similar to the enable/disable_event triggers:
+
+      enable_hist:<system>:<event>[:count]
+      disable_hist:<system>:<event>[:count]
+
+  Instead of enabling or disabling the tracing of the target event
+  into the trace buffer as the enable/disable_event triggers do, the
+  enable/disable_hist triggers enable or disable the aggregation of
+  the target event into a hash table.
+
+  A typical usage scenario for the enable_hist/disable_hist triggers
+  would be to first set up a paused hist trigger on some event,
+  followed by an enable_hist/disable_hist pair that turns the hist
+  aggregation on and off when conditions of interest are hit:
+
+  # echo 'hist:keys=skbaddr.hex:vals=len:pause' > \
+    /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+
+  # echo 'enable_hist:net:netif_receive_skb if filename==/usr/bin/wget' > \
+    /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
+
+  # echo 'disable_hist:net:netif_receive_skb if comm==wget' > \
+    /sys/kernel/debug/tracing/events/sched/sched_process_exit/trigger
+
+  The above sets up an initially paused hist trigger which is unpaused
+  and starts aggregating events when a given program is executed, and
+  which stops aggregating when the process exits and the hist trigger
+  is paused again.
+
+  The examples below provide a more concrete illustration of the
+  concepts and typical usage patterns discussed above.
+
+  'special' event fields
+  ------------------------
+
+  There are a number of 'special event fields' available for use as
+  keys or values in a hist trigger.  These look like and behave as if
+  they were actual event fields, but aren't really part of the event's
+  field definition or format file.  They are however available for any
+  event, and can be used anywhere an actual event field could be.
+  They are:
+
+    common_timestamp       u64 - timestamp (from ring buffer) associated
+                                 with the event, in nanoseconds.  May be
+				 modified by .usecs to have timestamps
+				 interpreted as microseconds.
+    cpu                    int - the cpu on which the event occurred.
+
+  Extended error information
+  --------------------------
+
+  For some error conditions encountered when invoking a hist trigger
+  command, extended error information is available via the
+  corresponding event's 'hist' file.  Reading the hist file after an
+  error will display more detailed information about what went wrong,
+  if information is available.  This extended error information will
+  be available until the next hist trigger command for that event.
+
+  If available for a given error condition, the extended error
+  information and usage takes the following form:
+
+    # echo xxx > /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
+    echo: write error: Invalid argument
+
+    # cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/hist
+    ERROR: Couldn't yyy: zzz
+      Last command: xxx
+
+6.2 'hist' trigger examples
+---------------------------
+
+  The first set of examples creates aggregations using the kmalloc
+  event.  The fields that can be used for the hist trigger are listed
+  in the kmalloc event's format file:
+
+    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/format
+    name: kmalloc
+    ID: 374
+    format:
+	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
+	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
+	field:unsigned char common_preempt_count;		offset:3;	size:1;	signed:0;
+	field:int common_pid;					offset:4;	size:4;	signed:1;
+
+	field:unsigned long call_site;				offset:8;	size:8;	signed:0;
+	field:const void * ptr;					offset:16;	size:8;	signed:0;
+	field:size_t bytes_req;					offset:24;	size:8;	signed:0;
+	field:size_t bytes_alloc;				offset:32;	size:8;	signed:0;
+	field:gfp_t gfp_flags;					offset:40;	size:4;	signed:0;
+
+  We'll start by creating a hist trigger that generates a simple table
+  that lists the total number of bytes requested for each function in
+  the kernel that made one or more calls to kmalloc:
+
+    # echo 'hist:key=call_site:val=bytes_req' > \
+            /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+
+  This tells the tracing system to create a 'hist' trigger using the
+  call_site field of the kmalloc event as the key for the table, which
+  just means that each unique call_site address will have an entry
+  created for it in the table.  The 'val=bytes_req' parameter tells
+  the hist trigger that for each unique entry (call_site) in the
+  table, it should keep a running total of the number of bytes
+  requested by that call_site.
+
+  We'll let it run for awhile and then dump the contents of the 'hist'
+  file in the kmalloc event's subdirectory (for readability, a number
+  of entries have been omitted):
+
+    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
+    # trigger info: hist:keys=call_site:vals=bytes_req:sort=hitcount:size=2048 [active]
+
+    { call_site: 18446744072106379007 } hitcount:          1  bytes_req:        176
+    { call_site: 18446744071579557049 } hitcount:          1  bytes_req:       1024
+    { call_site: 18446744071580608289 } hitcount:          1  bytes_req:      16384
+    { call_site: 18446744071581827654 } hitcount:          1  bytes_req:         24
+    { call_site: 18446744071580700980 } hitcount:          1  bytes_req:          8
+    { call_site: 18446744071579359876 } hitcount:          1  bytes_req:        152
+    { call_site: 18446744071580795365 } hitcount:          3  bytes_req:        144
+    { call_site: 18446744071581303129 } hitcount:          3  bytes_req:        144
+    { call_site: 18446744071580713234 } hitcount:          4  bytes_req:       2560
+    { call_site: 18446744071580933750 } hitcount:          4  bytes_req:        736
+    .
+    .
+    .
+    { call_site: 18446744072106047046 } hitcount:         69  bytes_req:       5576
+    { call_site: 18446744071582116407 } hitcount:         73  bytes_req:       2336
+    { call_site: 18446744072106054684 } hitcount:        136  bytes_req:     140504
+    { call_site: 18446744072106224230 } hitcount:        136  bytes_req:      19584
+    { call_site: 18446744072106078074 } hitcount:        153  bytes_req:       2448
+    { call_site: 18446744072106062406 } hitcount:        153  bytes_req:      36720
+    { call_site: 18446744071582507929 } hitcount:        153  bytes_req:      37088
+    { call_site: 18446744072102520590 } hitcount:        273  bytes_req:      10920
+    { call_site: 18446744071582143559 } hitcount:        358  bytes_req:        716
+    { call_site: 18446744072106465852 } hitcount:        417  bytes_req:      56712
+    { call_site: 18446744072102523378 } hitcount:        485  bytes_req:      27160
+    { call_site: 18446744072099568646 } hitcount:       1676  bytes_req:      33520
+
+    Totals:
+        Hits: 4610
+        Entries: 45
+        Dropped: 0
+
+  The output displays a line for each entry, beginning with the key
+  specified in the trigger, followed by the value(s) also specified in
+  the trigger.  At the beginning of the output is a line that displays
+  the trigger info, which can also be displayed by reading the
+  'trigger' file:
+
+    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+    hist:keys=call_site:vals=bytes_req:sort=hitcount:size=2048 [active]
+
+  At the end of the output are a few lines that display the overall
+  totals for the run.  The 'Hits' field shows the total number of
+  times the event trigger was hit, the 'Entries' field shows the total
+  number of used entries in the hash table, and the 'Dropped' field
+  shows the number of hits that were dropped because the number of
+  used entries for the run exceeded the maximum number of entries
+  allowed for the table (normally 0, but if not a hint that you may
+  want to increase the size of the table using the 'size' parameter).
+
+  Notice in the above output that there's an extra field, 'hitcount',
+  which wasn't specified in the trigger.  Also notice that in the
+  trigger info output, there's a parameter, 'sort=hitcount', which
+  wasn't specified in the trigger either.  The reason for that is that
+  every trigger implicitly keeps a count of the total number of hits
+  attributed to a given entry, called the 'hitcount'.  That hitcount
+  information is explicitly displayed in the output, and in the
+  absence of a user-specified sort parameter, is used as the default
+  sort field.
+
+  The value 'hitcount' can be used in place of an explicit value in
+  the 'values' parameter if you don't really need to have any
+  particular field summed and are mainly interested in hit
+  frequencies.
+
+  To turn the hist trigger off, simply call up the trigger in the
+  command history and re-execute it with a '!' prepended:
+
+    # echo '!hist:key=call_site:val=bytes_req' > \
+           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+
+  Finally, notice that the call_site as displayed in the output above
+  isn't really very useful.  It's an address, but normally addresses
+  are displayed in hex.  To have a numeric field displayed as a hex
+  value, simply append '.hex' to the field name in the trigger:
+
+    # echo 'hist:key=call_site.hex:val=bytes_req' > \
+           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+
+    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
+    # trigger info: hist:keys=call_site.hex:vals=bytes_req:sort=hitcount:size=2048 [active]
+
+    { call_site: ffffffffa026b291 } hitcount:          1  bytes_req:        433
+    { call_site: ffffffffa07186ff } hitcount:          1  bytes_req:        176
+    { call_site: ffffffff811ae721 } hitcount:          1  bytes_req:      16384
+    { call_site: ffffffff811c5134 } hitcount:          1  bytes_req:          8
+    { call_site: ffffffffa04a9ebb } hitcount:          1  bytes_req:        511
+    { call_site: ffffffff8122e0a6 } hitcount:          1  bytes_req:         12
+    { call_site: ffffffff8107da84 } hitcount:          1  bytes_req:        152
+    { call_site: ffffffff812d8246 } hitcount:          1  bytes_req:         24
+    { call_site: ffffffff811dc1e5 } hitcount:          3  bytes_req:        144
+    { call_site: ffffffffa02515e8 } hitcount:          3  bytes_req:        648
+    { call_site: ffffffff81258159 } hitcount:          3  bytes_req:        144
+    { call_site: ffffffff811c80f4 } hitcount:          4  bytes_req:        544
+    .
+    .
+    .
+    { call_site: ffffffffa06c7646 } hitcount:        106  bytes_req:       8024
+    { call_site: ffffffffa06cb246 } hitcount:        132  bytes_req:      31680
+    { call_site: ffffffffa06cef7a } hitcount:        132  bytes_req:       2112
+    { call_site: ffffffff8137e399 } hitcount:        132  bytes_req:      23232
+    { call_site: ffffffffa06c941c } hitcount:        185  bytes_req:     171360
+    { call_site: ffffffffa06f2a66 } hitcount:        185  bytes_req:      26640
+    { call_site: ffffffffa036a70e } hitcount:        265  bytes_req:      10600
+    { call_site: ffffffff81325447 } hitcount:        292  bytes_req:        584
+    { call_site: ffffffffa072da3c } hitcount:        446  bytes_req:      60656
+    { call_site: ffffffffa036b1f2 } hitcount:        526  bytes_req:      29456
+    { call_site: ffffffffa0099c06 } hitcount:       1780  bytes_req:      35600
+
+    Totals:
+        Hits: 4775
+        Entries: 46
+        Dropped: 0
+
+  Even that's only marginally more useful - while hex values do look
+  more like addresses, what users are typically more interested in
+  when looking at text addresses are the corresponding symbols
+  instead.  To have an address displayed as symbolic value instead,
+  simply append '.sym' or '.sym-offset' to the field name in the
+  trigger:
+
+    # echo 'hist:key=call_site.sym:val=bytes_req' > \
+           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+
+    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
+    # trigger info: hist:keys=call_site.sym:vals=bytes_req:sort=hitcount:size=2048 [active]
+
+    { call_site: [ffffffff810adcb9] syslog_print_all                              } hitcount:          1  bytes_req:       1024
+    { call_site: [ffffffff8154bc62] usb_control_msg                               } hitcount:          1  bytes_req:          8
+    { call_site: [ffffffffa00bf6fe] hidraw_send_report [hid]                      } hitcount:          1  bytes_req:          7
+    { call_site: [ffffffff8154acbe] usb_alloc_urb                                 } hitcount:          1  bytes_req:        192
+    { call_site: [ffffffffa00bf1ca] hidraw_report_event [hid]                     } hitcount:          1  bytes_req:          7
+    { call_site: [ffffffff811e3a25] __seq_open_private                            } hitcount:          1  bytes_req:         40
+    { call_site: [ffffffff8109524a] alloc_fair_sched_group                        } hitcount:          2  bytes_req:        128
+    { call_site: [ffffffff811febd5] fsnotify_alloc_group                          } hitcount:          2  bytes_req:        528
+    { call_site: [ffffffff81440f58] __tty_buffer_request_room                     } hitcount:          2  bytes_req:       2624
+    { call_site: [ffffffff81200ba6] inotify_new_group                             } hitcount:          2  bytes_req:         96
+    { call_site: [ffffffffa05e19af] ieee80211_start_tx_ba_session [mac80211]      } hitcount:          2  bytes_req:        464
+    { call_site: [ffffffff81672406] tcp_get_metrics                               } hitcount:          2  bytes_req:        304
+    { call_site: [ffffffff81097ec2] alloc_rt_sched_group                          } hitcount:          2  bytes_req:        128
+    { call_site: [ffffffff81089b05] sched_create_group                            } hitcount:          2  bytes_req:       1424
+    .
+    .
+    .
+    { call_site: [ffffffffa04a580c] intel_crtc_page_flip [i915]                   } hitcount:       1185  bytes_req:     123240
+    { call_site: [ffffffffa0287592] drm_mode_page_flip_ioctl [drm]                } hitcount:       1185  bytes_req:     104280
+    { call_site: [ffffffffa04c4a3c] intel_plane_duplicate_state [i915]            } hitcount:       1402  bytes_req:     190672
+    { call_site: [ffffffff812891ca] ext4_find_extent                              } hitcount:       1518  bytes_req:     146208
+    { call_site: [ffffffffa029070e] drm_vma_node_allow [drm]                      } hitcount:       1746  bytes_req:      69840
+    { call_site: [ffffffffa045e7c4] i915_gem_do_execbuffer.isra.23 [i915]         } hitcount:       2021  bytes_req:     792312
+    { call_site: [ffffffffa02911f2] drm_modeset_lock_crtc [drm]                   } hitcount:       2592  bytes_req:     145152
+    { call_site: [ffffffffa0489a66] intel_ring_begin [i915]                       } hitcount:       2629  bytes_req:     378576
+    { call_site: [ffffffffa046041c] i915_gem_execbuffer2 [i915]                   } hitcount:       2629  bytes_req:    3783248
+    { call_site: [ffffffff81325607] apparmor_file_alloc_security                  } hitcount:       5192  bytes_req:      10384
+    { call_site: [ffffffffa00b7c06] hid_report_raw_event [hid]                    } hitcount:       5529  bytes_req:     110584
+    { call_site: [ffffffff8131ebf7] aa_alloc_task_context                         } hitcount:      21943  bytes_req:     702176
+    { call_site: [ffffffff8125847d] ext4_htree_store_dirent                       } hitcount:      55759  bytes_req:    5074265
+
+    Totals:
+        Hits: 109928
+        Entries: 71
+        Dropped: 0
+
+  Because the default sort key above is 'hitcount', the above shows a
+  the list of call_sites by increasing hitcount, so that at the bottom
+  we see the functions that made the most kmalloc calls during the
+  run.  If instead we we wanted to see the top kmalloc callers in
+  terms of the number of bytes requested rather than the number of
+  calls, and we wanted the top caller to appear at the top, we can use
+  the 'sort' parameter, along with the 'descending' modifier:
+
+    # echo 'hist:key=call_site.sym:val=bytes_req:sort=bytes_req.descending' > \
+           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+
+    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
+    # trigger info: hist:keys=call_site.sym:vals=bytes_req:sort=bytes_req.descending:size=2048 [active]
+
+    { call_site: [ffffffffa046041c] i915_gem_execbuffer2 [i915]                   } hitcount:       2186  bytes_req:    3397464
+    { call_site: [ffffffffa045e7c4] i915_gem_do_execbuffer.isra.23 [i915]         } hitcount:       1790  bytes_req:     712176
+    { call_site: [ffffffff8125847d] ext4_htree_store_dirent                       } hitcount:       8132  bytes_req:     513135
+    { call_site: [ffffffff811e2a1b] seq_buf_alloc                                 } hitcount:        106  bytes_req:     440128
+    { call_site: [ffffffffa0489a66] intel_ring_begin [i915]                       } hitcount:       2186  bytes_req:     314784
+    { call_site: [ffffffff812891ca] ext4_find_extent                              } hitcount:       2174  bytes_req:     208992
+    { call_site: [ffffffff811ae8e1] __kmalloc                                     } hitcount:          8  bytes_req:     131072
+    { call_site: [ffffffffa04c4a3c] intel_plane_duplicate_state [i915]            } hitcount:        859  bytes_req:     116824
+    { call_site: [ffffffffa02911f2] drm_modeset_lock_crtc [drm]                   } hitcount:       1834  bytes_req:     102704
+    { call_site: [ffffffffa04a580c] intel_crtc_page_flip [i915]                   } hitcount:        972  bytes_req:     101088
+    { call_site: [ffffffffa0287592] drm_mode_page_flip_ioctl [drm]                } hitcount:        972  bytes_req:      85536
+    { call_site: [ffffffffa00b7c06] hid_report_raw_event [hid]                    } hitcount:       3333  bytes_req:      66664
+    { call_site: [ffffffff8137e559] sg_kmalloc                                    } hitcount:        209  bytes_req:      61632
+    .
+    .
+    .
+    { call_site: [ffffffff81095225] alloc_fair_sched_group                        } hitcount:          2  bytes_req:        128
+    { call_site: [ffffffff81097ec2] alloc_rt_sched_group                          } hitcount:          2  bytes_req:        128
+    { call_site: [ffffffff812d8406] copy_semundo                                  } hitcount:          2  bytes_req:         48
+    { call_site: [ffffffff81200ba6] inotify_new_group                             } hitcount:          1  bytes_req:         48
+    { call_site: [ffffffffa027121a] drm_getmagic [drm]                            } hitcount:          1  bytes_req:         48
+    { call_site: [ffffffff811e3a25] __seq_open_private                            } hitcount:          1  bytes_req:         40
+    { call_site: [ffffffff811c52f4] bprm_change_interp                            } hitcount:          2  bytes_req:         16
+    { call_site: [ffffffff8154bc62] usb_control_msg                               } hitcount:          1  bytes_req:          8
+    { call_site: [ffffffffa00bf1ca] hidraw_report_event [hid]                     } hitcount:          1  bytes_req:          7
+    { call_site: [ffffffffa00bf6fe] hidraw_send_report [hid]                      } hitcount:          1  bytes_req:          7
+
+    Totals:
+        Hits: 32133
+        Entries: 81
+        Dropped: 0
+
+  To display the offset and size information in addition to the symbol
+  name, just use 'sym-offset' instead:
+
+    # echo 'hist:key=call_site.sym-offset:val=bytes_req:sort=bytes_req.descending' > \
+           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+
+    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
+    # trigger info: hist:keys=call_site.sym-offset:vals=bytes_req:sort=bytes_req.descending:size=2048 [active]
+
+    { call_site: [ffffffffa046041c] i915_gem_execbuffer2+0x6c/0x2c0 [i915]                  } hitcount:       4569  bytes_req:    3163720
+    { call_site: [ffffffffa0489a66] intel_ring_begin+0xc6/0x1f0 [i915]                      } hitcount:       4569  bytes_req:     657936
+    { call_site: [ffffffffa045e7c4] i915_gem_do_execbuffer.isra.23+0x694/0x1020 [i915]      } hitcount:       1519  bytes_req:     472936
+    { call_site: [ffffffffa045e646] i915_gem_do_execbuffer.isra.23+0x516/0x1020 [i915]      } hitcount:       3050  bytes_req:     211832
+    { call_site: [ffffffff811e2a1b] seq_buf_alloc+0x1b/0x50                                 } hitcount:         34  bytes_req:     148384
+    { call_site: [ffffffffa04a580c] intel_crtc_page_flip+0xbc/0x870 [i915]                  } hitcount:       1385  bytes_req:     144040
+    { call_site: [ffffffff811ae8e1] __kmalloc+0x191/0x1b0                                   } hitcount:          8  bytes_req:     131072
+    { call_site: [ffffffffa0287592] drm_mode_page_flip_ioctl+0x282/0x360 [drm]              } hitcount:       1385  bytes_req:     121880
+    { call_site: [ffffffffa02911f2] drm_modeset_lock_crtc+0x32/0x100 [drm]                  } hitcount:       1848  bytes_req:     103488
+    { call_site: [ffffffffa04c4a3c] intel_plane_duplicate_state+0x2c/0xa0 [i915]            } hitcount:        461  bytes_req:      62696
+    { call_site: [ffffffffa029070e] drm_vma_node_allow+0x2e/0xd0 [drm]                      } hitcount:       1541  bytes_req:      61640
+    { call_site: [ffffffff815f8d7b] sk_prot_alloc+0xcb/0x1b0                                } hitcount:         57  bytes_req:      57456
+    .
+    .
+    .
+    { call_site: [ffffffff8109524a] alloc_fair_sched_group+0x5a/0x1a0                       } hitcount:          2  bytes_req:        128
+    { call_site: [ffffffffa027b921] drm_vm_open_locked+0x31/0xa0 [drm]                      } hitcount:          3  bytes_req:         96
+    { call_site: [ffffffff8122e266] proc_self_follow_link+0x76/0xb0                         } hitcount:          8  bytes_req:         96
+    { call_site: [ffffffff81213e80] load_elf_binary+0x240/0x1650                            } hitcount:          3  bytes_req:         84
+    { call_site: [ffffffff8154bc62] usb_control_msg+0x42/0x110                              } hitcount:          1  bytes_req:          8
+    { call_site: [ffffffffa00bf6fe] hidraw_send_report+0x7e/0x1a0 [hid]                     } hitcount:          1  bytes_req:          7
+    { call_site: [ffffffffa00bf1ca] hidraw_report_event+0x8a/0x120 [hid]                    } hitcount:          1  bytes_req:          7
+
+    Totals:
+        Hits: 26098
+        Entries: 64
+        Dropped: 0
+
+  We can also add multiple fields to the 'values' parameter.  For
+  example, we might want to see the total number of bytes allocated
+  alongside bytes requested, and display the result sorted by bytes
+  allocated in a descending order:
+
+    # echo 'hist:keys=call_site.sym:values=bytes_req,bytes_alloc:sort=bytes_alloc.descending' > \
+           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+
+    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
+    # trigger info: hist:keys=call_site.sym:vals=bytes_req,bytes_alloc:sort=bytes_alloc.descending:size=2048 [active]
+
+    { call_site: [ffffffffa046041c] i915_gem_execbuffer2 [i915]                   } hitcount:       7403  bytes_req:    4084360  bytes_alloc:    5958016
+    { call_site: [ffffffff811e2a1b] seq_buf_alloc                                 } hitcount:        541  bytes_req:    2213968  bytes_alloc:    2228224
+    { call_site: [ffffffffa0489a66] intel_ring_begin [i915]                       } hitcount:       7404  bytes_req:    1066176  bytes_alloc:    1421568
+    { call_site: [ffffffffa045e7c4] i915_gem_do_execbuffer.isra.23 [i915]         } hitcount:       1565  bytes_req:     557368  bytes_alloc:    1037760
+    { call_site: [ffffffff8125847d] ext4_htree_store_dirent                       } hitcount:       9557  bytes_req:     595778  bytes_alloc:     695744
+    { call_site: [ffffffffa045e646] i915_gem_do_execbuffer.isra.23 [i915]         } hitcount:       5839  bytes_req:     430680  bytes_alloc:     470400
+    { call_site: [ffffffffa04c4a3c] intel_plane_duplicate_state [i915]            } hitcount:       2388  bytes_req:     324768  bytes_alloc:     458496
+    { call_site: [ffffffffa02911f2] drm_modeset_lock_crtc [drm]                   } hitcount:       3911  bytes_req:     219016  bytes_alloc:     250304
+    { call_site: [ffffffff815f8d7b] sk_prot_alloc                                 } hitcount:        235  bytes_req:     236880  bytes_alloc:     240640
+    { call_site: [ffffffff8137e559] sg_kmalloc                                    } hitcount:        557  bytes_req:     169024  bytes_alloc:     221760
+    { call_site: [ffffffffa00b7c06] hid_report_raw_event [hid]                    } hitcount:       9378  bytes_req:     187548  bytes_alloc:     206312
+    { call_site: [ffffffffa04a580c] intel_crtc_page_flip [i915]                   } hitcount:       1519  bytes_req:     157976  bytes_alloc:     194432
+    .
+    .
+    .
+    { call_site: [ffffffff8109bd3b] sched_autogroup_create_attach                 } hitcount:          2  bytes_req:        144  bytes_alloc:        192
+    { call_site: [ffffffff81097ee8] alloc_rt_sched_group                          } hitcount:          2  bytes_req:        128  bytes_alloc:        128
+    { call_site: [ffffffff8109524a] alloc_fair_sched_group                        } hitcount:          2  bytes_req:        128  bytes_alloc:        128
+    { call_site: [ffffffff81095225] alloc_fair_sched_group                        } hitcount:          2  bytes_req:        128  bytes_alloc:        128
+    { call_site: [ffffffff81097ec2] alloc_rt_sched_group                          } hitcount:          2  bytes_req:        128  bytes_alloc:        128
+    { call_site: [ffffffff81213e80] load_elf_binary                               } hitcount:          3  bytes_req:         84  bytes_alloc:         96
+    { call_site: [ffffffff81079a2e] kthread_create_on_node                        } hitcount:          1  bytes_req:         56  bytes_alloc:         64
+    { call_site: [ffffffffa00bf6fe] hidraw_send_report [hid]                      } hitcount:          1  bytes_req:          7  bytes_alloc:          8
+    { call_site: [ffffffff8154bc62] usb_control_msg                               } hitcount:          1  bytes_req:          8  bytes_alloc:          8
+    { call_site: [ffffffffa00bf1ca] hidraw_report_event [hid]                     } hitcount:          1  bytes_req:          7  bytes_alloc:          8
+
+    Totals:
+        Hits: 66598
+        Entries: 65
+        Dropped: 0
+
+  Finally, to finish off our kmalloc example, instead of simply having
+  the hist trigger display symbolic call_sites, we can have the hist
+  trigger additionally display the complete set of kernel stack traces
+  that led to each call_site.  To do that, we simply use the special
+  value 'stacktrace' for the key parameter:
+
+    # echo 'hist:keys=stacktrace:values=bytes_req,bytes_alloc:sort=bytes_alloc' > \
+           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+
+  The above trigger will use the kernel stack trace in effect when an
+  event is triggered as the key for the hash table.  This allows the
+  enumeration of every kernel callpath that led up to a particular
+  event, along with a running total of any of the event fields for
+  that event.  Here we tally bytes requested and bytes allocated for
+  every callpath in the system that led up to a kmalloc (in this case
+  every callpath to a kmalloc for a kernel compile):
+
+    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
+    # trigger info: hist:keys=stacktrace:vals=bytes_req,bytes_alloc:sort=bytes_alloc:size=2048 [active]
+
+    { stacktrace:
+         __kmalloc_track_caller+0x10b/0x1a0
+         kmemdup+0x20/0x50
+         hidraw_report_event+0x8a/0x120 [hid]
+         hid_report_raw_event+0x3ea/0x440 [hid]
+         hid_input_report+0x112/0x190 [hid]
+         hid_irq_in+0xc2/0x260 [usbhid]
+         __usb_hcd_giveback_urb+0x72/0x120
+         usb_giveback_urb_bh+0x9e/0xe0
+         tasklet_hi_action+0xf8/0x100
+         __do_softirq+0x114/0x2c0
+         irq_exit+0xa5/0xb0
+         do_IRQ+0x5a/0xf0
+         ret_from_intr+0x0/0x30
+         cpuidle_enter+0x17/0x20
+         cpu_startup_entry+0x315/0x3e0
+         rest_init+0x7c/0x80
+    } hitcount:          3  bytes_req:         21  bytes_alloc:         24
+    { stacktrace:
+         __kmalloc_track_caller+0x10b/0x1a0
+         kmemdup+0x20/0x50
+         hidraw_report_event+0x8a/0x120 [hid]
+         hid_report_raw_event+0x3ea/0x440 [hid]
+         hid_input_report+0x112/0x190 [hid]
+         hid_irq_in+0xc2/0x260 [usbhid]
+         __usb_hcd_giveback_urb+0x72/0x120
+         usb_giveback_urb_bh+0x9e/0xe0
+         tasklet_hi_action+0xf8/0x100
+         __do_softirq+0x114/0x2c0
+         irq_exit+0xa5/0xb0
+         do_IRQ+0x5a/0xf0
+         ret_from_intr+0x0/0x30
+    } hitcount:          3  bytes_req:         21  bytes_alloc:         24
+    { stacktrace:
+         kmem_cache_alloc_trace+0xeb/0x150
+         aa_alloc_task_context+0x27/0x40
+         apparmor_cred_prepare+0x1f/0x50
+         security_prepare_creds+0x16/0x20
+         prepare_creds+0xdf/0x1a0
+         SyS_capset+0xb5/0x200
+         system_call_fastpath+0x12/0x6a
+    } hitcount:          1  bytes_req:         32  bytes_alloc:         32
+    .
+    .
+    .
+    { stacktrace:
+         __kmalloc+0x11b/0x1b0
+         i915_gem_execbuffer2+0x6c/0x2c0 [i915]
+         drm_ioctl+0x349/0x670 [drm]
+         do_vfs_ioctl+0x2f0/0x4f0
+         SyS_ioctl+0x81/0xa0
+         system_call_fastpath+0x12/0x6a
+    } hitcount:      17726  bytes_req:   13944120  bytes_alloc:   19593808
+    { stacktrace:
+         __kmalloc+0x11b/0x1b0
+         load_elf_phdrs+0x76/0xa0
+         load_elf_binary+0x102/0x1650
+         search_binary_handler+0x97/0x1d0
+         do_execveat_common.isra.34+0x551/0x6e0
+         SyS_execve+0x3a/0x50
+         return_from_execve+0x0/0x23
+    } hitcount:      33348  bytes_req:   17152128  bytes_alloc:   20226048
+    { stacktrace:
+         kmem_cache_alloc_trace+0xeb/0x150
+         apparmor_file_alloc_security+0x27/0x40
+         security_file_alloc+0x16/0x20
+         get_empty_filp+0x93/0x1c0
+         path_openat+0x31/0x5f0
+         do_filp_open+0x3a/0x90
+         do_sys_open+0x128/0x220
+         SyS_open+0x1e/0x20
+         system_call_fastpath+0x12/0x6a
+    } hitcount:    4766422  bytes_req:    9532844  bytes_alloc:   38131376
+    { stacktrace:
+         __kmalloc+0x11b/0x1b0
+         seq_buf_alloc+0x1b/0x50
+         seq_read+0x2cc/0x370
+         proc_reg_read+0x3d/0x80
+         __vfs_read+0x28/0xe0
+         vfs_read+0x86/0x140
+         SyS_read+0x46/0xb0
+         system_call_fastpath+0x12/0x6a
+    } hitcount:      19133  bytes_req:   78368768  bytes_alloc:   78368768
+
+    Totals:
+        Hits: 6085872
+        Entries: 253
+        Dropped: 0
+
+  If you key a hist trigger on common_pid, in order for example to
+  gather and display sorted totals for each process, you can use the
+  special .execname modifier to display the executable names for the
+  processes in the table rather than raw pids.  The example below
+  keeps a per-process sum of total bytes read:
+
+    # echo 'hist:key=common_pid.execname:val=count:sort=count.descending' > \
+           /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/trigger
+
+    # cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/hist
+    # trigger info: hist:keys=common_pid.execname:vals=count:sort=count.descending:size=2048 [active]
+
+    { common_pid: gnome-terminal  [      3196] } hitcount:        280  count:    1093512
+    { common_pid: Xorg            [      1309] } hitcount:        525  count:     256640
+    { common_pid: compiz          [      2889] } hitcount:         59  count:     254400
+    { common_pid: bash            [      8710] } hitcount:          3  count:      66369
+    { common_pid: dbus-daemon-lau [      8703] } hitcount:         49  count:      47739
+    { common_pid: irqbalance      [      1252] } hitcount:         27  count:      27648
+    { common_pid: 01ifupdown      [      8705] } hitcount:          3  count:      17216
+    { common_pid: dbus-daemon     [       772] } hitcount:         10  count:      12396
+    { common_pid: Socket Thread   [      8342] } hitcount:         11  count:      11264
+    { common_pid: nm-dhcp-client. [      8701] } hitcount:          6  count:       7424
+    { common_pid: gmain           [      1315] } hitcount:         18  count:       6336
+    .
+    .
+    .
+    { common_pid: postgres        [      1892] } hitcount:          2  count:         32
+    { common_pid: postgres        [      1891] } hitcount:          2  count:         32
+    { common_pid: gmain           [      8704] } hitcount:          2  count:         32
+    { common_pid: upstart-dbus-br [      2740] } hitcount:         21  count:         21
+    { common_pid: nm-dispatcher.a [      8696] } hitcount:          1  count:         16
+    { common_pid: indicator-datet [      2904] } hitcount:          1  count:         16
+    { common_pid: gdbus           [      2998] } hitcount:          1  count:         16
+    { common_pid: rtkit-daemon    [      2052] } hitcount:          1  count:          8
+    { common_pid: init            [         1] } hitcount:          2  count:          2
+
+    Totals:
+        Hits: 2116
+        Entries: 51
+        Dropped: 0
+
+  Similarly, if you key a hist trigger on syscall id, for example to
+  gather and display a list of systemwide syscall hits, you can use
+  the special .syscall modifier to display the syscall names rather
+  than raw ids.  The example below keeps a running total of syscall
+  counts for the system during the run:
+
+    # echo 'hist:key=id.syscall:val=hitcount' > \
+           /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger
+
+    # cat /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/hist
+    # trigger info: hist:keys=id.syscall:vals=hitcount:sort=hitcount:size=2048 [active]
+
+    { id: sys_fsync                     [ 74] } hitcount:          1
+    { id: sys_newuname                  [ 63] } hitcount:          1
+    { id: sys_prctl                     [157] } hitcount:          1
+    { id: sys_statfs                    [137] } hitcount:          1
+    { id: sys_symlink                   [ 88] } hitcount:          1
+    { id: sys_sendmmsg                  [307] } hitcount:          1
+    { id: sys_semctl                    [ 66] } hitcount:          1
+    { id: sys_readlink                  [ 89] } hitcount:          3
+    { id: sys_bind                      [ 49] } hitcount:          3
+    { id: sys_getsockname               [ 51] } hitcount:          3
+    { id: sys_unlink                    [ 87] } hitcount:          3
+    { id: sys_rename                    [ 82] } hitcount:          4
+    { id: unknown_syscall               [ 58] } hitcount:          4
+    { id: sys_connect                   [ 42] } hitcount:          4
+    { id: sys_getpid                    [ 39] } hitcount:          4
+    .
+    .
+    .
+    { id: sys_rt_sigprocmask            [ 14] } hitcount:        952
+    { id: sys_futex                     [202] } hitcount:       1534
+    { id: sys_write                     [  1] } hitcount:       2689
+    { id: sys_setitimer                 [ 38] } hitcount:       2797
+    { id: sys_read                      [  0] } hitcount:       3202
+    { id: sys_select                    [ 23] } hitcount:       3773
+    { id: sys_writev                    [ 20] } hitcount:       4531
+    { id: sys_poll                      [  7] } hitcount:       8314
+    { id: sys_recvmsg                   [ 47] } hitcount:      13738
+    { id: sys_ioctl                     [ 16] } hitcount:      21843
+
+    Totals:
+        Hits: 67612
+        Entries: 72
+        Dropped: 0
+
+    The syscall counts above provide a rough overall picture of system
+    call activity on the system; we can see for example that the most
+    popular system call on this system was the 'sys_ioctl' system call.
+
+    We can use 'compound' keys to refine that number and provide some
+    further insight as to which processes exactly contribute to the
+    overall ioctl count.
+
+    The command below keeps a hitcount for every unique combination of
+    system call id and pid - the end result is essentially a table
+    that keeps a per-pid sum of system call hits.  The results are
+    sorted using the system call id as the primary key, and the
+    hitcount sum as the secondary key:
+
+    # echo 'hist:key=id.syscall,common_pid.execname:val=hitcount:sort=id,hitcount' > \
+           /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger
+
+    # cat /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/hist
+    # trigger info: hist:keys=id.syscall,common_pid.execname:vals=hitcount:sort=id.syscall,hitcount:size=2048 [active]
+
+    { id: sys_read                      [  0], common_pid: rtkit-daemon    [      1877] } hitcount:          1
+    { id: sys_read                      [  0], common_pid: gdbus           [      2976] } hitcount:          1
+    { id: sys_read                      [  0], common_pid: console-kit-dae [      3400] } hitcount:          1
+    { id: sys_read                      [  0], common_pid: postgres        [      1865] } hitcount:          1
+    { id: sys_read                      [  0], common_pid: deja-dup-monito [      3543] } hitcount:          2
+    { id: sys_read                      [  0], common_pid: NetworkManager  [       890] } hitcount:          2
+    { id: sys_read                      [  0], common_pid: evolution-calen [      3048] } hitcount:          2
+    { id: sys_read                      [  0], common_pid: postgres        [      1864] } hitcount:          2
+    { id: sys_read                      [  0], common_pid: nm-applet       [      3022] } hitcount:          2
+    { id: sys_read                      [  0], common_pid: whoopsie        [      1212] } hitcount:          2
+    .
+    .
+    .
+    { id: sys_ioctl                     [ 16], common_pid: bash            [      8479] } hitcount:          1
+    { id: sys_ioctl                     [ 16], common_pid: bash            [      3472] } hitcount:         12
+    { id: sys_ioctl                     [ 16], common_pid: gnome-terminal  [      3199] } hitcount:         16
+    { id: sys_ioctl                     [ 16], common_pid: Xorg            [      1267] } hitcount:       1808
+    { id: sys_ioctl                     [ 16], common_pid: compiz          [      2994] } hitcount:       5580
+    .
+    .
+    .
+    { id: sys_waitid                    [247], common_pid: upstart-dbus-br [      2690] } hitcount:          3
+    { id: sys_waitid                    [247], common_pid: upstart-dbus-br [      2688] } hitcount:         16
+    { id: sys_inotify_add_watch         [254], common_pid: gmain           [       975] } hitcount:          2
+    { id: sys_inotify_add_watch         [254], common_pid: gmain           [      3204] } hitcount:          4
+    { id: sys_inotify_add_watch         [254], common_pid: gmain           [      2888] } hitcount:          4
+    { id: sys_inotify_add_watch         [254], common_pid: gmain           [      3003] } hitcount:          4
+    { id: sys_inotify_add_watch         [254], common_pid: gmain           [      2873] } hitcount:          4
+    { id: sys_inotify_add_watch         [254], common_pid: gmain           [      3196] } hitcount:          6
+    { id: sys_openat                    [257], common_pid: java            [      2623] } hitcount:          2
+    { id: sys_eventfd2                  [290], common_pid: ibus-ui-gtk3    [      2760] } hitcount:          4
+    { id: sys_eventfd2                  [290], common_pid: compiz          [      2994] } hitcount:          6
+
+    Totals:
+        Hits: 31536
+        Entries: 323
+        Dropped: 0
+
+    The above list does give us a breakdown of the ioctl syscall by
+    pid, but it also gives us quite a bit more than that, which we
+    don't really care about at the moment.  Since we know the syscall
+    id for sys_ioctl (16, displayed next to the sys_ioctl name), we
+    can use that to filter out all the other syscalls:
+
+    # echo 'hist:key=id.syscall,common_pid.execname:val=hitcount:sort=id,hitcount if id == 16' > \
+           /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger
+
+    # cat /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/hist
+    # trigger info: hist:keys=id.syscall,common_pid.execname:vals=hitcount:sort=id.syscall,hitcount:size=2048 if id == 16 [active]
+
+    { id: sys_ioctl                     [ 16], common_pid: gmain           [      2769] } hitcount:          1
+    { id: sys_ioctl                     [ 16], common_pid: evolution-addre [      8571] } hitcount:          1
+    { id: sys_ioctl                     [ 16], common_pid: gmain           [      3003] } hitcount:          1
+    { id: sys_ioctl                     [ 16], common_pid: gmain           [      2781] } hitcount:          1
+    { id: sys_ioctl                     [ 16], common_pid: gmain           [      2829] } hitcount:          1
+    { id: sys_ioctl                     [ 16], common_pid: bash            [      8726] } hitcount:          1
+    { id: sys_ioctl                     [ 16], common_pid: bash            [      8508] } hitcount:          1
+    { id: sys_ioctl                     [ 16], common_pid: gmain           [      2970] } hitcount:          1
+    { id: sys_ioctl                     [ 16], common_pid: gmain           [      2768] } hitcount:          1
+    .
+    .
+    .
+    { id: sys_ioctl                     [ 16], common_pid: pool            [      8559] } hitcount:         45
+    { id: sys_ioctl                     [ 16], common_pid: pool            [      8555] } hitcount:         48
+    { id: sys_ioctl                     [ 16], common_pid: pool            [      8551] } hitcount:         48
+    { id: sys_ioctl                     [ 16], common_pid: avahi-daemon    [       896] } hitcount:         66
+    { id: sys_ioctl                     [ 16], common_pid: Xorg            [      1267] } hitcount:      26674
+    { id: sys_ioctl                     [ 16], common_pid: compiz          [      2994] } hitcount:      73443
+
+    Totals:
+        Hits: 101162
+        Entries: 103
+        Dropped: 0
+
+    The above output shows that 'compiz' and 'Xorg' are far and away
+    the heaviest ioctl callers (which might lead to questions about
+    whether they really need to be making all those calls and to
+    possible avenues for further investigation.)
+
+    The compound key examples used a key and a sum value (hitcount) to
+    sort the output, but we can just as easily use two keys instead.
+    Here's an example where we use a compound key composed of the the
+    common_pid and size event fields.  Sorting with pid as the primary
+    key and 'size' as the secondary key allows us to display an
+    ordered summary of the recvfrom sizes, with counts, received by
+    each process:
+
+    # echo 'hist:key=common_pid.execname,size:val=hitcount:sort=common_pid,size' > \
+           /sys/kernel/debug/tracing/events/syscalls/sys_enter_recvfrom/trigger
+
+    # cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_recvfrom/hist
+    # trigger info: hist:keys=common_pid.execname,size:vals=hitcount:sort=common_pid.execname,size:size=2048 [active]
+
+    { common_pid: smbd            [       784], size:          4 } hitcount:          1
+    { common_pid: dnsmasq         [      1412], size:       4096 } hitcount:        672
+    { common_pid: postgres        [      1796], size:       1000 } hitcount:          6
+    { common_pid: postgres        [      1867], size:       1000 } hitcount:         10
+    { common_pid: bamfdaemon      [      2787], size:         28 } hitcount:          2
+    { common_pid: bamfdaemon      [      2787], size:      14360 } hitcount:          1
+    { common_pid: compiz          [      2994], size:          8 } hitcount:          1
+    { common_pid: compiz          [      2994], size:         20 } hitcount:         11
+    { common_pid: gnome-terminal  [      3199], size:          4 } hitcount:          2
+    { common_pid: firefox         [      8817], size:          4 } hitcount:          1
+    { common_pid: firefox         [      8817], size:          8 } hitcount:          5
+    { common_pid: firefox         [      8817], size:        588 } hitcount:          2
+    { common_pid: firefox         [      8817], size:        628 } hitcount:          1
+    { common_pid: firefox         [      8817], size:       6944 } hitcount:          1
+    { common_pid: firefox         [      8817], size:     408880 } hitcount:          2
+    { common_pid: firefox         [      8822], size:          8 } hitcount:          2
+    { common_pid: firefox         [      8822], size:        160 } hitcount:          2
+    { common_pid: firefox         [      8822], size:        320 } hitcount:          2
+    { common_pid: firefox         [      8822], size:        352 } hitcount:          1
+    .
+    .
+    .
+    { common_pid: pool            [      8923], size:       1960 } hitcount:         10
+    { common_pid: pool            [      8923], size:       2048 } hitcount:         10
+    { common_pid: pool            [      8924], size:       1960 } hitcount:         10
+    { common_pid: pool            [      8924], size:       2048 } hitcount:         10
+    { common_pid: pool            [      8928], size:       1964 } hitcount:          4
+    { common_pid: pool            [      8928], size:       1965 } hitcount:          2
+    { common_pid: pool            [      8928], size:       2048 } hitcount:          6
+    { common_pid: pool            [      8929], size:       1982 } hitcount:          1
+    { common_pid: pool            [      8929], size:       2048 } hitcount:          1
+
+    Totals:
+        Hits: 2016
+        Entries: 224
+        Dropped: 0
+
+  The above example also illustrates the fact that although a compound
+  key is treated as a single entity for hashing purposes, the sub-keys
+  it's composed of can be accessed independently.
+
+  The next example uses a string field as the hash key and
+  demonstrates how you can manually pause and continue a hist trigger.
+  In this example, we'll aggregate fork counts and don't expect a
+  large number of entries in the hash table, so we'll drop it to a
+  much smaller number, say 256:
+
+    # echo 'hist:key=child_comm:val=hitcount:size=256' > \
+           /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
+
+    # cat /sys/kernel/debug/tracing/events/sched/sched_process_fork/hist
+    # trigger info: hist:keys=child_comm:vals=hitcount:sort=hitcount:size=256 [active]
+
+    { child_comm: dconf worker                        } hitcount:          1
+    { child_comm: ibus-daemon                         } hitcount:          1
+    { child_comm: whoopsie                            } hitcount:          1
+    { child_comm: smbd                                } hitcount:          1
+    { child_comm: gdbus                               } hitcount:          1
+    { child_comm: kthreadd                            } hitcount:          1
+    { child_comm: dconf worker                        } hitcount:          1
+    { child_comm: evolution-alarm                     } hitcount:          2
+    { child_comm: Socket Thread                       } hitcount:          2
+    { child_comm: postgres                            } hitcount:          2
+    { child_comm: bash                                } hitcount:          3
+    { child_comm: compiz                              } hitcount:          3
+    { child_comm: evolution-sourc                     } hitcount:          4
+    { child_comm: dhclient                            } hitcount:          4
+    { child_comm: pool                                } hitcount:          5
+    { child_comm: nm-dispatcher.a                     } hitcount:          8
+    { child_comm: firefox                             } hitcount:          8
+    { child_comm: dbus-daemon                         } hitcount:          8
+    { child_comm: glib-pacrunner                      } hitcount:         10
+    { child_comm: evolution                           } hitcount:         23
+
+    Totals:
+        Hits: 89
+        Entries: 20
+        Dropped: 0
+
+  If we want to pause the hist trigger, we can simply append :pause to
+  the command that started the trigger.  Notice that the trigger info
+  displays as [paused]:
+
+    # echo 'hist:key=child_comm:val=hitcount:size=256:pause' >> \
+           /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
+
+    # cat /sys/kernel/debug/tracing/events/sched/sched_process_fork/hist
+    # trigger info: hist:keys=child_comm:vals=hitcount:sort=hitcount:size=256 [paused]
+
+    { child_comm: dconf worker                        } hitcount:          1
+    { child_comm: kthreadd                            } hitcount:          1
+    { child_comm: dconf worker                        } hitcount:          1
+    { child_comm: gdbus                               } hitcount:          1
+    { child_comm: ibus-daemon                         } hitcount:          1
+    { child_comm: Socket Thread                       } hitcount:          2
+    { child_comm: evolution-alarm                     } hitcount:          2
+    { child_comm: smbd                                } hitcount:          2
+    { child_comm: bash                                } hitcount:          3
+    { child_comm: whoopsie                            } hitcount:          3
+    { child_comm: compiz                              } hitcount:          3
+    { child_comm: evolution-sourc                     } hitcount:          4
+    { child_comm: pool                                } hitcount:          5
+    { child_comm: postgres                            } hitcount:          6
+    { child_comm: firefox                             } hitcount:          8
+    { child_comm: dhclient                            } hitcount:         10
+    { child_comm: emacs                               } hitcount:         12
+    { child_comm: dbus-daemon                         } hitcount:         20
+    { child_comm: nm-dispatcher.a                     } hitcount:         20
+    { child_comm: evolution                           } hitcount:         35
+    { child_comm: glib-pacrunner                      } hitcount:         59
+
+    Totals:
+        Hits: 199
+        Entries: 21
+        Dropped: 0
+
+  To manually continue having the trigger aggregate events, append
+  :cont instead.  Notice that the trigger info displays as [active]
+  again, and the data has changed:
+
+    # echo 'hist:key=child_comm:val=hitcount:size=256:cont' >> \
+           /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
+
+    # cat /sys/kernel/debug/tracing/events/sched/sched_process_fork/hist
+    # trigger info: hist:keys=child_comm:vals=hitcount:sort=hitcount:size=256 [active]
+
+    { child_comm: dconf worker                        } hitcount:          1
+    { child_comm: dconf worker                        } hitcount:          1
+    { child_comm: kthreadd                            } hitcount:          1
+    { child_comm: gdbus                               } hitcount:          1
+    { child_comm: ibus-daemon                         } hitcount:          1
+    { child_comm: Socket Thread                       } hitcount:          2
+    { child_comm: evolution-alarm                     } hitcount:          2
+    { child_comm: smbd                                } hitcount:          2
+    { child_comm: whoopsie                            } hitcount:          3
+    { child_comm: compiz                              } hitcount:          3
+    { child_comm: evolution-sourc                     } hitcount:          4
+    { child_comm: bash                                } hitcount:          5
+    { child_comm: pool                                } hitcount:          5
+    { child_comm: postgres                            } hitcount:          6
+    { child_comm: firefox                             } hitcount:          8
+    { child_comm: dhclient                            } hitcount:         11
+    { child_comm: emacs                               } hitcount:         12
+    { child_comm: dbus-daemon                         } hitcount:         22
+    { child_comm: nm-dispatcher.a                     } hitcount:         22
+    { child_comm: evolution                           } hitcount:         35
+    { child_comm: glib-pacrunner                      } hitcount:         59
+
+    Totals:
+        Hits: 206
+        Entries: 21
+        Dropped: 0
+
+  The previous example showed how to start and stop a hist trigger by
+  appending 'pause' and 'continue' to the hist trigger command.  A
+  hist trigger can also be started in a paused state by initially
+  starting the trigger with ':pause' appended.  This allows you to
+  start the trigger only when you're ready to start collecting data
+  and not before.  For example, you could start the trigger in a
+  paused state, then unpause it and do something you want to measure,
+  then pause the trigger again when done.
+
+  Of course, doing this manually can be difficult and error-prone, but
+  it is possible to automatically start and stop a hist trigger based
+  on some condition, via the enable_hist and disable_hist triggers.
+
+  For example, suppose we wanted to take a look at the relative
+  weights in terms of skb length for each callpath that leads to a
+  netif_receieve_skb event when downloading a decent-sized file using
+  wget.
+
+  First we set up an initially paused stacktrace trigger on the
+  netif_receive_skb event:
+
+    # echo 'hist:key=stacktrace:vals=len:pause' > \
+           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+
+  Next, we set up an 'enable_hist' trigger on the sched_process_exec
+  event, with an 'if filename==/usr/bin/wget' filter.  The effect of
+  this new trigger is that it will 'unpause' the hist trigger we just
+  set up on netif_receive_skb if and only if it sees a
+  sched_process_exec event with a filename of '/usr/bin/wget'.  When
+  that happens, all netif_receive_skb events are aggregated into a
+  hash table keyed on stacktrace:
+
+    # echo 'enable_hist:net:netif_receive_skb if filename==/usr/bin/wget' > \
+           /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
+
+  The aggregation continues until the netif_receive_skb is paused
+  again, which is what the following disable_hist event does by
+  creating a similar setup on the sched_process_exit event, using the
+  filter 'comm==wget':
+
+    # echo 'disable_hist:net:netif_receive_skb if comm==wget' > \
+           /sys/kernel/debug/tracing/events/sched/sched_process_exit/trigger
+
+  Whenever a process exits and the comm field of the disable_hist
+  trigger filter matches 'comm==wget', the netif_receive_skb hist
+  trigger is disabled.
+
+  The overall effect is that netif_receive_skb events are aggregated
+  into the hash table for only the duration of the wget.  Executing a
+  wget command and then listing the 'hist' file will display the
+  output generated by the wget command:
+
+    $ wget https://www.kernel.org/pub/linux/kernel/v3.x/patch-3.19.xz
+
+    # cat /sys/kernel/debug/tracing/events/net/netif_receive_skb/hist
+    # trigger info: hist:keys=stacktrace:vals=len:sort=hitcount:size=2048 [paused]
+
+    { stacktrace:
+         __netif_receive_skb_core+0x46d/0x990
+         __netif_receive_skb+0x18/0x60
+         netif_receive_skb_internal+0x23/0x90
+         napi_gro_receive+0xc8/0x100
+         ieee80211_deliver_skb+0xd6/0x270 [mac80211]
+         ieee80211_rx_handlers+0xccf/0x22f0 [mac80211]
+         ieee80211_prepare_and_rx_handle+0x4e7/0xc40 [mac80211]
+         ieee80211_rx+0x31d/0x900 [mac80211]
+         iwlagn_rx_reply_rx+0x3db/0x6f0 [iwldvm]
+         iwl_rx_dispatch+0x8e/0xf0 [iwldvm]
+         iwl_pcie_irq_handler+0xe3c/0x12f0 [iwlwifi]
+         irq_thread_fn+0x20/0x50
+         irq_thread+0x11f/0x150
+         kthread+0xd2/0xf0
+         ret_from_fork+0x42/0x70
+    } hitcount:         85  len:      28884
+    { stacktrace:
+         __netif_receive_skb_core+0x46d/0x990
+         __netif_receive_skb+0x18/0x60
+         netif_receive_skb_internal+0x23/0x90
+         napi_gro_complete+0xa4/0xe0
+         dev_gro_receive+0x23a/0x360
+         napi_gro_receive+0x30/0x100
+         ieee80211_deliver_skb+0xd6/0x270 [mac80211]
+         ieee80211_rx_handlers+0xccf/0x22f0 [mac80211]
+         ieee80211_prepare_and_rx_handle+0x4e7/0xc40 [mac80211]
+         ieee80211_rx+0x31d/0x900 [mac80211]
+         iwlagn_rx_reply_rx+0x3db/0x6f0 [iwldvm]
+         iwl_rx_dispatch+0x8e/0xf0 [iwldvm]
+         iwl_pcie_irq_handler+0xe3c/0x12f0 [iwlwifi]
+         irq_thread_fn+0x20/0x50
+         irq_thread+0x11f/0x150
+         kthread+0xd2/0xf0
+    } hitcount:         98  len:     664329
+    { stacktrace:
+         __netif_receive_skb_core+0x46d/0x990
+         __netif_receive_skb+0x18/0x60
+         process_backlog+0xa8/0x150
+         net_rx_action+0x15d/0x340
+         __do_softirq+0x114/0x2c0
+         do_softirq_own_stack+0x1c/0x30
+         do_softirq+0x65/0x70
+         __local_bh_enable_ip+0xb5/0xc0
+         ip_finish_output+0x1f4/0x840
+         ip_output+0x6b/0xc0
+         ip_local_out_sk+0x31/0x40
+         ip_send_skb+0x1a/0x50
+         udp_send_skb+0x173/0x2a0
+         udp_sendmsg+0x2bf/0x9f0
+         inet_sendmsg+0x64/0xa0
+         sock_sendmsg+0x3d/0x50
+    } hitcount:        115  len:      13030
+    { stacktrace:
+         __netif_receive_skb_core+0x46d/0x990
+         __netif_receive_skb+0x18/0x60
+         netif_receive_skb_internal+0x23/0x90
+         napi_gro_complete+0xa4/0xe0
+         napi_gro_flush+0x6d/0x90
+         iwl_pcie_irq_handler+0x92a/0x12f0 [iwlwifi]
+         irq_thread_fn+0x20/0x50
+         irq_thread+0x11f/0x150
+         kthread+0xd2/0xf0
+         ret_from_fork+0x42/0x70
+    } hitcount:        934  len:    5512212
+
+    Totals:
+        Hits: 1232
+        Entries: 4
+        Dropped: 0
+
+  The above shows all the netif_receive_skb callpaths and their total
+  lengths for the duration of the wget command.
+
+  The 'clear' hist trigger param can be used to clear the hash table.
+  Suppose we wanted to try another run of the previous example but
+  this time also wanted to see the complete list of events that went
+  into the histogram.  In order to avoid having to set everything up
+  again, we can just clear the histogram first:
+
+    # echo 'hist:key=stacktrace:vals=len:clear' >> \
+           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+
+  Just to verify that it is in fact cleared, here's what we now see in
+  the hist file:
+
+    # cat /sys/kernel/debug/tracing/events/net/netif_receive_skb/hist
+    # trigger info: hist:keys=stacktrace:vals=len:sort=hitcount:size=2048 [paused]
+
+    Totals:
+        Hits: 0
+        Entries: 0
+        Dropped: 0
+
+  Since we want to see the detailed list of every netif_receive_skb
+  event occurring during the new run, which are in fact the same
+  events being aggregated into the hash table, we add some additional
+  'enable_event' events to the triggering sched_process_exec and
+  sched_process_exit events as such:
+
+    # echo 'enable_event:net:netif_receive_skb if filename==/usr/bin/wget' > \
+           /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
+
+    # echo 'disable_event:net:netif_receive_skb if comm==wget' > \
+           /sys/kernel/debug/tracing/events/sched/sched_process_exit/trigger
+
+  If you read the trigger files for the sched_process_exec and
+  sched_process_exit triggers, you should see two triggers for each:
+  one enabling/disabling the hist aggregation and the other
+  enabling/disabling the logging of events:
+
+    # cat /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
+    enable_event:net:netif_receive_skb:unlimited if filename==/usr/bin/wget
+    enable_hist:net:netif_receive_skb:unlimited if filename==/usr/bin/wget
+
+    # cat /sys/kernel/debug/tracing/events/sched/sched_process_exit/trigger
+    enable_event:net:netif_receive_skb:unlimited if comm==wget
+    disable_hist:net:netif_receive_skb:unlimited if comm==wget
+
+  In other words, whenever either of the sched_process_exec or
+  sched_process_exit events is hit and matches 'wget', it enables or
+  disables both the histogram and the event log, and what you end up
+  with is a hash table and set of events just covering the specified
+  duration.  Run the wget command again:
+
+    $ wget https://www.kernel.org/pub/linux/kernel/v3.x/patch-3.19.xz
+
+  Displaying the 'hist' file should show something similar to what you
+  saw in the last run, but this time you should also see the
+  individual events in the trace file:
+
+    # cat /sys/kernel/debug/tracing/trace
+
+    # tracer: nop
+    #
+    # entries-in-buffer/entries-written: 183/1426   #P:4
+    #
+    #                              _-----=> irqs-off
+    #                             / _----=> need-resched
+    #                            | / _---=> hardirq/softirq
+    #                            || / _--=> preempt-depth
+    #                            ||| /     delay
+    #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
+    #              | |       |   ||||       |         |
+                wget-15108 [000] ..s1 31769.606929: netif_receive_skb: dev=lo skbaddr=ffff88009c353100 len=60
+                wget-15108 [000] ..s1 31769.606999: netif_receive_skb: dev=lo skbaddr=ffff88009c353200 len=60
+             dnsmasq-1382  [000] ..s1 31769.677652: netif_receive_skb: dev=lo skbaddr=ffff88009c352b00 len=130
+             dnsmasq-1382  [000] ..s1 31769.685917: netif_receive_skb: dev=lo skbaddr=ffff88009c352200 len=138
+    ##### CPU 2 buffer started ####
+      irq/29-iwlwifi-559   [002] ..s. 31772.031529: netif_receive_skb: dev=wlan0 skbaddr=ffff88009d433d00 len=2948
+      irq/29-iwlwifi-559   [002] ..s. 31772.031572: netif_receive_skb: dev=wlan0 skbaddr=ffff88009d432200 len=1500
+      irq/29-iwlwifi-559   [002] ..s. 31772.032196: netif_receive_skb: dev=wlan0 skbaddr=ffff88009d433100 len=2948
+      irq/29-iwlwifi-559   [002] ..s. 31772.032761: netif_receive_skb: dev=wlan0 skbaddr=ffff88009d433000 len=2948
+      irq/29-iwlwifi-559   [002] ..s. 31772.033220: netif_receive_skb: dev=wlan0 skbaddr=ffff88009d432e00 len=1500
+    .
+    .
+    .
+
+  The following example demonstrates how multiple hist triggers can be
+  attached to a given event.  This capability can be useful for
+  creating a set of different summaries derived from the same set of
+  events, or for comparing the effects of different filters, among
+  other things.
+
+    # echo 'hist:keys=skbaddr.hex:vals=len if len < 0' >> \
+           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+    # echo 'hist:keys=skbaddr.hex:vals=len if len > 4096' >> \
+           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+    # echo 'hist:keys=skbaddr.hex:vals=len if len == 256' >> \
+           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+    # echo 'hist:keys=skbaddr.hex:vals=len' >> \
+           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+    # echo 'hist:keys=len:vals=common_preempt_count' >> \
+           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+
+  The above set of commands create four triggers differing only in
+  their filters, along with a completely different though fairly
+  nonsensical trigger.  Note that in order to append multiple hist
+  triggers to the same file, you should use the '>>' operator to
+  append them ('>' will also add the new hist trigger, but will remove
+  any existing hist triggers beforehand).
+
+  Displaying the contents of the 'hist' file for the event shows the
+  contents of all five histograms:
+
+    # cat /sys/kernel/debug/tracing/events/net/netif_receive_skb/hist
+
+    # event histogram
+    #
+    # trigger info: hist:keys=len:vals=hitcount,common_preempt_count:sort=hitcount:size=2048 [active]
+    #
+
+    { len:        176 } hitcount:          1  common_preempt_count:          0
+    { len:        223 } hitcount:          1  common_preempt_count:          0
+    { len:       4854 } hitcount:          1  common_preempt_count:          0
+    { len:        395 } hitcount:          1  common_preempt_count:          0
+    { len:        177 } hitcount:          1  common_preempt_count:          0
+    { len:        446 } hitcount:          1  common_preempt_count:          0
+    { len:       1601 } hitcount:          1  common_preempt_count:          0
+    .
+    .
+    .
+    { len:       1280 } hitcount:         66  common_preempt_count:          0
+    { len:        116 } hitcount:         81  common_preempt_count:         40
+    { len:        708 } hitcount:        112  common_preempt_count:          0
+    { len:         46 } hitcount:        221  common_preempt_count:          0
+    { len:       1264 } hitcount:        458  common_preempt_count:          0
+
+    Totals:
+        Hits: 1428
+        Entries: 147
+        Dropped: 0
+
+
+    # event histogram
+    #
+    # trigger info: hist:keys=skbaddr.hex:vals=hitcount,len:sort=hitcount:size=2048 [active]
+    #
+
+    { skbaddr: ffff8800baee5e00 } hitcount:          1  len:        130
+    { skbaddr: ffff88005f3d5600 } hitcount:          1  len:       1280
+    { skbaddr: ffff88005f3d4900 } hitcount:          1  len:       1280
+    { skbaddr: ffff88009fed6300 } hitcount:          1  len:        115
+    { skbaddr: ffff88009fe0ad00 } hitcount:          1  len:        115
+    { skbaddr: ffff88008cdb1900 } hitcount:          1  len:         46
+    { skbaddr: ffff880064b5ef00 } hitcount:          1  len:        118
+    { skbaddr: ffff880044e3c700 } hitcount:          1  len:         60
+    { skbaddr: ffff880100065900 } hitcount:          1  len:         46
+    { skbaddr: ffff8800d46bd500 } hitcount:          1  len:        116
+    { skbaddr: ffff88005f3d5f00 } hitcount:          1  len:       1280
+    { skbaddr: ffff880100064700 } hitcount:          1  len:        365
+    { skbaddr: ffff8800badb6f00 } hitcount:          1  len:         60
+    .
+    .
+    .
+    { skbaddr: ffff88009fe0be00 } hitcount:         27  len:      24677
+    { skbaddr: ffff88009fe0a400 } hitcount:         27  len:      23052
+    { skbaddr: ffff88009fe0b700 } hitcount:         31  len:      25589
+    { skbaddr: ffff88009fe0b600 } hitcount:         32  len:      27326
+    { skbaddr: ffff88006a462800 } hitcount:         68  len:      71678
+    { skbaddr: ffff88006a463700 } hitcount:         70  len:      72678
+    { skbaddr: ffff88006a462b00 } hitcount:         71  len:      77589
+    { skbaddr: ffff88006a463600 } hitcount:         73  len:      71307
+    { skbaddr: ffff88006a462200 } hitcount:         81  len:      81032
+
+    Totals:
+        Hits: 1451
+        Entries: 318
+        Dropped: 0
+
+
+    # event histogram
+    #
+    # trigger info: hist:keys=skbaddr.hex:vals=hitcount,len:sort=hitcount:size=2048 if len == 256 [active]
+    #
+
+
+    Totals:
+        Hits: 0
+        Entries: 0
+        Dropped: 0
+
+
+    # event histogram
+    #
+    # trigger info: hist:keys=skbaddr.hex:vals=hitcount,len:sort=hitcount:size=2048 if len > 4096 [active]
+    #
+
+    { skbaddr: ffff88009fd2c300 } hitcount:          1  len:       7212
+    { skbaddr: ffff8800d2bcce00 } hitcount:          1  len:       7212
+    { skbaddr: ffff8800d2bcd700 } hitcount:          1  len:       7212
+    { skbaddr: ffff8800d2bcda00 } hitcount:          1  len:      21492
+    { skbaddr: ffff8800ae2e2d00 } hitcount:          1  len:       7212
+    { skbaddr: ffff8800d2bcdb00 } hitcount:          1  len:       7212
+    { skbaddr: ffff88006a4df500 } hitcount:          1  len:       4854
+    { skbaddr: ffff88008ce47b00 } hitcount:          1  len:      18636
+    { skbaddr: ffff8800ae2e2200 } hitcount:          1  len:      12924
+    { skbaddr: ffff88005f3e1000 } hitcount:          1  len:       4356
+    { skbaddr: ffff8800d2bcdc00 } hitcount:          2  len:      24420
+    { skbaddr: ffff8800d2bcc200 } hitcount:          2  len:      12996
+
+    Totals:
+        Hits: 14
+        Entries: 12
+        Dropped: 0
+
+
+    # event histogram
+    #
+    # trigger info: hist:keys=skbaddr.hex:vals=hitcount,len:sort=hitcount:size=2048 if len < 0 [active]
+    #
+
+
+    Totals:
+        Hits: 0
+        Entries: 0
+        Dropped: 0
+
+  Named triggers can be used to have triggers share a common set of
+  histogram data.  This capability is mostly useful for combining the
+  output of events generated by tracepoints contained inside inline
+  functions, but names can be used in a hist trigger on any event.
+  For example, these two triggers when hit will update the same 'len'
+  field in the shared 'foo' histogram data:
+
+    # echo 'hist:name=foo:keys=skbaddr.hex:vals=len' > \
+           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+    # echo 'hist:name=foo:keys=skbaddr.hex:vals=len' > \
+           /sys/kernel/debug/tracing/events/net/netif_rx/trigger
+
+  You can see that they're updating common histogram data by reading
+  each event's hist files at the same time:
+
+    # cat /sys/kernel/debug/tracing/events/net/netif_receive_skb/hist;
+      cat /sys/kernel/debug/tracing/events/net/netif_rx/hist
+
+    # event histogram
+    #
+    # trigger info: hist:name=foo:keys=skbaddr.hex:vals=hitcount,len:sort=hitcount:size=2048 [active]
+    #
+
+    { skbaddr: ffff88000ad53500 } hitcount:          1  len:         46
+    { skbaddr: ffff8800af5a1500 } hitcount:          1  len:         76
+    { skbaddr: ffff8800d62a1900 } hitcount:          1  len:         46
+    { skbaddr: ffff8800d2bccb00 } hitcount:          1  len:        468
+    { skbaddr: ffff8800d3c69900 } hitcount:          1  len:         46
+    { skbaddr: ffff88009ff09100 } hitcount:          1  len:         52
+    { skbaddr: ffff88010f13ab00 } hitcount:          1  len:        168
+    { skbaddr: ffff88006a54f400 } hitcount:          1  len:         46
+    { skbaddr: ffff8800d2bcc500 } hitcount:          1  len:        260
+    { skbaddr: ffff880064505000 } hitcount:          1  len:         46
+    { skbaddr: ffff8800baf24e00 } hitcount:          1  len:         32
+    { skbaddr: ffff88009fe0ad00 } hitcount:          1  len:         46
+    { skbaddr: ffff8800d3edff00 } hitcount:          1  len:         44
+    { skbaddr: ffff88009fe0b400 } hitcount:          1  len:        168
+    { skbaddr: ffff8800a1c55a00 } hitcount:          1  len:         40
+    { skbaddr: ffff8800d2bcd100 } hitcount:          1  len:         40
+    { skbaddr: ffff880064505f00 } hitcount:          1  len:        174
+    { skbaddr: ffff8800a8bff200 } hitcount:          1  len:        160
+    { skbaddr: ffff880044e3cc00 } hitcount:          1  len:         76
+    { skbaddr: ffff8800a8bfe700 } hitcount:          1  len:         46
+    { skbaddr: ffff8800d2bcdc00 } hitcount:          1  len:         32
+    { skbaddr: ffff8800a1f64800 } hitcount:          1  len:         46
+    { skbaddr: ffff8800d2bcde00 } hitcount:          1  len:        988
+    { skbaddr: ffff88006a5dea00 } hitcount:          1  len:         46
+    { skbaddr: ffff88002e37a200 } hitcount:          1  len:         44
+    { skbaddr: ffff8800a1f32c00 } hitcount:          2  len:        676
+    { skbaddr: ffff88000ad52600 } hitcount:          2  len:        107
+    { skbaddr: ffff8800a1f91e00 } hitcount:          2  len:         92
+    { skbaddr: ffff8800af5a0200 } hitcount:          2  len:        142
+    { skbaddr: ffff8800d2bcc600 } hitcount:          2  len:        220
+    { skbaddr: ffff8800ba36f500 } hitcount:          2  len:         92
+    { skbaddr: ffff8800d021f800 } hitcount:          2  len:         92
+    { skbaddr: ffff8800a1f33600 } hitcount:          2  len:        675
+    { skbaddr: ffff8800a8bfff00 } hitcount:          3  len:        138
+    { skbaddr: ffff8800d62a1300 } hitcount:          3  len:        138
+    { skbaddr: ffff88002e37a100 } hitcount:          4  len:        184
+    { skbaddr: ffff880064504400 } hitcount:          4  len:        184
+    { skbaddr: ffff8800a8bfec00 } hitcount:          4  len:        184
+    { skbaddr: ffff88000ad53700 } hitcount:          5  len:        230
+    { skbaddr: ffff8800d2bcdb00 } hitcount:          5  len:        196
+    { skbaddr: ffff8800a1f90000 } hitcount:          6  len:        276
+    { skbaddr: ffff88006a54f900 } hitcount:          6  len:        276
+
+    Totals:
+        Hits: 81
+        Entries: 42
+        Dropped: 0
+    # event histogram
+    #
+    # trigger info: hist:name=foo:keys=skbaddr.hex:vals=hitcount,len:sort=hitcount:size=2048 [active]
+    #
+
+    { skbaddr: ffff88000ad53500 } hitcount:          1  len:         46
+    { skbaddr: ffff8800af5a1500 } hitcount:          1  len:         76
+    { skbaddr: ffff8800d62a1900 } hitcount:          1  len:         46
+    { skbaddr: ffff8800d2bccb00 } hitcount:          1  len:        468
+    { skbaddr: ffff8800d3c69900 } hitcount:          1  len:         46
+    { skbaddr: ffff88009ff09100 } hitcount:          1  len:         52
+    { skbaddr: ffff88010f13ab00 } hitcount:          1  len:        168
+    { skbaddr: ffff88006a54f400 } hitcount:          1  len:         46
+    { skbaddr: ffff8800d2bcc500 } hitcount:          1  len:        260
+    { skbaddr: ffff880064505000 } hitcount:          1  len:         46
+    { skbaddr: ffff8800baf24e00 } hitcount:          1  len:         32
+    { skbaddr: ffff88009fe0ad00 } hitcount:          1  len:         46
+    { skbaddr: ffff8800d3edff00 } hitcount:          1  len:         44
+    { skbaddr: ffff88009fe0b400 } hitcount:          1  len:        168
+    { skbaddr: ffff8800a1c55a00 } hitcount:          1  len:         40
+    { skbaddr: ffff8800d2bcd100 } hitcount:          1  len:         40
+    { skbaddr: ffff880064505f00 } hitcount:          1  len:        174
+    { skbaddr: ffff8800a8bff200 } hitcount:          1  len:        160
+    { skbaddr: ffff880044e3cc00 } hitcount:          1  len:         76
+    { skbaddr: ffff8800a8bfe700 } hitcount:          1  len:         46
+    { skbaddr: ffff8800d2bcdc00 } hitcount:          1  len:         32
+    { skbaddr: ffff8800a1f64800 } hitcount:          1  len:         46
+    { skbaddr: ffff8800d2bcde00 } hitcount:          1  len:        988
+    { skbaddr: ffff88006a5dea00 } hitcount:          1  len:         46
+    { skbaddr: ffff88002e37a200 } hitcount:          1  len:         44
+    { skbaddr: ffff8800a1f32c00 } hitcount:          2  len:        676
+    { skbaddr: ffff88000ad52600 } hitcount:          2  len:        107
+    { skbaddr: ffff8800a1f91e00 } hitcount:          2  len:         92
+    { skbaddr: ffff8800af5a0200 } hitcount:          2  len:        142
+    { skbaddr: ffff8800d2bcc600 } hitcount:          2  len:        220
+    { skbaddr: ffff8800ba36f500 } hitcount:          2  len:         92
+    { skbaddr: ffff8800d021f800 } hitcount:          2  len:         92
+    { skbaddr: ffff8800a1f33600 } hitcount:          2  len:        675
+    { skbaddr: ffff8800a8bfff00 } hitcount:          3  len:        138
+    { skbaddr: ffff8800d62a1300 } hitcount:          3  len:        138
+    { skbaddr: ffff88002e37a100 } hitcount:          4  len:        184
+    { skbaddr: ffff880064504400 } hitcount:          4  len:        184
+    { skbaddr: ffff8800a8bfec00 } hitcount:          4  len:        184
+    { skbaddr: ffff88000ad53700 } hitcount:          5  len:        230
+    { skbaddr: ffff8800d2bcdb00 } hitcount:          5  len:        196
+    { skbaddr: ffff8800a1f90000 } hitcount:          6  len:        276
+    { skbaddr: ffff88006a54f900 } hitcount:          6  len:        276
+
+    Totals:
+        Hits: 81
+        Entries: 42
+        Dropped: 0
+
+  And here's an example that shows how to combine histogram data from
+  any two events even if they don't share any 'compatible' fields
+  other than 'hitcount' and 'stacktrace'.  These commands create a
+  couple of triggers named 'bar' using those fields:
+
+    # echo 'hist:name=bar:key=stacktrace:val=hitcount' > \
+           /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
+    # echo 'hist:name=bar:key=stacktrace:val=hitcount' > \
+          /sys/kernel/debug/tracing/events/net/netif_rx/trigger
+
+  And displaying the output of either shows some interesting if
+  somewhat confusing output:
+
+    # cat /sys/kernel/debug/tracing/events/sched/sched_process_fork/hist
+    # cat /sys/kernel/debug/tracing/events/net/netif_rx/hist
+
+    # event histogram
+    #
+    # trigger info: hist:name=bar:keys=stacktrace:vals=hitcount:sort=hitcount:size=2048 [active]
+    #
+
+    { stacktrace:
+             _do_fork+0x18e/0x330
+             kernel_thread+0x29/0x30
+             kthreadd+0x154/0x1b0
+             ret_from_fork+0x3f/0x70
+    } hitcount:          1
+    { stacktrace:
+             netif_rx_internal+0xb2/0xd0
+             netif_rx_ni+0x20/0x70
+             dev_loopback_xmit+0xaa/0xd0
+             ip_mc_output+0x126/0x240
+             ip_local_out_sk+0x31/0x40
+             igmp_send_report+0x1e9/0x230
+             igmp_timer_expire+0xe9/0x120
+             call_timer_fn+0x39/0xf0
+             run_timer_softirq+0x1e1/0x290
+             __do_softirq+0xfd/0x290
+             irq_exit+0x98/0xb0
+             smp_apic_timer_interrupt+0x4a/0x60
+             apic_timer_interrupt+0x6d/0x80
+             cpuidle_enter+0x17/0x20
+             call_cpuidle+0x3b/0x60
+             cpu_startup_entry+0x22d/0x310
+    } hitcount:          1
+    { stacktrace:
+             netif_rx_internal+0xb2/0xd0
+             netif_rx_ni+0x20/0x70
+             dev_loopback_xmit+0xaa/0xd0
+             ip_mc_output+0x17f/0x240
+             ip_local_out_sk+0x31/0x40
+             ip_send_skb+0x1a/0x50
+             udp_send_skb+0x13e/0x270
+             udp_sendmsg+0x2bf/0x980
+             inet_sendmsg+0x67/0xa0
+             sock_sendmsg+0x38/0x50
+             SYSC_sendto+0xef/0x170
+             SyS_sendto+0xe/0x10
+             entry_SYSCALL_64_fastpath+0x12/0x6a
+    } hitcount:          2
+    { stacktrace:
+             netif_rx_internal+0xb2/0xd0
+             netif_rx+0x1c/0x60
+             loopback_xmit+0x6c/0xb0
+             dev_hard_start_xmit+0x219/0x3a0
+             __dev_queue_xmit+0x415/0x4f0
+             dev_queue_xmit_sk+0x13/0x20
+             ip_finish_output2+0x237/0x340
+             ip_finish_output+0x113/0x1d0
+             ip_output+0x66/0xc0
+             ip_local_out_sk+0x31/0x40
+             ip_send_skb+0x1a/0x50
+             udp_send_skb+0x16d/0x270
+             udp_sendmsg+0x2bf/0x980
+             inet_sendmsg+0x67/0xa0
+             sock_sendmsg+0x38/0x50
+             ___sys_sendmsg+0x14e/0x270
+    } hitcount:         76
+    { stacktrace:
+             netif_rx_internal+0xb2/0xd0
+             netif_rx+0x1c/0x60
+             loopback_xmit+0x6c/0xb0
+             dev_hard_start_xmit+0x219/0x3a0
+             __dev_queue_xmit+0x415/0x4f0
+             dev_queue_xmit_sk+0x13/0x20
+             ip_finish_output2+0x237/0x340
+             ip_finish_output+0x113/0x1d0
+             ip_output+0x66/0xc0
+             ip_local_out_sk+0x31/0x40
+             ip_send_skb+0x1a/0x50
+             udp_send_skb+0x16d/0x270
+             udp_sendmsg+0x2bf/0x980
+             inet_sendmsg+0x67/0xa0
+             sock_sendmsg+0x38/0x50
+             ___sys_sendmsg+0x269/0x270
+    } hitcount:         77
+    { stacktrace:
+             netif_rx_internal+0xb2/0xd0
+             netif_rx+0x1c/0x60
+             loopback_xmit+0x6c/0xb0
+             dev_hard_start_xmit+0x219/0x3a0
+             __dev_queue_xmit+0x415/0x4f0
+             dev_queue_xmit_sk+0x13/0x20
+             ip_finish_output2+0x237/0x340
+             ip_finish_output+0x113/0x1d0
+             ip_output+0x66/0xc0
+             ip_local_out_sk+0x31/0x40
+             ip_send_skb+0x1a/0x50
+             udp_send_skb+0x16d/0x270
+             udp_sendmsg+0x2bf/0x980
+             inet_sendmsg+0x67/0xa0
+             sock_sendmsg+0x38/0x50
+             SYSC_sendto+0xef/0x170
+    } hitcount:         88
+    { stacktrace:
+             _do_fork+0x18e/0x330
+             SyS_clone+0x19/0x20
+             entry_SYSCALL_64_fastpath+0x12/0x6a
+    } hitcount:        244
+
+    Totals:
+        Hits: 489
+        Entries: 7
+        Dropped: 0
+
+
+2.2 Inter-event hist triggers
+-----------------------------
+
+Inter-event hist triggers are hist triggers that combine values from
+one or more other events and create a histogram using that data.  Data
+from an inter-event histogram can in turn become the source for
+further combined histograms, thus providing a chain of related
+histograms, which is important for some applications.
+
+The most important example of an inter-event quantity that can be used
+in this manner is latency, which is simply a difference in timestamps
+between two events.  Although latency is the most important
+inter-event quantity, note that because the support is completely
+general across the trace event subsystem, any event field can be used
+in an inter-event quantity.
+
+An example of a histogram that combines data from other histograms
+into a useful chain would be a 'wakeupswitch latency' histogram that
+combines a 'wakeup latency' histogram and a 'switch latency'
+histogram.
+
+Normally, a hist trigger specification consists of a (possibly
+compound) key along with one or more numeric values, which are
+continually updated sums associated with that key.  A histogram
+specification in this case consists of individual key and value
+specifications that refer to trace event fields associated with a
+single event type.
+
+The inter-event hist trigger extension allows fields from multiple
+events to be referenced and combined into a multi-event histogram
+specification.  In support of this overall goal, a few enabling
+features have been added to the hist trigger support:
+
+  - In order to compute an inter-event quantity, a value from one
+    event needs to saved and then referenced from another event.  This
+    requires the introduction of support for histogram 'variables'.
+
+  - The computation of inter-event quantities and their combination
+    require some minimal amount of support for applying simple
+    expressions to variables (+ and -).
+
+  - A histogram consisting of inter-event quantities isn't logically a
+    histogram on either event (so having the 'hist' file for either
+    event host the histogram output doesn't really make sense).  To
+    address the idea that the histogram is associated with a
+    combination of events, support is added allowing the creation of
+    'synthetic' events that are events derived from other events.
+    These synthetic events are full-fledged events just like any other
+    and can be used as such, as for instance to create the
+    'combination' histograms mentioned previously.
+
+  - A set of 'actions' can be associated with histogram entries -
+    these can be used to generate the previously mentioned synthetic
+    events, but can also be used for other purposes, such as for
+    example saving context when a 'max' latency has been hit.
+
+  - Trace events don't have a 'timestamp' associated with them, but
+    there is an implicit timestamp saved along with an event in the
+    underlying ftrace ring buffer.  This timestamp is now exposed as a
+    a synthetic field named 'common_timestamp' which can be used in
+    histograms as if it were any other event field; it isn't an actual
+    field in the trace format but rather is a synthesized value that
+    nonetheless can be used as if it were an actual field.  By default
+    it is in units of nanoseconds; appending '.usecs' to a
+    common_timestamp field changes the units to microseconds.
+
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
+
+2.2.1 Histogram Variables
+-------------------------
+
+Variables are simply named locations used for saving and retrieving
+values between matching events.  A 'matching' event is defined as an
+event that has a matching key - if a variable is saved for a histogram
+entry corresponding to that key, any subsequent event with a matching
+key can access that variable.
+
+A variable's value is normally available to any subsequent event until
+it is set to something else by a subsequent event.  The one exception
+to that rule is that any variable used in an expression is essentially
+'read-once' - once it's used by an expression in a subsequent event,
+it's reset to its 'unset' state, which means it can't be used again
+unless it's set again.  This ensures not only that an event doesn't
+use an uninitialized variable in a calculation, but that that variable
+is used only once and not for any unrelated subsequent match.
+
+The basic syntax for saving a variable is to simply prefix a unique
+variable name not corresponding to any keyword along with an '=' sign
+to any event field.
+
+Either keys or values can be saved and retrieved in this way.  This
+creates a variable named 'ts0' for a histogram entry with the key
+'next_pid':
+
+  # echo 'hist:keys=next_pid:vals=$ts0:ts0=common_timestamp ... >> \
+	event/trigger
+
+The ts0 variable can be accessed by any subsequent event having the
+same pid as 'next_pid'.
+
+Variable references are formed by prepending the variable name with
+the '$' sign.  Thus for example, the ts0 variable above would be
+referenced as '$ts0' in expressions.
+
+Because 'vals=' is used, the common_timestamp variable value above
+will also be summed as a normal histogram value would (though for a
+timestamp it makes little sense).
+
+The below shows that a key value can also be saved in the same way:
+
+  # echo 'hist:timer_pid=common_pid:key=timer_pid ...' >> event/trigger
+
+If a variable isn't a key variable or prefixed with 'vals=', the
+associated event field will be saved in a variable but won't be summed
+as a value:
+
+  # echo 'hist:keys=next_pid:ts1=common_timestamp ... >> event/trigger
+
+Multiple variables can be assigned at the same time.  The below would
+result in both ts0 and b being created as variables, with both
+common_timestamp and field1 additionally being summed as values:
+
+  # echo 'hist:keys=pid:vals=$ts0,$b:ts0=common_timestamp,b=field1 ... >> \
+	event/trigger
+
+Note that variable assignments can appear either preceding or
+following their use.  The command below behaves identically to the
+command above:
+
+  # echo 'hist:keys=pid:ts0=common_timestamp,b=field1:vals=$ts0,$b ... >> \
+	event/trigger
+
+Any number of variables not bound to a 'vals=' prefix can also be
+assigned by simply separating them with colons.  Below is the same
+thing but without the values being summed in the histogram:
+
+  # echo 'hist:keys=pid:ts0=common_timestamp:b=field1 ... >> event/trigger
+
+Variables set as above can be referenced and used in expressions on
+another event.
+
+For example, here's how a latency can be calculated:
+
+  # echo 'hist:keys=pid,prio:ts0=common_timestamp ... >> event1/trigger
+  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp-$ts0 ... >> event2/trigger
+
+In the first line above, the event's timetamp is saved into the
+variable ts0.  In the next line, ts0 is subtracted from the second
+event's timestamp to produce the latency, which is then assigned into
+yet another variable, 'wakeup_lat'.  The hist trigger below in turn
+makes use of the wakeup_lat variable to compute a combined latency
+using the same key and variable from yet another event:
+
+  # echo 'hist:key=pid:wakeupswitch_lat=$wakeup_lat+$switchtime_lat ... >> event3/trigger
+
+2.2.2 Synthetic Events
+----------------------
+
+Synthetic events are user-defined events generated from hist trigger
+variables or fields associated with one or more other events.  Their
+purpose is to provide a mechanism for displaying data spanning
+multiple events consistent with the existing and already familiar
+usage for normal events.
+
+To define a synthetic event, the user writes a simple specification
+consisting of the name of the new event along with one or more
+variables and their types, which can be any valid field type,
+separated by semicolons, to the tracing/synthetic_events file.
+
+For instance, the following creates a new event named 'wakeup_latency'
+with 3 fields: lat, pid, and prio.  Each of those fields is simply a
+variable reference to a variable on another event:
+
+  # echo 'wakeup_latency \
+          u64 lat; \
+          pid_t pid; \
+	  int prio' >> \
+	  /sys/kernel/debug/tracing/synthetic_events
+
+Reading the tracing/synthetic_events file lists all the currently
+defined synthetic events, in this case the event defined above:
+
+  # cat /sys/kernel/debug/tracing/synthetic_events
+    wakeup_latency u64 lat; pid_t pid; int prio
+
+An existing synthetic event definition can be removed by prepending
+the command that defined it with a '!':
+
+  # echo '!wakeup_latency u64 lat pid_t pid int prio' >> \
+    /sys/kernel/debug/tracing/synthetic_events
+
+At this point, there isn't yet an actual 'wakeup_latency' event
+instantiated in the event subsytem - for this to happen, a 'hist
+trigger action' needs to be instantiated and bound to actual fields
+and variables defined on other events (see Section 6.3.3 below).
+
+Once that is done, an event instance is created, and a histogram can
+be defined using it:
+
+  # echo 'hist:keys=pid,prio,lat.log2:sort=pid,lat' >> \
+        /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
+
+The new event is created under the tracing/events/synthetic/ directory
+and looks and behaves just like any other event:
+
+  # ls /sys/kernel/debug/tracing/events/synthetic/wakeup_latency
+        enable  filter  format  hist  id  trigger
+
+Like any other event, once a histogram is enabled for the event, the
+output can be displayed by reading the event's 'hist' file.
+
+2.2.3 Hist trigger 'actions'
+----------------------------
+
+A hist trigger 'action' is a function that's executed whenever a
+histogram entry is added or updated.
+
+The default 'action' if no special function is explicity specified is
+as it always has been, to simply update the set of values associated
+with an entry.  Some applications, however, may want to perform
+additional actions at that point, such as generate another event, or
+compare and save a maximum.
+
+The following additional actions are available.  To specify an action
+for a given event, simply specify the action between colons in the
+hist trigger specification.
+
+  - onmatch(matching.event).<synthetic_event_name>(param list)
+
+    The 'onmatch(matching.event).<synthetic_event_name>(params)' hist
+    trigger action is invoked whenever an event matches and the
+    histogram entry would be added or updated.  It causes the named
+    synthetic event to be generated with the values given in the
+    'param list'.  The result is the generation of a synthetic event
+    that consists of the values contained in those variables at the
+    time the invoking event was hit.
+
+    The 'param list' consists of one or more parameters which may be
+    either variables or fields defined on either the 'matching.event'
+    or the target event.  The variables or fields specified in the
+    param list may be either fully-qualified or unqualified.  If a
+    variable is specified as unqualified, it must be unique between
+    the two events.  A field name used as a param can be unqualified
+    if it refers to the target event, but must be fully qualified if
+    it refers to the matching event.  A fully-qualified name is of the
+    form 'system.event_name.$var_name' or 'system.event_name.field'.
+
+    The 'matching.event' specification is simply the fully qualified
+    event name of the event that matches the target event for the
+    onmatch() functionality, in the form 'system.event_name'.
+
+    Finally, the number and type of variables/fields in the 'param
+    list' must match the number and types of the fields in the
+    synthetic event being generated.
+
+    As an example the below defines a simple synthetic event and uses
+    a variable defined on the sched_wakeup_new event as a parameter
+    when invoking the synthetic event.  Here we define the synthetic
+    event:
+
+    # echo 'wakeup_new_test pid_t pid' >> \
+           /sys/kernel/debug/tracing/synthetic_events
+
+    # cat /sys/kernel/debug/tracing/synthetic_events
+          wakeup_new_test pid_t pid
+
+    The following hist trigger both defines the missing testpid
+    variable and specifies an onmatch() action that generates a
+    wakeup_new_test synthetic event whenever a sched_wakeup_new event
+    occurs, which because of the 'if comm == "cyclictest"' filter only
+    happens when the executable is cyclictest:
+
+    # echo 'hist:keys=$testpid:testpid=pid:onmatch(sched.sched_wakeup_new).\
+            wakeup_new_test($testpid) if comm=="cyclictest"' >> \
+            /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
+
+    Creating and displaying a histogram based on those events is now
+    just a matter of using the fields and new synthetic event in the
+    tracing/events/synthetic directory, as usual:
+
+    # echo 'hist:keys=pid:sort=pid' >> \
+           /sys/kernel/debug/tracing/events/synthetic/wakeup_new_test/trigger
+
+    Running 'cyclictest' should cause wakeup_new events to generate
+    wakeup_new_test synthetic events which should result in histogram
+    output in the wakeup_new_test event's hist file:
+
+    # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_new_test/hist
+
+    A more typical usage would be to use two events to calculate a
+    latency.  The following example uses a set of hist triggers to
+    produce a 'wakeup_latency' histogram:
+
+    First, we define a 'wakeup_latency' synthetic event:
+
+    # echo 'wakeup_latency u64 lat; pid_t pid; int prio' >> \
+            /sys/kernel/debug/tracing/synthetic_events
+
+    Next, we specify that whenever we see a sched_waking event for a
+    cyclictest thread, save the timestamp in a 'ts0' variable:
+
+    # echo 'hist:keys=$saved_pid:saved_pid=pid:ts0=common_timestamp.usecs \
+            if comm=="cyclictest"' >> \
+	    /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
+
+    Then, when the corresponding thread is actually scheduled onto the
+    CPU by a sched_switch event, calculate the latency and use that
+    along with another variable and an event field to generate a
+    wakeup_latency synthetic event:
+
+    # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:\
+            onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,\
+	            $saved_pid,next_prio) if next_comm=="cyclictest"' >> \
+	    /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+
+    We also need to create a histogram on the wakeup_latency synthetic
+    event in order to aggregate the generated synthetic event data:
+
+    # echo 'hist:keys=pid,prio,lat:sort=pid,lat' >> \
+            /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
+
+    Finally, once we've run cyclictest to actually generate some
+    events, we can see the output by looking at the wakeup_latency
+    synthetic event's hist file:
+
+    # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist
+
+  - onmax(var).save(field,..	.)
+
+    The 'onmax(var).save(field,...)' hist trigger action is invoked
+    whenever the value of 'var' associated with a histogram entry
+    exceeds the current maximum contained in that variable.
+
+    The end result is that the trace event fields specified as the
+    onmax.save() params will be saved if 'var' exceeds the current
+    maximum for that hist trigger entry.  This allows context from the
+    event that exhibited the new maximum to be saved for later
+    reference.  When the histogram is displayed, additional fields
+    displaying the saved values will be printed.
+
+    As an example the below defines a couple of hist triggers, one for
+    sched_waking and another for sched_switch, keyed on pid.  Whenever
+    a sched_waking occurs, the timestamp is saved in the entry
+    corresponding to the current pid, and when the scheduler switches
+    back to that pid, the timestamp difference is calculated.  If the
+    resulting latency, stored in wakeup_lat, exceeds the current
+    maximum latency, the values specified in the save() fields are
+    recoreded:
+
+    # echo 'hist:keys=pid:ts0=common_timestamp.usecs \
+            if comm=="cyclictest"' >> \
+            /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
+
+    # echo 'hist:keys=next_pid:\
+            wakeup_lat=common_timestamp.usecs-$ts0:\
+            onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm) \
+            if next_comm=="cyclictest"' >> \
+            /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+
+    When the histogram is displayed, the max value and the saved
+    values corresponding to the max are displayed following the rest
+    of the fields:
+
+    # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
+      { next_pid:       2255 } hitcount:        239
+        common_timestamp-ts0:          0
+        max:         27
+	next_comm: cyclictest
+        prev_pid:          0  prev_prio:        120  prev_comm: swapper/1
+
+      { next_pid:       2256 } hitcount:       2355
+        common_timestamp-ts0: 0
+        max:         49  next_comm: cyclictest
+        prev_pid:          0  prev_prio:        120  prev_comm: swapper/0
+
+      Totals:
+          Hits: 12970
+          Entries: 2
+          Dropped: 0
diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 7d9eb39fa76a..a0233edc0718 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -34,10 +34,12 @@ struct ring_buffer_event {
  *				 array[0] = time delta (28 .. 59)
  *				 size = 8 bytes
  *
- * @RINGBUF_TYPE_TIME_STAMP:	Sync time stamp with external clock
- *				 array[0]    = tv_nsec
- *				 array[1..2] = tv_sec
- *				 size = 16 bytes
+ * @RINGBUF_TYPE_TIME_STAMP:	Absolute timestamp
+ *				 Same format as TIME_EXTEND except that the
+ *				 value is an absolute timestamp, not a delta
+ *				 event.time_delta contains bottom 27 bits
+ *				 array[0] = top (28 .. 59) bits
+ *				 size = 8 bytes
  *
  * <= @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
  *				Data record
@@ -54,12 +56,12 @@ enum ring_buffer_type {
 	RINGBUF_TYPE_DATA_TYPE_LEN_MAX = 28,
 	RINGBUF_TYPE_PADDING,
 	RINGBUF_TYPE_TIME_EXTEND,
-	/* FIXME: RINGBUF_TYPE_TIME_STAMP not implemented */
 	RINGBUF_TYPE_TIME_STAMP,
 };
 
 unsigned ring_buffer_event_length(struct ring_buffer_event *event);
 void *ring_buffer_event_data(struct ring_buffer_event *event);
+u64 ring_buffer_event_time_stamp(struct ring_buffer_event *event);
 
 /*
  * ring_buffer_discard_commit will remove an event that has not
@@ -115,6 +117,9 @@ int ring_buffer_unlock_commit(struct ring_buffer *buffer,
 int ring_buffer_write(struct ring_buffer *buffer,
 		      unsigned long length, void *data);
 
+void ring_buffer_nest_start(struct ring_buffer *buffer);
+void ring_buffer_nest_end(struct ring_buffer *buffer);
+
 struct ring_buffer_event *
 ring_buffer_peek(struct ring_buffer *buffer, int cpu, u64 *ts,
 		 unsigned long *lost_events);
@@ -178,6 +183,8 @@ void ring_buffer_normalize_time_stamp(struct ring_buffer *buffer,
 				      int cpu, u64 *ts);
 void ring_buffer_set_clock(struct ring_buffer *buffer,
 			   u64 (*clock)(void));
+void ring_buffer_set_time_stamp_abs(struct ring_buffer *buffer, bool abs);
+bool ring_buffer_time_stamp_abs(struct ring_buffer *buffer);
 
 size_t ring_buffer_page_len(void *page);
 
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 8a1442c4e513..0cf48c61cc6d 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -430,11 +430,13 @@ enum event_trigger_type {
 
 extern int filter_match_preds(struct event_filter *filter, void *rec);
 
-extern enum event_trigger_type event_triggers_call(struct trace_event_file *file,
-						   void *rec);
-extern void event_triggers_post_call(struct trace_event_file *file,
-				     enum event_trigger_type tt,
-				     void *rec);
+extern enum event_trigger_type
+event_triggers_call(struct trace_event_file *file, void *rec,
+		    struct ring_buffer_event *event);
+extern void
+event_triggers_post_call(struct trace_event_file *file,
+			 enum event_trigger_type tt,
+			 void *rec, struct ring_buffer_event *event);
 
 bool trace_event_ignore_this_pid(struct trace_event_file *trace_file);
 
@@ -454,7 +456,7 @@ trace_trigger_soft_disabled(struct trace_event_file *file)
 
 	if (!(eflags & EVENT_FILE_FL_TRIGGER_COND)) {
 		if (eflags & EVENT_FILE_FL_TRIGGER_MODE)
-			event_triggers_call(file, NULL);
+			event_triggers_call(file, NULL, NULL);
 		if (eflags & EVENT_FILE_FL_SOFT_DISABLED)
 			return true;
 		if (eflags & EVENT_FILE_FL_PID_FILTER)
diff --git a/include/trace/events/initcall.h b/include/trace/events/initcall.h
new file mode 100644
index 000000000000..8d6cf10d27c9
--- /dev/null
+++ b/include/trace/events/initcall.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM initcall
+
+#if !defined(_TRACE_INITCALL_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_INITCALL_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(initcall_level,
+
+	TP_PROTO(const char *level),
+
+	TP_ARGS(level),
+
+	TP_STRUCT__entry(
+		__string(level, level)
+	),
+
+	TP_fast_assign(
+		__assign_str(level, level);
+	),
+
+	TP_printk("level=%s", __get_str(level))
+);
+
+TRACE_EVENT(initcall_start,
+
+	TP_PROTO(initcall_t func),
+
+	TP_ARGS(func),
+
+	TP_STRUCT__entry(
+		__field(initcall_t, func)
+	),
+
+	TP_fast_assign(
+		__entry->func = func;
+	),
+
+	TP_printk("func=%pS", __entry->func)
+);
+
+TRACE_EVENT(initcall_finish,
+
+	TP_PROTO(initcall_t func, int ret),
+
+	TP_ARGS(func, ret),
+
+	TP_STRUCT__entry(
+		__field(initcall_t,	func)
+		__field(int,		ret)
+	),
+
+	TP_fast_assign(
+		__entry->func = func;
+		__entry->ret = ret;
+	),
+
+	TP_printk("func=%pS ret=%d", __entry->func, __entry->ret)
+);
+
+#endif /* if !defined(_TRACE_GPIO_H) || defined(TRACE_HEADER_MULTI_READ) */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/init/main.c b/init/main.c
index 969eaf140ef0..6f6e6fc6f4b9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -97,6 +97,9 @@
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/initcall.h>
+
 static int kernel_init(void *);
 
 extern void init_IRQ(void);
@@ -491,6 +494,17 @@ void __init __weak thread_stack_cache_init(void)
 
 void __init __weak mem_encrypt_init(void) { }
 
+bool initcall_debug;
+core_param(initcall_debug, initcall_debug, bool, 0644);
+
+#ifdef TRACEPOINTS_ENABLED
+static void __init initcall_debug_enable(void);
+#else
+static inline void initcall_debug_enable(void)
+{
+}
+#endif
+
 /*
  * Set up kernel memory allocators
  */
@@ -612,6 +626,9 @@ asmlinkage __visible void __init start_kernel(void)
 	/* Trace events are available after this */
 	trace_init();
 
+	if (initcall_debug)
+		initcall_debug_enable();
+
 	context_tracking_init();
 	/* init some links before init_ISA_irqs() */
 	early_irq_init();
@@ -728,9 +745,6 @@ static void __init do_ctors(void)
 #endif
 }
 
-bool initcall_debug;
-core_param(initcall_debug, initcall_debug, bool, 0644);
-
 #ifdef CONFIG_KALLSYMS
 struct blacklist_entry {
 	struct list_head next;
@@ -800,37 +814,71 @@ static bool __init_or_module initcall_blacklisted(initcall_t fn)
 #endif
 __setup("initcall_blacklist=", initcall_blacklist);
 
-static int __init_or_module do_one_initcall_debug(initcall_t fn)
+static __init_or_module void
+trace_initcall_start_cb(void *data, initcall_t fn)
 {
-	ktime_t calltime, delta, rettime;
-	unsigned long long duration;
-	int ret;
+	ktime_t *calltime = (ktime_t *)data;
 
 	printk(KERN_DEBUG "calling  %pF @ %i\n", fn, task_pid_nr(current));
-	calltime = ktime_get();
-	ret = fn();
+	*calltime = ktime_get();
+}
+
+static __init_or_module void
+trace_initcall_finish_cb(void *data, initcall_t fn, int ret)
+{
+	ktime_t *calltime = (ktime_t *)data;
+	ktime_t delta, rettime;
+	unsigned long long duration;
+
 	rettime = ktime_get();
-	delta = ktime_sub(rettime, calltime);
+	delta = ktime_sub(rettime, *calltime);
 	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
 	printk(KERN_DEBUG "initcall %pF returned %d after %lld usecs\n",
 		 fn, ret, duration);
+}
 
-	return ret;
+static ktime_t initcall_calltime;
+
+#ifdef TRACEPOINTS_ENABLED
+static void __init initcall_debug_enable(void)
+{
+	int ret;
+
+	ret = register_trace_initcall_start(trace_initcall_start_cb,
+					    &initcall_calltime);
+	ret |= register_trace_initcall_finish(trace_initcall_finish_cb,
+					      &initcall_calltime);
+	WARN(ret, "Failed to register initcall tracepoints\n");
 }
+# define do_trace_initcall_start	trace_initcall_start
+# define do_trace_initcall_finish	trace_initcall_finish
+#else
+static inline void do_trace_initcall_start(initcall_t fn)
+{
+	if (!initcall_debug)
+		return;
+	trace_initcall_start_cb(&initcall_calltime, fn);
+}
+static inline void do_trace_initcall_finish(initcall_t fn, int ret)
+{
+	if (!initcall_debug)
+		return;
+	trace_initcall_finish_cb(&initcall_calltime, fn, ret);
+}
+#endif /* !TRACEPOINTS_ENABLED */
 
 int __init_or_module do_one_initcall(initcall_t fn)
 {
 	int count = preempt_count();
-	int ret;
 	char msgbuf[64];
+	int ret;
 
 	if (initcall_blacklisted(fn))
 		return -EPERM;
 
-	if (initcall_debug)
-		ret = do_one_initcall_debug(fn);
-	else
-		ret = fn();
+	do_trace_initcall_start(fn);
+	ret = fn();
+	do_trace_initcall_finish(fn, ret);
 
 	msgbuf[0] = 0;
 
@@ -874,7 +922,7 @@ static initcall_t *initcall_levels[] __initdata = {
 
 /* Keep these in sync with initcalls in include/linux/init.h */
 static char *initcall_level_names[] __initdata = {
-	"early",
+	"pure",
 	"core",
 	"postcore",
 	"arch",
@@ -895,6 +943,7 @@ static void __init do_initcall_level(int level)
 		   level, level,
 		   NULL, &repair_env_string);
 
+	trace_initcall_level(initcall_level_names[level]);
 	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
 		do_one_initcall(*fn);
 }
@@ -929,6 +978,7 @@ static void __init do_pre_smp_initcalls(void)
 {
 	initcall_t *fn;
 
+	trace_initcall_level("early");
 	for (fn = __initcall_start; fn < __initcall0_start; fn++)
 		do_one_initcall(*fn);
 }
diff --git a/kernel/panic.c b/kernel/panic.c
index 2cfef408fec9..fa8d4cc4956a 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -554,6 +554,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 	else
 		dump_stack();
 
+	print_irqtrace_events(current);
+
 	print_oops_end_marker();
 
 	/* Just a warning, don't kill lockdep. */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f274fbef821d..cb5b35341d69 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -52,6 +52,7 @@
 #include <linux/uaccess.h>
 #include <asm/sections.h>
 
+#include <trace/events/initcall.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/printk.h>
 
@@ -2781,6 +2782,7 @@ EXPORT_SYMBOL(unregister_console);
  */
 void __init console_init(void)
 {
+	int ret;
 	initcall_t *call;
 
 	/* Setup the default TTY line discipline. */
@@ -2791,8 +2793,11 @@ void __init console_init(void)
 	 * inform about problems etc..
 	 */
 	call = __con_initcall_start;
+	trace_initcall_level("console");
 	while (call < __con_initcall_end) {
-		(*call)();
+		trace_initcall_start((*call));
+		ret = (*call)();
+		trace_initcall_finish((*call), ret);
 		call++;
 	}
 }
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 0b249e2f0c3c..c4f0f2e4126e 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -606,7 +606,10 @@ config HIST_TRIGGERS
 	  event activity as an initial guide for further investigation
 	  using more advanced tools.
 
-	  See Documentation/trace/events.txt.
+	  Inter-event tracing of quantities such as latencies is also
+	  supported using hist triggers under this option.
+
+	  See Documentation/trace/histogram.txt.
 	  If in doubt, say N.
 
 config MMIOTRACE_TEST
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index eac9ce2c57a2..16bbf062018f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3902,14 +3902,13 @@ static bool module_exists(const char *module)
 {
 	/* All modules have the symbol __this_module */
 	const char this_mod[] = "__this_module";
-	const int modname_size = MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 1;
-	char modname[modname_size + 1];
+	char modname[MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 2];
 	unsigned long val;
 	int n;
 
-	n = snprintf(modname, modname_size + 1, "%s:%s", module, this_mod);
+	n = snprintf(modname, sizeof(modname), "%s:%s", module, this_mod);
 
-	if (n > modname_size)
+	if (n > sizeof(modname) - 1)
 		return false;
 
 	val = module_kallsyms_lookup_name(modname);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index dcf1c4dd3efe..c9cb9767d49b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -22,6 +22,7 @@
 #include <linux/hash.h>
 #include <linux/list.h>
 #include <linux/cpu.h>
+#include <linux/oom.h>
 
 #include <asm/local.h>
 
@@ -41,6 +42,8 @@ int ring_buffer_print_entry_header(struct trace_seq *s)
 			 RINGBUF_TYPE_PADDING);
 	trace_seq_printf(s, "\ttime_extend : type == %d\n",
 			 RINGBUF_TYPE_TIME_EXTEND);
+	trace_seq_printf(s, "\ttime_stamp : type == %d\n",
+			 RINGBUF_TYPE_TIME_STAMP);
 	trace_seq_printf(s, "\tdata max type_len  == %d\n",
 			 RINGBUF_TYPE_DATA_TYPE_LEN_MAX);
 
@@ -140,12 +143,15 @@ int ring_buffer_print_entry_header(struct trace_seq *s)
 
 enum {
 	RB_LEN_TIME_EXTEND = 8,
-	RB_LEN_TIME_STAMP = 16,
+	RB_LEN_TIME_STAMP =  8,
 };
 
 #define skip_time_extend(event) \
 	((struct ring_buffer_event *)((char *)event + RB_LEN_TIME_EXTEND))
 
+#define extended_time(event) \
+	(event->type_len >= RINGBUF_TYPE_TIME_EXTEND)
+
 static inline int rb_null_event(struct ring_buffer_event *event)
 {
 	return event->type_len == RINGBUF_TYPE_PADDING && !event->time_delta;
@@ -209,7 +215,7 @@ rb_event_ts_length(struct ring_buffer_event *event)
 {
 	unsigned len = 0;
 
-	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND) {
+	if (extended_time(event)) {
 		/* time extends include the data event after it */
 		len = RB_LEN_TIME_EXTEND;
 		event = skip_time_extend(event);
@@ -231,7 +237,7 @@ unsigned ring_buffer_event_length(struct ring_buffer_event *event)
 {
 	unsigned length;
 
-	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND)
+	if (extended_time(event))
 		event = skip_time_extend(event);
 
 	length = rb_event_length(event);
@@ -248,7 +254,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_event_length);
 static __always_inline void *
 rb_event_data(struct ring_buffer_event *event)
 {
-	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND)
+	if (extended_time(event))
 		event = skip_time_extend(event);
 	BUG_ON(event->type_len > RINGBUF_TYPE_DATA_TYPE_LEN_MAX);
 	/* If length is in len field, then array[0] has the data */
@@ -275,6 +281,27 @@ EXPORT_SYMBOL_GPL(ring_buffer_event_data);
 #define TS_MASK		((1ULL << TS_SHIFT) - 1)
 #define TS_DELTA_TEST	(~TS_MASK)
 
+/**
+ * ring_buffer_event_time_stamp - return the event's extended timestamp
+ * @event: the event to get the timestamp of
+ *
+ * Returns the extended timestamp associated with a data event.
+ * An extended time_stamp is a 64-bit timestamp represented
+ * internally in a special way that makes the best use of space
+ * contained within a ring buffer event.  This function decodes
+ * it and maps it to a straight u64 value.
+ */
+u64 ring_buffer_event_time_stamp(struct ring_buffer_event *event)
+{
+	u64 ts;
+
+	ts = event->array[0];
+	ts <<= TS_SHIFT;
+	ts += event->time_delta;
+
+	return ts;
+}
+
 /* Flag when events were overwritten */
 #define RB_MISSED_EVENTS	(1 << 31)
 /* Missed count stored at end */
@@ -451,6 +478,7 @@ struct ring_buffer_per_cpu {
 	struct buffer_page		*reader_page;
 	unsigned long			lost_events;
 	unsigned long			last_overrun;
+	unsigned long			nest;
 	local_t				entries_bytes;
 	local_t				entries;
 	local_t				overrun;
@@ -488,6 +516,7 @@ struct ring_buffer {
 	u64				(*clock)(void);
 
 	struct rb_irq_work		irq_work;
+	bool				time_stamp_abs;
 };
 
 struct ring_buffer_iter {
@@ -1134,30 +1163,60 @@ static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
 {
 	struct buffer_page *bpage, *tmp;
+	bool user_thread = current->mm != NULL;
+	gfp_t mflags;
 	long i;
 
+	/*
+	 * Check if the available memory is there first.
+	 * Note, si_mem_available() only gives us a rough estimate of available
+	 * memory. It may not be accurate. But we don't care, we just want
+	 * to prevent doing any allocation when it is obvious that it is
+	 * not going to succeed.
+	 */
+	i = si_mem_available();
+	if (i < nr_pages)
+		return -ENOMEM;
+
+	/*
+	 * __GFP_RETRY_MAYFAIL flag makes sure that the allocation fails
+	 * gracefully without invoking oom-killer and the system is not
+	 * destabilized.
+	 */
+	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL;
+
+	/*
+	 * If a user thread allocates too much, and si_mem_available()
+	 * reports there's enough memory, even though there is not.
+	 * Make sure the OOM killer kills this thread. This can happen
+	 * even with RETRY_MAYFAIL because another task may be doing
+	 * an allocation after this task has taken all memory.
+	 * This is the task the OOM killer needs to take out during this
+	 * loop, even if it was triggered by an allocation somewhere else.
+	 */
+	if (user_thread)
+		set_current_oom_origin();
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page;
-		/*
-		 * __GFP_RETRY_MAYFAIL flag makes sure that the allocation fails
-		 * gracefully without invoking oom-killer and the system is not
-		 * destabilized.
-		 */
+
 		bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
-				    GFP_KERNEL | __GFP_RETRY_MAYFAIL,
-				    cpu_to_node(cpu));
+				    mflags, cpu_to_node(cpu));
 		if (!bpage)
 			goto free_pages;
 
 		list_add(&bpage->list, pages);
 
-		page = alloc_pages_node(cpu_to_node(cpu),
-					GFP_KERNEL | __GFP_RETRY_MAYFAIL, 0);
+		page = alloc_pages_node(cpu_to_node(cpu), mflags, 0);
 		if (!page)
 			goto free_pages;
 		bpage->page = page_address(page);
 		rb_init_page(bpage->page);
+
+		if (user_thread && fatal_signal_pending(current))
+			goto free_pages;
 	}
+	if (user_thread)
+		clear_current_oom_origin();
 
 	return 0;
 
@@ -1166,6 +1225,8 @@ static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
 		list_del_init(&bpage->list);
 		free_buffer_page(bpage);
 	}
+	if (user_thread)
+		clear_current_oom_origin();
 
 	return -ENOMEM;
 }
@@ -1382,6 +1443,16 @@ void ring_buffer_set_clock(struct ring_buffer *buffer,
 	buffer->clock = clock;
 }
 
+void ring_buffer_set_time_stamp_abs(struct ring_buffer *buffer, bool abs)
+{
+	buffer->time_stamp_abs = abs;
+}
+
+bool ring_buffer_time_stamp_abs(struct ring_buffer *buffer)
+{
+	return buffer->time_stamp_abs;
+}
+
 static void rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer);
 
 static inline unsigned long rb_page_entries(struct buffer_page *bpage)
@@ -2206,12 +2277,15 @@ rb_move_tail(struct ring_buffer_per_cpu *cpu_buffer,
 
 /* Slow path, do not inline */
 static noinline struct ring_buffer_event *
-rb_add_time_stamp(struct ring_buffer_event *event, u64 delta)
+rb_add_time_stamp(struct ring_buffer_event *event, u64 delta, bool abs)
 {
-	event->type_len = RINGBUF_TYPE_TIME_EXTEND;
+	if (abs)
+		event->type_len = RINGBUF_TYPE_TIME_STAMP;
+	else
+		event->type_len = RINGBUF_TYPE_TIME_EXTEND;
 
-	/* Not the first event on the page? */
-	if (rb_event_index(event)) {
+	/* Not the first event on the page, or not delta? */
+	if (abs || rb_event_index(event)) {
 		event->time_delta = delta & TS_MASK;
 		event->array[0] = delta >> TS_SHIFT;
 	} else {
@@ -2254,7 +2328,9 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 	 * add it to the start of the resevered space.
 	 */
 	if (unlikely(info->add_timestamp)) {
-		event = rb_add_time_stamp(event, delta);
+		bool abs = ring_buffer_time_stamp_abs(cpu_buffer->buffer);
+
+		event = rb_add_time_stamp(event, info->delta, abs);
 		length -= RB_LEN_TIME_EXTEND;
 		delta = 0;
 	}
@@ -2442,7 +2518,7 @@ static __always_inline void rb_end_commit(struct ring_buffer_per_cpu *cpu_buffer
 
 static inline void rb_event_discard(struct ring_buffer_event *event)
 {
-	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND)
+	if (extended_time(event))
 		event = skip_time_extend(event);
 
 	/* array[0] holds the actual length for the discarded event */
@@ -2486,10 +2562,11 @@ rb_update_write_stamp(struct ring_buffer_per_cpu *cpu_buffer,
 			cpu_buffer->write_stamp =
 				cpu_buffer->commit_page->page->time_stamp;
 		else if (event->type_len == RINGBUF_TYPE_TIME_EXTEND) {
-			delta = event->array[0];
-			delta <<= TS_SHIFT;
-			delta += event->time_delta;
+			delta = ring_buffer_event_time_stamp(event);
 			cpu_buffer->write_stamp += delta;
+		} else if (event->type_len == RINGBUF_TYPE_TIME_STAMP) {
+			delta = ring_buffer_event_time_stamp(event);
+			cpu_buffer->write_stamp = delta;
 		} else
 			cpu_buffer->write_stamp += event->time_delta;
 	}
@@ -2581,10 +2658,10 @@ trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 		bit = pc & NMI_MASK ? RB_CTX_NMI :
 			pc & HARDIRQ_MASK ? RB_CTX_IRQ : RB_CTX_SOFTIRQ;
 
-	if (unlikely(val & (1 << bit)))
+	if (unlikely(val & (1 << (bit + cpu_buffer->nest))))
 		return 1;
 
-	val |= (1 << bit);
+	val |= (1 << (bit + cpu_buffer->nest));
 	cpu_buffer->current_context = val;
 
 	return 0;
@@ -2593,7 +2670,57 @@ trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 static __always_inline void
 trace_recursive_unlock(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	cpu_buffer->current_context &= cpu_buffer->current_context - 1;
+	cpu_buffer->current_context &=
+		cpu_buffer->current_context - (1 << cpu_buffer->nest);
+}
+
+/* The recursive locking above uses 4 bits */
+#define NESTED_BITS 4
+
+/**
+ * ring_buffer_nest_start - Allow to trace while nested
+ * @buffer: The ring buffer to modify
+ *
+ * The ring buffer has a safty mechanism to prevent recursion.
+ * But there may be a case where a trace needs to be done while
+ * tracing something else. In this case, calling this function
+ * will allow this function to nest within a currently active
+ * ring_buffer_lock_reserve().
+ *
+ * Call this function before calling another ring_buffer_lock_reserve() and
+ * call ring_buffer_nest_end() after the nested ring_buffer_unlock_commit().
+ */
+void ring_buffer_nest_start(struct ring_buffer *buffer)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	int cpu;
+
+	/* Enabled by ring_buffer_nest_end() */
+	preempt_disable_notrace();
+	cpu = raw_smp_processor_id();
+	cpu_buffer = buffer->buffers[cpu];
+	/* This is the shift value for the above recusive locking */
+	cpu_buffer->nest += NESTED_BITS;
+}
+
+/**
+ * ring_buffer_nest_end - Allow to trace while nested
+ * @buffer: The ring buffer to modify
+ *
+ * Must be called after ring_buffer_nest_start() and after the
+ * ring_buffer_unlock_commit().
+ */
+void ring_buffer_nest_end(struct ring_buffer *buffer)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	int cpu;
+
+	/* disabled by ring_buffer_nest_start() */
+	cpu = raw_smp_processor_id();
+	cpu_buffer = buffer->buffers[cpu];
+	/* This is the shift value for the above recusive locking */
+	cpu_buffer->nest -= NESTED_BITS;
+	preempt_enable_notrace();
 }
 
 /**
@@ -2637,7 +2764,8 @@ rb_handle_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 		  sched_clock_stable() ? "" :
 		  "If you just came from a suspend/resume,\n"
 		  "please switch to the trace global clock:\n"
-		  "  echo global > /sys/kernel/debug/tracing/trace_clock\n");
+		  "  echo global > /sys/kernel/debug/tracing/trace_clock\n"
+		  "or add trace_clock=global to the kernel command line\n");
 	info->add_timestamp = 1;
 }
 
@@ -2669,7 +2797,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	 * If this is the first commit on the page, then it has the same
 	 * timestamp as the page itself.
 	 */
-	if (!tail)
+	if (!tail && !ring_buffer_time_stamp_abs(cpu_buffer->buffer))
 		info->delta = 0;
 
 	/* See if we shot pass the end of this buffer page */
@@ -2746,8 +2874,11 @@ rb_reserve_next_event(struct ring_buffer *buffer,
 	/* make sure this diff is calculated here */
 	barrier();
 
-	/* Did the write stamp get updated already? */
-	if (likely(info.ts >= cpu_buffer->write_stamp)) {
+	if (ring_buffer_time_stamp_abs(buffer)) {
+		info.delta = info.ts;
+		rb_handle_timestamp(cpu_buffer, &info);
+	} else /* Did the write stamp get updated already? */
+		if (likely(info.ts >= cpu_buffer->write_stamp)) {
 		info.delta = diff;
 		if (unlikely(test_time_stamp(info.delta)))
 			rb_handle_timestamp(cpu_buffer, &info);
@@ -3429,14 +3560,13 @@ rb_update_read_stamp(struct ring_buffer_per_cpu *cpu_buffer,
 		return;
 
 	case RINGBUF_TYPE_TIME_EXTEND:
-		delta = event->array[0];
-		delta <<= TS_SHIFT;
-		delta += event->time_delta;
+		delta = ring_buffer_event_time_stamp(event);
 		cpu_buffer->read_stamp += delta;
 		return;
 
 	case RINGBUF_TYPE_TIME_STAMP:
-		/* FIXME: not implemented */
+		delta = ring_buffer_event_time_stamp(event);
+		cpu_buffer->read_stamp = delta;
 		return;
 
 	case RINGBUF_TYPE_DATA:
@@ -3460,14 +3590,13 @@ rb_update_iter_read_stamp(struct ring_buffer_iter *iter,
 		return;
 
 	case RINGBUF_TYPE_TIME_EXTEND:
-		delta = event->array[0];
-		delta <<= TS_SHIFT;
-		delta += event->time_delta;
+		delta = ring_buffer_event_time_stamp(event);
 		iter->read_stamp += delta;
 		return;
 
 	case RINGBUF_TYPE_TIME_STAMP:
-		/* FIXME: not implemented */
+		delta = ring_buffer_event_time_stamp(event);
+		iter->read_stamp = delta;
 		return;
 
 	case RINGBUF_TYPE_DATA:
@@ -3691,6 +3820,8 @@ rb_buffer_peek(struct ring_buffer_per_cpu *cpu_buffer, u64 *ts,
 	struct buffer_page *reader;
 	int nr_loops = 0;
 
+	if (ts)
+		*ts = 0;
  again:
 	/*
 	 * We repeat when a time extend is encountered.
@@ -3727,12 +3858,17 @@ rb_buffer_peek(struct ring_buffer_per_cpu *cpu_buffer, u64 *ts,
 		goto again;
 
 	case RINGBUF_TYPE_TIME_STAMP:
-		/* FIXME: not implemented */
+		if (ts) {
+			*ts = ring_buffer_event_time_stamp(event);
+			ring_buffer_normalize_time_stamp(cpu_buffer->buffer,
+							 cpu_buffer->cpu, ts);
+		}
+		/* Internal data, OK to advance */
 		rb_advance_reader(cpu_buffer);
 		goto again;
 
 	case RINGBUF_TYPE_DATA:
-		if (ts) {
+		if (ts && !(*ts)) {
 			*ts = cpu_buffer->read_stamp + event->time_delta;
 			ring_buffer_normalize_time_stamp(cpu_buffer->buffer,
 							 cpu_buffer->cpu, ts);
@@ -3757,6 +3893,9 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	struct ring_buffer_event *event;
 	int nr_loops = 0;
 
+	if (ts)
+		*ts = 0;
+
 	cpu_buffer = iter->cpu_buffer;
 	buffer = cpu_buffer->buffer;
 
@@ -3809,12 +3948,17 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 		goto again;
 
 	case RINGBUF_TYPE_TIME_STAMP:
-		/* FIXME: not implemented */
+		if (ts) {
+			*ts = ring_buffer_event_time_stamp(event);
+			ring_buffer_normalize_time_stamp(cpu_buffer->buffer,
+							 cpu_buffer->cpu, ts);
+		}
+		/* Internal data, OK to advance */
 		rb_advance_iter(iter);
 		goto again;
 
 	case RINGBUF_TYPE_DATA:
-		if (ts) {
+		if (ts && !(*ts)) {
 			*ts = iter->read_stamp + event->time_delta;
 			ring_buffer_normalize_time_stamp(buffer,
 							 cpu_buffer->cpu, ts);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 20a2300ae4e8..e18e69183c9a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -41,6 +41,7 @@
 #include <linux/nmi.h>
 #include <linux/fs.h>
 #include <linux/trace.h>
+#include <linux/sched/clock.h>
 #include <linux/sched/rt.h>
 
 #include "trace.h"
@@ -1168,6 +1169,14 @@ static struct {
 	ARCH_TRACE_CLOCKS
 };
 
+bool trace_clock_in_ns(struct trace_array *tr)
+{
+	if (trace_clocks[tr->clock_id].in_ns)
+		return true;
+
+	return false;
+}
+
 /*
  * trace_parser_get_init - gets the buffer for trace parser
  */
@@ -2269,7 +2278,7 @@ trace_event_buffer_lock_reserve(struct ring_buffer **current_rb,
 
 	*current_rb = trace_file->tr->trace_buffer.buffer;
 
-	if ((trace_file->flags &
+	if (!ring_buffer_time_stamp_abs(*current_rb) && (trace_file->flags &
 	     (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED)) &&
 	    (entry = this_cpu_read(trace_buffered_event))) {
 		/* Try to use the per cpu buffer first */
@@ -4515,6 +4524,9 @@ static const char readme_msg[] =
 #ifdef CONFIG_X86_64
 	"     x86-tsc:   TSC cycle counter\n"
 #endif
+	"\n  timestamp_mode\t-view the mode used to timestamp events\n"
+	"       delta:   Delta difference against a buffer-wide timestamp\n"
+	"    absolute:   Absolute (standalone) timestamp\n"
 	"\n  trace_marker\t\t- Writes into this file writes into the kernel buffer\n"
 	"\n  trace_marker_raw\t\t- Writes into this file writes binary data into the kernel buffer\n"
 	"  tracing_cpumask\t- Limit which CPUs to trace\n"
@@ -4691,8 +4703,9 @@ static const char readme_msg[] =
 	"\t            .sym        display an address as a symbol\n"
 	"\t            .sym-offset display an address as a symbol and offset\n"
 	"\t            .execname   display a common_pid as a program name\n"
-	"\t            .syscall    display a syscall id as a syscall name\n\n"
-	"\t            .log2       display log2 value rather than raw number\n\n"
+	"\t            .syscall    display a syscall id as a syscall name\n"
+	"\t            .log2       display log2 value rather than raw number\n"
+	"\t            .usecs      display a common_timestamp in microseconds\n\n"
 	"\t    The 'pause' parameter can be used to pause an existing hist\n"
 	"\t    trigger or to start a hist trigger but not log any events\n"
 	"\t    until told to do so.  'continue' can be used to start or\n"
@@ -6202,7 +6215,7 @@ static int tracing_clock_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int tracing_set_clock(struct trace_array *tr, const char *clockstr)
+int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 {
 	int i;
 
@@ -6282,6 +6295,71 @@ static int tracing_clock_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+static int tracing_time_stamp_mode_show(struct seq_file *m, void *v)
+{
+	struct trace_array *tr = m->private;
+
+	mutex_lock(&trace_types_lock);
+
+	if (ring_buffer_time_stamp_abs(tr->trace_buffer.buffer))
+		seq_puts(m, "delta [absolute]\n");
+	else
+		seq_puts(m, "[delta] absolute\n");
+
+	mutex_unlock(&trace_types_lock);
+
+	return 0;
+}
+
+static int tracing_time_stamp_mode_open(struct inode *inode, struct file *file)
+{
+	struct trace_array *tr = inode->i_private;
+	int ret;
+
+	if (tracing_disabled)
+		return -ENODEV;
+
+	if (trace_array_get(tr))
+		return -ENODEV;
+
+	ret = single_open(file, tracing_time_stamp_mode_show, inode->i_private);
+	if (ret < 0)
+		trace_array_put(tr);
+
+	return ret;
+}
+
+int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs)
+{
+	int ret = 0;
+
+	mutex_lock(&trace_types_lock);
+
+	if (abs && tr->time_stamp_abs_ref++)
+		goto out;
+
+	if (!abs) {
+		if (WARN_ON_ONCE(!tr->time_stamp_abs_ref)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (--tr->time_stamp_abs_ref)
+			goto out;
+	}
+
+	ring_buffer_set_time_stamp_abs(tr->trace_buffer.buffer, abs);
+
+#ifdef CONFIG_TRACER_MAX_TRACE
+	if (tr->max_buffer.buffer)
+		ring_buffer_set_time_stamp_abs(tr->max_buffer.buffer, abs);
+#endif
+ out:
+	mutex_unlock(&trace_types_lock);
+
+	return ret;
+}
+
 struct ftrace_buffer_info {
 	struct trace_iterator	iter;
 	void			*spare;
@@ -6529,6 +6607,13 @@ static const struct file_operations trace_clock_fops = {
 	.write		= tracing_clock_write,
 };
 
+static const struct file_operations trace_time_stamp_mode_fops = {
+	.open		= tracing_time_stamp_mode_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= tracing_single_release_tr,
+};
+
 #ifdef CONFIG_TRACER_SNAPSHOT
 static const struct file_operations snapshot_fops = {
 	.open		= tracing_snapshot_open,
@@ -7699,6 +7784,7 @@ static int instance_mkdir(const char *name)
 
 	INIT_LIST_HEAD(&tr->systems);
 	INIT_LIST_HEAD(&tr->events);
+	INIT_LIST_HEAD(&tr->hist_vars);
 
 	if (allocate_trace_buffers(tr, trace_buf_size) < 0)
 		goto out_free_tr;
@@ -7851,6 +7937,9 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("tracing_on", 0644, d_tracer,
 			  tr, &rb_simple_fops);
 
+	trace_create_file("timestamp_mode", 0444, d_tracer, tr,
+			  &trace_time_stamp_mode_fops);
+
 	create_trace_options_dir(tr);
 
 #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
@@ -8446,6 +8535,7 @@ __init static int tracer_alloc_buffers(void)
 
 	INIT_LIST_HEAD(&global_trace.systems);
 	INIT_LIST_HEAD(&global_trace.events);
+	INIT_LIST_HEAD(&global_trace.hist_vars);
 	list_add(&global_trace.list, &ftrace_trace_arrays);
 
 	apply_trace_boot_options();
@@ -8507,3 +8597,21 @@ __init static int clear_boot_tracer(void)
 
 fs_initcall(tracer_init_tracefs);
 late_initcall_sync(clear_boot_tracer);
+
+#ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
+__init static int tracing_set_default_clock(void)
+{
+	/* sched_clock_stable() is determined in late_initcall */
+	if (!trace_boot_clock && !sched_clock_stable()) {
+		printk(KERN_WARNING
+		       "Unstable clock detected, switching default tracing clock to \"global\"\n"
+		       "If you want to keep using the local clock, then add:\n"
+		       "  \"trace_clock=local\"\n"
+		       "on the kernel command line\n");
+		tracing_set_clock(&global_trace, "global");
+	}
+
+	return 0;
+}
+late_initcall_sync(tracing_set_default_clock);
+#endif
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 2a6d0325a761..6fb46a06c9dc 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -273,6 +273,8 @@ struct trace_array {
 	/* function tracing enabled */
 	int			function_enabled;
 #endif
+	int			time_stamp_abs_ref;
+	struct list_head	hist_vars;
 };
 
 enum {
@@ -286,6 +288,11 @@ extern struct mutex trace_types_lock;
 extern int trace_array_get(struct trace_array *tr);
 extern void trace_array_put(struct trace_array *tr);
 
+extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
+extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
+
+extern bool trace_clock_in_ns(struct trace_array *tr);
+
 /*
  * The global tracer (top) should be the first trace array added,
  * but we check the flag anyway.
@@ -1209,12 +1216,11 @@ struct ftrace_event_field {
 	int			is_signed;
 };
 
+struct prog_entry;
+
 struct event_filter {
-	int			n_preds;	/* Number assigned */
-	int			a_preds;	/* allocated */
-	struct filter_pred __rcu	*preds;
-	struct filter_pred __rcu	*root;
-	char				*filter_string;
+	struct prog_entry __rcu	*prog;
+	char			*filter_string;
 };
 
 struct event_subsystem {
@@ -1291,7 +1297,7 @@ __event_trigger_test_discard(struct trace_event_file *file,
 	unsigned long eflags = file->flags;
 
 	if (eflags & EVENT_FILE_FL_TRIGGER_COND)
-		*tt = event_triggers_call(file, entry);
+		*tt = event_triggers_call(file, entry, event);
 
 	if (test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags) ||
 	    (unlikely(file->flags & EVENT_FILE_FL_FILTERED) &&
@@ -1328,7 +1334,7 @@ event_trigger_unlock_commit(struct trace_event_file *file,
 		trace_buffer_unlock_commit(file->tr, buffer, event, irq_flags, pc);
 
 	if (tt)
-		event_triggers_post_call(file, tt, entry);
+		event_triggers_post_call(file, tt, entry, event);
 }
 
 /**
@@ -1361,7 +1367,7 @@ event_trigger_unlock_commit_regs(struct trace_event_file *file,
 						irq_flags, pc, regs);
 
 	if (tt)
-		event_triggers_post_call(file, tt, entry);
+		event_triggers_post_call(file, tt, entry, event);
 }
 
 #define FILTER_PRED_INVALID	((unsigned short)-1)
@@ -1406,12 +1412,8 @@ struct filter_pred {
 	unsigned short		*ops;
 	struct ftrace_event_field *field;
 	int 			offset;
-	int 			not;
+	int			not;
 	int 			op;
-	unsigned short		index;
-	unsigned short		parent;
-	unsigned short		left;
-	unsigned short		right;
 };
 
 static inline bool is_string_field(struct ftrace_event_field *field)
@@ -1543,6 +1545,8 @@ extern void pause_named_trigger(struct event_trigger_data *data);
 extern void unpause_named_trigger(struct event_trigger_data *data);
 extern void set_named_trigger_data(struct event_trigger_data *data,
 				   struct event_trigger_data *named_data);
+extern struct event_trigger_data *
+get_named_trigger_data(struct event_trigger_data *data);
 extern int register_event_command(struct event_command *cmd);
 extern int unregister_event_command(struct event_command *cmd);
 extern int register_trigger_hist_enable_disable_cmds(void);
@@ -1586,7 +1590,8 @@ extern int register_trigger_hist_enable_disable_cmds(void);
  */
 struct event_trigger_ops {
 	void			(*func)(struct event_trigger_data *data,
-					void *rec);
+					void *rec,
+					struct ring_buffer_event *rbe);
 	int			(*init)(struct event_trigger_ops *ops,
 					struct event_trigger_data *data);
 	void			(*free)(struct event_trigger_ops *ops,
diff --git a/kernel/trace/trace_clock.c b/kernel/trace/trace_clock.c
index 5fdc779f411d..d8a188e0418a 100644
--- a/kernel/trace/trace_clock.c
+++ b/kernel/trace/trace_clock.c
@@ -96,7 +96,7 @@ u64 notrace trace_clock_global(void)
 	int this_cpu;
 	u64 now;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 
 	this_cpu = raw_smp_processor_id();
 	now = sched_clock_cpu(this_cpu);
@@ -122,7 +122,7 @@ u64 notrace trace_clock_global(void)
 	arch_spin_unlock(&trace_clock_struct.lock);
 
  out:
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 
 	return now;
 }
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index a764aec3c9a1..1bda4ec95e18 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -33,163 +33,595 @@
 	"# Only events with the given fields will be affected.\n"	\
 	"# If no events are modified, an error message will be displayed here"
 
-enum filter_op_ids
-{
-	OP_OR,
-	OP_AND,
-	OP_GLOB,
-	OP_NE,
-	OP_EQ,
-	OP_LT,
-	OP_LE,
-	OP_GT,
-	OP_GE,
-	OP_BAND,
-	OP_NOT,
-	OP_NONE,
-	OP_OPEN_PAREN,
-};
+/* Due to token parsing '<=' must be before '<' and '>=' must be before '>' */
+#define OPS					\
+	C( OP_GLOB,	"~"  ),			\
+	C( OP_NE,	"!=" ),			\
+	C( OP_EQ,	"==" ),			\
+	C( OP_LE,	"<=" ),			\
+	C( OP_LT,	"<"  ),			\
+	C( OP_GE,	">=" ),			\
+	C( OP_GT,	">"  ),			\
+	C( OP_BAND,	"&"  ),			\
+	C( OP_MAX,	NULL )
 
-struct filter_op {
-	int id;
-	char *string;
-	int precedence;
-};
+#undef C
+#define C(a, b)	a
 
-/* Order must be the same as enum filter_op_ids above */
-static struct filter_op filter_ops[] = {
-	{ OP_OR,	"||",		1 },
-	{ OP_AND,	"&&",		2 },
-	{ OP_GLOB,	"~",		4 },
-	{ OP_NE,	"!=",		4 },
-	{ OP_EQ,	"==",		4 },
-	{ OP_LT,	"<",		5 },
-	{ OP_LE,	"<=",		5 },
-	{ OP_GT,	">",		5 },
-	{ OP_GE,	">=",		5 },
-	{ OP_BAND,	"&",		6 },
-	{ OP_NOT,	"!",		6 },
-	{ OP_NONE,	"OP_NONE",	0 },
-	{ OP_OPEN_PAREN, "(",		0 },
-};
+enum filter_op_ids { OPS };
 
-enum {
-	FILT_ERR_NONE,
-	FILT_ERR_INVALID_OP,
-	FILT_ERR_UNBALANCED_PAREN,
-	FILT_ERR_TOO_MANY_OPERANDS,
-	FILT_ERR_OPERAND_TOO_LONG,
-	FILT_ERR_FIELD_NOT_FOUND,
-	FILT_ERR_ILLEGAL_FIELD_OP,
-	FILT_ERR_ILLEGAL_INTVAL,
-	FILT_ERR_BAD_SUBSYS_FILTER,
-	FILT_ERR_TOO_MANY_PREDS,
-	FILT_ERR_MISSING_FIELD,
-	FILT_ERR_INVALID_FILTER,
-	FILT_ERR_IP_FIELD_ONLY,
-	FILT_ERR_ILLEGAL_NOT_OP,
-};
+#undef C
+#define C(a, b)	b
 
-static char *err_text[] = {
-	"No error",
-	"Invalid operator",
-	"Unbalanced parens",
-	"Too many operands",
-	"Operand too long",
-	"Field not found",
-	"Illegal operation for field type",
-	"Illegal integer value",
-	"Couldn't find or set field in one of a subsystem's events",
-	"Too many terms in predicate expression",
-	"Missing field name and/or value",
-	"Meaningless filter expression",
-	"Only 'ip' field is supported for function trace",
-	"Illegal use of '!'",
-};
+static const char * ops[] = { OPS };
 
-struct opstack_op {
-	enum filter_op_ids op;
-	struct list_head list;
-};
+/*
+ * pred functions are OP_LE, OP_LT, OP_GE, OP_GT, and OP_BAND
+ * pred_funcs_##type below must match the order of them above.
+ */
+#define PRED_FUNC_START			OP_LE
+#define PRED_FUNC_MAX			(OP_BAND - PRED_FUNC_START)
+
+#define ERRORS								\
+	C(NONE,			"No error"),				\
+	C(INVALID_OP,		"Invalid operator"),			\
+	C(TOO_MANY_OPEN,	"Too many '('"),			\
+	C(TOO_MANY_CLOSE,	"Too few '('"),				\
+	C(MISSING_QUOTE,	"Missing matching quote"),		\
+	C(OPERAND_TOO_LONG,	"Operand too long"),			\
+	C(EXPECT_STRING,	"Expecting string field"),		\
+	C(EXPECT_DIGIT,		"Expecting numeric field"),		\
+	C(ILLEGAL_FIELD_OP,	"Illegal operation for field type"),	\
+	C(FIELD_NOT_FOUND,	"Field not found"),			\
+	C(ILLEGAL_INTVAL,	"Illegal integer value"),		\
+	C(BAD_SUBSYS_FILTER,	"Couldn't find or set field in one of a subsystem's events"), \
+	C(TOO_MANY_PREDS,	"Too many terms in predicate expression"), \
+	C(INVALID_FILTER,	"Meaningless filter expression"),	\
+	C(IP_FIELD_ONLY,	"Only 'ip' field is supported for function trace"), \
+	C(INVALID_VALUE,	"Invalid value (did you forget quotes)?"),
+
+#undef C
+#define C(a, b)		FILT_ERR_##a
+
+enum { ERRORS };
+
+#undef C
+#define C(a, b)		b
+
+static char *err_text[] = { ERRORS };
+
+/* Called after a '!' character but "!=" and "!~" are not "not"s */
+static bool is_not(const char *str)
+{
+	switch (str[1]) {
+	case '=':
+	case '~':
+		return false;
+	}
+	return true;
+}
 
-struct postfix_elt {
-	enum filter_op_ids op;
-	char *operand;
-	struct list_head list;
+/**
+ * prog_entry - a singe entry in the filter program
+ * @target:	     Index to jump to on a branch (actually one minus the index)
+ * @when_to_branch:  The value of the result of the predicate to do a branch
+ * @pred:	     The predicate to execute.
+ */
+struct prog_entry {
+	int			target;
+	int			when_to_branch;
+	struct filter_pred	*pred;
 };
 
-struct filter_parse_state {
-	struct filter_op *ops;
-	struct list_head opstack;
-	struct list_head postfix;
+/**
+ * update_preds- assign a program entry a label target
+ * @prog: The program array
+ * @N: The index of the current entry in @prog
+ * @when_to_branch: What to assign a program entry for its branch condition
+ *
+ * The program entry at @N has a target that points to the index of a program
+ * entry that can have its target and when_to_branch fields updated.
+ * Update the current program entry denoted by index @N target field to be
+ * that of the updated entry. This will denote the entry to update if
+ * we are processing an "||" after an "&&"
+ */
+static void update_preds(struct prog_entry *prog, int N, int invert)
+{
+	int t, s;
+
+	t = prog[N].target;
+	s = prog[t].target;
+	prog[t].when_to_branch = invert;
+	prog[t].target = N;
+	prog[N].target = s;
+}
+
+struct filter_parse_error {
 	int lasterr;
 	int lasterr_pos;
-
-	struct {
-		char *string;
-		unsigned int cnt;
-		unsigned int tail;
-	} infix;
-
-	struct {
-		char string[MAX_FILTER_STR_VAL];
-		int pos;
-		unsigned int tail;
-	} operand;
 };
 
-struct pred_stack {
-	struct filter_pred	**preds;
-	int			index;
+static void parse_error(struct filter_parse_error *pe, int err, int pos)
+{
+	pe->lasterr = err;
+	pe->lasterr_pos = pos;
+}
+
+typedef int (*parse_pred_fn)(const char *str, void *data, int pos,
+			     struct filter_parse_error *pe,
+			     struct filter_pred **pred);
+
+enum {
+	INVERT		= 1,
+	PROCESS_AND	= 2,
+	PROCESS_OR	= 4,
 };
 
-/* If not of not match is equal to not of not, then it is a match */
+/*
+ * Without going into a formal proof, this explains the method that is used in
+ * parsing the logical expressions.
+ *
+ * For example, if we have: "a && !(!b || (c && g)) || d || e && !f"
+ * The first pass will convert it into the following program:
+ *
+ * n1: r=a;       l1: if (!r) goto l4;
+ * n2: r=b;       l2: if (!r) goto l4;
+ * n3: r=c; r=!r; l3: if (r) goto l4;
+ * n4: r=g; r=!r; l4: if (r) goto l5;
+ * n5: r=d;       l5: if (r) goto T
+ * n6: r=e;       l6: if (!r) goto l7;
+ * n7: r=f; r=!r; l7: if (!r) goto F
+ * T: return TRUE
+ * F: return FALSE
+ *
+ * To do this, we use a data structure to represent each of the above
+ * predicate and conditions that has:
+ *
+ *  predicate, when_to_branch, invert, target
+ *
+ * The "predicate" will hold the function to determine the result "r".
+ * The "when_to_branch" denotes what "r" should be if a branch is to be taken
+ * "&&" would contain "!r" or (0) and "||" would contain "r" or (1).
+ * The "invert" holds whether the value should be reversed before testing.
+ * The "target" contains the label "l#" to jump to.
+ *
+ * A stack is created to hold values when parentheses are used.
+ *
+ * To simplify the logic, the labels will start at 0 and not 1.
+ *
+ * The possible invert values are 1 and 0. The number of "!"s that are in scope
+ * before the predicate determines the invert value, if the number is odd then
+ * the invert value is 1 and 0 otherwise. This means the invert value only
+ * needs to be toggled when a new "!" is introduced compared to what is stored
+ * on the stack, where parentheses were used.
+ *
+ * The top of the stack and "invert" are initialized to zero.
+ *
+ * ** FIRST PASS **
+ *
+ * #1 A loop through all the tokens is done:
+ *
+ * #2 If the token is an "(", the stack is push, and the current stack value
+ *    gets the current invert value, and the loop continues to the next token.
+ *    The top of the stack saves the "invert" value to keep track of what
+ *    the current inversion is. As "!(a && !b || c)" would require all
+ *    predicates being affected separately by the "!" before the parentheses.
+ *    And that would end up being equivalent to "(!a || b) && !c"
+ *
+ * #3 If the token is an "!", the current "invert" value gets inverted, and
+ *    the loop continues. Note, if the next token is a predicate, then
+ *    this "invert" value is only valid for the current program entry,
+ *    and does not affect other predicates later on.
+ *
+ * The only other acceptable token is the predicate string.
+ *
+ * #4 A new entry into the program is added saving: the predicate and the
+ *    current value of "invert". The target is currently assigned to the
+ *    previous program index (this will not be its final value).
+ *
+ * #5 We now enter another loop and look at the next token. The only valid
+ *    tokens are ")", "&&", "||" or end of the input string "\0".
+ *
+ * #6 The invert variable is reset to the current value saved on the top of
+ *    the stack.
+ *
+ * #7 The top of the stack holds not only the current invert value, but also
+ *    if a "&&" or "||" needs to be processed. Note, the "&&" takes higher
+ *    precedence than "||". That is "a && b || c && d" is equivalent to
+ *    "(a && b) || (c && d)". Thus the first thing to do is to see if "&&" needs
+ *    to be processed. This is the case if an "&&" was the last token. If it was
+ *    then we call update_preds(). This takes the program, the current index in
+ *    the program, and the current value of "invert".  More will be described
+ *    below about this function.
+ *
+ * #8 If the next token is "&&" then we set a flag in the top of the stack
+ *    that denotes that "&&" needs to be processed, break out of this loop
+ *    and continue with the outer loop.
+ *
+ * #9 Otherwise, if a "||" needs to be processed then update_preds() is called.
+ *    This is called with the program, the current index in the program, but
+ *    this time with an inverted value of "invert" (that is !invert). This is
+ *    because the value taken will become the "when_to_branch" value of the
+ *    program.
+ *    Note, this is called when the next token is not an "&&". As stated before,
+ *    "&&" takes higher precedence, and "||" should not be processed yet if the
+ *    next logical operation is "&&".
+ *
+ * #10 If the next token is "||" then we set a flag in the top of the stack
+ *     that denotes that "||" needs to be processed, break out of this loop
+ *     and continue with the outer loop.
+ *
+ * #11 If this is the end of the input string "\0" then we break out of both
+ *     loops.
+ *
+ * #12 Otherwise, the next token is ")", where we pop the stack and continue
+ *     this inner loop.
+ *
+ * Now to discuss the update_pred() function, as that is key to the setting up
+ * of the program. Remember the "target" of the program is initialized to the
+ * previous index and not the "l" label. The target holds the index into the
+ * program that gets affected by the operand. Thus if we have something like
+ *  "a || b && c", when we process "a" the target will be "-1" (undefined).
+ * When we process "b", its target is "0", which is the index of "a", as that's
+ * the predicate that is affected by "||". But because the next token after "b"
+ * is "&&" we don't call update_preds(). Instead continue to "c". As the
+ * next token after "c" is not "&&" but the end of input, we first process the
+ * "&&" by calling update_preds() for the "&&" then we process the "||" by
+ * callin updates_preds() with the values for processing "||".
+ *
+ * What does that mean? What update_preds() does is to first save the "target"
+ * of the program entry indexed by the current program entry's "target"
+ * (remember the "target" is initialized to previous program entry), and then
+ * sets that "target" to the current index which represents the label "l#".
+ * That entry's "when_to_branch" is set to the value passed in (the "invert"
+ * or "!invert"). Then it sets the current program entry's target to the saved
+ * "target" value (the old value of the program that had its "target" updated
+ * to the label).
+ *
+ * Looking back at "a || b && c", we have the following steps:
+ *  "a"  - prog[0] = { "a", X, -1 } // pred, when_to_branch, target
+ *  "||" - flag that we need to process "||"; continue outer loop
+ *  "b"  - prog[1] = { "b", X, 0 }
+ *  "&&" - flag that we need to process "&&"; continue outer loop
+ * (Notice we did not process "||")
+ *  "c"  - prog[2] = { "c", X, 1 }
+ *  update_preds(prog, 2, 0); // invert = 0 as we are processing "&&"
+ *    t = prog[2].target; // t = 1
+ *    s = prog[t].target; // s = 0
+ *    prog[t].target = 2; // Set target to "l2"
+ *    prog[t].when_to_branch = 0;
+ *    prog[2].target = s;
+ * update_preds(prog, 2, 1); // invert = 1 as we are now processing "||"
+ *    t = prog[2].target; // t = 0
+ *    s = prog[t].target; // s = -1
+ *    prog[t].target = 2; // Set target to "l2"
+ *    prog[t].when_to_branch = 1;
+ *    prog[2].target = s;
+ *
+ * #13 Which brings us to the final step of the first pass, which is to set
+ *     the last program entry's when_to_branch and target, which will be
+ *     when_to_branch = 0; target = N; ( the label after the program entry after
+ *     the last program entry processed above).
+ *
+ * If we denote "TRUE" to be the entry after the last program entry processed,
+ * and "FALSE" the program entry after that, we are now done with the first
+ * pass.
+ *
+ * Making the above "a || b && c" have a progam of:
+ *  prog[0] = { "a", 1, 2 }
+ *  prog[1] = { "b", 0, 2 }
+ *  prog[2] = { "c", 0, 3 }
+ *
+ * Which translates into:
+ * n0: r = a; l0: if (r) goto l2;
+ * n1: r = b; l1: if (!r) goto l2;
+ * n2: r = c; l2: if (!r) goto l3;  // Which is the same as "goto F;"
+ * T: return TRUE; l3:
+ * F: return FALSE
+ *
+ * Although, after the first pass, the program is correct, it is
+ * inefficient. The simple sample of "a || b && c" could be easily been
+ * converted into:
+ * n0: r = a; if (r) goto T
+ * n1: r = b; if (!r) goto F
+ * n2: r = c; if (!r) goto F
+ * T: return TRUE;
+ * F: return FALSE;
+ *
+ * The First Pass is over the input string. The next too passes are over
+ * the program itself.
+ *
+ * ** SECOND PASS **
+ *
+ * Which brings us to the second pass. If a jump to a label has the
+ * same condition as that label, it can instead jump to its target.
+ * The original example of "a && !(!b || (c && g)) || d || e && !f"
+ * where the first pass gives us:
+ *
+ * n1: r=a;       l1: if (!r) goto l4;
+ * n2: r=b;       l2: if (!r) goto l4;
+ * n3: r=c; r=!r; l3: if (r) goto l4;
+ * n4: r=g; r=!r; l4: if (r) goto l5;
+ * n5: r=d;       l5: if (r) goto T
+ * n6: r=e;       l6: if (!r) goto l7;
+ * n7: r=f; r=!r; l7: if (!r) goto F:
+ * T: return TRUE;
+ * F: return FALSE
+ *
+ * We can see that "l3: if (r) goto l4;" and at l4, we have "if (r) goto l5;".
+ * And "l5: if (r) goto T", we could optimize this by converting l3 and l4
+ * to go directly to T. To accomplish this, we start from the last
+ * entry in the program and work our way back. If the target of the entry
+ * has the same "when_to_branch" then we could use that entry's target.
+ * Doing this, the above would end up as:
+ *
+ * n1: r=a;       l1: if (!r) goto l4;
+ * n2: r=b;       l2: if (!r) goto l4;
+ * n3: r=c; r=!r; l3: if (r) goto T;
+ * n4: r=g; r=!r; l4: if (r) goto T;
+ * n5: r=d;       l5: if (r) goto T;
+ * n6: r=e;       l6: if (!r) goto F;
+ * n7: r=f; r=!r; l7: if (!r) goto F;
+ * T: return TRUE
+ * F: return FALSE
+ *
+ * In that same pass, if the "when_to_branch" doesn't match, we can simply
+ * go to the program entry after the label. That is, "l2: if (!r) goto l4;"
+ * where "l4: if (r) goto T;", then we can convert l2 to be:
+ * "l2: if (!r) goto n5;".
+ *
+ * This will have the second pass give us:
+ * n1: r=a;       l1: if (!r) goto n5;
+ * n2: r=b;       l2: if (!r) goto n5;
+ * n3: r=c; r=!r; l3: if (r) goto T;
+ * n4: r=g; r=!r; l4: if (r) goto T;
+ * n5: r=d;       l5: if (r) goto T
+ * n6: r=e;       l6: if (!r) goto F;
+ * n7: r=f; r=!r; l7: if (!r) goto F
+ * T: return TRUE
+ * F: return FALSE
+ *
+ * Notice, all the "l#" labels are no longer used, and they can now
+ * be discarded.
+ *
+ * ** THIRD PASS **
+ *
+ * For the third pass we deal with the inverts. As they simply just
+ * make the "when_to_branch" get inverted, a simple loop over the
+ * program to that does: "when_to_branch ^= invert;" will do the
+ * job, leaving us with:
+ * n1: r=a; if (!r) goto n5;
+ * n2: r=b; if (!r) goto n5;
+ * n3: r=c: if (!r) goto T;
+ * n4: r=g; if (!r) goto T;
+ * n5: r=d; if (r) goto T
+ * n6: r=e; if (!r) goto F;
+ * n7: r=f; if (r) goto F
+ * T: return TRUE
+ * F: return FALSE
+ *
+ * As "r = a; if (!r) goto n5;" is obviously the same as
+ * "if (!a) goto n5;" without doing anything we can interperate the
+ * program as:
+ * n1: if (!a) goto n5;
+ * n2: if (!b) goto n5;
+ * n3: if (!c) goto T;
+ * n4: if (!g) goto T;
+ * n5: if (d) goto T
+ * n6: if (!e) goto F;
+ * n7: if (f) goto F
+ * T: return TRUE
+ * F: return FALSE
+ *
+ * Since the inverts are discarded at the end, there's no reason to store
+ * them in the program array (and waste memory). A separate array to hold
+ * the inverts is used and freed at the end.
+ */
+static struct prog_entry *
+predicate_parse(const char *str, int nr_parens, int nr_preds,
+		parse_pred_fn parse_pred, void *data,
+		struct filter_parse_error *pe)
+{
+	struct prog_entry *prog_stack;
+	struct prog_entry *prog;
+	const char *ptr = str;
+	char *inverts = NULL;
+	int *op_stack;
+	int *top;
+	int invert = 0;
+	int ret = -ENOMEM;
+	int len;
+	int N = 0;
+	int i;
+
+	nr_preds += 2; /* For TRUE and FALSE */
+
+	op_stack = kmalloc(sizeof(*op_stack) * nr_parens, GFP_KERNEL);
+	if (!op_stack)
+		return ERR_PTR(-ENOMEM);
+	prog_stack = kmalloc(sizeof(*prog_stack) * nr_preds, GFP_KERNEL);
+	if (!prog_stack) {
+		parse_error(pe, -ENOMEM, 0);
+		goto out_free;
+	}
+	inverts = kmalloc(sizeof(*inverts) * nr_preds, GFP_KERNEL);
+	if (!inverts) {
+		parse_error(pe, -ENOMEM, 0);
+		goto out_free;
+	}
+
+	top = op_stack;
+	prog = prog_stack;
+	*top = 0;
+
+	/* First pass */
+	while (*ptr) {						/* #1 */
+		const char *next = ptr++;
+
+		if (isspace(*next))
+			continue;
+
+		switch (*next) {
+		case '(':					/* #2 */
+			if (top - op_stack > nr_parens)
+				return ERR_PTR(-EINVAL);
+			*(++top) = invert;
+			continue;
+		case '!':					/* #3 */
+			if (!is_not(next))
+				break;
+			invert = !invert;
+			continue;
+		}
+
+		if (N >= nr_preds) {
+			parse_error(pe, FILT_ERR_TOO_MANY_PREDS, next - str);
+			goto out_free;
+		}
+
+		inverts[N] = invert;				/* #4 */
+		prog[N].target = N-1;
+
+		len = parse_pred(next, data, ptr - str, pe, &prog[N].pred);
+		if (len < 0) {
+			ret = len;
+			goto out_free;
+		}
+		ptr = next + len;
+
+		N++;
+
+		ret = -1;
+		while (1) {					/* #5 */
+			next = ptr++;
+			if (isspace(*next))
+				continue;
+
+			switch (*next) {
+			case ')':
+			case '\0':
+				break;
+			case '&':
+			case '|':
+				if (next[1] == next[0]) {
+					ptr++;
+					break;
+				}
+			default:
+				parse_error(pe, FILT_ERR_TOO_MANY_PREDS,
+					    next - str);
+				goto out_free;
+			}
+
+			invert = *top & INVERT;
+
+			if (*top & PROCESS_AND) {		/* #7 */
+				update_preds(prog, N - 1, invert);
+				*top &= ~PROCESS_AND;
+			}
+			if (*next == '&') {			/* #8 */
+				*top |= PROCESS_AND;
+				break;
+			}
+			if (*top & PROCESS_OR) {		/* #9 */
+				update_preds(prog, N - 1, !invert);
+				*top &= ~PROCESS_OR;
+			}
+			if (*next == '|') {			/* #10 */
+				*top |= PROCESS_OR;
+				break;
+			}
+			if (!*next)				/* #11 */
+				goto out;
+
+			if (top == op_stack) {
+				ret = -1;
+				/* Too few '(' */
+				parse_error(pe, FILT_ERR_TOO_MANY_CLOSE, ptr - str);
+				goto out_free;
+			}
+			top--;					/* #12 */
+		}
+	}
+ out:
+	if (top != op_stack) {
+		/* Too many '(' */
+		parse_error(pe, FILT_ERR_TOO_MANY_OPEN, ptr - str);
+		goto out_free;
+	}
+
+	prog[N].pred = NULL;					/* #13 */
+	prog[N].target = 1;		/* TRUE */
+	prog[N+1].pred = NULL;
+	prog[N+1].target = 0;		/* FALSE */
+	prog[N-1].target = N;
+	prog[N-1].when_to_branch = false;
+
+	/* Second Pass */
+	for (i = N-1 ; i--; ) {
+		int target = prog[i].target;
+		if (prog[i].when_to_branch == prog[target].when_to_branch)
+			prog[i].target = prog[target].target;
+	}
+
+	/* Third Pass */
+	for (i = 0; i < N; i++) {
+		invert = inverts[i] ^ prog[i].when_to_branch;
+		prog[i].when_to_branch = invert;
+		/* Make sure the program always moves forward */
+		if (WARN_ON(prog[i].target <= i)) {
+			ret = -EINVAL;
+			goto out_free;
+		}
+	}
+
+	return prog;
+out_free:
+	kfree(op_stack);
+	kfree(prog_stack);
+	kfree(inverts);
+	return ERR_PTR(ret);
+}
+
 #define DEFINE_COMPARISON_PRED(type)					\
 static int filter_pred_LT_##type(struct filter_pred *pred, void *event)	\
 {									\
 	type *addr = (type *)(event + pred->offset);			\
 	type val = (type)pred->val;					\
-	int match = (*addr < val);					\
-	return !!match == !pred->not;					\
+	return *addr < val;						\
 }									\
 static int filter_pred_LE_##type(struct filter_pred *pred, void *event)	\
 {									\
 	type *addr = (type *)(event + pred->offset);			\
 	type val = (type)pred->val;					\
-	int match = (*addr <= val);					\
-	return !!match == !pred->not;					\
+	return *addr <= val;						\
 }									\
 static int filter_pred_GT_##type(struct filter_pred *pred, void *event)	\
 {									\
 	type *addr = (type *)(event + pred->offset);			\
 	type val = (type)pred->val;					\
-	int match = (*addr > val);					\
-	return !!match == !pred->not;					\
+	return *addr > val;					\
 }									\
 static int filter_pred_GE_##type(struct filter_pred *pred, void *event)	\
 {									\
 	type *addr = (type *)(event + pred->offset);			\
 	type val = (type)pred->val;					\
-	int match = (*addr >= val);					\
-	return !!match == !pred->not;					\
+	return *addr >= val;						\
 }									\
 static int filter_pred_BAND_##type(struct filter_pred *pred, void *event) \
 {									\
 	type *addr = (type *)(event + pred->offset);			\
 	type val = (type)pred->val;					\
-	int match = !!(*addr & val);					\
-	return match == !pred->not;					\
+	return !!(*addr & val);						\
 }									\
 static const filter_pred_fn_t pred_funcs_##type[] = {			\
-	filter_pred_LT_##type,						\
 	filter_pred_LE_##type,						\
-	filter_pred_GT_##type,						\
+	filter_pred_LT_##type,						\
 	filter_pred_GE_##type,						\
+	filter_pred_GT_##type,						\
 	filter_pred_BAND_##type,					\
 };
 
-#define PRED_FUNC_START			OP_LT
-
 #define DEFINE_EQUALITY_PRED(size)					\
 static int filter_pred_##size(struct filter_pred *pred, void *event)	\
 {									\
@@ -272,44 +704,36 @@ static int filter_pred_strloc(struct filter_pred *pred, void *event)
 static int filter_pred_cpu(struct filter_pred *pred, void *event)
 {
 	int cpu, cmp;
-	int match = 0;
 
 	cpu = raw_smp_processor_id();
 	cmp = pred->val;
 
 	switch (pred->op) {
 	case OP_EQ:
-		match = cpu == cmp;
-		break;
+		return cpu == cmp;
+	case OP_NE:
+		return cpu != cmp;
 	case OP_LT:
-		match = cpu < cmp;
-		break;
+		return cpu < cmp;
 	case OP_LE:
-		match = cpu <= cmp;
-		break;
+		return cpu <= cmp;
 	case OP_GT:
-		match = cpu > cmp;
-		break;
+		return cpu > cmp;
 	case OP_GE:
-		match = cpu >= cmp;
-		break;
+		return cpu >= cmp;
 	default:
-		break;
+		return 0;
 	}
-
-	return !!match == !pred->not;
 }
 
 /* Filter predicate for COMM. */
 static int filter_pred_comm(struct filter_pred *pred, void *event)
 {
-	int cmp, match;
+	int cmp;
 
 	cmp = pred->regex.match(current->comm, &pred->regex,
-				pred->regex.field_len);
-	match = cmp ^ pred->not;
-
-	return match;
+				TASK_COMM_LEN);
+	return cmp ^ pred->not;
 }
 
 static int filter_pred_none(struct filter_pred *pred, void *event)
@@ -366,6 +790,7 @@ static int regex_match_glob(char *str, struct regex *r, int len __maybe_unused)
 		return 1;
 	return 0;
 }
+
 /**
  * filter_parse_regex - parse a basic regex
  * @buff:   the raw regex
@@ -426,10 +851,9 @@ static void filter_build_regex(struct filter_pred *pred)
 	struct regex *r = &pred->regex;
 	char *search;
 	enum regex_type type = MATCH_FULL;
-	int not = 0;
 
 	if (pred->op == OP_GLOB) {
-		type = filter_parse_regex(r->pattern, r->len, &search, &not);
+		type = filter_parse_regex(r->pattern, r->len, &search, &pred->not);
 		r->len = strlen(search);
 		memmove(r->pattern, search, r->len+1);
 	}
@@ -451,210 +875,32 @@ static void filter_build_regex(struct filter_pred *pred)
 		r->match = regex_match_glob;
 		break;
 	}
-
-	pred->not ^= not;
-}
-
-enum move_type {
-	MOVE_DOWN,
-	MOVE_UP_FROM_LEFT,
-	MOVE_UP_FROM_RIGHT
-};
-
-static struct filter_pred *
-get_pred_parent(struct filter_pred *pred, struct filter_pred *preds,
-		int index, enum move_type *move)
-{
-	if (pred->parent & FILTER_PRED_IS_RIGHT)
-		*move = MOVE_UP_FROM_RIGHT;
-	else
-		*move = MOVE_UP_FROM_LEFT;
-	pred = &preds[pred->parent & ~FILTER_PRED_IS_RIGHT];
-
-	return pred;
-}
-
-enum walk_return {
-	WALK_PRED_ABORT,
-	WALK_PRED_PARENT,
-	WALK_PRED_DEFAULT,
-};
-
-typedef int (*filter_pred_walkcb_t) (enum move_type move,
-				     struct filter_pred *pred,
-				     int *err, void *data);
-
-static int walk_pred_tree(struct filter_pred *preds,
-			  struct filter_pred *root,
-			  filter_pred_walkcb_t cb, void *data)
-{
-	struct filter_pred *pred = root;
-	enum move_type move = MOVE_DOWN;
-	int done = 0;
-
-	if  (!preds)
-		return -EINVAL;
-
-	do {
-		int err = 0, ret;
-
-		ret = cb(move, pred, &err, data);
-		if (ret == WALK_PRED_ABORT)
-			return err;
-		if (ret == WALK_PRED_PARENT)
-			goto get_parent;
-
-		switch (move) {
-		case MOVE_DOWN:
-			if (pred->left != FILTER_PRED_INVALID) {
-				pred = &preds[pred->left];
-				continue;
-			}
-			goto get_parent;
-		case MOVE_UP_FROM_LEFT:
-			pred = &preds[pred->right];
-			move = MOVE_DOWN;
-			continue;
-		case MOVE_UP_FROM_RIGHT:
- get_parent:
-			if (pred == root)
-				break;
-			pred = get_pred_parent(pred, preds,
-					       pred->parent,
-					       &move);
-			continue;
-		}
-		done = 1;
-	} while (!done);
-
-	/* We are fine. */
-	return 0;
-}
-
-/*
- * A series of AND or ORs where found together. Instead of
- * climbing up and down the tree branches, an array of the
- * ops were made in order of checks. We can just move across
- * the array and short circuit if needed.
- */
-static int process_ops(struct filter_pred *preds,
-		       struct filter_pred *op, void *rec)
-{
-	struct filter_pred *pred;
-	int match = 0;
-	int type;
-	int i;
-
-	/*
-	 * Micro-optimization: We set type to true if op
-	 * is an OR and false otherwise (AND). Then we
-	 * just need to test if the match is equal to
-	 * the type, and if it is, we can short circuit the
-	 * rest of the checks:
-	 *
-	 * if ((match && op->op == OP_OR) ||
-	 *     (!match && op->op == OP_AND))
-	 *	  return match;
-	 */
-	type = op->op == OP_OR;
-
-	for (i = 0; i < op->val; i++) {
-		pred = &preds[op->ops[i]];
-		if (!WARN_ON_ONCE(!pred->fn))
-			match = pred->fn(pred, rec);
-		if (!!match == type)
-			break;
-	}
-	/* If not of not match is equal to not of not, then it is a match */
-	return !!match == !op->not;
-}
-
-struct filter_match_preds_data {
-	struct filter_pred *preds;
-	int match;
-	void *rec;
-};
-
-static int filter_match_preds_cb(enum move_type move, struct filter_pred *pred,
-				 int *err, void *data)
-{
-	struct filter_match_preds_data *d = data;
-
-	*err = 0;
-	switch (move) {
-	case MOVE_DOWN:
-		/* only AND and OR have children */
-		if (pred->left != FILTER_PRED_INVALID) {
-			/* If ops is set, then it was folded. */
-			if (!pred->ops)
-				return WALK_PRED_DEFAULT;
-			/* We can treat folded ops as a leaf node */
-			d->match = process_ops(d->preds, pred, d->rec);
-		} else {
-			if (!WARN_ON_ONCE(!pred->fn))
-				d->match = pred->fn(pred, d->rec);
-		}
-
-		return WALK_PRED_PARENT;
-	case MOVE_UP_FROM_LEFT:
-		/*
-		 * Check for short circuits.
-		 *
-		 * Optimization: !!match == (pred->op == OP_OR)
-		 *   is the same as:
-		 * if ((match && pred->op == OP_OR) ||
-		 *     (!match && pred->op == OP_AND))
-		 */
-		if (!!d->match == (pred->op == OP_OR))
-			return WALK_PRED_PARENT;
-		break;
-	case MOVE_UP_FROM_RIGHT:
-		break;
-	}
-
-	return WALK_PRED_DEFAULT;
 }
 
 /* return 1 if event matches, 0 otherwise (discard) */
 int filter_match_preds(struct event_filter *filter, void *rec)
 {
-	struct filter_pred *preds;
-	struct filter_pred *root;
-	struct filter_match_preds_data data = {
-		/* match is currently meaningless */
-		.match = -1,
-		.rec   = rec,
-	};
-	int n_preds, ret;
+	struct prog_entry *prog;
+	int i;
 
 	/* no filter is considered a match */
 	if (!filter)
 		return 1;
 
-	n_preds = filter->n_preds;
-	if (!n_preds)
-		return 1;
-
-	/*
-	 * n_preds, root and filter->preds are protect with preemption disabled.
-	 */
-	root = rcu_dereference_sched(filter->root);
-	if (!root)
+	prog = rcu_dereference_sched(filter->prog);
+	if (!prog)
 		return 1;
 
-	data.preds = preds = rcu_dereference_sched(filter->preds);
-	ret = walk_pred_tree(preds, root, filter_match_preds_cb, &data);
-	WARN_ON(ret);
-	return data.match;
+	for (i = 0; prog[i].pred; i++) {
+		struct filter_pred *pred = prog[i].pred;
+		int match = pred->fn(pred, rec);
+		if (match == prog[i].when_to_branch)
+			i = prog[i].target;
+	}
+	return prog[i].target;
 }
 EXPORT_SYMBOL_GPL(filter_match_preds);
 
-static void parse_error(struct filter_parse_state *ps, int err, int pos)
-{
-	ps->lasterr = err;
-	ps->lasterr_pos = pos;
-}
-
 static void remove_filter_string(struct event_filter *filter)
 {
 	if (!filter)
@@ -664,57 +910,44 @@ static void remove_filter_string(struct event_filter *filter)
 	filter->filter_string = NULL;
 }
 
-static int replace_filter_string(struct event_filter *filter,
-				 char *filter_string)
-{
-	kfree(filter->filter_string);
-	filter->filter_string = kstrdup(filter_string, GFP_KERNEL);
-	if (!filter->filter_string)
-		return -ENOMEM;
-
-	return 0;
-}
-
-static int append_filter_string(struct event_filter *filter,
-				char *string)
-{
-	int newlen;
-	char *new_filter_string;
-
-	BUG_ON(!filter->filter_string);
-	newlen = strlen(filter->filter_string) + strlen(string) + 1;
-	new_filter_string = kmalloc(newlen, GFP_KERNEL);
-	if (!new_filter_string)
-		return -ENOMEM;
-
-	strcpy(new_filter_string, filter->filter_string);
-	strcat(new_filter_string, string);
-	kfree(filter->filter_string);
-	filter->filter_string = new_filter_string;
-
-	return 0;
-}
-
-static void append_filter_err(struct filter_parse_state *ps,
+static void append_filter_err(struct filter_parse_error *pe,
 			      struct event_filter *filter)
 {
-	int pos = ps->lasterr_pos;
-	char *buf, *pbuf;
+	struct trace_seq *s;
+	int pos = pe->lasterr_pos;
+	char *buf;
+	int len;
+
+	if (WARN_ON(!filter->filter_string))
+		return;
 
-	buf = (char *)__get_free_page(GFP_KERNEL);
-	if (!buf)
+	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	if (!s)
 		return;
+	trace_seq_init(s);
+
+	len = strlen(filter->filter_string);
+	if (pos > len)
+		pos = len;
 
-	append_filter_string(filter, "\n");
-	memset(buf, ' ', PAGE_SIZE);
-	if (pos > PAGE_SIZE - 128)
-		pos = 0;
-	buf[pos] = '^';
-	pbuf = &buf[pos] + 1;
+	/* indexing is off by one */
+	if (pos)
+		pos++;
 
-	sprintf(pbuf, "\nparse_error: %s\n", err_text[ps->lasterr]);
-	append_filter_string(filter, buf);
-	free_page((unsigned long) buf);
+	trace_seq_puts(s, filter->filter_string);
+	if (pe->lasterr > 0) {
+		trace_seq_printf(s, "\n%*s", pos, "^");
+		trace_seq_printf(s, "\nparse_error: %s\n", err_text[pe->lasterr]);
+	} else {
+		trace_seq_printf(s, "\nError: (%d)\n", pe->lasterr);
+	}
+	trace_seq_putc(s, 0);
+	buf = kmemdup_nul(s->buffer, s->seq.len, GFP_KERNEL);
+	if (buf) {
+		kfree(filter->filter_string);
+		filter->filter_string = buf;
+	}
+	kfree(s);
 }
 
 static inline struct event_filter *event_filter(struct trace_event_file *file)
@@ -747,166 +980,44 @@ void print_subsystem_event_filter(struct event_subsystem *system,
 	mutex_unlock(&event_mutex);
 }
 
-static int __alloc_pred_stack(struct pred_stack *stack, int n_preds)
+static void free_prog(struct event_filter *filter)
 {
-	stack->preds = kcalloc(n_preds + 1, sizeof(*stack->preds), GFP_KERNEL);
-	if (!stack->preds)
-		return -ENOMEM;
-	stack->index = n_preds;
-	return 0;
-}
+	struct prog_entry *prog;
+	int i;
 
-static void __free_pred_stack(struct pred_stack *stack)
-{
-	kfree(stack->preds);
-	stack->index = 0;
+	prog = rcu_access_pointer(filter->prog);
+	if (!prog)
+		return;
+
+	for (i = 0; prog[i].pred; i++)
+		kfree(prog[i].pred);
+	kfree(prog);
 }
 
-static int __push_pred_stack(struct pred_stack *stack,
-			     struct filter_pred *pred)
+static void filter_disable(struct trace_event_file *file)
 {
-	int index = stack->index;
+	unsigned long old_flags = file->flags;
 
-	if (WARN_ON(index == 0))
-		return -ENOSPC;
+	file->flags &= ~EVENT_FILE_FL_FILTERED;
 
-	stack->preds[--index] = pred;
-	stack->index = index;
-	return 0;
+	if (old_flags != file->flags)
+		trace_buffered_event_disable();
 }
 
-static struct filter_pred *
-__pop_pred_stack(struct pred_stack *stack)
+static void __free_filter(struct event_filter *filter)
 {
-	struct filter_pred *pred;
-	int index = stack->index;
-
-	pred = stack->preds[index++];
-	if (!pred)
-		return NULL;
+	if (!filter)
+		return;
 
-	stack->index = index;
-	return pred;
+	free_prog(filter);
+	kfree(filter->filter_string);
+	kfree(filter);
 }
 
-static int filter_set_pred(struct event_filter *filter,
-			   int idx,
-			   struct pred_stack *stack,
-			   struct filter_pred *src)
+void free_event_filter(struct event_filter *filter)
 {
-	struct filter_pred *dest = &filter->preds[idx];
-	struct filter_pred *left;
-	struct filter_pred *right;
-
-	*dest = *src;
-	dest->index = idx;
-
-	if (dest->op == OP_OR || dest->op == OP_AND) {
-		right = __pop_pred_stack(stack);
-		left = __pop_pred_stack(stack);
-		if (!left || !right)
-			return -EINVAL;
-		/*
-		 * If both children can be folded
-		 * and they are the same op as this op or a leaf,
-		 * then this op can be folded.
-		 */
-		if (left->index & FILTER_PRED_FOLD &&
-		    ((left->op == dest->op && !left->not) ||
-		     left->left == FILTER_PRED_INVALID) &&
-		    right->index & FILTER_PRED_FOLD &&
-		    ((right->op == dest->op && !right->not) ||
-		     right->left == FILTER_PRED_INVALID))
-			dest->index |= FILTER_PRED_FOLD;
-
-		dest->left = left->index & ~FILTER_PRED_FOLD;
-		dest->right = right->index & ~FILTER_PRED_FOLD;
-		left->parent = dest->index & ~FILTER_PRED_FOLD;
-		right->parent = dest->index | FILTER_PRED_IS_RIGHT;
-	} else {
-		/*
-		 * Make dest->left invalid to be used as a quick
-		 * way to know this is a leaf node.
-		 */
-		dest->left = FILTER_PRED_INVALID;
-
-		/* All leafs allow folding the parent ops. */
-		dest->index |= FILTER_PRED_FOLD;
-	}
-
-	return __push_pred_stack(stack, dest);
-}
-
-static void __free_preds(struct event_filter *filter)
-{
-	int i;
-
-	if (filter->preds) {
-		for (i = 0; i < filter->n_preds; i++)
-			kfree(filter->preds[i].ops);
-		kfree(filter->preds);
-		filter->preds = NULL;
-	}
-	filter->a_preds = 0;
-	filter->n_preds = 0;
-}
-
-static void filter_disable(struct trace_event_file *file)
-{
-	unsigned long old_flags = file->flags;
-
-	file->flags &= ~EVENT_FILE_FL_FILTERED;
-
-	if (old_flags != file->flags)
-		trace_buffered_event_disable();
-}
-
-static void __free_filter(struct event_filter *filter)
-{
-	if (!filter)
-		return;
-
-	__free_preds(filter);
-	kfree(filter->filter_string);
-	kfree(filter);
-}
-
-void free_event_filter(struct event_filter *filter)
-{
-	__free_filter(filter);
-}
-
-static struct event_filter *__alloc_filter(void)
-{
-	struct event_filter *filter;
-
-	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
-	return filter;
-}
-
-static int __alloc_preds(struct event_filter *filter, int n_preds)
-{
-	struct filter_pred *pred;
-	int i;
-
-	if (filter->preds)
-		__free_preds(filter);
-
-	filter->preds = kcalloc(n_preds, sizeof(*filter->preds), GFP_KERNEL);
-
-	if (!filter->preds)
-		return -ENOMEM;
-
-	filter->a_preds = n_preds;
-	filter->n_preds = 0;
-
-	for (i = 0; i < n_preds; i++) {
-		pred = &filter->preds[i];
-		pred->fn = filter_pred_none;
-	}
-
-	return 0;
-}
+	__free_filter(filter);
+}
 
 static inline void __remove_filter(struct trace_event_file *file)
 {
@@ -937,800 +1048,467 @@ static void filter_free_subsystem_filters(struct trace_subsystem_dir *dir,
 {
 	struct trace_event_file *file;
 
-	list_for_each_entry(file, &tr->events, list) {
-		if (file->system != dir)
-			continue;
-		__free_subsystem_filter(file);
-	}
-}
-
-static int filter_add_pred(struct filter_parse_state *ps,
-			   struct event_filter *filter,
-			   struct filter_pred *pred,
-			   struct pred_stack *stack)
-{
-	int err;
-
-	if (WARN_ON(filter->n_preds == filter->a_preds)) {
-		parse_error(ps, FILT_ERR_TOO_MANY_PREDS, 0);
-		return -ENOSPC;
-	}
-
-	err = filter_set_pred(filter, filter->n_preds, stack, pred);
-	if (err)
-		return err;
-
-	filter->n_preds++;
-
-	return 0;
-}
-
-int filter_assign_type(const char *type)
-{
-	if (strstr(type, "__data_loc") && strstr(type, "char"))
-		return FILTER_DYN_STRING;
-
-	if (strchr(type, '[') && strstr(type, "char"))
-		return FILTER_STATIC_STRING;
-
-	return FILTER_OTHER;
-}
-
-static bool is_legal_op(struct ftrace_event_field *field, enum filter_op_ids op)
-{
-	if (is_string_field(field) &&
-	    (op != OP_EQ && op != OP_NE && op != OP_GLOB))
-		return false;
-	if (!is_string_field(field) && op == OP_GLOB)
-		return false;
-
-	return true;
-}
-
-static filter_pred_fn_t select_comparison_fn(enum filter_op_ids op,
-					    int field_size, int field_is_signed)
-{
-	filter_pred_fn_t fn = NULL;
-
-	switch (field_size) {
-	case 8:
-		if (op == OP_EQ || op == OP_NE)
-			fn = filter_pred_64;
-		else if (field_is_signed)
-			fn = pred_funcs_s64[op - PRED_FUNC_START];
-		else
-			fn = pred_funcs_u64[op - PRED_FUNC_START];
-		break;
-	case 4:
-		if (op == OP_EQ || op == OP_NE)
-			fn = filter_pred_32;
-		else if (field_is_signed)
-			fn = pred_funcs_s32[op - PRED_FUNC_START];
-		else
-			fn = pred_funcs_u32[op - PRED_FUNC_START];
-		break;
-	case 2:
-		if (op == OP_EQ || op == OP_NE)
-			fn = filter_pred_16;
-		else if (field_is_signed)
-			fn = pred_funcs_s16[op - PRED_FUNC_START];
-		else
-			fn = pred_funcs_u16[op - PRED_FUNC_START];
-		break;
-	case 1:
-		if (op == OP_EQ || op == OP_NE)
-			fn = filter_pred_8;
-		else if (field_is_signed)
-			fn = pred_funcs_s8[op - PRED_FUNC_START];
-		else
-			fn = pred_funcs_u8[op - PRED_FUNC_START];
-		break;
-	}
-
-	return fn;
-}
-
-static int init_pred(struct filter_parse_state *ps,
-		     struct ftrace_event_field *field,
-		     struct filter_pred *pred)
-
-{
-	filter_pred_fn_t fn = filter_pred_none;
-	unsigned long long val;
-	int ret;
-
-	pred->offset = field->offset;
-
-	if (!is_legal_op(field, pred->op)) {
-		parse_error(ps, FILT_ERR_ILLEGAL_FIELD_OP, 0);
-		return -EINVAL;
-	}
-
-	if (field->filter_type == FILTER_COMM) {
-		filter_build_regex(pred);
-		fn = filter_pred_comm;
-		pred->regex.field_len = TASK_COMM_LEN;
-	} else if (is_string_field(field)) {
-		filter_build_regex(pred);
-
-		if (field->filter_type == FILTER_STATIC_STRING) {
-			fn = filter_pred_string;
-			pred->regex.field_len = field->size;
-		} else if (field->filter_type == FILTER_DYN_STRING)
-			fn = filter_pred_strloc;
-		else
-			fn = filter_pred_pchar;
-	} else if (is_function_field(field)) {
-		if (strcmp(field->name, "ip")) {
-			parse_error(ps, FILT_ERR_IP_FIELD_ONLY, 0);
-			return -EINVAL;
-		}
-	} else {
-		if (field->is_signed)
-			ret = kstrtoll(pred->regex.pattern, 0, &val);
-		else
-			ret = kstrtoull(pred->regex.pattern, 0, &val);
-		if (ret) {
-			parse_error(ps, FILT_ERR_ILLEGAL_INTVAL, 0);
-			return -EINVAL;
-		}
-		pred->val = val;
-
-		if (field->filter_type == FILTER_CPU)
-			fn = filter_pred_cpu;
-		else
-			fn = select_comparison_fn(pred->op, field->size,
-					  field->is_signed);
-		if (!fn) {
-			parse_error(ps, FILT_ERR_INVALID_OP, 0);
-			return -EINVAL;
-		}
-	}
-
-	if (pred->op == OP_NE)
-		pred->not ^= 1;
-
-	pred->fn = fn;
-	return 0;
-}
-
-static void parse_init(struct filter_parse_state *ps,
-		       struct filter_op *ops,
-		       char *infix_string)
-{
-	memset(ps, '\0', sizeof(*ps));
-
-	ps->infix.string = infix_string;
-	ps->infix.cnt = strlen(infix_string);
-	ps->ops = ops;
-
-	INIT_LIST_HEAD(&ps->opstack);
-	INIT_LIST_HEAD(&ps->postfix);
-}
-
-static char infix_next(struct filter_parse_state *ps)
-{
-	if (!ps->infix.cnt)
-		return 0;
-
-	ps->infix.cnt--;
-
-	return ps->infix.string[ps->infix.tail++];
-}
-
-static char infix_peek(struct filter_parse_state *ps)
-{
-	if (ps->infix.tail == strlen(ps->infix.string))
-		return 0;
-
-	return ps->infix.string[ps->infix.tail];
-}
-
-static void infix_advance(struct filter_parse_state *ps)
-{
-	if (!ps->infix.cnt)
-		return;
-
-	ps->infix.cnt--;
-	ps->infix.tail++;
-}
-
-static inline int is_precedence_lower(struct filter_parse_state *ps,
-				      int a, int b)
-{
-	return ps->ops[a].precedence < ps->ops[b].precedence;
-}
-
-static inline int is_op_char(struct filter_parse_state *ps, char c)
-{
-	int i;
-
-	for (i = 0; strcmp(ps->ops[i].string, "OP_NONE"); i++) {
-		if (ps->ops[i].string[0] == c)
-			return 1;
-	}
-
-	return 0;
-}
-
-static int infix_get_op(struct filter_parse_state *ps, char firstc)
-{
-	char nextc = infix_peek(ps);
-	char opstr[3];
-	int i;
-
-	opstr[0] = firstc;
-	opstr[1] = nextc;
-	opstr[2] = '\0';
-
-	for (i = 0; strcmp(ps->ops[i].string, "OP_NONE"); i++) {
-		if (!strcmp(opstr, ps->ops[i].string)) {
-			infix_advance(ps);
-			return ps->ops[i].id;
-		}
-	}
-
-	opstr[1] = '\0';
-
-	for (i = 0; strcmp(ps->ops[i].string, "OP_NONE"); i++) {
-		if (!strcmp(opstr, ps->ops[i].string))
-			return ps->ops[i].id;
-	}
-
-	return OP_NONE;
-}
-
-static inline void clear_operand_string(struct filter_parse_state *ps)
-{
-	memset(ps->operand.string, '\0', MAX_FILTER_STR_VAL);
-	ps->operand.tail = 0;
-}
-
-static inline int append_operand_char(struct filter_parse_state *ps, char c)
-{
-	if (ps->operand.tail == MAX_FILTER_STR_VAL - 1)
-		return -EINVAL;
-
-	ps->operand.string[ps->operand.tail++] = c;
-
-	return 0;
-}
-
-static int filter_opstack_push(struct filter_parse_state *ps,
-			       enum filter_op_ids op)
-{
-	struct opstack_op *opstack_op;
-
-	opstack_op = kmalloc(sizeof(*opstack_op), GFP_KERNEL);
-	if (!opstack_op)
-		return -ENOMEM;
-
-	opstack_op->op = op;
-	list_add(&opstack_op->list, &ps->opstack);
-
-	return 0;
-}
-
-static int filter_opstack_empty(struct filter_parse_state *ps)
-{
-	return list_empty(&ps->opstack);
-}
-
-static int filter_opstack_top(struct filter_parse_state *ps)
-{
-	struct opstack_op *opstack_op;
-
-	if (filter_opstack_empty(ps))
-		return OP_NONE;
-
-	opstack_op = list_first_entry(&ps->opstack, struct opstack_op, list);
-
-	return opstack_op->op;
-}
-
-static int filter_opstack_pop(struct filter_parse_state *ps)
-{
-	struct opstack_op *opstack_op;
-	enum filter_op_ids op;
-
-	if (filter_opstack_empty(ps))
-		return OP_NONE;
-
-	opstack_op = list_first_entry(&ps->opstack, struct opstack_op, list);
-	op = opstack_op->op;
-	list_del(&opstack_op->list);
-
-	kfree(opstack_op);
-
-	return op;
-}
-
-static void filter_opstack_clear(struct filter_parse_state *ps)
-{
-	while (!filter_opstack_empty(ps))
-		filter_opstack_pop(ps);
-}
-
-static char *curr_operand(struct filter_parse_state *ps)
-{
-	return ps->operand.string;
-}
-
-static int postfix_append_operand(struct filter_parse_state *ps, char *operand)
-{
-	struct postfix_elt *elt;
-
-	elt = kmalloc(sizeof(*elt), GFP_KERNEL);
-	if (!elt)
-		return -ENOMEM;
-
-	elt->op = OP_NONE;
-	elt->operand = kstrdup(operand, GFP_KERNEL);
-	if (!elt->operand) {
-		kfree(elt);
-		return -ENOMEM;
-	}
-
-	list_add_tail(&elt->list, &ps->postfix);
-
-	return 0;
-}
-
-static int postfix_append_op(struct filter_parse_state *ps, enum filter_op_ids op)
-{
-	struct postfix_elt *elt;
-
-	elt = kmalloc(sizeof(*elt), GFP_KERNEL);
-	if (!elt)
-		return -ENOMEM;
-
-	elt->op = op;
-	elt->operand = NULL;
-
-	list_add_tail(&elt->list, &ps->postfix);
-
-	return 0;
-}
-
-static void postfix_clear(struct filter_parse_state *ps)
-{
-	struct postfix_elt *elt;
-
-	while (!list_empty(&ps->postfix)) {
-		elt = list_first_entry(&ps->postfix, struct postfix_elt, list);
-		list_del(&elt->list);
-		kfree(elt->operand);
-		kfree(elt);
-	}
-}
-
-static int filter_parse(struct filter_parse_state *ps)
-{
-	enum filter_op_ids op, top_op;
-	int in_string = 0;
-	char ch;
-
-	while ((ch = infix_next(ps))) {
-		if (ch == '"') {
-			in_string ^= 1;
-			continue;
-		}
-
-		if (in_string)
-			goto parse_operand;
-
-		if (isspace(ch))
-			continue;
-
-		if (is_op_char(ps, ch)) {
-			op = infix_get_op(ps, ch);
-			if (op == OP_NONE) {
-				parse_error(ps, FILT_ERR_INVALID_OP, 0);
-				return -EINVAL;
-			}
-
-			if (strlen(curr_operand(ps))) {
-				postfix_append_operand(ps, curr_operand(ps));
-				clear_operand_string(ps);
-			}
-
-			while (!filter_opstack_empty(ps)) {
-				top_op = filter_opstack_top(ps);
-				if (!is_precedence_lower(ps, top_op, op)) {
-					top_op = filter_opstack_pop(ps);
-					postfix_append_op(ps, top_op);
-					continue;
-				}
-				break;
-			}
-
-			filter_opstack_push(ps, op);
-			continue;
-		}
-
-		if (ch == '(') {
-			filter_opstack_push(ps, OP_OPEN_PAREN);
-			continue;
-		}
-
-		if (ch == ')') {
-			if (strlen(curr_operand(ps))) {
-				postfix_append_operand(ps, curr_operand(ps));
-				clear_operand_string(ps);
-			}
-
-			top_op = filter_opstack_pop(ps);
-			while (top_op != OP_NONE) {
-				if (top_op == OP_OPEN_PAREN)
-					break;
-				postfix_append_op(ps, top_op);
-				top_op = filter_opstack_pop(ps);
-			}
-			if (top_op == OP_NONE) {
-				parse_error(ps, FILT_ERR_UNBALANCED_PAREN, 0);
-				return -EINVAL;
-			}
-			continue;
-		}
-parse_operand:
-		if (append_operand_char(ps, ch)) {
-			parse_error(ps, FILT_ERR_OPERAND_TOO_LONG, 0);
-			return -EINVAL;
-		}
-	}
-
-	if (strlen(curr_operand(ps)))
-		postfix_append_operand(ps, curr_operand(ps));
-
-	while (!filter_opstack_empty(ps)) {
-		top_op = filter_opstack_pop(ps);
-		if (top_op == OP_NONE)
-			break;
-		if (top_op == OP_OPEN_PAREN) {
-			parse_error(ps, FILT_ERR_UNBALANCED_PAREN, 0);
-			return -EINVAL;
-		}
-		postfix_append_op(ps, top_op);
+	list_for_each_entry(file, &tr->events, list) {
+		if (file->system != dir)
+			continue;
+		__free_subsystem_filter(file);
 	}
-
-	return 0;
 }
 
-static struct filter_pred *create_pred(struct filter_parse_state *ps,
-				       struct trace_event_call *call,
-				       enum filter_op_ids op,
-				       char *operand1, char *operand2)
+int filter_assign_type(const char *type)
 {
-	struct ftrace_event_field *field;
-	static struct filter_pred pred;
+	if (strstr(type, "__data_loc") && strstr(type, "char"))
+		return FILTER_DYN_STRING;
+
+	if (strchr(type, '[') && strstr(type, "char"))
+		return FILTER_STATIC_STRING;
 
-	memset(&pred, 0, sizeof(pred));
-	pred.op = op;
+	return FILTER_OTHER;
+}
 
-	if (op == OP_AND || op == OP_OR)
-		return &pred;
+static filter_pred_fn_t select_comparison_fn(enum filter_op_ids op,
+					    int field_size, int field_is_signed)
+{
+	filter_pred_fn_t fn = NULL;
+	int pred_func_index = -1;
 
-	if (!operand1 || !operand2) {
-		parse_error(ps, FILT_ERR_MISSING_FIELD, 0);
-		return NULL;
+	switch (op) {
+	case OP_EQ:
+	case OP_NE:
+		break;
+	default:
+		if (WARN_ON_ONCE(op < PRED_FUNC_START))
+			return NULL;
+		pred_func_index = op - PRED_FUNC_START;
+		if (WARN_ON_ONCE(pred_func_index > PRED_FUNC_MAX))
+			return NULL;
 	}
 
-	field = trace_find_event_field(call, operand1);
-	if (!field) {
-		parse_error(ps, FILT_ERR_FIELD_NOT_FOUND, 0);
-		return NULL;
+	switch (field_size) {
+	case 8:
+		if (pred_func_index < 0)
+			fn = filter_pred_64;
+		else if (field_is_signed)
+			fn = pred_funcs_s64[pred_func_index];
+		else
+			fn = pred_funcs_u64[pred_func_index];
+		break;
+	case 4:
+		if (pred_func_index < 0)
+			fn = filter_pred_32;
+		else if (field_is_signed)
+			fn = pred_funcs_s32[pred_func_index];
+		else
+			fn = pred_funcs_u32[pred_func_index];
+		break;
+	case 2:
+		if (pred_func_index < 0)
+			fn = filter_pred_16;
+		else if (field_is_signed)
+			fn = pred_funcs_s16[pred_func_index];
+		else
+			fn = pred_funcs_u16[pred_func_index];
+		break;
+	case 1:
+		if (pred_func_index < 0)
+			fn = filter_pred_8;
+		else if (field_is_signed)
+			fn = pred_funcs_s8[pred_func_index];
+		else
+			fn = pred_funcs_u8[pred_func_index];
+		break;
 	}
 
-	strcpy(pred.regex.pattern, operand2);
-	pred.regex.len = strlen(pred.regex.pattern);
-	pred.field = field;
-	return init_pred(ps, field, &pred) ? NULL : &pred;
+	return fn;
 }
 
-static int check_preds(struct filter_parse_state *ps)
+/* Called when a predicate is encountered by predicate_parse() */
+static int parse_pred(const char *str, void *data,
+		      int pos, struct filter_parse_error *pe,
+		      struct filter_pred **pred_ptr)
 {
-	int n_normal_preds = 0, n_logical_preds = 0;
-	struct postfix_elt *elt;
-	int cnt = 0;
+	struct trace_event_call *call = data;
+	struct ftrace_event_field *field;
+	struct filter_pred *pred = NULL;
+	char num_buf[24];	/* Big enough to hold an address */
+	char *field_name;
+	char q;
+	u64 val;
+	int len;
+	int ret;
+	int op;
+	int s;
+	int i = 0;
 
-	list_for_each_entry(elt, &ps->postfix, list) {
-		if (elt->op == OP_NONE) {
-			cnt++;
-			continue;
-		}
+	/* First find the field to associate to */
+	while (isspace(str[i]))
+		i++;
+	s = i;
 
-		if (elt->op == OP_AND || elt->op == OP_OR) {
-			n_logical_preds++;
-			cnt--;
-			continue;
-		}
-		if (elt->op != OP_NOT)
-			cnt--;
-		n_normal_preds++;
-		/* all ops should have operands */
-		if (cnt < 0)
-			break;
-	}
+	while (isalnum(str[i]) || str[i] == '_')
+		i++;
+
+	len = i - s;
+
+	if (!len)
+		return -1;
 
-	if (cnt != 1 || !n_normal_preds || n_logical_preds >= n_normal_preds) {
-		parse_error(ps, FILT_ERR_INVALID_FILTER, 0);
+	field_name = kmemdup_nul(str + s, len, GFP_KERNEL);
+	if (!field_name)
+		return -ENOMEM;
+
+	/* Make sure that the field exists */
+
+	field = trace_find_event_field(call, field_name);
+	kfree(field_name);
+	if (!field) {
+		parse_error(pe, FILT_ERR_FIELD_NOT_FOUND, pos + i);
 		return -EINVAL;
 	}
 
-	return 0;
-}
+	while (isspace(str[i]))
+		i++;
 
-static int count_preds(struct filter_parse_state *ps)
-{
-	struct postfix_elt *elt;
-	int n_preds = 0;
+	/* Make sure this op is supported */
+	for (op = 0; ops[op]; op++) {
+		/* This is why '<=' must come before '<' in ops[] */
+		if (strncmp(str + i, ops[op], strlen(ops[op])) == 0)
+			break;
+	}
 
-	list_for_each_entry(elt, &ps->postfix, list) {
-		if (elt->op == OP_NONE)
-			continue;
-		n_preds++;
+	if (!ops[op]) {
+		parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
+		goto err_free;
 	}
 
-	return n_preds;
-}
+	i += strlen(ops[op]);
 
-struct check_pred_data {
-	int count;
-	int max;
-};
+	while (isspace(str[i]))
+		i++;
 
-static int check_pred_tree_cb(enum move_type move, struct filter_pred *pred,
-			      int *err, void *data)
-{
-	struct check_pred_data *d = data;
+	s = i;
 
-	if (WARN_ON(d->count++ > d->max)) {
-		*err = -EINVAL;
-		return WALK_PRED_ABORT;
-	}
-	return WALK_PRED_DEFAULT;
-}
+	pred = kzalloc(sizeof(*pred), GFP_KERNEL);
+	if (!pred)
+		return -ENOMEM;
 
-/*
- * The tree is walked at filtering of an event. If the tree is not correctly
- * built, it may cause an infinite loop. Check here that the tree does
- * indeed terminate.
- */
-static int check_pred_tree(struct event_filter *filter,
-			   struct filter_pred *root)
-{
-	struct check_pred_data data = {
+	pred->field = field;
+	pred->offset = field->offset;
+	pred->op = op;
+
+	if (ftrace_event_is_function(call)) {
 		/*
-		 * The max that we can hit a node is three times.
-		 * Once going down, once coming up from left, and
-		 * once coming up from right. This is more than enough
-		 * since leafs are only hit a single time.
+		 * Perf does things different with function events.
+		 * It only allows an "ip" field, and expects a string.
+		 * But the string does not need to be surrounded by quotes.
+		 * If it is a string, the assigned function as a nop,
+		 * (perf doesn't use it) and grab everything.
 		 */
-		.max   = 3 * filter->n_preds,
-		.count = 0,
-	};
+		if (strcmp(field->name, "ip") != 0) {
+			 parse_error(pe, FILT_ERR_IP_FIELD_ONLY, pos + i);
+			 goto err_free;
+		 }
+		 pred->fn = filter_pred_none;
+
+		 /*
+		  * Quotes are not required, but if they exist then we need
+		  * to read them till we hit a matching one.
+		  */
+		 if (str[i] == '\'' || str[i] == '"')
+			 q = str[i];
+		 else
+			 q = 0;
+
+		 for (i++; str[i]; i++) {
+			 if (q && str[i] == q)
+				 break;
+			 if (!q && (str[i] == ')' || str[i] == '&' ||
+				    str[i] == '|'))
+				 break;
+		 }
+		 /* Skip quotes */
+		 if (q)
+			 s++;
+		len = i - s;
+		if (len >= MAX_FILTER_STR_VAL) {
+			parse_error(pe, FILT_ERR_OPERAND_TOO_LONG, pos + i);
+			goto err_free;
+		}
 
-	return walk_pred_tree(filter->preds, root,
-			      check_pred_tree_cb, &data);
-}
+		pred->regex.len = len;
+		strncpy(pred->regex.pattern, str + s, len);
+		pred->regex.pattern[len] = 0;
+
+	/* This is either a string, or an integer */
+	} else if (str[i] == '\'' || str[i] == '"') {
+		char q = str[i];
+
+		/* Make sure the op is OK for strings */
+		switch (op) {
+		case OP_NE:
+			pred->not = 1;
+			/* Fall through */
+		case OP_GLOB:
+		case OP_EQ:
+			break;
+		default:
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			goto err_free;
+		}
 
-static int count_leafs_cb(enum move_type move, struct filter_pred *pred,
-			  int *err, void *data)
-{
-	int *count = data;
+		/* Make sure the field is OK for strings */
+		if (!is_string_field(field)) {
+			parse_error(pe, FILT_ERR_EXPECT_DIGIT, pos + i);
+			goto err_free;
+		}
 
-	if ((move == MOVE_DOWN) &&
-	    (pred->left == FILTER_PRED_INVALID))
-		(*count)++;
+		for (i++; str[i]; i++) {
+			if (str[i] == q)
+				break;
+		}
+		if (!str[i]) {
+			parse_error(pe, FILT_ERR_MISSING_QUOTE, pos + i);
+			goto err_free;
+		}
 
-	return WALK_PRED_DEFAULT;
-}
+		/* Skip quotes */
+		s++;
+		len = i - s;
+		if (len >= MAX_FILTER_STR_VAL) {
+			parse_error(pe, FILT_ERR_OPERAND_TOO_LONG, pos + i);
+			goto err_free;
+		}
 
-static int count_leafs(struct filter_pred *preds, struct filter_pred *root)
-{
-	int count = 0, ret;
+		pred->regex.len = len;
+		strncpy(pred->regex.pattern, str + s, len);
+		pred->regex.pattern[len] = 0;
 
-	ret = walk_pred_tree(preds, root, count_leafs_cb, &count);
-	WARN_ON(ret);
-	return count;
-}
+		filter_build_regex(pred);
 
-struct fold_pred_data {
-	struct filter_pred *root;
-	int count;
-	int children;
-};
+		if (field->filter_type == FILTER_COMM) {
+			pred->fn = filter_pred_comm;
 
-static int fold_pred_cb(enum move_type move, struct filter_pred *pred,
-			int *err, void *data)
-{
-	struct fold_pred_data *d = data;
-	struct filter_pred *root = d->root;
+		} else if (field->filter_type == FILTER_STATIC_STRING) {
+			pred->fn = filter_pred_string;
+			pred->regex.field_len = field->size;
 
-	if (move != MOVE_DOWN)
-		return WALK_PRED_DEFAULT;
-	if (pred->left != FILTER_PRED_INVALID)
-		return WALK_PRED_DEFAULT;
+		} else if (field->filter_type == FILTER_DYN_STRING)
+			pred->fn = filter_pred_strloc;
+		else
+			pred->fn = filter_pred_pchar;
+		/* go past the last quote */
+		i++;
 
-	if (WARN_ON(d->count == d->children)) {
-		*err = -EINVAL;
-		return WALK_PRED_ABORT;
-	}
+	} else if (isdigit(str[i])) {
 
-	pred->index &= ~FILTER_PRED_FOLD;
-	root->ops[d->count++] = pred->index;
-	return WALK_PRED_DEFAULT;
-}
+		/* Make sure the field is not a string */
+		if (is_string_field(field)) {
+			parse_error(pe, FILT_ERR_EXPECT_STRING, pos + i);
+			goto err_free;
+		}
 
-static int fold_pred(struct filter_pred *preds, struct filter_pred *root)
-{
-	struct fold_pred_data data = {
-		.root  = root,
-		.count = 0,
-	};
-	int children;
+		if (op == OP_GLOB) {
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			goto err_free;
+		}
 
-	/* No need to keep the fold flag */
-	root->index &= ~FILTER_PRED_FOLD;
+		/* We allow 0xDEADBEEF */
+		while (isalnum(str[i]))
+			i++;
 
-	/* If the root is a leaf then do nothing */
-	if (root->left == FILTER_PRED_INVALID)
-		return 0;
+		len = i - s;
+		/* 0xfeedfacedeadbeef is 18 chars max */
+		if (len >= sizeof(num_buf)) {
+			parse_error(pe, FILT_ERR_OPERAND_TOO_LONG, pos + i);
+			goto err_free;
+		}
 
-	/* count the children */
-	children = count_leafs(preds, &preds[root->left]);
-	children += count_leafs(preds, &preds[root->right]);
+		strncpy(num_buf, str + s, len);
+		num_buf[len] = 0;
 
-	root->ops = kcalloc(children, sizeof(*root->ops), GFP_KERNEL);
-	if (!root->ops)
-		return -ENOMEM;
+		/* Make sure it is a value */
+		if (field->is_signed)
+			ret = kstrtoll(num_buf, 0, &val);
+		else
+			ret = kstrtoull(num_buf, 0, &val);
+		if (ret) {
+			parse_error(pe, FILT_ERR_ILLEGAL_INTVAL, pos + s);
+			goto err_free;
+		}
 
-	root->val = children;
-	data.children = children;
-	return walk_pred_tree(preds, root, fold_pred_cb, &data);
-}
+		pred->val = val;
 
-static int fold_pred_tree_cb(enum move_type move, struct filter_pred *pred,
-			     int *err, void *data)
-{
-	struct filter_pred *preds = data;
+		if (field->filter_type == FILTER_CPU)
+			pred->fn = filter_pred_cpu;
+		else {
+			pred->fn = select_comparison_fn(pred->op, field->size,
+							field->is_signed);
+			if (pred->op == OP_NE)
+				pred->not = 1;
+		}
 
-	if (move != MOVE_DOWN)
-		return WALK_PRED_DEFAULT;
-	if (!(pred->index & FILTER_PRED_FOLD))
-		return WALK_PRED_DEFAULT;
+	} else {
+		parse_error(pe, FILT_ERR_INVALID_VALUE, pos + i);
+		goto err_free;
+	}
 
-	*err = fold_pred(preds, pred);
-	if (*err)
-		return WALK_PRED_ABORT;
+	*pred_ptr = pred;
+	return i;
 
-	/* eveyrhing below is folded, continue with parent */
-	return WALK_PRED_PARENT;
+err_free:
+	kfree(pred);
+	return -EINVAL;
 }
 
+enum {
+	TOO_MANY_CLOSE		= -1,
+	TOO_MANY_OPEN		= -2,
+	MISSING_QUOTE		= -3,
+};
+
 /*
- * To optimize the processing of the ops, if we have several "ors" or
- * "ands" together, we can put them in an array and process them all
- * together speeding up the filter logic.
+ * Read the filter string once to calculate the number of predicates
+ * as well as how deep the parentheses go.
+ *
+ * Returns:
+ *   0 - everything is fine (err is undefined)
+ *  -1 - too many ')'
+ *  -2 - too many '('
+ *  -3 - No matching quote
  */
-static int fold_pred_tree(struct event_filter *filter,
-			   struct filter_pred *root)
-{
-	return walk_pred_tree(filter->preds, root, fold_pred_tree_cb,
-			      filter->preds);
-}
-
-static int replace_preds(struct trace_event_call *call,
-			 struct event_filter *filter,
-			 struct filter_parse_state *ps,
-			 bool dry_run)
-{
-	char *operand1 = NULL, *operand2 = NULL;
-	struct filter_pred *pred;
-	struct filter_pred *root;
-	struct postfix_elt *elt;
-	struct pred_stack stack = { }; /* init to NULL */
-	int err;
-	int n_preds = 0;
-
-	n_preds = count_preds(ps);
-	if (n_preds >= MAX_FILTER_PRED) {
-		parse_error(ps, FILT_ERR_TOO_MANY_PREDS, 0);
-		return -ENOSPC;
-	}
-
-	err = check_preds(ps);
-	if (err)
-		return err;
+static int calc_stack(const char *str, int *parens, int *preds, int *err)
+{
+	bool is_pred = false;
+	int nr_preds = 0;
+	int open = 1; /* Count the expression as "(E)" */
+	int last_quote = 0;
+	int max_open = 1;
+	int quote = 0;
+	int i;
 
-	if (!dry_run) {
-		err = __alloc_pred_stack(&stack, n_preds);
-		if (err)
-			return err;
-		err = __alloc_preds(filter, n_preds);
-		if (err)
-			goto fail;
-	}
+	*err = 0;
 
-	n_preds = 0;
-	list_for_each_entry(elt, &ps->postfix, list) {
-		if (elt->op == OP_NONE) {
-			if (!operand1)
-				operand1 = elt->operand;
-			else if (!operand2)
-				operand2 = elt->operand;
-			else {
-				parse_error(ps, FILT_ERR_TOO_MANY_OPERANDS, 0);
-				err = -EINVAL;
-				goto fail;
-			}
+	for (i = 0; str[i]; i++) {
+		if (isspace(str[i]))
+			continue;
+		if (quote) {
+			if (str[i] == quote)
+			       quote = 0;
 			continue;
 		}
 
-		if (elt->op == OP_NOT) {
-			if (!n_preds || operand1 || operand2) {
-				parse_error(ps, FILT_ERR_ILLEGAL_NOT_OP, 0);
-				err = -EINVAL;
-				goto fail;
+		switch (str[i]) {
+		case '\'':
+		case '"':
+			quote = str[i];
+			last_quote = i;
+			break;
+		case '|':
+		case '&':
+			if (str[i+1] != str[i])
+				break;
+			is_pred = false;
+			continue;
+		case '(':
+			is_pred = false;
+			open++;
+			if (open > max_open)
+				max_open = open;
+			continue;
+		case ')':
+			is_pred = false;
+			if (open == 1) {
+				*err = i;
+				return TOO_MANY_CLOSE;
 			}
-			if (!dry_run)
-				filter->preds[n_preds - 1].not ^= 1;
+			open--;
 			continue;
 		}
-
-		if (WARN_ON(n_preds++ == MAX_FILTER_PRED)) {
-			parse_error(ps, FILT_ERR_TOO_MANY_PREDS, 0);
-			err = -ENOSPC;
-			goto fail;
+		if (!is_pred) {
+			nr_preds++;
+			is_pred = true;
 		}
+	}
 
-		pred = create_pred(ps, call, elt->op, operand1, operand2);
-		if (!pred) {
-			err = -EINVAL;
-			goto fail;
-		}
+	if (quote) {
+		*err = last_quote;
+		return MISSING_QUOTE;
+	}
 
-		if (!dry_run) {
-			err = filter_add_pred(ps, filter, pred, &stack);
-			if (err)
-				goto fail;
-		}
+	if (open != 1) {
+		int level = open;
 
-		operand1 = operand2 = NULL;
+		/* find the bad open */
+		for (i--; i; i--) {
+			if (quote) {
+				if (str[i] == quote)
+					quote = 0;
+				continue;
+			}
+			switch (str[i]) {
+			case '(':
+				if (level == open) {
+					*err = i;
+					return TOO_MANY_OPEN;
+				}
+				level--;
+				break;
+			case ')':
+				level++;
+				break;
+			case '\'':
+			case '"':
+				quote = str[i];
+				break;
+			}
+		}
+		/* First character is the '(' with missing ')' */
+		*err = 0;
+		return TOO_MANY_OPEN;
 	}
 
-	if (!dry_run) {
-		/* We should have one item left on the stack */
-		pred = __pop_pred_stack(&stack);
-		if (!pred)
-			return -EINVAL;
-		/* This item is where we start from in matching */
-		root = pred;
-		/* Make sure the stack is empty */
-		pred = __pop_pred_stack(&stack);
-		if (WARN_ON(pred)) {
-			err = -EINVAL;
-			filter->root = NULL;
-			goto fail;
+	/* Set the size of the required stacks */
+	*parens = max_open;
+	*preds = nr_preds;
+	return 0;
+}
+
+static int process_preds(struct trace_event_call *call,
+			 const char *filter_string,
+			 struct event_filter *filter,
+			 struct filter_parse_error *pe)
+{
+	struct prog_entry *prog;
+	int nr_parens;
+	int nr_preds;
+	int index;
+	int ret;
+
+	ret = calc_stack(filter_string, &nr_parens, &nr_preds, &index);
+	if (ret < 0) {
+		switch (ret) {
+		case MISSING_QUOTE:
+			parse_error(pe, FILT_ERR_MISSING_QUOTE, index);
+			break;
+		case TOO_MANY_OPEN:
+			parse_error(pe, FILT_ERR_TOO_MANY_OPEN, index);
+			break;
+		default:
+			parse_error(pe, FILT_ERR_TOO_MANY_CLOSE, index);
 		}
-		err = check_pred_tree(filter, root);
-		if (err)
-			goto fail;
-
-		/* Optimize the tree */
-		err = fold_pred_tree(filter, root);
-		if (err)
-			goto fail;
-
-		/* We don't set root until we know it works */
-		barrier();
-		filter->root = root;
+		return ret;
 	}
 
-	err = 0;
-fail:
-	__free_pred_stack(&stack);
-	return err;
+	if (!nr_preds) {
+		prog = NULL;
+	} else {
+		prog = predicate_parse(filter_string, nr_parens, nr_preds,
+			       parse_pred, call, pe);
+		if (IS_ERR(prog))
+			return PTR_ERR(prog);
+	}
+	rcu_assign_pointer(filter->prog, prog);
+	return 0;
 }
 
 static inline void event_set_filtered_flag(struct trace_event_file *file)
@@ -1780,72 +1558,53 @@ struct filter_list {
 	struct event_filter	*filter;
 };
 
-static int replace_system_preds(struct trace_subsystem_dir *dir,
+static int process_system_preds(struct trace_subsystem_dir *dir,
 				struct trace_array *tr,
-				struct filter_parse_state *ps,
+				struct filter_parse_error *pe,
 				char *filter_string)
 {
 	struct trace_event_file *file;
 	struct filter_list *filter_item;
+	struct event_filter *filter = NULL;
 	struct filter_list *tmp;
 	LIST_HEAD(filter_list);
 	bool fail = true;
 	int err;
 
 	list_for_each_entry(file, &tr->events, list) {
-		if (file->system != dir)
-			continue;
-
-		/*
-		 * Try to see if the filter can be applied
-		 *  (filter arg is ignored on dry_run)
-		 */
-		err = replace_preds(file->event_call, NULL, ps, true);
-		if (err)
-			event_set_no_set_filter_flag(file);
-		else
-			event_clear_no_set_filter_flag(file);
-	}
-
-	list_for_each_entry(file, &tr->events, list) {
-		struct event_filter *filter;
 
 		if (file->system != dir)
 			continue;
 
-		if (event_no_set_filter_flag(file))
-			continue;
-
-		filter_item = kzalloc(sizeof(*filter_item), GFP_KERNEL);
-		if (!filter_item)
-			goto fail_mem;
-
-		list_add_tail(&filter_item->list, &filter_list);
-
-		filter_item->filter = __alloc_filter();
-		if (!filter_item->filter)
+		filter = kzalloc(sizeof(*filter), GFP_KERNEL);
+		if (!filter)
 			goto fail_mem;
-		filter = filter_item->filter;
 
-		/* Can only fail on no memory */
-		err = replace_filter_string(filter, filter_string);
-		if (err)
+		filter->filter_string = kstrdup(filter_string, GFP_KERNEL);
+		if (!filter->filter_string)
 			goto fail_mem;
 
-		err = replace_preds(file->event_call, filter, ps, false);
+		err = process_preds(file->event_call, filter_string, filter, pe);
 		if (err) {
 			filter_disable(file);
-			parse_error(ps, FILT_ERR_BAD_SUBSYS_FILTER, 0);
-			append_filter_err(ps, filter);
+			parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
+			append_filter_err(pe, filter);
 		} else
 			event_set_filtered_flag(file);
+
+
+		filter_item = kzalloc(sizeof(*filter_item), GFP_KERNEL);
+		if (!filter_item)
+			goto fail_mem;
+
+		list_add_tail(&filter_item->list, &filter_list);
 		/*
 		 * Regardless of if this returned an error, we still
 		 * replace the filter for the call.
 		 */
-		filter = event_filter(file);
-		event_set_filter(file, filter_item->filter);
-		filter_item->filter = filter;
+		filter_item->filter = event_filter(file);
+		event_set_filter(file, filter);
+		filter = NULL;
 
 		fail = false;
 	}
@@ -1871,9 +1630,10 @@ static int replace_system_preds(struct trace_subsystem_dir *dir,
 		list_del(&filter_item->list);
 		kfree(filter_item);
 	}
-	parse_error(ps, FILT_ERR_BAD_SUBSYS_FILTER, 0);
+	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
 	return -EINVAL;
  fail_mem:
+	kfree(filter);
 	/* If any call succeeded, we still need to sync */
 	if (!fail)
 		synchronize_sched();
@@ -1885,47 +1645,42 @@ static int replace_system_preds(struct trace_subsystem_dir *dir,
 	return -ENOMEM;
 }
 
-static int create_filter_start(char *filter_str, bool set_str,
-			       struct filter_parse_state **psp,
+static int create_filter_start(char *filter_string, bool set_str,
+			       struct filter_parse_error **pse,
 			       struct event_filter **filterp)
 {
 	struct event_filter *filter;
-	struct filter_parse_state *ps = NULL;
+	struct filter_parse_error *pe = NULL;
 	int err = 0;
 
-	WARN_ON_ONCE(*psp || *filterp);
+	if (WARN_ON_ONCE(*pse || *filterp))
+		return -EINVAL;
 
-	/* allocate everything, and if any fails, free all and fail */
-	filter = __alloc_filter();
-	if (filter && set_str)
-		err = replace_filter_string(filter, filter_str);
+	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
+	if (filter && set_str) {
+		filter->filter_string = kstrdup(filter_string, GFP_KERNEL);
+		if (!filter->filter_string)
+			err = -ENOMEM;
+	}
 
-	ps = kzalloc(sizeof(*ps), GFP_KERNEL);
+	pe = kzalloc(sizeof(*pe), GFP_KERNEL);
 
-	if (!filter || !ps || err) {
-		kfree(ps);
+	if (!filter || !pe || err) {
+		kfree(pe);
 		__free_filter(filter);
 		return -ENOMEM;
 	}
 
 	/* we're committed to creating a new filter */
 	*filterp = filter;
-	*psp = ps;
+	*pse = pe;
 
-	parse_init(ps, filter_ops, filter_str);
-	err = filter_parse(ps);
-	if (err && set_str)
-		append_filter_err(ps, filter);
-	return err;
+	return 0;
 }
 
-static void create_filter_finish(struct filter_parse_state *ps)
+static void create_filter_finish(struct filter_parse_error *pe)
 {
-	if (ps) {
-		filter_opstack_clear(ps);
-		postfix_clear(ps);
-		kfree(ps);
-	}
+	kfree(pe);
 }
 
 /**
@@ -1945,24 +1700,20 @@ static void create_filter_finish(struct filter_parse_state *ps)
  * freeing it.
  */
 static int create_filter(struct trace_event_call *call,
-			 char *filter_str, bool set_str,
+			 char *filter_string, bool set_str,
 			 struct event_filter **filterp)
 {
+	struct filter_parse_error *pe = NULL;
 	struct event_filter *filter = NULL;
-	struct filter_parse_state *ps = NULL;
 	int err;
 
-	err = create_filter_start(filter_str, set_str, &ps, &filter);
-	if (!err) {
-		err = replace_preds(call, filter, ps, false);
-		if (err && set_str)
-			append_filter_err(ps, filter);
-	}
-	if (err && !set_str) {
-		free_event_filter(filter);
-		filter = NULL;
-	}
-	create_filter_finish(ps);
+	err = create_filter_start(filter_string, set_str, &pe, &filter);
+	if (err)
+		return err;
+
+	err = process_preds(call, filter_string, filter, pe);
+	if (err && set_str)
+		append_filter_err(pe, filter);
 
 	*filterp = filter;
 	return err;
@@ -1989,21 +1740,21 @@ static int create_system_filter(struct trace_subsystem_dir *dir,
 				char *filter_str, struct event_filter **filterp)
 {
 	struct event_filter *filter = NULL;
-	struct filter_parse_state *ps = NULL;
+	struct filter_parse_error *pe = NULL;
 	int err;
 
-	err = create_filter_start(filter_str, true, &ps, &filter);
+	err = create_filter_start(filter_str, true, &pe, &filter);
 	if (!err) {
-		err = replace_system_preds(dir, tr, ps, filter_str);
+		err = process_system_preds(dir, tr, pe, filter_str);
 		if (!err) {
 			/* System filters just show a default message */
 			kfree(filter->filter_string);
 			filter->filter_string = NULL;
 		} else {
-			append_filter_err(ps, filter);
+			append_filter_err(pe, filter);
 		}
 	}
-	create_filter_finish(ps);
+	create_filter_finish(pe);
 
 	*filterp = filter;
 	return err;
@@ -2186,66 +1937,80 @@ static int __ftrace_function_set_filter(int filter, char *buf, int len,
 	return ret;
 }
 
-static int ftrace_function_check_pred(struct filter_pred *pred, int leaf)
+static int ftrace_function_check_pred(struct filter_pred *pred)
 {
 	struct ftrace_event_field *field = pred->field;
 
-	if (leaf) {
-		/*
-		 * Check the leaf predicate for function trace, verify:
-		 *  - only '==' and '!=' is used
-		 *  - the 'ip' field is used
-		 */
-		if ((pred->op != OP_EQ) && (pred->op != OP_NE))
-			return -EINVAL;
+	/*
+	 * Check the predicate for function trace, verify:
+	 *  - only '==' and '!=' is used
+	 *  - the 'ip' field is used
+	 */
+	if ((pred->op != OP_EQ) && (pred->op != OP_NE))
+		return -EINVAL;
 
-		if (strcmp(field->name, "ip"))
-			return -EINVAL;
-	} else {
-		/*
-		 * Check the non leaf predicate for function trace, verify:
-		 *  - only '||' is used
-		*/
-		if (pred->op != OP_OR)
-			return -EINVAL;
-	}
+	if (strcmp(field->name, "ip"))
+		return -EINVAL;
 
 	return 0;
 }
 
-static int ftrace_function_set_filter_cb(enum move_type move,
-					 struct filter_pred *pred,
-					 int *err, void *data)
+static int ftrace_function_set_filter_pred(struct filter_pred *pred,
+					   struct function_filter_data *data)
 {
+	int ret;
+
 	/* Checking the node is valid for function trace. */
-	if ((move != MOVE_DOWN) ||
-	    (pred->left != FILTER_PRED_INVALID)) {
-		*err = ftrace_function_check_pred(pred, 0);
-	} else {
-		*err = ftrace_function_check_pred(pred, 1);
-		if (*err)
-			return WALK_PRED_ABORT;
-
-		*err = __ftrace_function_set_filter(pred->op == OP_EQ,
-						    pred->regex.pattern,
-						    pred->regex.len,
-						    data);
-	}
+	ret = ftrace_function_check_pred(pred);
+	if (ret)
+		return ret;
+
+	return __ftrace_function_set_filter(pred->op == OP_EQ,
+					    pred->regex.pattern,
+					    pred->regex.len,
+					    data);
+}
+
+static bool is_or(struct prog_entry *prog, int i)
+{
+	int target;
+
+	/*
+	 * Only "||" is allowed for function events, thus,
+	 * all true branches should jump to true, and any
+	 * false branch should jump to false.
+	 */
+	target = prog[i].target + 1;
+	/* True and false have NULL preds (all prog entries should jump to one */
+	if (prog[target].pred)
+		return false;
 
-	return (*err) ? WALK_PRED_ABORT : WALK_PRED_DEFAULT;
+	/* prog[target].target is 1 for TRUE, 0 for FALSE */
+	return prog[i].when_to_branch == prog[target].target;
 }
 
 static int ftrace_function_set_filter(struct perf_event *event,
 				      struct event_filter *filter)
 {
+	struct prog_entry *prog = rcu_dereference_protected(filter->prog,
+						lockdep_is_held(&event_mutex));
 	struct function_filter_data data = {
 		.first_filter  = 1,
 		.first_notrace = 1,
 		.ops           = &event->ftrace_ops,
 	};
+	int i;
 
-	return walk_pred_tree(filter->preds, filter->root,
-			      ftrace_function_set_filter_cb, &data);
+	for (i = 0; prog[i].pred; i++) {
+		struct filter_pred *pred = prog[i].pred;
+
+		if (!is_or(prog, i))
+			return -EINVAL;
+
+		if (ftrace_function_set_filter_pred(pred, &data) < 0)
+			return -EINVAL;
+	}
+	return 0;
 }
 #else
 static int ftrace_function_set_filter(struct perf_event *event,
@@ -2388,26 +2153,28 @@ static int test_pred_visited_fn(struct filter_pred *pred, void *event)
 	return 1;
 }
 
-static int test_walk_pred_cb(enum move_type move, struct filter_pred *pred,
-			     int *err, void *data)
+static void update_pred_fn(struct event_filter *filter, char *fields)
 {
-	char *fields = data;
+	struct prog_entry *prog = rcu_dereference_protected(filter->prog,
+						lockdep_is_held(&event_mutex));
+	int i;
 
-	if ((move == MOVE_DOWN) &&
-	    (pred->left == FILTER_PRED_INVALID)) {
+	for (i = 0; prog[i].pred; i++) {
+		struct filter_pred *pred = prog[i].pred;
 		struct ftrace_event_field *field = pred->field;
 
+		WARN_ON_ONCE(!pred->fn);
+
 		if (!field) {
-			WARN(1, "all leafs should have field defined");
-			return WALK_PRED_DEFAULT;
+			WARN_ONCE(1, "all leafs should have field defined %d", i);
+			continue;
 		}
+
 		if (!strchr(fields, *field->name))
-			return WALK_PRED_DEFAULT;
+			continue;
 
-		WARN_ON(!pred->fn);
 		pred->fn = test_pred_visited_fn;
 	}
-	return WALK_PRED_DEFAULT;
 }
 
 static __init int ftrace_test_event_filter(void)
@@ -2431,20 +2198,22 @@ static __init int ftrace_test_event_filter(void)
 			break;
 		}
 
+		/* Needed to dereference filter->prog */
+		mutex_lock(&event_mutex);
 		/*
 		 * The preemption disabling is not really needed for self
 		 * tests, but the rcu dereference will complain without it.
 		 */
 		preempt_disable();
 		if (*d->not_visited)
-			walk_pred_tree(filter->preds, filter->root,
-				       test_walk_pred_cb,
-				       d->not_visited);
+			update_pred_fn(filter, d->not_visited);
 
 		test_pred_visited = 0;
 		err = filter_match_preds(filter, &d->rec);
 		preempt_enable();
 
+		mutex_unlock(&event_mutex);
+
 		__free_filter(filter);
 
 		if (test_pred_visited) {
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1e1558c99d56..0d7b3ffbecc2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -20,15 +20,39 @@
 #include <linux/slab.h>
 #include <linux/stacktrace.h>
 #include <linux/rculist.h>
+#include <linux/tracefs.h>
 
 #include "tracing_map.h"
 #include "trace.h"
 
+#define SYNTH_SYSTEM		"synthetic"
+#define SYNTH_FIELDS_MAX	16
+
+#define STR_VAR_LEN_MAX		32 /* must be multiple of sizeof(u64) */
+
 struct hist_field;
 
-typedef u64 (*hist_field_fn_t) (struct hist_field *field, void *event);
+typedef u64 (*hist_field_fn_t) (struct hist_field *field,
+				struct tracing_map_elt *elt,
+				struct ring_buffer_event *rbe,
+				void *event);
 
 #define HIST_FIELD_OPERANDS_MAX	2
+#define HIST_FIELDS_MAX		(TRACING_MAP_FIELDS_MAX + TRACING_MAP_VARS_MAX)
+#define HIST_ACTIONS_MAX	8
+
+enum field_op_id {
+	FIELD_OP_NONE,
+	FIELD_OP_PLUS,
+	FIELD_OP_MINUS,
+	FIELD_OP_UNARY_MINUS,
+};
+
+struct hist_var {
+	char				*name;
+	struct hist_trigger_data	*hist_data;
+	unsigned int			idx;
+};
 
 struct hist_field {
 	struct ftrace_event_field	*field;
@@ -37,27 +61,49 @@ struct hist_field {
 	unsigned int			size;
 	unsigned int			offset;
 	unsigned int                    is_signed;
+	const char			*type;
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
+	struct hist_trigger_data	*hist_data;
+	struct hist_var			var;
+	enum field_op_id		operator;
+	char				*system;
+	char				*event_name;
+	char				*name;
+	unsigned int			var_idx;
+	unsigned int			var_ref_idx;
+	bool                            read_once;
 };
 
-static u64 hist_field_none(struct hist_field *field, void *event)
+static u64 hist_field_none(struct hist_field *field,
+			   struct tracing_map_elt *elt,
+			   struct ring_buffer_event *rbe,
+			   void *event)
 {
 	return 0;
 }
 
-static u64 hist_field_counter(struct hist_field *field, void *event)
+static u64 hist_field_counter(struct hist_field *field,
+			      struct tracing_map_elt *elt,
+			      struct ring_buffer_event *rbe,
+			      void *event)
 {
 	return 1;
 }
 
-static u64 hist_field_string(struct hist_field *hist_field, void *event)
+static u64 hist_field_string(struct hist_field *hist_field,
+			     struct tracing_map_elt *elt,
+			     struct ring_buffer_event *rbe,
+			     void *event)
 {
 	char *addr = (char *)(event + hist_field->field->offset);
 
 	return (u64)(unsigned long)addr;
 }
 
-static u64 hist_field_dynstring(struct hist_field *hist_field, void *event)
+static u64 hist_field_dynstring(struct hist_field *hist_field,
+				struct tracing_map_elt *elt,
+				struct ring_buffer_event *rbe,
+				void *event)
 {
 	u32 str_item = *(u32 *)(event + hist_field->field->offset);
 	int str_loc = str_item & 0xffff;
@@ -66,24 +112,74 @@ static u64 hist_field_dynstring(struct hist_field *hist_field, void *event)
 	return (u64)(unsigned long)addr;
 }
 
-static u64 hist_field_pstring(struct hist_field *hist_field, void *event)
+static u64 hist_field_pstring(struct hist_field *hist_field,
+			      struct tracing_map_elt *elt,
+			      struct ring_buffer_event *rbe,
+			      void *event)
 {
 	char **addr = (char **)(event + hist_field->field->offset);
 
 	return (u64)(unsigned long)*addr;
 }
 
-static u64 hist_field_log2(struct hist_field *hist_field, void *event)
+static u64 hist_field_log2(struct hist_field *hist_field,
+			   struct tracing_map_elt *elt,
+			   struct ring_buffer_event *rbe,
+			   void *event)
 {
 	struct hist_field *operand = hist_field->operands[0];
 
-	u64 val = operand->fn(operand, event);
+	u64 val = operand->fn(operand, elt, rbe, event);
 
 	return (u64) ilog2(roundup_pow_of_two(val));
 }
 
+static u64 hist_field_plus(struct hist_field *hist_field,
+			   struct tracing_map_elt *elt,
+			   struct ring_buffer_event *rbe,
+			   void *event)
+{
+	struct hist_field *operand1 = hist_field->operands[0];
+	struct hist_field *operand2 = hist_field->operands[1];
+
+	u64 val1 = operand1->fn(operand1, elt, rbe, event);
+	u64 val2 = operand2->fn(operand2, elt, rbe, event);
+
+	return val1 + val2;
+}
+
+static u64 hist_field_minus(struct hist_field *hist_field,
+			    struct tracing_map_elt *elt,
+			    struct ring_buffer_event *rbe,
+			    void *event)
+{
+	struct hist_field *operand1 = hist_field->operands[0];
+	struct hist_field *operand2 = hist_field->operands[1];
+
+	u64 val1 = operand1->fn(operand1, elt, rbe, event);
+	u64 val2 = operand2->fn(operand2, elt, rbe, event);
+
+	return val1 - val2;
+}
+
+static u64 hist_field_unary_minus(struct hist_field *hist_field,
+				  struct tracing_map_elt *elt,
+				  struct ring_buffer_event *rbe,
+				  void *event)
+{
+	struct hist_field *operand = hist_field->operands[0];
+
+	s64 sval = (s64)operand->fn(operand, elt, rbe, event);
+	u64 val = (u64)-sval;
+
+	return val;
+}
+
 #define DEFINE_HIST_FIELD_FN(type)					\
-static u64 hist_field_##type(struct hist_field *hist_field, void *event)\
+	static u64 hist_field_##type(struct hist_field *hist_field,	\
+				     struct tracing_map_elt *elt,	\
+				     struct ring_buffer_event *rbe,	\
+				     void *event)			\
 {									\
 	type *addr = (type *)(event + hist_field->field->offset);	\
 									\
@@ -126,6 +222,19 @@ enum hist_field_flags {
 	HIST_FIELD_FL_SYSCALL		= 1 << 7,
 	HIST_FIELD_FL_STACKTRACE	= 1 << 8,
 	HIST_FIELD_FL_LOG2		= 1 << 9,
+	HIST_FIELD_FL_TIMESTAMP		= 1 << 10,
+	HIST_FIELD_FL_TIMESTAMP_USECS	= 1 << 11,
+	HIST_FIELD_FL_VAR		= 1 << 12,
+	HIST_FIELD_FL_EXPR		= 1 << 13,
+	HIST_FIELD_FL_VAR_REF		= 1 << 14,
+	HIST_FIELD_FL_CPU		= 1 << 15,
+	HIST_FIELD_FL_ALIAS		= 1 << 16,
+};
+
+struct var_defs {
+	unsigned int	n_vars;
+	char		*name[TRACING_MAP_VARS_MAX];
+	char		*expr[TRACING_MAP_VARS_MAX];
 };
 
 struct hist_trigger_attrs {
@@ -133,332 +242,3583 @@ struct hist_trigger_attrs {
 	char		*vals_str;
 	char		*sort_key_str;
 	char		*name;
+	char		*clock;
 	bool		pause;
 	bool		cont;
 	bool		clear;
+	bool		ts_in_usecs;
 	unsigned int	map_bits;
+
+	char		*assignment_str[TRACING_MAP_VARS_MAX];
+	unsigned int	n_assignments;
+
+	char		*action_str[HIST_ACTIONS_MAX];
+	unsigned int	n_actions;
+
+	struct var_defs	var_defs;
+};
+
+struct field_var {
+	struct hist_field	*var;
+	struct hist_field	*val;
+};
+
+struct field_var_hist {
+	struct hist_trigger_data	*hist_data;
+	char				*cmd;
 };
 
 struct hist_trigger_data {
-	struct hist_field               *fields[TRACING_MAP_FIELDS_MAX];
+	struct hist_field               *fields[HIST_FIELDS_MAX];
 	unsigned int			n_vals;
 	unsigned int			n_keys;
 	unsigned int			n_fields;
+	unsigned int			n_vars;
 	unsigned int			key_size;
 	struct tracing_map_sort_key	sort_keys[TRACING_MAP_SORT_KEYS_MAX];
 	unsigned int			n_sort_keys;
 	struct trace_event_file		*event_file;
 	struct hist_trigger_attrs	*attrs;
 	struct tracing_map		*map;
+	bool				enable_timestamps;
+	bool				remove;
+	struct hist_field               *var_refs[TRACING_MAP_VARS_MAX];
+	unsigned int			n_var_refs;
+
+	struct action_data		*actions[HIST_ACTIONS_MAX];
+	unsigned int			n_actions;
+
+	struct hist_field               *synth_var_refs[SYNTH_FIELDS_MAX];
+	unsigned int                    n_synth_var_refs;
+	struct field_var		*field_vars[SYNTH_FIELDS_MAX];
+	unsigned int			n_field_vars;
+	unsigned int			n_field_var_str;
+	struct field_var_hist		*field_var_hists[SYNTH_FIELDS_MAX];
+	unsigned int			n_field_var_hists;
+
+	struct field_var		*max_vars[SYNTH_FIELDS_MAX];
+	unsigned int			n_max_vars;
+	unsigned int			n_max_var_str;
 };
 
-static const char *hist_field_name(struct hist_field *field,
-				   unsigned int level)
-{
-	const char *field_name = "";
+struct synth_field {
+	char *type;
+	char *name;
+	size_t size;
+	bool is_signed;
+	bool is_string;
+};
 
-	if (level > 1)
-		return field_name;
+struct synth_event {
+	struct list_head			list;
+	int					ref;
+	char					*name;
+	struct synth_field			**fields;
+	unsigned int				n_fields;
+	unsigned int				n_u64;
+	struct trace_event_class		class;
+	struct trace_event_call			call;
+	struct tracepoint			*tp;
+};
 
-	if (field->field)
-		field_name = field->field->name;
-	else if (field->flags & HIST_FIELD_FL_LOG2)
-		field_name = hist_field_name(field->operands[0], ++level);
+struct action_data;
+
+typedef void (*action_fn_t) (struct hist_trigger_data *hist_data,
+			     struct tracing_map_elt *elt, void *rec,
+			     struct ring_buffer_event *rbe,
+			     struct action_data *data, u64 *var_ref_vals);
+
+struct action_data {
+	action_fn_t		fn;
+	unsigned int		n_params;
+	char			*params[SYNTH_FIELDS_MAX];
+
+	union {
+		struct {
+			unsigned int		var_ref_idx;
+			char			*match_event;
+			char			*match_event_system;
+			char			*synth_event_name;
+			struct synth_event	*synth_event;
+		} onmatch;
+
+		struct {
+			char			*var_str;
+			char			*fn_name;
+			unsigned int		max_var_ref_idx;
+			struct hist_field	*max_var;
+			struct hist_field	*var;
+		} onmax;
+	};
+};
 
-	if (field_name == NULL)
-		field_name = "";
 
-	return field_name;
+static char last_hist_cmd[MAX_FILTER_STR_VAL];
+static char hist_err_str[MAX_FILTER_STR_VAL];
+
+static void last_cmd_set(char *str)
+{
+	if (!str)
+		return;
+
+	strncpy(last_hist_cmd, str, MAX_FILTER_STR_VAL - 1);
 }
 
-static hist_field_fn_t select_value_fn(int field_size, int field_is_signed)
+static void hist_err(char *str, char *var)
 {
-	hist_field_fn_t fn = NULL;
+	int maxlen = MAX_FILTER_STR_VAL - 1;
 
-	switch (field_size) {
-	case 8:
-		if (field_is_signed)
-			fn = hist_field_s64;
-		else
-			fn = hist_field_u64;
-		break;
-	case 4:
-		if (field_is_signed)
-			fn = hist_field_s32;
-		else
-			fn = hist_field_u32;
-		break;
-	case 2:
-		if (field_is_signed)
-			fn = hist_field_s16;
-		else
-			fn = hist_field_u16;
-		break;
-	case 1:
-		if (field_is_signed)
-			fn = hist_field_s8;
-		else
-			fn = hist_field_u8;
-		break;
-	}
+	if (!str)
+		return;
 
-	return fn;
+	if (strlen(hist_err_str))
+		return;
+
+	if (!var)
+		var = "";
+
+	if (strlen(hist_err_str) + strlen(str) + strlen(var) > maxlen)
+		return;
+
+	strcat(hist_err_str, str);
+	strcat(hist_err_str, var);
 }
 
-static int parse_map_size(char *str)
+static void hist_err_event(char *str, char *system, char *event, char *var)
 {
-	unsigned long size, map_bits;
-	int ret;
+	char err[MAX_FILTER_STR_VAL];
 
-	strsep(&str, "=");
-	if (!str) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (system && var)
+		snprintf(err, MAX_FILTER_STR_VAL, "%s.%s.%s", system, event, var);
+	else if (system)
+		snprintf(err, MAX_FILTER_STR_VAL, "%s.%s", system, event);
+	else
+		strncpy(err, var, MAX_FILTER_STR_VAL);
 
-	ret = kstrtoul(str, 0, &size);
-	if (ret)
-		goto out;
+	hist_err(str, err);
+}
 
-	map_bits = ilog2(roundup_pow_of_two(size));
-	if (map_bits < TRACING_MAP_BITS_MIN ||
-	    map_bits > TRACING_MAP_BITS_MAX)
-		ret = -EINVAL;
-	else
-		ret = map_bits;
- out:
-	return ret;
+static void hist_err_clear(void)
+{
+	hist_err_str[0] = '\0';
 }
 
-static void destroy_hist_trigger_attrs(struct hist_trigger_attrs *attrs)
+static bool have_hist_err(void)
 {
-	if (!attrs)
-		return;
+	if (strlen(hist_err_str))
+		return true;
 
-	kfree(attrs->name);
-	kfree(attrs->sort_key_str);
-	kfree(attrs->keys_str);
-	kfree(attrs->vals_str);
-	kfree(attrs);
+	return false;
 }
 
-static struct hist_trigger_attrs *parse_hist_trigger_attrs(char *trigger_str)
-{
-	struct hist_trigger_attrs *attrs;
-	int ret = 0;
+static LIST_HEAD(synth_event_list);
+static DEFINE_MUTEX(synth_event_mutex);
 
-	attrs = kzalloc(sizeof(*attrs), GFP_KERNEL);
-	if (!attrs)
-		return ERR_PTR(-ENOMEM);
+struct synth_trace_event {
+	struct trace_entry	ent;
+	u64			fields[];
+};
 
-	while (trigger_str) {
-		char *str = strsep(&trigger_str, ":");
+static int synth_event_define_fields(struct trace_event_call *call)
+{
+	struct synth_trace_event trace;
+	int offset = offsetof(typeof(trace), fields);
+	struct synth_event *event = call->data;
+	unsigned int i, size, n_u64;
+	char *name, *type;
+	bool is_signed;
+	int ret = 0;
 
-		if ((strncmp(str, "key=", strlen("key=")) == 0) ||
-		    (strncmp(str, "keys=", strlen("keys=")) == 0))
-			attrs->keys_str = kstrdup(str, GFP_KERNEL);
-		else if ((strncmp(str, "val=", strlen("val=")) == 0) ||
-			 (strncmp(str, "vals=", strlen("vals=")) == 0) ||
-			 (strncmp(str, "values=", strlen("values=")) == 0))
-			attrs->vals_str = kstrdup(str, GFP_KERNEL);
-		else if (strncmp(str, "sort=", strlen("sort=")) == 0)
-			attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
-		else if (strncmp(str, "name=", strlen("name=")) == 0)
-			attrs->name = kstrdup(str, GFP_KERNEL);
-		else if (strcmp(str, "pause") == 0)
-			attrs->pause = true;
-		else if ((strcmp(str, "cont") == 0) ||
-			 (strcmp(str, "continue") == 0))
-			attrs->cont = true;
-		else if (strcmp(str, "clear") == 0)
-			attrs->clear = true;
-		else if (strncmp(str, "size=", strlen("size=")) == 0) {
-			int map_bits = parse_map_size(str);
+	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
+		size = event->fields[i]->size;
+		is_signed = event->fields[i]->is_signed;
+		type = event->fields[i]->type;
+		name = event->fields[i]->name;
+		ret = trace_define_field(call, type, name, offset, size,
+					 is_signed, FILTER_OTHER);
+		if (ret)
+			break;
 
-			if (map_bits < 0) {
-				ret = map_bits;
-				goto free;
-			}
-			attrs->map_bits = map_bits;
+		if (event->fields[i]->is_string) {
+			offset += STR_VAR_LEN_MAX;
+			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 		} else {
-			ret = -EINVAL;
-			goto free;
+			offset += sizeof(u64);
+			n_u64++;
 		}
 	}
 
-	if (!attrs->keys_str) {
-		ret = -EINVAL;
-		goto free;
-	}
+	event->n_u64 = n_u64;
 
-	return attrs;
- free:
-	destroy_hist_trigger_attrs(attrs);
+	return ret;
+}
 
-	return ERR_PTR(ret);
+static bool synth_field_signed(char *type)
+{
+	if (strncmp(type, "u", 1) == 0)
+		return false;
+
+	return true;
 }
 
-static inline void save_comm(char *comm, struct task_struct *task)
+static int synth_field_is_string(char *type)
 {
-	if (!task->pid) {
-		strcpy(comm, "<idle>");
-		return;
-	}
+	if (strstr(type, "char[") != NULL)
+		return true;
 
-	if (WARN_ON_ONCE(task->pid < 0)) {
-		strcpy(comm, "<XXX>");
-		return;
-	}
+	return false;
+}
 
-	memcpy(comm, task->comm, TASK_COMM_LEN);
+static int synth_field_string_size(char *type)
+{
+	char buf[4], *end, *start;
+	unsigned int len;
+	int size, err;
+
+	start = strstr(type, "char[");
+	if (start == NULL)
+		return -EINVAL;
+	start += strlen("char[");
+
+	end = strchr(type, ']');
+	if (!end || end < start)
+		return -EINVAL;
+
+	len = end - start;
+	if (len > 3)
+		return -EINVAL;
+
+	strncpy(buf, start, len);
+	buf[len] = '\0';
+
+	err = kstrtouint(buf, 0, &size);
+	if (err)
+		return err;
+
+	if (size > STR_VAR_LEN_MAX)
+		return -EINVAL;
+
+	return size;
 }
 
-static void hist_trigger_elt_comm_free(struct tracing_map_elt *elt)
+static int synth_field_size(char *type)
 {
-	kfree((char *)elt->private_data);
+	int size = 0;
+
+	if (strcmp(type, "s64") == 0)
+		size = sizeof(s64);
+	else if (strcmp(type, "u64") == 0)
+		size = sizeof(u64);
+	else if (strcmp(type, "s32") == 0)
+		size = sizeof(s32);
+	else if (strcmp(type, "u32") == 0)
+		size = sizeof(u32);
+	else if (strcmp(type, "s16") == 0)
+		size = sizeof(s16);
+	else if (strcmp(type, "u16") == 0)
+		size = sizeof(u16);
+	else if (strcmp(type, "s8") == 0)
+		size = sizeof(s8);
+	else if (strcmp(type, "u8") == 0)
+		size = sizeof(u8);
+	else if (strcmp(type, "char") == 0)
+		size = sizeof(char);
+	else if (strcmp(type, "unsigned char") == 0)
+		size = sizeof(unsigned char);
+	else if (strcmp(type, "int") == 0)
+		size = sizeof(int);
+	else if (strcmp(type, "unsigned int") == 0)
+		size = sizeof(unsigned int);
+	else if (strcmp(type, "long") == 0)
+		size = sizeof(long);
+	else if (strcmp(type, "unsigned long") == 0)
+		size = sizeof(unsigned long);
+	else if (strcmp(type, "pid_t") == 0)
+		size = sizeof(pid_t);
+	else if (synth_field_is_string(type))
+		size = synth_field_string_size(type);
+
+	return size;
 }
 
-static int hist_trigger_elt_comm_alloc(struct tracing_map_elt *elt)
+static const char *synth_field_fmt(char *type)
 {
-	struct hist_trigger_data *hist_data = elt->map->private_data;
-	struct hist_field *key_field;
-	unsigned int i;
+	const char *fmt = "%llu";
+
+	if (strcmp(type, "s64") == 0)
+		fmt = "%lld";
+	else if (strcmp(type, "u64") == 0)
+		fmt = "%llu";
+	else if (strcmp(type, "s32") == 0)
+		fmt = "%d";
+	else if (strcmp(type, "u32") == 0)
+		fmt = "%u";
+	else if (strcmp(type, "s16") == 0)
+		fmt = "%d";
+	else if (strcmp(type, "u16") == 0)
+		fmt = "%u";
+	else if (strcmp(type, "s8") == 0)
+		fmt = "%d";
+	else if (strcmp(type, "u8") == 0)
+		fmt = "%u";
+	else if (strcmp(type, "char") == 0)
+		fmt = "%d";
+	else if (strcmp(type, "unsigned char") == 0)
+		fmt = "%u";
+	else if (strcmp(type, "int") == 0)
+		fmt = "%d";
+	else if (strcmp(type, "unsigned int") == 0)
+		fmt = "%u";
+	else if (strcmp(type, "long") == 0)
+		fmt = "%ld";
+	else if (strcmp(type, "unsigned long") == 0)
+		fmt = "%lu";
+	else if (strcmp(type, "pid_t") == 0)
+		fmt = "%d";
+	else if (synth_field_is_string(type))
+		fmt = "%s";
+
+	return fmt;
+}
 
-	for_each_hist_key_field(i, hist_data) {
-		key_field = hist_data->fields[i];
+static enum print_line_t print_synth_event(struct trace_iterator *iter,
+					   int flags,
+					   struct trace_event *event)
+{
+	struct trace_array *tr = iter->tr;
+	struct trace_seq *s = &iter->seq;
+	struct synth_trace_event *entry;
+	struct synth_event *se;
+	unsigned int i, n_u64;
+	char print_fmt[32];
+	const char *fmt;
 
-		if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
-			unsigned int size = TASK_COMM_LEN + 1;
+	entry = (struct synth_trace_event *)iter->ent;
+	se = container_of(event, struct synth_event, call.event);
 
-			elt->private_data = kzalloc(size, GFP_KERNEL);
-			if (!elt->private_data)
-				return -ENOMEM;
-			break;
+	trace_seq_printf(s, "%s: ", se->name);
+
+	for (i = 0, n_u64 = 0; i < se->n_fields; i++) {
+		if (trace_seq_has_overflowed(s))
+			goto end;
+
+		fmt = synth_field_fmt(se->fields[i]->type);
+
+		/* parameter types */
+		if (tr->trace_flags & TRACE_ITER_VERBOSE)
+			trace_seq_printf(s, "%s ", fmt);
+
+		snprintf(print_fmt, sizeof(print_fmt), "%%s=%s%%s", fmt);
+
+		/* parameter values */
+		if (se->fields[i]->is_string) {
+			trace_seq_printf(s, print_fmt, se->fields[i]->name,
+					 (char *)&entry->fields[n_u64],
+					 i == se->n_fields - 1 ? "" : " ");
+			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
+		} else {
+			trace_seq_printf(s, print_fmt, se->fields[i]->name,
+					 entry->fields[n_u64],
+					 i == se->n_fields - 1 ? "" : " ");
+			n_u64++;
 		}
 	}
+end:
+	trace_seq_putc(s, '\n');
 
-	return 0;
+	return trace_handle_return(s);
 }
 
-static void hist_trigger_elt_comm_copy(struct tracing_map_elt *to,
-				       struct tracing_map_elt *from)
+static struct trace_event_functions synth_event_funcs = {
+	.trace		= print_synth_event
+};
+
+static notrace void trace_event_raw_event_synth(void *__data,
+						u64 *var_ref_vals,
+						unsigned int var_ref_idx)
 {
-	char *comm_from = from->private_data;
-	char *comm_to = to->private_data;
+	struct trace_event_file *trace_file = __data;
+	struct synth_trace_event *entry;
+	struct trace_event_buffer fbuffer;
+	struct ring_buffer *buffer;
+	struct synth_event *event;
+	unsigned int i, n_u64;
+	int fields_size = 0;
+
+	event = trace_file->event_call->data;
+
+	if (trace_trigger_soft_disabled(trace_file))
+		return;
+
+	fields_size = event->n_u64 * sizeof(u64);
+
+	/*
+	 * Avoid ring buffer recursion detection, as this event
+	 * is being performed within another event.
+	 */
+	buffer = trace_file->tr->trace_buffer.buffer;
+	ring_buffer_nest_start(buffer);
+
+	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
+					   sizeof(*entry) + fields_size);
+	if (!entry)
+		goto out;
+
+	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
+		if (event->fields[i]->is_string) {
+			char *str_val = (char *)(long)var_ref_vals[var_ref_idx + i];
+			char *str_field = (char *)&entry->fields[n_u64];
+
+			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
+			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
+		} else {
+			entry->fields[n_u64] = var_ref_vals[var_ref_idx + i];
+			n_u64++;
+		}
+	}
 
-	if (comm_from)
-		memcpy(comm_to, comm_from, TASK_COMM_LEN + 1);
+	trace_event_buffer_commit(&fbuffer);
+out:
+	ring_buffer_nest_end(buffer);
 }
 
-static void hist_trigger_elt_comm_init(struct tracing_map_elt *elt)
+static void free_synth_event_print_fmt(struct trace_event_call *call)
 {
-	char *comm = elt->private_data;
-
-	if (comm)
-		save_comm(comm, current);
+	if (call) {
+		kfree(call->print_fmt);
+		call->print_fmt = NULL;
+	}
 }
 
-static const struct tracing_map_ops hist_trigger_elt_comm_ops = {
-	.elt_alloc	= hist_trigger_elt_comm_alloc,
-	.elt_copy	= hist_trigger_elt_comm_copy,
-	.elt_free	= hist_trigger_elt_comm_free,
-	.elt_init	= hist_trigger_elt_comm_init,
-};
+static int __set_synth_event_print_fmt(struct synth_event *event,
+				       char *buf, int len)
+{
+	const char *fmt;
+	int pos = 0;
+	int i;
+
+	/* When len=0, we just calculate the needed length */
+#define LEN_OR_ZERO (len ? len - pos : 0)
+
+	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
+	for (i = 0; i < event->n_fields; i++) {
+		fmt = synth_field_fmt(event->fields[i]->type);
+		pos += snprintf(buf + pos, LEN_OR_ZERO, "%s=%s%s",
+				event->fields[i]->name, fmt,
+				i == event->n_fields - 1 ? "" : ", ");
+	}
+	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
 
-static void destroy_hist_field(struct hist_field *hist_field,
-			       unsigned int level)
+	for (i = 0; i < event->n_fields; i++) {
+		pos += snprintf(buf + pos, LEN_OR_ZERO,
+				", REC->%s", event->fields[i]->name);
+	}
+
+#undef LEN_OR_ZERO
+
+	/* return the length of print_fmt */
+	return pos;
+}
+
+static int set_synth_event_print_fmt(struct trace_event_call *call)
 {
-	unsigned int i;
+	struct synth_event *event = call->data;
+	char *print_fmt;
+	int len;
 
-	if (level > 2)
-		return;
+	/* First: called with 0 length to calculate the needed length */
+	len = __set_synth_event_print_fmt(event, NULL, 0);
 
-	if (!hist_field)
-		return;
+	print_fmt = kmalloc(len + 1, GFP_KERNEL);
+	if (!print_fmt)
+		return -ENOMEM;
 
-	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++)
-		destroy_hist_field(hist_field->operands[i], level + 1);
+	/* Second: actually write the @print_fmt */
+	__set_synth_event_print_fmt(event, print_fmt, len + 1);
+	call->print_fmt = print_fmt;
 
-	kfree(hist_field);
+	return 0;
 }
 
-static struct hist_field *create_hist_field(struct ftrace_event_field *field,
-					    unsigned long flags)
+static void free_synth_field(struct synth_field *field)
 {
-	struct hist_field *hist_field;
+	kfree(field->type);
+	kfree(field->name);
+	kfree(field);
+}
 
-	if (field && is_function_field(field))
-		return NULL;
+static struct synth_field *parse_synth_field(char *field_type,
+					     char *field_name)
+{
+	struct synth_field *field;
+	int len, ret = 0;
+	char *array;
 
-	hist_field = kzalloc(sizeof(struct hist_field), GFP_KERNEL);
-	if (!hist_field)
-		return NULL;
+	if (field_type[0] == ';')
+		field_type++;
 
-	if (flags & HIST_FIELD_FL_HITCOUNT) {
-		hist_field->fn = hist_field_counter;
-		goto out;
-	}
+	len = strlen(field_name);
+	if (field_name[len - 1] == ';')
+		field_name[len - 1] = '\0';
 
-	if (flags & HIST_FIELD_FL_STACKTRACE) {
-		hist_field->fn = hist_field_none;
-		goto out;
+	field = kzalloc(sizeof(*field), GFP_KERNEL);
+	if (!field)
+		return ERR_PTR(-ENOMEM);
+
+	len = strlen(field_type) + 1;
+	array = strchr(field_name, '[');
+	if (array)
+		len += strlen(array);
+	field->type = kzalloc(len, GFP_KERNEL);
+	if (!field->type) {
+		ret = -ENOMEM;
+		goto free;
+	}
+	strcat(field->type, field_type);
+	if (array) {
+		strcat(field->type, array);
+		*array = '\0';
 	}
 
-	if (flags & HIST_FIELD_FL_LOG2) {
+	field->size = synth_field_size(field->type);
+	if (!field->size) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	if (synth_field_is_string(field->type))
+		field->is_string = true;
+
+	field->is_signed = synth_field_signed(field->type);
+
+	field->name = kstrdup(field_name, GFP_KERNEL);
+	if (!field->name) {
+		ret = -ENOMEM;
+		goto free;
+	}
+ out:
+	return field;
+ free:
+	free_synth_field(field);
+	field = ERR_PTR(ret);
+	goto out;
+}
+
+static void free_synth_tracepoint(struct tracepoint *tp)
+{
+	if (!tp)
+		return;
+
+	kfree(tp->name);
+	kfree(tp);
+}
+
+static struct tracepoint *alloc_synth_tracepoint(char *name)
+{
+	struct tracepoint *tp;
+
+	tp = kzalloc(sizeof(*tp), GFP_KERNEL);
+	if (!tp)
+		return ERR_PTR(-ENOMEM);
+
+	tp->name = kstrdup(name, GFP_KERNEL);
+	if (!tp->name) {
+		kfree(tp);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return tp;
+}
+
+typedef void (*synth_probe_func_t) (void *__data, u64 *var_ref_vals,
+				    unsigned int var_ref_idx);
+
+static inline void trace_synth(struct synth_event *event, u64 *var_ref_vals,
+			       unsigned int var_ref_idx)
+{
+	struct tracepoint *tp = event->tp;
+
+	if (unlikely(atomic_read(&tp->key.enabled) > 0)) {
+		struct tracepoint_func *probe_func_ptr;
+		synth_probe_func_t probe_func;
+		void *__data;
+
+		if (!(cpu_online(raw_smp_processor_id())))
+			return;
+
+		probe_func_ptr = rcu_dereference_sched((tp)->funcs);
+		if (probe_func_ptr) {
+			do {
+				probe_func = probe_func_ptr->func;
+				__data = probe_func_ptr->data;
+				probe_func(__data, var_ref_vals, var_ref_idx);
+			} while ((++probe_func_ptr)->func);
+		}
+	}
+}
+
+static struct synth_event *find_synth_event(const char *name)
+{
+	struct synth_event *event;
+
+	list_for_each_entry(event, &synth_event_list, list) {
+		if (strcmp(event->name, name) == 0)
+			return event;
+	}
+
+	return NULL;
+}
+
+static int register_synth_event(struct synth_event *event)
+{
+	struct trace_event_call *call = &event->call;
+	int ret = 0;
+
+	event->call.class = &event->class;
+	event->class.system = kstrdup(SYNTH_SYSTEM, GFP_KERNEL);
+	if (!event->class.system) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	event->tp = alloc_synth_tracepoint(event->name);
+	if (IS_ERR(event->tp)) {
+		ret = PTR_ERR(event->tp);
+		event->tp = NULL;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&call->class->fields);
+	call->event.funcs = &synth_event_funcs;
+	call->class->define_fields = synth_event_define_fields;
+
+	ret = register_trace_event(&call->event);
+	if (!ret) {
+		ret = -ENODEV;
+		goto out;
+	}
+	call->flags = TRACE_EVENT_FL_TRACEPOINT;
+	call->class->reg = trace_event_reg;
+	call->class->probe = trace_event_raw_event_synth;
+	call->data = event;
+	call->tp = event->tp;
+
+	ret = trace_add_event_call(call);
+	if (ret) {
+		pr_warn("Failed to register synthetic event: %s\n",
+			trace_event_name(call));
+		goto err;
+	}
+
+	ret = set_synth_event_print_fmt(call);
+	if (ret < 0) {
+		trace_remove_event_call(call);
+		goto err;
+	}
+ out:
+	return ret;
+ err:
+	unregister_trace_event(&call->event);
+	goto out;
+}
+
+static int unregister_synth_event(struct synth_event *event)
+{
+	struct trace_event_call *call = &event->call;
+	int ret;
+
+	ret = trace_remove_event_call(call);
+
+	return ret;
+}
+
+static void free_synth_event(struct synth_event *event)
+{
+	unsigned int i;
+
+	if (!event)
+		return;
+
+	for (i = 0; i < event->n_fields; i++)
+		free_synth_field(event->fields[i]);
+
+	kfree(event->fields);
+	kfree(event->name);
+	kfree(event->class.system);
+	free_synth_tracepoint(event->tp);
+	free_synth_event_print_fmt(&event->call);
+	kfree(event);
+}
+
+static struct synth_event *alloc_synth_event(char *event_name, int n_fields,
+					     struct synth_field **fields)
+{
+	struct synth_event *event;
+	unsigned int i;
+
+	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	if (!event) {
+		event = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	event->name = kstrdup(event_name, GFP_KERNEL);
+	if (!event->name) {
+		kfree(event);
+		event = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	event->fields = kcalloc(n_fields, sizeof(*event->fields), GFP_KERNEL);
+	if (!event->fields) {
+		free_synth_event(event);
+		event = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	for (i = 0; i < n_fields; i++)
+		event->fields[i] = fields[i];
+
+	event->n_fields = n_fields;
+ out:
+	return event;
+}
+
+static void action_trace(struct hist_trigger_data *hist_data,
+			 struct tracing_map_elt *elt, void *rec,
+			 struct ring_buffer_event *rbe,
+			 struct action_data *data, u64 *var_ref_vals)
+{
+	struct synth_event *event = data->onmatch.synth_event;
+
+	trace_synth(event, var_ref_vals, data->onmatch.var_ref_idx);
+}
+
+struct hist_var_data {
+	struct list_head list;
+	struct hist_trigger_data *hist_data;
+};
+
+static void add_or_delete_synth_event(struct synth_event *event, int delete)
+{
+	if (delete)
+		free_synth_event(event);
+	else {
+		mutex_lock(&synth_event_mutex);
+		if (!find_synth_event(event->name))
+			list_add(&event->list, &synth_event_list);
+		else
+			free_synth_event(event);
+		mutex_unlock(&synth_event_mutex);
+	}
+}
+
+static int create_synth_event(int argc, char **argv)
+{
+	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
+	struct synth_event *event = NULL;
+	bool delete_event = false;
+	int i, n_fields = 0, ret = 0;
+	char *name;
+
+	mutex_lock(&synth_event_mutex);
+
+	/*
+	 * Argument syntax:
+	 *  - Add synthetic event: <event_name> field[;field] ...
+	 *  - Remove synthetic event: !<event_name> field[;field] ...
+	 *      where 'field' = type field_name
+	 */
+	if (argc < 1) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	name = argv[0];
+	if (name[0] == '!') {
+		delete_event = true;
+		name++;
+	}
+
+	event = find_synth_event(name);
+	if (event) {
+		if (delete_event) {
+			if (event->ref) {
+				event = NULL;
+				ret = -EBUSY;
+				goto out;
+			}
+			list_del(&event->list);
+			goto out;
+		}
+		event = NULL;
+		ret = -EEXIST;
+		goto out;
+	} else if (delete_event)
+		goto out;
+
+	if (argc < 2) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (i = 1; i < argc - 1; i++) {
+		if (strcmp(argv[i], ";") == 0)
+			continue;
+		if (n_fields == SYNTH_FIELDS_MAX) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		field = parse_synth_field(argv[i], argv[i + 1]);
+		if (IS_ERR(field)) {
+			ret = PTR_ERR(field);
+			goto err;
+		}
+		fields[n_fields] = field;
+		i++; n_fields++;
+	}
+
+	if (i < argc) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	event = alloc_synth_event(name, n_fields, fields);
+	if (IS_ERR(event)) {
+		ret = PTR_ERR(event);
+		event = NULL;
+		goto err;
+	}
+ out:
+	mutex_unlock(&synth_event_mutex);
+
+	if (event) {
+		if (delete_event) {
+			ret = unregister_synth_event(event);
+			add_or_delete_synth_event(event, !ret);
+		} else {
+			ret = register_synth_event(event);
+			add_or_delete_synth_event(event, ret);
+		}
+	}
+
+	return ret;
+ err:
+	mutex_unlock(&synth_event_mutex);
+
+	for (i = 0; i < n_fields; i++)
+		free_synth_field(fields[i]);
+	free_synth_event(event);
+
+	return ret;
+}
+
+static int release_all_synth_events(void)
+{
+	struct list_head release_events;
+	struct synth_event *event, *e;
+	int ret = 0;
+
+	INIT_LIST_HEAD(&release_events);
+
+	mutex_lock(&synth_event_mutex);
+
+	list_for_each_entry(event, &synth_event_list, list) {
+		if (event->ref) {
+			mutex_unlock(&synth_event_mutex);
+			return -EBUSY;
+		}
+	}
+
+	list_splice_init(&event->list, &release_events);
+
+	mutex_unlock(&synth_event_mutex);
+
+	list_for_each_entry_safe(event, e, &release_events, list) {
+		list_del(&event->list);
+
+		ret = unregister_synth_event(event);
+		add_or_delete_synth_event(event, !ret);
+	}
+
+	return ret;
+}
+
+
+static void *synth_events_seq_start(struct seq_file *m, loff_t *pos)
+{
+	mutex_lock(&synth_event_mutex);
+
+	return seq_list_start(&synth_event_list, *pos);
+}
+
+static void *synth_events_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return seq_list_next(v, &synth_event_list, pos);
+}
+
+static void synth_events_seq_stop(struct seq_file *m, void *v)
+{
+	mutex_unlock(&synth_event_mutex);
+}
+
+static int synth_events_seq_show(struct seq_file *m, void *v)
+{
+	struct synth_field *field;
+	struct synth_event *event = v;
+	unsigned int i;
+
+	seq_printf(m, "%s\t", event->name);
+
+	for (i = 0; i < event->n_fields; i++) {
+		field = event->fields[i];
+
+		/* parameter values */
+		seq_printf(m, "%s %s%s", field->type, field->name,
+			   i == event->n_fields - 1 ? "" : "; ");
+	}
+
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static const struct seq_operations synth_events_seq_op = {
+	.start  = synth_events_seq_start,
+	.next   = synth_events_seq_next,
+	.stop   = synth_events_seq_stop,
+	.show   = synth_events_seq_show
+};
+
+static int synth_events_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
+		ret = release_all_synth_events();
+		if (ret < 0)
+			return ret;
+	}
+
+	return seq_open(file, &synth_events_seq_op);
+}
+
+static ssize_t synth_events_write(struct file *file,
+				  const char __user *buffer,
+				  size_t count, loff_t *ppos)
+{
+	return trace_parse_run_command(file, buffer, count, ppos,
+				       create_synth_event);
+}
+
+static const struct file_operations synth_events_fops = {
+	.open           = synth_events_open,
+	.write		= synth_events_write,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = seq_release,
+};
+
+static u64 hist_field_timestamp(struct hist_field *hist_field,
+				struct tracing_map_elt *elt,
+				struct ring_buffer_event *rbe,
+				void *event)
+{
+	struct hist_trigger_data *hist_data = hist_field->hist_data;
+	struct trace_array *tr = hist_data->event_file->tr;
+
+	u64 ts = ring_buffer_event_time_stamp(rbe);
+
+	if (hist_data->attrs->ts_in_usecs && trace_clock_in_ns(tr))
+		ts = ns2usecs(ts);
+
+	return ts;
+}
+
+static u64 hist_field_cpu(struct hist_field *hist_field,
+			  struct tracing_map_elt *elt,
+			  struct ring_buffer_event *rbe,
+			  void *event)
+{
+	int cpu = smp_processor_id();
+
+	return cpu;
+}
+
+static struct hist_field *
+check_field_for_var_ref(struct hist_field *hist_field,
+			struct hist_trigger_data *var_data,
+			unsigned int var_idx)
+{
+	struct hist_field *found = NULL;
+
+	if (hist_field && hist_field->flags & HIST_FIELD_FL_VAR_REF) {
+		if (hist_field->var.idx == var_idx &&
+		    hist_field->var.hist_data == var_data) {
+			found = hist_field;
+		}
+	}
+
+	return found;
+}
+
+static struct hist_field *
+check_field_for_var_refs(struct hist_trigger_data *hist_data,
+			 struct hist_field *hist_field,
+			 struct hist_trigger_data *var_data,
+			 unsigned int var_idx,
+			 unsigned int level)
+{
+	struct hist_field *found = NULL;
+	unsigned int i;
+
+	if (level > 3)
+		return found;
+
+	if (!hist_field)
+		return found;
+
+	found = check_field_for_var_ref(hist_field, var_data, var_idx);
+	if (found)
+		return found;
+
+	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++) {
+		struct hist_field *operand;
+
+		operand = hist_field->operands[i];
+		found = check_field_for_var_refs(hist_data, operand, var_data,
+						 var_idx, level + 1);
+		if (found)
+			return found;
+	}
+
+	return found;
+}
+
+static struct hist_field *find_var_ref(struct hist_trigger_data *hist_data,
+				       struct hist_trigger_data *var_data,
+				       unsigned int var_idx)
+{
+	struct hist_field *hist_field, *found = NULL;
+	unsigned int i;
+
+	for_each_hist_field(i, hist_data) {
+		hist_field = hist_data->fields[i];
+		found = check_field_for_var_refs(hist_data, hist_field,
+						 var_data, var_idx, 0);
+		if (found)
+			return found;
+	}
+
+	for (i = 0; i < hist_data->n_synth_var_refs; i++) {
+		hist_field = hist_data->synth_var_refs[i];
+		found = check_field_for_var_refs(hist_data, hist_field,
+						 var_data, var_idx, 0);
+		if (found)
+			return found;
+	}
+
+	return found;
+}
+
+static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
+					   unsigned int var_idx)
+{
+	struct trace_array *tr = hist_data->event_file->tr;
+	struct hist_field *found = NULL;
+	struct hist_var_data *var_data;
+
+	list_for_each_entry(var_data, &tr->hist_vars, list) {
+		if (var_data->hist_data == hist_data)
+			continue;
+		found = find_var_ref(var_data->hist_data, hist_data, var_idx);
+		if (found)
+			break;
+	}
+
+	return found;
+}
+
+static bool check_var_refs(struct hist_trigger_data *hist_data)
+{
+	struct hist_field *field;
+	bool found = false;
+	int i;
+
+	for_each_hist_field(i, hist_data) {
+		field = hist_data->fields[i];
+		if (field && field->flags & HIST_FIELD_FL_VAR) {
+			if (find_any_var_ref(hist_data, field->var.idx)) {
+				found = true;
+				break;
+			}
+		}
+	}
+
+	return found;
+}
+
+static struct hist_var_data *find_hist_vars(struct hist_trigger_data *hist_data)
+{
+	struct trace_array *tr = hist_data->event_file->tr;
+	struct hist_var_data *var_data, *found = NULL;
+
+	list_for_each_entry(var_data, &tr->hist_vars, list) {
+		if (var_data->hist_data == hist_data) {
+			found = var_data;
+			break;
+		}
+	}
+
+	return found;
+}
+
+static bool field_has_hist_vars(struct hist_field *hist_field,
+				unsigned int level)
+{
+	int i;
+
+	if (level > 3)
+		return false;
+
+	if (!hist_field)
+		return false;
+
+	if (hist_field->flags & HIST_FIELD_FL_VAR ||
+	    hist_field->flags & HIST_FIELD_FL_VAR_REF)
+		return true;
+
+	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++) {
+		struct hist_field *operand;
+
+		operand = hist_field->operands[i];
+		if (field_has_hist_vars(operand, level + 1))
+			return true;
+	}
+
+	return false;
+}
+
+static bool has_hist_vars(struct hist_trigger_data *hist_data)
+{
+	struct hist_field *hist_field;
+	int i;
+
+	for_each_hist_field(i, hist_data) {
+		hist_field = hist_data->fields[i];
+		if (field_has_hist_vars(hist_field, 0))
+			return true;
+	}
+
+	return false;
+}
+
+static int save_hist_vars(struct hist_trigger_data *hist_data)
+{
+	struct trace_array *tr = hist_data->event_file->tr;
+	struct hist_var_data *var_data;
+
+	var_data = find_hist_vars(hist_data);
+	if (var_data)
+		return 0;
+
+	if (trace_array_get(tr) < 0)
+		return -ENODEV;
+
+	var_data = kzalloc(sizeof(*var_data), GFP_KERNEL);
+	if (!var_data) {
+		trace_array_put(tr);
+		return -ENOMEM;
+	}
+
+	var_data->hist_data = hist_data;
+	list_add(&var_data->list, &tr->hist_vars);
+
+	return 0;
+}
+
+static void remove_hist_vars(struct hist_trigger_data *hist_data)
+{
+	struct trace_array *tr = hist_data->event_file->tr;
+	struct hist_var_data *var_data;
+
+	var_data = find_hist_vars(hist_data);
+	if (!var_data)
+		return;
+
+	if (WARN_ON(check_var_refs(hist_data)))
+		return;
+
+	list_del(&var_data->list);
+
+	kfree(var_data);
+
+	trace_array_put(tr);
+}
+
+static struct hist_field *find_var_field(struct hist_trigger_data *hist_data,
+					 const char *var_name)
+{
+	struct hist_field *hist_field, *found = NULL;
+	int i;
+
+	for_each_hist_field(i, hist_data) {
+		hist_field = hist_data->fields[i];
+		if (hist_field && hist_field->flags & HIST_FIELD_FL_VAR &&
+		    strcmp(hist_field->var.name, var_name) == 0) {
+			found = hist_field;
+			break;
+		}
+	}
+
+	return found;
+}
+
+static struct hist_field *find_var(struct hist_trigger_data *hist_data,
+				   struct trace_event_file *file,
+				   const char *var_name)
+{
+	struct hist_trigger_data *test_data;
+	struct event_trigger_data *test;
+	struct hist_field *hist_field;
+
+	hist_field = find_var_field(hist_data, var_name);
+	if (hist_field)
+		return hist_field;
+
+	list_for_each_entry_rcu(test, &file->triggers, list) {
+		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			test_data = test->private_data;
+			hist_field = find_var_field(test_data, var_name);
+			if (hist_field)
+				return hist_field;
+		}
+	}
+
+	return NULL;
+}
+
+static struct trace_event_file *find_var_file(struct trace_array *tr,
+					      char *system,
+					      char *event_name,
+					      char *var_name)
+{
+	struct hist_trigger_data *var_hist_data;
+	struct hist_var_data *var_data;
+	struct trace_event_file *file, *found = NULL;
+
+	if (system)
+		return find_event_file(tr, system, event_name);
+
+	list_for_each_entry(var_data, &tr->hist_vars, list) {
+		var_hist_data = var_data->hist_data;
+		file = var_hist_data->event_file;
+		if (file == found)
+			continue;
+
+		if (find_var_field(var_hist_data, var_name)) {
+			if (found) {
+				hist_err_event("Variable name not unique, need to use fully qualified name (subsys.event.var) for variable: ", system, event_name, var_name);
+				return NULL;
+			}
+
+			found = file;
+		}
+	}
+
+	return found;
+}
+
+static struct hist_field *find_file_var(struct trace_event_file *file,
+					const char *var_name)
+{
+	struct hist_trigger_data *test_data;
+	struct event_trigger_data *test;
+	struct hist_field *hist_field;
+
+	list_for_each_entry_rcu(test, &file->triggers, list) {
+		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			test_data = test->private_data;
+			hist_field = find_var_field(test_data, var_name);
+			if (hist_field)
+				return hist_field;
+		}
+	}
+
+	return NULL;
+}
+
+static struct hist_field *
+find_match_var(struct hist_trigger_data *hist_data, char *var_name)
+{
+	struct trace_array *tr = hist_data->event_file->tr;
+	struct hist_field *hist_field, *found = NULL;
+	struct trace_event_file *file;
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *data = hist_data->actions[i];
+
+		if (data->fn == action_trace) {
+			char *system = data->onmatch.match_event_system;
+			char *event_name = data->onmatch.match_event;
+
+			file = find_var_file(tr, system, event_name, var_name);
+			if (!file)
+				continue;
+			hist_field = find_file_var(file, var_name);
+			if (hist_field) {
+				if (found) {
+					hist_err_event("Variable name not unique, need to use fully qualified name (subsys.event.var) for variable: ", system, event_name, var_name);
+					return ERR_PTR(-EINVAL);
+				}
+
+				found = hist_field;
+			}
+		}
+	}
+	return found;
+}
+
+static struct hist_field *find_event_var(struct hist_trigger_data *hist_data,
+					 char *system,
+					 char *event_name,
+					 char *var_name)
+{
+	struct trace_array *tr = hist_data->event_file->tr;
+	struct hist_field *hist_field = NULL;
+	struct trace_event_file *file;
+
+	if (!system || !event_name) {
+		hist_field = find_match_var(hist_data, var_name);
+		if (IS_ERR(hist_field))
+			return NULL;
+		if (hist_field)
+			return hist_field;
+	}
+
+	file = find_var_file(tr, system, event_name, var_name);
+	if (!file)
+		return NULL;
+
+	hist_field = find_file_var(file, var_name);
+
+	return hist_field;
+}
+
+struct hist_elt_data {
+	char *comm;
+	u64 *var_ref_vals;
+	char *field_var_str[SYNTH_FIELDS_MAX];
+};
+
+static u64 hist_field_var_ref(struct hist_field *hist_field,
+			      struct tracing_map_elt *elt,
+			      struct ring_buffer_event *rbe,
+			      void *event)
+{
+	struct hist_elt_data *elt_data;
+	u64 var_val = 0;
+
+	elt_data = elt->private_data;
+	var_val = elt_data->var_ref_vals[hist_field->var_ref_idx];
+
+	return var_val;
+}
+
+static bool resolve_var_refs(struct hist_trigger_data *hist_data, void *key,
+			     u64 *var_ref_vals, bool self)
+{
+	struct hist_trigger_data *var_data;
+	struct tracing_map_elt *var_elt;
+	struct hist_field *hist_field;
+	unsigned int i, var_idx;
+	bool resolved = true;
+	u64 var_val = 0;
+
+	for (i = 0; i < hist_data->n_var_refs; i++) {
+		hist_field = hist_data->var_refs[i];
+		var_idx = hist_field->var.idx;
+		var_data = hist_field->var.hist_data;
+
+		if (var_data == NULL) {
+			resolved = false;
+			break;
+		}
+
+		if ((self && var_data != hist_data) ||
+		    (!self && var_data == hist_data))
+			continue;
+
+		var_elt = tracing_map_lookup(var_data->map, key);
+		if (!var_elt) {
+			resolved = false;
+			break;
+		}
+
+		if (!tracing_map_var_set(var_elt, var_idx)) {
+			resolved = false;
+			break;
+		}
+
+		if (self || !hist_field->read_once)
+			var_val = tracing_map_read_var(var_elt, var_idx);
+		else
+			var_val = tracing_map_read_var_once(var_elt, var_idx);
+
+		var_ref_vals[i] = var_val;
+	}
+
+	return resolved;
+}
+
+static const char *hist_field_name(struct hist_field *field,
+				   unsigned int level)
+{
+	const char *field_name = "";
+
+	if (level > 1)
+		return field_name;
+
+	if (field->field)
+		field_name = field->field->name;
+	else if (field->flags & HIST_FIELD_FL_LOG2 ||
+		 field->flags & HIST_FIELD_FL_ALIAS)
+		field_name = hist_field_name(field->operands[0], ++level);
+	else if (field->flags & HIST_FIELD_FL_CPU)
+		field_name = "cpu";
+	else if (field->flags & HIST_FIELD_FL_EXPR ||
+		 field->flags & HIST_FIELD_FL_VAR_REF) {
+		if (field->system) {
+			static char full_name[MAX_FILTER_STR_VAL];
+
+			strcat(full_name, field->system);
+			strcat(full_name, ".");
+			strcat(full_name, field->event_name);
+			strcat(full_name, ".");
+			strcat(full_name, field->name);
+			field_name = full_name;
+		} else
+			field_name = field->name;
+	} else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
+		field_name = "common_timestamp";
+
+	if (field_name == NULL)
+		field_name = "";
+
+	return field_name;
+}
+
+static hist_field_fn_t select_value_fn(int field_size, int field_is_signed)
+{
+	hist_field_fn_t fn = NULL;
+
+	switch (field_size) {
+	case 8:
+		if (field_is_signed)
+			fn = hist_field_s64;
+		else
+			fn = hist_field_u64;
+		break;
+	case 4:
+		if (field_is_signed)
+			fn = hist_field_s32;
+		else
+			fn = hist_field_u32;
+		break;
+	case 2:
+		if (field_is_signed)
+			fn = hist_field_s16;
+		else
+			fn = hist_field_u16;
+		break;
+	case 1:
+		if (field_is_signed)
+			fn = hist_field_s8;
+		else
+			fn = hist_field_u8;
+		break;
+	}
+
+	return fn;
+}
+
+static int parse_map_size(char *str)
+{
+	unsigned long size, map_bits;
+	int ret;
+
+	strsep(&str, "=");
+	if (!str) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = kstrtoul(str, 0, &size);
+	if (ret)
+		goto out;
+
+	map_bits = ilog2(roundup_pow_of_two(size));
+	if (map_bits < TRACING_MAP_BITS_MIN ||
+	    map_bits > TRACING_MAP_BITS_MAX)
+		ret = -EINVAL;
+	else
+		ret = map_bits;
+ out:
+	return ret;
+}
+
+static void destroy_hist_trigger_attrs(struct hist_trigger_attrs *attrs)
+{
+	unsigned int i;
+
+	if (!attrs)
+		return;
+
+	for (i = 0; i < attrs->n_assignments; i++)
+		kfree(attrs->assignment_str[i]);
+
+	for (i = 0; i < attrs->n_actions; i++)
+		kfree(attrs->action_str[i]);
+
+	kfree(attrs->name);
+	kfree(attrs->sort_key_str);
+	kfree(attrs->keys_str);
+	kfree(attrs->vals_str);
+	kfree(attrs->clock);
+	kfree(attrs);
+}
+
+static int parse_action(char *str, struct hist_trigger_attrs *attrs)
+{
+	int ret = -EINVAL;
+
+	if (attrs->n_actions >= HIST_ACTIONS_MAX)
+		return ret;
+
+	if ((strncmp(str, "onmatch(", strlen("onmatch(")) == 0) ||
+	    (strncmp(str, "onmax(", strlen("onmax(")) == 0)) {
+		attrs->action_str[attrs->n_actions] = kstrdup(str, GFP_KERNEL);
+		if (!attrs->action_str[attrs->n_actions]) {
+			ret = -ENOMEM;
+			return ret;
+		}
+		attrs->n_actions++;
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
+{
+	int ret = 0;
+
+	if ((strncmp(str, "key=", strlen("key=")) == 0) ||
+	    (strncmp(str, "keys=", strlen("keys=")) == 0)) {
+		attrs->keys_str = kstrdup(str, GFP_KERNEL);
+		if (!attrs->keys_str) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else if ((strncmp(str, "val=", strlen("val=")) == 0) ||
+		 (strncmp(str, "vals=", strlen("vals=")) == 0) ||
+		 (strncmp(str, "values=", strlen("values=")) == 0)) {
+		attrs->vals_str = kstrdup(str, GFP_KERNEL);
+		if (!attrs->vals_str) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else if (strncmp(str, "sort=", strlen("sort=")) == 0) {
+		attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
+		if (!attrs->sort_key_str) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else if (strncmp(str, "name=", strlen("name=")) == 0) {
+		attrs->name = kstrdup(str, GFP_KERNEL);
+		if (!attrs->name) {
+			ret = -ENOMEM;
+			goto out;
+		}
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
+	} else if (strncmp(str, "size=", strlen("size=")) == 0) {
+		int map_bits = parse_map_size(str);
+
+		if (map_bits < 0) {
+			ret = map_bits;
+			goto out;
+		}
+		attrs->map_bits = map_bits;
+	} else {
+		char *assignment;
+
+		if (attrs->n_assignments == TRACING_MAP_VARS_MAX) {
+			hist_err("Too many variables defined: ", str);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		assignment = kstrdup(str, GFP_KERNEL);
+		if (!assignment) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		attrs->assignment_str[attrs->n_assignments++] = assignment;
+	}
+ out:
+	return ret;
+}
+
+static struct hist_trigger_attrs *parse_hist_trigger_attrs(char *trigger_str)
+{
+	struct hist_trigger_attrs *attrs;
+	int ret = 0;
+
+	attrs = kzalloc(sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		return ERR_PTR(-ENOMEM);
+
+	while (trigger_str) {
+		char *str = strsep(&trigger_str, ":");
+
+		if (strchr(str, '=')) {
+			ret = parse_assignment(str, attrs);
+			if (ret)
+				goto free;
+		} else if (strcmp(str, "pause") == 0)
+			attrs->pause = true;
+		else if ((strcmp(str, "cont") == 0) ||
+			 (strcmp(str, "continue") == 0))
+			attrs->cont = true;
+		else if (strcmp(str, "clear") == 0)
+			attrs->clear = true;
+		else {
+			ret = parse_action(str, attrs);
+			if (ret)
+				goto free;
+		}
+	}
+
+	if (!attrs->keys_str) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	if (!attrs->clock) {
+		attrs->clock = kstrdup("global", GFP_KERNEL);
+		if (!attrs->clock) {
+			ret = -ENOMEM;
+			goto free;
+		}
+	}
+
+	return attrs;
+ free:
+	destroy_hist_trigger_attrs(attrs);
+
+	return ERR_PTR(ret);
+}
+
+static inline void save_comm(char *comm, struct task_struct *task)
+{
+	if (!task->pid) {
+		strcpy(comm, "<idle>");
+		return;
+	}
+
+	if (WARN_ON_ONCE(task->pid < 0)) {
+		strcpy(comm, "<XXX>");
+		return;
+	}
+
+	memcpy(comm, task->comm, TASK_COMM_LEN);
+}
+
+static void hist_elt_data_free(struct hist_elt_data *elt_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < SYNTH_FIELDS_MAX; i++)
+		kfree(elt_data->field_var_str[i]);
+
+	kfree(elt_data->comm);
+	kfree(elt_data);
+}
+
+static void hist_trigger_elt_data_free(struct tracing_map_elt *elt)
+{
+	struct hist_elt_data *elt_data = elt->private_data;
+
+	hist_elt_data_free(elt_data);
+}
+
+static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
+{
+	struct hist_trigger_data *hist_data = elt->map->private_data;
+	unsigned int size = TASK_COMM_LEN;
+	struct hist_elt_data *elt_data;
+	struct hist_field *key_field;
+	unsigned int i, n_str;
+
+	elt_data = kzalloc(sizeof(*elt_data), GFP_KERNEL);
+	if (!elt_data)
+		return -ENOMEM;
+
+	for_each_hist_key_field(i, hist_data) {
+		key_field = hist_data->fields[i];
+
+		if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
+			elt_data->comm = kzalloc(size, GFP_KERNEL);
+			if (!elt_data->comm) {
+				kfree(elt_data);
+				return -ENOMEM;
+			}
+			break;
+		}
+	}
+
+	n_str = hist_data->n_field_var_str + hist_data->n_max_var_str;
+
+	size = STR_VAR_LEN_MAX;
+
+	for (i = 0; i < n_str; i++) {
+		elt_data->field_var_str[i] = kzalloc(size, GFP_KERNEL);
+		if (!elt_data->field_var_str[i]) {
+			hist_elt_data_free(elt_data);
+			return -ENOMEM;
+		}
+	}
+
+	elt->private_data = elt_data;
+
+	return 0;
+}
+
+static void hist_trigger_elt_data_init(struct tracing_map_elt *elt)
+{
+	struct hist_elt_data *elt_data = elt->private_data;
+
+	if (elt_data->comm)
+		save_comm(elt_data->comm, current);
+}
+
+static const struct tracing_map_ops hist_trigger_elt_data_ops = {
+	.elt_alloc	= hist_trigger_elt_data_alloc,
+	.elt_free	= hist_trigger_elt_data_free,
+	.elt_init	= hist_trigger_elt_data_init,
+};
+
+static const char *get_hist_field_flags(struct hist_field *hist_field)
+{
+	const char *flags_str = NULL;
+
+	if (hist_field->flags & HIST_FIELD_FL_HEX)
+		flags_str = "hex";
+	else if (hist_field->flags & HIST_FIELD_FL_SYM)
+		flags_str = "sym";
+	else if (hist_field->flags & HIST_FIELD_FL_SYM_OFFSET)
+		flags_str = "sym-offset";
+	else if (hist_field->flags & HIST_FIELD_FL_EXECNAME)
+		flags_str = "execname";
+	else if (hist_field->flags & HIST_FIELD_FL_SYSCALL)
+		flags_str = "syscall";
+	else if (hist_field->flags & HIST_FIELD_FL_LOG2)
+		flags_str = "log2";
+	else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP_USECS)
+		flags_str = "usecs";
+
+	return flags_str;
+}
+
+static void expr_field_str(struct hist_field *field, char *expr)
+{
+	if (field->flags & HIST_FIELD_FL_VAR_REF)
+		strcat(expr, "$");
+
+	strcat(expr, hist_field_name(field, 0));
+
+	if (field->flags && !(field->flags & HIST_FIELD_FL_VAR_REF)) {
+		const char *flags_str = get_hist_field_flags(field);
+
+		if (flags_str) {
+			strcat(expr, ".");
+			strcat(expr, flags_str);
+		}
+	}
+}
+
+static char *expr_str(struct hist_field *field, unsigned int level)
+{
+	char *expr;
+
+	if (level > 1)
+		return NULL;
+
+	expr = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
+	if (!expr)
+		return NULL;
+
+	if (!field->operands[0]) {
+		expr_field_str(field, expr);
+		return expr;
+	}
+
+	if (field->operator == FIELD_OP_UNARY_MINUS) {
+		char *subexpr;
+
+		strcat(expr, "-(");
+		subexpr = expr_str(field->operands[0], ++level);
+		if (!subexpr) {
+			kfree(expr);
+			return NULL;
+		}
+		strcat(expr, subexpr);
+		strcat(expr, ")");
+
+		kfree(subexpr);
+
+		return expr;
+	}
+
+	expr_field_str(field->operands[0], expr);
+
+	switch (field->operator) {
+	case FIELD_OP_MINUS:
+		strcat(expr, "-");
+		break;
+	case FIELD_OP_PLUS:
+		strcat(expr, "+");
+		break;
+	default:
+		kfree(expr);
+		return NULL;
+	}
+
+	expr_field_str(field->operands[1], expr);
+
+	return expr;
+}
+
+static int contains_operator(char *str)
+{
+	enum field_op_id field_op = FIELD_OP_NONE;
+	char *op;
+
+	op = strpbrk(str, "+-");
+	if (!op)
+		return FIELD_OP_NONE;
+
+	switch (*op) {
+	case '-':
+		if (*str == '-')
+			field_op = FIELD_OP_UNARY_MINUS;
+		else
+			field_op = FIELD_OP_MINUS;
+		break;
+	case '+':
+		field_op = FIELD_OP_PLUS;
+		break;
+	default:
+		break;
+	}
+
+	return field_op;
+}
+
+static void destroy_hist_field(struct hist_field *hist_field,
+			       unsigned int level)
+{
+	unsigned int i;
+
+	if (level > 3)
+		return;
+
+	if (!hist_field)
+		return;
+
+	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++)
+		destroy_hist_field(hist_field->operands[i], level + 1);
+
+	kfree(hist_field->var.name);
+	kfree(hist_field->name);
+	kfree(hist_field->type);
+
+	kfree(hist_field);
+}
+
+static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
+					    struct ftrace_event_field *field,
+					    unsigned long flags,
+					    char *var_name)
+{
+	struct hist_field *hist_field;
+
+	if (field && is_function_field(field))
+		return NULL;
+
+	hist_field = kzalloc(sizeof(struct hist_field), GFP_KERNEL);
+	if (!hist_field)
+		return NULL;
+
+	hist_field->hist_data = hist_data;
+
+	if (flags & HIST_FIELD_FL_EXPR || flags & HIST_FIELD_FL_ALIAS)
+		goto out; /* caller will populate */
+
+	if (flags & HIST_FIELD_FL_VAR_REF) {
+		hist_field->fn = hist_field_var_ref;
+		goto out;
+	}
+
+	if (flags & HIST_FIELD_FL_HITCOUNT) {
+		hist_field->fn = hist_field_counter;
+		hist_field->size = sizeof(u64);
+		hist_field->type = kstrdup("u64", GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
+		goto out;
+	}
+
+	if (flags & HIST_FIELD_FL_STACKTRACE) {
+		hist_field->fn = hist_field_none;
+		goto out;
+	}
+
+	if (flags & HIST_FIELD_FL_LOG2) {
 		unsigned long fl = flags & ~HIST_FIELD_FL_LOG2;
 		hist_field->fn = hist_field_log2;
-		hist_field->operands[0] = create_hist_field(field, fl);
+		hist_field->operands[0] = create_hist_field(hist_data, field, fl, NULL);
 		hist_field->size = hist_field->operands[0]->size;
+		hist_field->type = kstrdup(hist_field->operands[0]->type, GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
+		goto out;
+	}
+
+	if (flags & HIST_FIELD_FL_TIMESTAMP) {
+		hist_field->fn = hist_field_timestamp;
+		hist_field->size = sizeof(u64);
+		hist_field->type = kstrdup("u64", GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
+		goto out;
+	}
+
+	if (flags & HIST_FIELD_FL_CPU) {
+		hist_field->fn = hist_field_cpu;
+		hist_field->size = sizeof(int);
+		hist_field->type = kstrdup("unsigned int", GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
+		goto out;
+	}
+
+	if (WARN_ON_ONCE(!field))
+		goto out;
+
+	if (is_string_field(field)) {
+		flags |= HIST_FIELD_FL_STRING;
+
+		hist_field->size = MAX_FILTER_STR_VAL;
+		hist_field->type = kstrdup(field->type, GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
+
+		if (field->filter_type == FILTER_STATIC_STRING)
+			hist_field->fn = hist_field_string;
+		else if (field->filter_type == FILTER_DYN_STRING)
+			hist_field->fn = hist_field_dynstring;
+		else
+			hist_field->fn = hist_field_pstring;
+	} else {
+		hist_field->size = field->size;
+		hist_field->is_signed = field->is_signed;
+		hist_field->type = kstrdup(field->type, GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
+
+		hist_field->fn = select_value_fn(field->size,
+						 field->is_signed);
+		if (!hist_field->fn) {
+			destroy_hist_field(hist_field, 0);
+			return NULL;
+		}
+	}
+ out:
+	hist_field->field = field;
+	hist_field->flags = flags;
+
+	if (var_name) {
+		hist_field->var.name = kstrdup(var_name, GFP_KERNEL);
+		if (!hist_field->var.name)
+			goto free;
+	}
+
+	return hist_field;
+ free:
+	destroy_hist_field(hist_field, 0);
+	return NULL;
+}
+
+static void destroy_hist_fields(struct hist_trigger_data *hist_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < HIST_FIELDS_MAX; i++) {
+		if (hist_data->fields[i]) {
+			destroy_hist_field(hist_data->fields[i], 0);
+			hist_data->fields[i] = NULL;
+		}
+	}
+}
+
+static int init_var_ref(struct hist_field *ref_field,
+			struct hist_field *var_field,
+			char *system, char *event_name)
+{
+	int err = 0;
+
+	ref_field->var.idx = var_field->var.idx;
+	ref_field->var.hist_data = var_field->hist_data;
+	ref_field->size = var_field->size;
+	ref_field->is_signed = var_field->is_signed;
+	ref_field->flags |= var_field->flags &
+		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
+
+	if (system) {
+		ref_field->system = kstrdup(system, GFP_KERNEL);
+		if (!ref_field->system)
+			return -ENOMEM;
+	}
+
+	if (event_name) {
+		ref_field->event_name = kstrdup(event_name, GFP_KERNEL);
+		if (!ref_field->event_name) {
+			err = -ENOMEM;
+			goto free;
+		}
+	}
+
+	if (var_field->var.name) {
+		ref_field->name = kstrdup(var_field->var.name, GFP_KERNEL);
+		if (!ref_field->name) {
+			err = -ENOMEM;
+			goto free;
+		}
+	} else if (var_field->name) {
+		ref_field->name = kstrdup(var_field->name, GFP_KERNEL);
+		if (!ref_field->name) {
+			err = -ENOMEM;
+			goto free;
+		}
+	}
+
+	ref_field->type = kstrdup(var_field->type, GFP_KERNEL);
+	if (!ref_field->type) {
+		err = -ENOMEM;
+		goto free;
+	}
+ out:
+	return err;
+ free:
+	kfree(ref_field->system);
+	kfree(ref_field->event_name);
+	kfree(ref_field->name);
+
+	goto out;
+}
+
+static struct hist_field *create_var_ref(struct hist_field *var_field,
+					 char *system, char *event_name)
+{
+	unsigned long flags = HIST_FIELD_FL_VAR_REF;
+	struct hist_field *ref_field;
+
+	ref_field = create_hist_field(var_field->hist_data, NULL, flags, NULL);
+	if (ref_field) {
+		if (init_var_ref(ref_field, var_field, system, event_name)) {
+			destroy_hist_field(ref_field, 0);
+			return NULL;
+		}
+	}
+
+	return ref_field;
+}
+
+static bool is_var_ref(char *var_name)
+{
+	if (!var_name || strlen(var_name) < 2 || var_name[0] != '$')
+		return false;
+
+	return true;
+}
+
+static char *field_name_from_var(struct hist_trigger_data *hist_data,
+				 char *var_name)
+{
+	char *name, *field;
+	unsigned int i;
+
+	for (i = 0; i < hist_data->attrs->var_defs.n_vars; i++) {
+		name = hist_data->attrs->var_defs.name[i];
+
+		if (strcmp(var_name, name) == 0) {
+			field = hist_data->attrs->var_defs.expr[i];
+			if (contains_operator(field) || is_var_ref(field))
+				continue;
+			return field;
+		}
+	}
+
+	return NULL;
+}
+
+static char *local_field_var_ref(struct hist_trigger_data *hist_data,
+				 char *system, char *event_name,
+				 char *var_name)
+{
+	struct trace_event_call *call;
+
+	if (system && event_name) {
+		call = hist_data->event_file->event_call;
+
+		if (strcmp(system, call->class->system) != 0)
+			return NULL;
+
+		if (strcmp(event_name, trace_event_name(call)) != 0)
+			return NULL;
+	}
+
+	if (!!system != !!event_name)
+		return NULL;
+
+	if (!is_var_ref(var_name))
+		return NULL;
+
+	var_name++;
+
+	return field_name_from_var(hist_data, var_name);
+}
+
+static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
+					char *system, char *event_name,
+					char *var_name)
+{
+	struct hist_field *var_field = NULL, *ref_field = NULL;
+
+	if (!is_var_ref(var_name))
+		return NULL;
+
+	var_name++;
+
+	var_field = find_event_var(hist_data, system, event_name, var_name);
+	if (var_field)
+		ref_field = create_var_ref(var_field, system, event_name);
+
+	if (!ref_field)
+		hist_err_event("Couldn't find variable: $",
+			       system, event_name, var_name);
+
+	return ref_field;
+}
+
+static struct ftrace_event_field *
+parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
+	    char *field_str, unsigned long *flags)
+{
+	struct ftrace_event_field *field = NULL;
+	char *field_name, *modifier, *str;
+
+	modifier = str = kstrdup(field_str, GFP_KERNEL);
+	if (!modifier)
+		return ERR_PTR(-ENOMEM);
+
+	field_name = strsep(&modifier, ".");
+	if (modifier) {
+		if (strcmp(modifier, "hex") == 0)
+			*flags |= HIST_FIELD_FL_HEX;
+		else if (strcmp(modifier, "sym") == 0)
+			*flags |= HIST_FIELD_FL_SYM;
+		else if (strcmp(modifier, "sym-offset") == 0)
+			*flags |= HIST_FIELD_FL_SYM_OFFSET;
+		else if ((strcmp(modifier, "execname") == 0) &&
+			 (strcmp(field_name, "common_pid") == 0))
+			*flags |= HIST_FIELD_FL_EXECNAME;
+		else if (strcmp(modifier, "syscall") == 0)
+			*flags |= HIST_FIELD_FL_SYSCALL;
+		else if (strcmp(modifier, "log2") == 0)
+			*flags |= HIST_FIELD_FL_LOG2;
+		else if (strcmp(modifier, "usecs") == 0)
+			*flags |= HIST_FIELD_FL_TIMESTAMP_USECS;
+		else {
+			field = ERR_PTR(-EINVAL);
+			goto out;
+		}
+	}
+
+	if (strcmp(field_name, "common_timestamp") == 0) {
+		*flags |= HIST_FIELD_FL_TIMESTAMP;
+		hist_data->enable_timestamps = true;
+		if (*flags & HIST_FIELD_FL_TIMESTAMP_USECS)
+			hist_data->attrs->ts_in_usecs = true;
+	} else if (strcmp(field_name, "cpu") == 0)
+		*flags |= HIST_FIELD_FL_CPU;
+	else {
+		field = trace_find_event_field(file->event_call, field_name);
+		if (!field || !field->size) {
+			field = ERR_PTR(-EINVAL);
+			goto out;
+		}
+	}
+ out:
+	kfree(str);
+
+	return field;
+}
+
+static struct hist_field *create_alias(struct hist_trigger_data *hist_data,
+				       struct hist_field *var_ref,
+				       char *var_name)
+{
+	struct hist_field *alias = NULL;
+	unsigned long flags = HIST_FIELD_FL_ALIAS | HIST_FIELD_FL_VAR;
+
+	alias = create_hist_field(hist_data, NULL, flags, var_name);
+	if (!alias)
+		return NULL;
+
+	alias->fn = var_ref->fn;
+	alias->operands[0] = var_ref;
+
+	if (init_var_ref(alias, var_ref, var_ref->system, var_ref->event_name)) {
+		destroy_hist_field(alias, 0);
+		return NULL;
+	}
+
+	return alias;
+}
+
+static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
+				     struct trace_event_file *file, char *str,
+				     unsigned long *flags, char *var_name)
+{
+	char *s, *ref_system = NULL, *ref_event = NULL, *ref_var = str;
+	struct ftrace_event_field *field = NULL;
+	struct hist_field *hist_field = NULL;
+	int ret = 0;
+
+	s = strchr(str, '.');
+	if (s) {
+		s = strchr(++s, '.');
+		if (s) {
+			ref_system = strsep(&str, ".");
+			if (!str) {
+				ret = -EINVAL;
+				goto out;
+			}
+			ref_event = strsep(&str, ".");
+			if (!str) {
+				ret = -EINVAL;
+				goto out;
+			}
+			ref_var = str;
+		}
+	}
+
+	s = local_field_var_ref(hist_data, ref_system, ref_event, ref_var);
+	if (!s) {
+		hist_field = parse_var_ref(hist_data, ref_system, ref_event, ref_var);
+		if (hist_field) {
+			hist_data->var_refs[hist_data->n_var_refs] = hist_field;
+			hist_field->var_ref_idx = hist_data->n_var_refs++;
+			if (var_name) {
+				hist_field = create_alias(hist_data, hist_field, var_name);
+				if (!hist_field) {
+					ret = -ENOMEM;
+					goto out;
+				}
+			}
+			return hist_field;
+		}
+	} else
+		str = s;
+
+	field = parse_field(hist_data, file, str, flags);
+	if (IS_ERR(field)) {
+		ret = PTR_ERR(field);
+		goto out;
+	}
+
+	hist_field = create_hist_field(hist_data, field, *flags, var_name);
+	if (!hist_field) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	return hist_field;
+ out:
+	return ERR_PTR(ret);
+}
+
+static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
+				     struct trace_event_file *file,
+				     char *str, unsigned long flags,
+				     char *var_name, unsigned int level);
+
+static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
+				      struct trace_event_file *file,
+				      char *str, unsigned long flags,
+				      char *var_name, unsigned int level)
+{
+	struct hist_field *operand1, *expr = NULL;
+	unsigned long operand_flags;
+	int ret = 0;
+	char *s;
+
+	/* we support only -(xxx) i.e. explicit parens required */
+
+	if (level > 3) {
+		hist_err("Too many subexpressions (3 max): ", str);
+		ret = -EINVAL;
+		goto free;
+	}
+
+	str++; /* skip leading '-' */
+
+	s = strchr(str, '(');
+	if (s)
+		str++;
+	else {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	s = strrchr(str, ')');
+	if (s)
+		*s = '\0';
+	else {
+		ret = -EINVAL; /* no closing ')' */
+		goto free;
+	}
+
+	flags |= HIST_FIELD_FL_EXPR;
+	expr = create_hist_field(hist_data, NULL, flags, var_name);
+	if (!expr) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	operand_flags = 0;
+	operand1 = parse_expr(hist_data, file, str, operand_flags, NULL, ++level);
+	if (IS_ERR(operand1)) {
+		ret = PTR_ERR(operand1);
+		goto free;
+	}
+
+	expr->flags |= operand1->flags &
+		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
+	expr->fn = hist_field_unary_minus;
+	expr->operands[0] = operand1;
+	expr->operator = FIELD_OP_UNARY_MINUS;
+	expr->name = expr_str(expr, 0);
+	expr->type = kstrdup(operand1->type, GFP_KERNEL);
+	if (!expr->type) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	return expr;
+ free:
+	destroy_hist_field(expr, 0);
+	return ERR_PTR(ret);
+}
+
+static int check_expr_operands(struct hist_field *operand1,
+			       struct hist_field *operand2)
+{
+	unsigned long operand1_flags = operand1->flags;
+	unsigned long operand2_flags = operand2->flags;
+
+	if ((operand1_flags & HIST_FIELD_FL_VAR_REF) ||
+	    (operand1_flags & HIST_FIELD_FL_ALIAS)) {
+		struct hist_field *var;
+
+		var = find_var_field(operand1->var.hist_data, operand1->name);
+		if (!var)
+			return -EINVAL;
+		operand1_flags = var->flags;
+	}
+
+	if ((operand2_flags & HIST_FIELD_FL_VAR_REF) ||
+	    (operand2_flags & HIST_FIELD_FL_ALIAS)) {
+		struct hist_field *var;
+
+		var = find_var_field(operand2->var.hist_data, operand2->name);
+		if (!var)
+			return -EINVAL;
+		operand2_flags = var->flags;
+	}
+
+	if ((operand1_flags & HIST_FIELD_FL_TIMESTAMP_USECS) !=
+	    (operand2_flags & HIST_FIELD_FL_TIMESTAMP_USECS)) {
+		hist_err("Timestamp units in expression don't match", NULL);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
+				     struct trace_event_file *file,
+				     char *str, unsigned long flags,
+				     char *var_name, unsigned int level)
+{
+	struct hist_field *operand1 = NULL, *operand2 = NULL, *expr = NULL;
+	unsigned long operand_flags;
+	int field_op, ret = -EINVAL;
+	char *sep, *operand1_str;
+
+	if (level > 3) {
+		hist_err("Too many subexpressions (3 max): ", str);
+		return ERR_PTR(-EINVAL);
+	}
+
+	field_op = contains_operator(str);
+
+	if (field_op == FIELD_OP_NONE)
+		return parse_atom(hist_data, file, str, &flags, var_name);
+
+	if (field_op == FIELD_OP_UNARY_MINUS)
+		return parse_unary(hist_data, file, str, flags, var_name, ++level);
+
+	switch (field_op) {
+	case FIELD_OP_MINUS:
+		sep = "-";
+		break;
+	case FIELD_OP_PLUS:
+		sep = "+";
+		break;
+	default:
+		goto free;
+	}
+
+	operand1_str = strsep(&str, sep);
+	if (!operand1_str || !str)
+		goto free;
+
+	operand_flags = 0;
+	operand1 = parse_atom(hist_data, file, operand1_str,
+			      &operand_flags, NULL);
+	if (IS_ERR(operand1)) {
+		ret = PTR_ERR(operand1);
+		operand1 = NULL;
+		goto free;
+	}
+
+	/* rest of string could be another expression e.g. b+c in a+b+c */
+	operand_flags = 0;
+	operand2 = parse_expr(hist_data, file, str, operand_flags, NULL, ++level);
+	if (IS_ERR(operand2)) {
+		ret = PTR_ERR(operand2);
+		operand2 = NULL;
+		goto free;
+	}
+
+	ret = check_expr_operands(operand1, operand2);
+	if (ret)
+		goto free;
+
+	flags |= HIST_FIELD_FL_EXPR;
+
+	flags |= operand1->flags &
+		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
+
+	expr = create_hist_field(hist_data, NULL, flags, var_name);
+	if (!expr) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	operand1->read_once = true;
+	operand2->read_once = true;
+
+	expr->operands[0] = operand1;
+	expr->operands[1] = operand2;
+	expr->operator = field_op;
+	expr->name = expr_str(expr, 0);
+	expr->type = kstrdup(operand1->type, GFP_KERNEL);
+	if (!expr->type) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	switch (field_op) {
+	case FIELD_OP_MINUS:
+		expr->fn = hist_field_minus;
+		break;
+	case FIELD_OP_PLUS:
+		expr->fn = hist_field_plus;
+		break;
+	default:
+		ret = -EINVAL;
+		goto free;
+	}
+
+	return expr;
+ free:
+	destroy_hist_field(operand1, 0);
+	destroy_hist_field(operand2, 0);
+	destroy_hist_field(expr, 0);
+
+	return ERR_PTR(ret);
+}
+
+static char *find_trigger_filter(struct hist_trigger_data *hist_data,
+				 struct trace_event_file *file)
+{
+	struct event_trigger_data *test;
+
+	list_for_each_entry_rcu(test, &file->triggers, list) {
+		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			if (test->private_data == hist_data)
+				return test->filter_str;
+		}
+	}
+
+	return NULL;
+}
+
+static struct event_command trigger_hist_cmd;
+static int event_hist_trigger_func(struct event_command *cmd_ops,
+				   struct trace_event_file *file,
+				   char *glob, char *cmd, char *param);
+
+static bool compatible_keys(struct hist_trigger_data *target_hist_data,
+			    struct hist_trigger_data *hist_data,
+			    unsigned int n_keys)
+{
+	struct hist_field *target_hist_field, *hist_field;
+	unsigned int n, i, j;
+
+	if (hist_data->n_fields - hist_data->n_vals != n_keys)
+		return false;
+
+	i = hist_data->n_vals;
+	j = target_hist_data->n_vals;
+
+	for (n = 0; n < n_keys; n++) {
+		hist_field = hist_data->fields[i + n];
+		target_hist_field = target_hist_data->fields[j + n];
+
+		if (strcmp(hist_field->type, target_hist_field->type) != 0)
+			return false;
+		if (hist_field->size != target_hist_field->size)
+			return false;
+		if (hist_field->is_signed != target_hist_field->is_signed)
+			return false;
+	}
+
+	return true;
+}
+
+static struct hist_trigger_data *
+find_compatible_hist(struct hist_trigger_data *target_hist_data,
+		     struct trace_event_file *file)
+{
+	struct hist_trigger_data *hist_data;
+	struct event_trigger_data *test;
+	unsigned int n_keys;
+
+	n_keys = target_hist_data->n_fields - target_hist_data->n_vals;
+
+	list_for_each_entry_rcu(test, &file->triggers, list) {
+		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			hist_data = test->private_data;
+
+			if (compatible_keys(target_hist_data, hist_data, n_keys))
+				return hist_data;
+		}
+	}
+
+	return NULL;
+}
+
+static struct trace_event_file *event_file(struct trace_array *tr,
+					   char *system, char *event_name)
+{
+	struct trace_event_file *file;
+
+	file = find_event_file(tr, system, event_name);
+	if (!file)
+		return ERR_PTR(-EINVAL);
+
+	return file;
+}
+
+static struct hist_field *
+find_synthetic_field_var(struct hist_trigger_data *target_hist_data,
+			 char *system, char *event_name, char *field_name)
+{
+	struct hist_field *event_var;
+	char *synthetic_name;
+
+	synthetic_name = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
+	if (!synthetic_name)
+		return ERR_PTR(-ENOMEM);
+
+	strcpy(synthetic_name, "synthetic_");
+	strcat(synthetic_name, field_name);
+
+	event_var = find_event_var(target_hist_data, system, event_name, synthetic_name);
+
+	kfree(synthetic_name);
+
+	return event_var;
+}
+
+/**
+ * create_field_var_hist - Automatically create a histogram and var for a field
+ * @target_hist_data: The target hist trigger
+ * @subsys_name: Optional subsystem name
+ * @event_name: Optional event name
+ * @field_name: The name of the field (and the resulting variable)
+ *
+ * Hist trigger actions fetch data from variables, not directly from
+ * events.  However, for convenience, users are allowed to directly
+ * specify an event field in an action, which will be automatically
+ * converted into a variable on their behalf.
+
+ * If a user specifies a field on an event that isn't the event the
+ * histogram currently being defined (the target event histogram), the
+ * only way that can be accomplished is if a new hist trigger is
+ * created and the field variable defined on that.
+ *
+ * This function creates a new histogram compatible with the target
+ * event (meaning a histogram with the same key as the target
+ * histogram), and creates a variable for the specified field, but
+ * with 'synthetic_' prepended to the variable name in order to avoid
+ * collision with normal field variables.
+ *
+ * Return: The variable created for the field.
+ */
+static struct hist_field *
+create_field_var_hist(struct hist_trigger_data *target_hist_data,
+		      char *subsys_name, char *event_name, char *field_name)
+{
+	struct trace_array *tr = target_hist_data->event_file->tr;
+	struct hist_field *event_var = ERR_PTR(-EINVAL);
+	struct hist_trigger_data *hist_data;
+	unsigned int i, n, first = true;
+	struct field_var_hist *var_hist;
+	struct trace_event_file *file;
+	struct hist_field *key_field;
+	char *saved_filter;
+	char *cmd;
+	int ret;
+
+	if (target_hist_data->n_field_var_hists >= SYNTH_FIELDS_MAX) {
+		hist_err_event("onmatch: Too many field variables defined: ",
+			       subsys_name, event_name, field_name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	file = event_file(tr, subsys_name, event_name);
+
+	if (IS_ERR(file)) {
+		hist_err_event("onmatch: Event file not found: ",
+			       subsys_name, event_name, field_name);
+		ret = PTR_ERR(file);
+		return ERR_PTR(ret);
+	}
+
+	/*
+	 * Look for a histogram compatible with target.  We'll use the
+	 * found histogram specification to create a new matching
+	 * histogram with our variable on it.  target_hist_data is not
+	 * yet a registered histogram so we can't use that.
+	 */
+	hist_data = find_compatible_hist(target_hist_data, file);
+	if (!hist_data) {
+		hist_err_event("onmatch: Matching event histogram not found: ",
+			       subsys_name, event_name, field_name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* See if a synthetic field variable has already been created */
+	event_var = find_synthetic_field_var(target_hist_data, subsys_name,
+					     event_name, field_name);
+	if (!IS_ERR_OR_NULL(event_var))
+		return event_var;
+
+	var_hist = kzalloc(sizeof(*var_hist), GFP_KERNEL);
+	if (!var_hist)
+		return ERR_PTR(-ENOMEM);
+
+	cmd = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
+	if (!cmd) {
+		kfree(var_hist);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Use the same keys as the compatible histogram */
+	strcat(cmd, "keys=");
+
+	for_each_hist_key_field(i, hist_data) {
+		key_field = hist_data->fields[i];
+		if (!first)
+			strcat(cmd, ",");
+		strcat(cmd, key_field->field->name);
+		first = false;
+	}
+
+	/* Create the synthetic field variable specification */
+	strcat(cmd, ":synthetic_");
+	strcat(cmd, field_name);
+	strcat(cmd, "=");
+	strcat(cmd, field_name);
+
+	/* Use the same filter as the compatible histogram */
+	saved_filter = find_trigger_filter(hist_data, file);
+	if (saved_filter) {
+		strcat(cmd, " if ");
+		strcat(cmd, saved_filter);
+	}
+
+	var_hist->cmd = kstrdup(cmd, GFP_KERNEL);
+	if (!var_hist->cmd) {
+		kfree(cmd);
+		kfree(var_hist);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Save the compatible histogram information */
+	var_hist->hist_data = hist_data;
+
+	/* Create the new histogram with our variable */
+	ret = event_hist_trigger_func(&trigger_hist_cmd, file,
+				      "", "hist", cmd);
+	if (ret) {
+		kfree(cmd);
+		kfree(var_hist->cmd);
+		kfree(var_hist);
+		hist_err_event("onmatch: Couldn't create histogram for field: ",
+			       subsys_name, event_name, field_name);
+		return ERR_PTR(ret);
+	}
+
+	kfree(cmd);
+
+	/* If we can't find the variable, something went wrong */
+	event_var = find_synthetic_field_var(target_hist_data, subsys_name,
+					     event_name, field_name);
+	if (IS_ERR_OR_NULL(event_var)) {
+		kfree(var_hist->cmd);
+		kfree(var_hist);
+		hist_err_event("onmatch: Couldn't find synthetic variable: ",
+			       subsys_name, event_name, field_name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	n = target_hist_data->n_field_var_hists;
+	target_hist_data->field_var_hists[n] = var_hist;
+	target_hist_data->n_field_var_hists++;
+
+	return event_var;
+}
+
+static struct hist_field *
+find_target_event_var(struct hist_trigger_data *hist_data,
+		      char *subsys_name, char *event_name, char *var_name)
+{
+	struct trace_event_file *file = hist_data->event_file;
+	struct hist_field *hist_field = NULL;
+
+	if (subsys_name) {
+		struct trace_event_call *call;
+
+		if (!event_name)
+			return NULL;
+
+		call = file->event_call;
+
+		if (strcmp(subsys_name, call->class->system) != 0)
+			return NULL;
+
+		if (strcmp(event_name, trace_event_name(call)) != 0)
+			return NULL;
+	}
+
+	hist_field = find_var_field(hist_data, var_name);
+
+	return hist_field;
+}
+
+static inline void __update_field_vars(struct tracing_map_elt *elt,
+				       struct ring_buffer_event *rbe,
+				       void *rec,
+				       struct field_var **field_vars,
+				       unsigned int n_field_vars,
+				       unsigned int field_var_str_start)
+{
+	struct hist_elt_data *elt_data = elt->private_data;
+	unsigned int i, j, var_idx;
+	u64 var_val;
+
+	for (i = 0, j = field_var_str_start; i < n_field_vars; i++) {
+		struct field_var *field_var = field_vars[i];
+		struct hist_field *var = field_var->var;
+		struct hist_field *val = field_var->val;
+
+		var_val = val->fn(val, elt, rbe, rec);
+		var_idx = var->var.idx;
+
+		if (val->flags & HIST_FIELD_FL_STRING) {
+			char *str = elt_data->field_var_str[j++];
+			char *val_str = (char *)(uintptr_t)var_val;
+
+			strscpy(str, val_str, STR_VAR_LEN_MAX);
+			var_val = (u64)(uintptr_t)str;
+		}
+		tracing_map_set_var(elt, var_idx, var_val);
+	}
+}
+
+static void update_field_vars(struct hist_trigger_data *hist_data,
+			      struct tracing_map_elt *elt,
+			      struct ring_buffer_event *rbe,
+			      void *rec)
+{
+	__update_field_vars(elt, rbe, rec, hist_data->field_vars,
+			    hist_data->n_field_vars, 0);
+}
+
+static void update_max_vars(struct hist_trigger_data *hist_data,
+			    struct tracing_map_elt *elt,
+			    struct ring_buffer_event *rbe,
+			    void *rec)
+{
+	__update_field_vars(elt, rbe, rec, hist_data->max_vars,
+			    hist_data->n_max_vars, hist_data->n_field_var_str);
+}
+
+static struct hist_field *create_var(struct hist_trigger_data *hist_data,
+				     struct trace_event_file *file,
+				     char *name, int size, const char *type)
+{
+	struct hist_field *var;
+	int idx;
+
+	if (find_var(hist_data, file, name) && !hist_data->remove) {
+		var = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	var = kzalloc(sizeof(struct hist_field), GFP_KERNEL);
+	if (!var) {
+		var = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	idx = tracing_map_add_var(hist_data->map);
+	if (idx < 0) {
+		kfree(var);
+		var = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	var->flags = HIST_FIELD_FL_VAR;
+	var->var.idx = idx;
+	var->var.hist_data = var->hist_data = hist_data;
+	var->size = size;
+	var->var.name = kstrdup(name, GFP_KERNEL);
+	var->type = kstrdup(type, GFP_KERNEL);
+	if (!var->var.name || !var->type) {
+		kfree(var->var.name);
+		kfree(var->type);
+		kfree(var);
+		var = ERR_PTR(-ENOMEM);
+	}
+ out:
+	return var;
+}
+
+static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
+					  struct trace_event_file *file,
+					  char *field_name)
+{
+	struct hist_field *val = NULL, *var = NULL;
+	unsigned long flags = HIST_FIELD_FL_VAR;
+	struct field_var *field_var;
+	int ret = 0;
+
+	if (hist_data->n_field_vars >= SYNTH_FIELDS_MAX) {
+		hist_err("Too many field variables defined: ", field_name);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	val = parse_atom(hist_data, file, field_name, &flags, NULL);
+	if (IS_ERR(val)) {
+		hist_err("Couldn't parse field variable: ", field_name);
+		ret = PTR_ERR(val);
+		goto err;
+	}
+
+	var = create_var(hist_data, file, field_name, val->size, val->type);
+	if (IS_ERR(var)) {
+		hist_err("Couldn't create or find variable: ", field_name);
+		kfree(val);
+		ret = PTR_ERR(var);
+		goto err;
+	}
+
+	field_var = kzalloc(sizeof(struct field_var), GFP_KERNEL);
+	if (!field_var) {
+		kfree(val);
+		kfree(var);
+		ret =  -ENOMEM;
+		goto err;
+	}
+
+	field_var->var = var;
+	field_var->val = val;
+ out:
+	return field_var;
+ err:
+	field_var = ERR_PTR(ret);
+	goto out;
+}
+
+/**
+ * create_target_field_var - Automatically create a variable for a field
+ * @target_hist_data: The target hist trigger
+ * @subsys_name: Optional subsystem name
+ * @event_name: Optional event name
+ * @var_name: The name of the field (and the resulting variable)
+ *
+ * Hist trigger actions fetch data from variables, not directly from
+ * events.  However, for convenience, users are allowed to directly
+ * specify an event field in an action, which will be automatically
+ * converted into a variable on their behalf.
+
+ * This function creates a field variable with the name var_name on
+ * the hist trigger currently being defined on the target event.  If
+ * subsys_name and event_name are specified, this function simply
+ * verifies that they do in fact match the target event subsystem and
+ * event name.
+ *
+ * Return: The variable created for the field.
+ */
+static struct field_var *
+create_target_field_var(struct hist_trigger_data *target_hist_data,
+			char *subsys_name, char *event_name, char *var_name)
+{
+	struct trace_event_file *file = target_hist_data->event_file;
+
+	if (subsys_name) {
+		struct trace_event_call *call;
+
+		if (!event_name)
+			return NULL;
+
+		call = file->event_call;
+
+		if (strcmp(subsys_name, call->class->system) != 0)
+			return NULL;
+
+		if (strcmp(event_name, trace_event_name(call)) != 0)
+			return NULL;
+	}
+
+	return create_field_var(target_hist_data, file, var_name);
+}
+
+static void onmax_print(struct seq_file *m,
+			struct hist_trigger_data *hist_data,
+			struct tracing_map_elt *elt,
+			struct action_data *data)
+{
+	unsigned int i, save_var_idx, max_idx = data->onmax.max_var->var.idx;
+
+	seq_printf(m, "\n\tmax: %10llu", tracing_map_read_var(elt, max_idx));
+
+	for (i = 0; i < hist_data->n_max_vars; i++) {
+		struct hist_field *save_val = hist_data->max_vars[i]->val;
+		struct hist_field *save_var = hist_data->max_vars[i]->var;
+		u64 val;
+
+		save_var_idx = save_var->var.idx;
+
+		val = tracing_map_read_var(elt, save_var_idx);
+
+		if (save_val->flags & HIST_FIELD_FL_STRING) {
+			seq_printf(m, "  %s: %-32s", save_var->var.name,
+				   (char *)(uintptr_t)(val));
+		} else
+			seq_printf(m, "  %s: %10llu", save_var->var.name, val);
+	}
+}
+
+static void onmax_save(struct hist_trigger_data *hist_data,
+		       struct tracing_map_elt *elt, void *rec,
+		       struct ring_buffer_event *rbe,
+		       struct action_data *data, u64 *var_ref_vals)
+{
+	unsigned int max_idx = data->onmax.max_var->var.idx;
+	unsigned int max_var_ref_idx = data->onmax.max_var_ref_idx;
+
+	u64 var_val, max_val;
+
+	var_val = var_ref_vals[max_var_ref_idx];
+	max_val = tracing_map_read_var(elt, max_idx);
+
+	if (var_val <= max_val)
+		return;
+
+	tracing_map_set_var(elt, max_idx, var_val);
+
+	update_max_vars(hist_data, elt, rbe, rec);
+}
+
+static void onmax_destroy(struct action_data *data)
+{
+	unsigned int i;
+
+	destroy_hist_field(data->onmax.max_var, 0);
+	destroy_hist_field(data->onmax.var, 0);
+
+	kfree(data->onmax.var_str);
+	kfree(data->onmax.fn_name);
+
+	for (i = 0; i < data->n_params; i++)
+		kfree(data->params[i]);
+
+	kfree(data);
+}
+
+static int onmax_create(struct hist_trigger_data *hist_data,
+			struct action_data *data)
+{
+	struct trace_event_file *file = hist_data->event_file;
+	struct hist_field *var_field, *ref_field, *max_var;
+	unsigned int var_ref_idx = hist_data->n_var_refs;
+	struct field_var *field_var;
+	char *onmax_var_str, *param;
+	unsigned long flags;
+	unsigned int i;
+	int ret = 0;
+
+	onmax_var_str = data->onmax.var_str;
+	if (onmax_var_str[0] != '$') {
+		hist_err("onmax: For onmax(x), x must be a variable: ", onmax_var_str);
+		return -EINVAL;
+	}
+	onmax_var_str++;
+
+	var_field = find_target_event_var(hist_data, NULL, NULL, onmax_var_str);
+	if (!var_field) {
+		hist_err("onmax: Couldn't find onmax variable: ", onmax_var_str);
+		return -EINVAL;
+	}
+
+	flags = HIST_FIELD_FL_VAR_REF;
+	ref_field = create_hist_field(hist_data, NULL, flags, NULL);
+	if (!ref_field)
+		return -ENOMEM;
+
+	if (init_var_ref(ref_field, var_field, NULL, NULL)) {
+		destroy_hist_field(ref_field, 0);
+		ret = -ENOMEM;
+		goto out;
+	}
+	hist_data->var_refs[hist_data->n_var_refs] = ref_field;
+	ref_field->var_ref_idx = hist_data->n_var_refs++;
+	data->onmax.var = ref_field;
+
+	data->fn = onmax_save;
+	data->onmax.max_var_ref_idx = var_ref_idx;
+	max_var = create_var(hist_data, file, "max", sizeof(u64), "u64");
+	if (IS_ERR(max_var)) {
+		hist_err("onmax: Couldn't create onmax variable: ", "max");
+		ret = PTR_ERR(max_var);
 		goto out;
 	}
+	data->onmax.max_var = max_var;
+
+	for (i = 0; i < data->n_params; i++) {
+		param = kstrdup(data->params[i], GFP_KERNEL);
+		if (!param) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		field_var = create_target_field_var(hist_data, NULL, NULL, param);
+		if (IS_ERR(field_var)) {
+			hist_err("onmax: Couldn't create field variable: ", param);
+			ret = PTR_ERR(field_var);
+			kfree(param);
+			goto out;
+		}
+
+		hist_data->max_vars[hist_data->n_max_vars++] = field_var;
+		if (field_var->val->flags & HIST_FIELD_FL_STRING)
+			hist_data->n_max_var_str++;
+
+		kfree(param);
+	}
+ out:
+	return ret;
+}
+
+static int parse_action_params(char *params, struct action_data *data)
+{
+	char *param, *saved_param;
+	int ret = 0;
+
+	while (params) {
+		if (data->n_params >= SYNTH_FIELDS_MAX)
+			goto out;
+
+		param = strsep(&params, ",");
+		if (!param) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		param = strstrip(param);
+		if (strlen(param) < 2) {
+			hist_err("Invalid action param: ", param);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		saved_param = kstrdup(param, GFP_KERNEL);
+		if (!saved_param) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		data->params[data->n_params++] = saved_param;
+	}
+ out:
+	return ret;
+}
+
+static struct action_data *onmax_parse(char *str)
+{
+	char *onmax_fn_name, *onmax_var_str;
+	struct action_data *data;
+	int ret = -EINVAL;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	onmax_var_str = strsep(&str, ")");
+	if (!onmax_var_str || !str) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	data->onmax.var_str = kstrdup(onmax_var_str, GFP_KERNEL);
+	if (!data->onmax.var_str) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	strsep(&str, ".");
+	if (!str)
+		goto free;
+
+	onmax_fn_name = strsep(&str, "(");
+	if (!onmax_fn_name || !str)
+		goto free;
+
+	if (strncmp(onmax_fn_name, "save", strlen("save")) == 0) {
+		char *params = strsep(&str, ")");
+
+		if (!params) {
+			ret = -EINVAL;
+			goto free;
+		}
+
+		ret = parse_action_params(params, data);
+		if (ret)
+			goto free;
+	} else
+		goto free;
+
+	data->onmax.fn_name = kstrdup(onmax_fn_name, GFP_KERNEL);
+	if (!data->onmax.fn_name) {
+		ret = -ENOMEM;
+		goto free;
+	}
+ out:
+	return data;
+ free:
+	onmax_destroy(data);
+	data = ERR_PTR(ret);
+	goto out;
+}
+
+static void onmatch_destroy(struct action_data *data)
+{
+	unsigned int i;
+
+	mutex_lock(&synth_event_mutex);
+
+	kfree(data->onmatch.match_event);
+	kfree(data->onmatch.match_event_system);
+	kfree(data->onmatch.synth_event_name);
+
+	for (i = 0; i < data->n_params; i++)
+		kfree(data->params[i]);
+
+	if (data->onmatch.synth_event)
+		data->onmatch.synth_event->ref--;
+
+	kfree(data);
+
+	mutex_unlock(&synth_event_mutex);
+}
+
+static void destroy_field_var(struct field_var *field_var)
+{
+	if (!field_var)
+		return;
+
+	destroy_hist_field(field_var->var, 0);
+	destroy_hist_field(field_var->val, 0);
+
+	kfree(field_var);
+}
+
+static void destroy_field_vars(struct hist_trigger_data *hist_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_field_vars; i++)
+		destroy_field_var(hist_data->field_vars[i]);
+}
+
+static void save_field_var(struct hist_trigger_data *hist_data,
+			   struct field_var *field_var)
+{
+	hist_data->field_vars[hist_data->n_field_vars++] = field_var;
+
+	if (field_var->val->flags & HIST_FIELD_FL_STRING)
+		hist_data->n_field_var_str++;
+}
+
+
+static void destroy_synth_var_refs(struct hist_trigger_data *hist_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_synth_var_refs; i++)
+		destroy_hist_field(hist_data->synth_var_refs[i], 0);
+}
+
+static void save_synth_var_ref(struct hist_trigger_data *hist_data,
+			 struct hist_field *var_ref)
+{
+	hist_data->synth_var_refs[hist_data->n_synth_var_refs++] = var_ref;
+
+	hist_data->var_refs[hist_data->n_var_refs] = var_ref;
+	var_ref->var_ref_idx = hist_data->n_var_refs++;
+}
+
+static int check_synth_field(struct synth_event *event,
+			     struct hist_field *hist_field,
+			     unsigned int field_pos)
+{
+	struct synth_field *field;
+
+	if (field_pos >= event->n_fields)
+		return -EINVAL;
+
+	field = event->fields[field_pos];
+
+	if (strcmp(field->type, hist_field->type) != 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct hist_field *
+onmatch_find_var(struct hist_trigger_data *hist_data, struct action_data *data,
+		 char *system, char *event, char *var)
+{
+	struct hist_field *hist_field;
+
+	var++; /* skip '$' */
+
+	hist_field = find_target_event_var(hist_data, system, event, var);
+	if (!hist_field) {
+		if (!system) {
+			system = data->onmatch.match_event_system;
+			event = data->onmatch.match_event;
+		}
+
+		hist_field = find_event_var(hist_data, system, event, var);
+	}
+
+	if (!hist_field)
+		hist_err_event("onmatch: Couldn't find onmatch param: $", system, event, var);
+
+	return hist_field;
+}
+
+static struct hist_field *
+onmatch_create_field_var(struct hist_trigger_data *hist_data,
+			 struct action_data *data, char *system,
+			 char *event, char *var)
+{
+	struct hist_field *hist_field = NULL;
+	struct field_var *field_var;
+
+	/*
+	 * First try to create a field var on the target event (the
+	 * currently being defined).  This will create a variable for
+	 * unqualified fields on the target event, or if qualified,
+	 * target fields that have qualified names matching the target.
+	 */
+	field_var = create_target_field_var(hist_data, system, event, var);
+
+	if (field_var && !IS_ERR(field_var)) {
+		save_field_var(hist_data, field_var);
+		hist_field = field_var->var;
+	} else {
+		field_var = NULL;
+		/*
+		 * If no explicit system.event is specfied, default to
+		 * looking for fields on the onmatch(system.event.xxx)
+		 * event.
+		 */
+		if (!system) {
+			system = data->onmatch.match_event_system;
+			event = data->onmatch.match_event;
+		}
+
+		/*
+		 * At this point, we're looking at a field on another
+		 * event.  Because we can't modify a hist trigger on
+		 * another event to add a variable for a field, we need
+		 * to create a new trigger on that event and create the
+		 * variable at the same time.
+		 */
+		hist_field = create_field_var_hist(hist_data, system, event, var);
+		if (IS_ERR(hist_field))
+			goto free;
+	}
+ out:
+	return hist_field;
+ free:
+	destroy_field_var(field_var);
+	hist_field = NULL;
+	goto out;
+}
+
+static int onmatch_create(struct hist_trigger_data *hist_data,
+			  struct trace_event_file *file,
+			  struct action_data *data)
+{
+	char *event_name, *param, *system = NULL;
+	struct hist_field *hist_field, *var_ref;
+	unsigned int i, var_ref_idx;
+	unsigned int field_pos = 0;
+	struct synth_event *event;
+	int ret = 0;
+
+	mutex_lock(&synth_event_mutex);
+	event = find_synth_event(data->onmatch.synth_event_name);
+	if (!event) {
+		hist_err("onmatch: Couldn't find synthetic event: ", data->onmatch.synth_event_name);
+		mutex_unlock(&synth_event_mutex);
+		return -EINVAL;
+	}
+	event->ref++;
+	mutex_unlock(&synth_event_mutex);
+
+	var_ref_idx = hist_data->n_var_refs;
+
+	for (i = 0; i < data->n_params; i++) {
+		char *p;
+
+		p = param = kstrdup(data->params[i], GFP_KERNEL);
+		if (!param) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		system = strsep(&param, ".");
+		if (!param) {
+			param = (char *)system;
+			system = event_name = NULL;
+		} else {
+			event_name = strsep(&param, ".");
+			if (!param) {
+				kfree(p);
+				ret = -EINVAL;
+				goto err;
+			}
+		}
+
+		if (param[0] == '$')
+			hist_field = onmatch_find_var(hist_data, data, system,
+						      event_name, param);
+		else
+			hist_field = onmatch_create_field_var(hist_data, data,
+							      system,
+							      event_name,
+							      param);
+
+		if (!hist_field) {
+			kfree(p);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		if (check_synth_field(event, hist_field, field_pos) == 0) {
+			var_ref = create_var_ref(hist_field, system, event_name);
+			if (!var_ref) {
+				kfree(p);
+				ret = -ENOMEM;
+				goto err;
+			}
+
+			save_synth_var_ref(hist_data, var_ref);
+			field_pos++;
+			kfree(p);
+			continue;
+		}
+
+		hist_err_event("onmatch: Param type doesn't match synthetic event field type: ",
+			       system, event_name, param);
+		kfree(p);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (field_pos != event->n_fields) {
+		hist_err("onmatch: Param count doesn't match synthetic event field count: ", event->name);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	data->fn = action_trace;
+	data->onmatch.synth_event = event;
+	data->onmatch.var_ref_idx = var_ref_idx;
+ out:
+	return ret;
+ err:
+	mutex_lock(&synth_event_mutex);
+	event->ref--;
+	mutex_unlock(&synth_event_mutex);
+
+	goto out;
+}
+
+static struct action_data *onmatch_parse(struct trace_array *tr, char *str)
+{
+	char *match_event, *match_event_system;
+	char *synth_event_name, *params;
+	struct action_data *data;
+	int ret = -EINVAL;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	match_event = strsep(&str, ")");
+	if (!match_event || !str) {
+		hist_err("onmatch: Missing closing paren: ", match_event);
+		goto free;
+	}
+
+	match_event_system = strsep(&match_event, ".");
+	if (!match_event) {
+		hist_err("onmatch: Missing subsystem for match event: ", match_event_system);
+		goto free;
+	}
+
+	if (IS_ERR(event_file(tr, match_event_system, match_event))) {
+		hist_err_event("onmatch: Invalid subsystem or event name: ",
+			       match_event_system, match_event, NULL);
+		goto free;
+	}
 
-	if (WARN_ON_ONCE(!field))
-		goto out;
+	data->onmatch.match_event = kstrdup(match_event, GFP_KERNEL);
+	if (!data->onmatch.match_event) {
+		ret = -ENOMEM;
+		goto free;
+	}
 
-	if (is_string_field(field)) {
-		flags |= HIST_FIELD_FL_STRING;
+	data->onmatch.match_event_system = kstrdup(match_event_system, GFP_KERNEL);
+	if (!data->onmatch.match_event_system) {
+		ret = -ENOMEM;
+		goto free;
+	}
 
-		if (field->filter_type == FILTER_STATIC_STRING)
-			hist_field->fn = hist_field_string;
-		else if (field->filter_type == FILTER_DYN_STRING)
-			hist_field->fn = hist_field_dynstring;
-		else
-			hist_field->fn = hist_field_pstring;
-	} else {
-		hist_field->fn = select_value_fn(field->size,
-						 field->is_signed);
-		if (!hist_field->fn) {
-			destroy_hist_field(hist_field, 0);
-			return NULL;
-		}
+	strsep(&str, ".");
+	if (!str) {
+		hist_err("onmatch: Missing . after onmatch(): ", str);
+		goto free;
 	}
- out:
-	hist_field->field = field;
-	hist_field->flags = flags;
 
-	return hist_field;
-}
+	synth_event_name = strsep(&str, "(");
+	if (!synth_event_name || !str) {
+		hist_err("onmatch: Missing opening paramlist paren: ", synth_event_name);
+		goto free;
+	}
 
-static void destroy_hist_fields(struct hist_trigger_data *hist_data)
-{
-	unsigned int i;
+	data->onmatch.synth_event_name = kstrdup(synth_event_name, GFP_KERNEL);
+	if (!data->onmatch.synth_event_name) {
+		ret = -ENOMEM;
+		goto free;
+	}
 
-	for (i = 0; i < TRACING_MAP_FIELDS_MAX; i++) {
-		if (hist_data->fields[i]) {
-			destroy_hist_field(hist_data->fields[i], 0);
-			hist_data->fields[i] = NULL;
-		}
+	params = strsep(&str, ")");
+	if (!params || !str || (str && strlen(str))) {
+		hist_err("onmatch: Missing closing paramlist paren: ", params);
+		goto free;
 	}
+
+	ret = parse_action_params(params, data);
+	if (ret)
+		goto free;
+ out:
+	return data;
+ free:
+	onmatch_destroy(data);
+	data = ERR_PTR(ret);
+	goto out;
 }
 
 static int create_hitcount_val(struct hist_trigger_data *hist_data)
 {
 	hist_data->fields[HITCOUNT_IDX] =
-		create_hist_field(NULL, HIST_FIELD_FL_HITCOUNT);
+		create_hist_field(hist_data, NULL, HIST_FIELD_FL_HITCOUNT, NULL);
 	if (!hist_data->fields[HITCOUNT_IDX])
 		return -ENOMEM;
 
 	hist_data->n_vals++;
+	hist_data->n_fields++;
 
 	if (WARN_ON(hist_data->n_vals > TRACING_MAP_VALS_MAX))
 		return -EINVAL;
@@ -466,54 +3826,71 @@ static int create_hitcount_val(struct hist_trigger_data *hist_data)
 	return 0;
 }
 
+static int __create_val_field(struct hist_trigger_data *hist_data,
+			      unsigned int val_idx,
+			      struct trace_event_file *file,
+			      char *var_name, char *field_str,
+			      unsigned long flags)
+{
+	struct hist_field *hist_field;
+	int ret = 0;
+
+	hist_field = parse_expr(hist_data, file, field_str, flags, var_name, 0);
+	if (IS_ERR(hist_field)) {
+		ret = PTR_ERR(hist_field);
+		goto out;
+	}
+
+	hist_data->fields[val_idx] = hist_field;
+
+	++hist_data->n_vals;
+	++hist_data->n_fields;
+
+	if (WARN_ON(hist_data->n_vals > TRACING_MAP_VALS_MAX + TRACING_MAP_VARS_MAX))
+		ret = -EINVAL;
+ out:
+	return ret;
+}
+
 static int create_val_field(struct hist_trigger_data *hist_data,
 			    unsigned int val_idx,
 			    struct trace_event_file *file,
 			    char *field_str)
 {
-	struct ftrace_event_field *field = NULL;
-	unsigned long flags = 0;
-	char *field_name;
-	int ret = 0;
-
 	if (WARN_ON(val_idx >= TRACING_MAP_VALS_MAX))
 		return -EINVAL;
 
-	field_name = strsep(&field_str, ".");
-	if (field_str) {
-		if (strcmp(field_str, "hex") == 0)
-			flags |= HIST_FIELD_FL_HEX;
-		else {
-			ret = -EINVAL;
-			goto out;
-		}
-	}
+	return __create_val_field(hist_data, val_idx, file, NULL, field_str, 0);
+}
 
-	field = trace_find_event_field(file->event_call, field_name);
-	if (!field || !field->size) {
-		ret = -EINVAL;
-		goto out;
-	}
+static int create_var_field(struct hist_trigger_data *hist_data,
+			    unsigned int val_idx,
+			    struct trace_event_file *file,
+			    char *var_name, char *expr_str)
+{
+	unsigned long flags = 0;
 
-	hist_data->fields[val_idx] = create_hist_field(field, flags);
-	if (!hist_data->fields[val_idx]) {
-		ret = -ENOMEM;
-		goto out;
+	if (WARN_ON(val_idx >= TRACING_MAP_VALS_MAX + TRACING_MAP_VARS_MAX))
+		return -EINVAL;
+
+	if (find_var(hist_data, file, var_name) && !hist_data->remove) {
+		hist_err("Variable already defined: ", var_name);
+		return -EINVAL;
 	}
 
-	++hist_data->n_vals;
+	flags |= HIST_FIELD_FL_VAR;
+	hist_data->n_vars++;
+	if (WARN_ON(hist_data->n_vars > TRACING_MAP_VARS_MAX))
+		return -EINVAL;
 
-	if (WARN_ON(hist_data->n_vals > TRACING_MAP_VALS_MAX))
-		ret = -EINVAL;
- out:
-	return ret;
+	return __create_val_field(hist_data, val_idx, file, var_name, expr_str, flags);
 }
 
 static int create_val_fields(struct hist_trigger_data *hist_data,
 			     struct trace_event_file *file)
 {
 	char *fields_str, *field_str;
-	unsigned int i, j;
+	unsigned int i, j = 1;
 	int ret;
 
 	ret = create_hitcount_val(hist_data);
@@ -533,12 +3910,15 @@ static int create_val_fields(struct hist_trigger_data *hist_data,
 		field_str = strsep(&fields_str, ",");
 		if (!field_str)
 			break;
+
 		if (strcmp(field_str, "hitcount") == 0)
 			continue;
+
 		ret = create_val_field(hist_data, j++, file, field_str);
 		if (ret)
 			goto out;
 	}
+
 	if (fields_str && (strcmp(fields_str, "hitcount") != 0))
 		ret = -EINVAL;
  out:
@@ -551,12 +3931,13 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 			    struct trace_event_file *file,
 			    char *field_str)
 {
-	struct ftrace_event_field *field = NULL;
+	struct hist_field *hist_field = NULL;
+
 	unsigned long flags = 0;
 	unsigned int key_size;
 	int ret = 0;
 
-	if (WARN_ON(key_idx >= TRACING_MAP_FIELDS_MAX))
+	if (WARN_ON(key_idx >= HIST_FIELDS_MAX))
 		return -EINVAL;
 
 	flags |= HIST_FIELD_FL_KEY;
@@ -564,57 +3945,40 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 	if (strcmp(field_str, "stacktrace") == 0) {
 		flags |= HIST_FIELD_FL_STACKTRACE;
 		key_size = sizeof(unsigned long) * HIST_STACKTRACE_DEPTH;
+		hist_field = create_hist_field(hist_data, NULL, flags, NULL);
 	} else {
-		char *field_name = strsep(&field_str, ".");
-
-		if (field_str) {
-			if (strcmp(field_str, "hex") == 0)
-				flags |= HIST_FIELD_FL_HEX;
-			else if (strcmp(field_str, "sym") == 0)
-				flags |= HIST_FIELD_FL_SYM;
-			else if (strcmp(field_str, "sym-offset") == 0)
-				flags |= HIST_FIELD_FL_SYM_OFFSET;
-			else if ((strcmp(field_str, "execname") == 0) &&
-				 (strcmp(field_name, "common_pid") == 0))
-				flags |= HIST_FIELD_FL_EXECNAME;
-			else if (strcmp(field_str, "syscall") == 0)
-				flags |= HIST_FIELD_FL_SYSCALL;
-			else if (strcmp(field_str, "log2") == 0)
-				flags |= HIST_FIELD_FL_LOG2;
-			else {
-				ret = -EINVAL;
-				goto out;
-			}
+		hist_field = parse_expr(hist_data, file, field_str, flags,
+					NULL, 0);
+		if (IS_ERR(hist_field)) {
+			ret = PTR_ERR(hist_field);
+			goto out;
 		}
 
-		field = trace_find_event_field(file->event_call, field_name);
-		if (!field || !field->size) {
+		if (hist_field->flags & HIST_FIELD_FL_VAR_REF) {
+			hist_err("Using variable references as keys not supported: ", field_str);
+			destroy_hist_field(hist_field, 0);
 			ret = -EINVAL;
 			goto out;
 		}
 
-		if (is_string_field(field))
-			key_size = MAX_FILTER_STR_VAL;
-		else
-			key_size = field->size;
+		key_size = hist_field->size;
 	}
 
-	hist_data->fields[key_idx] = create_hist_field(field, flags);
-	if (!hist_data->fields[key_idx]) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	hist_data->fields[key_idx] = hist_field;
 
 	key_size = ALIGN(key_size, sizeof(u64));
 	hist_data->fields[key_idx]->size = key_size;
 	hist_data->fields[key_idx]->offset = key_offset;
+
 	hist_data->key_size += key_size;
+
 	if (hist_data->key_size > HIST_KEY_SIZE_MAX) {
 		ret = -EINVAL;
 		goto out;
 	}
 
 	hist_data->n_keys++;
+	hist_data->n_fields++;
 
 	if (WARN_ON(hist_data->n_keys > TRACING_MAP_KEYS_MAX))
 		return -EINVAL;
@@ -658,21 +4022,113 @@ static int create_key_fields(struct hist_trigger_data *hist_data,
 	return ret;
 }
 
+static int create_var_fields(struct hist_trigger_data *hist_data,
+			     struct trace_event_file *file)
+{
+	unsigned int i, j = hist_data->n_vals;
+	int ret = 0;
+
+	unsigned int n_vars = hist_data->attrs->var_defs.n_vars;
+
+	for (i = 0; i < n_vars; i++) {
+		char *var_name = hist_data->attrs->var_defs.name[i];
+		char *expr = hist_data->attrs->var_defs.expr[i];
+
+		ret = create_var_field(hist_data, j++, file, var_name, expr);
+		if (ret)
+			goto out;
+	}
+ out:
+	return ret;
+}
+
+static void free_var_defs(struct hist_trigger_data *hist_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->attrs->var_defs.n_vars; i++) {
+		kfree(hist_data->attrs->var_defs.name[i]);
+		kfree(hist_data->attrs->var_defs.expr[i]);
+	}
+
+	hist_data->attrs->var_defs.n_vars = 0;
+}
+
+static int parse_var_defs(struct hist_trigger_data *hist_data)
+{
+	char *s, *str, *var_name, *field_str;
+	unsigned int i, j, n_vars = 0;
+	int ret = 0;
+
+	for (i = 0; i < hist_data->attrs->n_assignments; i++) {
+		str = hist_data->attrs->assignment_str[i];
+		for (j = 0; j < TRACING_MAP_VARS_MAX; j++) {
+			field_str = strsep(&str, ",");
+			if (!field_str)
+				break;
+
+			var_name = strsep(&field_str, "=");
+			if (!var_name || !field_str) {
+				hist_err("Malformed assignment: ", var_name);
+				ret = -EINVAL;
+				goto free;
+			}
+
+			if (n_vars == TRACING_MAP_VARS_MAX) {
+				hist_err("Too many variables defined: ", var_name);
+				ret = -EINVAL;
+				goto free;
+			}
+
+			s = kstrdup(var_name, GFP_KERNEL);
+			if (!s) {
+				ret = -ENOMEM;
+				goto free;
+			}
+			hist_data->attrs->var_defs.name[n_vars] = s;
+
+			s = kstrdup(field_str, GFP_KERNEL);
+			if (!s) {
+				kfree(hist_data->attrs->var_defs.name[n_vars]);
+				ret = -ENOMEM;
+				goto free;
+			}
+			hist_data->attrs->var_defs.expr[n_vars++] = s;
+
+			hist_data->attrs->var_defs.n_vars = n_vars;
+		}
+	}
+
+	return ret;
+ free:
+	free_var_defs(hist_data);
+
+	return ret;
+}
+
 static int create_hist_fields(struct hist_trigger_data *hist_data,
 			      struct trace_event_file *file)
 {
 	int ret;
 
+	ret = parse_var_defs(hist_data);
+	if (ret)
+		goto out;
+
 	ret = create_val_fields(hist_data, file);
 	if (ret)
 		goto out;
 
-	ret = create_key_fields(hist_data, file);
+	ret = create_var_fields(hist_data, file);
 	if (ret)
 		goto out;
 
-	hist_data->n_fields = hist_data->n_vals + hist_data->n_keys;
+	ret = create_key_fields(hist_data, file);
+	if (ret)
+		goto out;
  out:
+	free_var_defs(hist_data);
+
 	return ret;
 }
 
@@ -695,7 +4151,7 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 	char *fields_str = hist_data->attrs->sort_key_str;
 	struct tracing_map_sort_key *sort_key;
 	int descending, ret = 0;
-	unsigned int i, j;
+	unsigned int i, j, k;
 
 	hist_data->n_sort_keys = 1; /* we always have at least one, hitcount */
 
@@ -743,12 +4199,19 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 			continue;
 		}
 
-		for (j = 1; j < hist_data->n_fields; j++) {
+		for (j = 1, k = 1; j < hist_data->n_fields; j++) {
+			unsigned int idx;
+
 			hist_field = hist_data->fields[j];
+			if (hist_field->flags & HIST_FIELD_FL_VAR)
+				continue;
+
+			idx = k++;
+
 			test_name = hist_field_name(hist_field, 0);
 
 			if (strcmp(field_name, test_name) == 0) {
-				sort_key->field_idx = j;
+				sort_key->field_idx = idx;
 				descending = is_descending(field_str);
 				if (descending < 0) {
 					ret = descending;
@@ -763,16 +4226,230 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 			break;
 		}
 	}
-	hist_data->n_sort_keys = i;
- out:
-	return ret;
+
+	hist_data->n_sort_keys = i;
+ out:
+	return ret;
+}
+
+static void destroy_actions(struct hist_trigger_data *hist_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *data = hist_data->actions[i];
+
+		if (data->fn == action_trace)
+			onmatch_destroy(data);
+		else if (data->fn == onmax_save)
+			onmax_destroy(data);
+		else
+			kfree(data);
+	}
+}
+
+static int parse_actions(struct hist_trigger_data *hist_data)
+{
+	struct trace_array *tr = hist_data->event_file->tr;
+	struct action_data *data;
+	unsigned int i;
+	int ret = 0;
+	char *str;
+
+	for (i = 0; i < hist_data->attrs->n_actions; i++) {
+		str = hist_data->attrs->action_str[i];
+
+		if (strncmp(str, "onmatch(", strlen("onmatch(")) == 0) {
+			char *action_str = str + strlen("onmatch(");
+
+			data = onmatch_parse(tr, action_str);
+			if (IS_ERR(data)) {
+				ret = PTR_ERR(data);
+				break;
+			}
+			data->fn = action_trace;
+		} else if (strncmp(str, "onmax(", strlen("onmax(")) == 0) {
+			char *action_str = str + strlen("onmax(");
+
+			data = onmax_parse(action_str);
+			if (IS_ERR(data)) {
+				ret = PTR_ERR(data);
+				break;
+			}
+			data->fn = onmax_save;
+		} else {
+			ret = -EINVAL;
+			break;
+		}
+
+		hist_data->actions[hist_data->n_actions++] = data;
+	}
+
+	return ret;
+}
+
+static int create_actions(struct hist_trigger_data *hist_data,
+			  struct trace_event_file *file)
+{
+	struct action_data *data;
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < hist_data->attrs->n_actions; i++) {
+		data = hist_data->actions[i];
+
+		if (data->fn == action_trace) {
+			ret = onmatch_create(hist_data, file, data);
+			if (ret)
+				return ret;
+		} else if (data->fn == onmax_save) {
+			ret = onmax_create(hist_data, data);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+static void print_actions(struct seq_file *m,
+			  struct hist_trigger_data *hist_data,
+			  struct tracing_map_elt *elt)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *data = hist_data->actions[i];
+
+		if (data->fn == onmax_save)
+			onmax_print(m, hist_data, elt, data);
+	}
+}
+
+static void print_onmax_spec(struct seq_file *m,
+			     struct hist_trigger_data *hist_data,
+			     struct action_data *data)
+{
+	unsigned int i;
+
+	seq_puts(m, ":onmax(");
+	seq_printf(m, "%s", data->onmax.var_str);
+	seq_printf(m, ").%s(", data->onmax.fn_name);
+
+	for (i = 0; i < hist_data->n_max_vars; i++) {
+		seq_printf(m, "%s", hist_data->max_vars[i]->var->var.name);
+		if (i < hist_data->n_max_vars - 1)
+			seq_puts(m, ",");
+	}
+	seq_puts(m, ")");
+}
+
+static void print_onmatch_spec(struct seq_file *m,
+			       struct hist_trigger_data *hist_data,
+			       struct action_data *data)
+{
+	unsigned int i;
+
+	seq_printf(m, ":onmatch(%s.%s).", data->onmatch.match_event_system,
+		   data->onmatch.match_event);
+
+	seq_printf(m, "%s(", data->onmatch.synth_event->name);
+
+	for (i = 0; i < data->n_params; i++) {
+		if (i)
+			seq_puts(m, ",");
+		seq_printf(m, "%s", data->params[i]);
+	}
+
+	seq_puts(m, ")");
+}
+
+static bool actions_match(struct hist_trigger_data *hist_data,
+			  struct hist_trigger_data *hist_data_test)
+{
+	unsigned int i, j;
+
+	if (hist_data->n_actions != hist_data_test->n_actions)
+		return false;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *data = hist_data->actions[i];
+		struct action_data *data_test = hist_data_test->actions[i];
+
+		if (data->fn != data_test->fn)
+			return false;
+
+		if (data->n_params != data_test->n_params)
+			return false;
+
+		for (j = 0; j < data->n_params; j++) {
+			if (strcmp(data->params[j], data_test->params[j]) != 0)
+				return false;
+		}
+
+		if (data->fn == action_trace) {
+			if (strcmp(data->onmatch.synth_event_name,
+				   data_test->onmatch.synth_event_name) != 0)
+				return false;
+			if (strcmp(data->onmatch.match_event_system,
+				   data_test->onmatch.match_event_system) != 0)
+				return false;
+			if (strcmp(data->onmatch.match_event,
+				   data_test->onmatch.match_event) != 0)
+				return false;
+		} else if (data->fn == onmax_save) {
+			if (strcmp(data->onmax.var_str,
+				   data_test->onmax.var_str) != 0)
+				return false;
+			if (strcmp(data->onmax.fn_name,
+				   data_test->onmax.fn_name) != 0)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+
+static void print_actions_spec(struct seq_file *m,
+			       struct hist_trigger_data *hist_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *data = hist_data->actions[i];
+
+		if (data->fn == action_trace)
+			print_onmatch_spec(m, hist_data, data);
+		else if (data->fn == onmax_save)
+			print_onmax_spec(m, hist_data, data);
+	}
+}
+
+static void destroy_field_var_hists(struct hist_trigger_data *hist_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_field_var_hists; i++) {
+		kfree(hist_data->field_var_hists[i]->cmd);
+		kfree(hist_data->field_var_hists[i]);
+	}
 }
 
 static void destroy_hist_data(struct hist_trigger_data *hist_data)
 {
+	if (!hist_data)
+		return;
+
 	destroy_hist_trigger_attrs(hist_data->attrs);
 	destroy_hist_fields(hist_data);
 	tracing_map_destroy(hist_data->map);
+
+	destroy_actions(hist_data);
+	destroy_field_vars(hist_data);
+	destroy_field_var_hists(hist_data);
+	destroy_synth_var_refs(hist_data);
+
 	kfree(hist_data);
 }
 
@@ -781,7 +4458,7 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
 	struct tracing_map *map = hist_data->map;
 	struct ftrace_event_field *field;
 	struct hist_field *hist_field;
-	int i, idx;
+	int i, idx = 0;
 
 	for_each_hist_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
@@ -792,6 +4469,9 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
 
 			if (hist_field->flags & HIST_FIELD_FL_STACKTRACE)
 				cmp_fn = tracing_map_cmp_none;
+			else if (!field)
+				cmp_fn = tracing_map_cmp_num(hist_field->size,
+							     hist_field->is_signed);
 			else if (is_string_field(field))
 				cmp_fn = tracing_map_cmp_string;
 			else
@@ -800,36 +4480,29 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
 			idx = tracing_map_add_key_field(map,
 							hist_field->offset,
 							cmp_fn);
-
-		} else
+		} else if (!(hist_field->flags & HIST_FIELD_FL_VAR))
 			idx = tracing_map_add_sum_field(map);
 
 		if (idx < 0)
 			return idx;
-	}
-
-	return 0;
-}
-
-static bool need_tracing_map_ops(struct hist_trigger_data *hist_data)
-{
-	struct hist_field *key_field;
-	unsigned int i;
-
-	for_each_hist_key_field(i, hist_data) {
-		key_field = hist_data->fields[i];
 
-		if (key_field->flags & HIST_FIELD_FL_EXECNAME)
-			return true;
+		if (hist_field->flags & HIST_FIELD_FL_VAR) {
+			idx = tracing_map_add_var(map);
+			if (idx < 0)
+				return idx;
+			hist_field->var.idx = idx;
+			hist_field->var.hist_data = hist_data;
+		}
 	}
 
-	return false;
+	return 0;
 }
 
 static struct hist_trigger_data *
 create_hist_data(unsigned int map_bits,
 		 struct hist_trigger_attrs *attrs,
-		 struct trace_event_file *file)
+		 struct trace_event_file *file,
+		 bool remove)
 {
 	const struct tracing_map_ops *map_ops = NULL;
 	struct hist_trigger_data *hist_data;
@@ -840,6 +4513,12 @@ create_hist_data(unsigned int map_bits,
 		return ERR_PTR(-ENOMEM);
 
 	hist_data->attrs = attrs;
+	hist_data->remove = remove;
+	hist_data->event_file = file;
+
+	ret = parse_actions(hist_data);
+	if (ret)
+		goto free;
 
 	ret = create_hist_fields(hist_data, file);
 	if (ret)
@@ -849,8 +4528,7 @@ create_hist_data(unsigned int map_bits,
 	if (ret)
 		goto free;
 
-	if (need_tracing_map_ops(hist_data))
-		map_ops = &hist_trigger_elt_comm_ops;
+	map_ops = &hist_trigger_elt_data_ops;
 
 	hist_data->map = tracing_map_create(map_bits, hist_data->key_size,
 					    map_ops, hist_data);
@@ -863,12 +4541,6 @@ create_hist_data(unsigned int map_bits,
 	ret = create_tracing_map_fields(hist_data);
 	if (ret)
 		goto free;
-
-	ret = tracing_map_init(hist_data->map);
-	if (ret)
-		goto free;
-
-	hist_data->event_file = file;
  out:
 	return hist_data;
  free:
@@ -882,18 +4554,39 @@ create_hist_data(unsigned int map_bits,
 }
 
 static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
-				    struct tracing_map_elt *elt,
-				    void *rec)
+				    struct tracing_map_elt *elt, void *rec,
+				    struct ring_buffer_event *rbe,
+				    u64 *var_ref_vals)
 {
+	struct hist_elt_data *elt_data;
 	struct hist_field *hist_field;
-	unsigned int i;
+	unsigned int i, var_idx;
 	u64 hist_val;
 
+	elt_data = elt->private_data;
+	elt_data->var_ref_vals = var_ref_vals;
+
 	for_each_hist_val_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
-		hist_val = hist_field->fn(hist_field, rec);
+		hist_val = hist_field->fn(hist_field, elt, rbe, rec);
+		if (hist_field->flags & HIST_FIELD_FL_VAR) {
+			var_idx = hist_field->var.idx;
+			tracing_map_set_var(elt, var_idx, hist_val);
+			continue;
+		}
 		tracing_map_update_sum(elt, i, hist_val);
 	}
+
+	for_each_hist_key_field(i, hist_data) {
+		hist_field = hist_data->fields[i];
+		if (hist_field->flags & HIST_FIELD_FL_VAR) {
+			hist_val = hist_field->fn(hist_field, elt, rbe, rec);
+			var_idx = hist_field->var.idx;
+			tracing_map_set_var(elt, var_idx, hist_val);
+		}
+	}
+
+	update_field_vars(hist_data, elt, rbe, rec);
 }
 
 static inline void add_to_key(char *compound_key, void *key,
@@ -920,15 +4613,31 @@ static inline void add_to_key(char *compound_key, void *key,
 	memcpy(compound_key + key_field->offset, key, size);
 }
 
-static void event_hist_trigger(struct event_trigger_data *data, void *rec)
+static void
+hist_trigger_actions(struct hist_trigger_data *hist_data,
+		     struct tracing_map_elt *elt, void *rec,
+		     struct ring_buffer_event *rbe, u64 *var_ref_vals)
+{
+	struct action_data *data;
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		data = hist_data->actions[i];
+		data->fn(hist_data, elt, rec, rbe, data, var_ref_vals);
+	}
+}
+
+static void event_hist_trigger(struct event_trigger_data *data, void *rec,
+			       struct ring_buffer_event *rbe)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
 	bool use_compound_key = (hist_data->n_keys > 1);
 	unsigned long entries[HIST_STACKTRACE_DEPTH];
+	u64 var_ref_vals[TRACING_MAP_VARS_MAX];
 	char compound_key[HIST_KEY_SIZE_MAX];
+	struct tracing_map_elt *elt = NULL;
 	struct stack_trace stacktrace;
 	struct hist_field *key_field;
-	struct tracing_map_elt *elt;
 	u64 field_contents;
 	void *key = NULL;
 	unsigned int i;
@@ -949,7 +4658,7 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec)
 
 			key = entries;
 		} else {
-			field_contents = key_field->fn(key_field, rec);
+			field_contents = key_field->fn(key_field, elt, rbe, rec);
 			if (key_field->flags & HIST_FIELD_FL_STRING) {
 				key = (void *)(unsigned long)field_contents;
 				use_compound_key = true;
@@ -964,9 +4673,18 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec)
 	if (use_compound_key)
 		key = compound_key;
 
+	if (hist_data->n_var_refs &&
+	    !resolve_var_refs(hist_data, key, var_ref_vals, false))
+		return;
+
 	elt = tracing_map_insert(hist_data->map, key);
-	if (elt)
-		hist_trigger_elt_update(hist_data, elt, rec);
+	if (!elt)
+		return;
+
+	hist_trigger_elt_update(hist_data, elt, rec, rbe, var_ref_vals);
+
+	if (resolve_var_refs(hist_data, key, var_ref_vals, true))
+		hist_trigger_actions(hist_data, elt, rec, rbe, var_ref_vals);
 }
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
@@ -1023,7 +4741,13 @@ hist_trigger_entry_print(struct seq_file *m,
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
@@ -1067,6 +4791,10 @@ hist_trigger_entry_print(struct seq_file *m,
 	for (i = 1; i < hist_data->n_vals; i++) {
 		field_name = hist_field_name(hist_data->fields[i], 0);
 
+		if (hist_data->fields[i]->flags & HIST_FIELD_FL_VAR ||
+		    hist_data->fields[i]->flags & HIST_FIELD_FL_EXPR)
+			continue;
+
 		if (hist_data->fields[i]->flags & HIST_FIELD_FL_HEX) {
 			seq_printf(m, "  %s: %10llx", field_name,
 				   tracing_map_read_sum(elt, i));
@@ -1076,6 +4804,8 @@ hist_trigger_entry_print(struct seq_file *m,
 		}
 	}
 
+	print_actions(m, hist_data, elt);
+
 	seq_puts(m, "\n");
 }
 
@@ -1144,6 +4874,11 @@ static int hist_show(struct seq_file *m, void *v)
 			hist_trigger_show(m, data, n++);
 	}
 
+	if (have_hist_err()) {
+		seq_printf(m, "\nERROR: %s\n", hist_err_str);
+		seq_printf(m, "  Last command: %s\n", last_hist_cmd);
+	}
+
  out_unlock:
 	mutex_unlock(&event_mutex);
 
@@ -1162,37 +4897,22 @@ const struct file_operations event_hist_fops = {
 	.release = single_release,
 };
 
-static const char *get_hist_field_flags(struct hist_field *hist_field)
-{
-	const char *flags_str = NULL;
-
-	if (hist_field->flags & HIST_FIELD_FL_HEX)
-		flags_str = "hex";
-	else if (hist_field->flags & HIST_FIELD_FL_SYM)
-		flags_str = "sym";
-	else if (hist_field->flags & HIST_FIELD_FL_SYM_OFFSET)
-		flags_str = "sym-offset";
-	else if (hist_field->flags & HIST_FIELD_FL_EXECNAME)
-		flags_str = "execname";
-	else if (hist_field->flags & HIST_FIELD_FL_SYSCALL)
-		flags_str = "syscall";
-	else if (hist_field->flags & HIST_FIELD_FL_LOG2)
-		flags_str = "log2";
-
-	return flags_str;
-}
-
 static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 {
 	const char *field_name = hist_field_name(hist_field, 0);
 
-	seq_printf(m, "%s", field_name);
-	if (hist_field->flags) {
-		const char *flags_str = get_hist_field_flags(hist_field);
-
-		if (flags_str)
-			seq_printf(m, ".%s", flags_str);
-	}
+	if (hist_field->var.name)
+		seq_printf(m, "%s=", hist_field->var.name);
+
+	if (hist_field->flags & HIST_FIELD_FL_CPU)
+		seq_puts(m, "cpu");
+	else if (field_name) {
+		if (hist_field->flags & HIST_FIELD_FL_VAR_REF ||
+		    hist_field->flags & HIST_FIELD_FL_ALIAS)
+			seq_putc(m, '$');
+		seq_printf(m, "%s", field_name);
+	} else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP)
+		seq_puts(m, "common_timestamp");
 }
 
 static int event_hist_trigger_print(struct seq_file *m,
@@ -1200,7 +4920,8 @@ static int event_hist_trigger_print(struct seq_file *m,
 				    struct event_trigger_data *data)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
-	struct hist_field *key_field;
+	struct hist_field *field;
+	bool have_var = false;
 	unsigned int i;
 
 	seq_puts(m, "hist:");
@@ -1211,25 +4932,47 @@ static int event_hist_trigger_print(struct seq_file *m,
 	seq_puts(m, "keys=");
 
 	for_each_hist_key_field(i, hist_data) {
-		key_field = hist_data->fields[i];
+		field = hist_data->fields[i];
 
 		if (i > hist_data->n_vals)
 			seq_puts(m, ",");
 
-		if (key_field->flags & HIST_FIELD_FL_STACKTRACE)
+		if (field->flags & HIST_FIELD_FL_STACKTRACE)
 			seq_puts(m, "stacktrace");
 		else
-			hist_field_print(m, key_field);
+			hist_field_print(m, field);
 	}
 
 	seq_puts(m, ":vals=");
 
 	for_each_hist_val_field(i, hist_data) {
+		field = hist_data->fields[i];
+		if (field->flags & HIST_FIELD_FL_VAR) {
+			have_var = true;
+			continue;
+		}
+
 		if (i == HITCOUNT_IDX)
 			seq_puts(m, "hitcount");
 		else {
 			seq_puts(m, ",");
-			hist_field_print(m, hist_data->fields[i]);
+			hist_field_print(m, field);
+		}
+	}
+
+	if (have_var) {
+		unsigned int n = 0;
+
+		seq_puts(m, ":");
+
+		for_each_hist_val_field(i, hist_data) {
+			field = hist_data->fields[i];
+
+			if (field->flags & HIST_FIELD_FL_VAR) {
+				if (n++)
+					seq_puts(m, ",");
+				hist_field_print(m, field);
+			}
 		}
 	}
 
@@ -1237,28 +4980,36 @@ static int event_hist_trigger_print(struct seq_file *m,
 
 	for (i = 0; i < hist_data->n_sort_keys; i++) {
 		struct tracing_map_sort_key *sort_key;
+		unsigned int idx, first_key_idx;
+
+		/* skip VAR vals */
+		first_key_idx = hist_data->n_vals - hist_data->n_vars;
 
 		sort_key = &hist_data->sort_keys[i];
+		idx = sort_key->field_idx;
+
+		if (WARN_ON(idx >= HIST_FIELDS_MAX))
+			return -EINVAL;
 
 		if (i > 0)
 			seq_puts(m, ",");
 
-		if (sort_key->field_idx == HITCOUNT_IDX)
+		if (idx == HITCOUNT_IDX)
 			seq_puts(m, "hitcount");
 		else {
-			unsigned int idx = sort_key->field_idx;
-
-			if (WARN_ON(idx >= TRACING_MAP_FIELDS_MAX))
-				return -EINVAL;
-
+			if (idx >= first_key_idx)
+				idx += hist_data->n_vars;
 			hist_field_print(m, hist_data->fields[idx]);
 		}
 
 		if (sort_key->descending)
 			seq_puts(m, ".descending");
 	}
-
 	seq_printf(m, ":size=%u", (1 << hist_data->map->map_bits));
+	if (hist_data->enable_timestamps)
+		seq_printf(m, ":clock=%s", hist_data->attrs->clock);
+
+	print_actions_spec(m, hist_data);
 
 	if (data->filter_str)
 		seq_printf(m, " if %s", data->filter_str);
@@ -1286,6 +5037,21 @@ static int event_hist_trigger_init(struct event_trigger_ops *ops,
 	return 0;
 }
 
+static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
+{
+	struct trace_event_file *file;
+	unsigned int i;
+	char *cmd;
+	int ret;
+
+	for (i = 0; i < hist_data->n_field_var_hists; i++) {
+		file = hist_data->field_var_hists[i]->hist_data->event_file;
+		cmd = hist_data->field_var_hists[i]->cmd;
+		ret = event_hist_trigger_func(&trigger_hist_cmd, file,
+					      "!hist", "hist", cmd);
+	}
+}
+
 static void event_hist_trigger_free(struct event_trigger_ops *ops,
 				    struct event_trigger_data *data)
 {
@@ -1298,7 +5064,13 @@ static void event_hist_trigger_free(struct event_trigger_ops *ops,
 	if (!data->ref) {
 		if (data->name)
 			del_named_trigger(data);
+
 		trigger_data_free(data);
+
+		remove_hist_vars(hist_data);
+
+		unregister_field_var_hists(hist_data);
+
 		destroy_hist_data(hist_data);
 	}
 }
@@ -1425,6 +5197,15 @@ static bool hist_trigger_match(struct event_trigger_data *data,
 			return false;
 		if (key_field->offset != key_field_test->offset)
 			return false;
+		if (key_field->size != key_field_test->size)
+			return false;
+		if (key_field->is_signed != key_field_test->is_signed)
+			return false;
+		if (!!key_field->var.name != !!key_field_test->var.name)
+			return false;
+		if (key_field->var.name &&
+		    strcmp(key_field->var.name, key_field_test->var.name) != 0)
+			return false;
 	}
 
 	for (i = 0; i < hist_data->n_sort_keys; i++) {
@@ -1440,6 +5221,9 @@ static bool hist_trigger_match(struct event_trigger_data *data,
 	    (strcmp(data->filter_str, data_test->filter_str) != 0))
 		return false;
 
+	if (!actions_match(hist_data, hist_data_test))
+		return false;
+
 	return true;
 }
 
@@ -1456,6 +5240,7 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 		if (named_data) {
 			if (!hist_trigger_match(data, named_data, named_data,
 						true)) {
+				hist_err("Named hist trigger doesn't match existing named trigger (includes variables): ", hist_data->attrs->name);
 				ret = -EINVAL;
 				goto out;
 			}
@@ -1475,13 +5260,16 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 				test->paused = false;
 			else if (hist_data->attrs->clear)
 				hist_clear(test);
-			else
+			else {
+				hist_err("Hist trigger already exists", NULL);
 				ret = -EEXIST;
+			}
 			goto out;
 		}
 	}
  new:
 	if (hist_data->attrs->cont || hist_data->attrs->clear) {
+		hist_err("Can't clear or continue a nonexistent hist trigger", NULL);
 		ret = -ENOENT;
 		goto out;
 	}
@@ -1490,7 +5278,6 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 		data->paused = true;
 
 	if (named_data) {
-		destroy_hist_data(data->private_data);
 		data->private_data = named_data->private_data;
 		set_named_trigger_data(data, named_data);
 		data->ops = &event_hist_trigger_named_ops;
@@ -1502,8 +5289,32 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 			goto out;
 	}
 
-	list_add_rcu(&data->list, &file->triggers);
+	if (hist_data->enable_timestamps) {
+		char *clock = hist_data->attrs->clock;
+
+		ret = tracing_set_clock(file->tr, hist_data->attrs->clock);
+		if (ret) {
+			hist_err("Couldn't set trace_clock: ", clock);
+			goto out;
+		}
+
+		tracing_set_time_stamp_abs(file->tr, true);
+	}
+
+	if (named_data)
+		destroy_hist_data(hist_data);
+
 	ret++;
+ out:
+	return ret;
+}
+
+static int hist_trigger_enable(struct event_trigger_data *data,
+			       struct trace_event_file *file)
+{
+	int ret = 0;
+
+	list_add_tail_rcu(&data->list, &file->triggers);
 
 	update_cond_flag(file);
 
@@ -1512,10 +5323,55 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 		update_cond_flag(file);
 		ret--;
 	}
- out:
+
 	return ret;
 }
 
+static bool have_hist_trigger_match(struct event_trigger_data *data,
+				    struct trace_event_file *file)
+{
+	struct hist_trigger_data *hist_data = data->private_data;
+	struct event_trigger_data *test, *named_data = NULL;
+	bool match = false;
+
+	if (hist_data->attrs->name)
+		named_data = find_named_trigger(hist_data->attrs->name);
+
+	list_for_each_entry_rcu(test, &file->triggers, list) {
+		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			if (hist_trigger_match(data, test, named_data, false)) {
+				match = true;
+				break;
+			}
+		}
+	}
+
+	return match;
+}
+
+static bool hist_trigger_check_refs(struct event_trigger_data *data,
+				    struct trace_event_file *file)
+{
+	struct hist_trigger_data *hist_data = data->private_data;
+	struct event_trigger_data *test, *named_data = NULL;
+
+	if (hist_data->attrs->name)
+		named_data = find_named_trigger(hist_data->attrs->name);
+
+	list_for_each_entry_rcu(test, &file->triggers, list) {
+		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			if (!hist_trigger_match(data, test, named_data, false))
+				continue;
+			hist_data = test->private_data;
+			if (check_var_refs(hist_data))
+				return true;
+			break;
+		}
+	}
+
+	return false;
+}
+
 static void hist_unregister_trigger(char *glob, struct event_trigger_ops *ops,
 				    struct event_trigger_data *data,
 				    struct trace_event_file *file)
@@ -1541,17 +5397,55 @@ static void hist_unregister_trigger(char *glob, struct event_trigger_ops *ops,
 
 	if (unregistered && test->ops->free)
 		test->ops->free(test->ops, test);
+
+	if (hist_data->enable_timestamps) {
+		if (!hist_data->remove || unregistered)
+			tracing_set_time_stamp_abs(file->tr, false);
+	}
+}
+
+static bool hist_file_check_refs(struct trace_event_file *file)
+{
+	struct hist_trigger_data *hist_data;
+	struct event_trigger_data *test;
+
+	list_for_each_entry_rcu(test, &file->triggers, list) {
+		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			hist_data = test->private_data;
+			if (check_var_refs(hist_data))
+				return true;
+		}
+	}
+
+	return false;
 }
 
 static void hist_unreg_all(struct trace_event_file *file)
 {
 	struct event_trigger_data *test, *n;
+	struct hist_trigger_data *hist_data;
+	struct synth_event *se;
+	const char *se_name;
+
+	if (hist_file_check_refs(file))
+		return;
 
 	list_for_each_entry_safe(test, n, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			hist_data = test->private_data;
 			list_del_rcu(&test->list);
 			trace_event_trigger_enable_disable(file, 0);
+
+			mutex_lock(&synth_event_mutex);
+			se_name = trace_event_name(file->event_call);
+			se = find_synth_event(se_name);
+			if (se)
+				se->ref--;
+			mutex_unlock(&synth_event_mutex);
+
 			update_cond_flag(file);
+			if (hist_data->enable_timestamps)
+				tracing_set_time_stamp_abs(file->tr, false);
 			if (test->ops->free)
 				test->ops->free(test->ops, test);
 		}
@@ -1567,16 +5461,54 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	struct hist_trigger_attrs *attrs;
 	struct event_trigger_ops *trigger_ops;
 	struct hist_trigger_data *hist_data;
-	char *trigger;
+	struct synth_event *se;
+	const char *se_name;
+	bool remove = false;
+	char *trigger, *p;
 	int ret = 0;
 
+	if (glob && strlen(glob)) {
+		last_cmd_set(param);
+		hist_err_clear();
+	}
+
 	if (!param)
 		return -EINVAL;
 
-	/* separate the trigger from the filter (k:v [if filter]) */
-	trigger = strsep(&param, " \t");
-	if (!trigger)
-		return -EINVAL;
+	if (glob[0] == '!')
+		remove = true;
+
+	/*
+	 * separate the trigger from the filter (k:v [if filter])
+	 * allowing for whitespace in the trigger
+	 */
+	p = trigger = param;
+	do {
+		p = strstr(p, "if");
+		if (!p)
+			break;
+		if (p == param)
+			return -EINVAL;
+		if (*(p - 1) != ' ' && *(p - 1) != '\t') {
+			p++;
+			continue;
+		}
+		if (p >= param + strlen(param) - strlen("if") - 1)
+			return -EINVAL;
+		if (*(p + strlen("if")) != ' ' && *(p + strlen("if")) != '\t') {
+			p++;
+			continue;
+		}
+		break;
+	} while (p);
+
+	if (!p)
+		param = NULL;
+	else {
+		*(p - 1) = '\0';
+		param = strstrip(p);
+		trigger = strstrip(trigger);
+	}
 
 	attrs = parse_hist_trigger_attrs(trigger);
 	if (IS_ERR(attrs))
@@ -1585,7 +5517,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	if (attrs->map_bits)
 		hist_trigger_bits = attrs->map_bits;
 
-	hist_data = create_hist_data(hist_trigger_bits, attrs, file);
+	hist_data = create_hist_data(hist_trigger_bits, attrs, file, remove);
 	if (IS_ERR(hist_data)) {
 		destroy_hist_trigger_attrs(attrs);
 		return PTR_ERR(hist_data);
@@ -1593,10 +5525,11 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 
 	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
 
-	ret = -ENOMEM;
 	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
-	if (!trigger_data)
+	if (!trigger_data) {
+		ret = -ENOMEM;
 		goto out_free;
+	}
 
 	trigger_data->count = -1;
 	trigger_data->ops = trigger_ops;
@@ -1614,8 +5547,24 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 			goto out_free;
 	}
 
-	if (glob[0] == '!') {
+	if (remove) {
+		if (!have_hist_trigger_match(trigger_data, file))
+			goto out_free;
+
+		if (hist_trigger_check_refs(trigger_data, file)) {
+			ret = -EBUSY;
+			goto out_free;
+		}
+
 		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
+
+		mutex_lock(&synth_event_mutex);
+		se_name = trace_event_name(file->event_call);
+		se = find_synth_event(se_name);
+		if (se)
+			se->ref--;
+		mutex_unlock(&synth_event_mutex);
+
 		ret = 0;
 		goto out_free;
 	}
@@ -1632,14 +5581,47 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 		goto out_free;
 	} else if (ret < 0)
 		goto out_free;
+
+	if (get_named_trigger_data(trigger_data))
+		goto enable;
+
+	if (has_hist_vars(hist_data))
+		save_hist_vars(hist_data);
+
+	ret = create_actions(hist_data, file);
+	if (ret)
+		goto out_unreg;
+
+	ret = tracing_map_init(hist_data->map);
+	if (ret)
+		goto out_unreg;
+enable:
+	ret = hist_trigger_enable(trigger_data, file);
+	if (ret)
+		goto out_unreg;
+
+	mutex_lock(&synth_event_mutex);
+	se_name = trace_event_name(file->event_call);
+	se = find_synth_event(se_name);
+	if (se)
+		se->ref++;
+	mutex_unlock(&synth_event_mutex);
+
 	/* Just return zero, not the number of registered triggers */
 	ret = 0;
  out:
+	if (ret == 0)
+		hist_err_clear();
+
 	return ret;
+ out_unreg:
+	cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
  out_free:
 	if (cmd_ops->set_filter)
 		cmd_ops->set_filter(NULL, trigger_data, NULL);
 
+	remove_hist_vars(hist_data);
+
 	kfree(trigger_data);
 
 	destroy_hist_data(hist_data);
@@ -1669,7 +5651,8 @@ __init int register_trigger_hist_cmd(void)
 }
 
 static void
-hist_enable_trigger(struct event_trigger_data *data, void *rec)
+hist_enable_trigger(struct event_trigger_data *data, void *rec,
+		    struct ring_buffer_event *event)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
 	struct event_trigger_data *test;
@@ -1685,7 +5668,8 @@ hist_enable_trigger(struct event_trigger_data *data, void *rec)
 }
 
 static void
-hist_enable_count_trigger(struct event_trigger_data *data, void *rec)
+hist_enable_count_trigger(struct event_trigger_data *data, void *rec,
+			  struct ring_buffer_event *event)
 {
 	if (!data->count)
 		return;
@@ -1693,7 +5677,7 @@ hist_enable_count_trigger(struct event_trigger_data *data, void *rec)
 	if (data->count != -1)
 		(data->count)--;
 
-	hist_enable_trigger(data, rec);
+	hist_enable_trigger(data, rec, event);
 }
 
 static struct event_trigger_ops hist_enable_trigger_ops = {
@@ -1798,3 +5782,31 @@ __init int register_trigger_hist_enable_disable_cmds(void)
 
 	return ret;
 }
+
+static __init int trace_events_hist_init(void)
+{
+	struct dentry *entry = NULL;
+	struct dentry *d_tracer;
+	int err = 0;
+
+	d_tracer = tracing_init_dentry();
+	if (IS_ERR(d_tracer)) {
+		err = PTR_ERR(d_tracer);
+		goto err;
+	}
+
+	entry = tracefs_create_file("synthetic_events", 0644, d_tracer,
+				    NULL, &synth_events_fops);
+	if (!entry) {
+		err = -ENODEV;
+		goto err;
+	}
+
+	return err;
+ err:
+	pr_warn("Could not create tracefs 'synthetic_events' entry\n");
+
+	return err;
+}
+
+fs_initcall(trace_events_hist_init);
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 87411482a46f..d251cabcf69a 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -63,7 +63,8 @@ void trigger_data_free(struct event_trigger_data *data)
  * any trigger that should be deferred, ETT_NONE if nothing to defer.
  */
 enum event_trigger_type
-event_triggers_call(struct trace_event_file *file, void *rec)
+event_triggers_call(struct trace_event_file *file, void *rec,
+		    struct ring_buffer_event *event)
 {
 	struct event_trigger_data *data;
 	enum event_trigger_type tt = ETT_NONE;
@@ -76,7 +77,7 @@ event_triggers_call(struct trace_event_file *file, void *rec)
 		if (data->paused)
 			continue;
 		if (!rec) {
-			data->ops->func(data, rec);
+			data->ops->func(data, rec, event);
 			continue;
 		}
 		filter = rcu_dereference_sched(data->filter);
@@ -86,7 +87,7 @@ event_triggers_call(struct trace_event_file *file, void *rec)
 			tt |= data->cmd_ops->trigger_type;
 			continue;
 		}
-		data->ops->func(data, rec);
+		data->ops->func(data, rec, event);
 	}
 	return tt;
 }
@@ -108,7 +109,7 @@ EXPORT_SYMBOL_GPL(event_triggers_call);
 void
 event_triggers_post_call(struct trace_event_file *file,
 			 enum event_trigger_type tt,
-			 void *rec)
+			 void *rec, struct ring_buffer_event *event)
 {
 	struct event_trigger_data *data;
 
@@ -116,7 +117,7 @@ event_triggers_post_call(struct trace_event_file *file,
 		if (data->paused)
 			continue;
 		if (data->cmd_ops->trigger_type & tt)
-			data->ops->func(data, rec);
+			data->ops->func(data, rec, event);
 	}
 }
 EXPORT_SYMBOL_GPL(event_triggers_post_call);
@@ -908,8 +909,15 @@ void set_named_trigger_data(struct event_trigger_data *data,
 	data->named_data = named_data;
 }
 
+struct event_trigger_data *
+get_named_trigger_data(struct event_trigger_data *data)
+{
+	return data->named_data;
+}
+
 static void
-traceon_trigger(struct event_trigger_data *data, void *rec)
+traceon_trigger(struct event_trigger_data *data, void *rec,
+		struct ring_buffer_event *event)
 {
 	if (tracing_is_on())
 		return;
@@ -918,7 +926,8 @@ traceon_trigger(struct event_trigger_data *data, void *rec)
 }
 
 static void
-traceon_count_trigger(struct event_trigger_data *data, void *rec)
+traceon_count_trigger(struct event_trigger_data *data, void *rec,
+		      struct ring_buffer_event *event)
 {
 	if (tracing_is_on())
 		return;
@@ -933,7 +942,8 @@ traceon_count_trigger(struct event_trigger_data *data, void *rec)
 }
 
 static void
-traceoff_trigger(struct event_trigger_data *data, void *rec)
+traceoff_trigger(struct event_trigger_data *data, void *rec,
+		 struct ring_buffer_event *event)
 {
 	if (!tracing_is_on())
 		return;
@@ -942,7 +952,8 @@ traceoff_trigger(struct event_trigger_data *data, void *rec)
 }
 
 static void
-traceoff_count_trigger(struct event_trigger_data *data, void *rec)
+traceoff_count_trigger(struct event_trigger_data *data, void *rec,
+		       struct ring_buffer_event *event)
 {
 	if (!tracing_is_on())
 		return;
@@ -1039,13 +1050,15 @@ static struct event_command trigger_traceoff_cmd = {
 
 #ifdef CONFIG_TRACER_SNAPSHOT
 static void
-snapshot_trigger(struct event_trigger_data *data, void *rec)
+snapshot_trigger(struct event_trigger_data *data, void *rec,
+		 struct ring_buffer_event *event)
 {
 	tracing_snapshot();
 }
 
 static void
-snapshot_count_trigger(struct event_trigger_data *data, void *rec)
+snapshot_count_trigger(struct event_trigger_data *data, void *rec,
+		       struct ring_buffer_event *event)
 {
 	if (!data->count)
 		return;
@@ -1053,7 +1066,7 @@ snapshot_count_trigger(struct event_trigger_data *data, void *rec)
 	if (data->count != -1)
 		(data->count)--;
 
-	snapshot_trigger(data, rec);
+	snapshot_trigger(data, rec, event);
 }
 
 static int
@@ -1141,13 +1154,15 @@ static __init int register_trigger_snapshot_cmd(void) { return 0; }
 #endif
 
 static void
-stacktrace_trigger(struct event_trigger_data *data, void *rec)
+stacktrace_trigger(struct event_trigger_data *data, void *rec,
+		   struct ring_buffer_event *event)
 {
 	trace_dump_stack(STACK_SKIP);
 }
 
 static void
-stacktrace_count_trigger(struct event_trigger_data *data, void *rec)
+stacktrace_count_trigger(struct event_trigger_data *data, void *rec,
+			 struct ring_buffer_event *event)
 {
 	if (!data->count)
 		return;
@@ -1155,7 +1170,7 @@ stacktrace_count_trigger(struct event_trigger_data *data, void *rec)
 	if (data->count != -1)
 		(data->count)--;
 
-	stacktrace_trigger(data, rec);
+	stacktrace_trigger(data, rec, event);
 }
 
 static int
@@ -1217,7 +1232,8 @@ static __init void unregister_trigger_traceon_traceoff_cmds(void)
 }
 
 static void
-event_enable_trigger(struct event_trigger_data *data, void *rec)
+event_enable_trigger(struct event_trigger_data *data, void *rec,
+		     struct ring_buffer_event *event)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
 
@@ -1228,7 +1244,8 @@ event_enable_trigger(struct event_trigger_data *data, void *rec)
 }
 
 static void
-event_enable_count_trigger(struct event_trigger_data *data, void *rec)
+event_enable_count_trigger(struct event_trigger_data *data, void *rec,
+			   struct ring_buffer_event *event)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
 
@@ -1242,7 +1259,7 @@ event_enable_count_trigger(struct event_trigger_data *data, void *rec)
 	if (data->count != -1)
 		(data->count)--;
 
-	event_enable_trigger(data, rec);
+	event_enable_trigger(data, rec, event);
 }
 
 int event_enable_trigger_print(struct seq_file *m,
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 07e75344725b..5cadb1b8b5fe 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -66,6 +66,73 @@ u64 tracing_map_read_sum(struct tracing_map_elt *elt, unsigned int i)
 	return (u64)atomic64_read(&elt->fields[i].sum);
 }
 
+/**
+ * tracing_map_set_var - Assign a tracing_map_elt's variable field
+ * @elt: The tracing_map_elt
+ * @i: The index of the given variable associated with the tracing_map_elt
+ * @n: The value to assign
+ *
+ * Assign n to variable i associated with the specified tracing_map_elt
+ * instance.  The index i is the index returned by the call to
+ * tracing_map_add_var() when the tracing map was set up.
+ */
+void tracing_map_set_var(struct tracing_map_elt *elt, unsigned int i, u64 n)
+{
+	atomic64_set(&elt->vars[i], n);
+	elt->var_set[i] = true;
+}
+
+/**
+ * tracing_map_var_set - Return whether or not a variable has been set
+ * @elt: The tracing_map_elt
+ * @i: The index of the given variable associated with the tracing_map_elt
+ *
+ * Return true if the variable has been set, false otherwise.  The
+ * index i is the index returned by the call to tracing_map_add_var()
+ * when the tracing map was set up.
+ */
+bool tracing_map_var_set(struct tracing_map_elt *elt, unsigned int i)
+{
+	return elt->var_set[i];
+}
+
+/**
+ * tracing_map_read_var - Return the value of a tracing_map_elt's variable field
+ * @elt: The tracing_map_elt
+ * @i: The index of the given variable associated with the tracing_map_elt
+ *
+ * Retrieve the value of the variable i associated with the specified
+ * tracing_map_elt instance.  The index i is the index returned by the
+ * call to tracing_map_add_var() when the tracing map was set
+ * up.
+ *
+ * Return: The variable value associated with field i for elt.
+ */
+u64 tracing_map_read_var(struct tracing_map_elt *elt, unsigned int i)
+{
+	return (u64)atomic64_read(&elt->vars[i]);
+}
+
+/**
+ * tracing_map_read_var_once - Return and reset a tracing_map_elt's variable field
+ * @elt: The tracing_map_elt
+ * @i: The index of the given variable associated with the tracing_map_elt
+ *
+ * Retrieve the value of the variable i associated with the specified
+ * tracing_map_elt instance, and reset the variable to the 'not set'
+ * state.  The index i is the index returned by the call to
+ * tracing_map_add_var() when the tracing map was set up.  The reset
+ * essentially makes the variable a read-once variable if it's only
+ * accessed using this function.
+ *
+ * Return: The variable value associated with field i for elt.
+ */
+u64 tracing_map_read_var_once(struct tracing_map_elt *elt, unsigned int i)
+{
+	elt->var_set[i] = false;
+	return (u64)atomic64_read(&elt->vars[i]);
+}
+
 int tracing_map_cmp_string(void *val_a, void *val_b)
 {
 	char *a = val_a;
@@ -170,6 +237,28 @@ int tracing_map_add_sum_field(struct tracing_map *map)
 	return tracing_map_add_field(map, tracing_map_cmp_atomic64);
 }
 
+/**
+ * tracing_map_add_var - Add a field describing a tracing_map var
+ * @map: The tracing_map
+ *
+ * Add a var to the map and return the index identifying it in the map
+ * and associated tracing_map_elts.  This is the index used for
+ * instance to update a var for a particular tracing_map_elt using
+ * tracing_map_update_var() or reading it via tracing_map_read_var().
+ *
+ * Return: The index identifying the var in the map and associated
+ * tracing_map_elts, or -EINVAL on error.
+ */
+int tracing_map_add_var(struct tracing_map *map)
+{
+	int ret = -EINVAL;
+
+	if (map->n_vars < TRACING_MAP_VARS_MAX)
+		ret = map->n_vars++;
+
+	return ret;
+}
+
 /**
  * tracing_map_add_key_field - Add a field describing a tracing_map key
  * @map: The tracing_map
@@ -280,6 +369,11 @@ static void tracing_map_elt_clear(struct tracing_map_elt *elt)
 		if (elt->fields[i].cmp_fn == tracing_map_cmp_atomic64)
 			atomic64_set(&elt->fields[i].sum, 0);
 
+	for (i = 0; i < elt->map->n_vars; i++) {
+		atomic64_set(&elt->vars[i], 0);
+		elt->var_set[i] = false;
+	}
+
 	if (elt->map->ops && elt->map->ops->elt_clear)
 		elt->map->ops->elt_clear(elt);
 }
@@ -306,6 +400,8 @@ static void tracing_map_elt_free(struct tracing_map_elt *elt)
 	if (elt->map->ops && elt->map->ops->elt_free)
 		elt->map->ops->elt_free(elt);
 	kfree(elt->fields);
+	kfree(elt->vars);
+	kfree(elt->var_set);
 	kfree(elt->key);
 	kfree(elt);
 }
@@ -333,6 +429,18 @@ static struct tracing_map_elt *tracing_map_elt_alloc(struct tracing_map *map)
 		goto free;
 	}
 
+	elt->vars = kcalloc(map->n_vars, sizeof(*elt->vars), GFP_KERNEL);
+	if (!elt->vars) {
+		err = -ENOMEM;
+		goto free;
+	}
+
+	elt->var_set = kcalloc(map->n_vars, sizeof(*elt->var_set), GFP_KERNEL);
+	if (!elt->var_set) {
+		err = -ENOMEM;
+		goto free;
+	}
+
 	tracing_map_elt_init_fields(elt);
 
 	if (map->ops && map->ops->elt_alloc) {
@@ -414,7 +522,9 @@ static inline struct tracing_map_elt *
 __tracing_map_insert(struct tracing_map *map, void *key, bool lookup_only)
 {
 	u32 idx, key_hash, test_key;
+	int dup_try = 0;
 	struct tracing_map_entry *entry;
+	struct tracing_map_elt *val;
 
 	key_hash = jhash(key, map->key_size, 0);
 	if (key_hash == 0)
@@ -426,11 +536,33 @@ __tracing_map_insert(struct tracing_map *map, void *key, bool lookup_only)
 		entry = TRACING_MAP_ENTRY(map->map, idx);
 		test_key = entry->key;
 
-		if (test_key && test_key == key_hash && entry->val &&
-		    keys_match(key, entry->val->key, map->key_size)) {
-			if (!lookup_only)
-				atomic64_inc(&map->hits);
-			return entry->val;
+		if (test_key && test_key == key_hash) {
+			val = READ_ONCE(entry->val);
+			if (val &&
+			    keys_match(key, val->key, map->key_size)) {
+				if (!lookup_only)
+					atomic64_inc(&map->hits);
+				return val;
+			} else if (unlikely(!val)) {
+				/*
+				 * The key is present. But, val (pointer to elt
+				 * struct) is still NULL. which means some other
+				 * thread is in the process of inserting an
+				 * element.
+				 *
+				 * On top of that, it's key_hash is same as the
+				 * one being inserted right now. So, it's
+				 * possible that the element has the same
+				 * key as well.
+				 */
+
+				dup_try++;
+				if (dup_try > map->map_size) {
+					atomic64_inc(&map->drops);
+					break;
+				}
+				continue;
+			}
 		}
 
 		if (!test_key) {
@@ -452,6 +584,13 @@ __tracing_map_insert(struct tracing_map *map, void *key, bool lookup_only)
 				atomic64_inc(&map->hits);
 
 				return entry->val;
+			} else {
+				/*
+				 * cmpxchg() failed. Loop around once
+				 * more to check what key was inserted.
+				 */
+				dup_try++;
+				continue;
 			}
 		}
 
@@ -816,67 +955,15 @@ create_sort_entry(void *key, struct tracing_map_elt *elt)
 	return sort_entry;
 }
 
-static struct tracing_map_elt *copy_elt(struct tracing_map_elt *elt)
-{
-	struct tracing_map_elt *dup_elt;
-	unsigned int i;
-
-	dup_elt = tracing_map_elt_alloc(elt->map);
-	if (IS_ERR(dup_elt))
-		return NULL;
-
-	if (elt->map->ops && elt->map->ops->elt_copy)
-		elt->map->ops->elt_copy(dup_elt, elt);
-
-	dup_elt->private_data = elt->private_data;
-	memcpy(dup_elt->key, elt->key, elt->map->key_size);
-
-	for (i = 0; i < elt->map->n_fields; i++) {
-		atomic64_set(&dup_elt->fields[i].sum,
-			     atomic64_read(&elt->fields[i].sum));
-		dup_elt->fields[i].cmp_fn = elt->fields[i].cmp_fn;
-	}
-
-	return dup_elt;
-}
-
-static int merge_dup(struct tracing_map_sort_entry **sort_entries,
-		     unsigned int target, unsigned int dup)
-{
-	struct tracing_map_elt *target_elt, *elt;
-	bool first_dup = (target - dup) == 1;
-	int i;
-
-	if (first_dup) {
-		elt = sort_entries[target]->elt;
-		target_elt = copy_elt(elt);
-		if (!target_elt)
-			return -ENOMEM;
-		sort_entries[target]->elt = target_elt;
-		sort_entries[target]->elt_copied = true;
-	} else
-		target_elt = sort_entries[target]->elt;
-
-	elt = sort_entries[dup]->elt;
-
-	for (i = 0; i < elt->map->n_fields; i++)
-		atomic64_add(atomic64_read(&elt->fields[i].sum),
-			     &target_elt->fields[i].sum);
-
-	sort_entries[dup]->dup = true;
-
-	return 0;
-}
-
-static int merge_dups(struct tracing_map_sort_entry **sort_entries,
+static void detect_dups(struct tracing_map_sort_entry **sort_entries,
 		      int n_entries, unsigned int key_size)
 {
 	unsigned int dups = 0, total_dups = 0;
-	int err, i, j;
+	int i;
 	void *key;
 
 	if (n_entries < 2)
-		return total_dups;
+		return;
 
 	sort(sort_entries, n_entries, sizeof(struct tracing_map_sort_entry *),
 	     (int (*)(const void *, const void *))cmp_entries_dup, NULL);
@@ -885,30 +972,14 @@ static int merge_dups(struct tracing_map_sort_entry **sort_entries,
 	for (i = 1; i < n_entries; i++) {
 		if (!memcmp(sort_entries[i]->key, key, key_size)) {
 			dups++; total_dups++;
-			err = merge_dup(sort_entries, i - dups, i);
-			if (err)
-				return err;
 			continue;
 		}
 		key = sort_entries[i]->key;
 		dups = 0;
 	}
 
-	if (!total_dups)
-		return total_dups;
-
-	for (i = 0, j = 0; i < n_entries; i++) {
-		if (!sort_entries[i]->dup) {
-			sort_entries[j] = sort_entries[i];
-			if (j++ != i)
-				sort_entries[i] = NULL;
-		} else {
-			destroy_sort_entry(sort_entries[i]);
-			sort_entries[i] = NULL;
-		}
-	}
-
-	return total_dups;
+	WARN_ONCE(total_dups > 0,
+		  "Duplicates detected: %d\n", total_dups);
 }
 
 static bool is_key(struct tracing_map *map, unsigned int field_idx)
@@ -1034,10 +1105,7 @@ int tracing_map_sort_entries(struct tracing_map *map,
 		return 1;
 	}
 
-	ret = merge_dups(entries, n_entries, map->key_size);
-	if (ret < 0)
-		goto free;
-	n_entries -= ret;
+	detect_dups(entries, n_entries, map->key_size);
 
 	if (is_key(map, sort_keys[0].field_idx))
 		cmp_entries_fn = cmp_entries_key;
diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
index 5b5bbf8ae550..053eb92b2d31 100644
--- a/kernel/trace/tracing_map.h
+++ b/kernel/trace/tracing_map.h
@@ -10,6 +10,7 @@
 #define TRACING_MAP_VALS_MAX		3
 #define TRACING_MAP_FIELDS_MAX		(TRACING_MAP_KEYS_MAX + \
 					 TRACING_MAP_VALS_MAX)
+#define TRACING_MAP_VARS_MAX		16
 #define TRACING_MAP_SORT_KEYS_MAX	2
 
 typedef int (*tracing_map_cmp_fn_t) (void *val_a, void *val_b);
@@ -137,6 +138,8 @@ struct tracing_map_field {
 struct tracing_map_elt {
 	struct tracing_map		*map;
 	struct tracing_map_field	*fields;
+	atomic64_t			*vars;
+	bool				*var_set;
 	void				*key;
 	void				*private_data;
 };
@@ -192,6 +195,7 @@ struct tracing_map {
 	int				key_idx[TRACING_MAP_KEYS_MAX];
 	unsigned int			n_keys;
 	struct tracing_map_sort_key	sort_key;
+	unsigned int			n_vars;
 	atomic64_t			hits;
 	atomic64_t			drops;
 };
@@ -215,11 +219,6 @@ struct tracing_map {
  *	Element allocation occurs before tracing begins, when the
  *	tracing_map_init() call is made by client code.
  *
- * @elt_copy: At certain points in the lifetime of an element, it may
- *	need to be copied.  The copy should include a copy of the
- *	client-allocated data, which can be copied into the 'to'
- *	element from the 'from' element.
- *
  * @elt_free: When a tracing_map_elt is freed, this function is called
  *	and allows client-allocated per-element data to be freed.
  *
@@ -233,8 +232,6 @@ struct tracing_map {
  */
 struct tracing_map_ops {
 	int			(*elt_alloc)(struct tracing_map_elt *elt);
-	void			(*elt_copy)(struct tracing_map_elt *to,
-					    struct tracing_map_elt *from);
 	void			(*elt_free)(struct tracing_map_elt *elt);
 	void			(*elt_clear)(struct tracing_map_elt *elt);
 	void			(*elt_init)(struct tracing_map_elt *elt);
@@ -248,6 +245,7 @@ tracing_map_create(unsigned int map_bits,
 extern int tracing_map_init(struct tracing_map *map);
 
 extern int tracing_map_add_sum_field(struct tracing_map *map);
+extern int tracing_map_add_var(struct tracing_map *map);
 extern int tracing_map_add_key_field(struct tracing_map *map,
 				     unsigned int offset,
 				     tracing_map_cmp_fn_t cmp_fn);
@@ -267,7 +265,13 @@ extern int tracing_map_cmp_none(void *val_a, void *val_b);
 
 extern void tracing_map_update_sum(struct tracing_map_elt *elt,
 				   unsigned int i, u64 n);
+extern void tracing_map_set_var(struct tracing_map_elt *elt,
+				unsigned int i, u64 n);
+extern bool tracing_map_var_set(struct tracing_map_elt *elt, unsigned int i);
 extern u64 tracing_map_read_sum(struct tracing_map_elt *elt, unsigned int i);
+extern u64 tracing_map_read_var(struct tracing_map_elt *elt, unsigned int i);
+extern u64 tracing_map_read_var_once(struct tracing_map_elt *elt, unsigned int i);
+
 extern void tracing_map_set_field_descr(struct tracing_map *map,
 					unsigned int i,
 					unsigned int key_offset,
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d7a708f82559..89f8a4a4b770 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2591,6 +2591,8 @@ int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args)
 			case 's':
 			case 'F':
 			case 'f':
+			case 'x':
+			case 'K':
 				save_arg(void *);
 				break;
 			default:
@@ -2765,6 +2767,8 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 			case 's':
 			case 'F':
 			case 'f':
+			case 'x':
+			case 'K':
 				process = true;
 				break;
 			default:
diff --git a/security/security.c b/security/security.c
index 1cd8526cb0b7..987afe3d464c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -30,6 +30,8 @@
 #include <linux/string.h>
 #include <net/flow.h>
 
+#include <trace/events/initcall.h>
+
 #define MAX_LSM_EVM_XATTR	2
 
 /* Maximum number of letters for an LSM name string */
@@ -45,10 +47,14 @@ static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 
 static void __init do_security_initcalls(void)
 {
+	int ret;
 	initcall_t *call;
 	call = __security_initcall_start;
+	trace_initcall_level("security");
 	while (call < __security_initcall_end) {
-		(*call) ();
+		trace_initcall_start((*call));
+		ret = (*call) ();
+		trace_initcall_finish((*call), ret);
 		call++;
 	}
 }
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index df3dd7fe5f9b..2a4f16fc9819 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -59,6 +59,13 @@ disable_events() {
     echo 0 > events/enable
 }
 
+clear_synthetic_events() { # reset all current synthetic events
+    grep -v ^# synthetic_events |
+    while read line; do
+        echo "!$line" >> synthetic_events
+    done
+}
+
 initialize_ftrace() { # Reset ftrace to initial-state
 # As the initial state, ftrace will be set to nop tracer,
 # no events, no triggers, no filters, no function filters,
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
new file mode 100644
index 000000000000..786dce7e48be
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
@@ -0,0 +1,39 @@
+#!/bin/sh
+# description: event trigger - test extended error support
+
+
+do_reset() {
+    reset_trigger
+    echo > set_event
+    clear_trace
+}
+
+fail() { #msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+if [ ! -f set_event ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f synthetic_events ]; then
+    echo "synthetic event is not supported"
+    exit_unsupported
+fi
+
+reset_tracer
+do_reset
+
+echo "Test extended error support"
+echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
+echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' >> events/sched/sched_wakeup/trigger &>/dev/null
+if ! grep -q "ERROR:" events/sched/sched_wakeup/hist; then
+    fail "Failed to generate extended error in histogram"
+fi
+
+do_reset
+
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
new file mode 100644
index 000000000000..7fd5b4a8f060
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
@@ -0,0 +1,54 @@
+#!/bin/sh
+# description: event trigger - test field variable support
+
+do_reset() {
+    reset_trigger
+    echo > set_event
+    clear_trace
+}
+
+fail() { #msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+if [ ! -f set_event ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f synthetic_events ]; then
+    echo "synthetic event is not supported"
+    exit_unsupported
+fi
+
+clear_synthetic_events
+reset_tracer
+do_reset
+
+echo "Test field variable support"
+
+echo 'wakeup_latency u64 lat; pid_t pid; int prio; char comm[16]' > synthetic_events
+echo 'hist:keys=comm:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_waking/trigger
+echo 'hist:keys=next_comm:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,sched.sched_waking.prio,next_comm) if next_comm=="ping"' > events/sched/sched_switch/trigger
+echo 'hist:keys=pid,prio,comm:vals=lat:sort=pid,prio' > events/synthetic/wakeup_latency/trigger
+
+ping localhost -c 3
+if ! grep -q "ping" events/synthetic/wakeup_latency/hist; then
+    fail "Failed to create inter-event histogram"
+fi
+
+if ! grep -q "synthetic_prio=prio" events/sched/sched_waking/hist; then
+    fail "Failed to create histogram with field variable"
+fi
+
+echo '!hist:keys=next_comm:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,sched.sched_waking.prio,next_comm) if next_comm=="ping"' >> events/sched/sched_switch/trigger
+
+if grep -q "synthetic_prio=prio" events/sched/sched_waking/hist; then
+    fail "Failed to remove histogram with field variable"
+fi
+
+do_reset
+
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
new file mode 100644
index 000000000000..c93dbe38b5df
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
@@ -0,0 +1,58 @@
+#!/bin/sh
+# description: event trigger - test inter-event combined histogram trigger
+
+do_reset() {
+    reset_trigger
+    echo > set_event
+    clear_trace
+}
+
+fail() { #msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+if [ ! -f set_event ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f synthetic_events ]; then
+    echo "synthetic event is not supported"
+    exit_unsupported
+fi
+
+reset_tracer
+do_reset
+clear_synthetic_events
+
+echo "Test create synthetic event"
+
+echo 'waking_latency  u64 lat pid_t pid' > synthetic_events
+if [ ! -d events/synthetic/waking_latency ]; then
+    fail "Failed to create waking_latency synthetic event"
+fi
+
+echo "Test combined histogram"
+
+echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_waking/trigger
+echo 'hist:keys=pid:waking_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).waking_latency($waking_lat,pid) if comm=="ping"' > events/sched/sched_wakeup/trigger
+echo 'hist:keys=pid,lat:sort=pid,lat' > events/synthetic/waking_latency/trigger
+
+echo 'wakeup_latency u64 lat pid_t pid' >> synthetic_events
+echo 'hist:keys=pid:ts1=common_timestamp.usecs if comm=="ping"' >> events/sched/sched_wakeup/trigger
+echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts1:onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,next_pid) if next_comm=="ping"' > events/sched/sched_switch/trigger
+
+echo 'waking+wakeup_latency u64 lat; pid_t pid' >> synthetic_events
+echo 'hist:keys=pid,lat:sort=pid,lat:ww_lat=$waking_lat+$wakeup_lat:onmatch(synthetic.wakeup_latency).waking+wakeup_latency($ww_lat,pid)' >> events/synthetic/wakeup_latency/trigger
+echo 'hist:keys=pid,lat:sort=pid,lat' >> events/synthetic/waking+wakeup_latency/trigger
+
+ping localhost -c 3
+if ! grep -q "pid:" events/synthetic/waking+wakeup_latency/hist; then
+    fail "Failed to create combined histogram"
+fi
+
+do_reset
+
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
new file mode 100644
index 000000000000..e84e7d048566
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
@@ -0,0 +1,50 @@
+#!/bin/sh
+# description: event trigger - test inter-event histogram trigger onmatch action
+
+do_reset() {
+    reset_trigger
+    echo > set_event
+    clear_trace
+}
+
+fail() { #msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+if [ ! -f set_event ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f synthetic_events ]; then
+    echo "synthetic event is not supported"
+    exit_unsupported
+fi
+
+clear_synthetic_events
+reset_tracer
+do_reset
+
+echo "Test create synthetic event"
+
+echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
+if [ ! -d events/synthetic/wakeup_latency ]; then
+    fail "Failed to create wakeup_latency synthetic event"
+fi
+
+echo "Test create histogram for synthetic event"
+echo "Test histogram variables,simple expression support and onmatch action"
+
+echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
+echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,next_pid,next_comm) if next_comm=="ping"' > events/sched/sched_switch/trigger
+echo 'hist:keys=comm,pid,lat:wakeup_lat=lat:sort=lat' > events/synthetic/wakeup_latency/trigger
+ping localhost -c 5
+if ! grep -q "ping" events/synthetic/wakeup_latency/hist; then
+    fail "Failed to create onmatch action inter-event histogram"
+fi
+
+do_reset
+
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
new file mode 100644
index 000000000000..7907d8aacde3
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
@@ -0,0 +1,50 @@
+#!/bin/sh
+# description: event trigger - test inter-event histogram trigger onmatch-onmax action
+
+do_reset() {
+    reset_trigger
+    echo > set_event
+    clear_trace
+}
+
+fail() { #msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+if [ ! -f set_event ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f synthetic_events ]; then
+    echo "synthetic event is not supported"
+    exit_unsupported
+fi
+
+clear_synthetic_events
+reset_tracer
+do_reset
+
+echo "Test create synthetic event"
+
+echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
+if [ ! -d events/synthetic/wakeup_latency ]; then
+    fail "Failed to create wakeup_latency synthetic event"
+fi
+
+echo "Test create histogram for synthetic event"
+echo "Test histogram variables,simple expression support and onmatch-onmax action"
+
+echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
+echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,next_pid,next_comm):onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm) if next_comm=="ping"' >> events/sched/sched_switch/trigger
+echo 'hist:keys=comm,pid,lat:wakeup_lat=lat:sort=lat' > events/synthetic/wakeup_latency/trigger
+ping localhost -c 5
+if [ ! grep -q "ping" events/synthetic/wakeup_latency/hist -o ! grep -q "max:" events/sched/sched_switch/hist]; then
+    fail "Failed to create onmatch-onmax action inter-event histogram"
+fi
+
+do_reset
+
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
new file mode 100644
index 000000000000..38b7ed6242b2
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
@@ -0,0 +1,48 @@
+#!/bin/sh
+# description: event trigger - test inter-event histogram trigger onmax action
+
+do_reset() {
+    reset_trigger
+    echo > set_event
+    clear_trace
+}
+
+fail() { #msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+if [ ! -f set_event ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f synthetic_events ]; then
+    echo "synthetic event is not supported"
+    exit_unsupported
+fi
+
+clear_synthetic_events
+reset_tracer
+do_reset
+
+echo "Test create synthetic event"
+
+echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
+if [ ! -d events/synthetic/wakeup_latency ]; then
+    fail "Failed to create wakeup_latency synthetic event"
+fi
+
+echo "Test onmax action"
+
+echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' >> events/sched/sched_waking/trigger
+echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm) if next_comm=="ping"' >> events/sched/sched_switch/trigger
+ping localhost -c 3
+if ! grep -q "max:" events/sched/sched_switch/hist; then
+    fail "Failed to create onmax action inter-event histogram"
+fi
+
+do_reset
+
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
new file mode 100644
index 000000000000..cef11377dcbd
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
@@ -0,0 +1,54 @@
+#!/bin/sh
+# description: event trigger - test synthetic event create remove
+do_reset() {
+    reset_trigger
+    echo > set_event
+    clear_trace
+}
+
+fail() { #msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+if [ ! -f set_event ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f synthetic_events ]; then
+    echo "synthetic event is not supported"
+    exit_unsupported
+fi
+
+clear_synthetic_events
+reset_tracer
+do_reset
+
+echo "Test create synthetic event"
+
+echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
+if [ ! -d events/synthetic/wakeup_latency ]; then
+    fail "Failed to create wakeup_latency synthetic event"
+fi
+
+reset_trigger
+
+echo "Test create synthetic event with an error"
+echo 'wakeup_latency  u64 lat pid_t pid char' > synthetic_events > /dev/null
+if [ -d events/synthetic/wakeup_latency ]; then
+    fail "Created wakeup_latency synthetic event with an invalid format"
+fi
+
+reset_trigger
+
+echo "Test remove synthetic event"
+echo '!wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
+if [ -d events/synthetic/wakeup_latency ]; then
+    fail "Failed to delete wakeup_latency synthetic event"
+fi
+
+do_reset
+
+exit 0
