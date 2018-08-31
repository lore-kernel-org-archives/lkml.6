Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB53C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9132077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="C+so74F7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9132077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeHaST2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:19:28 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59950 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbeHaST2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3/PwZRknnAKzusxSbqtwFZ5wdNN6bsX5hahC5aoG0G0=; b=C+so74F7cTOMGaEqxjnNgtaCC
        fDFB1zzj2QUMjmiKOgm77nq6CaYEJ1H+E4QxJH1BrNcvWcvf7oz1fNo8vyz8440ury92lrAtE9XxL
        cUh5jH/nSCaYp6BGsJCj+U2E/Fjt238CNPPWc3aNqlS7OEVwbqy7tOu1vTIMMcLukNwf4=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:42102)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fvk93-0000E8-Jj; Fri, 31 Aug 2018 15:11:29 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fvk8z-0001GM-7R; Fri, 31 Aug 2018 15:11:25 +0100
Date:   Fri, 31 Aug 2018 15:11:23 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, kishon@ti.com, gregory.clement@bootlin.com,
        andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 02/10] net: mvpp2: phylink support
Message-ID: <20180831141123.GM30658@n2100.armlinux.org.uk>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
 <20180517082939.14598-3-antoine.tenart@bootlin.com>
 <20180827165058.GD30658@n2100.armlinux.org.uk>
 <20180831133651.GB32574@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831133651.GB32574@kwain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 03:36:51PM +0200, Antoine Tenart wrote:
> With the above code remove one case did not worked anymore: when the
> port is configured as a fixed-link because the SFP cage can't be
> described and used (on the 7040-db and 8040-db boards). In such cases
> phylink is called, mac_config() is called, but link_up() is never
> called. I'm not sure this is actually an issue in phylink, but the PPv2
> driver should probably take care of this weird case itself (by calling
> explicitly link_up()). What do you think?

Fixed link should work:

- when a fixed link is configured, link_config.link is set true.
- when phylink_start() is called, mac_config() will be called to do the
  initial setup, and a resolve is triggered.
- phylink_resolve() will read the fixed link state, which in the case
  of no GPIO, will inherit link_config.link.
  - you will then see another mac_config() call.

Now what happens depends whether you've set the netdev's carrier state
in the driver - if you haven't, the netdev's carrier state should be
off.  Since the state mismatches the link_state.link (which will be
true), you will get a mac_link_up() call.

mvneta ensures this state by always calling netif_carrier_off() in
mvneta_open(), maybe that ought to be in phylink_start() as that's the
state that phylink expects when phylink_start() has been called.  So,
maybe it's a phylink bug.

Can you see any down-sides to moving the netif_carrier_off() in
mvneta_open() to phylink_start() ?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
