Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B9BC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2F727B7E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2F727B7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754220AbeF2JEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:04:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:35608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753279AbeF2JEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:04:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 018D2AF31;
        Fri, 29 Jun 2018 09:04:20 +0000 (UTC)
Date:   Fri, 29 Jun 2018 11:04:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
Message-ID: <20180629090419.GD13860@dhcp22.suse.cz>
References: <1529493638-6389-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <alpine.DEB.2.21.1806201528490.16984@chino.kir.corp.google.com>
 <20180621073142.GA10465@dhcp22.suse.cz>
 <2d8c3056-1bc2-9a32-d745-ab328fd587a1@i-love.sakura.ne.jp>
 <20180626170345.GA3593@linux.vnet.ibm.com>
 <20180627072207.GB32348@dhcp22.suse.cz>
 <20180627143125.GW3593@linux.vnet.ibm.com>
 <20180628113942.GD32348@dhcp22.suse.cz>
 <20180628213105.GP3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628213105.GP3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-06-18 14:31:05, Paul E. McKenney wrote:
> On Thu, Jun 28, 2018 at 01:39:42PM +0200, Michal Hocko wrote:
> > On Wed 27-06-18 07:31:25, Paul E. McKenney wrote:
> > > On Wed, Jun 27, 2018 at 09:22:07AM +0200, Michal Hocko wrote:
> > > > On Tue 26-06-18 10:03:45, Paul E. McKenney wrote:
> > > > [...]
> > > > > 3.	Something else?
> > > > 
> > > > How hard it would be to use a different API than oom notifiers? E.g. a
> > > > shrinker which just kicks all the pending callbacks if the reclaim
> > > > priority reaches low values (e.g. 0)?
> > > 
> > > Beats me.  What is a shrinker?  ;-)
> > 
> > This is a generich mechanism to reclaim memory that is not on standard
> > LRU lists. Lwn.net surely has some nice coverage (e.g.
> > https://lwn.net/Articles/548092/).
> 
> "In addition, there is little agreement over what a call to a shrinker
> really means or how the called subsystem should respond."  ;-)
> 
> Is this set up using register_shrinker() in mm/vmscan.c?  I am guessing

Yes, exactly. You are supposed to implement the two methods in struct
shrink_control

> that the many mentions of shrinker in DRM are irrelevant.
> 
> If my guess is correct, the API seems a poor fit for RCU.  I can
> produce an approximate number of RCU callbacks for ->count_objects(),
> but a given callback might free a lot of memory or none at all.  Plus,
> to actually have ->scan_objects() free them before returning, I would
> need to use something like rcu_barrier(), which might involve longer
> delays than desired.`

Well, I am not yet sure how good fit this is because I still do not
understand the underlying problem your notifier is trying to solve. So I
will get back to this once that is settled.
> 
> Or am I missing something here?
> 
> > > More seriously, could you please point me at an exemplary shrinker
> > > use case so I can see what is involved?
> > 
> > Well, I am not really sure what is the objective of the oom notifier to
> > point you to the right direction. IIUC you just want to kick callbacks
> > to be handled sooner under a heavy memory pressure, right? How is that
> > achieved? Kick a worker?
> 
> That is achieved by enqueuing a non-lazy callback on each CPU's callback
> list, but only for those CPUs having non-empty lists.  This causes
> CPUs with lists containing only lazy callbacks to be more aggressive,
> in particular, it prevents such CPUs from hanging out idle for seconds
> at a time while they have callbacks on their lists.
> 
> The enqueuing happens via an IPI to the CPU in question.

I am afraid this is too low level for my to understand what is going on
here. What are lazy callbacks and why do they need any specific action
when we are getting close to OOM? I mean, I do understand that we might
have many callers of call_rcu and free memory lazily. But there is quite
a long way before we start the reclaim until we reach the OOM killer path.
So why don't those callbacks get called during that time period? How are
their triggered when we are not hitting the OOM path? They surely cannot
sit there for ever, right? Can we trigger them sooner? Maybe the
shrinker is not the best fit but we have a retry feedback loop in the page
allocator, maybe we can kick this processing from there.
-- 
Michal Hocko
SUSE Labs
