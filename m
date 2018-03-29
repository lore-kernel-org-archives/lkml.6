Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753258AbeC2Lyg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:54:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38353 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751896AbeC2Lyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:54:35 -0400
Date: Thu, 29 Mar 2018 13:54:32 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: mvneta: improve suspend/resume
Message-ID: <20180329135432.7da1299b@windsurf>
In-Reply-To: <20180329181536.46e065d2@xhacker.debian>
References: <20180329181220.61d63c92@xhacker.debian>
        <20180329181536.46e065d2@xhacker.debian>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jisheng,

On Thu, 29 Mar 2018 18:15:36 +0800, Jisheng Zhang wrote:
> Current suspend/resume implementation reuses the mvneta_open() and
> mvneta_close(), but it could be optimized to take only necessary
> actions during suspend/resume.
> 
> One obvious problem of current implementation is: after hundreds of
> system suspend/resume cycles, the resume of mvneta could fail due to
> fragmented dma coherent memory. After this patch, the non-necessary
> memory alloc/free is optimized out.

Indeed, this needs to be fixed, you're totally right.

> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 76 ++++++++++++++++++++++++++++++-----
>  1 file changed, 66 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 4ec69bbd1eb4..1870f1dd7093 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -4575,14 +4575,46 @@ static int mvneta_remove(struct platform_device *pdev)
>  #ifdef CONFIG_PM_SLEEP
>  static int mvneta_suspend(struct device *device)
>  {
> +	int queue;
>  	struct net_device *dev = dev_get_drvdata(device);
>  	struct mvneta_port *pp = netdev_priv(dev);
>  
> -	rtnl_lock();
> -	if (netif_running(dev))
> -		mvneta_stop(dev);
> -	rtnl_unlock();
> +	if (!netif_running(dev))
> +		return 0;

This is changing the behavior I believe. The current code is:

        rtnl_lock();
        if (netif_running(dev))
                mvneta_stop(dev);
        rtnl_unlock();
        netif_device_detach(dev);
        clk_disable_unprepare(pp->clk_bus);
        clk_disable_unprepare(pp->clk);
        return 0;

So, when netif_running(dev) is false, we're indeed not calling
mvneta_stop(), but we're still doing netif_device_detach(), and
disabling the clocks. With your change, we're no longer doing these
steps.

> +
>  	netif_device_detach(dev);
> +
> +	mvneta_stop_dev(pp);
> +
> +	if (!pp->neta_armada3700) {
> +		spin_lock(&pp->lock);
> +		pp->is_stopped = true;
> +		spin_unlock(&pp->lock);

Real question: is it OK to set pp->is_stopped *after* calling
mvneta_stop_dev(), while it was set before calling mvneta_stop_dev() in
the current code ?

> +
> +		cpuhp_state_remove_instance_nocalls(online_hpstate,
> +						    &pp->node_online);
> +		cpuhp_state_remove_instance_nocalls(CPUHP_NET_MVNETA_DEAD,
> +						    &pp->node_dead);

Do we need to remove/add those CPU notifiers when suspending/resuming ?

> +	}
> +
> +	for (queue = 0; queue < rxq_number; queue++) {
> +		struct mvneta_rx_queue *rxq = &pp->rxqs[queue];
> +
> +		mvneta_rxq_drop_pkts(pp, rxq);
> +	}

Wouldn't it make sense to have
mvneta_rxq_sw_deinit/mvneta_rxq_hw_deinit(), like you did for the
initialization ?

> +
> +	for (queue = 0; queue < txq_number; queue++) {
> +		struct mvneta_tx_queue *txq = &pp->txqs[queue];
> +
> +		/* Set minimum bandwidth for disabled TXQs */
> +		mvreg_write(pp, MVETH_TXQ_TOKEN_CFG_REG(txq->id), 0);
> +		mvreg_write(pp, MVETH_TXQ_TOKEN_COUNT_REG(txq->id), 0);
> +
> +		/* Set Tx descriptors queue starting address and size */
> +		mvreg_write(pp, MVNETA_TXQ_BASE_ADDR_REG(txq->id), 0);
> +		mvreg_write(pp, MVNETA_TXQ_SIZE_REG(txq->id), 0);
> +	}

Same comment here: a mvneta_txq_sw_deinit()/mvneta_txq_hw_deinit()
would be good, and would avoid duplicating this logic.

> +
>  	clk_disable_unprepare(pp->clk_bus);
>  	clk_disable_unprepare(pp->clk);
>  	return 0;
> @@ -4593,7 +4625,7 @@ static int mvneta_resume(struct device *device)
>  	struct platform_device *pdev = to_platform_device(device);
>  	struct net_device *dev = dev_get_drvdata(device);
>  	struct mvneta_port *pp = netdev_priv(dev);
> -	int err;
> +	int err, queue;
>  
>  	clk_prepare_enable(pp->clk);
>  	if (!IS_ERR(pp->clk_bus))
> @@ -4614,13 +4646,37 @@ static int mvneta_resume(struct device *device)
>  		return err;
>  	}
>  
> +	if (!netif_running(dev))
> +		return 0;
> +
>  	netif_device_attach(dev);
> -	rtnl_lock();
> -	if (netif_running(dev)) {
> -		mvneta_open(dev);
> -		mvneta_set_rx_mode(dev);
> +
> +	for (queue = 0; queue < rxq_number; queue++) {
> +		struct mvneta_rx_queue *rxq = &pp->rxqs[queue];
> +
> +		rxq->next_desc_to_proc = 0;
> +		mvneta_rxq_hw_init(pp, rxq);
>  	}
> -	rtnl_unlock();
> +
> +	for (queue = 0; queue < txq_number; queue++) {
> +		struct mvneta_tx_queue *txq = &pp->txqs[queue];
> +
> +		txq->next_desc_to_proc = 0;
> +		mvneta_txq_hw_init(pp, txq);
> +	}
> +
> +	if (!pp->neta_armada3700) {
> +		spin_lock(&pp->lock);
> +		pp->is_stopped = false;
> +		spin_unlock(&pp->lock);
> +		cpuhp_state_add_instance_nocalls(online_hpstate,
> +						 &pp->node_online);
> +		cpuhp_state_add_instance_nocalls(CPUHP_NET_MVNETA_DEAD,
> +						 &pp->node_dead);
> +	}
> +
> +	mvneta_set_rx_mode(dev);
> +	mvneta_start_dev(pp);

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
