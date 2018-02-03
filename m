Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754952AbeBCSx0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 13:53:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753116AbeBCSwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 13:52:37 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E1220C48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Sat, 3 Feb 2018 13:52:33 -0500
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
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
Message-ID: <20180203135233.797c41d6@gandalf.local.home>
In-Reply-To: <20180202230458.840252014@goodmis.org>
References: <20180202230458.840252014@goodmis.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I need to add a "Quick guide" and "Tips and tricks" section to the
document. To explain the arguments better...

Simple args are:

 "int val", "unsigned int val", "char x", "unsigned long addr",

Also the types:

 "s32 val", "u32 val", "s8 x", "u64 addr"

The above are all printed in decimal "%d" or "%u", if you want hex...

 "x32 val", "x8 x", "x64 addr"

If you want to have it use "%pS" to print (symbols)

 "symbol addr" is like: "%pS", (void *)addr

Arrays can be expressed after the type:

 "x8[6] mac" is like: "%x,%x,%x,%x,%x,%x", mac[0], mac[1], mac[2],
                                           mac[3], mac[4], mac[5]

Where mac would be: unsigned char mac[6] type.

Note, arrays of type "char" and "unsigned char" turn into a static
string.

 "char[10] str" is like: "%s", str

Where str is defined as char str[10];

If the argument is a pointer to a structure, you can index into the
structure:

 "x64 ip[16]" is like: "%llx", ((u64 *)ip)[16]

Finally, if an argument is a pointer to a structure, and you want to
get to another structure that it points to, for example

 struct sk_buff *skb;

and you want to get to:

  skb->dev->perm_addr

when the parameter is a pointer to skb.

  (gdb) printf "%d\n", &((struct sk_buff *)0)->dev
16
  (gdb) printf "%d\n", &((struct net_device *)0)->perm_addr
558

The net_device *dev is 16 bytes into sk_buff, and the char array
perm_addr, is 558 bytes into the net_device structure.

Where perm_addr is an array of the mac address.

 "x8[6] perm_addr+16[0]+558"

Which would turn into:

 char *dev = (char **)(((void *)skb)+16)[0];
 char *perm_addr = (char *)(dev+558);

 "%x,%x,%x,%x,%x,%x", perm_addr[0], perm_addr[1], perm_addr[2],
                      perm_addr[3], perm_addr[4], perm_addr[5]

OK, the above is a bit complex ;-) But works nicely.

-- Steve

On Fri, 02 Feb 2018 18:04:58 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> At Kernel Summit back in October, we tried to bring up trace markers, which
> would be nops within the kernel proper, that would allow modules to hook
> arbitrary trace events to them. The reaction to this proposal was less than
> favorable. We were told that we were trying to make a work around for a
> problem, and not solving it. The problem in our minds is the notion of a
> "stable trace event".
> 
> There are maintainers that do not want trace events, or more trace events in
> their subsystems. This is due to the fact that trace events post an
> interface to user space, and this interface could become required by some
> tool. This may cause the trace event to become stable where it must not
> break the tool, and thus prevent the code from changing.
> 
> Or, the trace event may just have to add padding for fields that tools
> may require. The "success" field of the sched_wakeup trace event is one such
> instance. There is no more "success" variable, but tools may fail if it were
> to go away, so a "1" is simply added to the trace event wasting ring buffer
> real estate.
> 
> I talked with Linus about this, and he told me that we already have these
> markers in the kernel. They are from the mcount/__fentry__ used by function
> tracing. Have the trace events be created by these, and see if this will
> satisfy most areas that want trace events.
> 
> I decided to implement this idea, and here's the patch set.
> 
> Introducing "function based events". These are created dynamically by a
> tracefs file called "function_events". By writing a pseudo prototype into
> this file, you create an event.
> 
>  # mount -t tracefs nodev /sys/kernel/tracing
>  # cd /sys/kernel/tracing
>  # echo 'do_IRQ(symbol ip[16] | x64[6] irq_stack[16])' > function_events
>  # cat events/functions/do_IRQ/format
> name: do_IRQ
> ID: 1399
> format:
> 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> 	field:int common_pid;	offset:4;	size:4;	signed:1;
> 
> 	field:unsigned long __parent_ip;	offset:8;	size:8;	signed:0;
> 	field:unsigned long __ip;	offset:16;	size:8;	signed:0;
> 	field:symbol ip;	offset:24;	size:8;	signed:0;
> 	field:x64 irq_stack[6];	offset:32;	size:48;	signed:0;
> 
> print fmt: "%pS->%pS(ip=%pS, irq_stack=%llx:%llx:%llx:%llx:%llx:%llx)", REC->__ip, REC->__parent_ip,
> REC->ip, REC->irq_stack[0], REC->irq_stack[1], REC->irq_stack[2], REC->irq_stack[3], REC->irq_stack[4],
> REC->irq_stack[5]
> 
>  # echo 1 > events/functions/do_IRQ/enable
>  # cat trace
>           <idle>-0     [003] d..3  3647.049344: ret_from_intr->do_IRQ(ip=cpuidle_enter_state+0xb1/0x330, irq_stack=ffffffff81665db1,10,246,ffffc900006c3e80,18,ffff88011eae9b40)
>           <idle>-0     [003] d..3  3647.049433: ret_from_intr->do_IRQ(ip=cpuidle_enter_state+0xb1/0x330, irq_stack=ffffffff81665db1,10,246,ffffc900006c3e80,18,ffff88011eae9b40)
>           <idle>-0     [003] d..3  3647.049672: ret_from_intr->do_IRQ(ip=cpuidle_enter_state+0xb1/0x330, irq_stack=ffffffff81665db1,10,246,ffffc900006c3e80,18,ffff88011eae9b40)
>           <idle>-0     [003] d..3  3647.325709: ret_from_intr->do_IRQ(ip=cpuidle_enter_state+0xb1/0x330, irq_stack=ffffffff81665db1,10,246,ffffc900006c3e80,18,ffff88011eae9b40)
>           <idle>-0     [003] d..3  3647.325929: ret_from_intr->do_IRQ(ip=cpuidle_enter_state+0xb1/0x330, irq_stack=ffffffff81665db1,10,246,ffffc900006c3e80,18,ffff88011eae9b40)
>           <idle>-0     [003] d..3  3647.325993: ret_from_intr->do_IRQ(ip=cpuidle_enter_state+0xb1/0x330, irq_stack=ffffffff81665db1,10,246,ffffc900006c3e80,18,ffff88011eae9b40)
>           <idle>-0     [003] d..3  3647.387571: ret_from_intr->do_IRQ(ip=cpuidle_enter_state+0xb1/0x330, irq_stack=ffffffff81665db1,10,246,ffffc900006c3e80,18,ffff88011eae9b40)
>           <idle>-0     [003] d..3  3647.387791: ret_from_intr->do_IRQ(ip=cpuidle_enter_state+0xb1/0x330, irq_stack=ffffffff81665db1,10,246,ffffc900006c3e80,18,ffff88011eae9b40)
>           <idle>-0     [003] d..3  3647.387874: ret_from_intr->do_IRQ(ip=cpuidle_enter_state+0xb1/0x330, irq_stack=ffffffff81665db1,10,246,ffffc900006c3e80,18,ffff88011eae9b40)
> 
> And this is much more powerful than just this. We can show strings, and
> index off of structures into other structures.
> 
>   # echo '__vfs_read(symbol read+40[0]+16)' > function_events
> 
>   # echo 1 > events/functions/__vfs_read/enable
>   # cat trace
>          sshd-1343  [005] ...2   199.734752: vfs_read->__vfs_read(read=tty_read+0x0/0xf0)
>          bash-1344  [003] ...2   199.734822: vfs_read->__vfs_read(read=tty_read+0x0/0xf0)
>          sshd-1343  [005] ...2   199.734835: vfs_read->__vfs_read(read=tty_read+0x0/0xf0)
>  avahi-daemon-910   [003] ...2   200.136740: vfs_read->__vfs_read(read=          (null))
>  avahi-daemon-910   [003] ...2   200.136750: vfs_read->__vfs_read(read=          (null))
> 
> And even read user space:
> 
>   # echo 'SyS_openat(int dfd, string path, x32 flags, x16 mode)' > function_events
>   # echo 1 > events/functions/enable
>   # grep task_fork /proc/kallsyms 
> ffffffff810d5a60 t task_fork_fair
> ffffffff810dfc30 t task_fork_dl
>   # cat trace
>             grep-1820  [000] ...2  3926.107603: entry_SYSCALL_64_fastpath->SyS_openat(dfd=-100, path=/proc/kallsyms, flags=100, mode=0)
> 
> These are fully functional events. That is, they work with ftrace,
> trace-cmd, perf, histograms, triggers, and eBPF.
> 
> What's next? I need to rewrite the function graph tracer, and be able to add
> dynamic events on function return.
> 
> I made this work with x86 with a simple function that only returns
> 6 function parameters for x86_64 and 3 for x86_32. But this could easily
> be extended.
> 
> Cheers!
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> ftrace/dynamic-ftrace-events
> 
> Head SHA1: 30fbdffd5d38bd27b04fb911f7158f10a99be8c4
> 
> 
> Steven Rostedt (VMware) (18):
>       tracing: Add function based events
>       tracing: Add documentation for function based events
>       tracing: Add simple arguments to function based events
>       tracing/x86: Add arch_get_func_args() function
>       tracing: Add hex print for dynamic ftrace based events
>       tracing: Add indirect offset to args of ftrace based events
>       tracing: Add dereferencing multiple fields per arg
>       tracing: Add "unsigned" to function based events
>       tracing: Add indexing of arguments for function based events
>       tracing: Make func_type enums for easier comparing of arg types
>       tracing: Add symbol type to function based events
>       tracing: Add accessing direct address from function based events
>       tracing: Add array type to function based events
>       tracing: Have char arrays be strings for function based events
>       tracing: Add string type for dynamic strings in function based events
>       tracing: Add NULL to skip args for function based events
>       tracing: Add indirect to indirect access for function based events
>       tracing/perf: Allow perf to use function based events
> 
> ----
>  Documentation/trace/function-based-events.rst |  426 ++++++++
>  arch/x86/kernel/ftrace.c                      |   28 +
>  include/linux/trace_events.h                  |    2 +
>  kernel/trace/Kconfig                          |   12 +
>  kernel/trace/Makefile                         |    1 +
>  kernel/trace/trace.h                          |   11 +
>  kernel/trace/trace_event_ftrace.c             | 1440 +++++++++++++++++++++++++
>  kernel/trace/trace_probe.h                    |   11 -
>  8 files changed, 1920 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/trace/function-based-events.rst
>  create mode 100644 kernel/trace/trace_event_ftrace.c
> --
> To unsubscribe from this list: send the line "unsubscribe linux-trace-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
