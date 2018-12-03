Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF593C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C1C20834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C1C20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbeLCPUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:20:38 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:56728 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726549AbeLCPUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:20:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TElCRpQ_1543850431;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0TElCRpQ_1543850431)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 03 Dec 2018 23:20:32 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH 2/3] mm/vmscan: Enable kswapd to reclaim low-protected
 memory
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20181203080119.18989-1-xlpang@linux.alibaba.com>
 <20181203080119.18989-2-xlpang@linux.alibaba.com>
 <20181203115646.GP31738@dhcp22.suse.cz>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <54a3f0a6-6e7d-c620-97f2-ac567c057bc2@linux.alibaba.com>
Date:   Mon, 3 Dec 2018 23:20:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181203115646.GP31738@dhcp22.suse.cz>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/3 ÏÂÎç7:56, Michal Hocko wrote:
> On Mon 03-12-18 16:01:18, Xunlei Pang wrote:
>> There may be cgroup memory overcommitment, it will become
>> even common in the future.
>>
>> Let's enable kswapd to reclaim low-protected memory in case
>> of memory pressure, to mitigate the global direct reclaim
>> pressures which could cause jitters to the response time of
>> lantency-sensitive groups.
> 
> Please be more descriptive about the problem you are trying to handle
> here. I haven't actually read the patch but let me emphasise that the
> low limit protection is important isolation tool. And allowing kswapd to
> reclaim protected memcgs is going to break the semantic as it has been
> introduced and designed.

We have two types of memcgs: online groups(important business)
and offline groups(unimportant business). Online groups are
all configured with MAX low protection, while offline groups
are not at all protected(with default 0 low).

When offline groups are overcommitted, the global memory pressure
suffers. This will cause the memory allocations from online groups
constantly go to the slow global direct reclaim in order to reclaim
online's page caches, as kswap is not able to reclaim low-protection
memory. low is not hard limit, it's reasonable to be reclaimed by
kswapd if there's no other reclaimable memory.

> 
>>
>> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
>> ---
>>  mm/vmscan.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 62ac0c488624..3d412eb91f73 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -3531,6 +3531,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
>>  
>>  	count_vm_event(PAGEOUTRUN);
>>  
>> +retry:
>>  	do {
>>  		unsigned long nr_reclaimed = sc.nr_reclaimed;
>>  		bool raise_priority = true;
>> @@ -3622,6 +3623,13 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
>>  			sc.priority--;
>>  	} while (sc.priority >= 1);
>>  
>> +	if (!sc.nr_reclaimed && sc.memcg_low_skipped) {
>> +		sc.priority = DEF_PRIORITY;
>> +		sc.memcg_low_reclaim = 1;
>> +		sc.memcg_low_skipped = 0;
>> +		goto retry;
>> +	}
>> +
>>  	if (!sc.nr_reclaimed)
>>  		pgdat->kswapd_failures++;
>>  
>> -- 
>> 2.13.5 (Apple Git-94)
>>
> 
