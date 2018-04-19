Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752413AbeDSMSI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 08:18:08 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:33712 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750974AbeDSMSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 08:18:06 -0400
Date: Thu, 19 Apr 2018 14:18:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jingju Hou <Jingju.Hou@synaptics.com>
Subject: Re: [PATCH] net: phy: marvell: clear wol event before setting it
Message-ID: <20180419121801.GC17888@lunn.ch>
References: <20180419160232.519d15be@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419160232.519d15be@xhacker.debian>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 04:02:32PM +0800, Jisheng Zhang wrote:
> From: Jingju Hou <Jingju.Hou@synaptics.com>
> 
> If WOL event happened once, the LED[2] interrupt pin will not be
> cleared unless reading the CSISR register. So clear the WOL event
> before enabling it.
> 
> Signed-off-by: Jingju Hou <Jingju.Hou@synaptics.com>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/net/phy/marvell.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index c22e8e383247..b6abe1cbc84b 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -115,6 +115,9 @@
>  /* WOL Event Interrupt Enable */
>  #define MII_88E1318S_PHY_CSIER_WOL_EIE			BIT(7)
>  
> +/* Copper Specific Interrupt Status Register */
> +#define MII_88E1318S_PHY_CSISR				0x13
> +
>  /* LED Timer Control Register */
>  #define MII_88E1318S_PHY_LED_TCR			0x12
>  #define MII_88E1318S_PHY_LED_TCR_FORCE_INT		BIT(15)
> @@ -1393,6 +1396,12 @@ static int m88e1318_set_wol(struct phy_device *phydev,
>  		if (err < 0)
>  			goto error;
>  
> +		/* If WOL event happened once, the LED[2] interrupt pin
> +		 * will not be cleared unless reading the CSISR register.
> +		 * So clear the WOL event first before enabling it.
> +		 */
> +		phy_read(phydev, MII_88E1318S_PHY_CSISR);
> +

Hi Jisheng

The problem with this is, you could be clearing a real interrupt, link
down/up etc. If interrupts are in use, i think the normal interrupt
handling will clear the WOL interrupt? So can you make this read
conditional on !phy_interrupt_is_valid()?

	Andrew
