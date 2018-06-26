Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B37C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A097C266E8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5LI8kpDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A097C266E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbeFZIi6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:38:58 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42621 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752481AbeFZIiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=veS1DexrqSttwiXpHZyanZVdmNiPpesRw5Opz495s0o=;
        b=5LI8kpDG253YDd3irjDH4ugeFD5ArvIusrH6bVm0l1a71gg5u/xRAQSj2L0mcgC98zxDgVJ127q1zQbDdqZe/iOF+BLCa43t88CyRFMzd4LwhDoOQ7EiqZSsEeVi3Z40NvkPha/8Db3QBOwDpsvUkZ862G8FU6ES+ApKo0XcqCY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fXjUV-000822-6R; Tue, 26 Jun 2018 10:38:23 +0200
Date:   Tue, 26 Jun 2018 10:38:23 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 00/14] ARM: davinci: step towards removing
 at24_platform_data
Message-ID: <20180626083823.GA28068@lunn.ch>
References: <20180625155025.12567-1-brgl@bgdev.pl>
 <20180625174024.GB17417@lunn.ch>
 <CAMRc=MdEn74G5SJAaGLAfNSS7Zy7wqH04aN5CMZ45UXqhu_58g@mail.gmail.com>
 <20180625180237.GC17417@lunn.ch>
 <CAMRc=MejDn=t6EPbKOfhMfRAb_O-5hxtWRyjAWH1mb5BUySrDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MejDn=t6EPbKOfhMfRAb_O-5hxtWRyjAWH1mb5BUySrDA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 09:44:19AM +0200, Bartosz Golaszewski wrote:
> 2018-06-25 20:02 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> >> With my patch 1/14 you'll get -EPROBE_DEFER from nvmem_cell_get() if
> >> the nvmem provider is not yet registered. Will that help in your case?
> >
> > I don't think so. My driver instantiates the AT24 device. So if i get
> > -EPROBE_DEFER, i need to cleanup the probe, and return -EPROBDE_DEFER
> > to the code. Which means i need to remove the AT24 device...
> >
> >        Andrew
> 
> Are you sure this is the correct approach? I understand that you want
> to use something like board files for your machine? Wouldn't it be
> better to register a platform device for at24, register a cell lookup
> and then depend on that cell from your driver?

Hi Bartosz

The machine is based around a Kontron Com Express module, with an
intel Ivy Bridge CPU. This is then placed into a custom carrier board,
which has a number of i2c devices.

I have a platform driver which matches on the DMI system ID for the
Kontron module.

The Com Express module has a PLD which implements i2c, gpio,
etc. There is an MFD for this, which instantiates the i2c-kempld i2c
bus driver.

My platform driver finds this i2c-kempld bus driver. If it does not
exist yet, it return -EPROBE_DEFER. If it is found it instantiates an
at24 device on it. I need to look at the content of the EEPROM to
determine the hardware revision, plus do a checksum.  From that, i
need to instantiates 1 or 2 additional AT24, up to 4 GPIO expanders,
and i2c to spi converter, add some gpio-leds on the gpio expanders,
create a bit-banging MDIO bus, instantiate an Ethernet switch on the
MDIO bus, maybe add an Ethernet switch to the SPI bus, etc.

As you can see, i have a chain of events. I cannot move onto the next
part of the chain until i know the probe for the previous part has
finished. e.g. i cannot add gpio-leds until i know the gpio expander
has probed. But the gpio expander provides a call back, similar to the
at24 setup(). The MDIO bus and the SPI bus has a mechanism to register
an info structure, just like you have done for NVMEM cells. So that
works out.

The weak link in this chain is that first at24 probe, and knowing when
i can access the nvmem cells for the revision and checksum
information. -EPROBE_DEFER does not help me here. I need either some
sort of blocking wait for the cells to become available, or a callback
in a context which allows me to instantiate more devices.

I also have some steps which cannot be undone. You don't provide a
mechanism to unregister the nvmem info structure. The I2C and MDIO
equivalent also does not provide an unregister for bus info. So once i
register the first info structure, i'm past the point of no return. I
cannot return -EPROBE_DEFER because i cannot unregister the info
structures, so that i can register them again the next time the
platform driver gets probed.

	 Andrew

