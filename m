Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbeCWVvd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:51:33 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37133 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCWVvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:51:31 -0400
X-Google-Smtp-Source: AG47ELsQgfaWvwSGVVeoBEZb6aBaj6o8/vl/7JT9VHPadrNhkHohz4URz/hZ2bKOHjZHrJ3UB9AN+Q==
Subject: Re: [PATCH net-next 3/8] net: mscc: Add MDIO driver
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-4-alexandre.belloni@bootlin.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <9547b11d-147d-5029-0abe-8bf0f705c959@gmail.com>
Date: Fri, 23 Mar 2018 14:51:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323201117.8416-4-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/2018 01:11 PM, Alexandre Belloni wrote:
> Add a driver for the Microsemi MII Management controller (MIIM) found on
> Microsemi SoCs.
> On Ocelot, there are two controllers, one is connected to the internal
> PHYs, the other one can communicate with external PHYs.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/net/ethernet/Kconfig          |   1 +
>  drivers/net/ethernet/Makefile         |   1 +
>  drivers/net/ethernet/mscc/Kconfig     |  22 ++++
>  drivers/net/ethernet/mscc/Makefile    |   2 +
>  drivers/net/ethernet/mscc/mscc_miim.c | 210 ++++++++++++++++++++++++++++++++++
>  5 files changed, 236 insertions(+)
>  create mode 100644 drivers/net/ethernet/mscc/Kconfig
>  create mode 100644 drivers/net/ethernet/mscc/Makefile
>  create mode 100644 drivers/net/ethernet/mscc/mscc_miim.c
> 
> diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
> index b6cf4b6962f5..adf643484198 100644
> --- a/drivers/net/ethernet/Kconfig
> +++ b/drivers/net/ethernet/Kconfig
> @@ -115,6 +115,7 @@ source "drivers/net/ethernet/mediatek/Kconfig"
>  source "drivers/net/ethernet/mellanox/Kconfig"
>  source "drivers/net/ethernet/micrel/Kconfig"
>  source "drivers/net/ethernet/microchip/Kconfig"
> +source "drivers/net/ethernet/mscc/Kconfig"
>  source "drivers/net/ethernet/moxa/Kconfig"
>  source "drivers/net/ethernet/myricom/Kconfig"
>  
> diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
> index 3cdf01e96e0b..ed7df22de7ff 100644
> --- a/drivers/net/ethernet/Makefile
> +++ b/drivers/net/ethernet/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_NET_VENDOR_MEDIATEK) += mediatek/
>  obj-$(CONFIG_NET_VENDOR_MELLANOX) += mellanox/
>  obj-$(CONFIG_NET_VENDOR_MICREL) += micrel/
>  obj-$(CONFIG_NET_VENDOR_MICROCHIP) += microchip/
> +obj-$(CONFIG_NET_VENDOR_MICROSEMI) += mscc/
>  obj-$(CONFIG_NET_VENDOR_MOXART) += moxa/
>  obj-$(CONFIG_NET_VENDOR_MYRI) += myricom/
>  obj-$(CONFIG_FEALNX) += fealnx.o
> diff --git a/drivers/net/ethernet/mscc/Kconfig b/drivers/net/ethernet/mscc/Kconfig
> new file mode 100644
> index 000000000000..2330de6e7bb6
> --- /dev/null
> +++ b/drivers/net/ethernet/mscc/Kconfig
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +config NET_VENDOR_MICROSEMI
> +	bool "Microsemi devices"
> +	default y
> +	help
> +	  If you have a network (Ethernet) card belonging to this class, say Y.
> +
> +	  Note that the answer to this question doesn't directly affect the
> +	  kernel: saying N will just cause the configurator to skip all
> +	  the questions about Microsemi devices.
> +
> +if NET_VENDOR_MICROSEMI
> +
> +config MSCC_MIIM
> +	tristate "Microsemi MIIM interface support"
> +	depends on HAS_IOMEM
> +	select PHYLIB
> +	help
> +	  This driver supports the MIIM (MDIO) interface found in the network
> +	  switches of the Microsemi SoCs
> +
> +endif # NET_VENDOR_MICROSEMI
> diff --git a/drivers/net/ethernet/mscc/Makefile b/drivers/net/ethernet/mscc/Makefile
> new file mode 100644
> index 000000000000..4570e8fa4711
> --- /dev/null
> +++ b/drivers/net/ethernet/mscc/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +obj-$(CONFIG_MSCC_MIIM) += mscc_miim.o
> diff --git a/drivers/net/ethernet/mscc/mscc_miim.c b/drivers/net/ethernet/mscc/mscc_miim.c
> new file mode 100644
> index 000000000000..95b8d102c90f
> --- /dev/null
> +++ b/drivers/net/ethernet/mscc/mscc_miim.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Driver for the MDIO interface of Microsemi network switches.
> + *
> + * Author: Alexandre Belloni <alexandre.belloni@bootlin.com>
> + * Copyright (c) 2017 Microsemi Corporation
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/bitops.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/of_mdio.h>
> +
> +#define MSCC_MIIM_REG_STATUS		0x0
> +#define		MSCC_MIIM_STATUS_STAT_BUSY	BIT(3)
> +#define MSCC_MIIM_REG_CMD		0x8
> +#define		MSCC_MIIM_CMD_OPR_WRITE		BIT(1)
> +#define		MSCC_MIIM_CMD_OPR_READ		BIT(2)
> +#define		MSCC_MIIM_CMD_WRDATA_SHIFT	4
> +#define		MSCC_MIIM_CMD_REGAD_SHIFT	20
> +#define		MSCC_MIIM_CMD_PHYAD_SHIFT	25
> +#define		MSCC_MIIM_CMD_VLD		BIT(31)
> +#define MSCC_MIIM_REG_DATA		0xC
> +#define		MSCC_MIIM_DATA_ERROR		(BIT(16) | BIT(17))
> +
> +#define MSCC_PHY_REG_PHY_CFG	0x0
> +#define		PHY_CFG_PHY_ENA		(BIT(0) | BIT(1) | BIT(2) | BIT(3))
> +#define		PHY_CFG_PHY_COMMON_RESET BIT(4)
> +#define		PHY_CFG_PHY_RESET	(BIT(5) | BIT(6) | BIT(7) | BIT(8))
> +#define MSCC_PHY_REG_PHY_STATUS	0x4
> +
> +struct mscc_miim_dev {
> +	struct mutex lock;
> +	void __iomem *regs;
> +	void __iomem *phy_regs;
> +};
> +
> +static int mscc_miim_wait_ready(struct mii_bus *bus)
> +{
> +	struct mscc_miim_dev *miim = bus->priv;
> +	u32 val;
> +
> +	readl_poll_timeout(miim->regs + MSCC_MIIM_REG_STATUS, val,
> +			   !(val & MSCC_MIIM_STATUS_STAT_BUSY), 100, 250000);
> +	if (val & MSCC_MIIM_STATUS_STAT_BUSY)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static int mscc_miim_read(struct mii_bus *bus, int mii_id, int regnum)
> +{
> +	struct mscc_miim_dev *miim = bus->priv;
> +	u32 val;
> +	int ret;
> +
> +	mutex_lock(&miim->lock);

What is this lock for considering that bus->lock should always be
acquired when doing these operations? As Andrew pointed out, needs to be
initialized with mutex_init(), but likely you would drop it.

> +
> +	ret = mscc_miim_wait_ready(bus);
> +	if (ret)
> +		goto out;
> +
> +	writel(MSCC_MIIM_CMD_VLD | (mii_id << MSCC_MIIM_CMD_PHYAD_SHIFT) |
> +	       (regnum << MSCC_MIIM_CMD_REGAD_SHIFT) | MSCC_MIIM_CMD_OPR_READ,
> +	       miim->regs + MSCC_MIIM_REG_CMD);
> +
> +	ret = mscc_miim_wait_ready(bus);
> +	if (ret)
> +		goto out;

Your example had an interrupt specified, can't you use that instead of
polling?

> +
> +	val = readl(miim->regs + MSCC_MIIM_REG_DATA);
> +	if (val & MSCC_MIIM_DATA_ERROR) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	ret = val & 0xFFFF;
> +out:
> +	mutex_unlock(&miim->lock);
> +	return ret;
> +}
> +
> +static int mscc_miim_write(struct mii_bus *bus, int mii_id,
> +			   int regnum, u16 value)
> +{
> +	struct mscc_miim_dev *miim = bus->priv;
> +	int ret;
> +
> +	mutex_lock(&miim->lock);
> +
> +	ret = mscc_miim_wait_ready(bus);
> +	if (ret < 0)
> +		goto out;
> +
> +	writel(MSCC_MIIM_CMD_VLD | (mii_id << MSCC_MIIM_CMD_PHYAD_SHIFT) |
> +	       (regnum << MSCC_MIIM_CMD_REGAD_SHIFT) |
> +	       (value << MSCC_MIIM_CMD_WRDATA_SHIFT) |
> +	       MSCC_MIIM_CMD_OPR_WRITE,
> +	       miim->regs + MSCC_MIIM_REG_CMD);
> +
> +out:
> +	mutex_unlock(&miim->lock);
> +	return ret;
> +}
> +
> +static int mscc_miim_reset(struct mii_bus *bus)
> +{
> +	struct mscc_miim_dev *miim = bus->priv;
> +	int i;

unsigned int i

> +
> +	if (miim->phy_regs) {
> +		writel(0, miim->phy_regs + MSCC_PHY_REG_PHY_CFG);
> +		writel(0x1ff, miim->phy_regs + MSCC_PHY_REG_PHY_CFG);
> +		mdelay(500);
> +	}
> +
> +	for (i = 0; i < PHY_MAX_ADDR; i++) {
> +		if (mscc_miim_read(bus, i, MII_PHYSID1) < 0)
> +			bus->phy_mask |= BIT(i);
> +	}

What is this used for? You have an OF MDIO bus which would create a
phy_device for each node specified, is this a similar workaround to what
drivers/net/phy/mdio-bcm-unimac.c has to do? If so, please document it
as such.

Other than that, this looks quite good!
-- 
Florian
