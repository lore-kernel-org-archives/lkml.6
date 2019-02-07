Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E08C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097E32147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfBGKgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:36:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35080 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfBGKgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:36:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 827A280D;
        Thu,  7 Feb 2019 02:36:08 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9239A3F675;
        Thu,  7 Feb 2019 02:36:06 -0800 (PST)
Date:   Thu, 7 Feb 2019 10:36:00 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jisheng Zhang <jszhang@marvell.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] drivers: base: add support to skip power management in
 device/driver model
Message-ID: <20190207103600.GA14464@e107155-lin>
References: <20190206150935.12140-1-sudeep.holla@arm.com>
 <CAPDyKFr2qwXoOL3SRy7Crf-pg4FMn_qecPrw__BE+YpVAjAFZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr2qwXoOL3SRy7Crf-pg4FMn_qecPrw__BE+YpVAjAFZA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 10:53:56AM +0100, Ulf Hansson wrote:
> On Wed, 6 Feb 2019 at 16:09, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > All device objects in the driver model contain fields that control the
> > handling of various power management activities. However, it's not
> > always useful. There are few instances where pseudo devices are added
> > to the model just to take advantage of many other features like
> > kobjects, udev events, and so on. One such example is cpu devices and
> > their caches.
> >
> > The sysfs for the cpu caches are managed by adding devices with cpu
> > as the parent in cpu_device_create() when secondary cpu is brought
> > online. Generally when the secondary CPUs are hotplugged back in as part
> > of resume from suspend-to-ram, we call cpu_device_create() from the cpu
> > hotplug state machine while the cpu device associated with that CPU is
> > not yet ready to be resumed as the device_resume() call happens bit
> > later. It's not really needed to set the flag is_prepared for cpu
> > devices as they are mostly pseudo device and hotplug framework deals
> > with state machine and not managed through the cpu device.
>
> What's the point of removing and then re-adding the sysfs attributes
> for the cpu caches, at each hotplug off/on sequence? To me that sounds
> inefficient and unnecessary, no?
>

Oh well, you must look at PowerPC pHyp which can change cache nodes for
suspend/resume operation too, let alone hotplug operations. So, we can't
assume the same CPUs with exact same caches are always hotplugged back
in. That's may happen in embedded and other static platforms but not
everywhere. Anyway that's my understand as why it's done in hotplug
patch. So it's not so simple to call it inefficient and unnecessary IMO.

> If you avoid this, would that solve this problem?
>

May be, but as mentioned above we can't really. Also this change will
help to avoid creating unnecessary power sysfs which is mainly runtime
pm related for some of the devices created. CPU/caches was just one
example which triggered this, but this can be more useful. We can avoid
adding them to dpm list.

--
Regards,
Sudeep
