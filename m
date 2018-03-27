Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754341AbeC0RSa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:18:30 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:44101 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753455AbeC0RS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:18:27 -0400
Date: Tue, 27 Mar 2018 19:18:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, ssantosh@kernel.org,
        malat@debian.org, w-kwok2@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v2 03/10] net: netcp: ethss: make call to
 gbe_sgmii_config() conditional
Message-ID: <20180327171817.GO5862@lunn.ch>
References: <1522168309-12338-1-git-send-email-m-karicheri2@ti.com>
 <1522168309-12338-4-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522168309-12338-4-git-send-email-m-karicheri2@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 12:31:42PM -0400, Murali Karicheri wrote:
> As a preparatory patch to add support for 2u cpsw hardware found on
> K2G SoC, make call to gbe_sgmii_config() conditional. This is required
> since 2u uses RGMII interface instead of SGMII and to allow for driver
> re-use.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  drivers/net/ethernet/ti/netcp_ethss.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
> index 56dbc0b..1dea891 100644
> --- a/drivers/net/ethernet/ti/netcp_ethss.c
> +++ b/drivers/net/ethernet/ti/netcp_ethss.c
> @@ -2271,7 +2271,8 @@ static int gbe_slave_open(struct gbe_intf *gbe_intf)
>  
>  	void (*hndlr)(struct net_device *) = gbe_adjust_link;
>  
> -	gbe_sgmii_config(priv, slave);
> +	if ((priv->ss_version == GBE_SS_VERSION_14) || IS_SS_ID_NU(priv))
> +		gbe_sgmii_config(priv, slave);

Or maybe:

   if (slave->phy_node == PHY_INTERFACE_MODE_SGMII)
   	gbe_sgmii_config(priv, slave);

	Andrew
