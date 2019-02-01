Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77216C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE2F2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549012483;
	bh=8vYFjOBIW9qgm0zB57zofj/quMeItLeICS94XcMp+xY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sWGG+lmbaaWRff7K2tsuItSIWQX2MsDV5T09xyvA/khkYXbIOyz041/7BnROD72r6
	 Asky6jrBDRKPWffOI9w32q9YUUo/yzcgW/iBkRKedDkzfnumRSCT5LnkFOPMXvG3k7
	 UFLI+Hi1UKHidVIJ80D0m14vI0zhgHSfJwnQBWXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfBAJOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:14:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:48348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727323AbfBAJOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:14:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3F348AE58;
        Fri,  1 Feb 2019 09:14:35 +0000 (UTC)
Date:   Fri, 1 Feb 2019 10:14:33 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Yong-Taek Lee <ytk.lee@samsung.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm, oom: Tolerate processes sharing mm with different
 view of oom_score_adj.
Message-ID: <20190201091433.GH11599@dhcp22.suse.cz>
References: <1547636121-9229-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190116110937.GI24149@dhcp22.suse.cz>
 <88e10029-f3d9-5bb5-be46-a3547c54de28@I-love.SAKURA.ne.jp>
 <20190116121915.GJ24149@dhcp22.suse.cz>
 <6118fa8a-7344-b4b2-36ce-d77d495fba69@i-love.sakura.ne.jp>
 <20190116134131.GP24149@dhcp22.suse.cz>
 <20190117155159.GA4087@dhcp22.suse.cz>
 <edad66e0-1947-eb42-f4db-7f826d3157d7@i-love.sakura.ne.jp>
 <20190131071130.GM18811@dhcp22.suse.cz>
 <5fd73d87-3e4b-f793-1976-b937955663e3@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fd73d87-3e4b-f793-1976-b937955663e3@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-02-19 05:59:55, Tetsuo Handa wrote:
> On 2019/01/31 16:11, Michal Hocko wrote:
> > On Thu 31-01-19 07:49:35, Tetsuo Handa wrote:
> >> This patch reverts both commit 44a70adec910d692 ("mm, oom_adj: make sure
> >> processes sharing mm have same view of oom_score_adj") and commit
> >> 97fd49c2355ffded ("mm, oom: kill all tasks sharing the mm") in order to
> >> close a race and reduce the latency at __set_oom_adj(), and reduces the
> >> warning at __oom_kill_process() in order to minimize the latency.
> >>
> >> Commit 36324a990cf578b5 ("oom: clear TIF_MEMDIE after oom_reaper managed
> >> to unmap the address space") introduced the worst case mentioned in
> >> 44a70adec910d692. But since the OOM killer skips mm with MMF_OOM_SKIP set,
> >> only administrators can trigger the worst case.
> >>
> >> Since 44a70adec910d692 did not take latency into account, we can "hold RCU
> >> for minutes and trigger RCU stall warnings" by calling printk() on many
> >> thousands of thread groups. Also, current code becomes a DoS attack vector
> >> which will allow "stalling for more than one month in unkillable state"
> >> simply printk()ing same messages when many thousands of thread groups
> >> tried to iterate __set_oom_adj() on each other.
> >>
> >> I also noticed that 44a70adec910d692 is racy [1], and trying to fix the
> >> race will require a global lock which is too costly for rare events. And
> >> Michal Hocko is thinking to change the oom_score_adj implementation to per
> >> mm_struct (with shadowed score stored in per task_struct in order to
> >> support vfork() => __set_oom_adj() => execve() sequence) so that we don't
> >> need the global lock.
> >>
> >> If the worst case in 44a70adec910d692 happened, it is an administrator's
> >> request. Therefore, before changing the oom_score_adj implementation,
> >> let's eliminate the DoS attack vector first.
> > 
> > This is really ridiculous. I have already nacked the previous version
> > and provided two ways around. The simplest one is to drop the printk.
> > The second one is to move oom_score_adj to the mm struct. Could you
> > explain why do you still push for this?
> 
> Dropping printk() does not close the race.

But it does remove the source of a long operation from the RCU context.
If you are not willing to post such a trivial patch I will do so.

> You must propose an alternative patch if you dislike this patch.

I will eventually get there.
-- 
Michal Hocko
SUSE Labs
