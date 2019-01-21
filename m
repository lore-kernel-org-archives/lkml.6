Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA5BC7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A24D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfAULXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:23:00 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59960 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbfAULW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:22:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFAA6EBD;
        Mon, 21 Jan 2019 03:22:57 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7EEE3F5C1;
        Mon, 21 Jan 2019 03:22:55 -0800 (PST)
Date:   Mon, 21 Jan 2019 11:22:48 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Pramod Kumar <pramod.kumar@broadcom.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
Message-ID: <20190121112248.GA27784@e107155-lin>
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin>
 <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 11:28:27AM +0530, Pramod Kumar wrote:
> On Fri, Jan 18, 2019 at 5:02 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > On Fri, Jan 18, 2019 at 11:16:20AM +0530, Pramod Kumar wrote:
> > > If CPU hotplug is supported, ipi_cpu_stop should use PSCI cpudie
> > > call to stop the CPU. This call ensures L1/L2 cache flush,
> > > CPUs cache-cohenrecy setting w.r.to interconnect.
> >
> > Firstly, this is not specific to PSCI and I don't see any PSCI calls as
> > $subject claims.
>
> I had seen all the other cpu ops methods where only PSCI supports only
> cpu_die features hence used PSCI reference in my subject line to be more
> clear where this die gets converted in last.
>

OK, but since you are not directly dealing with PSCI APIs, it's misleading.

> > Next, you fail to explain why do you have to ensure
> > caches are cleaned and why do you need that in ipi_cpu_stop ?
> > What's the use case ?
> >
> Need comes from a specific use case where one Accelerator card(SoC) is
> plugged in a sever over a PCIe interface.  This Card gets supply from a
> battery, which could provide very less power for a very small time, in case
> of any power loss. Once Card switches to battery, this has to reduce its
> power consumption to its lowest point and back-up the DDR contents asap
> before battery gets fully drained off.
>

OK, but I was expecting the complete call path for this use-case.

> Since battery can provide limited power for a very short time hence need to
> transition to lowest power. As per the transition process , CPUs power
> domain has to be off but before that it needs to flush out its content to
> system memory(L3) so that content could be backed-up by a MCU, a controller
> consuming very less power. Since we can not afford plugging-out every
> individual CPUs in sequence hence uses  ipi_cpu_stop for all other CPUs

So, you are randomly using ipi_cpu_stop for something it's not supposed to
be used. What do you exactly want to achieve in that context where you need
to save power ? Why system off or reset not sufficient ?

--
Regards,
Sudeep

