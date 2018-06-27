Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AC0C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9935924194
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9935924194
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754870AbeF0Pl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:41:29 -0400
Received: from foss.arm.com ([217.140.101.70]:33550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752937AbeF0Pl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:41:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87BFBED1;
        Wed, 27 Jun 2018 08:41:26 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.210.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B445A3F266;
        Wed, 27 Jun 2018 08:41:24 -0700 (PDT)
Subject: Re: [PATCHv3 1/9] sched: Add static_key for asymmetric cpu capacity
 optimizations
To:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org
References: <1529485549-5191-1-git-send-email-morten.rasmussen@arm.com>
 <1529485549-5191-2-git-send-email-morten.rasmussen@arm.com>
 <20180622082222.GD23168@e108498-lin.cambridge.arm.com>
 <20180622143624.GD8461@e105550-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4208ea5d-0c00-d17a-5524-b5d9caa70273@arm.com>
Date:   Wed, 27 Jun 2018 17:41:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622143624.GD8461@e105550-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/2018 04:36 PM, Morten Rasmussen wrote:
> On Fri, Jun 22, 2018 at 09:22:22AM +0100, Quentin Perret wrote:
>> Hi Morten,
>>
>> On Wednesday 20 Jun 2018 at 10:05:41 (+0100), Morten Rasmussen wrote:
>>> +static void update_asym_cpucapacity(int cpu)
>>> +{
>>> +	int enable = false;
>>> +
>>> +	rcu_read_lock();
>>> +	if (lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY))
>>> +		enable = true;
>>> +	rcu_read_unlock();
>>> +
>>> +	if (enable) {
>>> +		/* This expects to be hotplug-safe */
>>> +		static_branch_enable_cpuslocked(&sched_asym_cpucapacity);
>>> +	}
>>> +}
>>
>> What would happen if you hotplugged an entire cluster ? You'd loose the
>> SD_ASYM_CPUCAPACITY flag but keep the static key is that right ? Should
>> we care ?
> 
> I don't think we should care. The static key enables additional checks
> and tweaks but AFAICT none of them requires the SD_ASYM_CPUCAPACITY to
> be set and they should all be have no effect if that is the case. I
> added the static key just avoid the overhead on systems where they would
> have no effect. At least that is intention, I could course have broken
> things by mistake.

I tent to agree for misfit but it would be easy to just add an 
static_branch_disable_cpuslocked() into the else path of if(enable).

>> And also, Peter mentioned an issue with the EAS patches with multiple
>> root_domains. Does that apply here as well ? What if you had a
>> configuration with big and little CPUs in different root_domains for ex?
>>
>> Should we disable the static key in the above cases ?
> 
> Exclusive cpusets are more tricky as the flags will be the same for
> sched_domains at the same level. So we can't set the flag correctly if
> someone configures the exclusive cpusets such that you have one
> root_domain spanning big and a subset of little, and one spanning the
> remaining little cpus if all topology levels are preserved. If we
> imagine a three cluster system where 0-3 and 4-7 little clusters, and
> 8-11 is a big cluster with cpusets configured as 0-5 and 6-11. The first
> set should _not_ have SD_ASYM_CPUCAPACITY set, while the second should.
> 
> I'm tempted to say we shouldn't care in this situation. Setting the
> flags correctly in the three cluster example would require knowledge
> about the cpuset configuration which we don't have in the arch code so
> SD_ASYM_CPUCAPACITY flag detection would have be done by the
> sched_domain build code. However, not setting the flag according to the
> actual members of the exclusive cpuset means that homogeneous
> sched_domains might have SD_ASYM_CPUCAPACITY set enabling potentially
> wrong scheduling decisions.

We could easily pass the CPU as an argument to all these 
sched_domain_flags_f functions.

-typedef int (*sched_domain_flags_f)(void);
+typedef int (*sched_domain_flags_f)(int cpu);

In this case, the arch specific flag functions on a sched domain (sd) 
level could use the corresponding sched_domain_mask_f function to 
iterate over the span of the sd seen by CPU instead of all online cpus.

The overall question is ... do we need sd setups which are asymmetric 
(different topology flags for sd hierarchies seen by different CPUs) and 
does the scheduler cope with this?

We have seen 3 cluster systems like the MediaTek X20 (2 A72, 4 A53 (max 
1.85Ghz), 4 A53 (max 1.4Ghz)) but this would rather be a big-little-tiny 
system due to the max CPU frequency differences between the A53's.

We could also say that systems with 2 clusters with the same uArch and 
same max CPU frequency and additional clusters are insane, like we e.g. 
do with the Energy Model and CPUs with different uArch within a 
frequency domain?

> We can actually end up with this problem just by hotplugging too. If you
> unplug the entire big cluster in the three cluster example above, you
> preserve DIE level which would have SD_ASYM_CPUCAPACITY set even though
> we only have little cpus left.
> 
> As I see it, we have two choices: 1) Set the flags correctly for
> exclusive cpusets which means some additional "fun" in the sched_domain
> hierarchy set up, or 2) ignore it and make sure that setting

I assume you refer to this cpu parameter for sched_domain_flags_f under 1).

> SD_ASYM_CPUCAPACITY on homogeneous sched_domains works fairly okay. The
> latter seems easier.
> 
> Morten
> 

