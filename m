Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAA9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F3F20824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="amVvzpmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F3F20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406718AbeKWGJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:09:27 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:46006 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732651AbeKWGJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=m+UpwmIhRWhshYeTyDn5f7FIt6lniILPSIWuW7kciMg=;
        b=amVvzpmKUFiQyyKAz4KdM/gY2mO9AnPqfLE+IDhwK3LYGqXd5JSTax0o4bKgizqr701o8L9NTSV3PjiFsNw0Egt++xsLmy2mNnxIcqSlYKxlNlJ7j3QMjqlgFIK3f6Pd9xKuYmEs9pUz6luYwg/91J7JsUMHodF4A05OsntV0ag=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gPueT-0002tZ-4R; Thu, 22 Nov 2018 20:28:37 +0100
Date:   Thu, 22 Nov 2018 20:28:37 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH net] net: phy: mscc: fix deadlock in
 vsc85xx_default_config
Message-ID: <20181122192837.GH10697@lunn.ch>
References: <20181122131232.32032-1-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122131232.32032-1-quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 02:12:32PM +0100, Quentin Schulz wrote:
> The vsc85xx_default_config function called in the vsc85xx_config_init
> function which is used by VSC8530, VSC8531, VSC8540 and VSC8541 PHYs
> mistakenly calls phy_read and phy_write in-between phy_select_page and
> phy_restore_page.
> 
> phy_select_page and phy_restore_page actually take and release the MDIO
> bus lock so __phy_write and __phy_read (which assume that you already
> have the MDIO bus lock unlike phy_write and phy_read) should be used for
> any call in between the two said functions.
> 
> Let's fix this deadlock.
> 
> Fixes: 6a0bfbbe20b0 ("net: phy: mscc: migrate to phy_select/restore_page functions")
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  drivers/net/phy/mscc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
> index 62269e578718..6856fe4d1a60 100644
> --- a/drivers/net/phy/mscc.c
> +++ b/drivers/net/phy/mscc.c
> @@ -814,10 +814,10 @@ static int vsc85xx_default_config(struct phy_device *phydev)
>  	if (rc < 0)
>  		goto out_unlock;
>  
> -	reg_val = phy_read(phydev, MSCC_PHY_RGMII_CNTL);
> +	reg_val = __phy_read(phydev, MSCC_PHY_RGMII_CNTL);
>  	reg_val &= ~(RGMII_RX_CLK_DELAY_MASK);
>  	reg_val |= (RGMII_RX_CLK_DELAY_1_1_NS << RGMII_RX_CLK_DELAY_POS);
> -	phy_write(phydev, MSCC_PHY_RGMII_CNTL, reg_val);
> +	__phy_write(phydev, MSCC_PHY_RGMII_CNTL, reg_val);

Hi Quentin

You appear to be only accessing a single register, read/modify/write.
I think you can use phy_modify_paged(), which will take care of all
the locking for you.

    Andrew
