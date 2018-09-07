Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E36C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D2E2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D2E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeIGEw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 00:52:58 -0400
Received: from foss.arm.com ([217.140.101.70]:52460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbeIGEw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 00:52:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 461B07A9;
        Thu,  6 Sep 2018 17:14:58 -0700 (PDT)
Received: from [10.103.100.29] (unknown [10.103.100.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0D7F3F557;
        Thu,  6 Sep 2018 17:14:57 -0700 (PDT)
Subject: Re: [PATCH v6 04/14] PM / EM: Expose the Energy Model in sysfs
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
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
 <20180820094420.26590-5-quentin.perret@arm.com>
 <c012c934-d861-eba6-0c67-63e8308ae37b@arm.com>
 <20180906140914.noe3yz7xrb4g5sf4@queper01-lin>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <fe196eda-5e97-b115-0c24-b484428d2ac2@arm.com>
Date:   Thu, 6 Sep 2018 17:14:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906140914.noe3yz7xrb4g5sf4@queper01-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2018 07:09 AM, Quentin Perret wrote:
> Hi Dietmar,
> 
> On Wednesday 05 Sep 2018 at 23:56:43 (-0700), Dietmar Eggemann wrote:
>> On 08/20/2018 02:44 AM, Quentin Perret wrote:
>>> Expose the Energy Model (read-only) of all performance domains in sysfs
>>> for convenience. To do so, add a kobject to the CPU subsystem under the
>>> umbrella of which a kobject for each performance domain is attached.
>>>
>>> The resulting hierarchy is as follows for a platform with two
>>> performance domains for example:
>>>
>>>      /sys/devices/system/cpu/energy_model
>>>      ├── pd0
>>>      │   ├── cost
>>>      │   ├── cpus
>>>      │   ├── frequency
>>>      │   └── power
>>
>> cpus (cpumask of the perf domain), frequency (OPP's of the perf domain) and
>> power (values at those OPP's) are somehow easy to grasp, cost is definitely
>> not.
>>
>> You have this nice description in em_pd_energy() what cost actually is.
>> IMHO, might be worth repeating this at least in the patch header here.
> 
> Hmm, this patch introduces the sysfs interface, not the 'cost' field
> itself. As long as 'cost' is documented in the patch that introduces it
> we should be good no ? I mean this patch header tells you _where_ the
> fields of the structure are exposed. _What_ the structure is all about
> is a different story.

Mmmh, so maybe a EAS related documentation file explaining this 
interface as well, which can be introduced later is the solution here?

I'm just not 100% convinced that those cost values are self-explanatory 
like the other three items:

root@h960:~# ls /sys/devices/system/cpu/energy_model/pd0/
cost
cpus
frequency
power

root@h960:~# cat /sys/devices/system/cpu/energy_model/pd0/*
96 129 163 201 245
0-3
533000 999000 1402000 1709000 1844000
28 70 124 187 245

> But yeah, in any case, a reminder shouldn't hurt I guess, if you really
> want one :-)

Nothing which should hold this patch-set back though.
