Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A9AC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260732082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DVz5Cea/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260732082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeJDWKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:10:20 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53844 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbeJDWKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=rLXJLGLbUNC+wDOIeuKfWvWaWFSEJwlmKlHt/R3XqaI=;
        b=DVz5Cea/KBuzLzd87yePaFXKR1jb6A8yippQzA8LiucukLL9Z+MgnhKS1iYqg/gYxQUBG8BalaIdhRgQyb56HOKoMzK+FjCVM6a7yNJSb9WBTYVPoGniKy8NWZu5jyqvwP1GDiiBNJTWo+bxQ38B1eP5PNK6vlmJE1KhOOSMRC4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g85Mc-0007EI-US; Thu, 04 Oct 2018 17:16:30 +0200
Date:   Thu, 4 Oct 2018 17:16:30 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH net-next v2 1/6] net: phy: mscc: migrate to
 phy_select/restore_page functions
Message-ID: <20181004151630.GE4730@lunn.ch>
References: <20181004124728.9821-1-quentin.schulz@bootlin.com>
 <20181004124728.9821-2-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004124728.9821-2-quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 02:47:23PM +0200, Quentin Schulz wrote:
> @@ -197,25 +199,30 @@ static int vsc85xx_mdix_set(struct phy_device *phydev, u8 mdix)
>  	if (rc != 0)
>  		return rc;
>  
> -	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_EXTENDED);
> -	if (rc != 0)
> -		return rc;
> +	oldpage = phy_select_page(phydev, MSCC_PHY_PAGE_EXTENDED);
> +	if (oldpage < 0) {
> +		rc = oldpage;
> +		goto out;
> +	}
>  
> -	reg_val = phy_read(phydev, MSCC_PHY_EXT_MODE_CNTL);
> +	reg_val = __phy_read(phydev, MSCC_PHY_EXT_MODE_CNTL);
>  	reg_val &= ~(FORCE_MDI_CROSSOVER_MASK);
>  	if (mdix == ETH_TP_MDI)
>  		reg_val |= FORCE_MDI_CROSSOVER_MDI;
>  	else if (mdix == ETH_TP_MDI_X)
>  		reg_val |= FORCE_MDI_CROSSOVER_MDIX;

Hi Quentin

Could you use phy_modify_paged() here? This function only accesses a
single register, so using the wrapper should not have any
disadvantages. The same should apply for any function modifying a single
register.

> -	rc = phy_write(phydev, MSCC_PHY_EXT_MODE_CNTL, reg_val);
> +	rc = __phy_write(phydev, MSCC_PHY_EXT_MODE_CNTL, reg_val);
>  	if (rc != 0)
> -		return rc;
> +		goto out;
>  
> -	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_STANDARD);
> -	if (rc != 0)
> +	rc = phy_restore_page(phydev, oldpage, rc);
> +	if (rc < 0)
>  		return rc;
>  
>  	return genphy_restart_aneg(phydev);
> +
> +out:
> +	return phy_restore_page(phydev, oldpage, rc);
>  }
>  
>  static int vsc85xx_downshift_get(struct phy_device *phydev, u8 *count)
> @@ -223,25 +230,24 @@ static int vsc85xx_downshift_get(struct phy_device *phydev, u8 *count)
>  	int rc;
>  	u16 reg_val;
>  
> -	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_EXTENDED);
> -	if (rc != 0)
> +	rc = phy_select_page(phydev, MSCC_PHY_PAGE_EXTENDED);
> +	if (rc < 0)
>  		goto out;
>  
> -	reg_val = phy_read(phydev, MSCC_PHY_ACTIPHY_CNTL);
> +	reg_val = __phy_read(phydev, MSCC_PHY_ACTIPHY_CNTL);
>  	reg_val &= DOWNSHIFT_CNTL_MASK;
>  	if (!(reg_val & DOWNSHIFT_EN))
>  		*count = DOWNSHIFT_DEV_DISABLE;
>  	else
>  		*count = ((reg_val & ~DOWNSHIFT_EN) >> DOWNSHIFT_CNTL_POS) + 2;

phy_read_paged()? Any function which just accesses a single register
should try to use phy_read_paged(), phy_write_paged() or
phy_modify_paged() to avoid a lot of boilerplate code.

	   Andrew
