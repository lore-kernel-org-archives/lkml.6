Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F0AC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536BC20852
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536BC20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeHTWXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:23:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50444 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbeHTWXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:23:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A905420737; Mon, 20 Aug 2018 21:06:22 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id D62342072F;
        Mon, 20 Aug 2018 21:06:21 +0200 (CEST)
Date:   Mon, 20 Aug 2018 21:06:21 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alban <albeu@free.fr>, Jonathan Corbet <corbet@lwn.net>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
Message-ID: <20180820210621.5ffe3866@bbrezillon>
In-Reply-To: <CAMRc=McwEjofZKP93DxPa8vJLE6NceLLGfcbcK9-Pfk-dav_Zg@mail.gmail.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
        <20180810080526.27207-7-brgl@bgdev.pl>
        <20180817182720.6a6e5e8e@bbrezillon>
        <20180819133106.0420df5f@tock>
        <20180819184609.6dcdbb9a@bbrezillon>
        <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
        <20180820202038.5d3dc195@bbrezillon>
        <CAMRc=McwEjofZKP93DxPa8vJLE6NceLLGfcbcK9-Pfk-dav_Zg@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018 20:50:55 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> 2018-08-20 20:20 GMT+02:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> > On Mon, 20 Aug 2018 11:43:34 +0100
> > Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
> >  
> >>
> >> Overall am still not able to clear visualize on how MTD bindings with
> >> nvmem cells would look in both partition and un-partition usecases?
> >> An example DT would be nice here!!  
> >
> > Something along those lines:
> >
> >         mtdnode {
> >                 nvmem-cells {
> >                         #address-cells = <1>;
> >                         #size-cells = <1>;
> >
> >                         cell@0 {
> >                                 reg = <0x0 0x14>;
> >                         };
> >                 };
> >
> >                 partitions {
> >                         compatible = "fixed-partitions";
> >                         #address-cells = <1>;
> >                         #size-cells = <1>;
> >
> >                         partition@0 {
> >                                 reg = <0x0 0x20000>;
> >
> >                                 nvmem-cells {
> >                                         #address-cells = <1>;
> >                                         #size-cells = <1>;
> >
> >                                         cell@0 {
> >                                                 reg = <0x0 0x10>;
> >                                         };
> >                                 };
> >                         };
> >                 };
> >         };  
> 
> If there'll be an agreement on the bindings: will you be willing to
> merge Alban's patch even without support in the code for the above
> (with the assumption that it will be added later)?

No, because Alban's patch actually allows people to define and
reference nvmem cells in a DT, but without documenting it (see my first
reply).

> My use-case is on
> non-DT systems and creating nvmem devices corresponding to MTD
> partitions if fine by me.

What you propose is option #1 in my list of proposals, and it requires
some changes to avoid automatically assigning nvmem->dev.of_node to
parent->of_node (which will be != NULL when the MTD device has been
instantiated from a DT node).

> I also don't have the means to test the
> support for these bindings if I were to actually write them myself.

And that's the very reason I proposed #1. I don't want to block this
stuff, but in its current state, I'm not willing to accept it either.
Either we agree on the binding and patch the nvmem framework to support
this new binding, or we find a way to hide the fact that the mtd
device (the nvmem parent) has a DT node attached to it.
