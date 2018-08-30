Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98E3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775DB20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sP6xgVkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775DB20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeH3VqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:46:17 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48003 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbeH3VqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=iPpgRrWsxDnPqjMElfLEWocL8UoqMVQCyvagPcW3hAE=;
        b=sP6xgVkzHufsSZwKQlft6uj16D5c9savAUC8fpjdokO+EIl1nvjl/UhMJooT3IqIh8cGAsFgF3CIPJr87g+LkKyTqdikY3CxtFEtQ9phtCQYdvfhBJ7SfSXSSs1ne09bC2PQbmiLIaj+RyFfz4XwJStByEIZy59KJg66DsrIwqE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fvQy8-0001Am-Ow; Thu, 30 Aug 2018 19:42:56 +0200
Date:   Thu, 30 Aug 2018 19:42:56 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Moritz Fischer <moritz.fischer@ettus.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, Alex Williams <alex.williams@ni.com>
Subject: Re: [PATCH net-next 2/3] net: nixge: Add support for having nixge as
 subdevice
Message-ID: <20180830174256.GC31581@lunn.ch>
References: <20180830004046.9417-1-mdf@kernel.org>
 <20180830004046.9417-3-mdf@kernel.org>
 <20180830031110.GC16896@lunn.ch>
 <CAAtXAHceYgPx4A7F14AYEQs9RFo2hP6JTkApHa_GtbxVcdiQNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAtXAHceYgPx4A7F14AYEQs9RFo2hP6JTkApHa_GtbxVcdiQNA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:39:39AM -0700, Moritz Fischer wrote:
> Hi Andrew,
> 
> On Wed, Aug 29, 2018 at 8:11 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > Could you tell us more about the parent device. I'm guessing PCIe.  Is
> > it x86 so no device tree? Are there cases where it does not have a PHY
> > connected? What is connected instead? SFP? A switch? Can there be
> > multiple PHYs on the MDIO bus?
> 
> The device is part of a larger FPGA design. One use case that I was trying
> to support with this patch is PCIe with x86 (hopefully on it's own PF...)
> Since the whole design isn't completely done, these are the use cases I
> see upcoming and current:
> 
> ARM(64):
> a) DT: PHY over MDIO (current use case), fixed-link with GPIO (coming)
> b) DT: SFP (potentially coming)
> 
> x86:
> a) no PHY (coming)-> fixed-link with GPIO
> b) SFP (potentially), PHY over MDIO (potentially)

Hi Mortiz

For SFP, you need to convert this driver to use phylink. That will
also help you with fixed-link, since phylink will handle probing that
for you.

But this brings its own problems. phylink and sfp currently has no
support for platform devices. The SFP driver needs to know which i2c
bus to use, and which GPIOs are connected to the SFP. phylink parses
the device tree to find out if there is an SFP device, or a fixed
link, etc. I don't know of any conceptual reason why platform data
would not work, it just needs implementing.

There also does not appear to be any in kernel users of the device
tree binding. That gives you some flexibility in that you could think
about making non-backwards compatible changes in the binding. I would
definitely want to move PHYs into an mdio subnode.

I'm not aware of any x86 drivers using fixed link. What they generally
do is register the mdio bus using mdiobus_register() and then use
phy_find_first() to get a PHY. This works O.K. for PCs, laptops, and
PCIe cards where there is only one PHY on the bus. What you might be
able to do is always register the MDIO bus, and if you fail to find a
PHY, instantiate a fixed-link and use that instead.

Reality is, all the core work in this area has been pushed by the
embedded world, which is ARM and device tree. For Intel and Server
style networking, drivers tend to either ignore the Linux core code
and write there own PHY and MDIO bus drivers, or it is all done in
firmware.

     Andrew
