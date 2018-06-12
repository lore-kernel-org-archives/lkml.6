Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 43E5CC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D6020891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D6020891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934965AbeFLWxM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:53:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:52601 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934368AbeFLWxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:53:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5CMr4cO014552;
        Tue, 12 Jun 2018 17:53:05 -0500
Message-ID: <f5e71bac1bc23f96b7dae64bbdad8e2154c339aa.camel@kernel.crashing.org>
Subject: Re: [PATCH] drivers/of: Add devm_of_iomap()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 13 Jun 2018 08:53:03 +1000
In-Reply-To: <CAL_Jsq+dHVN+Y7xczf_Oxcn=BiJ6N9WzovRbSujgLLTYHMEh0g@mail.gmail.com>
References: <23be2945b593a36d8fa1970bb579389c0f892a3e.camel@kernel.crashing.org>
         <CAL_Jsq+dHVN+Y7xczf_Oxcn=BiJ6N9WzovRbSujgLLTYHMEh0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-12 at 11:42 -0600, Rob Herring wrote:
> On Mon, Jun 11, 2018 at 6:01 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > There are still quite a few cases where a device might want to get to a
> > different node of the device-tree, obtain the resources and map them.
> > 
> > Drivers doing that currently open code the whole thing, which is error
> > proe.
> > 
> > We have of_iomap() and of_io_request_and_map() but they both have shortcomings,
> > such as not returning the size of the resource found (which can be necessary)
> > and not being "managed".
> > 
> > This adds a devm_of_iomap() that provides all of these and should probably
> > replace uses of the above in most drivers.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> > 
> > I'm cooking a driver that uses this, if there's no objection I'd like
> > to carry it in my pull request for that driver (it can also exist in
> > the DT tree of course). Just let me know.
> 
> We generally only use of_iomap when there is no struct device for any
> new driver. Why can't you use devm_ioremap_resource? Is this a
> non-platform bus device?

This is just a wrapper on devm_ioremap_resource :-) Basically it's a
"fixed" version of of_iomap, that has the devm* management and will
mark the resource busy.

My thinking was to then replace most of_iomap users with this.

As for the specific case of the driver I'm cooking, it's a case where
the SoC contains a little coprocessor (a ColdFire even !) alongside the
main ARM core. I have a driver that offloads the bitbanging of some
GPIOs to it (to implement the FSI bus). I use devm_of_iomap() to map
the registers of the interrupt controller of the coprocessor, it's not
really part of the interrupt tree, it doesn't distribute interrupts to
the ARM or to Linux, it's just a device-node pointed to by a handle.

BTW. Another thing that I find a bit annoying is "allocated" reserved-
memory, there's no API to get to it other than via the DMA APIs or a
CMA, which is overkill in a few circumstances (such as the one here
where I just want to dedicate a bit of memory to the coprocessor).
Right now I'm using a fixed reservation (with a reg property) and go to
it "manually" but that somewhat sucks.

Cheers,
Ben.

> 
> > 
> >  drivers/of/address.c       | 35 +++++++++++++++++++++++++++++++++++
> >  include/linux/of_address.h |  5 +++++
> >  2 files changed, 40 insertions(+)
> > 
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index cf83c05f5650..b7d49ee7b690 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -807,6 +807,41 @@ void __iomem *of_io_request_and_map(struct device_node *np, int index,
> >  }
> >  EXPORT_SYMBOL(of_io_request_and_map);
> > 
> > +/*
> > + * devm_of_iomap - Requests a resource and maps the memory mapped IO
> > + *                for a given device_node managed by a given device
> > + *
> > + * Checks that a resource is a valid memory region, requests the memory
> > + * region and ioremaps it. All operations are managed and will be undone
> > + * on driver detach of the device.
> > + *
> > + * This is to be used when a device requests/maps resources described
> > + * by other device tree nodes (children or otherwise).
> > + *
> > + * @dev:       The device "managing" the resource
> > + * @node:       The device-tree node where the resource resides
> > + * @index:     index of the MMIO range in the "reg" property
> > + * @size:      Returns the size of the resource (pass NULL if not needed)
> > + * Returns a pointer to the requested and mapped memory or an ERR_PTR() encoded
> > + * error code on failure. Usage example:
> > + *
> > + *     base = devm_of_iomap(&pdev->dev, node, 0, NULL);
> > + *     if (IS_ERR(base))
> > + *             return PTR_ERR(base);
> > + */
> > +void __iomem *devm_of_iomap(struct device *dev, struct device_node *node, int index,
> > +                           resource_size_t *size)
> 
> of/address.c generally doesn't depend on struct device. I'd like to
> keep it that way.
> 
> Rob
