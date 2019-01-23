Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2A9C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFA92085A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfAWQsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:48:10 -0500
Received: from foss.arm.com ([217.140.101.70]:44072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAWQsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:48:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15FBFEBD;
        Wed, 23 Jan 2019 08:48:09 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F12E33F237;
        Wed, 23 Jan 2019 08:48:06 -0800 (PST)
Date:   Wed, 23 Jan 2019 16:48:02 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pramod Kumar <pramod.kumar@broadcom.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
Message-ID: <20190123164801.GA55887@lakrids.cambridge.arm.com>
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin>
 <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
 <CAJ+tv6KqynSf5t_VwLqpdM4BF+wLWcJ0wPTD4nWqL4ej1Yih4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+tv6KqynSf5t_VwLqpdM4BF+wLWcJ0wPTD4nWqL4ej1Yih4g@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 11:30:02AM +0530, Pramod Kumar wrote:
> On Mon, Jan 21, 2019 at 11:28 AM Pramod Kumar <pramod.kumar@broadcom.com>
> wrote:
> 
>     Need comes from a specific use case where one Accelerator card(SoC) is
>     plugged in a sever over a PCIe interface.  This Card gets supply from a
>     battery, which could provide very less power for a very small time, in case
>     of any power loss. Once Card switches to battery, this has to reduce its
>     power consumption to its lowest point and back-up the DDR contents asap
>     before battery gets fully drained off. 

In this example is Linux running on the server, or on the accelerator?

What precisely are you trying to back up from DDR, and why?

What is responsible for backing up that contents?

>     Since battery can provide limited power for a very short time hence need to
>     transition to lowest power. As per the transition process , CPUs power
>     domain has to be off but before that it needs to flush out its content to
>     system memory(L3) so that content could be backed-up by a MCU, a controller
>     consuming very less power. Since we can not afford plugging-out every
>     individual CPUs in sequence hence uses  ipi_cpu_stop for all other CPUs
>     which ultimately switch to ATF to flush out all the CPUs caches and comes
>     out of coherency domain so that its power rails could be switched-off.

If you're stopping CPUs from completely arbitrary states, what is the
benefit of saving the RAM contents?

CPUs might be running with IRQs disabled for an arbitrarily long time,
so there's no guarantee that all of them will be turned off before power
is lost.

I'm very confused as to what you're trying to achieve here.

Thanks,
Mark.
