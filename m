Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52F6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACB320880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfA1OjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:39:24 -0500
Received: from route-level1.fsdata.se ([89.221.252.216]:19053 "EHLO
        route-level1.fsdata.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1OjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:39:24 -0500
Received: from DAG01.HMC.local (192.168.46.11) by EDGE01LEVEL1.hmc.local
 (192.168.46.33) with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 28 Jan
 2019 15:38:45 +0100
Received: from localhost (94.234.46.36) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1263.5; Mon, 28 Jan 2019 15:38:48
 +0100
Date:   Mon, 28 Jan 2019 15:38:45 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <2pi@mok.nu>
Subject: Re: [PATCH] platform/x86: wmi: fix potential null pointer
 dereferences
Message-ID: <20190128143845.2gneic5ip5b56mwv@mok.nu>
References: <20190122200302.19861-1-2pi@mok.nu>
 <CAHp75Vfv1sMyAQn=ue0hroqAnbkhQayCj64xNBHO5PRRv53GSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75Vfv1sMyAQn=ue0hroqAnbkhQayCj64xNBHO5PRRv53GSA@mail.gmail.com>
X-Originating-IP: [94.234.46.36]
X-ClientProxiedBy: PROXY04.HMC.local (192.168.46.54) To DAG01.HMC.local
 (192.168.46.11)
Received-SPF: Neutral (EDGE01LEVEL1.hmc.local: 192.168.46.11 is neither
 permitted nor denied by domain of 2pi@mok.nu)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019-01-27, Andy Shevchenko wrote:
> On Tue, Jan 22, 2019 at 10:04 PM Mattias Jacobsson <2pi@mok.nu> wrote:
> >
> > In the function wmi_dev_match() there are three variables that
> > potentially can result in a null pointer dereference. Namely:
> > dev/wblock, driver/wmi_driver, and wmi_driver->id_table.
> >
> > Check for NULL and return that the driver can't handle the device if any
> > of these variables would result in a null pointer dereference.
> >
> > The NULL checks are performed prior to running container_of() for the
> > variables dev/wblock and driver/wmi_driver.
> >
> > Fixes: 844af950da94 ("platform/x86: wmi: Turn WMI into a bus driver")
> > Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
> > ---
> >  drivers/platform/x86/wmi.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> > index bea35be68706..c596479e8b13 100644
> > --- a/drivers/platform/x86/wmi.c
> > +++ b/drivers/platform/x86/wmi.c
> > @@ -763,10 +763,18 @@ static void wmi_dev_release(struct device *dev)
> >
> >  static int wmi_dev_match(struct device *dev, struct device_driver *driver)
> >  {
> > -       struct wmi_driver *wmi_driver =
> > -               container_of(driver, struct wmi_driver, driver);
> 
> AFAIU this is just a pointer arithmetics, no need to move it.

That is my understanding too, it seamed backwards to do the NULL check
afterwards, but we still have access to dev and driver. So why not...

> 
> > -       struct wmi_block *wblock = dev_to_wblock(dev);
> 
> > -       const struct wmi_device_id *id = wmi_driver->id_table;
> > +       const struct wmi_device_id *id;
> > +       struct wmi_block *wblock;
> > +       struct wmi_driver *wmi_driver;
> > +
> 
> > +       if (dev == NULL || driver == NULL)
> > +               return 0;
> 
> On which circumstances this may ever happen?

Nothing in particular. If there is a bug in the caller of this function,
then that is when this will come into play. See my earlier mail to
Darren too.

> 
> > +       wblock = dev_to_wblock(dev);
> > +       wmi_driver = container_of(driver, struct wmi_driver, driver);
> > +
> > +       if (wmi_driver->id_table == NULL)
> > +               return 0;
> > +       id = wmi_driver->id_table;
> >
> >         while (id->guid_string) {
> >                 uuid_le driver_guid;
> > --
> > 2.20.1
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko

Thanks,
Mattias
