Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeEKJuL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 05:50:11 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44092 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeEKJuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 05:50:10 -0400
X-Google-Smtp-Source: AB8JxZoCEQbCGb88fFRN5G6O+1Kqemnh4JaMieeO7SS+ZIZoGiKb+IeWt3MegfARpk2hjfMCbHBmSw==
Date: Fri, 11 May 2018 18:50:04 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: printk feature for syzbot?
Message-ID: <20180511095004.GA6575@jagdpanzerIV>
References: <201805102350.JJH73950.tVJHQLFSOMOOFF@I-love.SAKURA.ne.jp>
 <20180511014515.GA895@jagdpanzerIV>
 <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
 <20180511062151.GA18160@jagdpanzerIV>
 <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/11/18 11:17), Dmitry Vyukov wrote:
> 
> From what I see, it seems that interrupts can be nested:

Hm, I thought that in general IRQ handlers run with local IRQs
disabled on CPU. So, generally, IRQs don't nest. Was I wrong?
NMIs can nest, that's true; but I thought that at least IRQs
don't.

> https://syzkaller.appspot.com/bug?id=72eddef9cedcf81486adb9dd3e789f0d77505ba5
> https://syzkaller.appspot.com/bug?id=66fcf61c65f8aa50bbb862eb2fde27c08909a4ff
> 
> Will this in_nmi()/in_irq()/in_serving_softirq()/else be enough to
> untangle output printed by such nested interrupts?

Well, hm. __irq_enter() does preempt_count_add(HARDIRQ_OFFSET) and
__irq_exit() does preempt_count_sub(HARDIRQ_OFFSET). So, technically,
you can store

	preempt_count() & HARDIRQ_MASK
	preempt_count() & SOFTIRQ_MASK
	preempt_count() & NMI_MASK

in that extended context tracking. The numbers will not tell you
the IRQ line number, for instance, but at least you'll be able to
distinguish different hard/soft IRQs, NMIs. Just an idea, I didn't
check it, may be it won't work at all.

Ideally, the serial log should be like this

	i:1 ... foo()
	i:1 ... bar()
	i:2 ... foo()  // __irq_enter()
	i:2 ... bar()
	i:2 ... buz()  // __irq_exit()
	i:1 ... buz()

but I may be completely wrong.

Petr and Steven probably will have better ideas.

	-ss
