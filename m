Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C407E13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF5420893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF5420893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeG3PRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:17:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbeG3PRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:17:48 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 357442B75703D;
        Mon, 30 Jul 2018 21:42:33 +0800 (CST)
Received: from [10.177.98.84] (10.177.98.84) by smtp.huawei.com (10.3.19.205)
 with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 30 Jul 2018 21:42:27
 +0800
Subject: Re: [Question] load balance move tasks not suitable ?
To:     Peter Zijlstra <peterz@infradead.org>
References: <6e782fa5-de1d-93a9-ed11-5b43b65b20c9@huawei.com>
 <20180730125606.GP2476@hirez.programming.kicks-ass.net>
CC:     <linux-kernel@vger.kernel.org>,
        Zhanghailiang <zhang.zhanghailiang@huawei.com>
From:   "weiqi (C)" <weiqi4@huawei.com>
Message-ID: <8513a5c1-2067-cdf6-285f-3fb422274c05@huawei.com>
Date:   Mon, 30 Jul 2018 21:42:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180730125606.GP2476@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.98.84]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in latest  linux kernel version,  load-balance's  detach_tasks() keeps  
"load/2"  behavior:

"""

         if (( load / 2 ) > env->imbalance)
                 goto next;
"""

It  means  a task  "p",  which  load  is 1.5 times than "env->imbalance" 
can move from "src_rq" to "dst_rq".
after this move,  imbalance between  "src_rq"  and "dst_rq" may larger 
than  before.
but if use "load*2" here,  It means we can pick a task "p" , which load 
is half of "env->imbalance"， and after move，
"src_rq" and "dst_rq"  is balanced.

Am I right?


在 2018/7/30 20:56, Peter Zijlstra 写道:
> On Mon, Jul 30, 2018 at 08:08:55PM +0800, weiqi (C) wrote:
>> Hi Peter,
>>
>> After  Commits 5d6523ebd(sched: Fix load-balance wreckage)，
> That's a _6_ year old patch... and I can barely remember last week.
>
>> The jugement whether imbalance reached changed from twice to one-half.
>>
>> from
>>
>> (1) if((load * 2)> rem_load_move)
>>          goto next;
>>
>> to
>>
>> (2) if((load / 2)> env-> load_move)
>>          goto next;
>>
>> I'm confused about this change.
>>
>> "load*2" may be more appropriate, because if a task whose load more than
>> env->imbalance is moved from high load cpu to low load cpu,
>>
>> will make more imbalance.
> It basically goes back to what it was before (see 367456c), in that
> patch I (inadvertently) replaced (load.weight >> 1) with (load * 2)
> instead of (load / 2).
>
> I'm not entirely sure I can explain that logic at this time. Doing
> software archeology on it might clarify where it came from.
> .
>

