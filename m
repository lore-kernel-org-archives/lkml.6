Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753860AbeCFPYG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:24:06 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:48783 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753243AbeCFPXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:23:51 -0500
Date: Tue, 6 Mar 2018 16:23:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: netdev@vger.kernel.org, steve.glendinning@shawell.net,
        matt.sealey@arm.com, davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: smsc911x: Fix unload crash when link is up
Message-ID: <20180306152345.GD30557@lunn.ch>
References: <20180306150006.31512-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306150006.31512-1-jeremy.linton@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is caused by the mdiobus being unregistered/free'd
> and the code in phy_detach() attempting to manipulate mdio
> related structures from unregister_netdev() calling close()
> 
> To fix this, we delay the mdiobus teardown until after
> the netdev is deregistered.
> 
> Reported-by: Matt Sealey <matt.sealey@arm.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/net/ethernet/smsc/smsc911x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
> index 012fb66eed8d..f0afb88d7bc2 100644
> --- a/drivers/net/ethernet/smsc/smsc911x.c
> +++ b/drivers/net/ethernet/smsc/smsc911x.c
> @@ -2335,14 +2335,14 @@ static int smsc911x_drv_remove(struct platform_device *pdev)
>  	pdata = netdev_priv(dev);
>  	BUG_ON(!pdata);
>  	BUG_ON(!pdata->ioaddr);
> -	WARN_ON(dev->phydev);

Hi Jeremy

I assume this WARN_ON() also fired? It would be good to comment about
why you removed it, that the code now handles that case.

Apart from that

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
