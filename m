Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C48C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A90020848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A90020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeLCOur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:50:47 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:43483 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbeLCOur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:50:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01429;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TElAQiJ_1543848559;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0TElAQiJ_1543848559)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 03 Dec 2018 22:49:19 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH 1/3] mm/memcg: Fix min/low usage in
 propagate_protected_usage()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20181203080119.18989-1-xlpang@linux.alibaba.com>
 <20181203115453.GO31738@dhcp22.suse.cz>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <1c62ec71-52de-3597-ec87-3dd8d81c4d2a@linux.alibaba.com>
Date:   Mon, 3 Dec 2018 22:49:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181203115453.GO31738@dhcp22.suse.cz>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/3 ÏÂÎç7:54, Michal Hocko wrote:
> On Mon 03-12-18 16:01:17, Xunlei Pang wrote:
>> When usage exceeds min, min usage should be min other than 0.
>> Apply the same for low.
> 
> Why? What is the actual problem.

children_min_usage tracks the total children usages under min,
it's natural that min should be added into children_min_usage
when above min, I can't image why 0 is added, is there special
history I missed?

See mem_cgroup_protected(), when usage exceeds min, emin is
calculated as "parent_emin*min/children_min_usage".

> 
>> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
>> ---
>>  mm/page_counter.c | 12 ++----------
>>  1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/page_counter.c b/mm/page_counter.c
>> index de31470655f6..75d53f15f040 100644
>> --- a/mm/page_counter.c
>> +++ b/mm/page_counter.c
>> @@ -23,11 +23,7 @@ static void propagate_protected_usage(struct page_counter *c,
>>  		return;
>>  
>>  	if (c->min || atomic_long_read(&c->min_usage)) {
>> -		if (usage <= c->min)
>> -			protected = usage;
>> -		else
>> -			protected = 0;
>> -
>> +		protected = min(usage, c->min);
>>  		old_protected = atomic_long_xchg(&c->min_usage, protected);
>>  		delta = protected - old_protected;
>>  		if (delta)
>> @@ -35,11 +31,7 @@ static void propagate_protected_usage(struct page_counter *c,
>>  	}
>>  
>>  	if (c->low || atomic_long_read(&c->low_usage)) {
>> -		if (usage <= c->low)
>> -			protected = usage;
>> -		else
>> -			protected = 0;
>> -
>> +		protected = min(usage, c->low);
>>  		old_protected = atomic_long_xchg(&c->low_usage, protected);
>>  		delta = protected - old_protected;
>>  		if (delta)
>> -- 
>> 2.13.5 (Apple Git-94)
>>
> 
