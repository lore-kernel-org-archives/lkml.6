Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A552C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC8A24B05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC8A24B05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754702AbeF2N0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:26:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:51602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753471AbeF2N0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:26:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6DC53ADDA;
        Fri, 29 Jun 2018 13:26:39 +0000 (UTC)
Date:   Fri, 29 Jun 2018 15:26:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
Message-ID: <20180629132638.GD5963@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1806201528490.16984@chino.kir.corp.google.com>
 <20180621073142.GA10465@dhcp22.suse.cz>
 <2d8c3056-1bc2-9a32-d745-ab328fd587a1@i-love.sakura.ne.jp>
 <20180626170345.GA3593@linux.vnet.ibm.com>
 <20180627072207.GB32348@dhcp22.suse.cz>
 <20180627143125.GW3593@linux.vnet.ibm.com>
 <20180628113942.GD32348@dhcp22.suse.cz>
 <20180628213105.GP3593@linux.vnet.ibm.com>
 <20180629090419.GD13860@dhcp22.suse.cz>
 <20180629125218.GX3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629125218.GX3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29-06-18 05:52:18, Paul E. McKenney wrote:
> On Fri, Jun 29, 2018 at 11:04:19AM +0200, Michal Hocko wrote:
> > On Thu 28-06-18 14:31:05, Paul E. McKenney wrote:
> > > On Thu, Jun 28, 2018 at 01:39:42PM +0200, Michal Hocko wrote:
[...]
> > > > Well, I am not really sure what is the objective of the oom notifier to
> > > > point you to the right direction. IIUC you just want to kick callbacks
> > > > to be handled sooner under a heavy memory pressure, right? How is that
> > > > achieved? Kick a worker?
> > > 
> > > That is achieved by enqueuing a non-lazy callback on each CPU's callback
> > > list, but only for those CPUs having non-empty lists.  This causes
> > > CPUs with lists containing only lazy callbacks to be more aggressive,
> > > in particular, it prevents such CPUs from hanging out idle for seconds
> > > at a time while they have callbacks on their lists.
> > > 
> > > The enqueuing happens via an IPI to the CPU in question.
> > 
> > I am afraid this is too low level for my to understand what is going on
> > here. What are lazy callbacks and why do they need any specific action
> > when we are getting close to OOM? I mean, I do understand that we might
> > have many callers of call_rcu and free memory lazily. But there is quite
> > a long way before we start the reclaim until we reach the OOM killer path.
> > So why don't those callbacks get called during that time period? How are
> > their triggered when we are not hitting the OOM path? They surely cannot
> > sit there for ever, right? Can we trigger them sooner? Maybe the
> > shrinker is not the best fit but we have a retry feedback loop in the page
> > allocator, maybe we can kick this processing from there.
> 
> The effect of RCU's current OOM code is to speed up callback invocation
> by at most a few seconds (assuming no stalled CPUs, in which case
> it is not possible to speed up callback invocation).
> 
> Given that, I should just remove RCU's OOM code entirely?

Yeah, it seems so. I do not see how this would really help much. If we
really need some way to kick callbacks then we should do so much earlier
in the reclaim process - e.g. when we start struggling to reclaim any
memory.

I am curious. Has the notifier been motivated by a real world use case
or it was "nice thing to do"?
-- 
Michal Hocko
SUSE Labs
