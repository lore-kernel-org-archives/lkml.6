Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CEEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240332082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240332082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeLCNrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:47:20 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37694 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbeLCNrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:47:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A9F51682;
        Mon,  3 Dec 2018 05:46:15 -0800 (PST)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2560A3F614;
        Mon,  3 Dec 2018 05:46:10 -0800 (PST)
Subject: Re: [PATCH V5 2/2] base/drivers/arch_topology: Default dmips-mhz if
 they are not set in DT
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, viresh.kumar@linaro.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Olof Johansson <olof@lixom.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Russell King <linux@armlinux.org.uk>
References: <1543325060-1599-1-git-send-email-daniel.lezcano@linaro.org>
 <1543325060-1599-2-git-send-email-daniel.lezcano@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <2b050e93-f734-f2f3-ac67-a30d37bf1950@arm.com>
Date:   Mon, 3 Dec 2018 14:46:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543325060-1599-2-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

+cc: Russell King <linux@armlinux.org.uk>

On 11/27/18 2:24 PM, Daniel Lezcano wrote:
> In the case of asymmetric SoC with the same micro-architecture, we
> have a group of CPUs with smaller OPPs than the other group. One
> example is the 96boards dragonboard 820c. There is no dmips/MHz
> difference between both groups, so no need to specify the values in
> the DT. Unfortunately, without these defined, there is no scaling
> capacity computation triggered, so we need to write
> 'capacity-dmips-mhz' for each CPU with the same value in order to
> force the scaled capacity computation.
> 
> In order to fix this situation, allocate 'raw_capacity' so the pointer
> is set and the init_cpu_capacity_callback() function can be called.
> 
> This was tested on db820c:
>   - specified values in the DT (correct results)
>   - partial values defined in the DT (error + fallback to defaults)
>   - no specified values in the DT (correct results)
> 
> correct results are:
>    cat /sys/devices/system/cpu/cpu*/cpu_capacity
>     758
>     758
>    1024
>    1024
> 
>    ... respectively for CPU0, CPU1, CPU2 and CPU3.
> 
> That reflects the capacity for the max frequencies 1593600 and 2150400.

[...]

I'm afraid that this change is incompatible with the still existing 
cpu_efficiency interface we have in Arm32 for A15/A7 systems like Arm TC2:

In case you specify clock-frequency dt properties per cpu for such a 
system, the cpu_capacity values are determined via the cpu_efficiency 
code in arch/arm/kernel/topology.c.

So on Arm TC2 with clock-frequency = <1000000000> [A15] and <800000000> 
[A7] you get:

root@linaro-nano:~# cat /sys/devices/system/cpu/cpu*/cpu_capacity
606
1441
1441
606
606

With your patches on top (cpu_capacity functionality in 
drivers/base/arch_topology.c does not have to be switched on by 
specifying capacity-dmips-mhz dt properties anymore) we end up scaling 
by max frequency again:

root@linaro-nano:~# cat /sys/devices/system/cpu/cpu*/cpu_capacity
358
1024
1024
358
358

I tried to remove the cpu_efficiency based API a year ago but Russell 
pointed out that the compatibility has to be maintained for longer:

https://lore.kernel.org/lkml/20171024102718.16113-1-dietmar.eggemann@arm.com/

I assume that the capacity-dmips-mhz dt property is like a switch to 
turn this functionality on for big.Little and so called gold/silver 
platforms, which have cores with the same uArch but in frequency domains 
with different max frequency values.

So what's wrong with specifying capacity-dmips-mhz = <1024> for all 
cores for those gold/silver platforms? I don't expect that there will be 
so many of them. And normal SMP platforms (w/o frequency domains w/o 
different max frequency values) don't have to execute this code.

IMHO, at least we should remove the cpu_efficiency bits before we do 
this change.

[...]
