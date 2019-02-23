Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE5EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 15:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0567720684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 15:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j646Hl3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfBWPZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 10:25:45 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:36131 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfBWPZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 10:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CRQwEQzjztiQ4ff0Ub/tPThKUBLrzw/3lLd+v4EOqVk=; b=j646Hl3yCGAdrbOYUtYvXWDdl1
        6NiMGMABcS+7tgQMbEx7df4k8I14MKQ/fQdRaaYX2WolE/61bHqpo03N9qK2bRr7Tg177bEBpxvnP
        cxGKSdEAQoabqRrLVlsznTH5zIzuL//+Go7ymFyUI0gxD2ewhHn2nNFZwZPazLVfDLrg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gxZBM-0003Mi-9M; Sat, 23 Feb 2019 16:25:40 +0100
Date:   Sat, 23 Feb 2019 16:25:40 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        netdev@vger.kernel.org, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, rafalc@cadence.com,
        piotrs@cadence.com, jank@cadence.com
Subject: Re: [PATCH 2/3] net: ethernet: add c45 PHY support in MDIO
 read/write functions.
Message-ID: <20190223152540.GE10693@lunn.ch>
References: <20190222201242.GA20889@lvlogina.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222201242.GA20889@lvlogina.cadence.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 08:12:42PM +0000, Parshuram Thombare wrote:
> This patch modify MDIO read/write functions to support
> communication with C45 PHY in Cadence ethernet controller driver.
> 
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      |   15 +++++--
>  drivers/net/ethernet/cadence/macb_main.c |   61 ++++++++++++++++++++++++-----
>  2 files changed, 61 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index bed4ded..59c23e0 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -636,10 +636,17 @@
>  #define GEM_CLK_DIV96				5
>  
>  /* Constants for MAN register */
> -#define MACB_MAN_SOF				1
> -#define MACB_MAN_WRITE				1
> -#define MACB_MAN_READ				2
> -#define MACB_MAN_CODE				2
> +#define MACB_MAN_C22_SOF                        1
> +#define MACB_MAN_C22_WRITE                      1
> +#define MACB_MAN_C22_READ                       2
> +#define MACB_MAN_C22_CODE                       2
> +
> +#define MACB_MAN_C45_SOF                        0
> +#define MACB_MAN_C45_ADDR                       0
> +#define MACB_MAN_C45_WRITE                      1
> +#define MACB_MAN_C45_POST_READ_INCR             2
> +#define MACB_MAN_C45_READ                       3
> +#define MACB_MAN_C45_CODE                       2
>  
>  /* Capability mask bits */
>  #define MACB_CAPS_ISR_CLEAR_ON_WRITE		0x00000001
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 4f4f8e5..2494abf 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -323,11 +323,30 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
>  	struct macb *bp = bus->priv;
>  	int value;
>  
> -	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
> -			      | MACB_BF(RW, MACB_MAN_READ)
> -			      | MACB_BF(PHYA, mii_id)
> -			      | MACB_BF(REGA, regnum)
> -			      | MACB_BF(CODE, MACB_MAN_CODE)));
> +	if (regnum & MII_ADDR_C45) {
> +		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C45_SOF)
> +				| MACB_BF(RW, MACB_MAN_C45_ADDR)
> +				| MACB_BF(PHYA, mii_id)
> +				| MACB_BF(REGA, (regnum >> 16) & 0x1F)
> +				| MACB_BF(DATA, regnum & 0xFFFF)
> +				| MACB_BF(CODE, MACB_MAN_C45_CODE)));
> +
> +	/* wait for end of transfer */
> +	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
> +		cpu_relax();

You need a timeout here, and anywhere you wait for the hardware to
complete. Try to make use of readx_poll_timeout() variants.

	  Andrew
