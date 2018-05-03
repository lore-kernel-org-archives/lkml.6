Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbeECKJl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:09:41 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:32375 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751403AbeECKJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:09:39 -0400
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="14449272"
Subject: Re: [RFC PATCH 3/5] net: macb: Add pm runtime support
To: <harinikatakamlinux@gmail.com>, <nicolas.ferre@atmel.com>,
        <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harinik@xilinx.com>, <michals@xilinx.com>, <appanad@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
References: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
 <1521726700-22634-4-git-send-email-harinikatakamlinux@gmail.com>
From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <48b8ea24-52be-c314-f674-1a6cae4d95f4@microchip.com>
Date: Thu, 3 May 2018 13:09:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1521726700-22634-4-git-send-email-harinikatakamlinux@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.03.2018 15:51, harinikatakamlinux@gmail.com wrote:
> From: Harini Katakam <harinik@xilinx.com>
> 
> Add runtime pm functions and move clock handling there.
> Enable clocks in mdio read/write functions.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Harini Katakam <harinik@xilinx.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 105 ++++++++++++++++++++++++++-----
>  1 file changed, 90 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index ae61927..ce75088 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -35,6 +35,7 @@
>  #include <linux/ip.h>
>  #include <linux/udp.h>
>  #include <linux/tcp.h>
> +#include <linux/pm_runtime.h>
>  #include "macb.h"
>  
>  #define MACB_RX_BUFFER_SIZE	128
> @@ -77,6 +78,7 @@
>   * 1 frame time (10 Mbits/s, full-duplex, ignoring collisions)
>   */
>  #define MACB_HALT_TIMEOUT	1230
> +#define MACB_PM_TIMEOUT  100 /* ms */
>  
>  /* DMA buffer descriptor might be different size
>   * depends on hardware configuration:
> @@ -321,8 +323,13 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
>  {
>  	struct macb *bp = bus->priv;
>  	int value;
> +	int err;
>  	ulong timeout;
>  
> +	err = pm_runtime_get_sync(&bp->pdev->dev);
> +	if (err < 0)

You have to call pm_runtime_put_noidle() or something similar to decrement the
dev->power.usage_count.

> +		return err;
> +
>  	timeout = jiffies + msecs_to_jiffies(1000);
>  	/* wait for end of transfer */
>  	do {
> @@ -334,6 +341,8 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
>  
>  	if (time_after_eq(jiffies, timeout)) {
>  		netdev_err(bp->dev, "wait for end of transfer timed out\n");

For this:

> +		pm_runtime_mark_last_busy(&bp->pdev->dev);
> +		pm_runtime_put_autosuspend(&bp->pdev->dev);>  		return -ETIMEDOUT;
>  	}
>  
> @@ -354,11 +363,15 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
>  
>  	if (time_after_eq(jiffies, timeout)) {
>  		netdev_err(bp->dev, "wait for end of transfer timed out\n");

And this:

> +		pm_runtime_mark_last_busy(&bp->pdev->dev);
> +		pm_runtime_put_autosuspend(&bp->pdev->dev);
>  		return -ETIMEDOUT;

I would use a "goto" instruction, e.g.:
  		value = -ETIMEDOUT;
		goto out;

>  	}
>  
>  	value = MACB_BFEXT(DATA, macb_readl(bp, MAN));
>  

out:
> +	pm_runtime_mark_last_busy(&bp->pdev->dev);
> +	pm_runtime_put_autosuspend(&bp->pdev->dev);
>  	return value;
>  }
>  
> @@ -366,8 +379,13 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
>  			   u16 value)
>  {
>  	struct macb *bp = bus->priv;
> +	int err;
>  	ulong timeout;
>  
> +	err = pm_runtime_get_sync(&bp->pdev->dev);> +	if (err < 0)

Ditto

> +		return err;
> +
>  	timeout = jiffies + msecs_to_jiffies(1000);
>  	/* wait for end of transfer */
>  	do {
> @@ -379,6 +397,8 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
>  
>  	if (time_after_eq(jiffies, timeout)) {
>  		netdev_err(bp->dev, "wait for end of transfer timed out\n");

Ditto

> +		pm_runtime_mark_last_busy(&bp->pdev->dev);
> +		pm_runtime_put_autosuspend(&bp->pdev->dev);
>  		return -ETIMEDOUT;
>  	}
>  
> @@ -400,9 +420,13 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
>  
>  	if (time_after_eq(jiffies, timeout)) {
>  		netdev_err(bp->dev, "wait for end of transfer timed out\n");
> +		pm_runtime_mark_last_busy(&bp->pdev->dev);
> +		pm_runtime_put_autosuspend(&bp->pdev->dev);

Ditto

>  		return -ETIMEDOUT;
>  	}
>  
> +	pm_runtime_mark_last_busy(&bp->pdev->dev);
> +	pm_runtime_put_autosuspend(&bp->pdev->dev);
>  	return 0;
>  }
>  
> @@ -2338,6 +2362,10 @@ static int macb_open(struct net_device *dev)
>  
>  	netdev_dbg(bp->dev, "open\n");
>  
> +	err = pm_runtime_get_sync(&bp->pdev->dev);
> +	if (err < 0)

Ditto

> +		return err;
> +

Below, in macb_open() you have a return err; case:
	err = macb_alloc_consistent(bp);
	if (err) {
		netdev_err(dev, "Unable to allocate DMA memory (error %d)\n",
			   err);
		return err;
	}

You have to undo pm_runtime_get_sync() with pm_runtime_put_sync() or something
similar to decrement dev->power.usage_count.
	
>  	/* carrier starts down */
>  	netif_carrier_off(dev);
>  
> @@ -2397,6 +2425,8 @@ static int macb_close(struct net_device *dev)
>  	if (bp->ptp_info)
>  		bp->ptp_info->ptp_remove(dev);
>  
> +	pm_runtime_put(&bp->pdev->dev);
> +
>  	return 0;
>  }
>  
> @@ -3949,6 +3979,11 @@ static int macb_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, MACB_PM_TIMEOUT);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
>  	native_io = hw_is_native_io(mem);
>  
>  	macb_probe_queues(mem, native_io, &queue_mask, &num_queues);
> @@ -4062,6 +4097,9 @@ static int macb_probe(struct platform_device *pdev)
>  		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
>  		    dev->base_addr, dev->irq, dev->dev_addr);
>  
> +	pm_runtime_mark_last_busy(&bp->pdev->dev);
> +	pm_runtime_put_autosuspend(&bp->pdev->dev);
> +
>  	return 0;
>  
>  err_out_unregister_mdio:
> @@ -4081,6 +4119,9 @@ static int macb_probe(struct platform_device *pdev)
>  	clk_disable_unprepare(pclk);
>  	clk_disable_unprepare(rx_clk);
>  	clk_disable_unprepare(tsu_clk);
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  
>  	return err;
>  }
> @@ -4104,11 +4145,16 @@ static int macb_remove(struct platform_device *pdev)
>  		mdiobus_free(bp->mii_bus);
>  
>  		unregister_netdev(dev);
> -		clk_disable_unprepare(bp->tx_clk);
> -		clk_disable_unprepare(bp->hclk);
> -		clk_disable_unprepare(bp->pclk);
> -		clk_disable_unprepare(bp->rx_clk);
> -		clk_disable_unprepare(bp->tsu_clk);
> +		pm_runtime_disable(&pdev->dev);
> +		pm_runtime_dont_use_autosuspend(&pdev->dev);
> +		if (!pm_runtime_suspended(&pdev->dev)) {
> +			clk_disable_unprepare(bp->tx_clk);
> +			clk_disable_unprepare(bp->hclk);
> +			clk_disable_unprepare(bp->pclk);
> +			clk_disable_unprepare(bp->rx_clk);
> +			clk_disable_unprepare(bp->tsu_clk);
> +			pm_runtime_set_suspended(&pdev->dev);

This is driver remove function. Shouldn't clocks be removed?

> +		}>  		of_node_put(bp->phy_node);
>  		free_netdev(dev);
>  	}
> @@ -4129,13 +4175,9 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  		macb_writel(bp, IER, MACB_BIT(WOL));
>  		macb_writel(bp, WOL, MACB_BIT(MAG));
>  		enable_irq_wake(bp->queues[0].irq);
> -	} else {
> -		clk_disable_unprepare(bp->tx_clk);
> -		clk_disable_unprepare(bp->hclk);
> -		clk_disable_unprepare(bp->pclk);
> -		clk_disable_unprepare(bp->rx_clk);
>  	}
> -	clk_disable_unprepare(bp->tsu_clk);
> +
> +	pm_runtime_force_suspend(dev);
>  
>  	return 0;
>  }
> @@ -4146,11 +4188,43 @@ static int __maybe_unused macb_resume(struct device *dev)
>  	struct net_device *netdev = platform_get_drvdata(pdev);
>  	struct macb *bp = netdev_priv(netdev);
>  
> +	pm_runtime_force_resume(dev);
> +
>  	if (bp->wol & MACB_WOL_ENABLED) {
>  		macb_writel(bp, IDR, MACB_BIT(WOL));
>  		macb_writel(bp, WOL, 0);
>  		disable_irq_wake(bp->queues[0].irq);
> -	} else {
> +	}
> +
> +	netif_device_attach(netdev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused macb_runtime_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct net_device *netdev = platform_get_drvdata(pdev);
> +	struct macb *bp = netdev_priv(netdev);
> +
> +	if (!(device_may_wakeup(&bp->dev->dev))) {
> +		clk_disable_unprepare(bp->tx_clk);
> +		clk_disable_unprepare(bp->hclk);
> +		clk_disable_unprepare(bp->pclk);
> +		clk_disable_unprepare(bp->rx_clk);
> +	}
> +	clk_disable_unprepare(bp->tsu_clk);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused macb_runtime_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct net_device *netdev = platform_get_drvdata(pdev);
> +	struct macb *bp = netdev_priv(netdev);
> +
> +	if (!(device_may_wakeup(&bp->dev->dev))) {
>  		clk_prepare_enable(bp->pclk);
>  		clk_prepare_enable(bp->hclk);
>  		clk_prepare_enable(bp->tx_clk);
> @@ -4158,12 +4232,13 @@ static int __maybe_unused macb_resume(struct device *dev)
>  	}
>  	clk_prepare_enable(bp->tsu_clk);
>  
> -	netif_device_attach(netdev);
> -
>  	return 0;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(macb_pm_ops, macb_suspend, macb_resume);
> +static const struct dev_pm_ops macb_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(macb_suspend, macb_resume)
> +	SET_RUNTIME_PM_OPS(macb_runtime_suspend, macb_runtime_resume, NULL)
> +};
>  
>  static struct platform_driver macb_driver = {
>  	.probe		= macb_probe,
> 
