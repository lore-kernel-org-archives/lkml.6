Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35CFC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F454217FA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549924918;
	bh=bFQv2jL8l7LsVrBnjJxllnBM4ycB3n+bbsg7aa18+d4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XnMDoGUXSbf9S+B8ehgLMpwPoT5zklUDeS9PTJj/nYG02qkS8VcqZ2pVqc5/4NMOP
	 D+j67hs7hhHyenAGYIZ9MeXzE8hXVvv0qDoDtLsZArVlfmxY9jmnS0Yi3QkY0ZksR1
	 aogqdBtsePIh56cd7LPHPjTQ9CPzub1yVE0azVNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfBKWl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:41:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37591 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfBKWl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:41:56 -0500
Received: by mail-ot1-f66.google.com with SMTP id b3so1085256otp.4;
        Mon, 11 Feb 2019 14:41:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bF4alEILY9CICyqtP82YT446lOAQzqM3kGIWefidkfM=;
        b=WTfX3+QJf3jgeqKt4wGjZ8xb1sZ9ozv8RI2U6NW8z9fzPJqN3oe/XgU99ArNbNoOFN
         BdRBf6xqqMNz1ijsv+pa9lz4QIHQl1KTPfMPcTYtR+dcUDABA36mhpVVSd3BK0u3irqS
         OKZ+TDXn3g0X4rOa4fYTysYKJsbhEX/IYEmDjV+pnn8t7z5/K2jJLQdBE+99OZeS4qXE
         XOnMhvNWB6IKrkCGO/vZAjQUbNQqKIfGeMapxEOVmcxCp3HaESUuxC2b5i79I0gP1I3U
         945QAOQYjWpbXHUzKLtEwJFYgm27o785zcOZbxiu7HgtrhZNDChnqlVjwwYFaURkg7RE
         6gKA==
X-Gm-Message-State: AHQUAub0Sx9oX3EPNoGoyW2MBEzF43WgumV7nfWrlpSfE1PV8P8cr73i
        fa2LnDt6joylYBE6D+pc0ysj+Z05bZxzAeM2TNg=
X-Google-Smtp-Source: AHgI3IYzytf+HPkXCaBfMzSU4VhijBb1TSgv6ajUqMxP6TQY3Wz4v3SNEMoIKPXn89xyCzQSws285/o8icmroNtgvJ8=
X-Received: by 2002:a9d:7e8f:: with SMTP id m15mr566998otp.124.1549924915024;
 Mon, 11 Feb 2019 14:41:55 -0800 (PST)
MIME-Version: 1.0
References: <3917694.ab5GGAjohB@aspire.rjw.lan> <1634058.cXDNg15SOd@aspire.rjw.lan>
 <CAPDyKFpWCT9CcmxqqWk+S8tSPz_at56UCnk3EVBab-TnScHw8Q@mail.gmail.com>
In-Reply-To: <CAPDyKFpWCT9CcmxqqWk+S8tSPz_at56UCnk3EVBab-TnScHw8Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Feb 2019 23:41:43 +0100
Message-ID: <CAJZ5v0j2Gi7uG7TWSXdmQ09VWT+ZZF=woUFAnoFBDLx9zy-Cng@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM-runtime: Take suppliers into account in __pm_runtime_set_status()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Feb 11, 2019 at 2:28 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 7 Feb 2019 at 19:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If the target device has any suppliers, as reflected by device links
> > to them, __pm_runtime_set_status() does not take them into account,
> > which is not consistent with the other parts of the PM-runtime
> > framework and may lead to programming mistakes.
> >
> > Modify __pm_runtime_set_status() to take suppliers into account by
> > activating them upfront if the new status is RPM_ACTIVE and
> > deactivating them on exit if the new status is RPM_SUSPENDED.
> >
> > If the activation of one of the suppliers fails, the new status
> > will be RPM_SUSPENDED and the (remaining) suppliers will be
> > deactivated on exit (the child count of the device's parent
> > will be dropped too then).
> >
> > Of course, adding device links locking to __pm_runtime_set_status()
> > means that it cannot be run fron interrupt context, so make it use
> > spin_lock_irq() and spin_unlock_irq() instead of spin_lock_irqsave()
> > and spin_unlock_irqrestore(), respectively.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Rafael, thanks for working on this!
>
> I am running some tests at my side, but still not achieving the
> behavior I expect to. Will let you know when I have more details, but
> first some comments below.
>
> > ---
> >  drivers/base/power/runtime.c |   45 ++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 40 insertions(+), 5 deletions(-)
> >
> > Index: linux-pm/drivers/base/power/runtime.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/runtime.c
> > +++ linux-pm/drivers/base/power/runtime.c
> > @@ -1102,20 +1102,43 @@ EXPORT_SYMBOL_GPL(pm_runtime_get_if_in_u
> >   * and the device parent's counter of unsuspended children is modified to
> >   * reflect the new status.  If the new status is RPM_SUSPENDED, an idle
> >   * notification request for the parent is submitted.
> > + *
> > + * If @dev has any suppliers (as reflected by device links to them), and @status
> > + * is RPM_ACTIVE, they will be activated upfront and if the activation of one
> > + * of them fails, the status of @dev will be changed to RPM_SUSPENDED (instead
> > + * of the @status value) and the suppliers will be deacticated on exit.  The
> > + * error returned by the failing supplier activation will be returned in that
> > + * case.
> >   */
> >  int __pm_runtime_set_status(struct device *dev, unsigned int status)
> >  {
> >         struct device *parent = dev->parent;
> > -       unsigned long flags;
> >         bool notify_parent = false;
> >         int error = 0;
> >
> >         if (status != RPM_ACTIVE && status != RPM_SUSPENDED)
> >                 return -EINVAL;
> >
> > -       spin_lock_irqsave(&dev->power.lock, flags);
> > +       /*
> > +        * If the new status is RPM_ACTIVE, the suppliers can be activated
> > +        * upfront regardless of the current status, because next time
> > +        * rpm_put_suppliers() runs, the rpm_active refcounts of the links
> > +        * involved will be dropped down to one anyway.
> > +        */
> > +       if (status == RPM_ACTIVE) {
> > +               int idx = device_links_read_lock();
> > +
> > +               error = rpm_get_suppliers(dev);
> > +               if (error)
> > +                       status = RPM_SUSPENDED;
> > +
> > +               device_links_read_unlock(idx);
> > +       }
>
> This doesn't look right to me, and more importantly, this isn't
> consistent with how we treat a parent/child.

It cannot be entirely consistent with that, because you cannot walk
the suppliers under the device's power.lock.

The idea here is that activating suppliers upfront if the new status
is RPM_ACTIVE shouldn't hurt regardless.

> More precisely, I think you need to check "if
> (!dev->power.runtime_error && !dev->power.disable_depth)" and also
> whether "dev->power.runtime_status == status", before deciding to call
> rpm_get_suppliers() above. Otherwise you may end up resuming suppliers
> and/or increasing the link->rpm_active count, when you shouldn't.

Resuming suppliers unnecessarily is not particularly efficient, but it
is not incorrect.  Incrementing their rpm_active temporarily also
isn't incorrect as long as the rpm_active values are correct on exit
(and note that incementing them if the consumer's status is RPM_ACTIVE
doesn't even matter).

> In other words, expecting __pm_runtime_set_status() to be called in
> "balanced" manner isn't correct.

There is no such expectation here.

There is a possible race between __pm_runtime_set_status() and runtime
suspend or resume of the device in case PM-runtime is enabled for it
when __pm_runtime_set_status() is called, but it shouldn't occur if
__pm_runtime_set_status() is used correctly (that is, when PM-runtime
is disabled for the device).

I think I know how to avoid that race, though, so I'm going to post an
incremental fix if that works out.
