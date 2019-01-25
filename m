Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACD1C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99278218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfAYP4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:56:46 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49628 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfAYP4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:56:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDD77A78;
        Fri, 25 Jan 2019 07:56:45 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 813253F5AF;
        Fri, 25 Jan 2019 07:56:43 -0800 (PST)
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
To:     Pramod Kumar <pramod.kumar@broadcom.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Steve Capper <steve.capper@arm.com>
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin>
 <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
 <CAJ+tv6KqynSf5t_VwLqpdM4BF+wLWcJ0wPTD4nWqL4ej1Yih4g@mail.gmail.com>
 <20190123164801.GA55887@lakrids.cambridge.arm.com>
 <f1851a76-8078-b8e7-6a54-b038b47f9214@broadcom.com>
 <20190123173343.GC55887@lakrids.cambridge.arm.com>
 <CAJ+tv6+Mm8Rmsx8cfOuDT4+CVWVd4gKLzUnTs_EMxKYax+NScw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <28d43f76-12ac-662b-31ad-942c9d7e81ea@arm.com>
Date:   Fri, 25 Jan 2019 15:56:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJ+tv6+Mm8Rmsx8cfOuDT4+CVWVd4gKLzUnTs_EMxKYax+NScw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2019 07:03, Pramod Kumar wrote:
> On Wed, Jan 23, 2019 at 11:03 PM Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> On Wed, Jan 23, 2019 at 09:05:26AM -0800, Scott Branden wrote:
>>> Hi Mark,
>>>
>>> Hopefully I can shed some light on the use case inline.
>>>
>>> On 2019-01-23 8:48 a.m., Mark Rutland wrote:
>>>> On Mon, Jan 21, 2019 at 11:30:02AM +0530, Pramod Kumar wrote:
>>>>> On Mon, Jan 21, 2019 at 11:28 AM Pramod Kumar <pramod.kumar@broadcom.com>
>>>>> wrote:
>>>>>
>>>>>       Need comes from a specific use case where one Accelerator card(SoC) is
>>>>>       plugged in a sever over a PCIe interface.  This Card gets supply from a
>>>>>       battery, which could provide very less power for a very small time, in case
>>>>>       of any power loss. Once Card switches to battery, this has to reduce its
>>>>>       power consumption to its lowest point and back-up the DDR contents asap
>>>>>       before battery gets fully drained off.
>>>> In this example is Linux running on the server, or on the accelerator?
>>> Accelerator
>>>>
>>>> What precisely are you trying to back up from DDR, and why?
>>> Data in DDR is being written to disk at this time (disk is connected to
>>> accelerator)
>>>>
>>>> What is responsible for backing up that contents?
>>>
>>> A low power M-class processor and DMA engine which continues necessary
>>> operations to transfer DDR memory to disk.
>>>
>>> The high power processors on the accelerator running linux needed to be
>>> halted ASAP on this power loss event and M0 take over. Graceful shutdown of
>>> linux and other peripherals is unnecessary (and we don't have the power
>>> necessary to do so).
>>
>> If graceful shutdown of Linux is not required (and is in fact
>> undesireable), why is Linux involved at all in this shutdown process?
>>
>> For example, why is this not a secure interrupt taken to EL3, which can
>> (gracefully) shut down the CPUs regardless?
>>
> 
> This is an GPIO interrupt. This can not be marked secure as for that
> we need to mark whole GPIO controller as secure which is not possible
> as GPIO controller is meant for non-secure world having more than 100
> lines connected.
> 
> I agree we have work around where we invoke handler in Linux and
> switch to ATF via SMC and from ATF we need bring all secondary CPU to
> ATF via sending SGI and and then respective core flushes the L1/L2 and
> bring himself out of coherency domain and cluster and MCU shutdowns
> the CPU subsystem gracefully. This could work for our requirement.
> Need to check ATF support for that.

Right, SMCCC has whole spaces for SoC-specific and platform-specific 
service calls. If your system has a need to power off as fast as 
possible under system-specific constraints, it seems much more sensible 
to immediately tell the firmware "power off as fast as possible under 
the system-specific constraints that you have full knowledge of, 
please", rather than trying to coax the generic kernel_halt() (or 
whatever) infrastructure to sort-of-do-what-you-want.

> But What about generic system? This patch address the generic
> multi-master system's requirement. Consider system where shutting down
> the linux does not mean shutting down the complete system. Lets take
> an example of smartnic case Where NIC master and CPUs access cachable
> DDR. In smarnic its quite common to bring CPUs on demand means when
> needed via MCU help.
> Now in full-fledged system. if CPU subsystem is shutdown via poweroff
> command which does not bring secondary CPUs out of coherency domain,
> it will bring the complete system unstable when NIC master tries to
> access DDR and snoop is send to CPUs as well which is not available.
> Fabric/System hangs...

Not sure that's really relevant here... If platform firmware is able to 
power things off in a way that breaks the platform, surely that's 
entirely the firmware's own fault.

> I feel While shutting down the CPUs subsystem or powering off, All
> secondary CPUs must be shutdown properly by bring-out of coherency
> domain to remain rest of subsystem usable. I agree that introducing
> PSCI call introduce delay for shutdown/reboot case but stability
> matter than little delay.

Again, if you don't trust the firmware to implement SYSTEM_OFF 
appropriately for the platform, can you really assume its CPU_OFF 
implementation is safe either?

People already complain today about how long CPU bringup takes on 
certain systems. Extending their reboot cycle by a similar degree for 
reasons that are entirely irrelevant to those systems is hardly going to 
make those users any happier.

Robin.
