Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC8DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFF220661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YkrSANv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFF220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbeHaT3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:29:50 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60830 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeHaT3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AiyhXPlgawhHcX8YvGCRU7bTKrw/LJCJmlkd1EF9oKk=; b=YkrSANv5x1GH6TybmluPnw4DE
        NSQz1w+QJ8ajkZgWpQsAIWi7u1aN64cmPu/FyI0r4Dn6Yv+uZ1oevLM51UVZRcokw5UR4MESs0oJO
        Q6zmGdrWS7wuErmVN08/vX+BMS6TVca04ecH7J1MQAjsFqPc35imJ/xKXdcP9bAdN9Ye0=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:55898)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fvlEu-0000aS-UW; Fri, 31 Aug 2018 16:21:37 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fvlEr-00020g-ME; Fri, 31 Aug 2018 16:21:33 +0100
Date:   Fri, 31 Aug 2018 16:21:31 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        kishon@ti.com, gregory.clement@bootlin.com, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 02/10] net: mvpp2: phylink support
Message-ID: <20180831152131.GN30658@n2100.armlinux.org.uk>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
 <20180517082939.14598-3-antoine.tenart@bootlin.com>
 <20180827165058.GD30658@n2100.armlinux.org.uk>
 <20180831133651.GB32574@kwain>
 <20180831141123.GM30658@n2100.armlinux.org.uk>
 <20180831143721.GB19733@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831143721.GB19733@lunn.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 04:37:21PM +0200, Andrew Lunn wrote:
> > Can you see any down-sides to moving the netif_carrier_off() in
> > mvneta_open() to phylink_start() ?
> 
> This sounds like a good idea.
> 
> What happens on the resume path?

Suspend/resume should be safe, because we force the link down when
phylink_stop() is called.

Looking at mvneta again, mvneta_stop_dev() is called in the suspend
path, which then calls phylink_stop().  This causes us to call
mac_link_down() and netif_carrier_off().  So, at the point of suspend,
the netdev carrier is set down and the mac taken down.

When resuming, mvneta_start_dev() calls phylink_start(), which undoes
the changes above, calling mac_link_up() if the link is now up.

So, as long as netdevs don't mess with the carrier state in their
suspend/resume functions, and they call phylink_start()/phylink_stop()
there, everything will work as intended - and that's really the key
issue here.

> I've not looked at any code.... Just thinking aloud. Can we suspend
> with the link up? When we resume, so long as we were not doing WoL,
> the link is down. If phylink_start() is not called, we have this miss
> match again.

It depends what you mean by "link up".  Are you talking about the PHYs
link to the external world (which is normally what's responsible for
handling WOL) or are you talking about keeping the MAC and its rings
alive so it can process packets while suspended.

If the former, that's the responsibility of phylib to manage, if the
latter, the netdev must not call phylink_stop() in its suspend function.

Either way, not messing with the netdev's carrier state is key.

The only exception to this is that the carrier should be down at open()
time.  However, I don't see anything in net/core that fiddles with the
carrier state for a net device, so the default state at boot should be
carrier-off.

I think some questions for Antoine are:

- what is the state of the carrier at the start of mvpp2_start() ?
- when does the missing call to mac_link_up() occur - is it the first
  time the netdev is brought up, or a subsequent time?
- is the carrier always off at the end of mvpp2_stop()?

Having a local reproducer may help, so if you can point to a DT fragment
and set of steps to reproduce, it could be helpful.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
