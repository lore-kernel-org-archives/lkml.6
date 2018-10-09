Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836B3ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4367E204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4367E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeJJA5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:57:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38115 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJJA5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:57:18 -0400
Received: by mail-oi1-f194.google.com with SMTP id u197-v6so1907664oif.5;
        Tue, 09 Oct 2018 10:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9YJ2eFYI2HqiBFh/cYH89bZC0TxDqedS4Pavfx6HiP4=;
        b=pU5cOAzay3Zsf55zDNc1K0qjsX48oGmp5Cva40GHjan2nprX7vlk5idfDZjR3f8Wla
         q6k/NeVMoRdKtpny0WxY17aInpf89XIFN/Q/aFSixAGn4ZoyCVTzYXVR50MJHnHYGawU
         OrWQLxxulYsk5w0AzyJjIrl6eNJHZO/OGWSo+88CxpqlqSWKv/ov3VRF41oJRKtQ2WIZ
         2MebPv0epOTTXrV4BLjCL1chejcqKdjJEOv/jI6nfeA+sTxdGDlyWVaxfKLmoYzgbL6c
         RmrDe1tHeVeqsmmP4d8DyTZ8VQopDs7EJxfi2/cbZCVzisXcMWo5aKcEGwk9F/Ei+mGC
         3/gQ==
X-Gm-Message-State: ABuFfoifVfZyku6mjtYrmGbdAmlhxf2OSrg0zg5kFliGPBuFW6Nuk2xC
        K1sbNUH7MKDbIQTswBagzpSEM6PArOYDPkm+06ueWg==
X-Google-Smtp-Source: ACcGV633y3rhIBMtz6BnaREWeP8bT9AofRMeTW0YNtzY+wUcDH7QFoZ56uE7gO4hLn5U7bx9BfrPSTf2HCfpN62WVAw=
X-Received: by 2002:aca:d785:: with SMTP id o127-v6mr7366612oig.33.1539106753312;
 Tue, 09 Oct 2018 10:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <1539080245-25818-1-git-send-email-svellattu@mvista.com> <20181009172726.GA2182@xps15>
In-Reply-To: <20181009172726.GA2182@xps15>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Oct 2018 19:39:01 +0200
Message-ID: <CAJZ5v0gckkg0jyTc7=JYPpUruQQXL_FhEjm03-0mrFcxH60cHA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Driver core: add bus_find_device_by_fwnode
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     svellattu@mvista.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-rdma@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, oulijun@huawei.com,
        xavier.huwei@huawei.com, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 7:27 PM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> Hi Silesh,
>
> On Tue, Oct 09, 2018 at 03:47:24PM +0530, Silesh C V wrote:
> > Some drivers need to find the device on a bus having a specific firmware
> > node. Currently, such drivers have their own implementations to do this.
> > Provide a helper similar to bus_find_device_by_name so that each driver
> > does not have to reinvent this.
> >
> > Signed-off-by: Silesh C V <svellattu@mvista.com>
> > ---
> > Changes since v2:
> >       - make use of dev_fwnode in match_fwnode.
> >
> >  drivers/base/bus.c     | 20 ++++++++++++++++++++
> >  include/linux/device.h |  3 +++
> >  2 files changed, 23 insertions(+)
> >
> > diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> > index 8bfd27e..a2f39db 100644
> > --- a/drivers/base/bus.c
> > +++ b/drivers/base/bus.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/string.h>
> >  #include <linux/mutex.h>
> >  #include <linux/sysfs.h>
> > +#include <linux/property.h>
> >  #include "base.h"
> >  #include "power/power.h"
> >
> > @@ -373,6 +374,25 @@ struct device *bus_find_device_by_name(struct bus_type *bus,
> >  }
> >  EXPORT_SYMBOL_GPL(bus_find_device_by_name);
> >
> > +static int match_fwnode(struct device *dev, void *fwnode)
> > +{
> > +     return dev_fwnode(dev) == fwnode;
> > +}
> > +
> > +/**
> > + * bus_find_device_by_fwnode - device iterator for locating a particular device
> > + * having a specific firmware node
> > + * @bus: bus type
> > + * @start: Device to begin with
> > + * @fwnode: firmware node of the device to match
> > + */
> > +struct device *bus_find_device_by_fwnode(struct bus_type *bus, struct device *start,
> > +                                     struct fwnode_handle *fwnode)
>
> I get the following when running checkpatch on your set:
>
> mpoirier@xps15:~/work/linaro/coresight/kernel-maint$ ./scripts/checkpatch.pl
> 0001-Driver-core-add-bus_find_device_by_fwnode.patch
> WARNING: line over 80 characters

Lines longer than 80 chars often are legitimate.  No need to send
extra reports about those cases in general.

Thanks,
Rafael
