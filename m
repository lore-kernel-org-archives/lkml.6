Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeC3KnY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 06:43:24 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52000 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeC3KnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 06:43:23 -0400
Date: Fri, 30 Mar 2018 11:43:13 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: David Miller <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] net: mvneta: improve suspend/resume
Message-ID: <20180330104312.GH16141@n2100.armlinux.org.uk>
References: <20180330183332.3e180a1a@xhacker.debian>
 <20180330183615.6b34d153@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330183615.6b34d153@xhacker.debian>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 06:36:15PM +0800, Jisheng Zhang wrote:
> Current suspend/resume implementation reuses the mvneta_open() and
> mvneta_close(), but it could be optimized to take only necessary
> actions during suspend/resume.
> 
> One obvious problem of current implementation is: after hundreds of
> system suspend/resume cycles, the resume of mvneta could fail due to
> fragmented dma coherent memory. After this patch, the non-necessary
> memory alloc/free is optimized out.

I don't think you've properly tested this.  Please ensure that you test
patches with the appropriate debug options enabled.

> @@ -4586,16 +4586,43 @@ static int mvneta_remove(struct platform_device *pdev)
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
...
> +	mvneta_stop_dev(pp);

You're removing the rtnl_lock() that I introduced in 3b8bc67413de
("net: mvneta: ensure PM paths take the rtnl lock") which is necessary
to provide phylink with consistent locking.  mvneta_stop_dev() calls
phylink_stop() which will check that the rtnl lock is held, and will
print a warning if it isn't.

Your patch will cause a regression here.

> +
> +	for (queue = 0; queue < rxq_number; queue++) {
> +		struct mvneta_rx_queue *rxq = &pp->rxqs[queue];
> +
> +		mvneta_rxq_drop_pkts(pp, rxq);
> +	}
> +
> +	for (queue = 0; queue < txq_number; queue++) {
> +		struct mvneta_tx_queue *txq = &pp->txqs[queue];
> +
> +		mvneta_txq_hw_deinit(pp, txq);
> +	}
> +
> +clean_exit:
>  	netif_device_detach(dev);
>  	clk_disable_unprepare(pp->clk_bus);
>  	clk_disable_unprepare(pp->clk);
> +
>  	return 0;
>  }
>  
> @@ -4604,7 +4631,7 @@ static int mvneta_resume(struct device *device)
>  	struct platform_device *pdev = to_platform_device(device);
>  	struct net_device *dev = dev_get_drvdata(device);
>  	struct mvneta_port *pp = netdev_priv(dev);
> -	int err;
> +	int err, queue;
>  
>  	clk_prepare_enable(pp->clk);
>  	if (!IS_ERR(pp->clk_bus))
> @@ -4626,12 +4653,36 @@ static int mvneta_resume(struct device *device)
>  	}
>  
>  	netif_device_attach(dev);
> -	rtnl_lock();
> -	if (netif_running(dev)) {
> -		mvneta_open(dev);
> -		mvneta_set_rx_mode(dev);
...
>  	}
> -	rtnl_unlock();
...
> +	mvneta_start_dev(pp);

Same applies here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
