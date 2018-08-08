Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E375C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92DA21ADC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92DA21ADC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbeHHXxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:53:01 -0400
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:48267 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727480AbeHHXxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:53:01 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 09 Aug 2018 07:01:26 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fnW3B-00086w-Bw; Thu, 09 Aug 2018 07:31:25 +1000
Date:   Thu, 9 Aug 2018 07:31:25 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viro@zeniv.linux.org.uk, darrick.wong@oracle.com,
        paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, hughd@google.com, shuah@kernel.org,
        robh@kernel.org, ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, sfr@canb.auug.org.au,
        vdavydov.dev@gmail.com, chris@chris-wilson.co.uk,
        penguin-kernel@I-love.SAKURA.ne.jp, aryabinin@virtuozzo.com,
        willy@infradead.org, ying.huang@intel.com, shakeelb@google.com,
        jbacik@fb.com, mingo@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC 01/10] rcu: Make CONFIG_SRCU unconditionally enabled
Message-ID: <20180808213125.GM2234@dastard>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <153365625652.19074.8434946780002619802.stgit@localhost.localdomain>
 <20180808072040.GC27972@dhcp22.suse.cz>
 <d17e65bb-c114-55de-fb4e-e2f538779b92@virtuozzo.com>
 <20180808102734.GH27972@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808102734.GH27972@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 12:27:34PM +0200, Michal Hocko wrote:
> [CC Josh - the whole series is
> http://lkml.kernel.org/r/153365347929.19074.12509495712735843805.stgit@localhost.localdomain]
> 
> On Wed 08-08-18 13:17:44, Kirill Tkhai wrote:
> > On 08.08.2018 10:20, Michal Hocko wrote:
> > > On Tue 07-08-18 18:37:36, Kirill Tkhai wrote:
> > >> This patch kills all CONFIG_SRCU defines and
> > >> the code under !CONFIG_SRCU.
> > > 
> > > The last time somebody tried to do this there was a pushback due to
> > > kernel tinyfication. So this should really give some numbers about the
> > > code size increase. Also why can't we make this depend on MMU. Is
> > > anybody else than the reclaim asking for unconditional SRCU usage?
> > 
> > I don't know one. The size numbers (sparc64) are:
> > 
> > $ size image.srcu.disabled 
> >    text	   data	    bss	    dec	    hex	filename
> > 5117546	8030506	1968104	15116156	 e6a77c	image.srcu.disabled
> > $ size image.srcu.enabled
> >    text	   data	    bss	    dec	    hex	filename
> > 5126175	8064346	1968104	15158625	 e74d61	image.srcu.enabled
> > The difference is: 15158625-15116156 = 42469 ~41Kb
> > 
> > Please, see the measurement details to my answer to Stephen.
> > 
> > > Btw. I totaly agree with Steven. This is a very poor changelog. It is
> > > trivial to see what the patch does but it is far from clear why it is
> > > doing that and why we cannot go other ways.
> > We possibly can go another way, and there is comment to [2/10] about this.
> > Percpu rwsem may be used instead, the only thing, it is worse, is it will
> > make shrink_slab() wait unregistering shrinkers, while srcu-based
> > implementation does not require this.
> 
> Well, if unregisterring doesn't do anything subtle - e.g. an allocation
> or take locks which depend on allocation - and we can guarantee that
> then blocking shrink_slab shouldn't be a big deal.

unregister_shrinker() already blocks shrink_slab - taking a rwsem in
write mode blocks all readers - so using a per-cpu rwsem doesn't
introduce anything new or unexpected. I'd like to see numbers of the
different methods before anything else.

IMO, the big deal is that the split unregister mechanism seems to
imply superblock shrinkers can be called during sb teardown or
/after/ the filesystem has been torn down in memory (i.e. after
->put_super() is called). That's a change of behaviour, but it's
left to the filesystem to detect and handle that condition. That's
exceedingly subtle and looks like a recipe for disaster to me. I
note that XFS hasn't been updated to detect and avoid this landmine.

And, FWIW, filesystems with multiple shrinkers (e.g. XFS as 3 per
mount) will take the SCRU penalty multiple times during unmount, and
potentially be exposed to multiple different "use during/after
teardown" race conditions.

> It is subtle though.
> Maybe subtle enough to make unconditional SRCU worth it. This all should
> be in the changelog though.

IMO, we've had enough recent bugs to deal with from shrinkers being
called before the filesystem is set up and from trying to handle
allocation errors during setup. Do we really want to make shrinker
shutdown just as prone to mismanagement and subtle, hard to hit
bugs? I don't think we do - unmount is simply not a critical
performance path.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
