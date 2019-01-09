Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424F2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0D620685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfAIWMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:12:08 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:48075 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbfAIWMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:12:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0THuiMXM_1547071761;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0THuiMXM_1547071761)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Jan 2019 06:09:24 +0800
Subject: Re: [RFC v3 PATCH 0/5] mm: memcontrol: do memory reclaim when
 offlining
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mhocko@suse.com, shakeelb@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1547061285-100329-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190109193247.GA16319@cmpxchg.org>
 <d92912c7-511e-2ab5-39a6-38af3209fcaf@linux.alibaba.com>
 <20190109212334.GA18978@cmpxchg.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <9de4bb4a-6bb7-e13a-0d9a-c1306e1b3e60@linux.alibaba.com>
Date:   Wed, 9 Jan 2019 14:09:20 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190109212334.GA18978@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/19 1:23 PM, Johannes Weiner wrote:
> On Wed, Jan 09, 2019 at 12:36:11PM -0800, Yang Shi wrote:
>> As I mentioned above, if we know some page caches from some memcgs
>> are referenced one-off and unlikely shared, why just keep them
>> around to increase memory pressure?
> It's just not clear to me that your scenarios are generic enough to
> justify adding two interfaces that we have to maintain forever, and
> that they couldn't be solved with existing mechanisms.
>
> Please explain:
>
> - Unmapped clean page cache isn't expensive to reclaim, certainly
>    cheaper than the IO involved in new application startup. How could
>    recycling clean cache be a prohibitive part of workload warmup?

It is nothing about recycling. Those page caches might be referenced by 
memcg just once, then nobody touch them until memory pressure is hit. 
And, they might be not accessed again at any time soon.

>
> - Why you cannot temporarily raise the kswapd watermarks right before
>    an important application starts up (your answer was sorta handwavy)

It could, but kswapd watermark is global. Boosting kswapd watermark may 
cause kswapd reclaim some memory from some memcgs which we want to keep 
untouched. Although v2's low/min could provide some protection, it is 
still not prohibited generally. And, v1 doesn't have such protection at all.

force_empty or wipe_on_offline could be used to target to some specific 
memcgs which we may know exactly what they do or it is safe to reclaim 
memory from them. IMHO, this may make better isolation.

>
> - Why you cannot use madvise/fadvise when an application whose cache
>    you won't reuse exits

Sure we can. But, we can't guarantee all applications use them properly.

>
> - Why you couldn't set memory.high or memory.max to 0 after the
>    application quits and before you call rmdir on the cgroup

I recall I explained this in the review email for the first version. Set 
memory.high or memory.max to 0 would trigger direct reclaim which may 
stall the offline of memcg. But, we have "restarting the same name job" 
logic in our usecase (I'm not quite sure why they do so). Basically, it 
means to create memcg with the exact same name right after the old one 
is deleted, but may have different limit or other settings. The creation 
has to wait for rmdir is done.

>
> Adding a permanent kernel interface is a serious measure. I think you
> need to make a much better case for it, discuss why other options are
> not practical, and show that this will be a generally useful thing for
> cgroup users and not just a niche fix for very specific situations.

I do understand your concern and the maintenance cost for a permanent 
kernel interface. I'm not quite sure if this is generic enough, however, 
Michal Hocko did mention "It seems we have several people asking for 
something like that already.", so at least it sounds not like "a niche 
fix for very specific situations".

In my first submit, I did reuse force_empty interface to keep it less 
intrusive, at least not a new interface. Since we have several people 
asking for something like that already, Michal suggested a new knob 
instead of reusing force_empty.

Thanks,
Yang


