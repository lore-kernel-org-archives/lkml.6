Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeEGCzL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 22:55:11 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45033 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751854AbeEGCzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 22:55:08 -0400
X-ME-Sender: <xms:C8DvWnNhgJbHIGythNLq7a2Pc_hMK8HLfjb-puQkRvNzZC-4Ob9IRA>
Date: Mon, 7 May 2018 12:55:03 +1000
From: "Tobin C. Harding" <tobin@apporbit.com>
To: Andrea Greco <andrea.greco.gapmilano@gmail.com>
Cc: m.grzeschik@pengutronix.de, Andrea Greco <a.greco@4sigma.it>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] arcnet: com20020: Add memory map of com20020
Message-ID: <20180507025503.GF4197@eros>
References: <20180505213448.8180-1-andrea.greco.gapmilano@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505213448.8180-1-andrea.greco.gapmilano@gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 11:34:45PM +0200, Andrea Greco wrote:
> From: Andrea Greco <a.greco@4sigma.it>

Hi Andrea,

Here are some (mostly stylistic) suggestions to help you get your driver merged.

> Add support for com20022I/com20020, memory mapped chip version.
> Support bus: Intel 80xx and Motorola 68xx.
> Bus size: Only 8 bit bus size is supported.
> Added related device tree bindings
> 
> Signed-off-by: Andrea Greco <a.greco@4sigma.it>
> ---
>  .../devicetree/bindings/net/smsc-com20020.txt      |  23 +++
>  drivers/net/arcnet/Kconfig                         |  12 +-
>  drivers/net/arcnet/Makefile                        |   1 +
>  drivers/net/arcnet/arcdevice.h                     |  27 ++-
>  drivers/net/arcnet/com20020-membus.c               | 191 +++++++++++++++++++++
>  drivers/net/arcnet/com20020.c                      |   9 +-
>  6 files changed, 253 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/smsc-com20020.txt
>  create mode 100644 drivers/net/arcnet/com20020-membus.c
> 
> diff --git a/Documentation/devicetree/bindings/net/smsc-com20020.txt b/Documentation/devicetree/bindings/net/smsc-com20020.txt
> new file mode 100644
> index 000000000000..39c5b19c55af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/smsc-com20020.txt
> @@ -0,0 +1,23 @@
> +SMSC com20020, com20022I
> +
> +timeout: Arcnet timeout, checkout datashet
> +clockp: Clock Prescaler, checkout datashet
> +clockm: Clock multiplier, checkout datasheet
> +
> +phy-reset-gpios: Chip reset ppin
> +phy-irq-gpios: Chip irq pin
> +
> +com20020_A@0 {
> +    compatible = "smsc,com20020";
> +
> +	timeout	= <0x3>;
> +	backplane = <0x0>;
> +
> +	clockp = <0x0>;
> +	clockm = <0x3>;
> +
> +	phy-reset-gpios = <&gpio3 21 GPIO_ACTIVE_LOW>;
> +	phy-irq-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
> +
> +	status = "okay";
> +};
> diff --git a/drivers/net/arcnet/Kconfig b/drivers/net/arcnet/Kconfig
> index 39bd16f3f86d..d39faf45be1e 100644
> --- a/drivers/net/arcnet/Kconfig
> +++ b/drivers/net/arcnet/Kconfig
> @@ -3,7 +3,7 @@
>  #
>  
>  menuconfig ARCNET
> -	depends on NETDEVICES && (ISA || PCI || PCMCIA)
> +	depends on NETDEVICES
>  	tristate "ARCnet support"
>  	---help---
>  	  If you have a network card of this type, say Y and check out the
> @@ -129,5 +129,15 @@ config ARCNET_COM20020_CS
>  
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called com20020_cs.  If unsure, say N.
> +config ARCNET_COM20020_MEMORY_BUS
> +	bool "Support for COM20020 on external memory"
> +	depends on ARCNET_COM20020 && !(ARCNET_COM20020_PCI || ARCNET_COM20020_ISA || ARCNET_COM20020_CS)
> +	help
> +	  Say Y here if on your custom board mount com20020 or friends.
> +
> +	  Com20022I support arcnet bus 10Mbitps.
> +	  This driver support only 8bit

This driver only supports 8bit bus size.

>         	    	 	       , and DMA is not supported is attached on your board at external interface bus.

This bit does not make sense, sorry.

> +	  Supported bus Intel80xx / Motorola 68xx.
> +	  This driver not work with other com20020 module: PCI or PCMCIA compiled as [M].

I'm not sure exactly what you want to say here, perhaps:

  	  This driver does not work with other com20020 modules compiled
	  as PCI or PCMCIA [M].
>  
>  endif # ARCNET
> diff --git a/drivers/net/arcnet/Makefile b/drivers/net/arcnet/Makefile
> index 53525e8ea130..19425c1e06f4 100644
> --- a/drivers/net/arcnet/Makefile
> +++ b/drivers/net/arcnet/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_ARCNET_COM20020) += com20020.o
>  obj-$(CONFIG_ARCNET_COM20020_ISA) += com20020-isa.o
>  obj-$(CONFIG_ARCNET_COM20020_PCI) += com20020-pci.o
>  obj-$(CONFIG_ARCNET_COM20020_CS) += com20020_cs.o
> +obj-$(CONFIG_ARCNET_COM20020_MEMORY_BUS) += com20020-membus.o
> diff --git a/drivers/net/arcnet/arcdevice.h b/drivers/net/arcnet/arcdevice.h
> index d09b2b46ab63..16c608269cca 100644
> --- a/drivers/net/arcnet/arcdevice.h
> +++ b/drivers/net/arcnet/arcdevice.h
> @@ -201,7 +201,7 @@ struct ArcProto {
>  	void (*rx)(struct net_device *dev, int bufnum,
>  		   struct archdr *pkthdr, int length);
>  	int (*build_header)(struct sk_buff *skb, struct net_device *dev,
> -			    unsigned short ethproto, uint8_t daddr);
> +				unsigned short ethproto, uint8_t daddr);

  +			    unsigned short ethproto, uint8_t daddr);

Please use Linux coding style style, parameters continuing on separate
line are aligned with opening parenthesis.

>  	/* these functions return '1' if the skb can now be freed */
>  	int (*prepare_tx)(struct net_device *dev, struct archdr *pkt,
> @@ -326,9 +326,9 @@ struct arcnet_local {
>  		void (*recontrigger) (struct net_device * dev, int enable);
>  
>  		void (*copy_to_card)(struct net_device *dev, int bufnum,
> -				     int offset, void *buf, int count);
> +					 int offset, void *buf, int count);
>  		void (*copy_from_card)(struct net_device *dev, int bufnum,
> -				       int offset, void *buf, int count);
> +					   int offset, void *buf, int count);
>  	} hw;
>  
>  	void __iomem *mem_start;	/* pointer to ioremap'ed MMIO */
> @@ -360,7 +360,7 @@ struct net_device *alloc_arcdev(const char *name);
>  int arcnet_open(struct net_device *dev);
>  int arcnet_close(struct net_device *dev);
>  netdev_tx_t arcnet_send_packet(struct sk_buff *skb,
> -			       struct net_device *dev);
> +				   struct net_device *dev);
>  void arcnet_timeout(struct net_device *dev);
>  
>  /* I/O equivalents */
> @@ -371,7 +371,23 @@ void arcnet_timeout(struct net_device *dev);
>  #define BUS_ALIGN  1
>  #endif
>  
> -/* addr and offset allow register like names to define the actual IO  address.
> +#ifdef CONFIG_ARCNET_COM20020_MEMORY_BUS
> +#define arcnet_inb(addr, offset)					\
> +	ioread8((void __iomem *)(addr) + BUS_ALIGN * (offset))
> +
> +#define arcnet_outb(value, addr, offset)				\
> +	iowrite8(value, (void __iomem *)(addr) + BUS_ALIGN * (offset))
> +
> +#define arcnet_insb(addr, offset, buffer, count)			\
> +	ioread8_rep((void __iomem *)					\
> +	(addr) + BUS_ALIGN * (offset), buffer, count)
> +
> +#define arcnet_outsb(addr, offset, buffer, count)			\
> +	iowrite8_rep((void __iomem *)					\
> +	(addr) + BUS_ALIGN * (offset), buffer, count)
> +#else
> +/**
> + * addr and offset allow register like names to define the actual IO  address.
>   * A configuration option multiplies the offset for alignment.
>   */
>  #define arcnet_inb(addr, offset)					\
> @@ -388,6 +404,7 @@ void arcnet_timeout(struct net_device *dev);
>  	readb((addr) + (offset))
>  #define arcnet_writeb(value, addr, offset)				\
>  	writeb(value, (addr) + (offset))
> +#endif
>  
>  #endif				/* __KERNEL__ */
>  #endif				/* _LINUX_ARCDEVICE_H */
> diff --git a/drivers/net/arcnet/com20020-membus.c b/drivers/net/arcnet/com20020-membus.c
> new file mode 100644
> index 000000000000..6e4a2f3a84f7
> --- /dev/null
> +++ b/drivers/net/arcnet/com20020-membus.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/* Linux ARCnet driver for com 20020.
> + *
> + * This datasheet:
> + * http://ww1.microchip.com/downloads/en/DeviceDoc/200223vrevc.pdf
> + * http://ww1.microchip.com/downloads/en/DeviceDoc/20020.pdf
> + *
> + * This driver support:

    * This driver supports:

> + * - com20020,
> + * - com20022
> + * - com20022I-3v3
> + *
> + * This driver support only, 8bit read and write.

    * This driver supports only 8bit read and write.

> + * DMA is not supported by this driver.
> + */
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/platform_device.h>
> +#include <linux/netdevice.h>
> +#include <linux/of_address.h>
> +#include <linux/of_gpio.h>
> +#include <linux/sizes.h>
> +#include <linux/interrupt.h>
> +#include <linux/ioport.h>
> +#include <linux/random.h>
> +
> +#include <linux/delay.h>
> +#include "arcdevice.h"
> +#include "com20020.h"

White space line is not needed here, you might have meant to have it one
line down?

> +
> +#define VERSION "arcnet: COM20020 MEMORY BUS support loaded.\n"
> +
> +static int com20020_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np;
> +	struct net_device *dev;
> +	struct arcnet_local *lp;
> +	struct resource res, *iores;
> +	int ret, phy_reset, err;
> +	u32 timeout, backplane, clockp, clockm;
> +	void __iomem *ioaddr;
> +
> +	np = pdev->dev.of_node;
> +
> +	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	if (of_address_to_resource(np, 0, &res))
> +		return -EINVAL;
> +
> +	ret = of_property_read_u32(np, "timeout", &timeout);
> +	if (ret) {
> +		dev_err(&pdev->dev, "timeout is required param");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "backplane", &backplane);
> +	if (ret) {
> +		dev_err(&pdev->dev, "backplane is required param");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "clockp", &clockp);
> +	if (ret) {
> +		dev_err(&pdev->dev, "clockp is required param");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "clockm", &clockm);
> +	if (ret) {
> +		dev_err(&pdev->dev, "clockm is required param");
> +		return ret;
> +	}
> +
> +	phy_reset = of_get_named_gpio(np, "phy-reset-gpios", 0);
> +	if (phy_reset == -EPROBE_DEFER) {
> +		return phy_reset;
> +	} else if (!gpio_is_valid(phy_reset)) {
> +		dev_err(&pdev->dev, "phy-reset-gpios not valid !");
> +		return 0;
> +	}
> +
> +	err = devm_gpio_request_one(&pdev->dev, phy_reset, GPIOF_OUT_INIT_LOW,
> +				    "arcnet-phy-reset");
> +	if (err) {
> +		dev_err(&pdev->dev, "failed to get phy-reset-gpios: %d\n", err);
> +		return err;
> +	}
> +
> +	dev = alloc_arcdev(NULL);// Let autoassign name arc%d

/* C89 style comments please */

> +	dev->netdev_ops = &com20020_netdev_ops;
> +	lp = netdev_priv(dev);
> +
> +	lp->card_flags = ARC_CAN_10MBIT;/* pretend all of them can 10Mbit */
> +
> +	// Force address to 0

Unnecessary, we can see this in the code :)  Please don't comment 'what'
the code does (unless it is obfuscated or difficult to read).  You may
still like to comment 'why' the code does what it does though.

> +	// Will be set by user with `ip set dev arc0 address YOUR_NODE_ID`
> +	dev->dev_addr[0] = 0;
> +
> +	// request to system this memory region

Same as above

> +	if (!devm_request_mem_region(&pdev->dev, res.start, resource_size(&res),
> +				     lp->card_name))
> +		return -EBUSY;
> +
> +	ioaddr = devm_ioremap(&pdev->dev, iores->start, resource_size(iores));
> +	if (!ioaddr) {
> +		dev_err(&pdev->dev, "ioremap fallied\n");
> +		return -ENOMEM;
> +	}
> +
> +	// Reset time is 5 * xTalFreq, minimal xtal is 10Mhz
> +	// (5 * 1000) / 10Mhz = 500ns

perhaps a macro definition
#define MAX_XTAL_RESET_TIME ??

> +
> +	gpio_set_value_cansleep(phy_reset, 0);
> +	ndelay(500);
> +	gpio_set_value_cansleep(phy_reset, 1);
> +	ndelay(500);
> +
> +	/* Dummy access after Reset
> +	 * ARCNET controller needs
> +	 * this access to detect bustype
> +	 */

nit: Upto 72 characters wide is fine for comments

	/* Dummy access after Reset ARCNET controller needs
	 * this access to detect bustype
	 */

> +	arcnet_outb(0x00, ioaddr, COM20020_REG_W_COMMAND);
> +	arcnet_inb(ioaddr, COM20020_REG_R_DIAGSTAT);
> +
> +	dev->base_addr = (unsigned long)ioaddr;
> +	get_random_bytes(dev->dev_addr, sizeof(u8));
> +
> +	dev->irq = of_get_named_gpio(np, "phy-irq-gpios", 0);
> +	if (dev->irq == -EPROBE_DEFER) {
> +		return dev->irq;
> +	} else if (!gpio_is_valid(dev->irq)) {
> +		dev_err(&pdev->dev, "phy-irq-gpios not valid !");
> +		return 0;
> +	}
> +	dev->irq = gpio_to_irq(dev->irq);
> +
> +	lp->backplane = backplane;
> +	lp->clockp = clockp & 7;
> +	lp->clockm = clockm & 3;
> +	lp->timeout = timeout;
> +	lp->hw.owner = THIS_MODULE;
> +
> +	if (arcnet_inb(ioaddr, COM20020_REG_R_STATUS) == 0xFF) {
> +		ret = -EIO;
> +		goto err_release_mem;
> +	}
> +
> +	if (com20020_check(dev)) {
> +		ret = -EIO;
> +		goto err_release_mem;
> +	}
> +
> +	ret = com20020_found(dev, IRQF_TRIGGER_FALLING);
> +	if (ret)
> +		goto err_release_mem;
> +
> +	dev_dbg(&pdev->dev, "probe Done\n");
> +	return 0;
> +
> +err_release_mem:
> +	devm_iounmap(&pdev->dev, (void __iomem *)ioaddr);
> +	devm_release_mem_region(&pdev->dev, res.start, resource_size(&res));
> +	dev_err(&pdev->dev, "probe failed!\n");
> +	return ret;
> +}
> +
> +static const struct of_device_id of_com20020_match[] = {
> +	{ .compatible = "smsc,com20020",	},
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, of_com20020_match);
> +
> +static struct platform_driver of_com20020_driver = {
> +	.driver			= {
> +		.name		= "com20020-memory-bus",
> +		.of_match_table = of_com20020_match,
> +	},
> +	.probe			= com20020_probe,
> +};
> +
> +static int com20020_init(void)
> +{
> +	return platform_driver_register(&of_com20020_driver);
> +}
> +late_initcall(com20020_init);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
> index 78043a9c5981..f09ea77dd6a8 100644
> --- a/drivers/net/arcnet/com20020.c
> +++ b/drivers/net/arcnet/com20020.c
> @@ -43,7 +43,7 @@
>  #include "com20020.h"
>  
>  static const char * const clockrates[] = {
> -	"XXXXXXX", "XXXXXXXX", "XXXXXX", "2.5 Mb/s",
> +	"10 Mb/s", "XXXXXXXX", "XXXXXX", "2.5 Mb/s",
>  	"1.25Mb/s", "625 Kb/s", "312.5 Kb/s", "156.25 Kb/s",
>  	"Reserved", "Reserved", "Reserved"
>  };
> @@ -391,9 +391,10 @@ static void com20020_set_mc_list(struct net_device *dev)
>  	}
>  }
>  
> -#if defined(CONFIG_ARCNET_COM20020_PCI_MODULE) || \
> -    defined(CONFIG_ARCNET_COM20020_ISA_MODULE) || \
> -    defined(CONFIG_ARCNET_COM20020_CS_MODULE)
> +#if	defined(CONFIG_ARCNET_COM20020_PCI_MODULE) || \
> +	defined(CONFIG_ARCNET_COM20020_ISA_MODULE) || \
> +	defined(CONFIG_ARCNET_COM20020_CS_MODULE)  || \
> +	defined(CONFIG_ARCNET_COM20020_MEMORY_BUS)

Why the whitespace change?

Hope this helps,
Tobin.
