Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCD0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E39420844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E39420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeHAFHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 01:07:35 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:53705 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbeHAFHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 01:07:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0T5k5fVs_1533093844;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T5k5fVs_1533093844)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Aug 2018 11:24:04 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH] sched/fair: sync expires_seq in distribute_cfs_runtime()
To:     Cong Wang <xiyou.wangcong@gmail.com>,
        Ben Segall <bsegall@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180728002409.5781-1-xiyou.wangcong@gmail.com>
 <ef0e1185-51d6-0707-cda4-6f2ea987b651@linux.alibaba.com>
 <CAM_iQpVeK2VQDuahreZC2-L4eEzx0WtD8Bz=oHH68VSAiMqLGQ@mail.gmail.com>
 <fad5ebe6-ec49-c67b-7b4f-78a413723aa8@linux.alibaba.com>
 <xm26ftzz8h0r.fsf@bsegall-linux.svl.corp.google.com>
 <CAM_iQpXGCqo9AAp2kpSKk9sHx0ZRK7JU_c07sWh4vR9kFQ+LxA@mail.gmail.com>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <0939a9c3-e9c0-ae8a-3f56-0dde1ab2fc8e@linux.alibaba.com>
Date:   Wed, 1 Aug 2018 11:24:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAM_iQpXGCqo9AAp2kpSKk9sHx0ZRK7JU_c07sWh4vR9kFQ+LxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/18 4:55 AM, Cong Wang wrote:
> On Tue, Jul 31, 2018 at 10:13 AM <bsegall@google.com> wrote:
>>
>> Xunlei Pang <xlpang@linux.alibaba.com> writes:
>>
>>> On 7/31/18 1:55 AM, Cong Wang wrote:
>>>> On Sun, Jul 29, 2018 at 10:29 PM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>>>>>
>>>>> Hi Cong,
>>>>>
>>>>> On 7/28/18 8:24 AM, Cong Wang wrote:
>>>>>> Each time we sync cfs_rq->runtime_expires with cfs_b->runtime_expires,
>>>>>> we should sync its ->expires_seq too. However it is missing
>>>>>> for distribute_cfs_runtime(), especially the slack timer call path.
>>>>>
>>>>> I don't think it's a problem, as expires_seq will get synced in
>>>>> assign_cfs_rq_runtime().
>>>>
>>>> Sure, but there is a small window during which they are not synced.
>>>> Why do you want to wait until the next assign_cfs_rq_runtime() when
>>>> you already know runtime_expires is synced?
>>>>
>>>> Also, expire_cfs_rq_runtime() is called before assign_cfs_rq_runtime()
>>>> inside __account_cfs_rq_runtime(), which means the check of
>>>> cfs_rq->expires_seq is not accurate for unthrottling case if the clock
>>>> drift happens soon enough?
>>>>
>>>
>>> expire_cfs_rq_runtime():
>>>     if (cfs_rq->expires_seq == cfs_b->expires_seq) {
>>>         /* extend local deadline, drift is bounded above by 2 ticks */
>>>         cfs_rq->runtime_expires += TICK_NSEC;
>>>     } else {
>>>         /* global deadline is ahead, expiration has passed */
>>>         cfs_rq->runtime_remaining = 0;
>>>     }
>>>
>>> So if clock drift happens soon, then expires_seq decides the correct
>>> thing we should do: if cfs_b->expires_seq advanced, then clear the stale
>>> cfs_rq->runtime_remaining from the slack timer of the past period, then
>>> assign_cfs_rq_runtime() will refresh them afterwards, otherwise it is a
>>> real clock drift. I am still not getting where the race is?
> 
> But expires_seq is supposed to be the same here, after
> distribute_cfs_runtime(), therefore runtime_remaining is not supposed
> to be cleared.
> 
> Which part do I misunderstand? expires_seq should not be same here?
> Or you are saying a wrongly clear of runtime_remaning is fine?
> 

Let's see the unthrottle cases.
1. for the periodic timer
distribute_cfs_runtime updates the throttled cfs_rq->runtime_expires to
be a new value, so expire_cfs_rq_runtime does nothing because of:
  rq_clock(rq_of(cfs_rq)) - cfs_rq->runtime_expires < 0

Afterwards assign_cfs_rq_runtime() will sync its expires_seq.

2. for the slack timer
the two expires_seq should be the same, so if clock drift happens soon,
expire_cfs_rq_runtime regards it as true clock drift:
  cfs_rq->runtime_expires += TICK_NSEC
If it happens that global expires_seq advances, it also doesn't matter,
expire_cfs_rq_runtime will clear the stale expire_cfs_rq_runtime as
expected.

> 
>>
>> Nothing /important/ goes wrong because distribute_cfs_runtime only fills
>> runtime_remaining up to 1, not a real amount.
> 
> No, runtime_remaining is updated right before expire_cfs_rq_runtime():
> 
> static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
> {
>         /* dock delta_exec before expiring quota (as it could span periods) */
>         cfs_rq->runtime_remaining -= delta_exec;
>         expire_cfs_rq_runtime(cfs_rq);
> 
> so almost certainly it can't be 1.

I think Ben means it firstly gets a distributtion of 1 to run after
unthrottling, soon it will have a negative runtime_remaining, and go
to assign_cfs_rq_runtime().

Thanks,
Xunlei

> 
> Which means the following check could be passed:
> 
>  4655         if (cfs_rq->runtime_remaining < 0)
>  4656                 return;
> 
> therefore we are reaching the clock drift logic code inside
> expire_cfs_rq_runtime()
> where expires_seq is supposed to be same as they should be sync'ed.
> Therefore without patch, we wrongly clear the runtime_remainng?
> 
> Thanks.
> 
