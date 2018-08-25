Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1455C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 06:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AC620C51
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 06:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AC620C51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeHYKFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 06:05:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38391 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbeHYKFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 06:05:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A98BB207B1; Sat, 25 Aug 2018 08:27:28 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id D99E3206FF;
        Sat, 25 Aug 2018 08:27:27 +0200 (CEST)
Date:   Sat, 25 Aug 2018 08:27:22 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
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
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>, Naren <naren.kernel@gmail.com>,
        netdev@vger.kernel.org, Alban Bedel <albeu@free.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 01/29] nvmem: add support for cell lookups
Message-ID: <20180825082722.567e8c9a@bbrezillon>
In-Reply-To: <20180824152740.GD27483@lunn.ch>
References: <20180810080526.27207-1-brgl@bgdev.pl>
        <20180810080526.27207-2-brgl@bgdev.pl>
        <20180824170848.29594318@bbrezillon>
        <20180824152740.GD27483@lunn.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 17:27:40 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Fri, Aug 24, 2018 at 05:08:48PM +0200, Boris Brezillon wrote:
> > Hi Bartosz,
> > 
> > On Fri, 10 Aug 2018 10:04:58 +0200
> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >   
> > > +struct nvmem_cell_lookup {
> > > +	struct nvmem_cell_info	info;
> > > +	struct list_head	list;
> > > +	const char		*nvmem_name;
> > > +};  
> > 
> > Hm, maybe I don't get it right, but this looks suspicious. Usually the
> > consumer lookup table is here to attach device specific names to
> > external resources.
> > 
> > So what I'd expect here is:
> > 
> > struct nvmem_cell_lookup {
> > 	/* The nvmem device name. */
> > 	const char *nvmem_name;
> > 
> > 	/* The nvmem cell name */
> > 	const char *nvmem_cell_name;
> > 
> > 	/*
> > 	 * The local resource name. Basically what you have in the
> > 	 * nvmem-cell-names prop.
> > 	 */
> > 	const char *conid;
> > };
> > 
> > struct nvmem_cell_lookup_table {
> > 	struct list_head list;
> > 
> > 	/* ID of the consumer device. */
> > 	const char *devid;
> > 
> > 	/* Array of cell lookup entries. */
> > 	unsigned int ncells;
> > 	const struct nvmem_cell_lookup *cells;
> > };
> > 
> > Looks like your nvmem_cell_lookup is more something used to attach cells
> > to an nvmem device, which is NVMEM provider's responsibility not the
> > consumer one.  
> 
> Hi Boris
> 
> There are cases where there is not a clear providier/consumer split. I
> have an x86 platform, with a few at24 EEPROMs on it. It uses an off
> the shelf Komtron module, placed on a custom carrier board. One of the
> EEPROMs contains the hardware variant information. Once i know the
> variant, i need to instantiate other I2C, SPI, MDIO devices, all using
> platform devices, since this is x86, no DT available.
> 
> So the first thing my x86 platform device does is instantiate the
> first i2c device for the AT24. Once the EEPROM pops into existence, i
> need to add nvmem cells onto it. So at that point, the x86 platform
> driver is playing the provider role. Once the cells are added, i can
> then use nvmem consumer interfaces to get the contents of the cell,
> run a checksum, and instantiate the other devices.
> 
> I wish the embedded world was all DT, but the reality is that it is
> not :-(

Actually, I'm not questioning the need for this feature (being able to
attach NVMEM cells to an NVMEM device on a platform that does not use
DT). What I'm saying is that this functionality is provider related,
not consumer related. Also, I wonder if defining such NVMEM cells
shouldn't go through the provider driver instead of being passed
directly to the NVMEM layer, because nvmem_config already have a fields
to pass cells at registration time, plus, the name of the NVMEM cell
device is sometimes created dynamically and can be hard to guess at
platform_device registration time.

I also think non-DT consumers will need a way to reference exiting
NVMEM cells, but this consumer-oriented nvmem cell lookup table should
look like the gpio or pwm lookup table (basically what I proposed in my
previous email).
