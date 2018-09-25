Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7A7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B1A2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B1A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeIZBHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:07:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:44042 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726864AbeIZBHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:07:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5AC7DAA7C;
        Tue, 25 Sep 2018 18:58:47 +0000 (UTC)
Date:   Tue, 25 Sep 2018 20:58:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH RESEND] mm: don't raise MEMCG_OOM event due to failed
 high-order allocation
Message-ID: <20180925185845.GX18685@dhcp22.suse.cz>
References: <20180917230846.31027-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917230846.31027-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-09-18 23:10:59, Roman Gushchin wrote:
> The memcg OOM killer is never invoked due to a failed high-order
> allocation, however the MEMCG_OOM event can be raised.
> 
> As shown below, it can happen under conditions, which are very
> far from a real OOM: e.g. there is plenty of clean pagecache
> and low memory pressure.
> 
> There is no sense in raising an OOM event in such a case,
> as it might confuse a user and lead to wrong and excessive actions.
> 
> Let's look at the charging path in try_caharge(). If the memory usage
> is about memory.max, which is absolutely natural for most memory cgroups,
> we try to reclaim some pages. Even if we were able to reclaim
> enough memory for the allocation, the following check can fail due to
> a race with another concurrent allocation:
> 
>     if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
>         goto retry;
> 
> For regular pages the following condition will save us from triggering
> the OOM:
> 
>    if (nr_reclaimed && nr_pages <= (1 << PAGE_ALLOC_COSTLY_ORDER))
>        goto retry;
> 
> But for high-order allocation this condition will intentionally fail.
> The reason behind is that we'll likely fall to regular pages anyway,
> so it's ok and even preferred to return ENOMEM.
> 
> In this case the idea of raising MEMCG_OOM looks dubious.

I would really appreciate an example of application that would get
confused by consuming this event and an explanation why. I do agree that
the event itself is kinda weird because it doesn't give you any context
for what kind of requests the memcg is OOM. Costly orders are a little
different story than others and users shouldn't care about this because
this is a mere implementation detail.

In other words, do we have any users to actually care about this half
baked event at all? Shouldn't we simply stop emiting it (or make it an
alias of OOM_KILL) rather than making it slightly better but yet kinda
incomplete?

Jeez, we really suck at defining proper interfaces. Things seem so cool
when they are proposed, then those users come and ruin our lives...
-- 
Michal Hocko
SUSE Labs
