Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818AFECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFD020877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFD020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeGQEkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:40:23 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:33140 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726357AbeGQEkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:40:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0T4mLKVL_1531800516;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T4mLKVL_1531800516)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Jul 2018 12:08:36 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [tip:sched/core] sched/cputime: Ensure accurate utime and stime
 ratio in cputime_adjust()
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, frederic@kernel.org, lcapitulino@redhat.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tj@kernel.org, linux-tip-commits@vger.kernel.org
References: <20180709145843.126583-1-xlpang@linux.alibaba.com>
 <tip-8d4c00dc38a8aa30dae8402955e55e7b34e74bc8@git.kernel.org>
 <20180716133751.GC2494@hirez.programming.kicks-ass.net>
 <20180716174119.GA4514@gmail.com>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <464f4485-0e6b-17a2-1d54-6e2b24c95761@linux.alibaba.com>
Date:   Tue, 17 Jul 2018 12:08:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180716174119.GA4514@gmail.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/18 1:41 AM, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Sun, Jul 15, 2018 at 04:36:17PM -0700, tip-bot for Xunlei Pang wrote:
>>> Commit-ID:  8d4c00dc38a8aa30dae8402955e55e7b34e74bc8
>>> Gitweb:     https://git.kernel.org/tip/8d4c00dc38a8aa30dae8402955e55e7b34e74bc8
>>> Author:     Xunlei Pang <xlpang@linux.alibaba.com>
>>> AuthorDate: Mon, 9 Jul 2018 22:58:43 +0800
>>> Committer:  Ingo Molnar <mingo@kernel.org>
>>> CommitDate: Mon, 16 Jul 2018 00:28:31 +0200
>>>
>>> sched/cputime: Ensure accurate utime and stime ratio in cputime_adjust()
>>>
>>> If users access "/proc/pid/stat", the utime and stime ratio in the
>>> current SAMPLE period are excepted, but currently cputime_adjust()
>>> always calculates with the ratio of the WHOLE lifetime of the process.
>>>
>>> This results in inaccurate utime and stime in "/proc/pid/stat". For
>>> example,  a process runs for a while with "50% usr, 0% sys", then
>>> followed by "100% sys". For later while, the following is excepted:
>>>
>>>   0.0 usr,  100.0 sys
>>>
>>> but we get:
>>>
>>>   10.0 usr,  90.0 sys
>>>
>>> This patch uses the accurate ratio in cputime_adjust() to address the
>>> issue. A new 'task_cputime' type field is added in prev_cputime to record
>>> previous 'task_cputime' so that we can get the elapsed times as the accurate
>>> ratio.
>>
>> Ingo, please make this one go away.
> 
> Sure, I've removed it from sched/core.
> 

Hi Ingo, Peter, Frederic,

I captured some runtime data using trace to explain it, hope this can
illustrate the motive behind my patch. Anyone could help improve my
changelog is appreciated if you think so after reading.


Here are the simple trace_printk I added to capture the real data:

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 0796f938c4f0..b65c1f250941 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -611,6 +611,9 @@ void cputime_adjust(struct task_cputime *curr,
struct prev_cputime *prev,
        stime = curr->stime;
        utime = curr->utime;

+       if (!strncmp(current->comm, "cat", 3))
+               trace_printk("task tick-based utime %lld stime %lld,
scheduler rtime %lld\n", utime, stime, rtime);
+
        /*
         * If either stime or utime are 0, assume all runtime is userspace.
         * Once a task gets some ticks, the monotonicy code at 'update:'
@@ -651,9 +654,14 @@ void cputime_adjust(struct task_cputime *curr,
struct prev_cputime *prev,
                stime = rtime - utime;
        }

+       if (!strncmp(current->comm, "cat", 3))
+               trace_printk("result: old utime %lld stime %lld, new
utime %lld stime %lld\n",
+                               prev->utime, prev->stime, utime, stime);
+
        prev->stime = stime;
        prev->utime = utime;
 out:
        *ut = prev->utime;
        *st = prev->stime;
        raw_spin_unlock_irqrestore(&prev->lock, flags);


Using the reproducer I described in the changelog, it runs for a while
with "50% usr, 0% sys", then followed by "100% sys". A shell script
accesses its /proc/pid/stat at the interval of one second, and got:
50.0 usr,  0.0 sys
51.0 usr,  0.0 sys
50.0 usr,  0.0 sys
...
9.0 usr,  91.0 sys
9.0 usr,  91.0 sys


The trace data corresponds to the last sample period:
trace entry 1:
             cat-20755 [022] d...  1370.106496: cputime_adjust: task
tick-based utime 362560000000 stime 2551000000, scheduler rtime 333060702626
             cat-20755 [022] d...  1370.106497: cputime_adjust: result:
old utime 330729718142 stime 2306983867, new utime 330733635372 stime
2327067254

trace entry 2:
             cat-20773 [005] d...  1371.109825: cputime_adjust: task
tick-based utime 362567000000 stime 3547000000, scheduler rtime 334063718912
             cat-20773 [005] d...  1371.109826: cputime_adjust: result:
old utime 330733635372 stime 2327067254, new utime 330827229702 stime
3236489210

1) expected behaviour
Let's compare the last two trace entries(all the data below is in ns):
task tick-based utime: 362560000000->362567000000 increased 7000000
task tick-based stime: 2551000000  ->3547000000   increased 996000000
scheduler rtime:       333060702626->334063718912 increased 1003016286

The application actually runs almost 100%sys at the moment, we can
use the task tick-based utime and stime increased to double check:
996000000/(7000000+996000000) > 99%sys

2) the current cputime_adjust() inaccurate result
But for the current cputime_adjust(), we get the following adjusted
utime and stime increase in this sample period:
adjusted utime: 330733635372->330827229702 increased 93594330
adjusted stime: 2327067254  ->3236489210   increased 909421956

so 909421956/(93594330+909421956)=91%sys as the shell script shows above.

3) root cause
The root cause of the issue is that the current cputime_adjust() always
passes the whole times to scale_stime() to split the whole utime and
stime. In this patch, we pass all the increased deltas in 1) within
user's sample period to scale_stime() instead and accumulate the
corresponding results to the previous saved adjusted utime and stime,
so guarantee the accurate usr and sys increase within the user sample
period.


Thanks,
Xunlei
