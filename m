Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506B7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8AE20643
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbeLSPaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:30:09 -0500
Received: from foss.arm.com ([217.140.101.70]:37348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbeLSPaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:30:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 691BEEBD;
        Wed, 19 Dec 2018 07:30:08 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 786EB3F675;
        Wed, 19 Dec 2018 07:30:07 -0800 (PST)
Subject: Re: [PATCH v2 1/3] sched/fair: fix rounding issue for asym packing
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-2-git-send-email-vincent.guittot@linaro.org>
 <f2619d92-7367-abd4-97e8-e0f4e7cc96eb@arm.com>
 <CAKfTPtAEi=EBmSUEcYmkfSZVkBviQaJaqZXvt-=XbsgZs5t_OA@mail.gmail.com>
 <4de22c37-fe65-4f5f-929b-320c663ee8b6@arm.com>
 <CAKfTPtAprHq4YYdJ1gnuoAcNiVFpFPnxYv_=RS6pXs8aYpjcuA@mail.gmail.com>
 <8ea1a96c-c2e0-cc3f-1cec-444706383e77@arm.com>
 <CAKfTPtCVqSYOC_GUdBm8_5KNMNEwXdf77mXL4SDB4_G5_iE0iA@mail.gmail.com>
 <f48118ab-8782-a096-9299-58c6b8d384bb@arm.com>
 <CAKfTPtDwUqf1tKxOkJ-rU2FHUL63=smEtCRu5dqwYZC7zjvtJw@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <913b1033-cc8e-d109-6096-c3a73ec0c87c@arm.com>
Date:   Wed, 19 Dec 2018 15:30:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDwUqf1tKxOkJ-rU2FHUL63=smEtCRu5dqwYZC7zjvtJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2018 15:20, Vincent Guittot wrote:
[...]
>> Oh yes, I never said it didn't work - I was doing some investigation on
>> the reason as to why we'd need this fix, because it's wasn't explicit from
>> the commit message.
>>
>> The rounding errors are countered by the +1, yes, but I'd rather remove
>> the errors altogether and go for the snippet I suggested in my previous
>> reply.
> 
> except that you don't always want to migrate all group load.
> I prefer keeping current algorithm and fix it for now. Trying "new"
> thing can come in a 2nd step

We already set the imbalance as the whole group load, we just introduce
rounding errors inbetween. As I've already said:

in update_sg_lb_stats() we do:

        sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;

and in check_asym_packing() we do:

        env->imbalance = DIV_ROUND_CLOSEST(
                sds->busiest_stat.avg_load * sds->busiest_stat.group_capacity,
                SCHED_CAPACITY_SCALE)

So we end up with something like:

                    group_load * SCHED_CAPACITY_SCALE * group_capacity
        imbalance = --------------------------------------------------
                            group_capacity * SCHED_CAPACITY_SCALE

Which we could reduce down to:

        imbalance = group_load

and not get any rounding errors.
