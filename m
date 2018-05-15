Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeEOFUt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 01:20:49 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40949 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbeEOFUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 01:20:47 -0400
X-Google-Smtp-Source: AB8JxZpSOxhz/u7ucS6c/MOpTnm//SwZjs8i9T6e+XeefiXHz0eGn6LBFp8YUqAbkvzNg6oKLhC2wg==
Date: Tue, 15 May 2018 14:20:42 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: printk feature for syzbot?
Message-ID: <20180515052042.GB480@jagdpanzerIV>
References: <201805102350.JJH73950.tVJHQLFSOMOOFF@I-love.SAKURA.ne.jp>
 <20180511014515.GA895@jagdpanzerIV>
 <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
 <20180511062151.GA18160@jagdpanzerIV>
 <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
 <20180511095004.GA6575@jagdpanzerIV>
 <20180511093716.18329322@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511093716.18329322@gandalf.local.home>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On (05/11/18 09:37), Steven Rostedt wrote:
> > On (05/11/18 11:17), Dmitry Vyukov wrote:
> > > 
> > > From what I see, it seems that interrupts can be nested:  
> > 
> > Hm, I thought that in general IRQ handlers run with local IRQs
> > disabled on CPU. So, generally, IRQs don't nest. Was I wrong?
> > NMIs can nest, that's true; but I thought that at least IRQs
> > don't.
> 
> We normally don't run nested interrupts, although as the comment in
> preempt.h says:
> 
>  * The hardirq count could in theory be the same as the number of
>  * interrupts in the system, but we run all interrupt handlers with
>  * interrupts disabled, so we cannot have nesting interrupts. Though
>  * there are a few palaeontologic drivers which reenable interrupts in
>  * the handler, so we need more than one bit here.
> 
> And no, NMI handlers do not nest. Yes, we deal with nested NMIs, but in
> those cases, we just set a bit as a latch, and return, and when the
> first NMI is complete, it checks that bit and if it is set, it executes
> another NMI handler.

Good to know!
I thought that NMI can nest in some weird cases, like a breakpoint from
NMI. This must be super tricky, given that nested NMI will corrupt the
stack of the previous NMI, etc. Anyway.

> > Well, hm. __irq_enter() does preempt_count_add(HARDIRQ_OFFSET) and
> > __irq_exit() does preempt_count_sub(HARDIRQ_OFFSET). So, technically,
> > you can store
> > 
> > 	preempt_count() & HARDIRQ_MASK
> > 	preempt_count() & SOFTIRQ_MASK
> > 	preempt_count() & NMI_MASK
> >
[..]
> I handle nesting of different contexts in the ftrace ring buffer using
> the preempt count. See trace_recursive_lock/unlock() in
> kernel/trace/ring_buffer.c.

Thanks. So you are also checking the preempt_count().

	-ss
