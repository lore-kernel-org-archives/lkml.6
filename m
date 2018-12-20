Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED24C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9880B218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbeLTRYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:24:04 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60754 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730172AbeLTRYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:24:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A36B80D;
        Thu, 20 Dec 2018 09:24:03 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51EE23F575;
        Thu, 20 Dec 2018 09:24:02 -0800 (PST)
Subject: Re: [PATCH 3/3] sched/fair: fix unnecessary increase of balance
 interval
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
References: <1545292547-18770-1-git-send-email-vincent.guittot@linaro.org>
 <1545292547-18770-4-git-send-email-vincent.guittot@linaro.org>
 <c482361e-cfb4-d172-32c3-4d82ceb1e7d2@arm.com>
 <CAKfTPtCQTMs=6yGbrfuUGyhwPHWvMODcyyDROVjbURHFxLTxCQ@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d87cba1f-fa5c-3d82-ec7f-f2c72d40cb30@arm.com>
Date:   Thu, 20 Dec 2018 17:24:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCQTMs=6yGbrfuUGyhwPHWvMODcyyDROVjbURHFxLTxCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2018 14:50, Vincent Guittot wrote:
[...]
>> So now  we reset the interval for all active balances (expect last active
>> balance case), even when it is done as a last resort because all other
>> tasks were pinned.
>>
>> Arguably the current code isn't much better (always increase the interval
>> when active balancing), but at least it covers this case. It would be a
>> waste not to take this into account when we can detect this scenario
> 
> So i'd like to remind the $subject of this patchset: fix some known
> issues for asym_packing.
> While looking at this, we have added few other voluntary active
> balances because it was "obvious" that this active migration were
> voluntary one. But in fact, we don't have any UC which show a problem
> for those additional UC so far.
> 
> The default behavior for active migration is to increase the interval
> Now you want to extend the exception to others active migration UC
> whereas it's not clear that we don't fall in the default active
> migration UC and we should not increase the interval.
 
Well if we stick to the rule of only increasing balance_interval when
pinned tasks get in the way, it's clear to me that this use case shouldn't
be segregated from the others.

I do agree however that it's not entirely clear if that balance_interval
increase was also intended to slow down the nr_balance_failed migrations.

I had a look at the history and stumbled on:

	8102679447da ("[PATCH] sched: improve load balancing pinned tasks")

Which explains the reasoning behind the active_balance balance_interval
increase:

	"""
	this one attempts to work out whether the balancing failure has
	been due to too many tasks pinned on the runqueue.  This allows it
	to be basically invisible to the regular blancing paths (ie. when
	there are no pinned tasks).
	"""

So AFAICT that is indeed the rule we should be following, and I would only
increase the balance_interval when there are pinned tasks, not because
of active_balance categories. So here it's a matter of fixing that
condition into what it was meant to be doing.

> What you want is changing the behavior of the scheduler for UC that
> haven't raised any problem where asym_packing has known problem/
> 
> Changing default behavior for active migration is not subject of this
> patchset and should be treated in another one like the one discussed
> with peter few days ago
> >> (I'll reiterate my LBF_ALL_PINNED suggestion).
>>
>>>               /* We were unbalanced, so reset the balancing interval */
>>>               sd->balance_interval = sd->min_interval;
>>>       } else {
>>>
