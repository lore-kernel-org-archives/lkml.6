Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ACEC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174EE20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174EE20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeLJNNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:13:21 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53674 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbeLJNNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:13:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1561E15AB;
        Mon, 10 Dec 2018 05:13:20 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A3DC3F575;
        Mon, 10 Dec 2018 05:13:19 -0800 (PST)
Date:   Mon, 10 Dec 2018 14:13:17 +0100
From:   Christoffer Dall <christoffer.dall@arm.com>
To:     peng.hao2@zte.com.cn
Cc:     drjones@redhat.com, marc.zyngier@arm.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm/arm: return 0 when the number of objects is not
 lessthan min
Message-ID: <20181210131317.GP30263@e113682-lin.lund.arm.com>
References: <20181205083236.5tzhnxfhi4h4nknn@kamzik.brq.redhat.com>
 <201812060956304771332@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201812060956304771332@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 09:56:30AM +0800, peng.hao2@zte.com.cn wrote:
> >On Wed, Dec 05, 2018 at 09:15:51AM +0800, Peng Hao wrote:
> >> Return 0 when there is enough kvm_mmu_memory_cache object.
> >>
> >> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> >> ---
> >>  virt/kvm/arm/mmu.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> >> index ed162a6..fcda0ce 100644
> >> --- a/virt/kvm/arm/mmu.c
> >> +++ b/virt/kvm/arm/mmu.c
> >> @@ -127,7 +127,7 @@ static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
> >>      while (cache->nobjs < max) {
> >>          page = (void *)__get_free_page(PGALLOC_GFP);
> >>          if (!page)
> >> -            return -ENOMEM;
> >> +            return cache->nobjs >= min ? 0 : -ENOMEM;
> >
> >This condition will never be true here, as the exact same condition is
> >already checked above, and if it had been true, then we wouldn't be here.
> >
> >What problem are you attempting to solve?
> >
> if (cache->nobjs >= min)                      ------here cache->nobjs<min,it can continue downward 
>      return 0;
> while (cache->nobjs < max) {
>     page = (void *)__get_free_page(PGALLOC_GFP);
>     if (!page)
>        return -ENOMEM;                         -----here it is possible that  (cache->nobjs >= min) and (cache->nobjs<max)
>     cache->objects[cache->nobjs++] = page; ---here cache->nobjs increasing
>   }
> 
> I just think the logic of this function is to return 0 as long as (cache->nobjs >= min).
> thanks.

That's not the intention, nor is it on any of the other architectures
implementing the same thing (this one goes on the list of stuff we
should be sharing between architectures).

The idea is that you fill up the cache when it goes below min, and you
are always able to fill up to max.

If you're not able to fill up to max, then your system is seriously low
on memory and continuing to run this VM is not likely to be a good idea,
so you might as well tell user space to do something now instead of
waiting until the situation is even worse.


Thanks,

    Christoffer
