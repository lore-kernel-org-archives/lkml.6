Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BD8C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B440214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B440214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbeHBNL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:11:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:55184 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728685AbeHBNL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:11:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7024EAD1B;
        Thu,  2 Aug 2018 11:21:15 +0000 (UTC)
Date:   Thu, 2 Aug 2018 13:21:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm, oom: introduce memory.oom.group
Message-ID: <20180802112114.GG10808@dhcp22.suse.cz>
References: <20180802003201.817-1-guro@fb.com>
 <20180802003201.817-4-guro@fb.com>
 <879f1767-8b15-4e83-d9ef-d8df0e8b4d83@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <879f1767-8b15-4e83-d9ef-d8df0e8b4d83@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-08-18 19:53:13, Tetsuo Handa wrote:
> On 2018/08/02 9:32, Roman Gushchin wrote:
[...]
> > +struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
> > +					    struct mem_cgroup *oom_domain)
> > +{
> > +	struct mem_cgroup *oom_group = NULL;
> > +	struct mem_cgroup *memcg;
> > +
> > +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > +		return NULL;
> > +
> > +	if (!oom_domain)
> > +		oom_domain = root_mem_cgroup;
> > +
> > +	rcu_read_lock();
> > +
> > +	memcg = mem_cgroup_from_task(victim);
> 
> Isn't this racy? I guess that memcg of this "victim" can change to
> somewhere else from the one as of determining the final candidate.

How is this any different from the existing code? We select a victim and
then kill it. The victim might move away and won't be part of the oom
memcg anymore but we will still kill it. I do not remember this ever
being a problem. Migration is a privileged operation. If you loose this
restriction you shouldn't allow to move outside of the oom domain.

> This "victim" might have already passed exit_mm()/cgroup_exit() from do_exit().

Why does this matter? The victim hasn't been killed yet so if it exists
by its own I do not think we really have to tear the whole cgroup down.

> This "victim" might be moving to a memcg which is different from the one
> determining the final candidate.
> 
> > +	if (memcg == root_mem_cgroup)
> > +		goto out;
> > +
> > +	/*
> > +	 * Traverse the memory cgroup hierarchy from the victim task's
> > +	 * cgroup up to the OOMing cgroup (or root) to find the
> > +	 * highest-level memory cgroup with oom.group set.
> > +	 */
> > +	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
> > +		if (memcg->oom_group)
> > +			oom_group = memcg;
> > +
> > +		if (memcg == oom_domain)
> > +			break;
> > +	}
> > +
> > +	if (oom_group)
> > +		css_get(&oom_group->css);
> > +out:
> > +	rcu_read_unlock();
> > +
> > +	return oom_group;
> > +}
> 
> 
> 
> > @@ -974,7 +988,23 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
> >  	}
> >  	read_unlock(&tasklist_lock);
> >  
> > +	/*
> > +	 * Do we need to kill the entire memory cgroup?
> > +	 * Or even one of the ancestor memory cgroups?
> > +	 * Check this out before killing the victim task.
> > +	 */
> > +	oom_group = mem_cgroup_get_oom_group(victim, oc->memcg);
> > +
> >  	__oom_kill_process(victim);
> > +
> > +	/*
> > +	 * If necessary, kill all tasks in the selected memory cgroup.
> > +	 */
> > +	if (oom_group) {
> 
> Isn't "killing a child process of the biggest memory hog" and "killing all
> processes which belongs to a memcg which the child process of the biggest
> memory hog belongs to" strange? The intent of selecting a child is to try
> to minimize lost work while the intent of oom_cgroup is to try to discard
> all work. If oom_cgroup is enabled, I feel that we should
> 
>   pr_err("%s: Kill all processes in ", message);
>   pr_cont_cgroup_path(memcg->css.cgroup);
>   pr_cont(" due to memory.oom.group set\n");
> 
> without
> 
>   pr_err("%s: Kill process %d (%s) score %u or sacrifice child\n", message, task_pid_nr(p), p->comm, points);
> 
> (I mean, don't try to select a child).

Well, the child can belong into a different memcg. Whether the heuristic
to pick up the child is sensible is another question and I do not think
it is related to this patchset. The code works as intended, albeit being
questionable.
-- 
Michal Hocko
SUSE Labs
