Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755656AbeBPSRU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:17:20 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:57693 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751070AbeBPSRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:17:13 -0500
Date: Fri, 16 Feb 2018 19:17:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        f.fainelli@gmail.com, davem@davemloft.net
Subject: Re: [PATCH v3 2/2] net: ethernet: nixge: Add support for National
 Instruments XGE netdev
Message-ID: <20180216181707.GJ3080@lunn.ch>
References: <20180216170033.3834-1-mdf@kernel.org>
 <20180216170033.3834-2-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216170033.3834-2-mdf@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 09:00:33AM -0800, Moritz Fischer wrote:
> +#define NIXGE_MDIO_CLAUSE45	BIT(12)
> +#define NIXGE_MDIO_CLAUSE22	0
> +#define NIXGE_MDIO_OP(n)     (((n) & 0x3) << 10)
> +#define NIXGE_MDIO_OP_ADDRESS	0
> +#define NIXGE_MDIO_OP_WRITE	BIT(0)
> +#define NIXGE_MDIO_OP_READ	(BIT(1) | BIT(0))
> +#define MDIO_C22_WRITE		BIT(0)
> +#define MDIO_C22_READ		BIT(1)
> +#define MDIO_READ_POST		2

Hi Moritz


NIXGE prefix?

> +#define NIXGE_MDIO_ADDR(n)   (((n) & 0x1f) << 5)
> +#define NIXGE_MDIO_MMD(n)    (((n) & 0x1f) << 0)
> +
> +#define NIXGE_MAX_PHY_ADDR	32

This is nothing specific to this device. Please use the standard
PHY_MAX_ADDR.

> +static int nixge_open(struct net_device *ndev)
> +{
> +	struct nixge_priv *priv = netdev_priv(ndev);
> +	struct phy_device *phy;
> +	int ret;
> +
> +	nixge_device_reset(ndev);
> +
> +	phy = of_phy_connect(ndev, priv->phy_node,
> +			     &nixge_handle_link_change, 0, priv->phy_mode);
> +	if (!phy)
> +		return -ENODEV;
> +
> +	phy_start(phy);
> +
> +	/* Enable tasklets for Axi DMA error handling */
> +	tasklet_init(&priv->dma_err_tasklet, nixge_dma_err_handler,
> +		     (unsigned long)priv);
> +
> +	napi_enable(&priv->napi);
> +
> +	/* Enable interrupts for Axi DMA Tx */
> +	ret = request_irq(priv->tx_irq, nixge_tx_irq, 0, ndev->name, ndev);
> +	if (ret)
> +		goto err_tx_irq;
> +	/* Enable interrupts for Axi DMA Rx */
> +	ret = request_irq(priv->rx_irq, nixge_rx_irq, 0, ndev->name, ndev);
> +	if (ret)
> +		goto err_rx_irq;
> +
> +	netif_start_queue(ndev);
> +
> +	return 0;
> +
> +err_rx_irq:
> +	free_irq(priv->tx_irq, ndev);
> +err_tx_irq:
> +	tasklet_kill(&priv->dma_err_tasklet);
> +	netdev_err(ndev, "request_irq() failed\n");
> +	return ret;

Maybe you also want to stop the phy and disconnect it?

> +static int nixge_stop(struct net_device *ndev)
> +{
> +	struct nixge_priv *priv = netdev_priv(ndev);
> +	u32 cr;
> +
> +	netif_stop_queue(ndev);
> +	napi_disable(&priv->napi);
> +
> +	if (ndev->phydev)
> +		phy_stop(ndev->phydev);

phy_disconnect() ?


> +	cr = nixge_dma_read_reg(priv, XAXIDMA_RX_CR_OFFSET);
> +	nixge_dma_write_reg(priv, XAXIDMA_RX_CR_OFFSET,
> +			    cr & (~XAXIDMA_CR_RUNSTOP_MASK));
> +	cr = nixge_dma_read_reg(priv, XAXIDMA_TX_CR_OFFSET);
> +	nixge_dma_write_reg(priv, XAXIDMA_TX_CR_OFFSET,
> +			    cr & (~XAXIDMA_CR_RUNSTOP_MASK));
> +
> +	tasklet_kill(&priv->dma_err_tasklet);
> +
> +	free_irq(priv->tx_irq, ndev);
> +	free_irq(priv->rx_irq, ndev);
> +
> +	nixge_hw_dma_bd_release(ndev);
> +
> +	return 0;
> +}

> +static int nixge_mdio_read(struct mii_bus *bus, int phy_id, int reg)
> +{
> +	struct nixge_priv *priv = bus->priv;
> +	u32 status, tmp;
> +	int err;
> +	u16 device;
> +
> +	if (reg & MII_ADDR_C45) {
> +		device = (reg >> 16) & 0x1f;
> +
> +		nixge_ctrl_write_reg(priv, NIXGE_REG_MDIO_ADDR, reg & 0xffff);
> +
> +		tmp = NIXGE_MDIO_CLAUSE45 | NIXGE_MDIO_OP(NIXGE_MDIO_OP_ADDRESS)
> +			| NIXGE_MDIO_ADDR(phy_id) | NIXGE_MDIO_MMD(device);
> +
> +		nixge_ctrl_write_reg(priv, NIXGE_REG_MDIO_OP, tmp);
> +		nixge_ctrl_write_reg(priv, NIXGE_REG_MDIO_CTRL, 1);
> +
> +		err = nixge_ctrl_poll_timeout(priv, NIXGE_REG_MDIO_CTRL, status,
> +					      !status, 10, 1000);
> +		if (err) {
> +			dev_err(priv->dev, "timeout setting address");
> +			return err;
> +		}
> +
> +		tmp = NIXGE_MDIO_CLAUSE45 | NIXGE_MDIO_OP(NIXGE_MDIO_OP_READ) |
> +			NIXGE_MDIO_ADDR(phy_id) | NIXGE_MDIO_MMD(device);
> +	} else {
> +		device = reg & 0x1f;
> +
> +		tmp = NIXGE_MDIO_CLAUSE22 | NIXGE_MDIO_OP(MDIO_C22_READ) |
> +			NIXGE_MDIO_ADDR(phy_id) | NIXGE_MDIO_MMD(device);

It would be nice to have some naming consistency here. NIXGE_MDIO_C45_READ and 
NIXGE_MDIO_C22_READ?

> +	}
> +
> +	nixge_ctrl_write_reg(priv, NIXGE_REG_MDIO_OP, tmp);
> +	nixge_ctrl_write_reg(priv, NIXGE_REG_MDIO_CTRL, 1);
> +
> +	err = nixge_ctrl_poll_timeout(priv, NIXGE_REG_MDIO_CTRL, status,
> +				      !status, 10, 1000);
> +	if (err) {
> +		dev_err(priv->dev, "timeout setting read command");
> +		return err;
> +	}
> +
> +	status = nixge_ctrl_read_reg(priv, NIXGE_REG_MDIO_DATA);
> +
> +	return status;
> +}
> +
> +static int nixge_mdio_setup(struct nixge_priv *priv, struct device_node *np)
> +{
> +	struct mii_bus *bus;
> +	int err;
> +
> +	bus = mdiobus_alloc();

devm_mdiobus_alloc() ?

> +	if (!bus)
> +		return -ENOMEM;
> +
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(priv->dev));
> +	bus->priv = priv;
> +	bus->name = "nixge_mii_bus";
> +	bus->read = nixge_mdio_read;
> +	bus->write = nixge_mdio_write;
> +	bus->parent = priv->dev;
> +
> +	priv->mii_bus = bus;
> +	err = of_mdiobus_register(bus, np);
> +	if (err)
> +		goto err_register;
> +
> +	return 0;
> +
> +err_register:
> +	mdiobus_free(bus);
> +	return err;
> +}

> +static int nixge_remove(struct platform_device *pdev)
> +{
> +	struct net_device *ndev = platform_get_drvdata(pdev);
> +	struct nixge_priv *priv = netdev_priv(ndev);
> +
> +	mdiobus_unregister(priv->mii_bus);
> +	mdiobus_free(priv->mii_bus);
> +
> +	unregister_netdev(ndev);

I'm not sure about the ordering here. It might be better to unregister
the netdev, then destroy the MDIO bus.

> +
> +	free_netdev(ndev);
> +
> +	return 0;
> +}

  Andrew
