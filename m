Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94CBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DAE21557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hFkFMKWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DAE21557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeHXTDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:03:43 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42573 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbeHXTDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=XBUbNpntrULBhFGJWf7YDKiLFfdXW3bZZMuLRebO2cI=;
        b=hFkFMKWOdF8/2Bdyl3a9MBww+eEPuScMFd4kSbaXwfi6x10imc3RvSMw50gVqJ8dmCgR7DQQpER+h9k7f9BKqM0/hErYLdOPo8klYyFElXiXmPeZAtqSv0+QK5umpuNSX4BtRu65iJ+MDtP0RFPrreZCtn/+jPc99+P1bdptKCk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ftDzw-0001hI-2N; Fri, 24 Aug 2018 17:27:40 +0200
Date:   Fri, 24 Aug 2018 17:27:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
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
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/29] nvmem: add support for cell lookups
Message-ID: <20180824152740.GD27483@lunn.ch>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-2-brgl@bgdev.pl>
 <20180824170848.29594318@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824170848.29594318@bbrezillon>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 05:08:48PM +0200, Boris Brezillon wrote:
> Hi Bartosz,
> 
> On Fri, 10 Aug 2018 10:04:58 +0200
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
> > +struct nvmem_cell_lookup {
> > +	struct nvmem_cell_info	info;
> > +	struct list_head	list;
> > +	const char		*nvmem_name;
> > +};
> 
> Hm, maybe I don't get it right, but this looks suspicious. Usually the
> consumer lookup table is here to attach device specific names to
> external resources.
> 
> So what I'd expect here is:
> 
> struct nvmem_cell_lookup {
> 	/* The nvmem device name. */
> 	const char *nvmem_name;
> 
> 	/* The nvmem cell name */
> 	const char *nvmem_cell_name;
> 
> 	/*
> 	 * The local resource name. Basically what you have in the
> 	 * nvmem-cell-names prop.
> 	 */
> 	const char *conid;
> };
> 
> struct nvmem_cell_lookup_table {
> 	struct list_head list;
> 
> 	/* ID of the consumer device. */
> 	const char *devid;
> 
> 	/* Array of cell lookup entries. */
> 	unsigned int ncells;
> 	const struct nvmem_cell_lookup *cells;
> };
> 
> Looks like your nvmem_cell_lookup is more something used to attach cells
> to an nvmem device, which is NVMEM provider's responsibility not the
> consumer one.

Hi Boris

There are cases where there is not a clear providier/consumer split. I
have an x86 platform, with a few at24 EEPROMs on it. It uses an off
the shelf Komtron module, placed on a custom carrier board. One of the
EEPROMs contains the hardware variant information. Once i know the
variant, i need to instantiate other I2C, SPI, MDIO devices, all using
platform devices, since this is x86, no DT available.

So the first thing my x86 platform device does is instantiate the
first i2c device for the AT24. Once the EEPROM pops into existence, i
need to add nvmem cells onto it. So at that point, the x86 platform
driver is playing the provider role. Once the cells are added, i can
then use nvmem consumer interfaces to get the contents of the cell,
run a checksum, and instantiate the other devices.

I wish the embedded world was all DT, but the reality is that it is
not :-(

    Andrew
