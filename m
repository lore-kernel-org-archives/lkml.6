Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107E6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C940920880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C940920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbeGWNkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:40:14 -0400
Received: from foss.arm.com ([217.140.101.70]:32952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387883AbeGWNkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:40:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68CA580D;
        Mon, 23 Jul 2018 05:39:12 -0700 (PDT)
Received: from [10.4.12.213] (e112298-lin.emea.arm.com [10.4.12.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B892D3F778;
        Mon, 23 Jul 2018 05:39:10 -0700 (PDT)
Subject: Re: [PATCH v4 00/26] arm64: provide pseudo NMI with GICv3
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
 <20180720150943.i4u2s7wie7falh7p@holly.lan>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <f3b9b0b3-a7ce-fbdc-d249-907763d1edab@arm.com>
Date:   Mon, 23 Jul 2018 13:39:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180720150943.i4u2s7wie7falh7p@holly.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 20/07/18 16:09, Daniel Thompson wrote:
> On Fri, May 25, 2018 at 10:49:06AM +0100, Julien Thierry wrote:
>> This series is a continuation of the work started by Daniel [1]. The goal
>> is to use GICv3 interrupt priorities to simulate an NMI.
>>
>> To achieve this, set two priorities, one for standard interrupts and
>> another, higher priority, for NMIs. Whenever we want to disable interrupts,
>> we mask the standard priority instead so NMIs can still be raised. Some
>> corner cases though still require to actually mask all interrupts
>> effectively disabling the NMI.
>>
>> Currently, only PPIs and SPIs can be set as NMIs. IPIs being currently
>> hardcoded IRQ numbers, there isn't a generic interface to set SGIs as NMI
>> for now. I don't think there is any reason LPIs should be allowed to be set
>> as NMI as they do not have an active state.
>> When an NMI is active on a CPU, no other NMI can be triggered on the CPU.
>>
>> After the big refactoring I get performances similar to the ones I had
>> in v3[2], reposting old results here:
>>
>> - "hackbench 200 process 1000" (average over 20 runs)
>> +-----------+----------+------------+------------------+
>> |           | native   | PMR guest  | v4.17-rc6 guest  |
>> +-----------+----------+------------+------------------+
>> | PMR host  | 40.0336s |   39.3039s |         39.2044s |
>> | v4.17-rc6 | 40.4040s |   39.6011s |         39.1147s |
>> +-----------+----------+------------+------------------+
>>
>> - Kernel build from defconfig:
>> PMR host:  13m45.743s
>> v4.17-rc6: 13m40.400s
>>
>> I'll try to post more detailed benchmarks later if I find notable
>> differences with the previous version.
> 
> So... I'm rather late sharing these benchmarks but...
> 
> I ran some kernel build benchmarks on the Developerbox from 96Boards
> (aka Synquacer E-series by Socionext): 24 C-A53 cores running at 1GHz.
> This is obviously a real workload and one that anything called
> Developerbox needs to care about!
> 
> The difference in performance is slight but PMR based locking is
> marginally slower than using the I-bit. It varies with the
> parrallel-ness of the build slightly but the slowdown on this platform
> is between 0.2% and 0.6% [1].
> 
> This delta was sufficiently small that I was willing to leave the PMR
> masking in place for a fair amount of my day to day work. On that basis
> these patches could also be described as:
> 
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
> 

Thanks very much for doing this testing. Things have changed a bit in 
the NMI side of the series and I am trying to get a saner API to get 
upstreamed before posting a new version of these patches. But the PMR 
masking/unmasking remains the same so the benchmarks should still be 
valid in the future version.

Thanks,

> 
> Daniel.
> 
> 
> [1] For anyone interested in the raw numbers then the spreadsheet where
>      I checked the results is here:
> https://docs.google.com/spreadsheets/d/1gGxAJd_gL-HjeTF-x0Ut5lWT4JULNRDeTbPvPInZ4H4/edit?usp=sharing
> 

-- 
Julien Thierry
