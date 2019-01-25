Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F83DC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240E1218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jrM/uxrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfAYPAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:00:18 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:55720 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfAYPAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vj3C7OyAui/Gs3zjsUIsHTINfUeXshAblM3oKnQKT18=; b=jrM/uxrjymGpV8xveYBWB6UOtt
        I7DCyKbZOtWNmcVCc29ghswFN3IfWYJz2WA3HHLEaxRBD754E1M5ne4MtZSiQR4LW4kUzC5QZz3TZ
        WO5tVpXS0NBB5LJKe9OXC4orK34cn9e0X31MNCFrw0iPtTWpVW1YWhk/kJgEfvZS7G4o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gn2xp-0004T2-VY; Fri, 25 Jan 2019 16:00:13 +0100
Date:   Fri, 25 Jan 2019 16:00:13 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Carlo Caione <ccaione@baylibre.com>
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: at803x: Use helpers to access MMD PHY registers
Message-ID: <20190125150013.GG12962@lunn.ch>
References: <20190125123510.20511-1-ccaione@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125123510.20511-1-ccaione@baylibre.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 12:35:10PM +0000, Carlo Caione wrote:
> Libphy provides a standard set of helpers to access the MMD PHY
> registers. Use those instead of relying on custom driver-specific
> functions.

Hi Carlo

Maybe deja vu, but i thought a similar patch went by recently?

Anyway,

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  drivers/net/phy/at803x.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index f9432d053a22..23ba76f8d950 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
> @@ -39,9 +39,6 @@
>  #define AT803X_LOC_MAC_ADDR_0_15_OFFSET		0x804C
>  #define AT803X_LOC_MAC_ADDR_16_31_OFFSET	0x804B
>  #define AT803X_LOC_MAC_ADDR_32_47_OFFSET	0x804A
> -#define AT803X_MMD_ACCESS_CONTROL		0x0D
> -#define AT803X_MMD_ACCESS_CONTROL_DATA		0x0E
> -#define AT803X_FUNC_DATA			0x4003
>  #define AT803X_REG_CHIP_CONFIG			0x1f
>  #define AT803X_BT_BX_REG_SEL			0x8000
>  
> @@ -168,16 +165,9 @@ static int at803x_set_wol(struct phy_device *phydev,
>  		if (!is_valid_ether_addr(mac))
>  			return -EINVAL;
>  
> -		for (i = 0; i < 3; i++) {
> -			phy_write(phydev, AT803X_MMD_ACCESS_CONTROL,
> -				  AT803X_DEVICE_ADDR);
> -			phy_write(phydev, AT803X_MMD_ACCESS_CONTROL_DATA,
> -				  offsets[i]);
> -			phy_write(phydev, AT803X_MMD_ACCESS_CONTROL,
> -				  AT803X_FUNC_DATA);
> -			phy_write(phydev, AT803X_MMD_ACCESS_CONTROL_DATA,
> -				  mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
> -		}
> +		for (i = 0; i < 3; i++)
> +			phy_write_mmd(phydev, AT803X_DEVICE_ADDR, offsets[i],
> +				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
>  
>  		value = phy_read(phydev, AT803X_INTR_ENABLE);
>  		value |= AT803X_INTR_ENABLE_WOL;
> -- 
> 2.19.1
> 
