Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeDSJyJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 05:54:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:37881 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbeDSJyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 05:54:07 -0400
Date: Thu, 19 Apr 2018 11:54:05 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] printk: wake up klogd in vprintk_emit
Message-ID: <20180419095405.juihlwjqvd3ntmvi@pathway.suse.cz>
References: <20180414030145.26304-1-sergey.senozhatsky@gmail.com>
 <20180418140409.6hvkbip4skfs4x7y@pathway.suse.cz>
 <20180419012311.GB2700@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419012311.GB2700@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-04-19 10:23:11, Sergey Senozhatsky wrote:
> On (04/18/18 16:04), Petr Mladek wrote:
> [..]
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > index 2f4af216bd6e..86f0b337cbf6 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -1888,6 +1888,7 @@ asmlinkage int vprintk_emit(int facility, int level,
> > >  
> > >  	printed_len = log_output(facility, level, lflags, dict, dictlen, text, text_len);
> > >  
> > > +	wake_up_klogd();
> > >  	logbuf_unlock_irqrestore(flags);
> > 
> > In fact, I would feel more comfortable if we move this to the end
> > of vprintk_emit() right before return printk_len. This will be
> > more close to the current behavior (console first). But it will
> > still wakeup klogd much earlier and regularly if there is
> > a flood of messages.
> 
> Hm, the idea of the patch is that the existing "push everything to slow
> consoles first, then wakeup syslog" is not very robust.

I guess that you know why I suggested what I suggested ;-)
Just for record, I thought the following way:

The obsession about getting messages on consoles ASAP blocked
any softlockup prevention for years. There are surely situations
where this matter and we need to keep this in mind.

Loggers might preempt the current task because of priority
inversion. It is rather a corner case. The priority inversion is
problem on its own that probably do not have a good solution.


Our main target is to increase the chance to see the messages.
In theory userspace loggers might be faster than a slow console.
But they are not much reliable by definition. They need to get
scheduled, copy the message, store it into a file, the file need
to get synced to the disk. There are many things that might get
wrong there.


All in all, neither solution would work better in all situations.
I would just feel more comfortable if we do not go to the other
extreme, ...


> But probably we can do what you suggested, yes.

Thanks a lot for using this in v2.

Best Regards,
Petr
