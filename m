Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CwoaAYJVGVvZNwAAmS7hNA
	; Thu, 07 Jun 2018 15:55:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E96FA6074D; Thu,  7 Jun 2018 15:55:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 74B1C60590;
	Thu,  7 Jun 2018 15:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 74B1C60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934377AbeFGPzn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:55:43 -0400
Received: from foss.arm.com ([217.140.101.70]:53748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933778AbeFGPzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:55:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7E9E80D;
        Thu,  7 Jun 2018 08:55:38 -0700 (PDT)
Received: from [192.168.0.102] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31BA73F59D;
        Thu,  7 Jun 2018 08:55:34 -0700 (PDT)
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
To: Quentin Perret <quentin.perret@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
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
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <52b9575b-4c2a-01df-fadd-10ccf3146112@arm.com>
Date: Thu, 7 Jun 2018 17:55:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607151954.GA3597@e108498-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 05:19 PM, Quentin Perret wrote:
> Hi Juri,
> 
> On Thursday 07 Jun 2018 at 16:44:09 (+0200), Juri Lelli wrote:
>> On 21/05/18 15:24, Quentin Perret wrote:

[...]

>> Mmm, this gets complicated pretty fast eh? :)
> 
> Yeah, hopefully I'll be able to explain/clarify that :-).
> 
>>
>> I had to go back and forth between patches to start understanding the
>> different data structures and how they are use, and I'm not sure yet
>> I've got the full picture. I guess some nice diagram (cover letter or
>> documentation patch) would help a lot.

+1 on the diagram.

> Right, so I'd like very much to write a nice documentation patch once we
> are more or less OK with the overall design of this framework, but I
> felt like it was a little bit early for that. If we finally decide that
> what I did is totally stupid and that it'd be better to do things
> completely differently, my nice documentation patch would be a lot of
> efforts for nothing.
> 
> But I agree that at the same time all this complex code has to be
> explained. Hopefully the existing comments can help with that.
> Otherwise, I'm more than happy to answer all questions :-)

I'm not sure that the current API is the final one. Not sure that 
em_rescale_cpu_capacity() is really needed.

We should first clarify the provider - consumer relation. Are multiple 
providers allowed, if yes, are they allowed to provide partial EM data? 
Do we really want to allow this overwriting of old EM data 
(em_rescale_cpu_capacity()). In case multiple provider are allowed, is 
there some kind of priority involved?

The re-scaling thing comes from the requirement that the final cpu 
capacity values are only known after the arch_topology driver was able 
to scale the dmipz-capacity-values with the policy->cpuinfo.max_freq but 
why can't we create the EM on arm/arm64 after this? Even though we would 
be forced to get cpufreq's related cpumask from somewhere.

I guess the easiest model will be that the Energy Model (EM) is fully 
initialized with one init call (from the arch) and fixed after that.

In case the EM should not be tight to cpufreq, the interface 
em_create_fd(cpumask_t *span, int nr_states, struct em_data_callback 
*cb) seems ok.

IMHO, part of the problem why this might be harder to understand is the 
fact that the patches show the use of the 2. init call 
'em_rescale_cpu_capacity()' but not the 1. one 
'em_register_freq_domain()'. I guess that Quentin wanted to keep the set 
as small as possible.

[...]
