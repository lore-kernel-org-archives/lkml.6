Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753037AbeEKNhU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750758AbeEKNhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:37:18 -0400
Date: Fri, 11 May 2018 09:37:16 -0400
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
Message-ID: <20180511093716.18329322@gandalf.local.home>
In-Reply-To: <20180511095004.GA6575@jagdpanzerIV>
References: <201805102350.JJH73950.tVJHQLFSOMOOFF@I-love.SAKURA.ne.jp>
        <20180511014515.GA895@jagdpanzerIV>
        <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
        <20180511062151.GA18160@jagdpanzerIV>
        <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
        <20180511095004.GA6575@jagdpanzerIV>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2018 18:50:04 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> On (05/11/18 11:17), Dmitry Vyukov wrote:
> > 
> > From what I see, it seems that interrupts can be nested:  
> 
> Hm, I thought that in general IRQ handlers run with local IRQs
> disabled on CPU. So, generally, IRQs don't nest. Was I wrong?
> NMIs can nest, that's true; but I thought that at least IRQs
> don't.

We normally don't run nested interrupts, although as the comment in
preempt.h says:

 * The hardirq count could in theory be the same as the number of
 * interrupts in the system, but we run all interrupt handlers with
 * interrupts disabled, so we cannot have nesting interrupts. Though
 * there are a few palaeontologic drivers which reenable interrupts in
 * the handler, so we need more than one bit here.

And no, NMI handlers do not nest. Yes, we deal with nested NMIs, but in
those cases, we just set a bit as a latch, and return, and when the
first NMI is complete, it checks that bit and if it is set, it executes
another NMI handler.

> 
> > https://syzkaller.appspot.com/bug?id=72eddef9cedcf81486adb9dd3e789f0d77505ba5
> > https://syzkaller.appspot.com/bug?id=66fcf61c65f8aa50bbb862eb2fde27c08909a4ff
> > 
> > Will this in_nmi()/in_irq()/in_serving_softirq()/else be enough to
> > untangle output printed by such nested interrupts?  
> 
> Well, hm. __irq_enter() does preempt_count_add(HARDIRQ_OFFSET) and
> __irq_exit() does preempt_count_sub(HARDIRQ_OFFSET). So, technically,
> you can store
> 
> 	preempt_count() & HARDIRQ_MASK
> 	preempt_count() & SOFTIRQ_MASK
> 	preempt_count() & NMI_MASK
> 
> in that extended context tracking. The numbers will not tell you
> the IRQ line number, for instance, but at least you'll be able to
> distinguish different hard/soft IRQs, NMIs. Just an idea, I didn't
> check it, may be it won't work at all.
> 
> Ideally, the serial log should be like this
> 
> 	i:1 ... foo()
> 	i:1 ... bar()
> 	i:2 ... foo()  // __irq_enter()
> 	i:2 ... bar()
> 	i:2 ... buz()  // __irq_exit()
> 	i:1 ... buz()
> 
> but I may be completely wrong.
> 
> Petr and Steven probably will have better ideas.

I handle nesting of different contexts in the ftrace ring buffer using
the preempt count. See trace_recursive_lock/unlock() in
kernel/trace/ring_buffer.c.

-- Steve
