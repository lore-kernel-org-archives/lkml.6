Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936386AbeCBQRZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:17:25 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37704 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935554AbeCBQRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:17:16 -0500
Date: Fri, 2 Mar 2018 17:17:13 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: davem@davemloft.net, Stefan Chulski <stefanc@marvell.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 5/5] net: mvpp2: jumbo frames support
Message-ID: <20180302171713.54beaad0@windsurf.lan>
In-Reply-To: <20180302154044.25204-6-antoine.tenart@bootlin.com>
References: <20180302154044.25204-1-antoine.tenart@bootlin.com>
        <20180302154044.25204-6-antoine.tenart@bootlin.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri,  2 Mar 2018 16:40:44 +0100, Antoine Tenart wrote:

>  /* Attach long pool to rxq */
> @@ -4551,7 +4559,7 @@ mvpp2_bm_pool_use(struct mvpp2_port *port, int pool, int pkt_size)
>  	struct mvpp2_bm_pool *new_pool = &port->priv->bm_pools[pool];
>  	int num;
>  
> -	if (pool < MVPP2_BM_SHORT || pool > MVPP2_BM_LONG) {
> +	if (pool < MVPP2_BM_SHORT || pool > MVPP2_BM_JUMBO) {

pool could be an unsigned, which would avoid the need for
MVPP2_BM_SHORT.

And for the upper limit, you have a convenient MVPP2_BM_POOLS_NUM in
your mvpp2_bm_pool_log_num enum, so why not use if ?



>  		netdev_err(port->dev, "Invalid pool %d\n", pool);
>  		return NULL;
>  	}
> @@ -4596,11 +4604,24 @@ mvpp2_bm_pool_use(struct mvpp2_port *port, int pool, int pkt_size)
>  static int mvpp2_swf_bm_pool_init(struct mvpp2_port *port)
>  {
>  	int rxq;
> +	enum mvpp2_bm_pool_log_num long_log_pool, short_log_pool;
> +
> +	/* If port pkt_size is higher than 1518B:
> +	 * HW Long pool - SW Jumbo pool, HW Short pool - SW Short pool

The comment is wrong. In this case, the HW short pool is the SW long
pool.

> +	 * else: HW Long pool - SW Long pool, HW Short pool - SW Short pool
> +	 */
> +	if (port->pkt_size > MVPP2_BM_LONG_PKT_SIZE) {
> +		long_log_pool = MVPP2_BM_JUMBO;
> +		short_log_pool = MVPP2_BM_LONG;

See here.

> +	} else {
> +		long_log_pool = MVPP2_BM_LONG;
> +		short_log_pool = MVPP2_BM_SHORT;
> +	}


> +	/* If port MTU is higher than 1518B:
> +	 * HW Long pool - SW Jumbo pool, HW Short pool - SW Short pool

And the comment is wrong here as well :)

> +	 * else: HW Long pool - SW Long pool, HW Short pool - SW Short pool
> +	 */
> +	if (pkt_size > MVPP2_BM_LONG_PKT_SIZE)
> +		new_long_pool = MVPP2_BM_JUMBO;
> +	else
> +		new_long_pool = MVPP2_BM_LONG;
> +
> +	if (new_long_pool != port->pool_long->id) {
> +		/* Remove port from old short & long pool */
> +		port->pool_long = mvpp2_bm_pool_use(port, port->pool_long->id,
> +						    port->pool_long->pkt_size);
> +		port->pool_long->port_map &= ~(1 << port->id);

BIT(port->id) ?

> +		port->pool_long = NULL;
> +
> +		port->pool_short = mvpp2_bm_pool_use(port, port->pool_short->id,
> +						     port->pool_short->pkt_size);
> +		port->pool_short->port_map &= ~(1 << port->id);

Ditto.

> +	if (port->pool_long->id == MVPP2_BM_JUMBO && port->id != 0) {

Again, all over the place we hardcode the fact that Jumbo frames can
only be used on port 0. I know port 0 is the only one that can do 10G,
but are there possibly some use cases where you may want Jumbo frame on
another port ?

This all really feels very hardcoded to me.

> +		dev->features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
> +		dev->hw_features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
> +	}
> +
>  	dev->vlan_features |= features;
>  	dev->gso_max_segs = MVPP2_MAX_TSO_SEGS;
>  
> -	/* MTU range: 68 - 9676 */
> +	/* MTU range: 68 - 9704 */
>  	dev->min_mtu = ETH_MIN_MTU;
> -	/* 9676 == 9700 - 20 and rounding to 8 */
> -	dev->max_mtu = 9676;

How come we already had a max_mtu of 9676 without Jumbo frame support ?

> +	/* 9704 == 9728 - 20 and rounding to 8 */
> +	dev->max_mtu = MVPP2_BM_JUMBO_PKT_SIZE;

Is this correct for all ports ? Shouldn't the maximum MTU be different
between port 0 (that supports Jumbo frames) and the other ports ?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
