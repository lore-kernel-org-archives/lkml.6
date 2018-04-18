Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752914AbeDRPCR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:02:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:39548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752096AbeDRPCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:02:16 -0400
Date: Wed, 18 Apr 2018 17:02:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] printk: wake up klogd in vprintk_emit
Message-ID: <20180418150214.z7oyughldrktj6e4@pathway.suse.cz>
References: <20180414030145.26304-1-sergey.senozhatsky@gmail.com>
 <20180418102943.5aa0ffc4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418102943.5aa0ffc4@gandalf.local.home>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-04-18 10:29:43, Steven Rostedt wrote:
> On Sat, 14 Apr 2018 12:01:45 +0900
> Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> 
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -1888,6 +1888,7 @@ asmlinkage int vprintk_emit(int facility, int level,
> >  
> >  	printed_len = log_output(facility, level, lflags, dict, dictlen, text, text_len);
> >  
> > +	wake_up_klogd();
> >  	logbuf_unlock_irqrestore(flags);
> 
> You can't do this, because the scheduler can call printk_deferred()
> with the rq lock held, and printk_deferred() will grab the logbuf lock.
> 
> Calling wake_up_klogd() will grab the rq lock and give us a A-B<->B-A
> locking order.

wake_up_klogd() uses the lockless irq_work_queue(). So it is actually
safe.

But the name is confusing. We should rename it.

Best Regards,
Petr
