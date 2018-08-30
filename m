Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB291C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE6920658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VrzDFWqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE6920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeH3V5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:57:40 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48017 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbeH3V5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=gMCS3yQpaLcaO5MfisqCQUK6USTF+oSFHCtShor2TTg=;
        b=VrzDFWqL5z0Vlbyj+oQHi1JldDdSGHJdmHsOrDGsHONlbJe7+rzxH7Vty/GHoHuAhX/SIlR4EMzMtcBaAhwq4NOpTEaeGr1ldD5jbEnwGhf7yUmSILEJr7hucTuzkm1CkBqNpdvQyNOOEEkve7VtoFv5b1Rsv0dp9O2adjWP5iQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fvR99-0001E3-40; Thu, 30 Aug 2018 19:54:19 +0200
Date:   Thu, 30 Aug 2018 19:54:19 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Moritz Fischer <moritz.fischer@ettus.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, Alex Williams <alex.williams@ni.com>
Subject: Re: [PATCH net-next 1/3] net: nixge: Add support for fixed-link
 subnodes
Message-ID: <20180830175419.GD31581@lunn.ch>
References: <20180830004046.9417-1-mdf@kernel.org>
 <20180830004046.9417-2-mdf@kernel.org>
 <20180830030420.GB16896@lunn.ch>
 <CAAtXAHe_fX9_XExvFj20a0L-=b0Z1gX410=wnR=P2DjO-hEByA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAtXAHe_fX9_XExvFj20a0L-=b0Z1gX410=wnR=P2DjO-hEByA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > The hardware has MDIO, but you don't have a PHY connected on it, and
> > use fixed link.
> 
> Since it's an FPGA design in that case we'd probably build the hardware without
> MDIO to save resources.

You can save resources, but is it worth the complexity else where,
like in the software?

> > It is important you have the mdio subnode, with PHYs and switches as
> > children. The driver currently gets this wrong, it uses
> > pdev->dev.of_node.
> 
> Oh, whoops.

Yes, and i also missed it. I generally review all new network drivers
and look at their MDIO and PHY code.

> Any good examples of drivers doing it right? Is the one going with
> the DT snippet above a good example?

That comes from the Freescale fec_main.c. It only supports DT, and
always uses of_mdiobus_register. You need to be a bit more flexible
for when you don't have DT. I'm not sure there are good example of
this, since they either don't need this flexibility, or they get it
wrong :-(

      Andrew
