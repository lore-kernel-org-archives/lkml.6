Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C82C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDBF206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfAIUlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:41:17 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:56699 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726548AbfAIUlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 15:41:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0THuJmIi_1547066172;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0THuJmIi_1547066172)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Jan 2019 04:36:15 +0800
Subject: Re: [RFC v3 PATCH 0/5] mm: memcontrol: do memory reclaim when
 offlining
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mhocko@suse.com, shakeelb@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1547061285-100329-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190109193247.GA16319@cmpxchg.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <d92912c7-511e-2ab5-39a6-38af3209fcaf@linux.alibaba.com>
Date:   Wed, 9 Jan 2019 12:36:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190109193247.GA16319@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/19 11:32 AM, Johannes Weiner wrote:
> On Thu, Jan 10, 2019 at 03:14:40AM +0800, Yang Shi wrote:
>> We have some usecases which create and remove memcgs very frequently,
>> and the tasks in the memcg may just access the files which are unlikely
>> accessed by anyone else.  So, we prefer force_empty the memcg before
>> rmdir'ing it to reclaim the page cache so that they don't get
>> accumulated to incur unnecessary memory pressure.  Since the memory
>> pressure may incur direct reclaim to harm some latency sensitive
>> applications.
> We have kswapd for exactly this purpose. Can you lay out more details
> on why that is not good enough, especially in conjunction with tuning
> the watermark_scale_factor etc.?

watermark_scale_factor does help out for some workloads in general. 
However, memcgs might be created then do memory allocation faster than 
kswapd in some our workloads. And, the tune may work for one kind 
machine or workload, but may not work for others. But, we may have 
different kind workloads (for example, latency-sensitive and batch jobs) 
run on the same machine, so it is kind of hard for us to guarantee all 
the workloads work well together by relying on kswapd and 
watermark_scale_factor only.

And, we know the page cache access pattern would be one-off for some 
memcgs, and those page caches are unlikely shared by others, so why not 
just drop them when the memcg is offlined. Reclaiming those cold page 
caches earlier would also improve the efficiency of memcg creation for 
long run.

>
> We've been pretty adamant that users shouldn't use drop_caches for
> performance for example, and that the need to do this usually is
> indicative of a problem or suboptimal tuning in the VM subsystem.
>
> How is this different?

IMHO, that depends on the usecases and workloads. As I mentioned above, 
if we know some page caches from some memcgs are referenced one-off and 
unlikely shared, why just keep them around to increase memory pressure?

Thanks,
Yang


