Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B8EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB90220843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB90220843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeIZT3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:29:05 -0400
Received: from foss.arm.com ([217.140.101.70]:45864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbeIZT3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:29:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 364827A9;
        Wed, 26 Sep 2018 06:16:10 -0700 (PDT)
Received: from [10.4.12.39] (e113632-lin.emea.arm.com [10.4.12.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24C303F5D3;
        Wed, 26 Sep 2018 06:16:09 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Don't increase sd->balance_interval on
 newidle balance
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>
References: <1537896922-8508-1-git-send-email-valentin.schneider@arm.com>
 <CAKfTPtB-UiXx39XZeJ0FNeYOU-pLFbY1u7vgbo584MNHSnpr=w@mail.gmail.com>
 <9209a9ec-72b4-17d7-6596-71b55767a9aa@arm.com>
 <CAKfTPtAUUcwPThggDMfQ1k7z4kguTwrLVEFKnkMqszs9nTri=g@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <c80b5d26-ad8b-3b13-d317-8db7ec59aee0@arm.com>
Date:   Wed, 26 Sep 2018 14:16:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAUUcwPThggDMfQ1k7z4kguTwrLVEFKnkMqszs9nTri=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/18 11:33, Vincent Guittot wrote:
> On Wed, 26 Sep 2018 at 11:35, Valentin Schneider
> [...]
>>> Can you give us details about the use case that you care about ?
>>>
>>
>> It's the same as I presented last week - devlib (some python target communication
> 
> ok. you mean at linaro connect
> 

Yeah, sorry.

>> library I use) has some phase where it spawns at lot of tasks at once to do
>> some setup (busybox, shutils, bash...). Some of those tasks are pinned to a
>> particular CPU, and that can lead to failed load_balance() - and to make things
>> worse, there's a lot of idle_balance() in there.
>>
>> Eventually when I start running my actual workload a few ~100ms later, it's
>> impacted by that balance_interval increase.
>>
>> Admittedly that's a specific use-case, but I don't think this quick increase
>> is something that was intended.
> 
> Yes, this really sounds like a specific use-case. Unluckily you find a
> way to reach max interval quite easily/every time with your test
> set-up but keep in mind that this can also happen in real system life
> and without using the newly idle path.
> So if it's a problem to have a interval at max value for your unitary
> test, it probably means that it's a problem for the system and the max
> value is too high
> 

Limiting the max value for those tests is actually a good point, and I think
I'll give it a shot. However...

> Taking advantage of all load_balance event to update the interval
> makes sense to me. It seems that you care about a short and regular
> balance interval more that minimizing overhead of load balancing.
> At the opposite, i'm sure that you don't complain if newly idle load
> balance resets the interval to min value and overwrite what the
> periodic load balance set up previously :-)
> 

...My concern is more about increasing balance_interval faster than we should.
The proposed "fix" is to prevent any balance_interval increase when going
through idle_balance(), but Patrick (added in cc) suggested offline that
we could simply limit the rate at which we do these increases, so that they
match what we do in rebalance_domains().

We'd still increase balance_interval on failed newidle load_balance(), but
we wouldn't increase from min to max in e.g. 50ms. Would that work better
for you?

>> [...]
