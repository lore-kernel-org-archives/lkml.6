Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3FEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC9721905
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549998335;
	bh=Y8MyvqeUmegmXo+IkrKYysprqOtjlP0qrRBisdZAGWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SRrZAqll9Rs5CsVuwtXFLAs4/5leN5sP08sPiCtEWneng32itZMG/oD/ugQZO8rGT
	 XGtibDxSUAXDvHFRP2OgngGwGz37Vt8+XPayjDqDXjR/mysD8y4bfxEyzxr4BT5Off
	 +tKuMpwZfcanNyg2Ig6Qm4Oh1HJzIkmAcOqlTYKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbfBLTFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:05:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46939 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbfBLTFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:05:33 -0500
Received: by mail-ot1-f67.google.com with SMTP id w25so6178211otm.13;
        Tue, 12 Feb 2019 11:05:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdMl9D1EQubWNGa4FwxZw9A50X7SiJSRx6uxLDxexyM=;
        b=Q41QbnEFIDyGJc9xWysvjOh5YyvshInkb/Mpp3G5qtY4vze6HceXSvvcK1grXKQQbh
         HZb3YhcxaLT3T8ZCCJeLefErBux/OO7eFHaMFn5O4QCksmqPpScTgVVpphV8IZti1Jhs
         iHplIp2l/gCWoCghgVg8NQBVN/JOZvXra6eFDrc3bzzlO51ubv7bDOkpfNYit34HlMNQ
         gDZydMscfAGOrYC7/tFzyX2fG5zstEGNTzTak1COnx72JekYIrpZpbNG7N1dilZ2bKKz
         3YqEp5xrxSolwmC98uO/oLKdzQzbbQb3BhomZnCd0L8qrFhVZsPBjRLP5mt2bwryn9Yo
         zgLQ==
X-Gm-Message-State: AHQUAuZnQf/1Y/hFiRaxiJNeWbTa2Cp92Libka2bAq9Jo4OzL3Zzfcqh
        /5XrkIz1i587G0+1Q/J6Ifsq7Q9YB0KTbs23Hsk=
X-Google-Smtp-Source: AHgI3IbXTQ/nyNRWIUKku4SVDRypvOekUiQFqxp8J52uq8CgQA3mO9KSirfQvizLvegZylLnfPpeqA5yOuU893pB2f0=
X-Received: by 2002:a9d:5a09:: with SMTP id v9mr3644755oth.244.1549998332374;
 Tue, 12 Feb 2019 11:05:32 -0800 (PST)
MIME-Version: 1.0
References: <5510642.nRbR3bcduN@aspire.rjw.lan> <1670239.00ZbddH1IV@aspire.rjw.lan>
 <CAPDyKFoR+evmvDehgTJvxcZ70ZLTqU5J4To_c=2vYdOk26h92w@mail.gmail.com>
 <CAJZ5v0jv6dboQd=iu9pHA_B2HzCEhd2WaN3-732S9px_u6MA-w@mail.gmail.com> <CAPDyKFpNWrVCW9xwwsWf=vGukEkSj4qYs58terDy0tmmrhyLDw@mail.gmail.com>
In-Reply-To: <CAPDyKFpNWrVCW9xwwsWf=vGukEkSj4qYs58terDy0tmmrhyLDw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Feb 2019 20:05:21 +0100
Message-ID: <CAJZ5v0i6U3PW=MbFsNKFROUTajRpRBg1oWatAW-rXF1M7ihJYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM-runtime: Fix __pm_runtime_set_status() race with
 runtime resume
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 7:28 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 12 Feb 2019 at 17:28, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Feb 12, 2019 at 5:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Tue, 12 Feb 2019 at 13:10, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Commit 4080ab083000 ("PM-runtime: Take suppliers into account in
> > > > __pm_runtime_set_status()") introduced a race condition that may
> > > > trigger if __pm_runtime_set_status() is used incorrectly (that is,
> > > > if it is called when PM-runtime is enabled for the target device
> > > > and working).
> > > >
> > > > In that case, if the original PM-runtime status of the device is
> > > > RPM_SUSPENDED, a runtime resume of the device may occur after
> > > > __pm_runtime_set_status() has dropped its power.lock spinlock
> > > > and before deactivating its suppliers, so the suppliers may be
> > > > deactivated while the device is PM-runtime-active which may lead
> > > > to functional issues.
> > > >
> > > > To avoid that, modify __pm_runtime_set_status() to check whether
> > > > or not PM-runtime is enabled for the device before activating its
> > > > suppliers (if the new status is RPM_ACTIVE) and either return an
> > > > error if that's the case or increment the device's disable_depth
> > > > counter to prevent PM-runtime from being enabled for it while
> > > > the remaining part of the function is running (disable_depth is
> > > > then decremented on the way out).
> > > >
> > > > Fixes: 4080ab083000 ("PM-runtime: Take suppliers into account in __pm_runtime_set_status()")
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/base/power/runtime.c |   24 ++++++++++++++++++------
> > > >  1 file changed, 18 insertions(+), 6 deletions(-)
> > > >
> > > > Index: linux-pm/drivers/base/power/runtime.c
> > > > ===================================================================
> > > > --- linux-pm.orig/drivers/base/power/runtime.c
> > > > +++ linux-pm/drivers/base/power/runtime.c
> > > > @@ -1129,6 +1129,22 @@ int __pm_runtime_set_status(struct devic
> > > >         if (status != RPM_ACTIVE && status != RPM_SUSPENDED)
> > > >                 return -EINVAL;
> > > >
> > > > +       spin_lock_irq(&dev->power.lock);
> > > > +
> > > > +       /*
> > > > +        * Prevent PM-runtime from being enabled for the device or return an
> > > > +        * error if it is enabled already and working.
> > > > +        */
> > > > +       if (dev->power.runtime_error || dev->power.disable_depth)
> > > > +               dev->power.disable_depth++;
> > > > +       else
> > > > +               error = -EAGAIN;
> > > > +
> > > > +       spin_unlock_irq(&dev->power.lock);
> > > > +
> > > > +       if (error)
> > > > +               return error;
> > > > +
> > > >         /*
> > > >          * If the new status is RPM_ACTIVE, the suppliers can be activated
> > > >          * upfront regardless of the current status, because next time
> > > > @@ -1147,12 +1163,6 @@ int __pm_runtime_set_status(struct devic
> > > >
> > > >         spin_lock_irq(&dev->power.lock);
> > > >
> > > > -       if (!dev->power.runtime_error && !dev->power.disable_depth) {
> > > > -               status = dev->power.runtime_status;
> > > > -               error = -EAGAIN;
> > > > -               goto out;
> > > > -       }
> > > > -
> > > >         if (dev->power.runtime_status == status || !parent)
> > > >                 goto out_set;
> > > >
> > > > @@ -1205,6 +1215,8 @@ int __pm_runtime_set_status(struct devic
> > > >                 device_links_read_unlock(idx);
> > > >         }
> > > >
> > > > +       pm_runtime_enable(dev);
> > >
> > > pm_runtime_enable() uses spin_lock_irqsave(), rather than
> > > spin_lock_irq() - is there a reason to why you want to allow that
> > > here, but not earlier in the function?
> >
> > Device links locking cannot be used in interrupt context.
>
> I get that, but thanks for clarifying.
>
> However, then why did you convert __pm_runtime_set_status() from using
> spin_lock_irqsave() to spin_lock_irq() in commit "PM-runtime: Take
> suppliers into account in __pm_runtime_set_status()"?
>
> As far as I can tell, the spin_lock is not being held while we operate
> on the device links anyway. Or is this just to give the caller an
> indication what kind of context the function can be called from?

The latter plus getting rid of saving/restoring the flags which isn't necessary.
