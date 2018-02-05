Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752751AbeBEKto (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 05:49:44 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:32946 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeBEKtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 05:49:35 -0500
X-Google-Smtp-Source: AH8x226Gyk6I+6H5xPNTLVgy8UWlKhk2F310KuIvPGFlXU6X/ouXjRWUgxVmzCjLlAN3OuAmimP16A==
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
To: Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20180202230458.840252014@goodmis.org>
 <20180205102359.GV19535@localhost.localdomain>
From: Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <72fc5744-d064-9d0f-bd80-127f4d665580@redhat.com>
Date: Mon, 5 Feb 2018 11:49:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180205102359.GV19535@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2018 11:23 AM, Juri Lelli wrote:
> Hi Steve,
> 
> On 02/02/18 18:04, Steven Rostedt wrote:
>>
>> At Kernel Summit back in October, we tried to bring up trace markers, which
>> would be nops within the kernel proper, that would allow modules to hook
>> arbitrary trace events to them. The reaction to this proposal was less than
>> favorable. We were told that we were trying to make a work around for a
>> problem, and not solving it. The problem in our minds is the notion of a
>> "stable trace event".
>>
>> There are maintainers that do not want trace events, or more trace events in
>> their subsystems. This is due to the fact that trace events post an
>> interface to user space, and this interface could become required by some
>> tool. This may cause the trace event to become stable where it must not
>> break the tool, and thus prevent the code from changing.
>>
>> Or, the trace event may just have to add padding for fields that tools
>> may require. The "success" field of the sched_wakeup trace event is one such
>> instance. There is no more "success" variable, but tools may fail if it were
>> to go away, so a "1" is simply added to the trace event wasting ring buffer
>> real estate.
>>
>> I talked with Linus about this, and he told me that we already have these
>> markers in the kernel. They are from the mcount/__fentry__ used by function
>> tracing. Have the trace events be created by these, and see if this will
>> satisfy most areas that want trace events.
>>
>> I decided to implement this idea, and here's the patch set.
>>
>> Introducing "function based events". These are created dynamically by a
>> tracefs file called "function_events". By writing a pseudo prototype into
>> this file, you create an event.
>>
>>  # mount -t tracefs nodev /sys/kernel/tracing
>>  # cd /sys/kernel/tracing
>>  # echo 'do_IRQ(symbol ip[16] | x64[6] irq_stack[16])' > function_events
>>  # cat events/functions/do_IRQ/format
>> name: do_IRQ
>> ID: 1399
>> format:
>> 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
>> 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
>> 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
>> 	field:int common_pid;	offset:4;	size:4;	signed:1;
>>
>> 	field:unsigned long __parent_ip;	offset:8;	size:8;	signed:0;
>> 	field:unsigned long __ip;	offset:16;	size:8;	signed:0;
>> 	field:symbol ip;	offset:24;	size:8;	signed:0;
>> 	field:x64 irq_stack[6];	offset:32;	size:48;	signed:0;
>>
>> print fmt: "%pS->%pS(ip=%pS, irq_stack=%llx:%llx:%llx:%llx:%llx:%llx)", REC->__ip, REC->__parent_ip,
>> REC->ip, REC->irq_stack[0], REC->irq_stack[1], REC->irq_stack[2], REC->irq_stack[3], REC->irq_stack[4],
>> REC->irq_stack[5]
>>
>>  # echo 1 > events/functions/do_IRQ/enable
> 
> Got the following:
> 
> [  110.433602] =============================
> [  110.435671] WARNING: suspicious RCU usage
> [  110.437173] 4.15.0-rc9+ #42 Not tainted
> [  110.438698] -----------------------------
> [  110.440343] /home/juri/Work/kernel/linux/include/linux/rcupdate.h:749 rcu_read_lock_sched() used illegally while idle!
> [  110.444480]
> [  110.444480] other info that might help us debug this:
> [  110.444480]
> [  110.447616]
> [  110.447616] RCU used illegally from idle CPU!
> [  110.447616] rcu_scheduler_active = 2, debug_locks = 1
> [  110.452047] RCU used illegally from extended quiescent state!
> [  110.454072] 1 lock held by swapper/0/0:
> [  110.455447]  #0:  (rcu_read_lock_sched){....}, at: [<00000000de240ad4>] func_event_call+0x0/0x3c0
> [  110.458532]
> [  110.458532] stack backtrace:
> [  110.460066] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.0-rc9+ #42
> [  110.462300] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-2.fc27 04/01/2014
> [  110.464477] Call Trace:
> [  110.465095]  <IRQ>
> [  110.465600]  dump_stack+0x85/0xc5
> [  110.466417]  func_event_call+0x378/0x3c0
> [  110.467373]  ? find_held_lock+0x34/0xa0
> [  110.468216]  ? common_interrupt+0xa2/0xa2
> [  110.468978]  ? irq_work_interrupt+0xb0/0xb0
> [  110.470021]  ? hrtimer_start_range_ns+0x1bf/0x3e0
> [  110.471031]  ftrace_ops_assist_func+0x64/0xf0
> [  110.471941]  ? _raw_spin_unlock_irqrestore+0x55/0x60
> [  110.472926]  0xffffffffc02e30bf
> [  110.473491]  ? do_IRQ+0x5/0x100
> [  110.473977]  do_IRQ+0x5/0x100
> [  110.474430]  common_interrupt+0xa2/0xa2
> [  110.475014]  </IRQ>
> [  110.475341] RIP: 0010:native_safe_halt+0x2/0x10
> [  110.476020] RSP: 0018:ffffffff96a03ec8 EFLAGS: 00000206 ORIG_RAX: ffffffffffffffdd
> [  110.477137] RAX: ffffffff96a2a500 RBX: 0000000000000000 RCX: 0000000000000000
> [  110.478110] RDX: ffffffff96a2a500 RSI: 0000000000000001 RDI: ffffffff96a2a500
> [  110.478997] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> [  110.479880] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [  110.480764] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  110.481661]  default_idle+0x1f/0x1a0
> [  110.482118]  do_idle+0x166/0x1e0
> [  110.482530]  cpu_startup_entry+0x19/0x20
> [  110.482985]  start_kernel+0x40a/0x412
> [  110.483385]  secondary_startup_64+0xa5/0xb0

Isn't this the case of calling tracing functions before calling:

rcu_irq_enter();

?

-- Daniel
> 
> continuing to test this. :)
> 
> Thanks,
> 
> - Juri
> 
