Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755182AbeDTOCB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:02:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:56239 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754894AbeDTOB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:01:59 -0400
Date: Fri, 20 Apr 2018 16:01:57 +0200
From: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: Ratelimit messages printed by console drivers
Message-ID: <20180420140157.2nx5nkojj7l2y7if@pathway.suse.cz>
References: <20180413124704.19335-1-pmladek@suse.com>
 <20180413101233.0792ebf0@gandalf.local.home>
 <20180414023516.GA17806@tigerII.localdomain>
 <20180416014729.GB1034@jagdpanzerIV>
 <20180416042553.GA555@jagdpanzerIV>
 <20180419125353.lawdc3xna5oqlq7k@pathway.suse.cz>
 <20180420021511.GB6397@jagdpanzerIV>
 <20180420091224.cotxcfycmtt2hm4m@pathway.suse.cz>
 <20180420080428.622a8e7f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420080428.622a8e7f@gandalf.local.home>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-04-20 08:04:28, Steven Rostedt wrote:
> On Fri, 20 Apr 2018 11:12:24 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > Yes, my number was arbitrary. The important thing is that it was long
> > enough. Or do you know about an console that will not be able to write
> > 100 lines within one hour?
> 
> The problem is the way rate limit works. If you print 100 lines (or
> 1000) in 5 seconds, then you just stopped printing from that context
> for 59 minutes and 55 seconds. That's a long time to block printing.

Are we talking about the same context?

I am talking about console drivers called from console_unlock(). It is
very special context because it is more or less recursive:

     + could cause infinite loop
     + the errors are usually the same again and again

As a result, if you get too many messages from this context:

     + you are lost (recursion)
     + more messages != new information

And you need to fix the problem anyway. Otherwise, the system
logging is a mess.


> What happens if you had a couple of NMIs go off that takes up that
> time, and then you hit a bug 10 minutes later from that context. You
> just lost it.

I do not understand how this is related to the NMI context.
The messages in NMI context are not throttled!

OK, the original patch throttled also NMI messages when NMI
interrupted console drivers. But it is easy to fix.


> This is a magnitude larger than any other user of rate limit in the
> kernel. The most common time is 5 seconds. The longest I can find is 1
> minute. You are saying you want to block printing from this context for
> 60 minutes!

I see 1 day long limits in dio_warn_stale_pagecache() and
xfs_scrub_experimental_warning().

Note that most ratelimiting is related to a single message. Also it
is in situation where the system should recover within seconds.


> That is HUGE! I don't understand your rational for such a huge number.
> What data do you have to back that up with?

We want to allow seeing the entire lockdep splat (Sergey wants more
than 100 lines). Also it is not that unusual that slow console is busy
several minutes when too many things are happening.

I proposed that long delay because I want to be on the safe side.
Also I do not see a huge benefit in repeating the same messages
too often.

Alternative solution would be to allow first, lets say 250, lines
and then nothing. I mean to change the approach from rate-limiting
to print-once.

Best Regards,
Petr
