Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753931AbeC1TJv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:09:51 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52848 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753297AbeC1TJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:09:48 -0400
Date: Wed, 28 Mar 2018 20:09:37 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Yan Markman <ymarkman@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Miquel Raynal <miquel.raynal@free-electrons.com>,
        Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH net-next 1/2] net: phy: phylink: Provide PHY interface to
 mac_link_{up,down}
Message-ID: <20180328190937.GR10980@n2100.armlinux.org.uk>
References: <20180328190339.31433-1-f.fainelli@gmail.com>
 <20180328190339.31433-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328190339.31433-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 12:03:38PM -0700, Florian Fainelli wrote:
> In preparation for having DSA transition entirely to PHYLINK, we need to pass a
> PHY interface type to the mac_link_{up,down} callbacks because we may have to
> make decisions on that (e.g: turn on/off RGMII interfaces etc.). We do not pass
> an entire phylink_link_state because not all parameters (pause, duplex etc.) are
> defined when the link is down, only link and interface are.
> 
> Update mvneta accordingly since it currently implements phylink_mac_ops.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Similar comments to previous version wrt documentation, but...

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

> ---
>  drivers/net/ethernet/marvell/mvneta.c |  4 +++-
>  drivers/net/phy/phylink.c             |  4 +++-
>  include/linux/phylink.h               | 10 ++++++++--
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index eaa4bb80f1c9..cd09bde55596 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -3396,7 +3396,8 @@ static void mvneta_set_eee(struct mvneta_port *pp, bool enable)
>  	mvreg_write(pp, MVNETA_LPI_CTRL_1, lpi_ctl1);
>  }
>  
> -static void mvneta_mac_link_down(struct net_device *ndev, unsigned int mode)
> +static void mvneta_mac_link_down(struct net_device *ndev, unsigned int mode,
> +				 phy_interface_t interface)
>  {
>  	struct mvneta_port *pp = netdev_priv(ndev);
>  	u32 val;
> @@ -3415,6 +3416,7 @@ static void mvneta_mac_link_down(struct net_device *ndev, unsigned int mode)
>  }
>  
>  static void mvneta_mac_link_up(struct net_device *ndev, unsigned int mode,
> +			       phy_interface_t interface,
>  			       struct phy_device *phy)
>  {
>  	struct mvneta_port *pp = netdev_priv(ndev);
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 51a011a349fe..9b1e4721ea3a 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -470,10 +470,12 @@ static void phylink_resolve(struct work_struct *w)
>  	if (link_state.link != netif_carrier_ok(ndev)) {
>  		if (!link_state.link) {
>  			netif_carrier_off(ndev);
> -			pl->ops->mac_link_down(ndev, pl->link_an_mode);
> +			pl->ops->mac_link_down(ndev, pl->link_an_mode,
> +					       pl->phy_state.interface);
>  			netdev_info(ndev, "Link is Down\n");
>  		} else {
>  			pl->ops->mac_link_up(ndev, pl->link_an_mode,
> +					     pl->phy_state.interface,
>  					     pl->phydev);
>  
>  			netif_carrier_on(ndev);
> diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> index bd137c273d38..f29a40947de9 100644
> --- a/include/linux/phylink.h
> +++ b/include/linux/phylink.h
> @@ -73,8 +73,10 @@ struct phylink_mac_ops {
>  	void (*mac_config)(struct net_device *ndev, unsigned int mode,
>  			   const struct phylink_link_state *state);
>  	void (*mac_an_restart)(struct net_device *ndev);
> -	void (*mac_link_down)(struct net_device *ndev, unsigned int mode);
> +	void (*mac_link_down)(struct net_device *ndev, unsigned int mode,
> +			      phy_interface_t interface);
>  	void (*mac_link_up)(struct net_device *ndev, unsigned int mode,
> +			    phy_interface_t interface,
>  			    struct phy_device *phy);
>  };
>  
> @@ -161,17 +163,20 @@ void mac_an_restart(struct net_device *ndev);
>   * mac_link_down() - take the link down
>   * @ndev: a pointer to a &struct net_device for the MAC.
>   * @mode: link autonegotiation mode
> + * @interface: link &typedef phy_interface_t mode
>   *
>   * If @mode is not an in-band negotiation mode (as defined by
>   * phylink_autoneg_inband()), force the link down and disable any
>   * Energy Efficient Ethernet MAC configuration.
>   */
> -void mac_link_down(struct net_device *ndev, unsigned int mode);
> +void mac_link_down(struct net_device *ndev, unsigned int mode,
> +		   phy_interface_t interface);
>  
>  /**
>   * mac_link_up() - allow the link to come up
>   * @ndev: a pointer to a &struct net_device for the MAC.
>   * @mode: link autonegotiation mode
> + * @interface: link &typedef phy_interface_t mode
>   * @phy: any attached phy
>   *
>   * If @mode is not an in-band negotiation mode (as defined by
> @@ -180,6 +185,7 @@ void mac_link_down(struct net_device *ndev, unsigned int mode);
>   * phy_init_eee() and perform appropriate MAC configuration for EEE.
>   */
>  void mac_link_up(struct net_device *ndev, unsigned int mode,
> +		 phy_interface_t interface,
>  		 struct phy_device *phy);
>  #endif
>  
> -- 
> 2.14.1
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
