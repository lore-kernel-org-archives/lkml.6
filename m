Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B5CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F3F20880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KWgTBhRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfA1Ogs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:36:48 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:57622 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfA1Ogq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZCvXVl3seXO9QAW79mn0MH69W6lVhG9oxpFU9/haKxc=; b=KWgTBhRQF+GBDdVdtfU3JO01/X
        djvoOigFvy73eRVFZVewMikLyjtAL5CThac2IIr/1Rb+z2719TpEBatQgWI2I3TSkpNX5K0vzhrng
        WADMzk94TW1xG7AV2jNJ39zK87Jm7mnEXg/OY3WYV9FhSxc1AGOkY18sMO72AkUU7/o4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1go81a-0007Kg-5b; Mon, 28 Jan 2019 15:36:34 +0100
Date:   Mon, 28 Jan 2019 15:36:34 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] mdio_bus: Fix PTR_ERR() usage after
 initialization to constant
Message-ID: <20190128143634.GF4765@lunn.ch>
References: <20190128132409.17736-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128132409.17736-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 09:24:09PM +0800, YueHaibing wrote:
> Fix coccinelle warning:
> 
> ./drivers/net/phy/mdio_bus.c:51:5-12: ERROR: PTR_ERR applied after initialization to constant on line 44
> ./drivers/net/phy/mdio_bus.c:52:5-12: ERROR: PTR_ERR applied after initialization to constant on line 44
> 
> fix this by using IS_ERR before PTR_ERR
> 
> Fixes: bafbdd527d56 ("phylib: Add device reset GPIO support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/phy/mdio_bus.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index 3d31358..802716a 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c
> @@ -42,17 +42,20 @@
>  static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
>  {
>  	struct gpio_desc *gpiod = NULL;
> +	int ret;
>  

Hi YueHaibing

I think i prefer the simpler fix:

 static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
 {
-  	struct gpio_desc *gpiod = NULL;
+       struct gpio_desc *gpiod = ERR_PTR(-ENOENT);

Totally untested...

	Andrew

>  	/* Deassert the optional reset signal */
>  	if (mdiodev->dev.of_node)
>  		gpiod = fwnode_get_named_gpiod(&mdiodev->dev.of_node->fwnode,
>  					       "reset-gpios", 0, GPIOD_OUT_LOW,
>  					       "PHY reset");
> -	if (PTR_ERR(gpiod) == -ENOENT ||
> -	    PTR_ERR(gpiod) == -ENOSYS)
> -		gpiod = NULL;
> -	else if (IS_ERR(gpiod))
> -		return PTR_ERR(gpiod);
> +	if (IS_ERR(gpiod)) {
> +		ret = PTR_ERR(gpiod);
> +		if (ret == -ENOENT || ret == -ENOSYS)
> +			gpiod = NULL;
> +		else
> +			return ret;
> +	}
>  
>  	mdiodev->reset = gpiod;
>  
> -- 
> 2.7.4
> 
> 
