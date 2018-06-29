Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0F8C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C98624F8D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cWAh4Eln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C98624F8D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966623AbeF2PpH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:45:07 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47412 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932658AbeF2PpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=uHHhXoVCo1e55ybzhcJfcxHdXqESXbPa7DpzDV5aqqQ=;
        b=cWAh4ElnB1b2jXwHhycYNwLvv8dWNTj4VCLEF4/e9NechmAPJTFGJ4pIWsPL8nPsm+HUra5C14MyH0P7J0riCZRKdKQQn+PyLnFaASt6zB6wQ22SXT4cHlA7uTDGFV/ysuQMia5Ml4fZilAhUbgvStqH+crYi4BB+Cp1QOTd4zU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fYva2-0006Tg-Hn; Fri, 29 Jun 2018 17:45:02 +0200
Date:   Fri, 29 Jun 2018 17:45:02 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: phy: DP83TC811: Add INT_STAT3
Message-ID: <20180629154502.GG11285@lunn.ch>
References: <20180629153546.24107-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629153546.24107-1-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 10:35:45AM -0500, Dan Murphy wrote:
> Add INT_STAT3 interrupt setting and clearing
> support.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v2 - Removed bug fix removal of writing INT_STAT1 twice when disabling interrupts
> 
>  drivers/net/phy/dp83tc811.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83tc811.c b/drivers/net/phy/dp83tc811.c
> index 49ac678eb2dc..f8653f5d8789 100644
> --- a/drivers/net/phy/dp83tc811.c
> +++ b/drivers/net/phy/dp83tc811.c
> @@ -21,6 +21,7 @@
>  #define MII_DP83811_SGMII_CTRL	0x09
>  #define MII_DP83811_INT_STAT1	0x12
>  #define MII_DP83811_INT_STAT2	0x13
> +#define MII_DP83811_INT_STAT3	0x18
>  #define MII_DP83811_RESET_CTRL	0x1f
>  
>  #define DP83811_HW_RESET	BIT(15)
> @@ -44,6 +45,11 @@
>  #define DP83811_OVERVOLTAGE_INT_EN	BIT(6)
>  #define DP83811_UNDERVOLTAGE_INT_EN	BIT(7)
>  
> +/* INT_STAT3 bits */
> +#define DP83811_LPS_INT_EN	BIT(0)
> +#define DP83811_NO_FRAME_INT_EN	BIT(3)
> +#define DP83811_POR_DONE_INT_EN	BIT(4)
> +
>  #define MII_DP83811_RXSOP1	0x04a5
>  #define MII_DP83811_RXSOP2	0x04a6
>  #define MII_DP83811_RXSOP3	0x04a7
> @@ -81,6 +87,10 @@ static int dp83811_ack_interrupt(struct phy_device *phydev)
>  	if (err < 0)
>  		return err;
>  
> +	err = phy_read(phydev, MII_DP83811_INT_STAT3);
> +	if (err < 0)
> +		return err;
> +
>  	return 0;
>  }
>  
> @@ -216,6 +226,18 @@ static int dp83811_config_intr(struct phy_device *phydev)
>  				DP83811_UNDERVOLTAGE_INT_EN);
>  
>  		err = phy_write(phydev, MII_DP83811_INT_STAT2, misr_status);

Hi Dan

Isn't this going to fail to apply because net-next says STAT1 here?

That is why i said you need to wait for David to merge net into
net-next. Then you can submit these patches, and not have conflicts.

	  Andrew
