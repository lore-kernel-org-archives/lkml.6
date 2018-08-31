Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAFAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9EF20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2jGge9zP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9EF20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeHaSpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:45:15 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48939 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbeHaSpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=nLlobBTsa6c8BbLC229XIxBKnQaWcBS+M/8OcfJ2syY=;
        b=2jGge9zP/7UDMPdcDAdZALLvHXUEBBG5R63OjT/7EuNXtSrWf4NSPpAD8NDt45HXdNvEqbOvSKrPW6w35fA9eYMpv2G38brIle0lEYeYGPbVSRYKnDp/RoutcgSi1SWVz3OnPAhZFHlwjPYOHzqpFOPK/dTd5ZgFapJw+CT3Z84=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fvkY5-0005Zn-2X; Fri, 31 Aug 2018 16:37:21 +0200
Date:   Fri, 31 Aug 2018 16:37:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        kishon@ti.com, gregory.clement@bootlin.com, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 02/10] net: mvpp2: phylink support
Message-ID: <20180831143721.GB19733@lunn.ch>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
 <20180517082939.14598-3-antoine.tenart@bootlin.com>
 <20180827165058.GD30658@n2100.armlinux.org.uk>
 <20180831133651.GB32574@kwain>
 <20180831141123.GM30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831141123.GM30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you see any down-sides to moving the netif_carrier_off() in
> mvneta_open() to phylink_start() ?

This sounds like a good idea.

What happens on the resume path?

I've not looked at any code.... Just thinking aloud. Can we suspend
with the link up? When we resume, so long as we were not doing WoL,
the link is down. If phylink_start() is not called, we have this miss
match again.

And what about the WoL case? The link is up. What happens if you do a
netif_carrier_off() in phylink_start(), you again have a miss match.
But that case is pretty common with us developers, tftpbooting the
box, with uboot setting the link up before handing over the Linux. So
that case probably works already.

    Andrew
