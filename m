Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE39C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB69E240B0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB69E240B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753894AbeGEO7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:59:11 -0400
Received: from foss.arm.com ([217.140.101.70]:51444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753614AbeGEO7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:59:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D2CA18A;
        Thu,  5 Jul 2018 07:59:10 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.210.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C66413F5BA;
        Thu,  5 Jul 2018 07:59:06 -0700 (PDT)
Subject: Re: [lkp-robot] [sched/fair] fbd5188493:
 WARNING:inconsistent_lock_state
To:     Matt Fleming <matt@codeblueprint.co.uk>
Cc:     kernel test robot <xiaolong.ye@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>, lkp@01.org
References: <20180705080227.GH23907@yexl-desktop>
 <0ac4845e-cf6b-c5e3-a16c-f2fc457c5ef5@arm.com>
 <7c3d20fa-4997-e6ed-3750-e054ce1bd610@arm.com>
 <20180705132458.GA3864@codeblueprint.co.uk>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <42d319f5-1a3a-fb69-5ec5-d2e9836e49c9@arm.com>
Date:   Thu, 5 Jul 2018 16:59:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180705132458.GA3864@codeblueprint.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 03:24 PM, Matt Fleming wrote:
> On Thu, 05 Jul, at 11:52:21AM, Dietmar Eggemann wrote:
>>
>> Moving the code from _nohz_idle_balance to nohz_idle_balance let it disappear:
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 02be51c9dcc1..070924f07c68 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9596,16 +9596,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>>           */
>>          smp_mb();
>>   
>> -       /*
>> -        * Ensure this_rq's clock and load are up-to-date before we
>> -        * rebalance since it's possible that they haven't been
>> -        * updated for multiple schedule periods, i.e. many seconds.
>> -        */
>> -       raw_spin_lock_irq(&this_rq->lock);
>> -       update_rq_clock(this_rq);
>> -       cpu_load_update_idle(this_rq);
>> -       raw_spin_unlock_irq(&this_rq->lock);
>> -
>>          for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
>>                  if (balance_cpu == this_cpu || !idle_cpu(balance_cpu))
>>                          continue;
>> @@ -9701,6 +9691,16 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>>          if (!(flags & NOHZ_KICK_MASK))
>>                  return false;
>>   
>> +       /*
>> +        * Ensure this_rq's clock and load are up-to-date before we
>> +        * rebalance since it's possible that they haven't been
>> +        * updated for multiple schedule periods, i.e. many seconds.
>> +        */
>> +       raw_spin_lock_irq(&this_rq->lock);
>> +       update_rq_clock(this_rq);
>> +       cpu_load_update_idle(this_rq);
>> +       raw_spin_unlock_irq(&this_rq->lock);
>> +
>>          _nohz_idle_balance(this_rq, flags, idle);
>>   
>>          return true;
>>
> 
> Hmm.. it still looks to me like we should be saving and restoring IRQs
> since this can be called from IRQ context, no?

You mean in nohz_idle_balance()? Yes.

I just wanted to hint that since you need this cpu_load_update_idle() in 
the nohz idle balance case and not in idle balance, you could just 
update it in nohz_idle_balance() rather than in _nohz_idle_balance() 
(which is also called in nohz_newidle_balance()) avoiding this 
inconsistent lock state warning.

[...]
