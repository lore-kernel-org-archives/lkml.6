Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934756AbeEIMAy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:00:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50359 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbeEIMAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:00:53 -0400
Date: Wed, 9 May 2018 14:00:50 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: Ratelimit messages printed by console drivers
Message-ID: <20180509120050.eyuprdh75grhdsh4@pathway.suse.cz>
References: <20180420140157.2nx5nkojj7l2y7if@pathway.suse.cz>
 <20180420101751.6c1c70e8@gandalf.local.home>
 <20180420145720.hb7bbyd5xbm5je32@pathway.suse.cz>
 <20180420111307.44008fc7@gandalf.local.home>
 <20180423103232.k23yulv2e7fah42r@pathway.suse.cz>
 <20180423073603.6b3294ba@gandalf.local.home>
 <20180423124502.423fb57thvbf3zet@pathway.suse.cz>
 <20180425053146.GA25288@jagdpanzerIV>
 <20180426094211.okftwdzgfn72rik3@pathway.suse.cz>
 <20180427102245.GA591@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427102245.GA591@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-04-27 19:22:45, Sergey Senozhatsky wrote:
> On (04/26/18 11:42), Petr Mladek wrote:
> [..]
> > Honestly, I do not believe that console drivers are like Scheherazade.
> > They are not able to make up long interesting stories. Let's say that
> > lockdep splat has more than 100 lines but it can happen only once.
> > Let's say that WARNs have about 40 lines. I somehow doubt that we
> > could ever see 10 different WARN calls from one con->write() call.
> 
> The problem here is that it takes a human being with IQ to tell what's
> repetitive, what's useless and what's not.
> 
> 	vprintk(...)
> 	{
> 		if (!__ratelimit())
> 			return;
> 	}
> 
> has zero IQ to make such decisions.

You make it too complicated. Also it seems that you repeatedly
hide the fact that con->write() context is recursive. Just try to add
printk() into call_console_drivers() and see what happens.

IMHO, if con->write() wants to add more than 1000 (or 100 or whatever
sane limit) new lines then something is really wrong and we should
stop it. It is that simple.


> > > But we first need a real reason. Right now it looks to me like
> > > we have "a solution" to a problem which we have never witnessed.
> > 
> > I am trying to find a "simple" and generic solution for the problem
> > reported by Tejun:
> [..]
> > 1. Console is IPMI emulated serial console.  Super slow.  Also
> >    netconsole is in use.
> > 2. System runs out of memory, OOM triggers.
> > 3. OOM handler is printing out OOM debug info.
> > 4. While trying to emit the messages for netconsole, the network stack
> >    / driver tries to allocate memory and then fail, which in turn
> >    triggers allocation failure or other warning messages.  printk was
> >    already flushing, so the messages are queued on the ring.
> > 5. OOM handler keeps flushing but 4 repeats and the queue is never
> >    shrinking.  Because OOM handler is trapped in printk flushing, it
> >    never manages to free memory and no one else can enter OOM path
> >    either, so the system is trapped in this state.
> > </paste>

IMHO, we do not need to chase down this particular problem. It was
already "solved" by the commit 400e22499dd92613821 ("mm: don't warn
about allocations which stall for too long").

It was just an example. I wanted to make con->write() generally safe.
I thought that the problem (recursion) was clear enough.


> Yes, and that's why I want to take a look at the logs/backtraces.

If you want more cases to analyze, fair enough. I do not have any
at hands. It is not an urgent issue for me and I am not going to
spend more time on this.

Best Regards,
Petr
