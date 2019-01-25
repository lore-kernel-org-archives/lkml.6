Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963ABC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D71218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfAYQwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:52:15 -0500
Received: from foss.arm.com ([217.140.101.70]:50502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfAYQwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:52:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2249FA78;
        Fri, 25 Jan 2019 08:52:14 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B741D3F5AF;
        Fri, 25 Jan 2019 08:52:11 -0800 (PST)
Date:   Fri, 25 Jan 2019 16:52:04 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Pramod Kumar <pramod.kumar@broadcom.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
Message-ID: <20190125165204.GA20168@e107155-lin>
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin>
 <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
 <CAJ+tv6KqynSf5t_VwLqpdM4BF+wLWcJ0wPTD4nWqL4ej1Yih4g@mail.gmail.com>
 <20190123164801.GA55887@lakrids.cambridge.arm.com>
 <f1851a76-8078-b8e7-6a54-b038b47f9214@broadcom.com>
 <20190123173343.GC55887@lakrids.cambridge.arm.com>
 <CAJ+tv6+Mm8Rmsx8cfOuDT4+CVWVd4gKLzUnTs_EMxKYax+NScw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+tv6+Mm8Rmsx8cfOuDT4+CVWVd4gKLzUnTs_EMxKYax+NScw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 12:33:56PM +0530, Pramod Kumar wrote:

[...]

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
>

Yes platform specific requirement and platform specific solution,
happy ending :).

> But What about generic system? This patch address the generic
> multi-master system's requirement.

Why do we need to address this in generic system ? And what exactly
is this multi-master system's requirement ? Linux runs on one or more
masters and will own it completely. Shutdown must involve everything
it owns if it needs to be graceful.

> Consider system where shutting down the linux does not mean shutting
> down the complete system.

Why is that the case ? Is it forceful shutdown ? Does Linux just own
CPUs and don't care about other blocks in the system ? Irrespective
of what it owns, system shutdown will take care.

> Lets take an example of smartnic case Where NIC master and CPUs access
> cachable DDR. In smarnic its quite common to bring CPUs on demand means
> when needed via MCU help.

Yes you are talking about CPU hotplug or system here ? The above
indicates, it's just CPU hotplug and a solution already exists for that.

> Now in full-fledged system. if CPU subsystem is shutdown via poweroff
> command which does not bring secondary CPUs out of coherency domain,
> it will bring the complete system unstable when NIC master tries to
> access DDR and snoop is send to CPUs as well which is not available.
> Fabric/System hangs...
>

That's because your custom solution just sends ipi to stop CPUs. If you
shutdown the system, all the required information is save to non-volatile
memory and system is powered off gracefully.

> I feel While shutting down the CPUs subsystem or powering off, All
> secondary CPUs must be shutdown properly by bring-out of coherency
> domain to remain rest of subsystem usable. I agree that introducing
> PSCI call introduce delay for shutdown/reboot case but stability
> matter than little delay.

IPI_STOP is not designed to do a graceful shutdown of CPU subsystem.
Use CPU hotplug. You are trying to make you custom requirement a generic
one. We have CPU hotplug framework to do what you want, you just have to
use it. Infact you are doing almost the same with you patch, I don't see
any point as why CPU hotplug can't be used.

--
Regards,
Sudeep
