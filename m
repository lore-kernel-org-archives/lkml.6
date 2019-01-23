Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C088BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9146F21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfAWQ1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:27:11 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43720 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfAWQ1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:27:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF1E3A78;
        Wed, 23 Jan 2019 08:27:10 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 963F53F237;
        Wed, 23 Jan 2019 08:27:08 -0800 (PST)
Date:   Wed, 23 Jan 2019 16:27:03 +0000
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
Message-ID: <20190123162514.GA22147@e107155-lin>
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin>
 <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
 <20190121112248.GA27784@e107155-lin>
 <CAJ+tv6++eXwu7Ez-GW62Avgaj+h0aPhyL0K-n3mBgwM2RtXXjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+tv6++eXwu7Ez-GW62Avgaj+h0aPhyL0K-n3mBgwM2RtXXjQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 10:21:05AM +0530, Pramod Kumar wrote:
> Thanks Sudeep for reviewing. Please see my comment inline below.
>
> On Mon, Jan 21, 2019 at 4:52 PM Sudeep Holla <sudeep.holla@arm.com> wrote:

[...]

> >
> > OK, but I was expecting the complete call path for this use-case.
>
> OK. Once power loss happens, Application processor gets interrupt and
> it has to switch to MCU asap so that it can switch-off all irrelevant
> power domain to reduce battery drain.
> flow is like this-
> Power loss interrupt --> interrupt handler -> send IPI to stop all
> secondary CPUs-> switch primary CPU to ATF which ultimately transition
> to MCU where all power off action is taken.
>

So does the entire AP domain get powered off or is that the intention ?
If so, just stopping secondaries through IPI is not sufficient. What
happens to all the running tasks and other operations going on in the
system.

> >
> > > Since battery can provide limited power for a very short time hence need to
> > > transition to lowest power. As per the transition process , CPUs power
> > > domain has to be off but before that it needs to flush out its content to
> > > system memory(L3) so that content could be backed-up by a MCU, a controller
> > > consuming very less power. Since we can not afford plugging-out every
> > > individual CPUs in sequence hence uses  ipi_cpu_stop for all other CPUs
> >
> > So, you are randomly using ipi_cpu_stop for something it's not supposed to
> > be used. What do you exactly want to achieve in that context where you need
> > to save power ?
>
> Need to back-up DDR from MCU which will require L1/L2 content gets
> flushed before CPUs getting shutdown.
>

Understood.

> >Why system off or reset not sufficient ?
> System off or reset is not sufficient as we can not afford that much
> delay in transition.
>

But who will save the system state ? You may corrupt data at the cost
of saving transition delay. So IMO, you don't have a valid use-case or
you are failing to present one properly.

> Flushing L1/L2 contents to System memory and Bringing out CPUs
> Clusters out of coherency domain before shutting down Clusters puts
> rest of system in sane state.  If cluster are not being taken out
> properly from coherency domain before shutting down, it could lead
> system un-reliable for rest parts.
>

Looks like you are concerned only with CPUs in this scenario, but what
about other devices in the domain. So suspend-to-{ram,idle} are only
sane options to make sure you don't loose/corrupt any data/state.

Further point me to the code either part of this series or upstream
handling the "Power loss interrupt" explained above.

--
Regards,
Sudeep
