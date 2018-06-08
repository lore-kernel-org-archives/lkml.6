Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ILUuIn92GltUYQAAmS7hNA
	; Fri, 08 Jun 2018 12:39:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A54D6608BA; Fri,  8 Jun 2018 12:39:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1B43B607A4;
	Fri,  8 Jun 2018 12:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B43B607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeFHMjn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:39:43 -0400
Received: from foss.arm.com ([217.140.101.70]:33338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751251AbeFHMjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:39:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECF911529;
        Fri,  8 Jun 2018 05:39:40 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.210.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95A453F557;
        Fri,  8 Jun 2018 05:39:35 -0700 (PDT)
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
To: Quentin Perret <quentin.perret@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org,
        rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180607144409.GB3311@localhost.localdomain>
 <20180607151954.GA3597@e108498-lin.cambridge.arm.com>
 <52b9575b-4c2a-01df-fadd-10ccf3146112@arm.com>
 <20180608082511.GE3597@e108498-lin.cambridge.arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <5a7b8177-7cbe-df90-7d00-8aad0a0f5f08@arm.com>
Date: Fri, 8 Jun 2018 14:39:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608082511.GE3597@e108498-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 10:25 AM, Quentin Perret wrote:
> Hi Dietmar,
> 
> On Thursday 07 Jun 2018 at 17:55:32 (+0200), Dietmar Eggemann wrote:
>> On 06/07/2018 05:19 PM, Quentin Perret wrote:
>>> Hi Juri,
>>>
>>> On Thursday 07 Jun 2018 at 16:44:09 (+0200), Juri Lelli wrote:
>>>> On 21/05/18 15:24, Quentin Perret wrote:

[...]

> The comment above em_register_freq_domain() explains that, at least
> partially. In the current implementation, if multiple providers register
> the same frequency domain, all but the first will be ignored. The reason
> I implemented this that way is because: 1) it's simple; 2) it should
> cover the current use-cases for EAS and IPA.
> 
> But we could do something more clever. We could add a parameter to
> em_register_freq_domain() that would represent some sort of priority. In
> this case, if multiple providers register the same freq domain, the
> higher priority would override the lower priority. For example, power
> values coming from firmware could overwrite power values estimated with
> P=CV^2f for example.

In your current '(3)* Arm/Arm64 init code' (* see at the end of this 
email) you have this dev_pm_opp_of_estimate_power() em_data_callback 
active_power function.

Let's say thermal and the task scheduler would initialize the EM 
independently. They would still end up using C from dt, and f, V and P 
from opp library in your example.

IMHO, this information should be only provided once from one source per 
platform.

>> The re-scaling thing comes from the requirement that the final cpu capacity
>> values are only known after the arch_topology driver was able to scale the
>> dmipz-capacity-values with the policy->cpuinfo.max_freq but why can't we
>> create the EM on arm/arm64 after this?
> 
> What if you don't have dmips-capacity-mhz values in the DT and still
> want to use IPA ? There is no good reason to create a dependency between
> the thermal subsystem and the arch_topology driver IMO.

Mmmmh, that's correct. So it can't be simply called in 
init_cpu_capacity_callback() [drivers/base/arch_topology.c] in case the 
cpus_to_visit mask is empty. There is this dependency that cpufreq can 
be loaded at any time, requiring this re-scaling of capacity values ... 
That's not nice ...

>> Even though we would be forced to get cpufreq's related cpumask from
>> somewhere.
> 
> That's the easy part. The difficult part is, where do you get power
> values from ? You have to let the lower layers register those values
> in a centralized location on a voluntary basis. And then it becomes easy
> for consumers to access that data, because they know where it is.

The code in the arch could use the same struct em_data_callback em_cb = 
{ &dev_pm_opp_of_estimate_power } that the cpufreq driver is currently 
using?

>> I guess the easiest model will be that the Energy Model (EM) is fully
>> initialized with one init call (from the arch) and fixed after that.
> 
> Again, I don't think that's possible. You have to let the lower layers
> tell you where the power values come from, at the very least. You could
> let the archs do that aggregation I suppose, but I don't really see the
> benefit over one centralized framework with a generic interface ...
> What's your opinion ?

Don't understand the '... let the lower layers tell you where the power 
values come from ...' part. Where is the difference whether the arch or 
the cpufreq driver uses em_data_callback?

[...]

> So I think I'll drop patch 10/10 for v4 ... That part should be
> discussed separately, with the rest of the Arm-specific changes.

Maybe 3 clearly separated parts of the patch-set; (1) EM (2) EAS uses EM 
(3) Arm/Arm64 init code ?

[...]
