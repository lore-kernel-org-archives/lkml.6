Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E27C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351E42084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351E42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeKASkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:40:40 -0400
Received: from foss.arm.com ([217.140.101.70]:53804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbeKASkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:40:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2FA1A78;
        Thu,  1 Nov 2018 02:38:26 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61FFD3F557;
        Thu,  1 Nov 2018 02:38:24 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] sched/fair: update scale invariance of PELT
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org
References: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
 <1540570303-6097-3-git-send-email-vincent.guittot@linaro.org>
 <6d0b324e-5e26-a510-9bcd-97f475e515ed@arm.com>
 <CAKfTPtAPsq3fYrLEX7otQ+6Wy5JrQsYG8nLnEWT+09JBi=iKnQ@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <145bfbd2-f07f-6312-ca2f-029a5301fb15@arm.com>
Date:   Thu, 1 Nov 2018 10:38:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAPsq3fYrLEX7otQ+6Wy5JrQsYG8nLnEWT+09JBi=iKnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/18 10:18 AM, Vincent Guittot wrote:
> Hi Dietmar,
> 
> On Wed, 31 Oct 2018 at 08:20, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 10/26/18 6:11 PM, Vincent Guittot wrote:
>>
>> [...]
>>
>>>    static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
>>>    static unsigned long task_h_load(struct task_struct *p);
>>> @@ -764,7 +763,7 @@ void post_init_entity_util_avg(struct sched_entity *se)
>>>                         * such that the next switched_to_fair() has the
>>>                         * expected state.
>>>                         */
>>> -                     se->avg.last_update_time = cfs_rq_clock_task(cfs_rq);
>>> +                     se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
>>>                        return;
>>>                }
>>>        }
>>
>> There is this 1/cpu scaling of se->avg.util_sum (running_sum) in
>> update_tg_cfs_runnable() so it can be used to calculate
>> se->avg.runnable_load_sum (runnable_sum). I guess with your approach
>> this should be removed.
> 
> Yes good catch

Another thing, since you do not need the cpu parameter in 
accumulate_sum() anymore, you could also get rid of it in 
___update_load_sum() and further in __update_load_avg_blocked_se(),
__update_load_avg_cfs_rq() and __update_load_avg_se().

Nitpick: The function header of update_cfs_rq_load_avg() mentions '@now: 
current time, as per cfs_rq_clock_task()' ... should mention 
cfs_rq_clock_pelt() instead.

[...]
