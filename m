Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754734AbeBGU2U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:28:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754127AbeBGU2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:28:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F260D2179F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180207202402.253089656@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 07 Feb 2018 15:24:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 00/20 v2] tracing: Dynamically created function based events
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At Kernel Summit back in October, we tried to bring up trace markers, which
would be nops within the kernel proper, that would allow modules to hook
arbitrary trace events to them. The reaction to this proposal was less than
favorable. We were told that we were trying to make a work around for a
problem, and not solving it. The problem in our minds is the notion of a
"stable trace event".

There are maintainers that do not want trace events, or more trace events in
their subsystems. This is due to the fact that trace events post an
interface to user space, and this interface could become required by some
tool. This may cause the trace event to become stable where it must not
break the tool, and thus prevent the code from changing.

Or, the trace event may just have to add padding for fields that tools
may require. The "success" field of the sched_wakeup trace event is one such
instance. There is no more "success" variable, but tools may fail if it were
to go away, so a "1" is simply added to the trace event wasting ring buffer
real estate.

I talked with Linus about this, and he told me that we already have these
markers in the kernel. They are from the mcount/__fentry__ used by function
tracing. Have the trace events be created by these, and see if this will
satisfy most areas that want trace events.

I decided to implement this idea, and here's the patch set.

Introducing "function based events". These are created dynamically by a
tracefs file called "function_events". By writing a pseudo prototype into
this file, you create an event.

 # mount -t tracefs nodev /sys/kernel/tracing
 # cd /sys/kernel/tracing
 # echo 'do_IRQ(symbol ip[16] | x64[6] irq_stack[16])' > function_events
 # cat events/functions/do_IRQ/format
name: do_IRQ
ID: 1399
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:unsigned long __parent_ip;	offset:8;	size:8;	signed:0;
	field:unsigned long __ip;	offset:16;	size:8;	signed:0;
	field:symbol ip;	offset:24;	size:8;	signed:0;
	field:x64 irq_stack[6];	offset:32;	size:48;	signed:0;

print fmt: "%pS->%pS(ip=%pS, irq_stack=%llx:%llx:%llx:%llx:%llx:%llx)", REC->__ip, REC->__parent_ip,
REC->ip, REC->irq_stack[0], REC->irq_stack[1], REC->irq_stack[2], REC->irq_stack[3], REC->irq_stack[4],
REC->irq_stack[5]

 # echo 1 > events/functions/do_IRQ/enable
 # cat trace
          <idle>-0     [003] d..3  3647.049344: ret_from_intr->do_IRQ(ip=cpuidle_enter_state+0xb1/0x330, irq_stack=ffffffff81665db1,10,246,ffffc900006c3e80,18,ffff88011eae9b40)
          <idle>-0     [003] d..3  3647.049433: ret_from_intr->do_IRQ(ip=cpuidle_enter_state+0xb1/0x330, irq_stack=ffffffff81665db1,10,246,ffffc900006c3e80,18,ffff88011eae9b40)
          <idle>-0     [003] d..3  3647.049672: ret_from_intr->do_IRQ(ip=cpuidle_enter_state+0xb1/0x330, irq_stack=ffffffff81665db1,10,246,ffffc900006c3e80,18,ffff88011eae9b40)
          <idle>-0     [003] d..3  3647.325709: ret_from_intr->do_IRQ(ip=cpuidle_enter_state+0xb1/0x330, irq_stack=ffffffff81665db1,10,246,ffffc900006c3e80,18,ffff88011eae9b40)
          <idle>-0     [003] d..3  3647.325929: ret_from_intr->do_IRQ(ip=cpuidle_enter_state+0xb1/0x330, irq_stack=ffffffff81665db1,10,246,ffffc900006c3e80,18,ffff88011eae9b40)
          <idle>-0     [003] d..3  3647.325993: ret_from_intr->do_IRQ(ip=cpuidle_enter_state+0xb1/0x330, irq_stack=ffffffff81665db1,10,246,ffffc900006c3e80,18,ffff88011eae9b40)
          <idle>-0     [003] d..3  3647.387571: ret_from_intr->do_IRQ(ip=cpuidle_enter_state+0xb1/0x330, irq_stack=ffffffff81665db1,10,246,ffffc900006c3e80,18,ffff88011eae9b40)
          <idle>-0     [003] d..3  3647.387791: ret_from_intr->do_IRQ(ip=cpuidle_enter_state+0xb1/0x330, irq_stack=ffffffff81665db1,10,246,ffffc900006c3e80,18,ffff88011eae9b40)
          <idle>-0     [003] d..3  3647.387874: ret_from_intr->do_IRQ(ip=cpuidle_enter_state+0xb1/0x330, irq_stack=ffffffff81665db1,10,246,ffffc900006c3e80,18,ffff88011eae9b40)

And this is much more powerful than just this. We can show strings, and
index off of structures into other structures.

  # echo '__vfs_read(symbol read+40[0]+16)' > function_events

  # echo 1 > events/functions/__vfs_read/enable
  # cat trace
         sshd-1343  [005] ...2   199.734752: vfs_read->__vfs_read(read=tty_read+0x0/0xf0)
         bash-1344  [003] ...2   199.734822: vfs_read->__vfs_read(read=tty_read+0x0/0xf0)
         sshd-1343  [005] ...2   199.734835: vfs_read->__vfs_read(read=tty_read+0x0/0xf0)
 avahi-daemon-910   [003] ...2   200.136740: vfs_read->__vfs_read(read=          (null))
 avahi-daemon-910   [003] ...2   200.136750: vfs_read->__vfs_read(read=          (null))

And even read user space:

  # echo 'SyS_openat(int dfd, string path, x32 flags, x16 mode)' > function_events
  # echo 1 > events/functions/enable
  # grep task_fork /proc/kallsyms 
ffffffff810d5a60 t task_fork_fair
ffffffff810dfc30 t task_fork_dl
  # cat trace
            grep-1820  [000] ...2  3926.107603: entry_SYSCALL_64_fastpath->SyS_openat(dfd=-100, path=/proc/kallsyms, flags=100, mode=0)

These are fully functional events. That is, they work with ftrace,
trace-cmd, perf, histograms, triggers, and eBPF.

What's next? I need to rewrite the function graph tracer, and be able to add
dynamic events on function return.

I made this work with x86 with a simple function that only returns
6 function parameters for x86_64 and 3 for x86_32. But this could easily
be extended.

Cheers!

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/dynamic-ftrace-events

Head SHA1: acf9c4dc5a0662e4ee1fe60e08099b11ae3cffc5


Steven Rostedt (VMware) (20):
      tracing: Add function based events
      tracing: Add documentation for function based events
      tracing: Add simple arguments to function based events
      tracing/x86: Add arch_get_func_args() function
      tracing: Add hex print for dynamic ftrace based events
      tracing: Add indirect offset to args of ftrace based events
      tracing: Add dereferencing multiple fields per arg
      tracing: Add "unsigned" to function based events
      tracing: Add indexing of arguments for function based events
      tracing: Make func_type enums for easier comparing of arg types
      tracing: Add symbol type to function based events
      tracing: Add accessing direct address from function based events
      tracing: Add array type to function based events
      tracing: Have char arrays be strings for function based events
      tracing: Add string type for dynamic strings in function based events
      tracing: Add NULL to skip args for function based events
      tracing: Add indirect to indirect access for function based events
      tracing/perf: Allow perf to use function based events
      tracing: Add error messages for failed writes to function_events
      tracing: Add argument error message too many args for function based events

----
 Documentation/trace/function-based-events.rst |  426 +++++++
 arch/x86/kernel/ftrace.c                      |   28 +
 include/linux/trace_events.h                  |    2 +
 kernel/trace/Kconfig                          |   12 +
 kernel/trace/Makefile                         |    1 +
 kernel/trace/trace.h                          |   11 +
 kernel/trace/trace_event_ftrace.c             | 1653 +++++++++++++++++++++++++
 kernel/trace/trace_probe.h                    |   11 -
 8 files changed, 2133 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/trace/function-based-events.rst
 create mode 100644 kernel/trace/trace_event_ftrace.c
----

Changes since v1:

 The below diff, as well as two patches to supply error messages feedback.

 (Note, I still need to add that quick guide)


diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index b145639eac45..303a56c3339a 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -150,6 +150,8 @@ struct func_string {
 static struct func_string __percpu *str_buffer;
 static int nr_strings;
 
+static int max_args __read_mostly = -1;
+
 /**
  * arch_get_func_args - retrieve function arguments via pt_regs
  * @regs: The registers at the moment the function is called
@@ -269,7 +271,7 @@ static int add_arg(struct func_event *fevent, int ftype, int unsign)
 	struct func_arg *arg;
 
 	/* Make sure the arch can support this many args */
-	if (fevent->arg_cnt >= arch_get_func_args(NULL, 0, 0, NULL))
+	if (fevent->arg_cnt >= max_args)
 		return -EINVAL;
 
 	arg = kzalloc(sizeof(*arg), GFP_KERNEL);
@@ -332,7 +334,7 @@ static int update_arg_arg(struct func_event *fevent)
 		return -EINVAL;
 
 	/* Make sure the arch can support this many args */
-	if (fevent->arg_cnt >= arch_get_func_args(NULL, 0, 0, NULL))
+	if (fevent->arg_cnt >= max_args)
 		return -EINVAL;
 
 	arg->arg = fevent->arg_cnt;
@@ -879,14 +881,18 @@ func_event_call(unsigned long ip, unsigned long parent_ip,
 
 	func_event = container_of(op, struct func_event, ops);
 
-	rcu_read_lock_sched();
+	if (WARN_ON_ONCE(rcu_irq_enter_disabled()))
+		return;
+	rcu_irq_enter_irqson();
+	rcu_read_lock_sched_notrace();
 	list_for_each_entry_rcu(ff, &func_event->files, list) {
 		if (ff->file)
 			func_event_trace(ff->file, func_event, ip, parent_ip, pt_regs);
 		else
 			func_event_perf(func_event, ip, parent_ip, pt_regs);
 	}
-	rcu_read_unlock_sched();
+	rcu_read_unlock_sched_notrace();
+	rcu_irq_exit_irqson();
 }
 
 #define FMT_SIZE	8
@@ -1245,7 +1251,7 @@ static int func_event_create(struct func_event *func_event)
 
 static int create_function_event(int argc, char **argv)
 {
-	struct func_event *func_event, *fe;
+	struct func_event *func_event;
 	enum func_states state = FUNC_STATE_INIT;
 	char *token;
 	char *ptr;
@@ -1275,12 +1281,6 @@ static int create_function_event(int argc, char **argv)
 	if (state != FUNC_STATE_END)
 		goto fail;
 
-	ret = -EALREADY;
-	list_for_each_entry(fe, &func_events, list) {
-		if (strcmp(fe->func, func_event->func) == 0)
-			goto fail;
-	}
-
 	ret = ftrace_set_filter(&func_event->ops, func_event->func,
 				strlen(func_event->func), 0);
 	if (ret < 0)
@@ -1290,7 +1290,9 @@ static int create_function_event(int argc, char **argv)
 	if (ret < 0)
 		goto fail;
 
+	mutex_lock(&func_event_mutex);
 	list_add_tail(&func_event->list, &func_events);
+	mutex_unlock(&func_event_mutex);
 	return 0;
  fail:
 	free_func_event(func_event);
@@ -1349,7 +1351,7 @@ static int func_event_seq_show(struct seq_file *m, void *v)
 			if (redirect->index)
 				seq_printf(m, "+%ld", redirect->index);
 			if (redirect->indirect)
-				seq_printf(m, "[%d]",
+				seq_printf(m, "[%ld]",
 					   (redirect->indirect ^ INDIRECT_FLAG) / arg->size);
 		}
 	}
@@ -1368,22 +1370,27 @@ static const struct seq_operations func_event_seq_op = {
 static int release_all_func_events(void)
 {
 	struct func_event *func_event, *n;
-	int ret;
+	int ret = 0;
 
+	mutex_lock(&func_event_mutex);
 	list_for_each_entry_safe(func_event, n, &func_events, list) {
 		ret = trace_remove_event_call(&func_event->call);
 		if (ret < 0)
-			return ret;
+			break;
 		list_del(&func_event->list);
 		free_func_event(func_event);
 	}
-	return 0;
+	mutex_unlock(&func_event_mutex);
+	return ret;
 }
 
 static int func_event_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	if (max_args < 0)
+		max_args = arch_get_func_args(NULL, 0, 0, NULL);
+
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
 		ret = release_all_func_events();
 		if (ret < 0)
