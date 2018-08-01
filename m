Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C267C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2608C208B0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="isajhvXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2608C208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390560AbeHATcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:32:09 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42943 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389951AbeHATcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:32:08 -0400
Received: by mail-qt0-f193.google.com with SMTP id z8-v6so20821330qto.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tEL9IwiuuNHcEfw7I+59d25RLfFPQ9mHGxhbc8p2Ko4=;
        b=isajhvXrGQCJfVfj0vDORkixO0BfJW4iBeg8XblkXS/7N7RaQCZEgsIM/Lvk2W4gbd
         2sRnvB9sq8JamTWwanU5M0z8Br1MsADsAqp0q1EDciBkTLA/fBqv5/MvI2w/wmGRgFQo
         WJxzjPyJy62oIA23gydhNIZKFvFb5beCSH65OtLaYgTUTeqYXFFD0tR+euFu16zv2yNs
         wFXKe5NiYtvHfu8R67Trh91N7lpTpWZ1SEt6AETEBk1TUSE1CFmbK5elpIlFQNm98GGW
         i1M3ANf0wf/CqubswqEzLBsBJ03Oi73esCLbodZ+9By9tLcm9bPrZyu+n4eTMGlbno2l
         vmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tEL9IwiuuNHcEfw7I+59d25RLfFPQ9mHGxhbc8p2Ko4=;
        b=ScUbj8yPTUFySToVl4qw42u5xs1aOW9vWOW8querO4/Ume3ZLx6MffAuzIpZ2Q5/hZ
         iMvANQsBtbiZ8rTHGDS3yqofQNQ2tPg2d58w7qJqEDdBJh3qQBU7tS2ibDuBPQgZI88P
         mlIXxhAVEnya+CwuF3P+NtOw/CRwvnSKL6/5vIC8icuipvBJPrQkGDnV1ch/OZ4Uu25y
         NQvFDn4e2XK6IPO+m+z6WccR38wPjOjoSiKAwoBFcj6bsCB8EKY316SayN2WG/DczKzo
         JUBlJ6z4zyfrKRUDPIO27LMifQS+z8ikjIv54DrKhquuAsuf1hFxhHXZ5RwQwuACWTJK
         f2HA==
X-Gm-Message-State: AOUpUlE2mix1kOjqW7zheRD5RmCnnqh/x+2zF+y/dUmU68wCyn8fKCi/
        ERpqhWf1KNYijBFaTYsicJeTFg==
X-Google-Smtp-Source: AAOMgpeLyfgM7OA+tXypG/aclvSbpd4qs7SOaeL1krD1RLUcNdB2uxZoGLj6Xx75h5RlXH3cPCD9eg==
X-Received: by 2002:a0c:9547:: with SMTP id m7-v6mr23876583qvm.138.1533145520084;
        Wed, 01 Aug 2018 10:45:20 -0700 (PDT)
Received: from localhost (216.49.36.201.res-cmts.bus.ptd.net. [216.49.36.201])
        by smtp.gmail.com with ESMTPSA id b83-v6sm12524909qkc.20.2018.08.01.10.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 10:45:19 -0700 (PDT)
Date:   Wed, 1 Aug 2018 13:48:14 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm, oom: introduce memory.oom.group
Message-ID: <20180801174814.GC11386@cmpxchg.org>
References: <20180730180100.25079-1-guro@fb.com>
 <20180730180100.25079-4-guro@fb.com>
 <20180731090700.GF4557@dhcp22.suse.cz>
 <20180801011447.GB25953@castle.DHCP.thefacebook.com>
 <20180801055503.GB16767@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801055503.GB16767@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 07:55:03AM +0200, Michal Hocko wrote:
> On Tue 31-07-18 18:14:48, Roman Gushchin wrote:
> > On Tue, Jul 31, 2018 at 11:07:00AM +0200, Michal Hocko wrote:
> > > On Mon 30-07-18 11:01:00, Roman Gushchin wrote:
> > > > +struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
> > > > +					    struct mem_cgroup *oom_domain)
> > > > +{
> > > > +	struct mem_cgroup *oom_group = NULL;
> > > > +	struct mem_cgroup *memcg;
> > > > +
> > > > +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > > > +		return NULL;
> > > > +
> > > > +	if (!oom_domain)
> > > > +		oom_domain = root_mem_cgroup;
> > > > +
> > > > +	rcu_read_lock();
> > > > +
> > > > +	memcg = mem_cgroup_from_task(victim);
> > > > +	if (!memcg || memcg == root_mem_cgroup)
> > > > +		goto out;
> > > 
> > > When can we have memcg == NULL? victim should be always non-NULL.
> > > Also why do you need to special case the root_mem_cgroup here. The loop
> > > below should handle that just fine no?
> > 
> > Idk, I prefer to keep an explicit root_mem_cgroup check,
> > rather than traversing the tree and relying on an inability
> > to set oom_group on the root.
> 
> I will not insist but this just makes the code harder to read.

Just FYI, I'd prefer the explicit check. The loop would do the right
thing, but it's a little too implicit and subtle for my taste...
