Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8719C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B166E21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfAWUYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:24:55 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:39713 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726035AbfAWUYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:24:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TIsBfGx_1548275079;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TIsBfGx_1548275079)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Jan 2019 04:24:42 +0800
Subject: Re: [RFC PATCH] mm: vmscan: do not iterate all mem cgroups for global
 direct reclaim
To:     Michal Hocko <mhocko@kernel.org>
Cc:     hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1548187782-108454-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190123095926.GS4087@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <3684a63c-4c1d-fd1a-cda5-af92fb6bea8d@linux.alibaba.com>
Date:   Wed, 23 Jan 2019 12:24:38 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190123095926.GS4087@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/19 1:59 AM, Michal Hocko wrote:
> On Wed 23-01-19 04:09:42, Yang Shi wrote:
>> In current implementation, both kswapd and direct reclaim has to iterate
>> all mem cgroups.  It is not a problem before offline mem cgroups could
>> be iterated.  But, currently with iterating offline mem cgroups, it
>> could be very time consuming.  In our workloads, we saw over 400K mem
>> cgroups accumulated in some cases, only a few hundred are online memcgs.
>> Although kswapd could help out to reduce the number of memcgs, direct
>> reclaim still get hit with iterating a number of offline memcgs in some
>> cases.  We experienced the responsiveness problems due to this
>> occassionally.
> Can you provide some numbers?

What numbers do you mean? How long did it take to iterate all the 
memcgs? For now I don't have the exact number for the production 
environment, but the unresponsiveness is visible.

I had some test number with triggering direct reclaim with 8k memcgs 
artificially, which has just one clean page charged for each memcg, so 
the reclaim is cheaper than real production environment.

perf shows it took around 220ms to iterate 8k memcgs:

               dd 13873 [011]   578.542919: 
vmscan:mm_vmscan_direct_reclaim_begin
               dd 13873 [011]   578.758689: 
vmscan:mm_vmscan_direct_reclaim_end

So, iterating 400K would take at least 11s in this artificial case. The 
production environment is much more complicated, so it would take much 
longer in fact.

>
>> Here just break the iteration once it reclaims enough pages as what
>> memcg direct reclaim does.  This may hurt the fairness among memcgs
>> since direct reclaim may awlays do reclaim from same memcgs.  But, it
>> sounds ok since direct reclaim just tries to reclaim SWAP_CLUSTER_MAX
>> pages and memcgs can be protected by min/low.
> OK, this makes some sense to me. The purpose of the direct reclaim is
> to reclaim some memory and throttle the allocation pace. The iterator is
> cached so the next reclaimer on the same hierarchy will simply continue
> so the fairness should be more or less achieved.

Yes, you are right. I missed this point.

>
> Btw. is there any reason to keep !global_reclaim() check in place? Why
> is it not sufficient to exclude kswapd?

Iterating all memcgs in kswapd is still useful to help to reduce those 
zombie memcgs.

Thanks,
Yang

>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>>   mm/vmscan.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index a714c4f..ced5a16 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -2764,16 +2764,15 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>>   				   sc->nr_reclaimed - reclaimed);
>>   
>>   			/*
>> -			 * Direct reclaim and kswapd have to scan all memory
>> -			 * cgroups to fulfill the overall scan target for the
>> -			 * node.
>> +			 * Kswapd have to scan all memory cgroups to fulfill
>> +			 * the overall scan target for the node.
>>   			 *
>>   			 * Limit reclaim, on the other hand, only cares about
>>   			 * nr_to_reclaim pages to be reclaimed and it will
>>   			 * retry with decreasing priority if one round over the
>>   			 * whole hierarchy is not sufficient.
>>   			 */
>> -			if (!global_reclaim(sc) &&
>> +			if ((!global_reclaim(sc) || !current_is_kswapd()) &&
>>   					sc->nr_reclaimed >= sc->nr_to_reclaim) {
>>   				mem_cgroup_iter_break(root, memcg);
>>   				break;
>> -- 
>> 1.8.3.1
>>

