Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1795CC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B446F20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B446F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeJVUVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:21:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:34114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728186AbeJVUV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:21:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90BEAAFB6;
        Mon, 22 Oct 2018 12:03:11 +0000 (UTC)
Date:   Mon, 22 Oct 2018 14:03:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] memcg: do not report racy no-eligible OOM tasks
Message-ID: <20181022120308.GB18839@dhcp22.suse.cz>
References: <20181022071323.9550-1-mhocko@kernel.org>
 <20181022071323.9550-3-mhocko@kernel.org>
 <f9a8079f-55b0-301e-9b3d-a5250bd7d277@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9a8079f-55b0-301e-9b3d-a5250bd7d277@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-10-18 20:45:17, Tetsuo Handa wrote:
> On 2018/10/22 16:13, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > Tetsuo has reported [1] that a single process group memcg might easily
> > swamp the log with no-eligible oom victim reports due to race between
> > the memcg charge and oom_reaper
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
> > index e79cb59552d9..a9dfed29967b 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1380,10 +1380,22 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >  		.gfp_mask = gfp_mask,
> >  		.order = order,
> >  	};
> > -	bool ret;
> > +	bool ret = true;
> >  
> >  	mutex_lock(&oom_lock);
> > +
> > +	/*
> > +	 * multi-threaded tasks might race with oom_reaper and gain
> > +	 * MMF_OOM_SKIP before reaching out_of_memory which can lead
> > +	 * to out_of_memory failure if the task is the last one in
> > +	 * memcg which would be a false possitive failure reported
> > +	 */
> > +	if (tsk_is_oom_victim(current))
> > +		goto unlock;
> > +
> 
> This is not wrong but is strange. We can use mutex_lock_killable(&oom_lock)
> so that any killed threads no longer wait for oom_lock.

tsk_is_oom_victim is stronger because it doesn't depend on
fatal_signal_pending which might be cleared throughout the exit process.

> Also, closing this race for only memcg OOM path is strange. Global OOM path
> (which are CLONE_VM without CLONE_THREAD) is still suffering this race
> (though frequency is lower than memcg OOM due to use of mutex_trylock()). Either
> checking before calling out_of_memory() or checking task_will_free_mem(current)
> inside out_of_memory() will close this race for both paths.

The global case is much more complicated because we know that memcg
might bypass the charge so we do not have to care about the potential
endless loop like in page allocator path. Moreover I am not even sure
the race is all that interesting in the global case. I have never heard
about a pre-mature panic due to no killable task. The racing oom task
would have to be the last eligible process in the system and that is
quite unlikely. We can think about a more involved solution for that if
we ever hear about this to be a real problem.

So a simple memcg specific fix sounds like a reasonable way forward.
-- 
Michal Hocko
SUSE Labs
