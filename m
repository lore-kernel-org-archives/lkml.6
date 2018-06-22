Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029A2C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC5E23BF7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC5E23BF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934130AbeFVBRa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:17:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933129AbeFVBR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:17:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B0468182D1F;
        Fri, 22 Jun 2018 01:17:28 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 48AC5111DD1D;
        Fri, 22 Jun 2018 01:17:25 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5M1HPtD016689;
        Thu, 21 Jun 2018 21:17:25 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5M1HOeB016685;
        Thu, 21 Jun 2018 21:17:25 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 21 Jun 2018 21:17:24 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     jing xia <jing.xia.mail@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
In-Reply-To: <20180619104312.GD13685@dhcp22.suse.cz>
Message-ID: <alpine.LRH.2.02.1806191228110.25656@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1806131001250.15845@file01.intranet.prod.int.rdu2.redhat.com> <CAN=25QMQiJ7wvfvYvmZnEnrkeb-SA7_hPj+N2RnO8y-aVO8wOQ@mail.gmail.com> <20180614073153.GB9371@dhcp22.suse.cz> <alpine.LRH.2.02.1806141424510.30404@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615073201.GB24039@dhcp22.suse.cz> <alpine.LRH.2.02.1806150724260.15022@file01.intranet.prod.int.rdu2.redhat.com> <20180615115547.GH24039@dhcp22.suse.cz> <alpine.LRH.2.02.1806150832100.26650@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615130925.GI24039@dhcp22.suse.cz> <alpine.LRH.2.02.1806181003560.4201@file01.intranet.prod.int.rdu2.redhat.com> <20180619104312.GD13685@dhcp22.suse.cz>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 22 Jun 2018 01:17:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 22 Jun 2018 01:17:28 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Jun 2018, Michal Hocko wrote:

> On Mon 18-06-18 18:11:26, Mikulas Patocka wrote:
> [...]
> > I grepped the kernel for __GFP_NORETRY and triaged them. I found 16 cases 
> > without a fallback - those are bugs that make various functions randomly 
> > return -ENOMEM.
> 
> Well, maybe those are just optimistic attempts to allocate memory and
> have a fallback somewhere else. So I would be careful calling them
> outright bugs. But maybe you are right.

I was trying to find the fallback code when I triaged them and maked as 
"BUG" those cases where I didn't find it. You can search harder and 
perhaps you'll find something that I didn't.

> > Most of the callers provide callback.
> > 
> > There is another strange flag - __GFP_RETRY_MAYFAIL - it provides two 
> > different functions - if the allocation is larger than 
> > PAGE_ALLOC_COSTLY_ORDER, it retries the allocation as if it were smaller. 
> > If the allocations is smaller than PAGE_ALLOC_COSTLY_ORDER, 
> > __GFP_RETRY_MAYFAIL will avoid the oom killer (larger order allocations 
> > don't trigger the oom killer at all).
> 
> Well, the primary purpose of this flag is to provide a consistent
> failure behavior for all requests regardless of the size.
> 
> > So, perhaps __GFP_RETRY_MAYFAIL could be used instead of __GFP_NORETRY in 
> > the cases where the caller wants to avoid trigerring the oom killer (the 
> > problem is that __GFP_NORETRY causes random failure even in no-oom 
> > situations but __GFP_RETRY_MAYFAIL doesn't).
> 
> myabe yes.
> 
> > So my suggestion is - fix these obvious bugs when someone allocates memory 
> > with __GFP_NORETRY without any fallback - and then, __GFP_NORETRY could be 
> > just changed to return NULL instead of sleeping.
> 
> No real objection to fixing wrong __GFP_NORETRY usage. But __GFP_NORETRY
> can sleep. Nothing will really change in that regards.  It does a
> reclaim and that _might_ sleep.
> 
> But seriously, isn't the best way around the throttling issue to use
> PF_LESS_THROTTLE?

Yes - it could be done by setting PF_LESS_THROTTLE. But I think it would 
be better to change it just in one place than to add PF_LESS_THROTTLE to 
every block device driver (because adding it to every block driver results 
in more code).

What about this patch? If __GFP_NORETRY and __GFP_FS is not set (i.e. the 
request comes from a block device driver or a filesystem), we should not 
sleep.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -2674,6 +2674,7 @@ static bool shrink_node(pg_data_t *pgdat
 		 * the LRU too quickly.
 		 */
 		if (!sc->hibernation_mode && !current_is_kswapd() &&
+		   (sc->gfp_mask & (__GFP_NORETRY | __GFP_FS)) != __GFP_NORETRY &&
 		   current_may_throttle() && pgdat_memcg_congested(pgdat, root))
 			wait_iff_congested(BLK_RW_ASYNC, HZ/10);
 
