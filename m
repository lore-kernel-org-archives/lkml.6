Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC070C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877E821019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548241379;
	bh=PesCvQTrDqaBWdn8TFOXrB3onMgWCLdv89/6JzFw3yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PEXvaCAvo3hrAkcrjFegO/0i3Kv6xKHNC+OFvYQouI5AEQ1E5xVMYkhVB672INreE
	 cMsGLUZgCEjVD9u4A6c0xsBV5hkDyNGbCaAbzXT5gxDduV9S4USu1NymDi/yhWHUj2
	 ufFos5nuoaft9Dnmly8mSOu+AaQthNushSN66G3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfAWLC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:02:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:54828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726322AbfAWLC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:02:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9040FB0C1;
        Wed, 23 Jan 2019 11:02:56 +0000 (UTC)
Date:   Wed, 23 Jan 2019 12:02:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: vmscan: do not iterate all mem cgroups for
 global direct reclaim
Message-ID: <20190123110254.GU4087@dhcp22.suse.cz>
References: <1548187782-108454-1-git-send-email-yang.shi@linux.alibaba.com>
 <fa1d9a1f-99c8-a4ae-da7f-ed90336497e9@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa1d9a1f-99c8-a4ae-da7f-ed90336497e9@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-01-19 13:28:03, Kirill Tkhai wrote:
> On 22.01.2019 23:09, Yang Shi wrote:
> > In current implementation, both kswapd and direct reclaim has to iterate
> > all mem cgroups.  It is not a problem before offline mem cgroups could
> > be iterated.  But, currently with iterating offline mem cgroups, it
> > could be very time consuming.  In our workloads, we saw over 400K mem
> > cgroups accumulated in some cases, only a few hundred are online memcgs.
> > Although kswapd could help out to reduce the number of memcgs, direct
> > reclaim still get hit with iterating a number of offline memcgs in some
> > cases.  We experienced the responsiveness problems due to this
> > occassionally.
> > 
> > Here just break the iteration once it reclaims enough pages as what
> > memcg direct reclaim does.  This may hurt the fairness among memcgs
> > since direct reclaim may awlays do reclaim from same memcgs.  But, it
> > sounds ok since direct reclaim just tries to reclaim SWAP_CLUSTER_MAX
> > pages and memcgs can be protected by min/low.
> 
> In case of we stop after SWAP_CLUSTER_MAX pages are reclaimed; it's possible
> the following situation. Memcgs, which are closest to root_mem_cgroup, will
> become empty, and you will have to iterate over empty memcg hierarchy long time,
> just to find a not empty memcg.
> 
> I'd suggest, we should not lose fairness. We may introduce
> mem_cgroup::last_reclaim_child parameter to save a child
> (or its id), where the last reclaim was interrupted. Then
> next reclaim should start from this child:

Why is not our reclaim_cookie based caching sufficient?

-- 
Michal Hocko
SUSE Labs
