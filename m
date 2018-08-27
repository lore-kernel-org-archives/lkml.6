Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D838EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B70208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="B8MQ0Fpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B70208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeH0Uiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:38:46 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52038 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeH0Uiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bFiQZOoVkV0lMxmRX7cNGgRW3PGpxzUVMDLmi4zechw=; b=B8MQ0FpyuNhW8XCOkQtTSm6QI
        I+uf7be40lI+bUtQV4VLbNrjcSuu1qgN4Aygo+E38JpvXbUd7PRuUVHrcFXF0kyi+f3alvQryLkcE
        shyRD/KUAUJFVbkR38l0vPBMkrVGLK8nxSTAsWpLrvz8v6SGNGfFqoPlvpqAfYVrtzhS4=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:51725)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fuKjK-00022H-CI; Mon, 27 Aug 2018 17:51:06 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fuKjE-0005Hy-Hm; Mon, 27 Aug 2018 17:51:00 +0100
Date:   Mon, 27 Aug 2018 17:50:59 +0100
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
Message-ID: <20180827165058.GD30658@n2100.armlinux.org.uk>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
 <20180517082939.14598-3-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517082939.14598-3-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 10:29:31AM +0200, Antoine Tenart wrote:
> +static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
> +			     const struct phylink_link_state *state)
> +{
> +	struct mvpp2_port *port = netdev_priv(dev);
> +
> +	/* Check for invalid configuration */
> +	if (state->interface == PHY_INTERFACE_MODE_10GKR && port->gop_id != 0) {
> +		netdev_err(dev, "Invalid mode on %s\n", dev->name);
> +		return;
> +	}
> +
> +	netif_tx_stop_all_queues(port->dev);
> +	if (!port->has_phy)
> +		netif_carrier_off(port->dev);
...
> +	/* If the port already was up, make sure it's still in the same state */
> +	if (state->link || !port->has_phy) {
> +		mvpp2_port_enable(port);
> +
> +		mvpp2_egress_enable(port);
> +		mvpp2_ingress_enable(port);
> +		if (!port->has_phy)
> +			netif_carrier_on(dev);
> +		netif_tx_wake_all_queues(dev);
> +	}

I'm guessing that the above is what is classed as "small fixes"
in the cover letter for this series - as such I didn't look closely
at this patch, but I should have, because this is not a "small fix".
I don't find the above code in previous patches, and I don't find
any description about why this has changed.

I'm on record for having said (many times) that drivers that are
converted to phylink should _not_ mess with the net device carrier
state themselves, but should leave it to phylink to manage.

The above appears to cause a problem when testing on a singleshot
mcbin board - as a direct result of the above, I find that _all_
the network devices apparently have link, including those which
have no SFP inserted into the cage.  This results in debian jessie
hanging at boot for over 1 minute while systemd tries to bring up
all network devices.

The same should be true of the doubleshot board's 1G cage - which
is the same as the singleshot in every respect, and the singleshot
exhibits this problem there as well.  I haven't actually tested
this on the doubleshot though.

Have you identified a case where mac_config() is called with the
link up for which a major reconfiguration is required?  mac_config()
will get called for small reconfigurations such as changing the
pause parameters (which should _not_ require the queues to be
restarted) but the link should always be down for major
reconfigurations such sa changing the PHY interface mode.

mac_config() can also be called when nothing has changed - if we've
decided to re-run the link state resolve, it can be called with the
same parameters as previously, especially now that we have polling
of a GPIO for link state monitoring.  With your code above, this will
cause mvpp2 to down/up the carrier state every second.

Note that state->link here is the _future_ state of the link, which
may change state before the mac_link_up()/down() functions have been
called - turning the carrier on/off like this will prevent these
callbacks being made, and the link state being printed by phylink.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
