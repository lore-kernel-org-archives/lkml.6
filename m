Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeCNVht (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 17:37:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751289AbeCNVhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 17:37:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1C120779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 14 Mar 2018 17:37:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: syzbot <syzbot+9c0d616860575a73166a@syzkaller.appspotmail.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        acme <acme@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        syzkaller-bugs@googlegroups.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: WARNING in tracepoint_probe_register_prio (2)
Message-ID: <20180314173746.3a6ab6eb@vmware.local.home>
In-Reply-To: <539259484.8875.1520954991870.JavaMail.zimbra@efficios.com>
References: <001a114465e241a8720567419a72@google.com>
        <539259484.8875.1520954991870.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018 11:29:51 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Here is a WARN_ON() splat in tracepoint.c, which I suspect is caused
> by perf trying to register the same probe twice to the tracepoint API.
> We got another splat on unregister too, which I will forward in a
> separate email.
> 
> Thoughts ?

Yes, it looks like it's perf not accounting for registered events
properly.

Peter?

-- Steve



> > RIP: 0010:tracepoint_add_func kernel/tracepoint.c:210 [inline]
> > RIP: 0010:tracepoint_probe_register_prio+0x397/0x9a0 kernel/tracepoint.c:282
> > RSP: 0018:ffff8801bbc87468 EFLAGS: 00010293
> > RAX: ffff8801b5a3c680 RBX: 00000000fffffff4 RCX: ffffffff81735e67
> > RDX: 0000000000000000 RSI: ffffffff86f42a00 RDI: 0000000000000286
> > RBP: ffff8801bbc87570 R08: 1ffff10037790de1 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > R13: dffffc0000000000 R14: 0000000000000000 R15: ffff8801bbc87548
> >  tracepoint_probe_register+0x2a/0x40 kernel/tracepoint.c:303
> >  trace_event_reg+0x167/0x320 kernel/trace/trace_events.c:305
> >  perf_trace_event_reg kernel/trace/trace_event_perf.c:122 [inline]
> >  perf_trace_event_init kernel/trace/trace_event_perf.c:197 [inline]
> >  perf_trace_init+0x4ef/0xab0 kernel/trace/trace_event_perf.c:221
> >  perf_tp_event_init+0x7d/0xf0 kernel/events/core.c:7979
> >  perf_try_init_event+0xc9/0x2a0 kernel/events/core.c:9240
> >  perf_init_event kernel/events/core.c:9278 [inline]
> >  perf_event_alloc+0x1cc6/0x2b00 kernel/events/core.c:9542
> >  SYSC_perf_event_open+0x84e/0x2e00 kernel/events/core.c:9997
> >  SyS_perf_event_open+0x39/0x50 kernel/events/core.c:9883
> >  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
> >  entry_SYSCALL_64_after_hwframe+0x42/0xb7
>
