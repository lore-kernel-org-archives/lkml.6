Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8819CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5843624ED6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5843624ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932382AbeGCCKY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:10:24 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:60971 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932216AbeGCCKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:10:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0T3scaTw_1530583805;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0T3scaTw_1530583805)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Jul 2018 10:10:05 +0800
Subject: Re: [RFC PATCH] tg: count the sum wait time of an task group
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <5c4c978d-e8fb-4bcb-b942-3c6d3dcfc13e@linux.alibaba.com>
 <20180702120356.GJ2494@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <21628e16-5d34-d7f6-8c10-ff354b4e7b35@linux.alibaba.com>
Date:   Tue, 3 Jul 2018 10:10:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702120356.GJ2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter

On 2018/7/2 下午8:03, Peter Zijlstra wrote:
> On Mon, Jul 02, 2018 at 03:29:39PM +0800, 王贇 wrote:
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 1866e64..ef82ceb 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -862,6 +862,7 @@ static void update_curr_fair(struct rq *rq)
>>   static inline void
>>   update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>   {
>> +	struct task_group *tg;
>>   	struct task_struct *p;
>>   	u64 delta;
>>
>> @@ -882,6 +883,9 @@ static void update_curr_fair(struct rq *rq)
>>   			return;
>>   		}
>>   		trace_sched_stat_wait(p, delta);
>> +	} else {
>> +		tg = group_cfs_rq(se)->tg;
>> +		__schedstat_add(tg->wait_sum, delta);
>>   	}
> 
> You're joking right? This patch is both broken and utterly insane.
> 
> You're wanting to update an effectively global variable for every
> schedule action (and its broken because it is without any serialization
> or atomics).

Thanks for the reply and sorry for the thoughtless, I'll rewrite
the code to make it per-cpu variable, then assemble the results
on show.

Regards,
Michael Wang


> 
> NAK
> 
