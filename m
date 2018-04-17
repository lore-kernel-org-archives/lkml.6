Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeDQJDn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:03:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:47823 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751927AbeDQJDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:03:40 -0400
Date: Tue, 17 Apr 2018 11:03:35 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Buddy Lumpkin <buddy.lumpkin@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
        riel@surriel.com, mgorman@suse.de, willy@infradead.org,
        akpm@linux-foundation.org
Subject: Re: [RFC PATCH 1/1] vmscan: Support multiple kswapd threads per node
Message-ID: <20180417090335.GZ17484@dhcp22.suse.cz>
References: <1522661062-39745-1-git-send-email-buddy.lumpkin@oracle.com>
 <1522661062-39745-2-git-send-email-buddy.lumpkin@oracle.com>
 <20180403133115.GA5501@dhcp22.suse.cz>
 <EB9E8FC6-8B02-4D7C-AA50-2B5B6BD2AF40@oracle.com>
 <20180412131634.GF23400@dhcp22.suse.cz>
 <0D92091A-A135-4707-A981-9A4559ED8701@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0D92091A-A135-4707-A981-9A4559ED8701@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-04-18 20:02:22, Buddy Lumpkin wrote:
> 
> > On Apr 12, 2018, at 6:16 AM, Michal Hocko <mhocko@kernel.org> wrote:
[...]
> > But once you hit a wall with
> > hard-to-reclaim pages then I would expect multiple threads will simply
> > contend more (e.g. on fs locks in shrinkers etc…).
> 
> If that is the case, this is already happening since direct reclaims do just about
> everything that kswapd does. I have tested with a mix of filesystem reads, writes
> and anonymous memory with and without a swap device. The only locking
> problems I have run into so far are related to routines in mm/workingset.c.

You haven't tried hard enough. Try to generate a bigger fs metadata
pressure. In other words something less of a toy than a pure reader
without any real processing.

[...]

> > Or more specifically. How is the admin supposed to know how many
> > background threads are still improving the situation?
> 
> Reduce the setting and check to see if pgscan_direct is still incrementing.

This just doesn't work. You are oversimplifying a lot! There are much
more aspects to this. How many background threads are still worth it
without stealing cycles from others? Is half of CPUs per NUMA node worth
devoting to background reclaim or is it better to let those excessive
memory consumers to be throttled by the direct reclaim?

You are still ignoring/underestimating the fact that kswapd steals
cycles even from other workload that is not memory bound while direct
reclaim throttles (mostly) memory consumers.

[...]
> > I still haven't looked at your test results in detail because they seem
> > quite artificial. Clean pagecache reclaim is not all that interesting
> > IMHO
> 
> Clean page cache is extremely interesting for demonstrating this bottleneck.

yes it shows the bottleneck but it is quite artificial. Read data is
usually processed and/or written back and that changes the picture a
lot.

Anyway, I do agree that the reclaim can be made faster. I am just not
(yet) convinced that multiplying the number of workers is the way to achieve
that.

[...]
> >>> I would be also very interested
> >>> to see how to scale the number of threads based on how CPUs are utilized
> >>> by other workloads.
> >> 
> >> I think we have reached the point where it makes sense for page replacement to have more
> >> than one mode. Enterprise class servers with lots of memory and a large number of CPU
> >> cores would benefit heavily if more threads could be devoted toward proactive page
> >> replacement. The polar opposite case is my Raspberry PI which I want to run as efficiently
> >> as possible. This problem is only going to get worse. I think it makes sense to be able to 
> >> choose between efficiency and performance (throughput and latency reduction).
> > 
> > The thing is that as long as this would require admin to guess then this
> > is not all that useful. People will simply not know what to set and we
> > are going to end up with stupid admin guides claiming that you should
> > use 1/N of per node cpus for kswapd and that will not work.
> 
> I think this sysctl is very intuitive to use. Only use it if direct reclaims are
> occurring. This can be seen with sar -B. Justify any increase with testing.
> That is a whole lot easier to wrap your head around than a lot of the other
> sysctls that are available today. Find me an admin that actually understands
> what the swappiness tunable does. 

Well, you have pointed to a nice example actually. Yes swappiness is
confusing and you can find _many_ different howtos for tuning. Do they
work? No, for a long time on most workloads because we are simply
pagecache biased so much these days that we simply ignore the value most of the
time. I am pretty sure your "just watch sar -B and tune accordingly" will
become obsolete in a short time and people will get confused again.
Because they are explicitly tuning for their workload but it doesn't
help anymore because the internal implementation of the reclaim has
changed again (this happens all the time).

No, I simply do not want to repeat past errors and expose too much of
implementation details for admins who will most likely have no clue how
to use the tuning and rely on random advices on internet or even worse
admin guides of questionable quality full of cargo cult advises
(remember advises to disable THP for basically any performance problem
you see).

> > Not to
> > mention that the reclaim logic is full of heuristics which change over
> > time and a subtle implementation detail that would work for a particular
> > scaling might break without anybody noticing. Really, if we are not able
> > to come up with some auto tuning then I think that this is not really
> > worth it.
> 
> This is all speculation about how a patch behaves that you have not even
> tested. Similar arguments can be made about most of the sysctls that are
> available. 

I really do want a solid background for the change like this. You are
throwing a corner case numbers at me and ignoring some important points.
So let me repeat. If we want to allow more kswapd threads per node then
we really have to evaluate the effect on memory hogs throttling and we
should have a decent idea on how to scale those threads. If we are not
able to handle that in the kernel with the full picture then I fail to
see how admin can do that.
-- 
Michal Hocko
SUSE Labs
