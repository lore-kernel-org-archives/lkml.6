Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12871C282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D417E218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbfAZBmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 20:42:09 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:32799 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725550AbfAZBmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 20:42:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TJ.cBFS_1548466923;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TJ.cBFS_1548466923)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 26 Jan 2019 09:42:05 +0800
Subject: Re: [RFC PATCH] mm: vmscan: do not iterate all mem cgroups for global
 direct reclaim
To:     Michal Hocko <mhocko@kernel.org>
Cc:     hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1548187782-108454-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190123095926.GS4087@dhcp22.suse.cz>
 <3684a63c-4c1d-fd1a-cda5-af92fb6bea8d@linux.alibaba.com>
 <20190124084341.GE4087@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <7f2a5566-7547-b089-cf14-9c6db38283aa@linux.alibaba.com>
Date:   Fri, 25 Jan 2019 17:42:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190124084341.GE4087@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/19 12:43 AM, Michal Hocko wrote:
> On Wed 23-01-19 12:24:38, Yang Shi wrote:
>>
>> On 1/23/19 1:59 AM, Michal Hocko wrote:
>>> On Wed 23-01-19 04:09:42, Yang Shi wrote:
>>>> In current implementation, both kswapd and direct reclaim has to iterate
>>>> all mem cgroups.  It is not a problem before offline mem cgroups could
>>>> be iterated.  But, currently with iterating offline mem cgroups, it
>>>> could be very time consuming.  In our workloads, we saw over 400K mem
>>>> cgroups accumulated in some cases, only a few hundred are online memcgs.
>>>> Although kswapd could help out to reduce the number of memcgs, direct
>>>> reclaim still get hit with iterating a number of offline memcgs in some
>>>> cases.  We experienced the responsiveness problems due to this
>>>> occassionally.
>>> Can you provide some numbers?
>> What numbers do you mean? How long did it take to iterate all the memcgs?
>> For now I don't have the exact number for the production environment, but
>> the unresponsiveness is visible.
> Yeah, I would be interested in the worst case direct reclaim latencies.
> You can get that from our vmscan tracepoints quite easily.

I wish I could. But I just can't predict when the problem will happen on 
what machine, and I can't simply run perf on all machines of production 
environment.

I tried to dig into our cluster monitor data history which records some 
system behaviors. By looking into the data, it seems excessive direct 
reclaim latency may reach tens of seconds due to excessive memcgs in 
some cases (the discrepancy depends on the number of memcgs and workload 
too).

And the excessive direct reclaim latency problem has been reduced 
significantly since the patch was deployed.

>
>> I had some test number with triggering direct reclaim with 8k memcgs
>> artificially, which has just one clean page charged for each memcg, so the
>> reclaim is cheaper than real production environment.
>>
>> perf shows it took around 220ms to iterate 8k memcgs:
>>
>>                dd 13873 [011]   578.542919:
>> vmscan:mm_vmscan_direct_reclaim_begin
>>                dd 13873 [011]   578.758689:
>> vmscan:mm_vmscan_direct_reclaim_end
>>
>> So, iterating 400K would take at least 11s in this artificial case. The
>> production environment is much more complicated, so it would take much
>> longer in fact.
> Having real world numbers would definitely help with the justification.
>
>>>> Here just break the iteration once it reclaims enough pages as what
>>>> memcg direct reclaim does.  This may hurt the fairness among memcgs
>>>> since direct reclaim may awlays do reclaim from same memcgs.  But, it
>>>> sounds ok since direct reclaim just tries to reclaim SWAP_CLUSTER_MAX
>>>> pages and memcgs can be protected by min/low.
>>> OK, this makes some sense to me. The purpose of the direct reclaim is
>>> to reclaim some memory and throttle the allocation pace. The iterator is
>>> cached so the next reclaimer on the same hierarchy will simply continue
>>> so the fairness should be more or less achieved.
>> Yes, you are right. I missed this point.
>>
>>> Btw. is there any reason to keep !global_reclaim() check in place? Why
>>> is it not sufficient to exclude kswapd?
>> Iterating all memcgs in kswapd is still useful to help to reduce those
>> zombie memcgs.
> Yes, but for that you do not need to check for global_reclaim right?

Aha, yes. You are right. !current_is_kswapd() is good enough. Will fix 
this in v2.

Thanks,
Yang


