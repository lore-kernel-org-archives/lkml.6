Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06FBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8871420657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ld187+yf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404661AbfAPP4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:56:54 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45398 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfAPP4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=SmZmNHlZXEL4jfTuowmEiCjHV/dMTENkDuhbQDkOdbs=;
        b=ld187+yfha7ztKT3K8kMy2ynDMPt4k5LYYvYX6OQ/eQEw28wqlTuftBUqQTCzOL0Q3S4d1vCaOYnKzlkkjFEXdJTNoxqIZLffUgeTWGAM6PtZMifhoiTcQ+F2k6vfLzLGQNL/+lhik19WGB+kVRzdmeNgAeB0eylAyxLy2z+2So=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gjnYh-0007uU-5a; Wed, 16 Jan 2019 16:56:51 +0100
Date:   Wed, 16 Jan 2019 16:56:51 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Add suspend/resume
 callbacks
Message-ID: <20190116155651.GC29244@lunn.ch>
References: <20190116153419.3208-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116153419.3208-1-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:34:19PM +0100, Miquel Raynal wrote:
> Bring S2RAM support to the mv88e6xxx DSA driver.
> 
> The content of the *_irq_poll() helper is moved in *_do_irq_poll() so
> that that the function can be called from the ->resume() callback
> without using the *work pointer.
> 
> +static int __maybe_unused mv88e6xxx_suspend(struct device *dev)
> +{
> +	struct dsa_switch *ds = dev_get_drvdata(dev);
> +	struct mv88e6xxx_chip *chip = ds->priv;
> +
> +	kthread_cancel_delayed_work_sync(&chip->irq_poll_work);
> +
> +	return dsa_switch_suspend(ds);
> +}

Hi Miquel

I don't think this is sufficient. You are leaving the switch itself
running. It will still be forwarding frames. And since the host is
shutdown, there is nothing doing spanning tree protocol. So you are
likely to cause loops in your network.

Take a look at bcm_sf2:

static int bcm_sf2_sw_suspend(struct dsa_switch *ds)
{
        struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
        unsigned int port;

        bcm_sf2_intr_disable(priv);

        /* Disable all ports physically present including the IMP
         * port, the other ones have already been disabled during
         * bcm_sf2_sw_setup
         */
        for (port = 0; port < DSA_MAX_PORTS; port++) {
                if (dsa_is_user_port(ds, port) || dsa_is_cpu_port(ds, port))
                        bcm_sf2_port_disable(ds, port, NULL);
        }

        return 0;
}

qca8k does something similar.

	Andrew
