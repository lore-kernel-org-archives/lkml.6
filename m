Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C13C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56184206C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfBFKcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:32:21 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45562 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfBFKcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:32:20 -0500
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 183ab34d8a3d8790; Wed, 6 Feb 2019 11:32:17 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jisheng Zhang <jszhang@marvell.com>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] drivers core: cpu: add hotplug callback to update cpu_dev state to resumed
Date:   Wed, 06 Feb 2019 11:31:04 +0100
Message-ID: <2477683.mi0XWuPk1d@aspire.rjw.lan>
In-Reply-To: <20190204153720.GA24131@e107155-lin>
References: <20190125130701.GA855@vmlxhi-102.adit-jv.com> <20190131160559.GA32759@e107155-lin> <20190204153720.GA24131@e107155-lin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 4, 2019 4:37:20 PM CET Sudeep Holla wrote:
> On Thu, Jan 31, 2019 at 04:05:59PM +0000, Sudeep Holla wrote:
> > On Thu, Jan 31, 2019 at 12:48:49AM +0100, Rafael J. Wysocki wrote:
> > > On Friday, January 25, 2019 4:09:06 PM CET Sudeep Holla wrote:
> > > > The sysfs for the cpu caches are managed by adding devices with cpu
> > > > as the parent in cpu_device_create() when secondary cpu is brought
> > > > onlin. Generally when the secondary CPUs are hotplugged back is as part
> > > > of resume from suspend-to-ram, we call cpu_device_create() from the cpu
> > > > hotplug state machine while the cpu device associated with that CPU is
> > > > not yet ready to be resumed as the device_resume() call happens bit later.
> > > > It's not really needed to set the flag is_prepared for cpu devices are
> > > > they are mostly pseudo device and hotplug framework deals with state
> > > > machine and not managed through the cpu device.
> > > >
> > > > This often results in annoying warning when resuming:
> > > > Enabling non-boot CPUs ...
> > > > CPU1: Booted secondary processor
> > > >  cache: parent cpu1 should not be sleeping
> > > > CPU1 is up
> > > > CPU2: Booted secondary processor
> > > >  cache: parent cpu2 should not be sleeping
> > > > CPU2 is up
> > > > .... and so on.
> > > >
> > > > Just fix the warning by updating the device state quite early.
> > > >
> > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > Reported-by: Jisheng Zhang <jszhang@marvell.com>
> > > > Reported-by: Steve Longerbeam <slongerbeam@gmail.com>
> > > > Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > ---
> > > >  drivers/base/cpu.c         | 20 +++++++++++++++++++-
> > > >  include/linux/cpuhotplug.h |  1 +
> > > >  2 files changed, 20 insertions(+), 1 deletion(-)
> > > >
> > > > Hi Rafael,
> > > >
> > > > This is getting reported for quite some time. Let me know if you have
> > > > better solution to fix this harmless yet annoying warnings during system
> > > > resume.
> > >
> > > I'd rather have a flag in struct dev_pm_info that will cause the message to
> > > be suppressed if set.
> > >
> > > It could be used for other purposes too then in princple (like skipping the
> > > creation of empty "power" attr groups in sysfs for devices that don't
> > > need them etc.).
> > >
> > Thanks for the suggestion. I did quick hack and came up with something
> > below. I wanted to run through you once before I materialise it into
> > a formal patch to check if I understood your suggestion correctly.
> > We can move no_pm_required outside dev_pm_info struct and rename with
> > any better names.
> >
> 
> Sorry for the nag, since the title has RFC, thought there are chances of
> this getting lost. Let me know if the below idea aligns with your suggestion ?

RFC would be fine, but Patchwork doesn't pick up patches posted as replies
in the middle of a thread. :-)

Yes, this is basically what I suggested, please post.

Cheers,
Rafael

