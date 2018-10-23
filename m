Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F12C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D758207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D758207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeJWUFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:05:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:55714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbeJWUFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:05:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01F47AF01;
        Tue, 23 Oct 2018 11:42:46 +0000 (UTC)
Date:   Tue, 23 Oct 2018 13:42:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] memcg: do not report racy no-eligible OOM tasks
Message-ID: <20181023114246.GR18839@dhcp22.suse.cz>
References: <f9a8079f-55b0-301e-9b3d-a5250bd7d277@i-love.sakura.ne.jp>
 <20181022120308.GB18839@dhcp22.suse.cz>
 <201810230101.w9N118i3042448@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810230101.w9N118i3042448@www262.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-10-18 10:01:08, Tetsuo Handa wrote:
> Michal Hocko wrote:
> > On Mon 22-10-18 20:45:17, Tetsuo Handa wrote:
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index e79cb59552d9..a9dfed29967b 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -1380,10 +1380,22 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > > >  		.gfp_mask = gfp_mask,
> > > >  		.order = order,
> > > >  	};
> > > > -	bool ret;
> > > > +	bool ret = true;
> > > >  
> > > >  	mutex_lock(&oom_lock);
> > > > +
> > > > +	/*
> > > > +	 * multi-threaded tasks might race with oom_reaper and gain
> > > > +	 * MMF_OOM_SKIP before reaching out_of_memory which can lead
> > > > +	 * to out_of_memory failure if the task is the last one in
> > > > +	 * memcg which would be a false possitive failure reported
> > > > +	 */
> > > > +	if (tsk_is_oom_victim(current))
> > > > +		goto unlock;
> > > > +
> > > 
> > > This is not wrong but is strange. We can use mutex_lock_killable(&oom_lock)
> > > so that any killed threads no longer wait for oom_lock.
> > 
> > tsk_is_oom_victim is stronger because it doesn't depend on
> > fatal_signal_pending which might be cleared throughout the exit process.
> > 
> 
> I still want to propose this. No need to be memcg OOM specific.

Well, I maintain what I've said [1] about simplicity and specific fix
for a specific issue. Especially in the tricky code like this where all
the consequences are far more subtle than they seem to be.

This is obviously a matter of taste but I don't see much point discussing
this back and forth for ever. Unless there is a general agreement that
the above is less appropriate then I am willing to consider a different
change but I simply do not have energy to nit pick for ever.

[1] http://lkml.kernel.org/r/20181022134315.GF18839@dhcp22.suse.cz
-- 
Michal Hocko
SUSE Labs
