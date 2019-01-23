Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0425EC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C7720870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfAWLTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:19:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39684 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbfAWLTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:19:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67AA0EBD;
        Wed, 23 Jan 2019 03:19:52 -0800 (PST)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B88E3F5C1;
        Wed, 23 Jan 2019 03:19:45 -0800 (PST)
Subject: Re: [PATCH v8 2/3] sched/fair: update scale invariance of PELT
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org, Quentin Perret <quentin.perret@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <1547631791-16018-1-git-send-email-vincent.guittot@linaro.org>
 <1547631791-16018-3-git-send-email-vincent.guittot@linaro.org>
 <a3671d96-5003-6a50-ad2d-64833ca216a1@arm.com>
 <CAKfTPtCjb2PRxgs9nABw2V_MJq2wi=0DTpm+wEvvSX7qnAp+VA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <308e0dcc-f406-77b5-5631-d00dd4680a7d@arm.com>
Date:   Wed, 23 Jan 2019 12:19:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCjb2PRxgs9nABw2V_MJq2wi=0DTpm+wEvvSX7qnAp+VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/19 10:48 AM, Vincent Guittot wrote:
> On Wed, 23 Jan 2019 at 09:26, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 1/16/19 10:43 AM, Vincent Guittot wrote:
>>
>> [...]
>>
>>> +static inline u64 rq_clock_pelt(struct rq *rq)
>>> +{
>>
>> Doesn't this function need
>>
>>     lockdep_assert_held(&rq->lock);
>>     assert_clock_updated(rq);
> 
> originally, it was replacing cfs_rq_clock_task which doesn't have this
> debugging code.
> But it also replaces rq_clock_task for deadline and rt so it's
> probably worthing adding them for such case

I think so. Moreover, cfs_rq_clock_pelt() uses rq_clock_pelt(). Like 
cfs_rq_clock_task(), which was replaced by cfs_rq_clock_pelt() in 
fair.c, uses rq_clock_task().

>> like rq_clock() and rq_clock_task()? Later to support commit
>> cb42c9a3ebbb "sched/core: Add debugging code to catch missing
>> update_rq_clock() calls".
>>
>>> +     return rq->clock_pelt - rq->lost_idle_time;
>>> +}
>>
>> [...]

