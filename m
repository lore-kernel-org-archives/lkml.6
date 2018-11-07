Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239BAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67F220827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67F220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbeKGThy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:37:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:54928 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbeKGThx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:37:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D879B6EC;
        Wed,  7 Nov 2018 10:08:13 +0000 (UTC)
Date:   Wed, 7 Nov 2018 11:08:10 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] memcg: do not report racy no-eligible OOM tasks
Message-ID: <20181107100810.GA27423@dhcp22.suse.cz>
References: <20181022071323.9550-1-mhocko@kernel.org>
 <20181022071323.9550-3-mhocko@kernel.org>
 <20181026142531.GA27370@cmpxchg.org>
 <20181026192551.GC18839@dhcp22.suse.cz>
 <20181026193304.GD18839@dhcp22.suse.cz>
 <dfafc626-2233-db9b-49fa-9d4bae16d4aa@i-love.sakura.ne.jp>
 <c38e352a-dd23-a5e4-ac50-75b557506479@i-love.sakura.ne.jp>
 <20181106124224.GM27423@dhcp22.suse.cz>
 <8725e3b3-3752-fa7f-a88f-5ff4f5b6eace@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8725e3b3-3752-fa7f-a88f-5ff4f5b6eace@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-11-18 18:45:27, Tetsuo Handa wrote:
> On 2018/11/06 21:42, Michal Hocko wrote:
> > On Tue 06-11-18 18:44:43, Tetsuo Handa wrote:
> > [...]
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> index 6e1469b..a97648a 100644
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -1382,8 +1382,13 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >>  	};
> >>  	bool ret;
> >>  
> >> -	mutex_lock(&oom_lock);
> >> -	ret = out_of_memory(&oc);
> >> +	if (mutex_lock_killable(&oom_lock))
> >> +		return true;
> >> +	/*
> >> +	 * A few threads which were not waiting at mutex_lock_killable() can
> >> +	 * fail to bail out. Therefore, check again after holding oom_lock.
> >> +	 */
> >> +	ret = fatal_signal_pending(current) || out_of_memory(&oc);
> >>  	mutex_unlock(&oom_lock);
> >>  	return ret;
> >>  }
> > 
> > If we are goging with a memcg specific thingy then I really prefer
> > tsk_is_oom_victim approach. Or is there any reason why this is not
> > suitable?
> > 
> 
> Why need to wait for mark_oom_victim() called after slow printk() messages?
> 
> If current thread got Ctrl-C and thus current thread can terminate, what is
> nice with waiting for the OOM killer? If there are several OOM events in
> multiple memcg domains waiting for completion of printk() messages? I don't
> see points with waiting for oom_lock, for try_charge() already allows current
> thread to terminate due to fatal_signal_pending() test.

mutex_lock_killable would take care of exiting task already. I would
then still prefer to check for mark_oom_victim because that is not racy
with the exit path clearing signals. I can update my patch to use
_killable lock variant if we are really going with the memcg specific
fix.

Johaness?

-- 
Michal Hocko
SUSE Labs
