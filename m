Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76565C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315082083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315082083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966136AbeFSKnR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:43:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:54195 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965187AbeFSKnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:43:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9E609ABF4;
        Tue, 19 Jun 2018 10:43:12 +0000 (UTC)
Date:   Tue, 19 Jun 2018 12:43:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     jing xia <jing.xia.mail@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
Message-ID: <20180619104312.GD13685@dhcp22.suse.cz>
References: <alpine.LRH.2.02.1806131001250.15845@file01.intranet.prod.int.rdu2.redhat.com>
 <CAN=25QMQiJ7wvfvYvmZnEnrkeb-SA7_hPj+N2RnO8y-aVO8wOQ@mail.gmail.com>
 <20180614073153.GB9371@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806141424510.30404@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615073201.GB24039@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806150724260.15022@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615115547.GH24039@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806150832100.26650@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615130925.GI24039@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806181003560.4201@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1806181003560.4201@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18-06-18 18:11:26, Mikulas Patocka wrote:
[...]
> I grepped the kernel for __GFP_NORETRY and triaged them. I found 16 cases 
> without a fallback - those are bugs that make various functions randomly 
> return -ENOMEM.

Well, maybe those are just optimistic attempts to allocate memory and
have a fallback somewhere else. So I would be careful calling them
outright bugs. But maybe you are right.

> Most of the callers provide callback.
> 
> There is another strange flag - __GFP_RETRY_MAYFAIL - it provides two 
> different functions - if the allocation is larger than 
> PAGE_ALLOC_COSTLY_ORDER, it retries the allocation as if it were smaller. 
> If the allocations is smaller than PAGE_ALLOC_COSTLY_ORDER, 
> __GFP_RETRY_MAYFAIL will avoid the oom killer (larger order allocations 
> don't trigger the oom killer at all).

Well, the primary purpose of this flag is to provide a consistent
failure behavior for all requests regardless of the size.

> So, perhaps __GFP_RETRY_MAYFAIL could be used instead of __GFP_NORETRY in 
> the cases where the caller wants to avoid trigerring the oom killer (the 
> problem is that __GFP_NORETRY causes random failure even in no-oom 
> situations but __GFP_RETRY_MAYFAIL doesn't).

myabe yes.

> So my suggestion is - fix these obvious bugs when someone allocates memory 
> with __GFP_NORETRY without any fallback - and then, __GFP_NORETRY could be 
> just changed to return NULL instead of sleeping.

No real objection to fixing wrong __GFP_NORETRY usage. But __GFP_NORETRY
can sleep. Nothing will really change in that regards.  It does a
reclaim and that _might_ sleep.

But seriously, isn't the best way around the throttling issue to use
PF_LESS_THROTTLE?
-- 
Michal Hocko
SUSE Labs
