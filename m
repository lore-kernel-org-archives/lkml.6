Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F8BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABEA206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AABEA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeHXSOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:14:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49950 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbeHXSOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:14:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B90E322A3D; Fri, 24 Aug 2018 16:39:19 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0549622A2B;
        Fri, 24 Aug 2018 16:39:18 +0200 (CEST)
Date:   Fri, 24 Aug 2018 16:39:17 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Alban <albeu@free.fr>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-i2c@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        David Lechner <david@lechnology.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sven Van Asbroeck <svendev@arcx.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>, Naren <naren.kernel@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
Message-ID: <20180824163917.6bc349c9@bbrezillon>
In-Reply-To: <20180823122921.6857d917@tock>
References: <20180810080526.27207-1-brgl@bgdev.pl>
        <20180810080526.27207-7-brgl@bgdev.pl>
        <20180817182720.6a6e5e8e@bbrezillon>
        <20180819133106.0420df5f@tock>
        <20180819184609.6dcdbb9a@bbrezillon>
        <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
        <20180820202038.5d3dc195@bbrezillon>
        <e0ec3194-fd3a-9b3d-fba8-f88447eb56e9@linaro.org>
        <20180821133916.3a1c51b1@eos>
        <6db14f9c-edd3-5e43-839c-953bb03097ff@linaro.org>
        <20180821150121.4408672f@bbrezillon>
        <20180823122921.6857d917@tock>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2018 12:29:21 +0200
Alban <albeu@free.fr> wrote:

> On Tue, 21 Aug 2018 15:01:21 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> 
> > On Tue, 21 Aug 2018 13:00:04 +0100
> > Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
> >   
> > > On 21/08/18 12:39, Alban wrote:    
> > > > However we still have the a potential address space clash between
> > > > the nvmem cells and the main device binding.      
> > > Can you elaborate?
> > >     
> > 
> > Yes, I'd be interested in having a real example too, cause I don't see
> > what this address space clash is.  
> 
> Let say I have a device that use the following binding:
> 
> device {
>     compatible = "example-device";
>     #address-cells = <2>;
>     #size-cells = <1>;
> 
>     child@0,0 {
>         reg = <0x0 0x0>;
>         ...
>     };
> 
>     child@1,2 {
>         reg = <0x1 0x2>;
>         ...
>     };
> 
> };
> 
> Now this binding already use the node address space for something,
> so putting a nvmem node as direct child would not work. Here it is
> quiet clear as we have 2 address cells, however even if the number of
> cells and the cells size would match it would still be conceptually
> wrong as both bindings then use the same address space for something
> different.

When would we end up in this situation? MTD/flash nodes are supposed to
be leaf nodes (if you omit the partitions underneath). What would be
the case for defining subnodes there?

Do you know of any devices that uses such a representation?
