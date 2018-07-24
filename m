Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D116C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6DD20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6DD20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbeGXOhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:37:00 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:52126 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726656AbeGXOhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:37:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07402;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0T5FAEZm_1532438928;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T5FAEZm_1532438928)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Jul 2018 21:28:49 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [tip:sched/core] sched/cputime: Ensure accurate utime and stime
 ratio in cputime_adjust()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, tglx@linutronix.de,
        frederic@kernel.org, lcapitulino@redhat.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tj@kernel.org, linux-tip-commits@vger.kernel.org
References: <20180709145843.126583-1-xlpang@linux.alibaba.com>
 <tip-8d4c00dc38a8aa30dae8402955e55e7b34e74bc8@git.kernel.org>
 <20180716133751.GC2494@hirez.programming.kicks-ass.net>
 <20180716174119.GA4514@gmail.com>
 <464f4485-0e6b-17a2-1d54-6e2b24c95761@linux.alibaba.com>
 <20180723092118.GZ2494@hirez.programming.kicks-ass.net>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <dca42bb1-5480-cec0-0bc8-b5ac3c208177@linux.alibaba.com>
Date:   Tue, 24 Jul 2018 21:28:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723092118.GZ2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/18 5:21 PM, Peter Zijlstra wrote:
> On Tue, Jul 17, 2018 at 12:08:36PM +0800, Xunlei Pang wrote:
>> The trace data corresponds to the last sample period:
>> trace entry 1:
>>              cat-20755 [022] d...  1370.106496: cputime_adjust: task
>> tick-based utime 362560000000 stime 2551000000, scheduler rtime 333060702626
>>              cat-20755 [022] d...  1370.106497: cputime_adjust: result:
>> old utime 330729718142 stime 2306983867, new utime 330733635372 stime
>> 2327067254
>>
>> trace entry 2:
>>              cat-20773 [005] d...  1371.109825: cputime_adjust: task
>> tick-based utime 362567000000 stime 3547000000, scheduler rtime 334063718912
>>              cat-20773 [005] d...  1371.109826: cputime_adjust: result:
>> old utime 330733635372 stime 2327067254, new utime 330827229702 stime
>> 3236489210
>>
>> 1) expected behaviour
>> Let's compare the last two trace entries(all the data below is in ns):
>> task tick-based utime: 362560000000->362567000000 increased 7000000
>> task tick-based stime: 2551000000  ->3547000000   increased 996000000
>> scheduler rtime:       333060702626->334063718912 increased 1003016286
>>
>> The application actually runs almost 100%sys at the moment, we can
>> use the task tick-based utime and stime increased to double check:
>> 996000000/(7000000+996000000) > 99%sys
>>
>> 2) the current cputime_adjust() inaccurate result
>> But for the current cputime_adjust(), we get the following adjusted
>> utime and stime increase in this sample period:
>> adjusted utime: 330733635372->330827229702 increased 93594330
>> adjusted stime: 2327067254  ->3236489210   increased 909421956
>>
>> so 909421956/(93594330+909421956)=91%sys as the shell script shows above.
>>
>> 3) root cause
>> The root cause of the issue is that the current cputime_adjust() always
>> passes the whole times to scale_stime() to split the whole utime and
>> stime. In this patch, we pass all the increased deltas in 1) within
>> user's sample period to scale_stime() instead and accumulate the
>> corresponding results to the previous saved adjusted utime and stime,
>> so guarantee the accurate usr and sys increase within the user sample
>> period.
> 
> But why it this a problem?
> 
> Since its sample based there's really nothing much you can guarantee.
> What if your test program were to run in userspace for 50% of the time
> but is so constructed to always be in kernel space when the tick
> happens?
> 
> Then you would 'expect' it to be 50% user and 50% sys, but you're also
> not getting that.
> 
> This stuff cannot be perfect, and the current code provides 'sensible'
> numbers over the long run for most programs. Why muck with it?
> 

Basically I am ok with the current implementation, except for one
scenario we've met: when kernel went wrong for some reason with 100% sys
suddenly for seconds(even trigger softlockup), the statistics monitor
didn't reflect the fact, which confused people. One example with our
per-cgroup top, we ever noticed "20% usr, 80% sys" displayed while in
fact the kernel was in some busy loop(100% sys) at that moment, and the
tick based time are of course all sys samples in such case.
