Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FF3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BA621928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550165672;
	bh=w2KeBX6/XcnQbSMK7WMTAIuqo2qzHwifLQWa1kfW2GI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eHM8hehLzGM5yiWss570wwMbW4DCBCDywzSKBMIvoSjAQMUppz+yqkSla/RA8BVZE
	 uGfEL4dh1BCJd1QBGC6QhM5xcotwSLH7nXP3+sJ6o0MqEHQydKlilnw60OUWFLT49+
	 t9oyq7k/Iy0DoQqIZfHYzulZ9Gie0eDBoUTZ7v38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437007AbfBNReb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:34:31 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37139 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbfBNRea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:34:30 -0500
Received: by mail-ot1-f67.google.com with SMTP id b3so11879307otp.4;
        Thu, 14 Feb 2019 09:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FA6wHFrFC3UJlsaMHyvwmoAy5dv0XVvw0LKOdfJr1aM=;
        b=rvp28v9ie3+VuCPL0BwVRJVVsPvClpZgAE7aYrp9KbkvuAbA9KS5P2KWdyQduPLpln
         FkTMqrfhFMrTTnpZf+t5mws3OoXJw551P3epp9bnFRjGQ8ywQbhV0LtOYWZHruoFJqt1
         5fsqClgzW6hbHTMYw/2mKMsKjMjZ4wNRKuW4ej+LseAPp2otSkgC6yKMJ6cKl38HVwid
         tmFOXZcbqZbfKvwFzMtvENfbfbceZP2mQCPeN1E3NW48WwLS/XC8WFDz+En3X9zkzPtV
         UPpqBJKW0fdWLvYSFHd0ufSKs6Wkhh+aXigEU2D6vP1YjzMJAiD++vDfb7vnmPn4OE5x
         nxLg==
X-Gm-Message-State: AHQUAuY5pT9wHcCJHO5Fj35MzGp8GzUit7GluNmszngzkoQtQjVc0HVw
        cxCv5R1VkwO7Mfqs1A37giiO5PUKXBOCRcK0p8w=
X-Google-Smtp-Source: AHgI3IZFBYtFj6hrFZUeb3IZgnZrWfppVb0uhxAB/D4ZOx/2IJvOvKGR/rN/uWDbwzb6/CUJ4yZmA/qycGnh7FwqjWc=
X-Received: by 2002:aca:f4d3:: with SMTP id s202mr3072009oih.178.1550165670041;
 Thu, 14 Feb 2019 09:34:30 -0800 (PST)
MIME-Version: 1.0
References: <20190213120137.23354-1-sudeep.holla@arm.com> <CAJZ5v0gg7H9G_HrvLhf9k26maYUR+_EpE8DDQ7NPh58HMRH3Ew@mail.gmail.com>
 <20190214111609.GC28361@e107155-lin> <20190214120509.GA28292@e107155-lin>
In-Reply-To: <20190214120509.GA28292@e107155-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Feb 2019 18:34:19 +0100
Message-ID: <CAJZ5v0hVNcXc3eOSNqC_u5Zvvw78isb0zUBcKnmFqDX57uiLbA@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: base: add support to skip power management in
 device/driver model
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 1:05 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Feb 14, 2019 at 11:16:09AM +0000, Sudeep Holla wrote:
> > On Wed, Feb 13, 2019 at 11:17:47PM +0100, Rafael J. Wysocki wrote:
> > > On Wed, Feb 13, 2019 at 1:01 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> [...]
>
> > > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > > index 0992e67e862b..2a29c3d4e240 100644
> > > > --- a/drivers/base/power/main.c
> > > > +++ b/drivers/base/power/main.c
> > > > @@ -124,6 +124,10 @@ void device_pm_unlock(void)
> > > >   */
> > > >  void device_pm_add(struct device *dev)
> > > >  {
> > > > +       /* No need to create pm sysfs if explicitly specified as not required */
> > >
> > > Is this really about sysfs?
> > >
> >
> > Nope, copy-paste from dpm_sysfs_add, will drop it.
> >
> > > > +       if (device_pm_not_required(dev))
> > >
> > > Should power.disable_depth be bumped up here or while setting the "no PM" flag?
> > >
> >
> > OK, I missed that.
> >
>
> Looking at it,
> 1. We can't set it when we set "no PM" flag as pm_runtime_init called later
>    initialise it to 1
> 2. We can bump it here, but I see it's usage self contained in runtime.c
>    and may look odd to access it here.
>
> More basic question is should we really need to bump it to 2 as its
> initialised to 1 in runtime_init.

Right, I thought about that.

Let's leave it as is maybe. :-)
