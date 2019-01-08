Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7F0C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB2E20700
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546935286;
	bh=GZ73D1ulmTTu4wsOuaUE+0Dcp326dIR1rI3GjyiKpcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dll1yWRxslxHrjcRPg26ynOc6W7zDL9HD8+1NJKmHfunc27+KdmJwsGe/017QGixs
	 jL1wi+ml3eGlvTes36qgybepQHT0sz+pkoQLVMYdxhkaK06Yogdj+N1Xuq2dIbX5CW
	 VkFjaqENQ36Ln4n7aHSg9xAb5I7mmPh+3mX8Scvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfAHIOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:14:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:41822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727689AbfAHIOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:14:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9EA20AE3C;
        Tue,  8 Jan 2019 08:14:42 +0000 (UTC)
Date:   Tue, 8 Jan 2019 09:14:41 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] memcg: do not report racy no-eligible OOM tasks
Message-ID: <20190108081441.GO31793@dhcp22.suse.cz>
References: <20190107143802.16847-1-mhocko@kernel.org>
 <20190107143802.16847-3-mhocko@kernel.org>
 <fa8892d1-4a38-dccd-9597-923924aa0a66@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa8892d1-4a38-dccd-9597-923924aa0a66@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-01-19 05:59:49, Tetsuo Handa wrote:
> On 2019/01/07 23:38, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > Tetsuo has reported [1] that a single process group memcg might easily
> > swamp the log with no-eligible oom victim reports due to race between
> > the memcg charge and oom_reaper
> 
> This explanation is outdated. I reported that one memcg OOM killer can
> kill all processes in that memcg. I expect the changelog to be updated.

I am open to refinements. Any specific wording you have in mind?

> > 
> > Thread 1		Thread2				oom_reaper
> > try_charge		try_charge
> > 			  mem_cgroup_out_of_memory
> > 			    mutex_lock(oom_lock)
> >   mem_cgroup_out_of_memory
> >     mutex_lock(oom_lock)
> > 			      out_of_memory
> > 			        select_bad_process
> > 				oom_kill_process(current)
> > 				  wake_oom_reaper
> > 							  oom_reap_task
> > 							  MMF_OOM_SKIP->victim
> > 			    mutex_unlock(oom_lock)
> >     out_of_memory
> >       select_bad_process # no task
> > 
> > If Thread1 didn't race it would bail out from try_charge and force the
> > charge. We can achieve the same by checking tsk_is_oom_victim inside
> > the oom_lock and therefore close the race.
> > 
> > [1] http://lkml.kernel.org/r/bb2074c0-34fe-8c2c-1c7d-db71338f1e7f@i-love.sakura.ne.jp
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  mm/memcontrol.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index af7f18b32389..90eb2e2093e7 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1387,10 +1387,22 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >  		.gfp_mask = gfp_mask,
> >  		.order = order,
> >  	};
> > -	bool ret;
> > +	bool ret = true;
> >  
> >  	mutex_lock(&oom_lock);
> 
> And because of "[PATCH 1/2] mm, oom: marks all killed tasks as oom
> victims", mark_oom_victim() will be called on current thread even if
> we used mutex_lock_killable(&oom_lock) here, like you said
> 
>   mutex_lock_killable would take care of exiting task already. I would
>   then still prefer to check for mark_oom_victim because that is not racy
>   with the exit path clearing signals. I can update my patch to use
>   _killable lock variant if we are really going with the memcg specific
>   fix.
> 
> . If current thread is not yet killed by the OOM killer but can terminate
> without invoking the OOM killer, using mutex_lock_killable(&oom_lock) here
> saves some processes. What is the race you are referring by "racy with the
> exit path clearing signals" ?

This is unrelated to the patch.
 
> > +
> > +	/*
> > +	 * multi-threaded tasks might race with oom_reaper and gain
> > +	 * MMF_OOM_SKIP before reaching out_of_memory which can lead
> > +	 * to out_of_memory failure if the task is the last one in
> > +	 * memcg which would be a false possitive failure reported
> > +	 */
> 
> Not only out_of_memory() failure. Current thread needlessly tries to
> select next OOM victim. out_of_memory() failure is nothing but a result
> of no eligible candidate case.

So?

Let me ask again. Does this solve the issue you are seeing? I really do
not want to end in nit picking endless thread again and would like to
move on.

> > +	if (tsk_is_oom_victim(current))
> > +		goto unlock;
> > +
> >  	ret = out_of_memory(&oc);
> > +
> > +unlock:
> >  	mutex_unlock(&oom_lock);
> >  	return ret;
> >  }
> > 

-- 
Michal Hocko
SUSE Labs
