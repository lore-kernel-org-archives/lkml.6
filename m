Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D0CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A5220870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A5220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbeGaQkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:40:10 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:57640 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732268AbeGaQkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:40:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0T5iG5K3_1533049129;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T5iG5K3_1533049129)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 31 Jul 2018 22:58:49 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH] sched/fair: sync expires_seq in distribute_cfs_runtime()
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ben Segall <bsegall@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180728002409.5781-1-xiyou.wangcong@gmail.com>
 <ef0e1185-51d6-0707-cda4-6f2ea987b651@linux.alibaba.com>
 <CAM_iQpVeK2VQDuahreZC2-L4eEzx0WtD8Bz=oHH68VSAiMqLGQ@mail.gmail.com>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <fad5ebe6-ec49-c67b-7b4f-78a413723aa8@linux.alibaba.com>
Date:   Tue, 31 Jul 2018 22:58:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAM_iQpVeK2VQDuahreZC2-L4eEzx0WtD8Bz=oHH68VSAiMqLGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/18 1:55 AM, Cong Wang wrote:
> On Sun, Jul 29, 2018 at 10:29 PM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>>
>> Hi Cong,
>>
>> On 7/28/18 8:24 AM, Cong Wang wrote:
>>> Each time we sync cfs_rq->runtime_expires with cfs_b->runtime_expires,
>>> we should sync its ->expires_seq too. However it is missing
>>> for distribute_cfs_runtime(), especially the slack timer call path.
>>
>> I don't think it's a problem, as expires_seq will get synced in
>> assign_cfs_rq_runtime().
> 
> Sure, but there is a small window during which they are not synced.
> Why do you want to wait until the next assign_cfs_rq_runtime() when
> you already know runtime_expires is synced?
> 
> Also, expire_cfs_rq_runtime() is called before assign_cfs_rq_runtime()
> inside __account_cfs_rq_runtime(), which means the check of
> cfs_rq->expires_seq is not accurate for unthrottling case if the clock
> drift happens soon enough?
> 

expire_cfs_rq_runtime():
    if (cfs_rq->expires_seq == cfs_b->expires_seq) {
        /* extend local deadline, drift is bounded above by 2 ticks */
        cfs_rq->runtime_expires += TICK_NSEC;
    } else {
        /* global deadline is ahead, expiration has passed */
        cfs_rq->runtime_remaining = 0;
    }

So if clock drift happens soon, then expires_seq decides the correct
thing we should do: if cfs_b->expires_seq advanced, then clear the stale
cfs_rq->runtime_remaining from the slack timer of the past period, then
assign_cfs_rq_runtime() will refresh them afterwards, otherwise it is a
real clock drift. I am still not getting where the race is?
