Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5308AC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F43620842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfBLRtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:49:49 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41196 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbfBLRtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:49:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 988D1A78;
        Tue, 12 Feb 2019 09:49:46 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84EA23F675;
        Tue, 12 Feb 2019 09:49:44 -0800 (PST)
Date:   Tue, 12 Feb 2019 17:49:37 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] drivers: base: add support to skip power management in
 device/driver model
Message-ID: <20190212174937.GA19095@e107155-lin>
References: <20190206150935.12140-1-sudeep.holla@arm.com>
 <CAPDyKFr2qwXoOL3SRy7Crf-pg4FMn_qecPrw__BE+YpVAjAFZA@mail.gmail.com>
 <20190207103600.GA14464@e107155-lin>
 <CAPDyKFpkiaP0J_LJxP6tRUOyz3QKtDgA+PuhL-9vew7-RfKyNA@mail.gmail.com>
 <20190207150638.GB14464@e107155-lin>
 <CAPDyKFoenSDhYk_xNLFn6kB+rqvQQ+p71F27Mvevu-H9Nhxhuw@mail.gmail.com>
 <20190207152908.GC14464@e107155-lin>
 <CAPDyKFrV7XpKK-Pds=BNgJm9EC50C0wB_f99DK-6N7+K8aZXZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrV7XpKK-Pds=BNgJm9EC50C0wB_f99DK-6N7+K8aZXZw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 05:20:20PM +0100, Ulf Hansson wrote:
> On Thu, 7 Feb 2019 at 16:29, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, Feb 07, 2019 at 04:18:57PM +0100, Ulf Hansson wrote:
> > > On Thu, 7 Feb 2019 at 16:06, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > [...]
> >
> > > > Indeed, I was ignoring knowing that it's harmless. But more people
> > > > started to complain, and Rafael suggested this which I agree as we
> > > > have several pseudo devices created in the kernel that we can bypass
> > > > some of these pm handling knowing we won't need it.
> > >
> > > Okay, I see.
> > >
> > > Anyway, I will likely need to restore part of this change, via my
> > > cluster idling series then. As from that point, the cpu device that
> > > you call device_set_pm_not_required() for, starts to be used from both
> > > PM core and runtime PM point of view. But I guess that's okay then.
> > >
> >
> > Ah I see. I can drop for CPU devices then. Since I didn't see any use for
> > them, I set the flag, but I can drop it now or you can do that as part
> > of that series.
>
> Well, I prefer if you drop it for CPU devices, as least for now.
>
> > There are quite a few devices(especially the ones
> > registered under system subsys can set this but I would take it separate
> > once we settle on this). Also Rafael may have seen use for few more
> > devices when he suggested this.
>
> Yep, let's find another first user of this.
>
> Additionally, it seems like we should drop the print in device_pm_add().
>

Hi Rafael,

Do you prefer to drop the error message or retain it as is ? With this
patch, we don't have to. I will repost v2 dropping this flags for cpus
and just retaining the cache nodes for now.

Regards,
Sudeep
