Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CEEC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500982087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546948003;
	bh=xmR8WpyPhxG9uusctUHR3nYbgDAH3psziXW5uUOhrtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ndGgSlr+APZRcVHLhGCOFMB9gk/y3V2NUXVDMTUk5Y44v/o6ynNYm6Jd1+ORFPSMK
	 AFm5FJCaggj2h1KNTIbr0dLyOPPhml/EjZdz+tzK2WovQEHr+UwH1zh6p+QW/CkImO
	 PEbuDkrZn/iMIpqOcTdwkqOr1RUAXTQlsDaPRW+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfAHLqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:46:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:38238 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727236AbfAHLql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:46:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5437AF21;
        Tue,  8 Jan 2019 11:46:40 +0000 (UTC)
Date:   Tue, 8 Jan 2019 12:46:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] memcg: do not report racy no-eligible OOM tasks
Message-ID: <20190108114639.GR31793@dhcp22.suse.cz>
References: <20190107143802.16847-1-mhocko@kernel.org>
 <20190107143802.16847-3-mhocko@kernel.org>
 <fa8892d1-4a38-dccd-9597-923924aa0a66@i-love.sakura.ne.jp>
 <20190108081441.GO31793@dhcp22.suse.cz>
 <3b105bba-3542-1d00-c6e2-52f6d125eff2@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b105bba-3542-1d00-c6e2-52f6d125eff2@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-01-19 19:39:58, Tetsuo Handa wrote:
> On 2019/01/08 17:14, Michal Hocko wrote:
> >>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >>> index af7f18b32389..90eb2e2093e7 100644
> >>> --- a/mm/memcontrol.c
> >>> +++ b/mm/memcontrol.c
> >>> @@ -1387,10 +1387,22 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >>>  		.gfp_mask = gfp_mask,
> >>>  		.order = order,
> >>>  	};
> >>> -	bool ret;
> >>> +	bool ret = true;
> >>>  
> >>>  	mutex_lock(&oom_lock);
> >>
> >> And because of "[PATCH 1/2] mm, oom: marks all killed tasks as oom
> >> victims", mark_oom_victim() will be called on current thread even if
> >> we used mutex_lock_killable(&oom_lock) here, like you said
> >>
> >>   mutex_lock_killable would take care of exiting task already. I would
> >>   then still prefer to check for mark_oom_victim because that is not racy
> >>   with the exit path clearing signals. I can update my patch to use
> >>   _killable lock variant if we are really going with the memcg specific
> >>   fix.
> >>
> >> . If current thread is not yet killed by the OOM killer but can terminate
> >> without invoking the OOM killer, using mutex_lock_killable(&oom_lock) here
> >> saves some processes. What is the race you are referring by "racy with the
> >> exit path clearing signals" ?
> > 
> > This is unrelated to the patch.
> 
> Ultimately related! This is the reasoning why your patch should be preferred
> over my patch.

No! I've said I do not mind using mutex_lock_killable on top of this
patch. I just want to have this fix minimal.

-- 
Michal Hocko
SUSE Labs
