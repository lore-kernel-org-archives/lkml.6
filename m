Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6345AFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA0920833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PvOt3lBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA0920833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbeINWnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:43:31 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:35014 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbeINWna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=7bMh67wq6ZF6SoYKaGfvchiuTDGJQZ+2CbQv/xU2+P8=;
        b=PvOt3lBv9XFLtANXE4rhLCke5PdeYqLxaPLCqlbR5jd6ZkhdPZmYtOGxJb973TczILWqxbt0BId4g3OmgiHebvllS//vVIBy5z0kp2RHKZ7oAbr5gk7pCAir0sm2n63F3haoDb3OIp3hAwiJ18JBVj1Oazh1S9AB9g34nTouy6o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g0rso-0006E2-PS; Fri, 14 Sep 2018 19:27:54 +0200
Date:   Fri, 14 Sep 2018 19:27:54 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com
Subject: Re: [PATCH net-next 2/7] net: phy: mscc: add support for VSC8584 PHY
Message-ID: <20180914172754.GC3811@lunn.ch>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <a61d9affd3f1ec9deb60c882cce1daf37fbe2427.1536916714.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a61d9affd3f1ec9deb60c882cce1daf37fbe2427.1536916714.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>  struct vsc8531_private {
>  	int rate_magic;
>  	u16 supp_led_modes;
> @@ -181,6 +354,7 @@ struct vsc8531_private {
>  	struct vsc85xx_hw_stat *hw_stats;
>  	u64 *stats;
>  	int nstats;
> +	bool pkg_init;

> +/* bus->mdio_lock should be locked when using this function */
> +static int vsc8584_cmd(struct mii_bus *bus, int phy, u16 val)
> +{
> +	unsigned long deadline;
> +	u16 reg_val;
> +
> +	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS,
> +			MSCC_PHY_PAGE_EXTENDED_GPIO);
> +
> +	__mdiobus_write(bus, phy, MSCC_PHY_PROC_CMD, PROC_CMD_NCOMPLETED | val);

Hi Quentin

All the __mdiobus_write() look a bit ugly. Maybe add bus and base_addr
to the vsc8531_private structure. Then add helpers
phy_write_base_phy(priv, reg, val) and phy_read_base_phy(priv, reg).

You could also add in:

        if (unlikely(!mutex_is_locked(&priv->bus->mdio_lock))) {
                dev_err(bus->dev, "MDIO bus lock not held!\n");
                dump_stack();
        }

Having such code in the mv88e6xxx driver has found a few bugs for me.

       Andrew
