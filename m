Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C17C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F72222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550009352;
	bh=5bvvegJafxltFA1LIFNUkl7OxlFlUNL/T1mMBDHtmKU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JsVZ0BbmtkxsjYsCOzSr/Hgblwq1Vy9G2Tr2ZDoby95sh4S9dkL5H4kj5Hy2U0c4x
	 6pLgfqOCg4U8+SfnbTVqvg4a/aaX/A0Qf64JFEB5y50g0683z0Y57sd2zq6y0GDfQV
	 EoqfZHEwe6mbTWeufndunbJIbVsf0JwlME6fEUl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbfBLWJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:09:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33108 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732135AbfBLWJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 17:09:03 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so564285otl.0;
        Tue, 12 Feb 2019 14:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDaMSUbMNhVugdtyN/BMqr5213ZsUOAvkEukBy+CMpw=;
        b=qRfKF2mxXcJF9jvSqIwuSftqA8LSM+kl/c4nf0vodKAO6k5PJgJN9M8mTshHwwp8/h
         XHTe4jdMnPavkuEpM5/jX6f/WchOZOMeJRxc7Ls6Utesbcad2phFliYYoK/kRVWvKTGA
         55YbN4scwghN/CtxJeYZyDZvKh4Oc+YHQKqXtahULoZjzeriCGu3n/jxFafR+jzkufo3
         ARiTzN+VlhU12ec/NuPdOFGcN6PGc6HrjkyUOn7FGI4taYlDNo/TMin66Ue+K9T/0G+d
         2feJRsRgR5HXfOP8G/dckEOi/7hQDBd7kLngyk6tkaNgo2NnuYwUJj0e3gLyVuWueyIC
         YpVw==
X-Gm-Message-State: AHQUAuZYl9A4AulnX0+p4FOxmk+Da+kYjs6lO96WSjuABHihWdYdxiDD
        yZrdJa0VJiCb+PbAlalePW8dGMC1/p+U6tcMbz4=
X-Google-Smtp-Source: AHgI3IbVFix43KXiK7d9DnTNArmRycNOQ+G0/dDdlWZ12+sdUqixqPO6b/ffeGRes0t7U0YYuOycZPw+m0QURLpn5NU=
X-Received: by 2002:a9d:4c0f:: with SMTP id l15mr6289898otf.139.1550009342512;
 Tue, 12 Feb 2019 14:09:02 -0800 (PST)
MIME-Version: 1.0
References: <5510642.nRbR3bcduN@aspire.rjw.lan> <9351473.C2nPJoyFsE@aspire.rjw.lan>
 <CAPDyKFpVygMvKAVRd4bCkS6v5MotDRO6sb-VCHK+YEQvbLbc4Q@mail.gmail.com>
In-Reply-To: <CAPDyKFpVygMvKAVRd4bCkS6v5MotDRO6sb-VCHK+YEQvbLbc4Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Feb 2019 23:08:50 +0100
Message-ID: <CAJZ5v0iQiks4e4te3eoafD5=27zKSK3DRMZxsnjEvaBBPyt2ww@mail.gmail.com>
Subject: Re: [PATCH 2/2] driver core: Fix possible supplier PM-usage counter imbalance
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

On Tue, Feb 12, 2019 at 10:03 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 12 Feb 2019 at 13:10, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If a stateless device link to a certain supplier with
> > DL_FLAG_PM_RUNTIME set in the flags is added and then removed by the
> > consumer driver's probe callback, the supplier's PM-runtime usage
> > counter will be nonzero after that which effectively causes the
> > supplier to remain "always on" going forward.
> >
> > Namely, device_link_add() called to add the link invokes
> > device_link_rpm_prepare() which notices that the consumer driver is
> > probing, so it increments the supplier's PM-runtime usage counter
> > with the assumption that the link will stay around until
> > pm_runtime_put_suppliers() is called by driver_probe_device(),
> > but if the link goes away before that point, the supplier's
> > PM-runtime usage counter will remain nonzero.
> >
> > To prevent that from happening, first rework pm_runtime_get_suppliers()
> > and pm_runtime_put_suppliers() to use the rpm_active refounts of device
> > links and make the latter only drop rpm_active and the supplier's
> > PM-runtime usage counter for each link by one, unless rpm_active is
> > one already for it.  Next, modify device_link_add() to bump up the
> > new link's rpm_active refcount and the suppliers PM-runtime usage
> > counter by two, to prevent pm_runtime_put_suppliers(), if it is
> > called subsequently, from suspending the supplier prematurely (in
> > case its PM-runtime usage counter goes down to 0 in there).
> >
> > Due to the way rpm_put_suppliers() works, this change does not
> > affect runtime suspend of the consumer ends of new device links (or,
> > generally, device links for which DL_FLAG_PM_RUNTIME has just been
> > set).
> >
> > Fixes: e2f3cd831a28 ("driver core: Fix handling of runtime PM flags in device_link_add()")
> > Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> I have tested a several various common probe sequences (including
> error paths) by using my RPM test driver, no issues found. Of course
> it also fixes the problem that occurred while deleting the device link
> during ->probe(). Thanks a lot!
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Ulf Hansson <ulf.hansson@linaro.org>

Thank you!
