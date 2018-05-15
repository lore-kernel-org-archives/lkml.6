Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753955AbeEOOjb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 10:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752543AbeEOOja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 10:39:30 -0400
Date: Tue, 15 May 2018 10:39:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: printk feature for syzbot?
Message-ID: <20180515103927.1be0cafa@gandalf.local.home>
In-Reply-To: <20180515052042.GB480@jagdpanzerIV>
References: <201805102350.JJH73950.tVJHQLFSOMOOFF@I-love.SAKURA.ne.jp>
        <20180511014515.GA895@jagdpanzerIV>
        <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
        <20180511062151.GA18160@jagdpanzerIV>
        <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
        <20180511095004.GA6575@jagdpanzerIV>
        <20180511093716.18329322@gandalf.local.home>
        <20180515052042.GB480@jagdpanzerIV>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2018 14:20:42 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> > And no, NMI handlers do not nest. Yes, we deal with nested NMIs, but in
> > those cases, we just set a bit as a latch, and return, and when the
> > first NMI is complete, it checks that bit and if it is set, it executes
> > another NMI handler.  
> 
> Good to know!
> I thought that NMI can nest in some weird cases, like a breakpoint from
> NMI. This must be super tricky, given that nested NMI will corrupt the
> stack of the previous NMI, etc. Anyway.

Well, they do kinda nest, but we work hard not to let them do anything
when they do. You can read all about it here:

https://lwn.net/Articles/484932/

> 
> > > Well, hm. __irq_enter() does preempt_count_add(HARDIRQ_OFFSET) and
> > > __irq_exit() does preempt_count_sub(HARDIRQ_OFFSET). So, technically,
> > > you can store
> > > 
> > > 	preempt_count() & HARDIRQ_MASK
> > > 	preempt_count() & SOFTIRQ_MASK
> > > 	preempt_count() & NMI_MASK
> > >  
> [..]
> > I handle nesting of different contexts in the ftrace ring buffer using
> > the preempt count. See trace_recursive_lock/unlock() in
> > kernel/trace/ring_buffer.c.  
> 
> Thanks. So you are also checking the preempt_count().
>

Yes I am.

-- Steve
