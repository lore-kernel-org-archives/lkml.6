Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F17C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9735620842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549988940;
	bh=42qN9V0zQqq54p/Jaod/0sVbjQGOIAueFthA4zQbuTo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jV4UNI6HZgYYfp5lAX/qJpHetJ5r+UCCFm4RtvDMjVKRyCfVrASHnqHT5MT1IbZ1K
	 j3tgZNpKBysqHdC+JhZHPimZFmx27br1wovpyH9J1PxY1Vpga/fmKP0SzW8tjKPm1S
	 HGHRX645Ehxa38cQg9eCDOKcKQDYty3lT9zoEfmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbfBLQ27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:28:59 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43285 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfBLQ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:28:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id n71so5373583ota.10;
        Tue, 12 Feb 2019 08:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fseXW1aQ+MNpVWzEhj80Xv7V/c9aS3/ACQPeP06BvyA=;
        b=QcI5GRn5cPGAFIYKsoLhDGEACIrCACFB7oMamxPi41aeKrKo/elVgHCYIDxzMkikrU
         t3bjYM7agQC30aNSgoVVEBW99kkFSTU2BsMBGCTxeXmZAEoaRSxw8dSJBzZbktAQCBsP
         c8JzpN94Vc8y+1m7mk+XSciEEiW+wrz39ldJrZXewj5SHAT5PJcC2bo8j1em6l7Xz2A0
         u1AQPdVjs9JmmSCj6eGaG4FyVS5is39ALGaMx+vLb4vlLWKzaQVVtWQstV6Fd9nwDoYq
         YM+Ht/vBOjCt+i6jPoZW2zFvlNhCt9r07OGzPPlzTN+Gh5A61crip+hf2/Oqfh5DBSzs
         Sq9Q==
X-Gm-Message-State: AHQUAuaKSum21sMwxivV6+jBYJlDedlKockUQ6V0kEg6cnNareL8I7Pt
        SFpd6HefteN8mC1YybNPTVihLVfcSH4mT4f94uk=
X-Google-Smtp-Source: AHgI3IYcp5pXTrM2455oJPGH7prD24yaC5oOjzVrm9HFf/vYDg34UT3jy3d4W5hOdpx4CNQLz6bAXLMdI73VbNFB//g=
X-Received: by 2002:a9d:7990:: with SMTP id h16mr4467156otm.222.1549988937515;
 Tue, 12 Feb 2019 08:28:57 -0800 (PST)
MIME-Version: 1.0
References: <5510642.nRbR3bcduN@aspire.rjw.lan> <1670239.00ZbddH1IV@aspire.rjw.lan>
 <CAPDyKFoR+evmvDehgTJvxcZ70ZLTqU5J4To_c=2vYdOk26h92w@mail.gmail.com>
In-Reply-To: <CAPDyKFoR+evmvDehgTJvxcZ70ZLTqU5J4To_c=2vYdOk26h92w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Feb 2019 17:28:46 +0100
Message-ID: <CAJZ5v0jv6dboQd=iu9pHA_B2HzCEhd2WaN3-732S9px_u6MA-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM-runtime: Fix __pm_runtime_set_status() race with
 runtime resume
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
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 5:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 12 Feb 2019 at 13:10, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 4080ab083000 ("PM-runtime: Take suppliers into account in
> > __pm_runtime_set_status()") introduced a race condition that may
> > trigger if __pm_runtime_set_status() is used incorrectly (that is,
> > if it is called when PM-runtime is enabled for the target device
> > and working).
> >
> > In that case, if the original PM-runtime status of the device is
> > RPM_SUSPENDED, a runtime resume of the device may occur after
> > __pm_runtime_set_status() has dropped its power.lock spinlock
> > and before deactivating its suppliers, so the suppliers may be
> > deactivated while the device is PM-runtime-active which may lead
> > to functional issues.
> >
> > To avoid that, modify __pm_runtime_set_status() to check whether
> > or not PM-runtime is enabled for the device before activating its
> > suppliers (if the new status is RPM_ACTIVE) and either return an
> > error if that's the case or increment the device's disable_depth
> > counter to prevent PM-runtime from being enabled for it while
> > the remaining part of the function is running (disable_depth is
> > then decremented on the way out).
> >
> > Fixes: 4080ab083000 ("PM-runtime: Take suppliers into account in __pm_runtime_set_status()")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/runtime.c |   24 ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> >
> > Index: linux-pm/drivers/base/power/runtime.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/runtime.c
> > +++ linux-pm/drivers/base/power/runtime.c
> > @@ -1129,6 +1129,22 @@ int __pm_runtime_set_status(struct devic
> >         if (status != RPM_ACTIVE && status != RPM_SUSPENDED)
> >                 return -EINVAL;
> >
> > +       spin_lock_irq(&dev->power.lock);
> > +
> > +       /*
> > +        * Prevent PM-runtime from being enabled for the device or return an
> > +        * error if it is enabled already and working.
> > +        */
> > +       if (dev->power.runtime_error || dev->power.disable_depth)
> > +               dev->power.disable_depth++;
> > +       else
> > +               error = -EAGAIN;
> > +
> > +       spin_unlock_irq(&dev->power.lock);
> > +
> > +       if (error)
> > +               return error;
> > +
> >         /*
> >          * If the new status is RPM_ACTIVE, the suppliers can be activated
> >          * upfront regardless of the current status, because next time
> > @@ -1147,12 +1163,6 @@ int __pm_runtime_set_status(struct devic
> >
> >         spin_lock_irq(&dev->power.lock);
> >
> > -       if (!dev->power.runtime_error && !dev->power.disable_depth) {
> > -               status = dev->power.runtime_status;
> > -               error = -EAGAIN;
> > -               goto out;
> > -       }
> > -
> >         if (dev->power.runtime_status == status || !parent)
> >                 goto out_set;
> >
> > @@ -1205,6 +1215,8 @@ int __pm_runtime_set_status(struct devic
> >                 device_links_read_unlock(idx);
> >         }
> >
> > +       pm_runtime_enable(dev);
>
> pm_runtime_enable() uses spin_lock_irqsave(), rather than
> spin_lock_irq() - is there a reason to why you want to allow that
> here, but not earlier in the function?

Device links locking cannot be used in interrupt context.
