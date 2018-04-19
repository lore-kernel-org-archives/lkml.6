Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbeDSMyA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 08:54:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:56099 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751865AbeDSMx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 08:53:57 -0400
Date: Thu, 19 Apr 2018 14:53:53 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: Ratelimit messages printed by console drivers
Message-ID: <20180419125353.lawdc3xna5oqlq7k@pathway.suse.cz>
References: <20180413124704.19335-1-pmladek@suse.com>
 <20180413101233.0792ebf0@gandalf.local.home>
 <20180414023516.GA17806@tigerII.localdomain>
 <20180416014729.GB1034@jagdpanzerIV>
 <20180416042553.GA555@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416042553.GA555@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-04-16 13:25:53, Sergey Senozhatsky wrote:
> On (04/16/18 10:47), Sergey Senozhatsky wrote:
> > On (04/14/18 11:35), Sergey Senozhatsky wrote:
> > > On (04/13/18 10:12), Steven Rostedt wrote:
> > > > 
> > > > > The interval is set to one hour. It is rather arbitrary selected time.
> > > > > It is supposed to be a compromise between never print these messages,
> > > > > do not lockup the machine, do not fill the entire buffer too quickly,
> > > > > and get information if something changes over time.
> > > > 
> > > > 
> > > > I think an hour is incredibly long. We only allow 100 lines per hour for
> > > > printks happening inside another printk?
> > > > 
> > > > I think 5 minutes (at most) would probably be plenty. One minute may be
> > > > good enough.
> > > 
> > > Besides 100 lines is absolutely not enough for any real lockdep splat.
> > > My call would be - up to 1000 lines in a 1 minute interval.

But this would break the intention of this patch. We need to flush all
messages to the console before the timeout. Otherwise we would never
break the possible infinite loop.

Come on guys! The first reaction how to fix the infinite loop was
to fix the console drivers and remove the recursive messages. We are
talking about messages that should not be there or they should
get replaced by WARN_ONCE(), print_once() or so. This patch only
give us a chance to see the problem and do not blow up immediately.

I am fine with increasing the number of lines. But we need to keep
the timeout long. In fact, 1 hour is still rather short from my POV.


> > Well, if we want to basically turn printk_safe() into printk_safe_ratelimited().
> > I'm not so sure about it.

No, it is not about printk_safe(). The ratelimit is active when
console_owner == current. It triggers when printk() is called
inside

	console_lock_spinning_enable();

	  call_console_drivers(ext_text, ext_len, text, len);
	    printk();

	console_lock_spinning_disable_and_check()

It will continue working even if we disable printk_safe() context
earlier and the messages are stored into the main log buffer.


> > Besides the patch also rate limits printk_nmi->logbuf - the logbuf
> > PRINTK_NMI_DEFERRED_CONTEXT_MASK bypass, which is way too important
> > to rate limit it - for no reason.

Again. It has the effect only when console_owner == current. It means
that it affects "only" NMIs that interrupt console_unlock() when calling
console drivers.

Anyway, it needs to get fixed. I suggest to update the check in
printk_func():

	if (console_owner == current && !in_nmi() &&
	    !__ratelimit(&ratelimit_console))
		return 0;


> One more thing,
> I'd really prefer to rate limit the function which flushes per-CPU
> printk_safe buffers; not the function that appends new messages to
> the per-CPU printk_safe buffers.

I wonder if this opinion is still valid after explaining the
dependency on printk_safe(). In each case, it sounds weird
to block printk_safe buffers with some "unwanted" messages.
Or maybe I miss something.

Best Regards,
Petr
