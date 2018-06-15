Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 856E7C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FE0208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FE0208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965317AbeFOCaT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:30:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:18279 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S936073AbeFOCaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:30:17 -0400
X-UUID: 0bbd59609b514db19c7e31038fa8a231-20180615
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 79324028; Fri, 15 Jun 2018 10:30:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 15 Jun 2018 10:30:05 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 15 Jun 2018 10:30:05 +0800
Message-ID: <1529029805.29697.27.camel@mtkswgap22>
Subject: Re: [PATCH v3 2/7] serdev: add dev_pm_domain_attach|detach()
From:   Sean Wang <sean.wang@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jslaby@suse.com>, <linux-serial@vger.kernel.org>
Date:   Fri, 15 Jun 2018 10:30:05 +0800
In-Reply-To: <CAPDyKFqVpfhJf3R3jbXtjGgXf+0pg=9dgALBnxM_bSyBQrQQDQ@mail.gmail.com>
References: <cover.1528960095.git.sean.wang@mediatek.com>
         <e338118bb6b9f560560887eb974eb250a6c89984.1528960095.git.sean.wang@mediatek.com>
         <CAPDyKFqVpfhJf3R3jbXtjGgXf+0pg=9dgALBnxM_bSyBQrQQDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-14 at 10:58 +0200, Ulf Hansson wrote:
> On Thu, 14 Jun 2018 at 09:14, <sean.wang@mediatek.com> wrote:
> >
> > From: Sean Wang <sean.wang@mediatek.com>
> >
> > In order to open up the required power gate before any operation can be
> > effectively performed over the serial bus between CPU and serdev, it's
> > clearly essential to add common attach functions for PM domains to serdev
> > at the probe phase.
> >
> > Similarly, the relevant dettach function for the PM domains should be
> > properly and reversely added at the remove phase.
> >
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: linux-serial@vger.kernel.org
> > ---
> >  drivers/tty/serdev/core.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index df93b72..c93d8ee 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > +#include <linux/pm_domain.h>
> >  #include <linux/serdev.h>
> >  #include <linux/slab.h>
> >
> > @@ -330,8 +331,16 @@ EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
> >  static int serdev_drv_probe(struct device *dev)
> >  {
> >         const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
> > +       int ret;
> > +
> > +       ret = dev_pm_domain_attach(dev, true);
> > +       if (ret != -EPROBE_DEFER) {
> 
> From 4.18 rc1 via commit 919b7308fcc4, dev_pm_domain_attach() will
> return better error codes.
> 
> I suggest to change the above error path to:
> if (ret)
>      return ret;
> 
> Then continue with the probing below.

Thanks for sharing me the information. I'll happily respin using the
patch because it makes the most sense.

> 
> > +               ret = sdrv->probe(to_serdev_device(dev));
> > +               if (ret)
> > +                       dev_pm_domain_detach(dev, true);
> > +       }
> >
> > -       return sdrv->probe(to_serdev_device(dev));
> > +       return ret;
> >  }
> >
> >  static int serdev_drv_remove(struct device *dev)
> > @@ -339,6 +348,9 @@ static int serdev_drv_remove(struct device *dev)
> >         const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
> >         if (sdrv->remove)
> >                 sdrv->remove(to_serdev_device(dev));
> > +
> > +       dev_pm_domain_detach(dev, true);
> > +
> >         return 0;
> >  }
> >
> > --
> > 2.7.4
> >
> 
> Otherwise, this makes sense to me!
> 

really thanks for your review!

> Kind regards
> Uffe


