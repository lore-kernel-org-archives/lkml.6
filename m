Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D755ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82C4206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82C4206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbeGQJ2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:28:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42574 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbeGQJ2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:28:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31ECB7A9;
        Tue, 17 Jul 2018 01:57:21 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.210.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF85E3F589;
        Tue, 17 Jul 2018 01:57:15 -0700 (PDT)
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <fe73f66d-7bed-f413-eb77-34f3d385dbc7@arm.com>
Date:   Tue, 17 Jul 2018 10:57:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180716102917.GA19311@e108498-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16/2018 12:29 PM, Quentin Perret wrote:
> On Tuesday 10 Jul 2018 at 09:32:02 (+0100), Quentin Perret wrote:

[...]

> Another thing to take into consideration here is basically that the
> thermal subsystem (IPA) will be impacted by the RCU protection on the
> cs_table. However, since the 'frequency' and 'power' fields do not change
> at run-time, and since IPA doesn't need the 'capacity' value, there is no
> good reason to have IPA do rcu_read_lock() all over the place, so
> arguably something needs to be fixed here.
> 
> One possibility is to remove entirely the following struct:
> 	struct em_cap_state {
> 		unsigned long capacity;
> 		unsigned long frequency; /* Kilo-hertz */
> 		unsigned long power; /* Milli-watts */
> 	};
> 
> and to have three independent vectors (of the same size) for frequency,
> power and capacity. That way only the 'capacity' vector would be RCU
> protected, and IPA could use 'frequency' and 'power' directly, without
> further protections.
> 
> A second possibility is to remove the capacity values from the EM
> altogether (as I suggested in my previous message) and to get rid of the
> need for RCU protection at the same occasion.

I see an impact of 'calculating capacity on the fly' in 
compute_energy()->em_fd_energy(). Running the first energy test case (# 
task equal 10) on the Juno r0 board with function profiling gives me:

v4:

   Function              Hit    Time            Avg             s^2
A53 - cpu [0,3-5]
   compute_energy      14620    30790.86 us     2.106 us        8.421 us
   compute_energy        682    1512.960 us     2.218 us        0.154 us
   compute_energy       1207    2627.820 us     2.177 us        0.172 us
   compute_energy         93    206.720 us      2.222 us        0.151 us
A57 - cpu [1-2]
   compute_energy        153    160.100 us      1.046 us        0.190 us
   compute_energy        136    130.760 us      0.961 us        0.077 us


v4 + 'calculating capacity on the fly':

   Function              Hit    Time            Avg             s^2
A53 - cpu [0,3-5]
   compute_energy      11623    26941.12 us     2.317 us        12.203 us
   compute_energy       5062    11771.48 us     2.325 us        0.819 us
   compute_energy       4391    10396.78 us     2.367 us        1.753 us
   compute_energy       2234    5265.640 us     2.357 us        0.955 us
A57 - cpu [1-2]
   compute_energy         59    66.020 us       1.118 us        0.112 us
   compute_energy        229    234.880 us      1.025 us        0.135 us

The code is not optimized, I just replaced cs->capacity with 
arch_scale_cpu_capacity(NULL, cpu) (max_cap) and 'max_cap * 
cs->frequency / max_freq' respectively.
There are 3 compute_energy() calls per wake-up on a system with 2 
frequency domains.

> The second option simplifies the code of the EM framework significantly
> (no more em_rescale_cpu_capacity()) and shouldn't introduce massive
> overheads on the scheduler side (the energy calculation already
> requires one multiplication and one division, so nothing new on that
> side). At the same time, that would make it a whole lot easier to
> interface the EM framework with IPA without having to deal with RCU all
> over the place.

IMO, em_rescale_cpu_capacity() is just the capacity related example what 
the EM needs if its values can be changed at runtime. There might be 
other use cases in the future like changing power values depending on 
temperature.
So maybe it's a good idea to not have this 'EM values can change at 
runtime' feature in the first version of the EM and emphasize on 
simplicity of the code instead (if we can eliminate the extra runtime 
overhead).

[...]
