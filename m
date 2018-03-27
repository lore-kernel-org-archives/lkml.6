Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754738AbeC0RaE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:30:04 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:44137 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbeC0RaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:30:01 -0400
Date: Tue, 27 Mar 2018 19:29:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, ssantosh@kernel.org,
        malat@debian.org, w-kwok2@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v2 05/10] net: netcp: ethss: use rgmii link
 status for 2u cpsw hardware
Message-ID: <20180327172953.GP5862@lunn.ch>
References: <1522168309-12338-1-git-send-email-m-karicheri2@ti.com>
 <1522168309-12338-6-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522168309-12338-6-git-send-email-m-karicheri2@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 12:31:44PM -0400, Murali Karicheri wrote:
> Introduce rgmii link status to handle link state events for 2u
> cpsw hardware on K2G.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  drivers/net/ethernet/ti/netcp_ethss.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
> index ab9d369..078a1b8 100644
> --- a/drivers/net/ethernet/ti/netcp_ethss.c
> +++ b/drivers/net/ethernet/ti/netcp_ethss.c
> @@ -552,6 +552,7 @@ struct gbe_ss_regs {
>  struct gbe_ss_regs_ofs {
>  	u16	id_ver;
>  	u16	control;
> +	u16	rgmii_status; /* 2U */
>  };
>  
>  struct gbe_switch_regs {
> @@ -2120,23 +2121,39 @@ static bool gbe_phy_link_status(struct gbe_slave *slave)
>  	 return !slave->phy || slave->phy->link;
>  }
>  
> +#define RGMII_REG_STATUS_LINK	BIT(0)
> +
> +static void netcp_2u_rgmii_get_port_link(struct gbe_priv *gbe_dev, bool *status)
> +{
> +	u32 val = 0;
> +
> +	val = readl(GBE_REG_ADDR(gbe_dev, ss_regs, rgmii_status));
> +	*status = false;
> +	if ((val & RGMII_REG_STATUS_LINK) != 0)
> +		*status = true;

  *status = !!(val & RGMII_REG_STATUS_LINK);


> +}
> +
>  static void netcp_ethss_update_link_state(struct gbe_priv *gbe_dev,
>  					  struct gbe_slave *slave,
>  					  struct net_device *ndev)
>  {
> -	int sp = slave->slave_num;
> -	int phy_link_state, sgmii_link_state = 1, link_state;
> +	bool sw_link_state = true, phy_link_state;
> +	int sp = slave->slave_num, link_state;
>  
>  	if (!slave->open)
>  		return;
>  
>  	if (!SLAVE_LINK_IS_XGMII(slave)) {
> -		sgmii_link_state =
> +		if (SLAVE_LINK_IS_RGMII(slave))
> +			netcp_2u_rgmii_get_port_link(gbe_dev,
> +						     &sw_link_state);
> +		else
> +			sw_link_state =
>  			netcp_sgmii_get_port_link(SGMII_BASE(gbe_dev, sp), sp);

This would be more readable as

     if (SLAVE_LINK_IS_RGMII(slave))
		netcp_2u_rgmii_get_port_link(gbe_dev,
					     &sw_link_state);
     if (SLAVE_LINK_IS_SGMII(slave))
	sw_link_state = netcp_sgmii_get_port_link(
	   SGMII_BASE(gbe_dev, sp), sp);

   Andrew
