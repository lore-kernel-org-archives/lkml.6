Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50370C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B37321501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B37321501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbeHBOFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:05:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:45824 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728797AbeHBOFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:05:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27363ACD7;
        Thu,  2 Aug 2018 12:14:48 +0000 (UTC)
Date:   Thu, 2 Aug 2018 14:14:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm, oom: introduce memory.oom.group
Message-ID: <20180802121446.GK10808@dhcp22.suse.cz>
References: <20180802003201.817-1-guro@fb.com>
 <20180802003201.817-4-guro@fb.com>
 <879f1767-8b15-4e83-d9ef-d8df0e8b4d83@i-love.sakura.ne.jp>
 <20180802112114.GG10808@dhcp22.suse.cz>
 <712a319f-c9da-230a-f2cb-af980daff704@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <712a319f-c9da-230a-f2cb-af980daff704@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-08-18 20:53:14, Tetsuo Handa wrote:
> On 2018/08/02 20:21, Michal Hocko wrote:
> > On Thu 02-08-18 19:53:13, Tetsuo Handa wrote:
> >> On 2018/08/02 9:32, Roman Gushchin wrote:
> > [...]
> >>> +struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
> >>> +					    struct mem_cgroup *oom_domain)
> >>> +{
> >>> +	struct mem_cgroup *oom_group = NULL;
> >>> +	struct mem_cgroup *memcg;
> >>> +
> >>> +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> >>> +		return NULL;
> >>> +
> >>> +	if (!oom_domain)
> >>> +		oom_domain = root_mem_cgroup;
> >>> +
> >>> +	rcu_read_lock();
> >>> +
> >>> +	memcg = mem_cgroup_from_task(victim);
> >>
> >> Isn't this racy? I guess that memcg of this "victim" can change to
> >> somewhere else from the one as of determining the final candidate.
> > 
> > How is this any different from the existing code? We select a victim and
> > then kill it. The victim might move away and won't be part of the oom
> > memcg anymore but we will still kill it. I do not remember this ever
> > being a problem. Migration is a privileged operation. If you loose this
> > restriction you shouldn't allow to move outside of the oom domain.
> 
> The existing code kills one process (plus other processes sharing mm if any).
> But oom_cgroup kills multiple processes. Thus, whether we made decision based
> on correct memcg becomes important.

Yes but a proper configuration should already mitigate the harm because
you shouldn't be able to migrate the task outside of the oom domain.
	A (oom.group = 1)
       / \
      B   C

moving task between B and C should be harmless while moving it out of A
subtree completely is a dubious configuration.

> >> This "victim" might have already passed exit_mm()/cgroup_exit() from do_exit().
> > 
> > Why does this matter? The victim hasn't been killed yet so if it exists
> > by its own I do not think we really have to tear the whole cgroup down.
> 
> The existing code does not send SIGKILL if find_lock_task_mm() failed. Who can
> guarantee that the victim is not inside do_exit() yet when this code is executed?

I do not follow. Why does this matter at all?

-- 
Michal Hocko
SUSE Labs
