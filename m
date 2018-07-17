Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294ADECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FED2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FED2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbeGQQd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:33:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49042 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729640AbeGQQd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:33:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38D377A9;
        Tue, 17 Jul 2018 09:00:39 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.210.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 779C73F318;
        Tue, 17 Jul 2018 09:00:33 -0700 (PDT)
Subject: Re: [RFC PATCH v4 03/12] PM: Introduce an Energy Model management
 framework
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-4-quentin.perret@arm.com>
 <4341d199-8018-21e1-c2ce-9af8f7719297@arm.com>
 <20180710083202.GD17598@e108498-lin.cambridge.arm.com>
 <20180716102917.GA19311@e108498-lin.cambridge.arm.com>
 <fe73f66d-7bed-f413-eb77-34f3d385dbc7@arm.com>
 <20180717141955.GA4496@e108498-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <6488e9a1-19d4-5d6b-1446-684881618fce@arm.com>
Date:   Tue, 17 Jul 2018 18:00:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717141955.GA4496@e108498-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/17/2018 04:19 PM, Quentin Perret wrote:
> Hi Dietmar,
> 
> On Tuesday 17 Jul 2018 at 10:57:13 (+0200), Dietmar Eggemann wrote:
>> On 07/16/2018 12:29 PM, Quentin Perret wrote:

[...]

> So, I guess you see this overhead because of the extra division involved
> by computing 'cap = max_cap * cs->frequency / max_freq'. However, I
> think there is an opportunity to optimize things a bit and avoid that
> overhead entirely. My suggestion is to remove the 'capacity' field from
> the em_cap_state struct and to add a 'cost' parameter instead:
> 
> struct em_cap_state {
> 	unsigned long frequency;
> 	unsigned long power;
> 	unsigned long cost;
> };
> 
> I define the 'cost' of a capacity state as:
> 
> 	cost = power * max_freq / freq;
> 
> Since 'power', 'max_freq' and 'freq' do not change at run-time (as opposed
> to 'capacity'), this coefficient is static and computed when the table is
> first created. Then, based on this, you can implement em_fd_energy() as
> follows:
> 
> static inline unsigned long em_fd_energy(struct em_freq_domain *fd,
> 				unsigned long max_util, unsigned long sum_util)
> {
> 	unsigned long freq, scale_cpu;
> 	struct em_cap_state *cs;
> 	int i, cpu;
> 
> 	/* Map the utilization value to a frequency */
> 	cpu = cpumask_first(to_cpumask(fd->cpus));
> 	scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
> 	cs = &fd->table[fd->nr_cap_states - 1];
> 	freq = map_util_freq(max_util, cs->frequency, scale_cpu);
> 
> 	/* Find the lowest capacity state above this frequency */
> 	for (i = 0; i < fd->nr_cap_states; i++) {
> 		cs = &fd->table[i];
> 		if (cs->frequency >= freq)
> 			break;
> 	}
> 
> 	/*
> 	 * The capacity of a CPU at a specific performance state is defined as:
> 	 *
> 	 *     cap = freq * scale_cpu / max_freq
> 	 *
> 	 * The energy consumed by this CPU can be estimated as:
> 	 *
> 	 *     nrg = power * util / cap
> 	 *
> 	 * because (util / cap) represents the percentage of busy time of the
> 	 * CPU. Based on those definitions, we have:
> 	 *
> 	 *     nrg = power * util * max_freq / (scale_cpu * freq)
> 	 *
> 	 * which can be re-arranged as a product of two terms:
> 	 *
> 	 *     nrg = (power * max_freq / freq) * (util / scale_cpu)
> 	 *
> 	 * The first term is static, and is stored in the em_cap_state struct
> 	 * as 'cost'. The parameters of the second term change at run-time.
> 	 */
> 	return cs->cost * sum_util / scale_cpu;
> }
> 
> With the above implementation, there is no additional division in
> em_fd_energy() compared to v4, so I would expect to see no significant
> difference in computation time.
> 
> I tried to reproduce your test case and I get the following numbers on
> my Juno r0 (using the performance governor):
> 
> v4:
> ***
>    Function           Hit    Time            Avg             s^2
> A53 - cpu [0,3-5]
>    compute_energy    1796    12685.66 us     7.063 us        0.039 us
>    compute_energy    4214    28060.02 us     6.658 us        0.919 us
>    compute_energy    2743    20167.86 us     7.352 us        0.067 us
>    compute_energy   13958    97122.68 us     6.958 us        9.255 us
> A57 - cpu [1-2]
>    compute_energy      86    448.800 us      5.218 us        0.106 us
>    compute_energy     163    847.600 us      5.200 us        0.128 us
> 
> 
> 'v5' (with 'cost'):
> *******************
>    Function           Hit    Time            Avg             s^2
> A53 - cpu [0,3-5]
>    compute_energy    1695    11153.54 us     6.580 us        0.022 us
>    compute_energy   16823    113709.5 us     6.759 us        27.109 us
>    compute_energy     677    4490.060 us     6.632 us        0.028 us
>    compute_energy    1959    13595.66 us     6.940 us        0.029 us
> A57 - cpu [1-2]
>    compute_energy     211    1089.860 us     5.165 us        0.122 us
>    compute_energy      83    420.860 us      5.070 us        0.075 us
> 
> 
> So I don't observe any obvious regression with my optimization applied.
> The v4 branch I used is the one mentioned in the cover letter:
> http://www.linux-arm.org/git?p=linux-qp.git;a=shortlog;h=refs/heads/upstream/eas_v4

Yeah, just realized that I used the wrong eas_v4 branch. With the one 
you mentioned here I still get ~0.2-0.3us diff with the non-optimized 
approach but at least values in the same ballpark as yours (performance 
governor to keep s^2 low):

v4:

    Function             Hit    Time            Avg             s^2
A53 - cpu [0,3-5]
   compute_energy        233    1455.140 us     6.245 us        0.022 us
...
A57 - cpu [1-2]
   compute_energy        130    602.980 us      4.638 us        0.043 us

v4 + '(naive) calculating capacity on the fly':

   Function              Hit    Time            Avg             s^2
A53 - cpu [0,3-5]
   compute_energy        531    3460.200 us     6.516 us        0.044 us
A57 - cpu [1-2]
   compute_energy        141    700.220 us      4.966 us        0.106 us

> And I just pushed the WiP branch I used to compare against:
> http://www.linux-arm.org/git?p=linux-qp.git;a=shortlog;h=refs/heads/upstream/eas_v5-WiP-compute_energy_profiling
> 
> Is this also fixing the regression on your side ?

I assume with you 'unsigned long cost' optimization I will get the same 
test result than you so I guess that's the optimization which assures 
that we don't have to pay the simplification of the EM with scheduler 
runtime.

[...]

>> IMO, em_rescale_cpu_capacity() is just the capacity related example what the
>> EM needs if its values can be changed at runtime. There might be other use
>> cases in the future like changing power values depending on temperature.
>> So maybe it's a good idea to not have this 'EM values can change at runtime'
>> feature in the first version of the EM and emphasize on simplicity of the
>> code instead (if we can eliminate the extra runtime overhead).
> 
> I agree that it would be nice to keep it simple in the beginning. If
> there is strong and demonstrated use-case for updating the EM at
> run-time later, then we can re-introduce the RCU protection. But until
> then, we can avoid the complex implementation at no obvious cost (given
> my results above) so that sounds like a good trade-off to me :-)

Agreed.

[...]

