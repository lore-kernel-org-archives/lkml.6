Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92637C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D5225D36
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D5225D36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934295AbeGBMAR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:00:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:54224 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753497AbeGBMAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:00:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D1059ADA7;
        Mon,  2 Jul 2018 12:00:13 +0000 (UTC)
Date:   Mon, 2 Jul 2018 14:00:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
Message-ID: <20180702120012.GL19043@dhcp22.suse.cz>
References: <2d8c3056-1bc2-9a32-d745-ab328fd587a1@i-love.sakura.ne.jp>
 <20180626170345.GA3593@linux.vnet.ibm.com>
 <20180627072207.GB32348@dhcp22.suse.cz>
 <20180627143125.GW3593@linux.vnet.ibm.com>
 <20180628113942.GD32348@dhcp22.suse.cz>
 <20180628213105.GP3593@linux.vnet.ibm.com>
 <20180629090419.GD13860@dhcp22.suse.cz>
 <20180629125218.GX3593@linux.vnet.ibm.com>
 <20180629132638.GD5963@dhcp22.suse.cz>
 <20180630170522.GZ3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180630170522.GZ3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 30-06-18 10:05:22, Paul E. McKenney wrote:
> On Fri, Jun 29, 2018 at 03:26:38PM +0200, Michal Hocko wrote:
> > On Fri 29-06-18 05:52:18, Paul E. McKenney wrote:
> > > On Fri, Jun 29, 2018 at 11:04:19AM +0200, Michal Hocko wrote:
> > > > On Thu 28-06-18 14:31:05, Paul E. McKenney wrote:
> > > > > On Thu, Jun 28, 2018 at 01:39:42PM +0200, Michal Hocko wrote:
> > [...]
> > > > > > Well, I am not really sure what is the objective of the oom notifier to
> > > > > > point you to the right direction. IIUC you just want to kick callbacks
> > > > > > to be handled sooner under a heavy memory pressure, right? How is that
> > > > > > achieved? Kick a worker?
> > > > > 
> > > > > That is achieved by enqueuing a non-lazy callback on each CPU's callback
> > > > > list, but only for those CPUs having non-empty lists.  This causes
> > > > > CPUs with lists containing only lazy callbacks to be more aggressive,
> > > > > in particular, it prevents such CPUs from hanging out idle for seconds
> > > > > at a time while they have callbacks on their lists.
> > > > > 
> > > > > The enqueuing happens via an IPI to the CPU in question.
> > > > 
> > > > I am afraid this is too low level for my to understand what is going on
> > > > here. What are lazy callbacks and why do they need any specific action
> > > > when we are getting close to OOM? I mean, I do understand that we might
> > > > have many callers of call_rcu and free memory lazily. But there is quite
> > > > a long way before we start the reclaim until we reach the OOM killer path.
> > > > So why don't those callbacks get called during that time period? How are
> > > > their triggered when we are not hitting the OOM path? They surely cannot
> > > > sit there for ever, right? Can we trigger them sooner? Maybe the
> > > > shrinker is not the best fit but we have a retry feedback loop in the page
> > > > allocator, maybe we can kick this processing from there.
> > > 
> > > The effect of RCU's current OOM code is to speed up callback invocation
> > > by at most a few seconds (assuming no stalled CPUs, in which case
> > > it is not possible to speed up callback invocation).
> > > 
> > > Given that, I should just remove RCU's OOM code entirely?
> > 
> > Yeah, it seems so. I do not see how this would really help much. If we
> > really need some way to kick callbacks then we should do so much earlier
> > in the reclaim process - e.g. when we start struggling to reclaim any
> > memory.
> 
> One approach would be to tell RCU "It is time to trade CPU for memory"
> at the beginning of that struggle and then tell RCU "Go back to optimizing
> for CPU" at the end of that struggle.  Is there already a way to do this?
> If so, RCU should probably just switch to it.

Well, I can think of the first "we are strugling part". This would be
anytime we are strugling to reclaim any memory. If we knew how much can
be sitting in callbacks then it would certainly help to make some
educated decision but I am worried we do not have any number to look at.
Or maybe we have the number of callbacks to know to kick the processing?

The other part and go back to optimize for cpu is harder. We are
ususally not running the code when we do not struggle ;)

> But what is the typical duration of such a struggle?  Does this duration
> change with workload?  (I suspect that the answers are "who knows?" and
> "yes", but you tell me!)  Are there other oom handlers that would prefer
> the approach of the previous paragraph?
> 
> > I am curious. Has the notifier been motivated by a real world use case
> > or it was "nice thing to do"?
> 
> It was introduced by b626c1b689364 ("rcu: Provide OOM handler to motivate
> lazy RCU callbacks").  The motivation for this commit was a set of changes
> that improved energy efficiency by making CPUs sleep for longer when all
> of their pending callbacks were known to only free memory (as opposed
> to doing a wakeup or some such).  Prior to this set of changes, a CPU
> with callbacks would invoke those callbacks (thus freeing the memory)
> within a jiffy or so of the end of a grace period.  After this set of
> changes, a CPU might wait several seconds.  This was a concern to people
> with small-memory systems, hence commit b626c1b689364.

Do we have any real life examples of OOMs caused by the lazy execution
of rcu callbacks? If not then I would simply drop the notifier and get
back to _some_ implementation if somebody sees a real problem.
-- 
Michal Hocko
SUSE Labs
