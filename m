Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5442CC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B88C20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B88C20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbeGYLpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:45:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:41156 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728651AbeGYLpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:45:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 72949ACC3;
        Wed, 25 Jul 2018 10:34:16 +0000 (UTC)
Date:   Wed, 25 Jul 2018 12:34:16 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "zhaowuyun@wingtech.com" <zhaowuyun@wingtech.com>
Cc:     mgorman <mgorman@techsingularity.net>,
        akpm <akpm@linux-foundation.org>, minchan <minchan@kernel.org>,
        vinmenon <vinmenon@codeaurora.org>, hannes <hannes@cmpxchg.org>,
        "hillf.zj" <hillf.zj@alibaba-inc.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Re: [PATCH] [PATCH] mm: disable preemption before swapcache_free
Message-ID: <20180725103416.GZ28386@dhcp22.suse.cz>
References: <2018072514375722198958@wingtech.com>
 <20180725074009.GU28386@dhcp22.suse.cz>
 <2018072515575576668668@wingtech.com>
 <20180725082100.GV28386@dhcp22.suse.cz>
 <2018072517530727482074@wingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2018072517530727482074@wingtech.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-07-18 17:53:07, zhaowuyun@wingtech.com wrote:
> >[Please do not top post - thank you]
> >[CC Hugh - the original patch was http://lkml.kernel.org/r/2018072514375722198958@wingtech.com]
> >
> >On Wed 25-07-18 15:57:55, zhaowuyun@wingtech.com wrote:
> >> That is a BUG we found in mm/vmscan.c at KERNEL VERSION 4.9.82
> >
> >The code is quite similar in the current tree as well.
> >
> >> Sumary is TASK A (normal priority) doing __remove_mapping page preempted by TASK B (RT priority) doing __read_swap_cache_async,
> >> the TASK A preempted before swapcache_free, left SWAP_HAS_CACHE flag in the swap cache,
> >> the TASK B which doing __read_swap_cache_async, will not success at swapcache_prepare(entry) because the swap cache was exist, then it will loop forever because it is a RT thread...
> >> the spin lock unlocked before swapcache_free, so disable preemption until swapcache_free executed ...
> >
> >OK, I see your point now. I have missed the lock is dropped before
> >swapcache_free. How can preemption disabling prevent this race to happen
> >while the code is preempted by an IRQ?
> >--
> >Michal Hocko
> >SUSE Labs 
> 
> Hi Michal,
> 
> The action what processes __read_swap_cache_async is on the process context, so I think disable preemption is enough.

So what you are saying is that no IRQ or other non-process contexts will
not loop in __read_swap_cache_async so the live lock is not possible?
-- 
Michal Hocko
SUSE Labs
