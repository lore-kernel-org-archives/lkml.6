Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11975C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D5D2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D5D2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388672AbeGZScG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:32:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60042 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730095AbeGZScG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:32:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D2CF7A9;
        Thu, 26 Jul 2018 10:14:22 -0700 (PDT)
Received: from [10.4.12.39] (e113632-lin.Emea.Arm.com [10.4.12.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D97633F5B3;
        Thu, 26 Jul 2018 10:14:20 -0700 (PDT)
Subject: Re: [PATCHv4 00/12] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
To:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gaku.inami.xh@renesas.com,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
 <CAKfTPtB9tRb6vWAHf-CyMpZjMaRtOzUnB7PCuWwAmfsJf_Y6pA@mail.gmail.com>
 <20180709150839.GA19287@e105550-lin.cambridge.arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <98eb0daf-4467-3790-ec80-90b746807392@arm.com>
Date:   Thu, 26 Jul 2018 18:14:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180709150839.GA19287@e105550-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/07/18 16:08, Morten Rasmussen wrote:
> On Fri, Jul 06, 2018 at 12:18:27PM +0200, Vincent Guittot wrote:
>> Hi Morten,
>>
>> On Wed, 4 Jul 2018 at 12:18, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
>>> [...]
>> As already said , I'm not convinced by the proposal which seems quite
>> complex and also adds some kind of arbitrary and fixed power
>> management policy by deciding which tasks can or not go on big cores
>> whereas there are other frameworks to take such decision like EAS or
>> cgroups.
> 
> The misfit patches are a crucial part of the EAS solution but they also
> make sense for some users on their own without an energy model. This is
> why they are posted separately.
> 
> We have already discussed at length why the patches are needed and why
> the look like they do here in this thread:
> 
> https://lore.kernel.org/lkml/CAKfTPtD4skW_3SAk--vBEC5-m1Ua48bjOQYS0pDqW3nPSpsENg@mail.gmail.com/
> 
>> Furthermore, there is already something similar in the kernel
>> with SD_ASYM_PACKING and IMO, it would be better to improve this
>> feature (if needed) instead of adding a new one which often do similar
>> things.
> 
> As said in the previous thread, while it might look similar it isn't.
> SD_ASYM_PACKING isn't utilization-based which is the key metric used for
> EAS, schedutil, util_est, and util_clamp. SD_ASYM_PACKING serves a
> different purpose (see previous thread for details).
> 
>> I have rerun your tests and got same results than misfit task patchset
>> on my hikey960 with SD_ASYM_PACKING feature for legacy b.L topology
>> and fake dynamiQ topology. And it give better performance when the
>> pinned tasks are short and scheduler has to wait for the task to
>> increase their utilization before getting a chance to migrate on big
>> core.
> 
> Right, the test cases are quite simple and could be served better by
> SD_ASYM_PACKING. As we already discussed in that thread, that is due to
> the PELT lag but this the cost we have to pay if we don't have
> additional information about the requirements of the task and we don't
> want to default to big-first with all its implications.
> 

I played around with SD_ASYM_PACKING & lmbench on my HiKey960, and I think I
can bring a few more arguments to the table.



In terms of setup, I took Vincent's approach ([1]) which is to define
CPU priority as CPU capacity. As for the sched_domain flags, I initially
added SD_ASYM_PACKING to the DIE sched_domain, since it's the only level where
we want to do any ASYM_PACKING.

That causes a problem with nohz kicks, because the per-CPU sd_asym cache 
(which is used to determine if we can pack stuff into nohz CPUs) is defined
as:

    highest_flag_domain(cpu, SD_ASYM_PACKING);

which returns NULL because the first domain (MC) doesn't have it. That makes
sense to me as AFAICT that feature is mostly used to pack stuff on SMT levels.
It is only set at MC level in Vincent's patch, but that doesn't work for
regular big.LITTLE, so I had to set it for both MC and DIE. This does add a few
useless ops though, since all of the CPUs in a given MC domain have the same
priority.



With that out of the way, I did some lmbench runs:
> lat_mem_rd 10 1024

With ASYM_PACKING, I still see lmbench tasks remaining on LITTLE CPUs while
bigs are free, because ASYM_PACKING only does explicit active balancing on
CPU_NEWLY_IDLE balancing - otherwise it'll rely on the nr_balance_failed counter.

However, that counter can be reset before it reaches the threshold at which
active balance is done, which can lead to huge upmigration delays (almost a
full second). I also see the same kind of issues on Juno r0.

This could be resolved by extending ASYM_PACKING active balancing to 
non NEWLY_IDLE cases, but then we'd be thrashing everything. That's another
argument for basing upmigration on task load-tracking signals, as we can
determine which tasks need active balancing much faster than the
nr_balance_failed counter way while not active balancing the world.

---

[1]: https://lore.kernel.org/lkml/1522223215-23524-1-git-send-email-vincent.guittot@linaro.org/

---
lmbench results are meant to be plotted, I've added some pointers to show the
big obvious anomalies. I don't really care for the actual scores, as the 
resulting traces are interesting on their own, but I've included them for
the sake of completeness.

(lat_mem_rd 10 1024) with ASYM_PACKING:

0.00098 1.275
0.00195 1.274
0.00293 1.274
0.00391 1.274
0.00586 1.274
0.00781 1.275
0.00977 1.274
0.01172 1.275
0.01367 1.274
0.01562 1.274
0.01758 1.274
0.01953 1.274
0.02148 1.274
0.02344 1.274
0.02539 1.274
0.02734 1.275
0.0293 1.275
0.03125 1.275
0.03516 1.275
0.03906 1.275
0.04297 1.274
0.04688 1.275
0.05078 1.275
0.05469 1.275
0.05859 1.275
0.0625 1.275
0.07031 3.153
0.07812 4.035
0.08594 4.164
0.09375 4.237
0.10156 4.172
0.10938 4.1
0.11719 4.121
0.125 4.171
0.14062 4.073
0.15625 4.051
0.17188 4.026
0.1875 4.002
0.20312 3.973
0.21875 3.948
0.23438 3.927
0.25 3.904
0.28125 3.869
0.3125 3.86
0.34375 3.824
0.375 3.803
0.40625 3.798
0.4375 3.768
0.46875 3.784
0.5 3.753
0.5625 3.73
0.625 3.739
0.6875 3.703
0.75 3.69
0.8125 3.693
0.875 3.679
0.9375 3.686
1.0 3.664
1.125 3.656
1.25 3.658
1.375 3.638
1.5 3.635
1.625 3.628
1.75 4.274
1.875 4.579
2.0 4.651
2.25 5.313
2.5 6.314
2.75 7.585
3.0 8.457
3.25 9.045
3.5 9.532
3.75 9.909
4.0 148.66   <-----
4.5 10.191
5.0 10.222
5.5 10.208
6.0 10.21
6.5 10.21
7.0 10.199
7.5 10.203
8.0 154.354   <-----
9.0 10.163
10.0 10.138

(lat_mem_rd 10 1024) with misfit patches:

0.00098 1.273
0.00195 1.273
0.00293 1.273
0.00391 1.273
0.00586 1.274
0.00781 1.273
0.00977 1.273
0.01172 1.273
0.01367 1.273
0.01562 1.273
0.01758 1.273
0.01953 1.273
0.02148 1.273
0.02344 1.274
0.02539 1.273
0.02734 1.273
0.0293 1.273
0.03125 1.273
0.03516 1.273
0.03906 1.273
0.04297 1.273
0.04688 1.274
0.05078 1.274
0.05469 1.274
0.05859 1.274
0.0625 1.274
0.07031 3.323
0.07812 4.074
0.08594 4.171
0.09375 4.254
0.10156 4.166
0.10938 4.084
0.11719 4.088
0.125 4.112
0.14062 4.127
0.15625 4.132
0.17188 4.132
0.1875 4.131
0.20312 4.187
0.21875 4.17
0.23438 4.153
0.25 4.138
0.28125 4.102
0.3125 4.081
0.34375 4.075
0.375 4.011
0.40625 4.033
0.4375 4.021
0.46875 3.937
0.5 3.99
0.5625 3.901
0.625 3.995
0.6875 3.89
0.75 3.863
0.8125 3.903
0.875 3.883
0.9375 3.82
1.0 3.945
1.125 3.85
1.25 3.884
1.375 3.833
1.5 4.89
1.625 4.834
1.75 5.041
1.875 5.054
2.0 5.38
2.25 5.752
2.5 6.805
2.75 7.516
3.0 8.545
3.25 9.115
3.5 9.525
3.75 9.871
4.0 10.017
4.5 10.177
5.0 10.201
5.5 10.209
6.0 10.204
6.5 10.18
7.0 10.19
7.5 10.171
8.0 10.166
9.0 10.164
10.0 10.166
