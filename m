Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDC9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362AA20838
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zGi2+GQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362AA20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406597AbeKWFhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 00:37:51 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45985 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730830AbeKWFhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 00:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=jjm+431tIGbdobUrHCBXJNkRTtcLnDUFDYoMp02qVnE=;
        b=zGi2+GQpa1OGTO3OeltAhBhMWcv/ww2t9pYRoghywRg7Sdd0buxVKYIQCcUYka4woaDou1dlyxuLi5FV2L7PHwuHh3Z/TUUbDTuxmwnunChVxN2bz6HDmfxuLx4iiulhrlhvIvKnx0Z+S1CMJV0WNJQC5Oe6cjnuEX6KfOTkY8Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gPu9x-0002gp-32; Thu, 22 Nov 2018 19:57:05 +0100
Date:   Thu, 22 Nov 2018 19:57:05 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Marc Dionne <marc.c.dionne@gmail.com>, norbert.jurkeit@web.de,
        nic_swsd@realtek.com, Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        michael.wiktowy@gmail.com, jcline@redhat.com
Subject: Re: Issue with RTL8111 NIC after upgrade to kernel 4.19
Message-ID: <20181122185705.GG10697@lunn.ch>
References: <d0a53002-bf14-6cd9-ab0f-5d3f9aa395ce@web.de>
 <38dad61b-bc7f-7038-6d1b-f5c4afe3841c@gmail.com>
 <20181121202034.GA10697@lunn.ch>
 <eda84d0b-2d9f-07ae-34a1-767bc5200964@gmail.com>
 <6aeba3d6-2292-1221-9be7-1c0bb7cbc203@gmail.com>
 <7d6362e1-e197-d338-d6b0-9036c3802e2c@gmail.com>
 <CAB9dFdvw8QqzaVYV3bOMGtACyvqWnE9uy96m1tu2C+jjzQR9_Q@mail.gmail.com>
 <a995b6f6-c5b1-877c-581c-39c0897e7703@gmail.com>
 <CAB9dFdsq7EBNm1Y1nK2tqOvg5ikyTm4ZGTQddsNAp1BaA0J_XQ@mail.gmail.com>
 <d38a9ed9-b801-5622-1d3a-1b9620ed9d8d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d38a9ed9-b801-5622-1d3a-1b9620ed9d8d@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks a lot for testing. Could you please test also the following
> as an alternative to the delay?
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 55202a0ac..aeccb2323 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -2254,6 +2254,7 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
>         new_driver->mdiodrv.driver.probe = phy_probe;
>         new_driver->mdiodrv.driver.remove = phy_remove;
>         new_driver->mdiodrv.driver.owner = owner;
> +       new_driver->mdiodrv.driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
> 
>         retval = driver_register(&new_driver->mdiodrv.driver);
>         if (retval) {


Humm, maybe i don't understand the issue correctly.

When the MDIO bus is registered, we scan the bus looking for PHYs.
When we find a PHY, we call phy_device_create(). That will then
trigger the loading of the kernel module which should driver this phy.

Sometime later, the PHY driver module gets loaded and calls
phy_drivers_register() to register the list of IDs it supports.  The
driver core will then call phy_bus_match() to see if the newly loaded
driver matches to a device we have created. If so, the driver will be
associated to the device.

Sometime later, the MAC tries to attach to the phy using
phy_attach_direct(). If there is no driver associated to the device,
we use the generic PHY driver.

I thought the issue was the race condition between loading the module
and the MAC attaching to it? We are getting the generic driver because
the specific driver is still loading?

If that really is the issue, i think phy_attach_direct() should try
loading the module again, doing it synchronously. Only when it fails
should the generic driver be associated to the device.

       Andrew

