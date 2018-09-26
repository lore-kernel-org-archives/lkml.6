Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520DBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094DE2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094DE2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeIZUz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:55:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51565 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbeIZUz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:55:59 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 529F3206DE; Wed, 26 Sep 2018 16:42:40 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3F9CC208D9;
        Wed, 26 Sep 2018 16:42:18 +0200 (CEST)
Date:   Wed, 26 Sep 2018 16:42:19 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] phy: mscc: fix printf format
Message-ID: <20180926144219.GE16644@piout.net>
References: <20180926132021.2933754-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926132021.2933754-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2018 15:20:11+0200, Arnd Bergmann wrote:
> gcc points out that the length of the temporary buffer may not be sufficient for
> large numbers of leds:
> 
> drivers/net/phy/mscc.c: In function 'vsc85xx_probe':
> drivers/net/phy/mscc.c:460:45: error: '-mode' directive writing 5 bytes into a region of size between 0 and 9 [-Werror=format-overflow=]
>    ret = sprintf(led_dt_prop, "vsc8531,led-%d-mode", i);
>                                              ^~~~~
> drivers/net/phy/mscc.c:460:9: note: 'sprintf' output between 19 and 28 bytes into a destination of size 22
>    ret = sprintf(led_dt_prop, "vsc8531,led-%d-mode", i);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> While we can make a reasonable assumption that the number of LEDs is small,
> the cost of making the buffer a little bigger is insignificant as well.
> 
> Fixes: 11bfdabb7ff5 ("net: phy: mscc: factorize code for LEDs mode")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/net/phy/mscc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
> index 2d9676d78d3f..7d0384e26c99 100644
> --- a/drivers/net/phy/mscc.c
> +++ b/drivers/net/phy/mscc.c
> @@ -453,7 +453,7 @@ static int vsc85xx_dt_led_modes_get(struct phy_device *phydev,
>  				    u32 *default_mode)
>  {
>  	struct vsc8531_private *priv = phydev->priv;
> -	char led_dt_prop[19];
> +	char led_dt_prop[28];
>  	int i, ret;
>  
>  	for (i = 0; i < priv->nleds; i++) {
> -- 
> 2.18.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
