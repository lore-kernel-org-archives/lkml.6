Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359F6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B7420818
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550439251;
	bh=7f4wSOqwyPwlnqp8yYPhRiq2viRL7fPCyf51b4xSPyw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eWGNMVATHE31w52zr2MZgmNzz0yYcB4UVJ+kqENlQMntGepnTHGpAkk5G4dyzQq1S
	 guubzzJOXfcNeesEsBCo64vtdAe6cdd9Z5uaI5jXm4T/MufnKqh1jLgyvm3HA47TRl
	 mT/SZj62LE10bzRc+qCadX7Xsk0nJLinSfPldtk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfBQVeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 16:34:09 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34559 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfBQVeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 16:34:08 -0500
Received: by mail-ot1-f66.google.com with SMTP id 98so25222608oty.1;
        Sun, 17 Feb 2019 13:34:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8FRUHqRc9lRsraDrAUpG5xGDVP+1Vj6PZFOEaq0NNc=;
        b=TNVSi9we0bGm40cCPW4wJ1F/BIF0THlliD/ap9yUYG6HdPK5oQgU34ohYtoyfLhnWO
         zwkJz98txi3hq/lx5lXMfOuVAvqKXF2iMPPYAVKOwlW3e4mwdGVmV1V9VQylRKLSioak
         UALskGZ3GdV0PwwSPBYOEMsy0MnLQmwoz6EMggQQ5aBwDvgrh96rwI2D4HuGAz0kb+bN
         8oZZiRdXM2LnwGHPRcXGmlennmuD/L6YcTcxXivpvH9gET18Uw0k8/S1V0jEBCio0AcQ
         upUId/Ajh9pX3OEo9LmcJfMJLUM8imT7BnFEQH4ShPKlwK8H9PlDkvy8iNKM+x8ndj8m
         3vNg==
X-Gm-Message-State: AHQUAuZebsl9v0v4wqOabZMXuC1ULDD1C6PzDz4wdRI2oVarNK78GNx7
        s3MsS/Nxv8ZSacjAdlKjxy4OqSSiFyVuzaHabBl/W+HK
X-Google-Smtp-Source: AHgI3IaEe0vpMHA4tOw+1uIHf+B6xJblcfjfagd66eH0tdrM+HHG5PAj6u5tUKS/Sx+bDsbZYP7x+Zw8rkozPwK1+5o=
X-Received: by 2002:a9d:5a09:: with SMTP id v9mr11941419oth.244.1550439247400;
 Sun, 17 Feb 2019 13:34:07 -0800 (PST)
MIME-Version: 1.0
References: <5510642.nRbR3bcduN@aspire.rjw.lan> <9351473.C2nPJoyFsE@aspire.rjw.lan>
 <2ed95b05-317c-59bb-498a-b5481e54bcf6@nvidia.com> <CAPDyKFoAtviRYuFxJLNrD_J0bGbMTca3O8EN8THg6+d3BNq3vQ@mail.gmail.com>
 <775fe187-ae04-91ee-44d6-1603e670df06@nvidia.com>
In-Reply-To: <775fe187-ae04-91ee-44d6-1603e670df06@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 17 Feb 2019 22:33:56 +0100
Message-ID: <CAJZ5v0gTfLxPsc_7ANSmmHk90Mx+fVscyzs6yLfxde+DQtBEfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] driver core: Fix possible supplier PM-usage counter imbalance
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
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
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 5:44 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 15/02/2019 14:37, Ulf Hansson wrote:
> > On Fri, 15 Feb 2019 at 12:00, Jon Hunter <jonathanh@nvidia.com> wrote:
> >>
> >> Hi Rafael,
> >>
> >> On 12/02/2019 12:08, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> If a stateless device link to a certain supplier with
> >>> DL_FLAG_PM_RUNTIME set in the flags is added and then removed by the
> >>> consumer driver's probe callback, the supplier's PM-runtime usage
> >>> counter will be nonzero after that which effectively causes the
> >>> supplier to remain "always on" going forward.
> >>>
> >>> Namely, device_link_add() called to add the link invokes
> >>> device_link_rpm_prepare() which notices that the consumer driver is
> >>> probing, so it increments the supplier's PM-runtime usage counter
> >>> with the assumption that the link will stay around until
> >>> pm_runtime_put_suppliers() is called by driver_probe_device(),
> >>> but if the link goes away before that point, the supplier's
> >>> PM-runtime usage counter will remain nonzero.
> >>>
> >>> To prevent that from happening, first rework pm_runtime_get_suppliers()
> >>> and pm_runtime_put_suppliers() to use the rpm_active refounts of device
> >>> links and make the latter only drop rpm_active and the supplier's
> >>> PM-runtime usage counter for each link by one, unless rpm_active is
> >>> one already for it.  Next, modify device_link_add() to bump up the
> >>> new link's rpm_active refcount and the suppliers PM-runtime usage
> >>> counter by two, to prevent pm_runtime_put_suppliers(), if it is
> >>> called subsequently, from suspending the supplier prematurely (in
> >>> case its PM-runtime usage counter goes down to 0 in there).
> >>>
> >>> Due to the way rpm_put_suppliers() works, this change does not
> >>> affect runtime suspend of the consumer ends of new device links (or,
> >>> generally, device links for which DL_FLAG_PM_RUNTIME has just been
> >>> set).
> >>>
> >>> Fixes: e2f3cd831a28 ("driver core: Fix handling of runtime PM flags in device_link_add()")
> >>> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>
> >>> Note that the issue had been there before commit e2f3cd831a28, but it was
> >>> overlooked by that commit and this change is a fix on top of it, so make
> >>> the Fixes: tag point to commit e2f3cd831a28 (instead of an earlier one
> >>> that the patch will not be applicable to).
> >> I noticed that yesterday's and today's -next were no longer booting on
> >> one of our Tegra boards (Tegra210 Jetson TX2) because networking is
> >> failing. The ethernet chip is a USB device and looking at the bootlogs I
> >> can see that the Tegra XHCI driver is failing ...
> >>
> >>  tegra-xusb 70090000.usb: xHCI host controller not responding, assume dead
> >>  tegra-xusb 70090000.usb: HC died; cleaning up
> >>
> >> The Tegra XHCI driver uses multiple power-domains and uses
> >> device_link_add() to attach them. So now I am wondering if there is
> >> something that we have got wrong in our implementation. However, I don't
> >> see the device being probed deferred on boot or anything like that.
> >>
> >> The driver in question is drivers/usb/host/xhci-tegra.c and we add the
> >> links in the function tegra_xusb_powerdomain_init() which is before RPM
> >> is enabled. Let me know if you have any thoughts.
> >
> > If you are willing to help debugging then I am offering my assistance.
> >
> > I would start by enabling CONFIG_PM_ADVANCED_DEBUG, which gives you
> > some more information about the runtime PM state of the device, like
> > the usage count for example.
> > I would also add a couple of prints in
> > tegra_xusb_runtime_suspend|resume() and in the ->power_on|off()
> > callbacks for the corresponding genpds, to see when those gets called.
>
> From the bootlog I see ...
>
> [    4.445827] tegra_xusb_runtime_resume-788
> [    4.508799] tegra-xusb 70090000.usb: Firmware timestamp: 2015-08-10 09:47:54 UTC
> [    4.516223] tegra-xusb 70090000.usb: xHCI Host Controller
> [    4.521622] tegra-xusb 70090000.usb: new USB bus registered, assigned bus number 1
> [    4.530087] tegra-xusb 70090000.usb: hcc params 0x0184f525 hci version 0x100 quirks 0x0000000000010010
> [    4.539398] tegra-xusb 70090000.usb: irq 69, io mem 0x70090000
> [    4.553671] tegra-xusb 70090000.usb: xHCI Host Controller
> [    4.559064] tegra-xusb 70090000.usb: new USB bus registered, assigned bus number 2
> [    4.566622] tegra-xusb 70090000.usb: Host supports USB 3.0  SuperSpeed
> [    4.595393] tegra-pmc: tegra_genpd_power_off-673: xusbc
> [    4.600672] tegra-pmc: tegra_genpd_power_off-673: xusba
> [    4.657346] tegra-xusb 70090000.usb: xHCI host controller not responding, assume dead
> [    4.665157] tegra-xusb 70090000.usb: HC died; cleaning up
>
> This shows the xusb controller is runtime resumed during probe but
> then after probe the pm-domains, xusba and xusbc, are turned off
> without it being runtime suspended. We never suspend it until it
> is removed currently.

As I said offline on Sat, I suspected that the suppliers (that would
be xusba and xusbc if my understanding of the system is correct) were
suspended prematurely during or after the consumer (xusb) probe, which
previously had been prevented from occurring by the
pm_runtime_get_noresume(supplier) removed by the $subject patch.

What you said above seems to be in agreement with that theory, so it
looks like you simply need to pass DL_FLAG_RPM_ACTICE to
device_link_add() in both cases, as that would prevent the suppliers
from being suspended until the consumer suspends (or its PM-runtime
status is changed to "suspended").  And if the consumer never
suspends, the suppliers will never suspend too then.
