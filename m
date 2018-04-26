Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeDZFaG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:30:06 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:21588 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751040AbeDZFaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:30:04 -0400
X-UUID: 88a60e048f0c411e9805e88380848de2-20180426
Message-ID: <1524720598.12322.37.camel@mtkswgap22>
Subject: Re: [PATCH v1 2/7] serdev: add dev_pm_domain_attach|detach()
From: Sean Wang <sean.wang@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, <linux-serial@vger.kernel.org>
Date: Thu, 26 Apr 2018 13:29:58 +0800
In-Reply-To: <FD85DED4-589C-4113-8A8B-BC5A39494130@holtmann.org>
References: <cover.1522736996.git.sean.wang@mediatek.com>
         <f976766cd499c8d7053a1f442aba1494b4d3314f.1522736996.git.sean.wang@mediatek.com>
         <FD85DED4-589C-4113-8A8B-BC5A39494130@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-03 at 12:29 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 
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
> > drivers/tty/serdev/core.c | 14 +++++++++++++-
> > 1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index df93b72..c93d8ee 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -13,6 +13,7 @@
> > #include <linux/module.h>
> > #include <linux/of.h>
> > #include <linux/of_device.h>
> > +#include <linux/pm_domain.h>
> > #include <linux/serdev.h>
> > #include <linux/slab.h>
> > 
> > @@ -330,8 +331,16 @@ EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
> > static int serdev_drv_probe(struct device *dev)
> > {
> > 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
> > +	int ret;
> > +
> > +	ret = dev_pm_domain_attach(dev, true);
> > +	if (ret != -EPROBE_DEFER) {
> > +		ret = sdrv->probe(to_serdev_device(dev));
> > +		if (ret)
> > +			dev_pm_domain_detach(dev, true);
> > +	}
> 
> so if this is deferred, when does the serdev device gets probed?
> 

driver probe deferral mechanism is supported in driver core

deferred_probe_initcall makes sure that deferred probing is
delayed until late_initcall time.


Below is a few of word I got from drivers/base/core.c I thought it helps
to understand the mechanism in complete picture

* If a required resource is not available yet, a driver can
request probing to be deferred by returning -EPROBE_DEFER from
its probe hook.

* A driver returning -EPROBE_DEFER causes the device to be added to the
pending list.  A successful driver probe will trigger moving all devices
from the pending to the active list so that the workqueue will
eventually retry them.

> > 
> > -	return sdrv->probe(to_serdev_device(dev));
> > +	return ret;
> > }
> > 
> > static int serdev_drv_remove(struct device *dev)
> > @@ -339,6 +348,9 @@ static int serdev_drv_remove(struct device *dev)
> > 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
> > 	if (sdrv->remove)
> > 		sdrv->remove(to_serdev_device(dev));
> > +
> > +	dev_pm_domain_detach(dev, true);
> > +
> > 	return 0;
> > }
> 
> Regards
> 
> Marcel
> 
