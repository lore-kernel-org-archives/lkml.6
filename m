Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95121C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F3720661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F3720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeHaTQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:16:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46822 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbeHaTQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:16:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 698442071E; Fri, 31 Aug 2018 17:08:49 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3712C203EC;
        Fri, 31 Aug 2018 17:08:39 +0200 (CEST)
Date:   Fri, 31 Aug 2018 17:08:38 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        kishon@ti.com, gregory.clement@bootlin.com, andrew@lunn.ch,
        jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 02/10] net: mvpp2: phylink support
Message-ID: <20180831150838.GE32574@kwain>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
 <20180517082939.14598-3-antoine.tenart@bootlin.com>
 <20180827165058.GD30658@n2100.armlinux.org.uk>
 <20180831133651.GB32574@kwain>
 <20180831141123.GM30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180831141123.GM30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Fri, Aug 31, 2018 at 03:11:23PM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 31, 2018 at 03:36:51PM +0200, Antoine Tenart wrote:
> > With the above code remove one case did not worked anymore: when the
> > port is configured as a fixed-link because the SFP cage can't be
> > described and used (on the 7040-db and 8040-db boards). In such cases
> > phylink is called, mac_config() is called, but link_up() is never
> > called. I'm not sure this is actually an issue in phylink, but the PPv2
> > driver should probably take care of this weird case itself (by calling
> > explicitly link_up()). What do you think?
> 
> Fixed link should work:
> 
> - when a fixed link is configured, link_config.link is set true.
> - when phylink_start() is called, mac_config() will be called to do the
>   initial setup, and a resolve is triggered.
> - phylink_resolve() will read the fixed link state, which in the case
>   of no GPIO, will inherit link_config.link.
>   - you will then see another mac_config() call.
> 
> Now what happens depends whether you've set the netdev's carrier state
> in the driver - if you haven't, the netdev's carrier state should be
> off.  Since the state mismatches the link_state.link (which will be
> true), you will get a mac_link_up() call.

OK, that makes sense. Thanks for the explanations.

> mvneta ensures this state by always calling netif_carrier_off() in
> mvneta_open(), maybe that ought to be in phylink_start() as that's the
> state that phylink expects when phylink_start() has been called.  So,
> maybe it's a phylink bug.
> 
> Can you see any down-sides to moving the netif_carrier_off() in
> mvneta_open() to phylink_start() ?

I removed most of my previous fix, and called netif_carrier_off() just
before phylink_start() in PPv2. I worked, and it seemed to me all cases
were working fine.

As calling netif_carrier_off() seems to be a phylink assumption, I would
agree to call it directly from within phylink_start(). But I don't have
the full picture here.

If such a solution is OK for you, and if no one raises an issue in the
next days, I can send a series to add a netif_carrier_off() call, fix
PPv2, and remove mvneta's call to netif_carrier_off() in mvneta_open().

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
