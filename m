Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EE8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7698920824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="23VDG7MR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7698920824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504810AbeKXBwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:52:45 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:47014 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504792AbeKXBwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=+g2W/obI3cWbottSoUi5ycyOnVZOBTkOEsXK/8dB/vk=;
        b=23VDG7MRE+bBBThhLbaWS5TlCtZ0p/Pa+BhoEMUDgJcv8tO9o8slbINt/KkqpeKogaEb1XLgD+7WPaDP1dQa6IiZImfDT3aKD9EpqRYbwKHVtNHRAhnroK+SHqmAfgRaJSyuD0lPQAhcaL5KGK0OGYNqyEI1eGEsXHkjG1qOWCs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gQD3u-00089i-MK; Fri, 23 Nov 2018 16:08:06 +0100
Date:   Fri, 23 Nov 2018 16:08:06 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH net v2] net: phy: mscc: fix deadlock in
 vsc85xx_default_config
Message-ID: <20181123150806.GB30913@lunn.ch>
References: <20181123081636.18795-1-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123081636.18795-1-quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 09:16:36AM +0100, Quentin Schulz wrote:
> The vsc85xx_default_config function called in the vsc85xx_config_init
> function which is used by VSC8530, VSC8531, VSC8540 and VSC8541 PHYs
> mistakenly calls phy_read and phy_write in-between phy_select_page and
> phy_restore_page.
> 
> phy_select_page and phy_restore_page actually take and release the MDIO
> bus lock and phy_write and phy_read take and release the lock to write
> or read to a PHY register.
> 
> Let's fix this deadlock by using phy_modify_paged which handles
> correctly a read followed by a write in a non-standard page.
> 
> Fixes: 6a0bfbbe20b0 ("net: phy: mscc: migrate to phy_select/restore_page functions")
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
> 
> v2:
>  - use phy_modify_paged instead of
>  phy_select_page -> __phy_read -> __phy_write -> phy_restore_page
> 
>  drivers/net/phy/mscc.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
> index 62269e578718..4dcf7ad06259 100644
> --- a/drivers/net/phy/mscc.c
> +++ b/drivers/net/phy/mscc.c
> @@ -810,17 +810,16 @@ static int vsc85xx_default_config(struct phy_device *phydev)
>  
>  	phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
>  	mutex_lock(&phydev->lock);
> -	rc = phy_select_page(phydev, MSCC_PHY_PAGE_EXTENDED_2);
> +
> +	reg_val = RGMII_RX_CLK_DELAY_1_1_NS << RGMII_RX_CLK_DELAY_POS;
> +
> +	rc = phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_2,
> +			      MSCC_PHY_RGMII_CNTL, RGMII_RX_CLK_DELAY_MASK,
> +			      reg_val);
>  	if (rc < 0)
>  		goto out_unlock;

Hi Quentin

Isn't this goto now pointless. You are not jumping over anything.

      Andrew

>  
> -	reg_val = phy_read(phydev, MSCC_PHY_RGMII_CNTL);
> -	reg_val &= ~(RGMII_RX_CLK_DELAY_MASK);
> -	reg_val |= (RGMII_RX_CLK_DELAY_1_1_NS << RGMII_RX_CLK_DELAY_POS);
> -	phy_write(phydev, MSCC_PHY_RGMII_CNTL, reg_val);
> -
>  out_unlock:
> -	rc = phy_restore_page(phydev, rc, rc > 0 ? 0 : rc);
>  	mutex_unlock(&phydev->lock);
>  
>  	return rc;
> -- 
> 2.17.1
> 
