Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbeEDMRK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:17:10 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:15727 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbeEDMRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:17:08 -0400
X-IronPort-AV: E=Sophos;i="5.49,362,1520924400";
   d="scan'208";a="13542053"
Subject: Re: [RFC PATCH 5/5] net: macb: Add WOL support with ARP
To: <harinikatakamlinux@gmail.com>, <nicolas.ferre@atmel.com>,
        <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harinik@xilinx.com>, <michals@xilinx.com>, <appanad@xilinx.com>
References: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
 <1521726700-22634-6-git-send-email-harinikatakamlinux@gmail.com>
From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <51e1b2f3-4dd7-3513-2148-649372775130@microchip.com>
Date: Fri, 4 May 2018 15:17:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1521726700-22634-6-git-send-email-harinikatakamlinux@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.03.2018 15:51, harinikatakamlinux@gmail.com wrote:
> From: Harini Katakam <harinik@xilinx.com>
> 
> This patch enables ARP wake event support in GEM through the following:
> 
> -> WOL capability can be selected based on the SoC/GEM IP version rather
> than a devictree property alone. Hence add a new capability property and
> set device as "wakeup capable" in probe in this case.
> -> Wake source selection can be done via ethtool or by enabling wakeup
> in /sys/devices/platform/..../ethx/power/
> This patch adds default wake source as ARP and the existing selection of
> WOL using magic packet remains unchanged.
> -> When GEM is the wake device with ARP as the wake event, the current
> IP address to match is written to WOL register along with other
> necessary confuguration required for MAC to recognize an ARP event.
> -> While RX needs to remain enabled, there is no need to process the
> actual wake packet - hence tie off all RX queues to avoid unnecessary
> processing by DMA in the background. 

Why is this different for magic packet vs ARP packet?

This tie off is done using a
> dummy buffer descriptor with used bit set. (There is no other provision
> to disable RX DMA in the GEM IP version in ZynqMP)
> -> TX is disabled and all interrupts except WOL on Q0 are disabled.
> Clear the WOL interrupt as no other action is required from driver.
> Power management of the SoC will already have got the event and will
> take care of initiating resume.
> -> Upon resume ARP WOL config is cleared and macb is reinitialized.
> 
> Signed-off-by: Harini Katakam <harinik@xilinx.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      |   6 ++
>  drivers/net/ethernet/cadence/macb_main.c | 130 +++++++++++++++++++++++++++++--
>  2 files changed, 131 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 9e7fb14..e18ff34 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -93,6 +93,7 @@
>  #define GEM_SA3T		0x009C /* Specific3 Top */
>  #define GEM_SA4B		0x00A0 /* Specific4 Bottom */
>  #define GEM_SA4T		0x00A4 /* Specific4 Top */
> +#define GEM_WOL			0x00B8 /* Wake on LAN */
>  #define GEM_EFTSH		0x00e8 /* PTP Event Frame Transmitted Seconds Register 47:32 */
>  #define GEM_EFRSH		0x00ec /* PTP Event Frame Received Seconds Register 47:32 */
>  #define GEM_PEFTSH		0x00f0 /* PTP Peer Event Frame Transmitted Seconds Register 47:32 */
> @@ -398,6 +399,8 @@
>  #define MACB_PDRSFT_SIZE	1
>  #define MACB_SRI_OFFSET		26 /* TSU Seconds Register Increment */
>  #define MACB_SRI_SIZE		1
> +#define GEM_WOL_OFFSET		28 /* Enable wake-on-lan interrupt in GEM */
> +#define GEM_WOL_SIZE		1
>  
>  /* Timer increment fields */
>  #define MACB_TI_CNS_OFFSET	0
> @@ -635,6 +638,7 @@
>  #define MACB_CAPS_USRIO_DISABLED		0x00000010
>  #define MACB_CAPS_JUMBO				0x00000020
>  #define MACB_CAPS_GEM_HAS_PTP			0x00000040
> +#define MACB_CAPS_WOL				0x00000080

I think would be better to have this as part of bp->wol and use it properly
in suspend/resume hooks.

>  #define MACB_CAPS_FIFO_MODE			0x10000000
>  #define MACB_CAPS_GIGABIT_MODE_AVAILABLE	0x20000000
>  #define MACB_CAPS_SG_DISABLED			0x40000000
> @@ -1147,6 +1151,8 @@ struct macb {
>  	unsigned int		num_queues;
>  	unsigned int		queue_mask;
>  	struct macb_queue	queues[MACB_MAX_QUEUES];
> +	dma_addr_t		rx_ring_tieoff_dma;
> +	struct macb_dma_desc	*rx_ring_tieoff;
>  
>  	spinlock_t		lock;
>  	struct platform_device	*pdev;
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index bca91bd..9902654 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -36,6 +36,7 @@
>  #include <linux/udp.h>
>  #include <linux/tcp.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/inetdevice.h>
>  #include "macb.h"
>  
>  #define MACB_RX_BUFFER_SIZE	128
> @@ -1400,6 +1401,12 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
>  	spin_lock(&bp->lock);
>  
>  	while (status) {
> +		if (status & GEM_BIT(WOL)) {
> +			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
> +				queue_writel(queue, ISR, GEM_BIT(WOL));
> +			break;
> +		}
> +
>  		/* close possible race with dev_close */
>  		if (unlikely(!netif_running(dev))) {
>  			queue_writel(queue, IDR, -1);
> @@ -1900,6 +1907,12 @@ static void macb_free_consistent(struct macb *bp)
>  		queue->rx_ring = NULL;
>  	}
>  
> +	if (bp->rx_ring_tieoff) {
> +		dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
> +				  bp->rx_ring_tieoff, bp->rx_ring_tieoff_dma);
> +		bp->rx_ring_tieoff = NULL;
> +	}
> +
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>  		kfree(queue->tx_skb);
>  		queue->tx_skb = NULL;
> @@ -1979,6 +1992,14 @@ static int macb_alloc_consistent(struct macb *bp)
>  			   "Allocated RX ring of %d bytes at %08lx (mapped %p)\n",
>  			   size, (unsigned long)queue->rx_ring_dma, queue->rx_ring);
>  	}
> +	/* Allocate one dummy descriptor to tie off RX queues when required */
> +	bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
> +						macb_dma_desc_get_size(bp),
> +						&bp->rx_ring_tieoff_dma,
> +						GFP_KERNEL);
> +	if (!bp->rx_ring_tieoff)
> +		goto out_err;
> +
>  	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
>  		goto out_err;
>  
> @@ -1989,6 +2010,34 @@ static int macb_alloc_consistent(struct macb *bp)
>  	return -ENOMEM;
>  }
>  
> +static void macb_init_tieoff(struct macb *bp)
> +{
> +	struct macb_dma_desc *d = bp->rx_ring_tieoff;
> +
> +	/* Setup a wrapping descriptor with no free slots
> +	 * (WRAP and USED) to tie off/disable unused RX queues.
> +	 */
> +	macb_set_addr(bp, d, MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
> +	d->ctrl = 0;
> +}
> +
> +static inline void macb_rx_tieoff(struct macb *bp)
> +{
> +	struct macb_queue *queue = bp->queues;
> +	unsigned int q;
> +
> +	for (q = 0, queue = bp->queues; q < bp->num_queues;
> +	     ++q, ++queue) {
> +		queue_writel(queue, RBQP,
> +			     lower_32_bits(bp->rx_ring_tieoff_dma));
> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> +		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
> +			queue_writel(queue, RBQPH,
> +				     upper_32_bits(bp->rx_ring_tieoff_dma));
> +#endif
> +	}
> +}
> +
>  static void gem_init_rings(struct macb *bp)
>  {
>  	struct macb_queue *queue;
> @@ -2011,6 +2060,7 @@ static void gem_init_rings(struct macb *bp)
>  
>  		gem_rx_refill(queue);
>  	}
> +	macb_init_tieoff(bp);
>  
>  }
>  
> @@ -2653,6 +2703,13 @@ static void macb_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
>  		if (bp->wol & MACB_WOL_ENABLED)
>  			wol->wolopts |= WAKE_MAGIC;
>  	}
> +
> +	if (bp->caps & MACB_CAPS_WOL) {
> +		wol->supported = WAKE_ARP;
> +
> +		if (bp->wol & MACB_WOL_ENABLED)
> +			wol->wolopts |= WAKE_ARP;
> +	}
>  }
>  
>  static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
> @@ -2660,10 +2717,11 @@ static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
>  	struct macb *bp = netdev_priv(netdev);
>  
>  	if (!(bp->wol & MACB_WOL_HAS_MAGIC_PACKET) ||
> -	    (wol->wolopts & ~WAKE_MAGIC))
> +	    !(bp->caps & MACB_CAPS_WOL) ||
> +	    (wol->wolopts & ~WAKE_MAGIC) || (wol->wolopts & ~WAKE_ARP))
>  		return -EOPNOTSUPP;

So, both flags WAKE_MAGIC and WAKE_ARP needs to be set in order to use
Wake on Lan? Shouldn't this be exclusive? I mean if only one is set to
use that one?

Also, wouldn't be better to have all Wake on LAN capabilities in the same
place? I mean either bp->wol or bp->caps??


>  
> -	if (wol->wolopts & WAKE_MAGIC)
> +	if (wol->wolopts & (WAKE_MAGIC | WAKE_ARP))
>  		bp->wol |= MACB_WOL_ENABLED;
>  	else
>  		bp->wol &= ~MACB_WOL_ENABLED;
> @@ -3895,7 +3953,7 @@ static const struct macb_config np4_config = {
>  static const struct macb_config zynqmp_config = {
>  	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
>  			MACB_CAPS_JUMBO |
> -			MACB_CAPS_GEM_HAS_PTP,
> +			MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_WOL,
>  	.dma_burst_length = 16,
>  	.clk_init = macb_clk_init,
>  	.init = macb_init,
> @@ -4093,6 +4151,9 @@ static int macb_probe(struct platform_device *pdev)
>  
>  	phy_attached_info(phydev);
>  
> +	if (bp->caps & MACB_CAPS_WOL)
> +		device_set_wakeup_capable(&bp->dev->dev, 1);
> +

I think it is better to have this in bp->wol to keep all the wakeup related
events in the same place.

>  	netdev_info(dev, "Cadence %s rev 0x%08x at 0x%08lx irq %d (%pM)\n",
>  		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
>  		    dev->base_addr, dev->irq, dev->dev_addr);
> @@ -4170,16 +4231,58 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  	struct macb_queue *queue = bp->queues;
>  	unsigned long flags;
>  	unsigned int q;
> +	u32 ctrl, arpipmask;
>  
>  	if (!netif_running(netdev))
>  		return 0;
>  
>  
> -	if (bp->wol & MACB_WOL_ENABLED) {
> +	if ((bp->wol & MACB_WOL_ENABLED) &&
> +	    (bp->wol & MACB_WOL_HAS_MAGIC_PACKET)) {

If you will also introduce the other 2 wakeup supported sources of GEM GXL you
will end up having also a new else and conditioning device_may_wakeup() below
if-else condition with a bp->caps & MACB_CAPS_WOL.

I thinking that having something like this will be simpler:
	if (bp->wol & MACB_WOL_ENABLED) {
		if (bp->wol & MACB_WOL_HAS_MAGIC_PACKET)
			macb_configure_magic_pkt();
		if (bp->wol & MACB_WOL_HAS_ARP_PACKET)
			macb_configure_arp_pkt();
	}

What do you think?

>  		macb_writel(bp, IER, MACB_BIT(WOL));
>  		macb_writel(bp, WOL, MACB_BIT(MAG));
>  		enable_irq_wake(bp->queues[0].irq);
>  		netif_device_detach(netdev);
> +	} else if (device_may_wakeup(&bp->dev->dev)) {
> +		/* Use ARP as default wake source */
> +		spin_lock_irqsave(&bp->lock, flags);
> +		ctrl = macb_readl(bp, NCR);
> +		/* Disable TX as is it not required;
> +		 * Disable RX to change BD pointers and enable again
> +		 */
> +		ctrl &= ~(MACB_BIT(TE) | MACB_BIT(RE));
> +		macb_writel(bp, NCR, ctrl);
> +		/* Tie all RX queues */
> +		macb_rx_tieoff(bp);
> +		ctrl = macb_readl(bp, NCR);
> +		ctrl |= MACB_BIT(RE);
> +		macb_writel(bp, NCR, ctrl);
> +		/* Broadcast should be enabled for ARP wake event */
> +		gem_writel(bp, NCFGR, gem_readl(bp, NCFGR) & ~MACB_BIT(NBC));
> +		macb_writel(bp, TSR, -1);
> +		macb_writel(bp, RSR, -1);
> +		macb_readl(bp, ISR);
> +		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
> +			macb_writel(bp, ISR, -1);
> +
> +		/* Enable WOL (Q0 only) and disable all other interrupts */
> +		queue = bp->queues;
> +		queue_writel(queue, IER, GEM_BIT(WOL));
> +		for (q = 0, queue = bp->queues; q < bp->num_queues;
> +		     ++q, ++queue) {
> +			queue_writel(queue, IDR, MACB_RX_INT_FLAGS |
> +						 MACB_TX_INT_FLAGS |
> +						 MACB_BIT(HRESP));
> +		}
> +
> +		arpipmask = cpu_to_be32p(&bp->dev->ip_ptr->ifa_list->ifa_local)
> +					 & 0xFFFF;
> +		gem_writel(bp, WOL, MACB_BIT(ARP) | arpipmask);
> +		spin_unlock_irqrestore(&bp->lock, flags);
> +		enable_irq_wake(bp->queues[0].irq);
> +		netif_device_detach(netdev);
> +		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
> +			napi_disable(&queue->napi);

Is all this really necessary?
I mean, wouldn't be enough the adaption of previous approach? Looking over the initial
approach we have this:

	if (bp->wol & MACB_WOL_ENABLED) {
		macb_writel(bp, IER, MACB_BIT(WOL));
		macb_writel(bp, WOL, MACB_BIT(MAG));
		enable_irq_wake(bp->queues[0].irq);
		netif_device_detach(netdev);
	}

Wouldn't it work if you will change it in something like this:

	u32 wolmask, arpipmask = 0;

	if (bp->wol & MACB_WOL_ENABLED) {
		macb_writel(bp, IER, MACB_BIT(WOL));

		if (bp->wol & MACB_WOL_HAS_ARP_PACKET) {
			/* Enable broadcast. */
			gem_writel(bp, NCFGR, gem_readl(bp, NCFGR) & ~MACB_BIT(NBC));
			arpipmask = cpu_to_be32p(&bp->dev->ip_ptr->ifa_list->ifa_local) & 0xFFFF;
			wolmask = arpipmask | MACB_BIT(ARP);
		} else {
			wolmask = MACB_BIT(MAG);
		}

		macb_writel(bp, WOL, wolmask);
		enable_irq_wake(bp->queues[0].irq);
		netif_device_detach(netdev);
	}

I cannot find anything particular for ARP WOL events in datasheet. Also, 
I cannot find something related to DMA activity while WOL is active

Thank you,
Claudiu

>  	} else {
>  		netif_device_detach(netdev);
>  		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
> @@ -4206,16 +4309,33 @@ static int __maybe_unused macb_resume(struct device *dev)
>  	struct macb *bp = netdev_priv(netdev);
>  	struct macb_queue *queue = bp->queues;
>  	unsigned int q;
> +	unsigned long flags;
>  
>  	if (!netif_running(netdev))
>  		return 0;
>  
>  	pm_runtime_force_resume(dev);
>  
> -	if (bp->wol & MACB_WOL_ENABLED) {
> +	if ((bp->wol & MACB_WOL_ENABLED) &&
> +	    (bp->wol & MACB_WOL_HAS_MAGIC_PACKET)) {
>  		macb_writel(bp, IDR, MACB_BIT(WOL));
>  		macb_writel(bp, WOL, 0);
>  		disable_irq_wake(bp->queues[0].irq);
> +	} else if (device_may_wakeup(&bp->dev->dev)) {
> +		/* Resume after ARP wake event */
> +		spin_lock_irqsave(&bp->lock, flags);
> +		queue = bp->queues;
> +		queue_writel(queue, IDR, GEM_BIT(WOL));
> +		gem_writel(bp, WOL, 0);
> +		/* Clear Q0 ISR as WOL was enabled on Q0 */
> +		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
> +			macb_writel(bp, ISR, -1);
> +		disable_irq_wake(bp->queues[0].irq);
> +		spin_unlock_irqrestore(&bp->lock, flags);
> +		macb_writel(bp, NCR, MACB_BIT(MPE));
> +		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
> +			napi_enable(&queue->napi);
> +		netif_carrier_on(netdev);
>  	} else {
>  		macb_writel(bp, NCR, MACB_BIT(MPE));
>  		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
> 
