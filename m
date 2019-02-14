Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E2BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8DB2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732295AbfBNMFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:05:19 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42332 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbfBNMFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:05:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D08280D;
        Thu, 14 Feb 2019 04:05:18 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CA2B3F675;
        Thu, 14 Feb 2019 04:05:16 -0800 (PST)
Date:   Thu, 14 Feb 2019 12:05:09 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v2] drivers: base: add support to skip power management
 in device/driver model
Message-ID: <20190214120509.GA28292@e107155-lin>
References: <20190213120137.23354-1-sudeep.holla@arm.com>
 <CAJZ5v0gg7H9G_HrvLhf9k26maYUR+_EpE8DDQ7NPh58HMRH3Ew@mail.gmail.com>
 <20190214111609.GC28361@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214111609.GC28361@e107155-lin>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 11:16:09AM +0000, Sudeep Holla wrote:
> On Wed, Feb 13, 2019 at 11:17:47PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Feb 13, 2019 at 1:01 PM Sudeep Holla <sudeep.holla@arm.com> wrote:

[...]

> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index 0992e67e862b..2a29c3d4e240 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -124,6 +124,10 @@ void device_pm_unlock(void)
> > >   */
> > >  void device_pm_add(struct device *dev)
> > >  {
> > > +       /* No need to create pm sysfs if explicitly specified as not required */
> >
> > Is this really about sysfs?
> >
>
> Nope, copy-paste from dpm_sysfs_add, will drop it.
>
> > > +       if (device_pm_not_required(dev))
> >
> > Should power.disable_depth be bumped up here or while setting the "no PM" flag?
> >
>
> OK, I missed that.
>

Looking at it,
1. We can't set it when we set "no PM" flag as pm_runtime_init called later
   initialise it to 1
2. We can bump it here, but I see it's usage self contained in runtime.c
   and may look odd to access it here.

More basic question is should we really need to bump it to 2 as its
initialised to 1 in runtime_init.

--
Regards,
Sudeep
