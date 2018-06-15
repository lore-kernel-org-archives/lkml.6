Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 70401C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3EB208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3EB208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755855AbeFOGRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:17:00 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35504 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755824AbeFOGQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:16:58 -0400
Received: by mail-vk0-f66.google.com with SMTP id o17-v6so5093325vka.2;
        Thu, 14 Jun 2018 23:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P94jsr0JtNj8lqyTGp8Wiw2s4cdYOrxsH0WJozCvi3Y=;
        b=PzBWqstZM+Ia6MaU+Gq27hET8ToFdm166dm529RNrbNwN9v0ycI3XTEV33Rhz3OerM
         KmRWS4wBB4ihzbVOR5H+DD7azJTLxeXGBq/SKV97t9vkffklLvV+WbUyE4Pkx1Q31Vuu
         gFVMCqM0pBElzH8VGtP8L5sxrM6mU8fdRqw7AJjheK4JzZfBampc7XVo4i13IJ5sbOOr
         5BSIIK+NorBz9zRkPKVM5IPQNU5AlKKUe0gfaMfpWeRCWqe+U5uEe4NAKm7w3SDDRwLQ
         Bkg30r1nJRe8qKjW+EfJ6fxKkn5jWk9QneQdztBIQCNfZDtfDW8numAT2UsIeqk7HflW
         5/eA==
X-Gm-Message-State: APt69E2Qo//WbTKwmJvmqGCHISl9uDDZjIsULERs2/UQQ9WMcetrEjGa
        eaeo6w/9Yd7LnkCEqyMRa6X8jnfqE3V6Lm7RSZ3IY2qg
X-Google-Smtp-Source: ADUXVKIIgECDDWHMK9RNM2mx992d+hrQm2DtHTp74jHqJrcUdzjHlPqmnFV/EH/+YqICwv4oM9QIVkvbuRbRW5UlYbQ=
X-Received: by 2002:a1f:2c0d:: with SMTP id s13-v6mr185965vks.106.1529043417954;
 Thu, 14 Jun 2018 23:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <23be2945b593a36d8fa1970bb579389c0f892a3e.camel@kernel.crashing.org>
 <CAMuHMdVixknUDYZUHafCqNY02z=T-WC2s+Qh6GkpejmoJU0fuQ@mail.gmail.com> <3312487e2b61b8c2f265d210d14bbed8681a9ecc.camel@kernel.crashing.org>
In-Reply-To: <3312487e2b61b8c2f265d210d14bbed8681a9ecc.camel@kernel.crashing.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Jun 2018 08:16:46 +0200
Message-ID: <CAMuHMdWPQPZxvG6JhGGqsqYpzp74PgABDjMKVCBetKSAnLqhkw@mail.gmail.com>
Subject: Re: [PATCH] drivers/of: Add devm_of_iomap()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Fri, Jun 15, 2018 at 1:51 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2018-06-14 at 10:27 +0200, Geert Uytterhoeven wrote:
> > > --- a/include/linux/of_address.h
> > > +++ b/include/linux/of_address.h
> > > @@ -40,6 +40,11 @@ extern void __iomem *of_iomap(struct device_node *device, int index);
> > >   void __iomem *of_io_request_and_map(struct device_node *device,
> > >                                      int index, const char *name);
> > >
> > > +/* Request and map, wrapper on devm_ioremap_resource */
> > > +extern void __iomem *devm_of_iomap(struct device *dev,
> > > +                                  struct device_node *node, int index,
> > > +                                  resource_size_t *size);
> > > +
> > >   /* Extract an address from a device, returns the region size and
> > >    * the address space flags too. The PCI version uses a BAR number
> > >    * instead of an absolute index
> >
> > Do you need a dummy for !CONFIG_OF_ADDRESS, to aid compile-testing?
>
> I didn't think so, as of_address_to_resource() already has a dummy, so
> it should build fine.

That dummy doesn't matter, as drivers/of/address won't be built if
!CONFIG_OF_ADDRESS anyway.
I mean for compile-testing users of devm_of_iomap().

And according to kbuild test robot <lkp@intel.com>:

>> (.text+0x1882): undefined reference to `devm_ioremap_resource'

devm_ioremap_resource() has no dummy for !HAS_IOMEM and
OF_ADDRESS depends on !SPARC && (HAS_IOMEM || UML),
bypassing the HAS_IOMEM check on UML.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
