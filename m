Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeDTCPR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 22:15:17 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:42717 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753784AbeDTCPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 22:15:16 -0400
X-Google-Smtp-Source: AIpwx4//uueBmnyWUajdoeqD340sY1B7BDIUgGBdOvZRU4GdEN74F8zxK70LQ7zU3NjnEs1CTJlJIg==
Date: Fri, 20 Apr 2018 11:15:11 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: Ratelimit messages printed by console drivers
Message-ID: <20180420021511.GB6397@jagdpanzerIV>
References: <20180413124704.19335-1-pmladek@suse.com>
 <20180413101233.0792ebf0@gandalf.local.home>
 <20180414023516.GA17806@tigerII.localdomain>
 <20180416014729.GB1034@jagdpanzerIV>
 <20180416042553.GA555@jagdpanzerIV>
 <20180419125353.lawdc3xna5oqlq7k@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419125353.lawdc3xna5oqlq7k@pathway.suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/19/18 14:53), Petr Mladek wrote:
> > > > 
> > > > Besides 100 lines is absolutely not enough for any real lockdep splat.
> > > > My call would be - up to 1000 lines in a 1 minute interval.
> 
> But this would break the intention of this patch.

You picked an arbitrary value and now you are saying that any other
value will not work?

> Come on guys! The first reaction how to fix the infinite loop was
> to fix the console drivers and remove the recursive messages. We are
> talking about messages that should not be there or they should
> get replaced by WARN_ONCE(), print_once() or so. This patch only
> give us a chance to see the problem and do not blow up immediately.
> 
> I am fine with increasing the number of lines. But we need to keep
> the timeout long. In fact, 1 hour is still rather short from my POV.

Disagree.

I saw 3 or 4 lockdep reports coming from console drivers. "100 lines"
is way too restrictive. I want to have a complete report; not the first
50 lines, not the first 103 lines, which would "hint" me that "hey, there
is something wrong there, but you are on your own to figure out the rest".

> > > Well, if we want to basically turn printk_safe() into printk_safe_ratelimited().
> > > I'm not so sure about it.
> 
> No, it is not about printk_safe(). The ratelimit is active when
> console_owner == current. It triggers when printk() is called
> inside

"console_owner == current" is exactly the point when we call console
drivers and add scheduler, networking, timekeeping, etc. locks to the
picture. And so far all of the lockdeps reports that we had were from
call_console_drivers(). So it very much is about printk_safe().

> > > Besides the patch also rate limits printk_nmi->logbuf - the logbuf
> > > PRINTK_NMI_DEFERRED_CONTEXT_MASK bypass, which is way too important
> > > to rate limit it - for no reason.
> 
> Again. It has the effect only when console_owner == current. It means
> that it affects "only" NMIs that interrupt console_unlock() when calling
> console drivers.

What is your objection here? NMIs can come anytime.

> > One more thing,
> > I'd really prefer to rate limit the function which flushes per-CPU
> > printk_safe buffers; not the function that appends new messages to
> > the per-CPU printk_safe buffers.
> 
> I wonder if this opinion is still valid after explaining the
> dependency on printk_safe(). In each case, it sounds weird
> to block printk_safe buffers with some "unwanted" messages.
> Or maybe I miss something.

I'm not following.

The fact that some consoles under some circumstances can add unwanted
messages to the buffer does not look like a good enough reason to start
rate limiting _all_ messages and to potentially discard the _important_
ones.

	-ss
