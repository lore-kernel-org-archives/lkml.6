Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B46C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F230F2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F230F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeIFKkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:40:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39046 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbeIFKkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:40:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF2C17A9;
        Wed,  5 Sep 2018 23:06:52 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.Emea.Arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C0643F557;
        Wed,  5 Sep 2018 23:06:42 -0700 (PDT)
Subject: Re: [PATCH v6 07/14] sched/topology: Introduce sched_energy_present
 static key
To:     Quentin Perret <quentin.perret@arm.com>, peterz@infradead.org,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-8-quentin.perret@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f206f192-1bbf-f868-c8c6-8215334639db@arm.com>
Date:   Wed, 5 Sep 2018 23:06:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180820094420.26590-8-quentin.perret@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/2018 02:44 AM, Quentin Perret wrote:
> In order to ensure a minimal performance impact on non-energy-aware
> systems, introduce a static_key guarding the access to Energy-Aware
> Scheduling (EAS) code.
> 
> The static key is set iff all the following conditions are met for at
> least one root domain:
>    1. all online CPUs of the root domain are covered by the Energy
>       Model (EM);
>    2. the complexity of the root domain's EM is low enough to keep
>       scheduling overheads low;
>    3. the root domain has an asymmetric CPU capacity topology (detected
>       by looking for the SD_ASYM_CPUCAPACITY flag in the sched_domain
>       hierarchy).

This is pretty much the list (+ is schedutil running) of conditions to 
set rd->pd != NULL in build_perf_domains().

So when testing 'static_branch_unlikely(&sched_energy_present) && 
rcu_dereference(rd->pd)' don't you test two times the same thing?

Also, if let's say somebody wants to run another EM user (e.g. a thermal 
governor, like IPA) but not EAS on a asymmetric CPU capacity system. 
This can't be achieved with the current static branch approach

So what about using a (disabled by default ?) sched_feature + rd->pd != 
NULL instead?

[...]
