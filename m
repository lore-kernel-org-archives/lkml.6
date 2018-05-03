Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeECKIu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:08:50 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:37910 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbeECKIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:08:48 -0400
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="13502425"
Subject: Re: [RFC PATCH 1/5] net: macb: Check MDIO state before read/write and
 use timeouts
To: <harinikatakamlinux@gmail.com>, <nicolas.ferre@atmel.com>,
        <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harinik@xilinx.com>, <michals@xilinx.com>, <appanad@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
References: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
 <1521726700-22634-2-git-send-email-harinikatakamlinux@gmail.com>
From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <81b5b276-e59c-79d8-1616-79ff0e9c5f17@microchip.com>
Date: Thu, 3 May 2018 13:08:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1521726700-22634-2-git-send-email-harinikatakamlinux@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.03.2018 15:51, harinikatakamlinux@gmail.com wrote:
> From: Harini Katakam <harinik@xilinx.com>
> 
> Replace the while loop in MDIO read/write functions with a timeout.
> In addition, add a check for MDIO bus busy before initiating a new
> operation as well to make sure there is no ongoing MDIO operation.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Harini Katakam <harinik@xilinx.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 54 ++++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index d09bd43..f4030c1 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -321,6 +321,21 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
>  {
>  	struct macb *bp = bus->priv;
>  	int value;
> +	ulong timeout;
> +
> +	timeout = jiffies + msecs_to_jiffies(1000);
> +	/* wait for end of transfer */
> +	do {
> +		if (MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
> +			break;
> +
> +		cpu_relax();
> +	} while (!time_after_eq(jiffies, timeout));
> +
> +	if (time_after_eq(jiffies, timeout)) {
> +		netdev_err(bp->dev, "wait for end of transfer timed out\n");
> +		return -ETIMEDOUT;
> +	}

Wouldn't be cleaner to keep it in this way:

	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR))) {
		if (time_after_eq(jiffies, timeout) {
			netdev_err(bp->dev, "wait for end of transfer timed out\n");
			return -ETIMEDOUT;
		}
		cpu_relax();
	}

>  
>  	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
>  			      | MACB_BF(RW, MACB_MAN_READ)
> @@ -328,9 +343,19 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
>  			      | MACB_BF(REGA, regnum)
>  			      | MACB_BF(CODE, MACB_MAN_CODE)));
>  
> +	timeout = jiffies + msecs_to_jiffies(1000);
>  	/* wait for end of transfer */
> -	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
> +	do {
> +		if (MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
> +			break;
> +
>  		cpu_relax();
> +	} while (!time_after_eq(jiffies, timeout));
> +
> +	if (time_after_eq(jiffies, timeout)) {
> +		netdev_err(bp->dev, "wait for end of transfer timed out\n");
> +		return -ETIMEDOUT;
> +	}
>  
>  	value = MACB_BFEXT(DATA, macb_readl(bp, MAN));
>  
> @@ -341,6 +366,21 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
>  			   u16 value)
>  {
>  	struct macb *bp = bus->priv;
> +	ulong timeout;
> +
> +	timeout = jiffies + msecs_to_jiffies(1000);
> +	/* wait for end of transfer */
> +	do {
> +		if (MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
> +			break;
> +
> +		cpu_relax();
> +	} while (!time_after_eq(jiffies, timeout));
> +
> +	if (time_after_eq(jiffies, timeout)) {
> +		netdev_err(bp->dev, "wait for end of transfer timed out\n");
> +		return -ETIMEDOUT;
> +	}
>  
>  	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
>  			      | MACB_BF(RW, MACB_MAN_WRITE)
> @@ -349,9 +389,19 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
>  			      | MACB_BF(CODE, MACB_MAN_CODE)
>  			      | MACB_BF(DATA, value)));
>  
> +	timeout = jiffies + msecs_to_jiffies(1000);
>  	/* wait for end of transfer */
> -	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
> +	do {
> +		if (MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
> +			break;
> +
>  		cpu_relax();
> +	} while (!time_after_eq(jiffies, timeout));
> +
> +	if (time_after_eq(jiffies, timeout)) {
> +		netdev_err(bp->dev, "wait for end of transfer timed out\n");
> +		return -ETIMEDOUT;
> +	}
>  
>  	return 0;
>  }
> 
