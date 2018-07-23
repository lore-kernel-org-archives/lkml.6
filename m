Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388AAECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F381520880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F381520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389700AbeGWNdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:33:20 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:36287 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388283AbeGWNdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:33:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0T5AXqzf_1532349134;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0T5AXqzf_1532349134)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 23 Jul 2018 20:32:14 +0800
Subject: Re: [PATCH v2] tg: show the sum wait time of an task group
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <5c4c978d-e8fb-4bcb-b942-3c6d3dcfc13e@linux.alibaba.com>
 <b9e74571-87d0-ef27-3f14-ebd21d72ee15@linux.alibaba.com>
 <ff7dae3b-e5f9-7157-1caa-ff02c6b23dc1@linux.alibaba.com>
 <20180723093121.GA2494@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <a57d74eb-f7a8-80e6-6798-2f9eec942ce3@linux.alibaba.com>
Date:   Mon, 23 Jul 2018 20:32:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180723093121.GA2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/23 下午5:31, Peter Zijlstra wrote:
> On Wed, Jul 04, 2018 at 11:27:27AM +0800, 王贇 wrote:
> 
>> @@ -6788,6 +6790,12 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
>>   	seq_printf(sf, "nr_throttled %d\n", cfs_b->nr_throttled);
>>   	seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);
>>
>> +	if (schedstat_enabled() && tg != &root_task_group) {
> 
> I put the variables here.

Will do that in next version :-)

> 
>> +		for_each_possible_cpu(i)
>> +			ws += schedstat_val(tg->se[i]->statistics.wait_sum);
> 
> This doesn't quite work on 32bit archs, but I'm not sure I care enough
> to be bothered about that.

Could easily overflow then... hope they won't really care
about the group conflicts.

Regards,
Michael Wang

> 
>> +		seq_printf(sf, "wait_sum %llu\n", ws);
>> +	}
