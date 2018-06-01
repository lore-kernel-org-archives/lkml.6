Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeFAIyC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:54:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:51721 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750739AbeFAIx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:53:58 -0400
Date: Fri, 1 Jun 2018 10:53:56 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Maninder Singh <maninder1.s@samsung.com>, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 2/2] printk: make sure to print log on console.
Message-ID: <20180601085356.kncuat7epkbtythv@pathway.suse.cz>
References: <CGME20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e@epcas5p2.samsung.com>
 <20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e~zs5h59tMh2250222502epcas5p2S@epcas5p2.samsung.com>
 <20180531105215.GF477@jagdpanzerIV>
 <20180531122112.bfeqtmwpl2qc67a5@pathway.suse.cz>
 <20180601044050.GA5687@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601044050.GA5687@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-06-01 13:40:50, Sergey Senozhatsky wrote:
> On (05/31/18 14:21), Petr Mladek wrote:
> > > 
> > > Upstream printk has no printing kthread. And we also run
> > > printk()->console_unlock() with disabled preemption.
> > 
> > Yes, the comment was wrong
> 
> Yes, that was the only thing I meant.
> I really didn't have any time to look at the patch yesterday, just
> commented on the most obvious thing.

Fair enough.

> > but the problem is real.
> 
> Yep, could be. But not exactly the way it is described in the commit
> messages and the patch does not fully address the problem.
> 
> The patch assumes that all those events happen sequentially. While
> in reality they can happen in parallel on different CPUs.
> 
> Example:
> 
> 	CPU0					CPU1
> 
> 	set console verbose
> 
> 	dump_backtrace()
> 	{
> 		// for (;;)  print frames
> 		printk("%pS\n", frame0);
> 		printk("%pS\n", frame1);
> 		printk("%pS\n", frame2);
> 		printk("%pS\n", frame3);
> 		...				console_loglevel = CONSOLE_LOGLEVEL_SILENT;
> 		printk("%pS\n", frame12);
> 		printk("%pS\n", frame13);
> 	}
> 
> Part of backtrace or the entire backtrace will be missed, because
> we read the global console_loglevel. The problem is still there.

[...]

> So I'd say that most likely the following scenarios can suffer:
> 
> - NMI comes in, sets loglevel to X, printk-s some data, restores the
>   loglevel back to Y
> - IRQ comes in [like sysrq, etc] comes in and does the same thing
> - software exception comes in and does the same thing [e.g. bust_spinlocks()
>   at arch/s390/mm/fault.c]


My view is:

The race with another printk() (console_lock owner) is much more
likely than a race between two CPUs manipulating console_loglevel.

The proposed patch seems to be in the right direction. It is supposed
to fix the most likely scenario. We could block it and request full
solution but I wonder if it is worth it.

I am personally fine with this partial solution for now. We could
always make it better if people meet the other scenarios.

Best Regards,
Petr
