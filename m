Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E97BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FD32177E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pla+dXFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbfBOBXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:23:16 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:52949 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfBOBXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 20:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=u3eUgyFYldFIJglk/7U47Ejyv3SrbBGDZo5ySYR/Pzk=; b=pla+dXFv8mA5rIsc+9ktzzB2zK
        4kwtyEESr3BLM+slauxq5mj2G3ugDFrKytGE2xXumMg3Wyt8KOdRU+AO32gLhO96Jqh/ZB+4TgG4X
        5t0oD46zL6HLMm8b5dIc5dI7kHG/NANgYlpgb+K1Je2VOol1RKuuUB+iUEfF1zHXxCSU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1guSDf-0008Uc-0u; Fri, 15 Feb 2019 02:23:11 +0100
Date:   Fri, 15 Feb 2019 02:23:11 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH] net: phy: mdio_bus: add missing device_del() in
 mdiobus_register() error handling
Message-ID: <20190215012311.GE5699@lunn.ch>
References: <20190116095358.28354-1-thomas.petazzoni@bootlin.com>
 <20190116144829.GC25731@lunn.ch>
 <20190116161855.1d01e083@windsurf>
 <20190116154439.GA29244@lunn.ch>
 <20190211153159.6b13a687@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211153159.6b13a687@windsurf>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 03:31:59PM +0100, Thomas Petazzoni wrote:
> Even if DaveM already merged my simple fix, I had a further look at
> whether we should be using device_unregister(), and in fact we should
> not, but not really for a good reason: because the mdio API is not very
> symmetrical.
> 
> The typical flow is:
> 
> 	probe() {
> 		bus = mdiobus_alloc();
> 		if (!bus)
> 			return -ENOMEM;
> 
> 		ret = mdiobus_register(&bus);
> 		if (ret) {
> 			mdiobus_free(bus);
> 
> 		...
> 	}
> 
> 	remove() {
> 		mdiobus_unregister();
> 		mdiobus_free();
> 	}
> 
> mdiobus_alloc() only does memory allocation, i.e it has no side effects
> on the device model data structures.
> 
> mdiobus_register() does a device_register(). If it fails, it only
> cleans up with a device_del(), i.e it doesn't do the put_device() that
> it should do to fully "undo" its effect.
> 
> mdiobus_unregister() does a device_del(), i.e it also doesn't do the
> opposite of mdiobus_register(), which should be device_del() +
> put_device() (device_unregister() is a shortcut for both).
> 
> mdiobus_free() does the put_device()

Hi Thomas

You made some simplifications here. There is a state variable involved
as well. So if you do mdiobus_alloc() ; mdiobus_free(), it will not do
a put_device() but actually call free(). In that case, it is
symmetrical. 

> 
> So:
> 
>  * mdiobus_alloc() / mdiobus_free() are not symmetrical in terms of
>    their interaction with the device model data structures
> 
>  * On error, mdiobus_register() leaves a non-zero reference count to the
>    bus->dev structure, which will be freed up by mdiobus_free()
> 
>  * mdiobus_unregister() leaves a non-zero reference count to the
>    bus->dev structure, which will be freed up by mdiobus_free()
> 
> So, if we were to use device_unregister() in the error path of
> mdiobus_register() and in mdiobus_unregister(), it would break how
> mdiobus_free() works.

I compared mdiobus with alloc_netdev(), register_netdev(),
unregister_netdev() and free_netdev(). The code is actually very
similar, both have a state variable indicating UNITITIALIZED,
UNREGISTERED, REGISTERED, RELEASED, etc.  Both have asymmetric
operations.

I think the real issue here is that you cannot destroy the memory
until all references to it are released. So free_netdev() /
mdiobus_free() cannot actual use free() if the device has been
registered so there could be references to it. The free() has to
happen as part of the put_device() once the reference count reaches
zero.  If you were to do the put_device() in mdiobus_unregister()
call, by the time you called mdiobus_free(), the structure could of
already been freed, so you cannot look at the state variable to know
if it was ever registered. If it was never registered, you do need to
free it.

So the internals are asymmetric. Which is messy. But the usage of the
API by a driver is symmetric. That i think is more important.

    Andrew
