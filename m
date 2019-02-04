Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91706C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699B72082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbfBDPwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:52:44 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57406 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728379AbfBDPwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:52:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B737880D;
        Mon,  4 Feb 2019 07:52:43 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19B6F3F71E;
        Mon,  4 Feb 2019 07:52:41 -0800 (PST)
Date:   Mon, 4 Feb 2019 15:52:39 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>
Subject: Re: [RFC PATCH] drivers core: cpu: add hotplug callback to update
 cpu_dev state to resumed
Message-ID: <20190204155239.GB24131@e107155-lin>
References: <20190125130701.GA855@vmlxhi-102.adit-jv.com>
 <20190125150906.27614-1-sudeep.holla@arm.com>
 <2397404.eE4apdlqQK@aspire.rjw.lan>
 <20190131160559.GA32759@e107155-lin>
 <20190204153720.GA24131@e107155-lin>
 <20190204154421.GA14330@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204154421.GA14330@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 04:44:21PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 04, 2019 at 03:37:20PM +0000, Sudeep Holla wrote:
> > On Thu, Jan 31, 2019 at 04:05:59PM +0000, Sudeep Holla wrote:
> > > On Thu, Jan 31, 2019 at 12:48:49AM +0100, Rafael J. Wysocki wrote:
> > > > On Friday, January 25, 2019 4:09:06 PM CET Sudeep Holla wrote:
> > > > > The sysfs for the cpu caches are managed by adding devices with cpu
> > > > > as the parent in cpu_device_create() when secondary cpu is brought
> > > > > onlin. Generally when the secondary CPUs are hotplugged back is as part
> > > > > of resume from suspend-to-ram, we call cpu_device_create() from the cpu
> > > > > hotplug state machine while the cpu device associated with that CPU is
> > > > > not yet ready to be resumed as the device_resume() call happens bit later.
> > > > > It's not really needed to set the flag is_prepared for cpu devices are
> > > > > they are mostly pseudo device and hotplug framework deals with state
> > > > > machine and not managed through the cpu device.
> > > > >
> > > > > This often results in annoying warning when resuming:
> > > > > Enabling non-boot CPUs ...
> > > > > CPU1: Booted secondary processor
> > > > >  cache: parent cpu1 should not be sleeping
> > > > > CPU1 is up
> > > > > CPU2: Booted secondary processor
> > > > >  cache: parent cpu2 should not be sleeping
> > > > > CPU2 is up
> > > > > .... and so on.
> > > > >
> > > > > Just fix the warning by updating the device state quite early.
> > > > >
> > > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > > Reported-by: Jisheng Zhang <jszhang@marvell.com>
> > > > > Reported-by: Steve Longerbeam <slongerbeam@gmail.com>
> > > > > Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> > > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > > ---
> > > > >  drivers/base/cpu.c         | 20 +++++++++++++++++++-
> > > > >  include/linux/cpuhotplug.h |  1 +
> > > > >  2 files changed, 20 insertions(+), 1 deletion(-)
> > > > >
> > > > > Hi Rafael,
> > > > >
> > > > > This is getting reported for quite some time. Let me know if you have
> > > > > better solution to fix this harmless yet annoying warnings during system
> > > > > resume.
> > > >
> > > > I'd rather have a flag in struct dev_pm_info that will cause the message to
> > > > be suppressed if set.
> > > >
> > > > It could be used for other purposes too then in princple (like skipping the
> > > > creation of empty "power" attr groups in sysfs for devices that don't
> > > > need them etc.).
> > > >
> > > Thanks for the suggestion. I did quick hack and came up with something
> > > below. I wanted to run through you once before I materialise it into
> > > a formal patch to check if I understood your suggestion correctly.
> > > We can move no_pm_required outside dev_pm_info struct and rename with
> > > any better names.
> > >
> >
> > Sorry for the nag, since the title has RFC, thought there are chances of
> > this getting lost. Let me know if the below idea aligns with your suggestion ?
>
> Personally, I ignore RFC patches unless I'm accidentally interested in
> them, as it shows that the author doesn't feel good enough to propose
> them as a real solution :)
>

I understand. Since Rafael did suggest alternate approach, just thought
of pinging him to check if I understood his idea.

> But that's just me...
>

:)

Regards,
Sudeep
