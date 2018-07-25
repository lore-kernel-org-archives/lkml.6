Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999CBC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3CA2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3CA2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbeGYLnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:43:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:40044 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728651AbeGYLnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:43:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4948FAEB6;
        Wed, 25 Jul 2018 10:32:06 +0000 (UTC)
Date:   Wed, 25 Jul 2018 12:32:04 +0200
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
Message-ID: <20180725103204.GY28386@dhcp22.suse.cz>
References: <2018072514375722198958@wingtech.com>
 <20180725074009.GU28386@dhcp22.suse.cz>
 <2018072515575576668668@wingtech.com>
 <20180725082100.GV28386@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725082100.GV28386@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-07-18 10:21:00, Michal Hocko wrote:
> [Please do not top post - thank you]
> [CC Hugh - the original patch was http://lkml.kernel.org/r/2018072514375722198958@wingtech.com]

now for real

> On Wed 25-07-18 15:57:55, zhaowuyun@wingtech.com wrote:
> > That is a BUG we found in mm/vmscan.c at KERNEL VERSION 4.9.82
> 
> The code is quite similar in the current tree as well.
> 
> > Sumary is TASK A (normal priority) doing __remove_mapping page preempted by TASK B (RT priority) doing __read_swap_cache_async,
> > the TASK A preempted before swapcache_free, left SWAP_HAS_CACHE flag in the swap cache,
> > the TASK B which doing __read_swap_cache_async, will not success at swapcache_prepare(entry) because the swap cache was exist, then it will loop forever because it is a RT thread...
> > the spin lock unlocked before swapcache_free, so disable preemption until swapcache_free executed ...
> 
> OK, I see your point now. I have missed the lock is dropped before
> swapcache_free. How can preemption disabling prevent this race to happen
> while the code is preempted by an IRQ?

-- 
Michal Hocko
SUSE Labs
