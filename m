Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934211AbeCMPg1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:36:27 -0400
Received: from mail.efficios.com ([167.114.142.138]:38042 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934190AbeCMPgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:36:23 -0400
Date: Tue, 13 Mar 2018 11:29:51 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: syzbot <syzbot+9c0d616860575a73166a@syzkaller.appspotmail.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        acme <acme@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        rostedt <rostedt@goodmis.org>, syzkaller-bugs@googlegroups.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Message-ID: <539259484.8875.1520954991870.JavaMail.zimbra@efficios.com>
In-Reply-To: <001a114465e241a8720567419a72@google.com>
References: <001a114465e241a8720567419a72@google.com>
Subject: Re: WARNING in tracepoint_probe_register_prio (2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.6_GA_1906 (ZimbraWebClient - FF52 (Linux)/8.8.6_GA_1906)
Thread-Topic: WARNING in tracepoint_probe_register_prio (2)
Thread-Index: dedKd711yJrLUNtHdaHp5Os5eLdECA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 12, 2018, at 9:59 PM, syzbot syzbot+9c0d616860575a73166a@syzkaller.appspotmail.com wrote:

> Hello,
> 
> syzbot hit the following crash on bpf-next commit
> 6d8cb045cde681e64a5ed80a2ab70be831a7f9b0 (Fri Mar 9 07:46:33 2018 +0000)
> bpf: comment why dots in filenames under BPF virtual FS are not allowed

Hi,

Here is a WARN_ON() splat in tracepoint.c, which I suspect is caused
by perf trying to register the same probe twice to the tracepoint API.
We got another splat on unregister too, which I will forward in a
separate email.

Thoughts ?

Thanks,

Mathieu


> 
> So far this crash happened 6 times on bpf-next, upstream.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9c0d616860575a73166a@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441dd9
> RDX: 00000000ffffffff RSI: 0000000000000000 RDI: 0000000020348f88
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000032
> R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000004
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
> WARNING: CPU: 0 PID: 4185 at kernel/tracepoint.c:210 tracepoint_add_func
> kernel/tracepoint.c:210 [inline]
> WARNING: CPU: 0 PID: 4185 at kernel/tracepoint.c:210
> tracepoint_probe_register_prio+0x397/0x9a0 kernel/tracepoint.c:282
> Kernel panic - not syncing: panic_on_warn set ...
> 
> CPU: 0 PID: 4185 Comm: syzkaller994063 Not tainted 4.16.0-rc4+ #28
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x24d lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
>  __warn+0x1dc/0x200 kernel/panic.c:547
>  report_bug+0x211/0x2d0 lib/bug.c:184
>  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:986
> RIP: 0010:tracepoint_add_func kernel/tracepoint.c:210 [inline]
> RIP: 0010:tracepoint_probe_register_prio+0x397/0x9a0 kernel/tracepoint.c:282
> RSP: 0018:ffff8801bbc87468 EFLAGS: 00010293
> RAX: ffff8801b5a3c680 RBX: 00000000fffffff4 RCX: ffffffff81735e67
> RDX: 0000000000000000 RSI: ffffffff86f42a00 RDI: 0000000000000286
> RBP: ffff8801bbc87570 R08: 1ffff10037790de1 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: dffffc0000000000 R14: 0000000000000000 R15: ffff8801bbc87548
>  tracepoint_probe_register+0x2a/0x40 kernel/tracepoint.c:303
>  trace_event_reg+0x167/0x320 kernel/trace/trace_events.c:305
>  perf_trace_event_reg kernel/trace/trace_event_perf.c:122 [inline]
>  perf_trace_event_init kernel/trace/trace_event_perf.c:197 [inline]
>  perf_trace_init+0x4ef/0xab0 kernel/trace/trace_event_perf.c:221
>  perf_tp_event_init+0x7d/0xf0 kernel/events/core.c:7979
>  perf_try_init_event+0xc9/0x2a0 kernel/events/core.c:9240
>  perf_init_event kernel/events/core.c:9278 [inline]
>  perf_event_alloc+0x1cc6/0x2b00 kernel/events/core.c:9542
>  SYSC_perf_event_open+0x84e/0x2e00 kernel/events/core.c:9997
>  SyS_perf_event_open+0x39/0x50 kernel/events/core.c:9883
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x441dd9
> RSP: 002b:00007ffcca452388 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441dd9
> RDX: 00000000ffffffff RSI: 0000000000000000 RDI: 0000000020348f88
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000032
> R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000004
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> If you want to test a patch for this bug, please reply with:
> #syz test: git://repo/address.git branch
> and provide the patch inline or as an attachment.
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
