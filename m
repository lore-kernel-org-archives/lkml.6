Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeECKJw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:09:52 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:51639 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751403AbeECKJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:09:49 -0400
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="13743814"
Subject: Re: [RFC PATCH 4/5] net: macb: Add support for suspend/resume with
 full power down
To: <harinikatakamlinux@gmail.com>, <nicolas.ferre@atmel.com>,
        <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harinik@xilinx.com>, <michals@xilinx.com>, <appanad@xilinx.com>
References: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
 <1521726700-22634-5-git-send-email-harinikatakamlinux@gmail.com>
From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <35d980af-b9d5-495e-88af-c4fc911b8429@microchip.com>
Date: Thu, 3 May 2018 13:09:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1521726700-22634-5-git-send-email-harinikatakamlinux@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.03.2018 15:51, harinikatakamlinux@gmail.com wrote:
> From: Harini Katakam <harinik@xilinx.com>
> 
> When macb device is suspended and system is powered down, the clocks
> are removed and hence macb should be closed gracefully and restored
> upon resume. 

Is this a power saving mode which shut down the core?

This patch does the same by switching off the net device,
> suspending phy and performing necessary cleanup of interrupts and BDs.
> Upon resume, all these are reinitialized again.
> 
> Reset of macb device is done only when GEM is not a wake device.
> Even when gem is a wake device, tx queues can be stopped and ptp device
> can be closed (tsu clock will be disabled in pm_runtime_suspend) as
> wake event detection has no dependency on this.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> Signed-off-by: Harini Katakam <harinik@xilinx.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 38 ++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index ce75088..bca91bd 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4167,16 +4167,33 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct net_device *netdev = platform_get_drvdata(pdev);
>  	struct macb *bp = netdev_priv(netdev);
> +	struct macb_queue *queue = bp->queues;
> +	unsigned long flags;
> +	unsigned int q;
> +
> +	if (!netif_running(netdev))
> +		return 0;
>  
> -	netif_carrier_off(netdev);
> -	netif_device_detach(netdev);
>  
>  	if (bp->wol & MACB_WOL_ENABLED) {
>  		macb_writel(bp, IER, MACB_BIT(WOL));
>  		macb_writel(bp, WOL, MACB_BIT(MAG));
>  		enable_irq_wake(bp->queues[0].irq);
> +		netif_device_detach(netdev);
> +	} else {
> +		netif_device_detach(netdev);
> +		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
> +			napi_disable(&queue->napi);
> +		phy_stop(netdev->phydev);
> +		phy_suspend(netdev->phydev);
> +		spin_lock_irqsave(&bp->lock, flags);
> +		macb_reset_hw(bp);
> +		spin_unlock_irqrestore(&bp->lock, flags);

Wouldn't be simple to just call macb_close() here?

>  	}
>  
> +	netif_carrier_off(netdev);
> +	if (bp->ptp_info)
> +		bp->ptp_info->ptp_remove(netdev);
>  	pm_runtime_force_suspend(dev);
>  
>  	return 0;
> @@ -4187,6 +4204,11 @@ static int __maybe_unused macb_resume(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct net_device *netdev = platform_get_drvdata(pdev);
>  	struct macb *bp = netdev_priv(netdev);
> +	struct macb_queue *queue = bp->queues;
> +	unsigned int q;
> +
> +	if (!netif_running(netdev))
> +		return 0;
>  
>  	pm_runtime_force_resume(dev);
>  
> @@ -4194,9 +4216,21 @@ static int __maybe_unused macb_resume(struct device *dev)
>  		macb_writel(bp, IDR, MACB_BIT(WOL));
>  		macb_writel(bp, WOL, 0);
>  		disable_irq_wake(bp->queues[0].irq);
> +	} else {
> +		macb_writel(bp, NCR, MACB_BIT(MPE));
> +		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
> +			napi_enable(&queue->napi);
> +		netif_carrier_on(netdev);
> +		phy_resume(netdev->phydev);
> +		phy_start(netdev->phydev);
>  	}
>  
> +	bp->macbgem_ops.mog_init_rings(bp);
> +	macb_init_hw(bp);
> +	macb_set_rx_mode(netdev);
>  	netif_device_attach(netdev);
> +	if (bp->ptp_info)
> +		bp->ptp_info->ptp_init(netdev);

Wouln't be simpler to call macb_open() here?

>  
>  	return 0;
>  }
> 
