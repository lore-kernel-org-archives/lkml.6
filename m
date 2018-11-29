Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895F0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293E620868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XQdIZ5f5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293E620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeK2Q7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 11:59:32 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:53829 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbeK2Q7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 11:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=bxcTrYfwpWhtFlmCs28IZaAdRCUjjrf7qsMM7+kpdXI=;
        b=XQdIZ5f5H02MfszM11eQyPsf3iBkc5Q/95nFcTexdO2Lp7TMy/UbV2KwMxdTVQqU/aUvSq9YciZ+TC+ILPnkbDOCHWX+XlcB70sNellkykBefwsjzZsMmpu2SyjqDD3AUTal7ABhvZJr0enEPHKN/zZFF6P3puSoaBQ/Z0N5+vg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gSFI6-0004ic-O0; Thu, 29 Nov 2018 06:55:10 +0100
Date:   Thu, 29 Nov 2018 06:55:10 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     f.fainelli@gmail.com, sergei.shtylyov@cogentembedded.com,
        atish.patra@wdc.com, schwab@suse.de, nicolas.ferre@microchip.com,
        netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, hkallweit1@gmail.com
Subject: Re: macb: probe of 10090000.ethernet failed with error -110
Message-ID: <20181129055510.GB17675@lunn.ch>
References: <2e17bba6-d932-37b2-5dca-0963fc50f5e6@gmail.com>
 <mhng-0ddf5852-8900-4131-b3e0-81c5cc7de2eb@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-0ddf5852-8900-4131-b3e0-81c5cc7de2eb@palmer-si-x1c4>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>    diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
>    index 7cae17517744..8e0a71ee6bab 100644
>    --- a/drivers/net/phy/mscc.c
>    +++ b/drivers/net/phy/mscc.c
>    @@ -1822,6 +1822,24 @@ static int vsc85xx_probe(struct phy_device *phydev)
>     	return vsc85xx_dt_led_modes_get(phydev, default_mode);
>     }
>    +static int vsc8541_reset(struct phy_device *phydev, int value)
>    +{
>    +	WARN_ON(value != 0 || value != 1);
>    +	mdio_device_reset(&phydev->mdio, value);
>    +	if (value == 1) {
>    +		/* The VSC8541 has an unexpected feature where a single reset
>    +		 * rising edge can only be used to enter managed mode.  For
>    +		 * unmanaged mode a pair of reset rising edges is necessary.
>    +		 * */
>    +		mdio_device_reset(&phydev_mdio, 0);
>    +		mdio_device_reset(&phydev_mdio, 1);
>    +
>    +		/* After this pair of reset rising edges we must wait at least
>    +		 * 15ms before writing any phy registers. */
>    +		msleep(15);
>    +	}
>    +}
>    +
>     /* Microsemi VSC85xx PHYs */
>     static struct phy_driver vsc85xx_driver[] = {
>     {
>    @@ -1927,6 +1945,7 @@ static struct phy_driver vsc85xx_driver[] = {
>     	.get_sset_count = &vsc85xx_get_sset_count,
>     	.get_strings    = &vsc85xx_get_strings,
>     	.get_stats      = &vsc85xx_get_stats,
>    +	.reset          = &vsc8541_reset,

So if we assume you can identify the PHY using its ID registers, you
can put this reset code into the soft_reset call. That gets called
first before anything else. There is no need to add a new function to
phy_driver.

	Andrew
