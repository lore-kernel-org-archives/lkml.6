Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754744AbeCVOrZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:47:25 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38977 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbeCVOrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:47:23 -0400
Date: Thu, 22 Mar 2018 15:47:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: harinikatakamlinux@gmail.com
Cc: nicolas.ferre@atmel.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, harinik@xilinx.com, michals@xilinx.com,
        appanad@xilinx.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [RFC PATCH 1/5] net: macb: Check MDIO state before read/write
 and use timeouts
Message-ID: <20180322144716.GB24516@lunn.ch>
References: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
 <1521726700-22634-2-git-send-email-harinikatakamlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521726700-22634-2-git-send-email-harinikatakamlinux@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 07:21:36PM +0530, harinikatakamlinux@gmail.com wrote:
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

Hi Harini

It looks like you have repeated the same code 4 times. Please move it
into a helper function.

     Andrew
