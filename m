Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbeEGDIa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 23:08:30 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56209 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751874AbeEGDI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 23:08:29 -0400
X-ME-Sender: <xms:LcPvWu7H7VOFjIgUX--VJ2qTnH79jKoBVsHWUSoxmWHzs_H9CtLgVw>
Date: Mon, 7 May 2018 13:08:25 +1000
From: "Tobin C. Harding" <tobin@apporbit.com>
To: Andrea Greco <andrea.greco.gapmilano@gmail.com>
Cc: m.grzeschik@pengutronix.de, Andrea Greco <a.greco@4sigma.it>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] arcnet: com20020: Add ethtool support
Message-ID: <20180507030825.GH4197@eros>
References: <20180505213530.8294-1-andrea.greco.gapmilano@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505213530.8294-1-andrea.greco.gapmilano@gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 11:35:29PM +0200, Andrea Greco wrote:
> From: Andrea Greco <a.greco@4sigma.it>
> 
> Setup ethtols for export com20020 diag register
> 
> Signed-off-by: Andrea Greco <a.greco@4sigma.it>
> ---
>  drivers/net/arcnet/com20020-isa.c    |  1 +
>  drivers/net/arcnet/com20020-membus.c |  1 +
>  drivers/net/arcnet/com20020.c        | 29 +++++++++++++++++++++++++++++
>  drivers/net/arcnet/com20020.h        |  1 +
>  drivers/net/arcnet/com20020_cs.c     |  1 +
>  include/uapi/linux/if_arcnet.h       |  6 ++++++
>  6 files changed, 39 insertions(+)
> 
> diff --git a/drivers/net/arcnet/com20020-isa.c b/drivers/net/arcnet/com20020-isa.c
> index 38fa60ddaf2e..44ab6dcccb58 100644
> --- a/drivers/net/arcnet/com20020-isa.c
> +++ b/drivers/net/arcnet/com20020-isa.c
> @@ -154,6 +154,7 @@ static int __init com20020_init(void)
>  		dev->dev_addr[0] = node;
>  
>  	dev->netdev_ops = &com20020_netdev_ops;
> +	dev->ethtool_ops = &com20020_ethtool_ops;
>  
>  	lp = netdev_priv(dev);
>  	lp->backplane = backplane;
> diff --git a/drivers/net/arcnet/com20020-membus.c b/drivers/net/arcnet/com20020-membus.c
> index 6e4a2f3a84f7..9eead734a3cf 100644
> --- a/drivers/net/arcnet/com20020-membus.c
> +++ b/drivers/net/arcnet/com20020-membus.c
> @@ -91,6 +91,7 @@ static int com20020_probe(struct platform_device *pdev)
>  
>  	dev = alloc_arcdev(NULL);// Let autoassign name arc%d
>  	dev->netdev_ops = &com20020_netdev_ops;
> +	dev->ethtool_ops = &com20020_ethtool_ops;
>  	lp = netdev_priv(dev);
>  
>  	lp->card_flags = ARC_CAN_10MBIT;/* pretend all of them can 10Mbit */
> diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
> index abd32ed8ec9b..2089b45e81c8 100644
> --- a/drivers/net/arcnet/com20020.c
> +++ b/drivers/net/arcnet/com20020.c
> @@ -201,6 +201,34 @@ const struct net_device_ops com20020_netdev_ops = {
>  	.ndo_set_rx_mode = com20020_set_mc_list,
>  };
>  
> +static int com20020_ethtool_regs_len(struct net_device *netdev)
> +{
> +	return sizeof(struct com20020_ethtool_regs);
> +}
> +
> +static void com20020_ethtool_regs_read(struct net_device *dev,
> +				       struct ethtool_regs *regs, void *p)
> +{
> +	struct arcnet_local *lp;
> +	struct com20020_ethtool_regs *com_reg;
> +
> +	lp = netdev_priv(dev);
> +	memset(p, 0, sizeof(struct com20020_ethtool_regs));

perhaps:

	struct arcnet_local *lp = netdev_priv(dev);
	struct com20020_ethtool_regs *com_reg = p;

	memset(com_reg, 0, sizeof(*com_reg));

> +
> +	regs->version = 1;

Should this function really have a side effect?  If so, perhaps it could
be commented.

> +
> +	com_reg = p;
> +
> +	com_reg->status = lp->hw.status(dev) & 0xFF;
> +	com_reg->diag_register = (lp->hw.status(dev) >> 8) & 0xFF;
> +	com_reg->reconf_count = lp->num_recons;
> +}
> +
> +const struct ethtool_ops com20020_ethtool_ops = {
> +	.get_regs = com20020_ethtool_regs_read,
> +	.get_regs_len  = com20020_ethtool_regs_len,
> +};
> +

Hope this helps,
Tobin.
