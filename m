Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755943AbeEHVj2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:39:28 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46001 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755734AbeEHVj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:39:26 -0400
X-ME-Sender: <xms:DRnyWisIBjdwvI4fNhtDo7nmMD9Po2zZicvvcubNTxgYELdGY2dGsw>
Date: Wed, 9 May 2018 07:39:21 +1000
From: "Tobin C. Harding" <tobin@apporbit.com>
To: Andrea Greco <andrea.greco.gapmilano@gmail.com>
Cc: m.grzeschik@pengutronix.de, Andrea Greco <a.greco@4sigma.it>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] arcnet: com20020: Add memory map of com20020
Message-ID: <20180508213921.GC7517@eros>
References: <20180505213448.8180-1-andrea.greco.gapmilano@gmail.com>
 <20180507025503.GF4197@eros>
 <710123d5-c012-5d8f-1c9c-d197f341e702@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <710123d5-c012-5d8f-1c9c-d197f341e702@gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 11:36:51AM +0200, Andrea Greco wrote:
> On 05/07/2018 04:55 AM, Tobin C. Harding wrote:
> >On Sat, May 05, 2018 at 11:34:45PM +0200, Andrea Greco wrote:
> >>From: Andrea Greco <a.greco@4sigma.it>
> >
> >Hi Andrea,
> >
> >Here are some (mostly stylistic) suggestions to help you get your driver merged.
> >
> >>Add support for com20022I/com20020, memory mapped chip version.
> >>Support bus: Intel 80xx and Motorola 68xx.
> >>Bus size: Only 8 bit bus size is supported.
> >>Added related device tree bindings
> >>
> >>Signed-off-by: Andrea Greco <a.greco@4sigma.it>
> >>---
> >>  .../devicetree/bindings/net/smsc-com20020.txt      |  23 +++
> >>  drivers/net/arcnet/Kconfig                         |  12 +-
> >>  drivers/net/arcnet/Makefile                        |   1 +
> >>  drivers/net/arcnet/arcdevice.h                     |  27 ++-
> >>  drivers/net/arcnet/com20020-membus.c               | 191 +++++++++++++++++++++
> >>  drivers/net/arcnet/com20020.c                      |   9 +-
> >>  6 files changed, 253 insertions(+), 10 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/net/smsc-com20020.txt
> >>  create mode 100644 drivers/net/arcnet/com20020-membus.c
> >>
> >>diff --git a/Documentation/devicetree/bindings/net/smsc-com20020.txt b/Documentation/devicetree/bindings/net/smsc-com20020.txt
> >>new file mode 100644
> >>index 000000000000..39c5b19c55af
> >>--- /dev/null
> >>+++ b/Documentation/devicetree/bindings/net/smsc-com20020.txt
> >>@@ -0,0 +1,23 @@
> >>+SMSC com20020, com20022I
> >>+
> >>+timeout: Arcnet timeout, checkout datashet
> >>+clockp: Clock Prescaler, checkout datashet
> >>+clockm: Clock multiplier, checkout datasheet
> >>+
> >>+phy-reset-gpios: Chip reset ppin
> >>+phy-irq-gpios: Chip irq pin
> 
> ppin Corrected by my-self.
> 
> >>+
> >>+com20020_A@0 {
> >>+    compatible = "smsc,com20020";
> >>+
> >>+	timeout	= <0x3>;
> >>+	backplane = <0x0>;
> >>+
> >>+	clockp = <0x0>;
> >>+	clockm = <0x3>;
> >>+
> >>+	phy-reset-gpios = <&gpio3 21 GPIO_ACTIVE_LOW>;
> >>+	phy-irq-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
> >>+
> >>+	status = "okay";
> >>+};
> >>diff --git a/drivers/net/arcnet/Kconfig b/drivers/net/arcnet/Kconfig
> >>index 39bd16f3f86d..d39faf45be1e 100644
> >>--- a/drivers/net/arcnet/Kconfig
> >>+++ b/drivers/net/arcnet/Kconfig
> >>@@ -3,7 +3,7 @@
> >>  #
> >>  menuconfig ARCNET
> >>-	depends on NETDEVICES && (ISA || PCI || PCMCIA)
> >>+	depends on NETDEVICES
> >>  	tristate "ARCnet support"
> >>  	---help---
> >>  	  If you have a network card of this type, say Y and check out the
> >>@@ -129,5 +129,15 @@ config ARCNET_COM20020_CS
> >>  	  To compile this driver as a module, choose M here: the module will be
> >>  	  called com20020_cs.  If unsure, say N.
> >>+config ARCNET_COM20020_MEMORY_BUS
> >>+	bool "Support for COM20020 on external memory"
> >>+	depends on ARCNET_COM20020 && !(ARCNET_COM20020_PCI || ARCNET_COM20020_ISA || ARCNET_COM20020_CS)
> >>+	help
> >>+	  Say Y here if on your custom board mount com20020 or friends.
> >>+
> >>+	  Com20022I support arcnet bus 10Mbitps.
> >>+	  This driver support only 8bit
> >
> >This driver only supports 8bit bus size.
> >
> >>         	    	 	       , and DMA is not supported is attached on your board at external interface bus.
> >
> >This bit does not make sense, sorry.
> Removed description,
> 
> Proposal for v2:
> Say Y here if your custom board mount com20020 chipset or friends.
> Supported Chipset: com20020, com20022, com20022I-3v3.
> If unsure, say N.

If you don't mind me doing review I'll do so again on v2 and comment then.

> >>+	  Supported bus Intel80xx / Motorola 68xx.
> >>+	  This driver not work with other com20020 module: PCI or PCMCIA compiled as [M].
> >
> >I'm not sure exactly what you want to say here, perhaps:
> >
> >   	  This driver does not work with other com20020 modules compiled
> >	  as PCI or PCMCIA [M].
> 
> About this, all removed from kconfig
> For PCI, PCMCIA, checkout downside
> 
> >>  endif # ARCNET
> >>diff --git a/drivers/net/arcnet/Makefile b/drivers/net/arcnet/Makefile
> >>index 53525e8ea130..19425c1e06f4 100644
> >>--- a/drivers/net/arcnet/Makefile
> >>+++ b/drivers/net/arcnet/Makefile
> >>@@ -14,3 +14,4 @@ obj-$(CONFIG_ARCNET_COM20020) += com20020.o
> >>  obj-$(CONFIG_ARCNET_COM20020_ISA) += com20020-isa.o
> >>  obj-$(CONFIG_ARCNET_COM20020_PCI) += com20020-pci.o
> >>  obj-$(CONFIG_ARCNET_COM20020_CS) += com20020_cs.o
> >>+obj-$(CONFIG_ARCNET_COM20020_MEMORY_BUS) += com20020-membus.o
> >>diff --git a/drivers/net/arcnet/arcdevice.h b/drivers/net/arcnet/arcdevice.h
> >>index d09b2b46ab63..16c608269cca 100644
> >>--- a/drivers/net/arcnet/arcdevice.h
> >>+++ b/drivers/net/arcnet/arcdevice.h
> >>@@ -201,7 +201,7 @@ struct ArcProto {
> >>  	void (*rx)(struct net_device *dev, int bufnum,
> >>  		   struct archdr *pkthdr, int length);
> >>  	int (*build_header)(struct sk_buff *skb, struct net_device *dev,
> >>-			    unsigned short ethproto, uint8_t daddr);
> >>+				unsigned short ethproto, uint8_t daddr);
> >
> >   +			    unsigned short ethproto, uint8_t daddr);
> >
> >Please use Linux coding style style, parameters continuing on separate
> >line are aligned with opening parenthesis.
> >
> >>  	/* these functions return '1' if the skb can now be freed */
> >>  	int (*prepare_tx)(struct net_device *dev, struct archdr *pkt,
> >>@@ -326,9 +326,9 @@ struct arcnet_local {
> >>  		void (*recontrigger) (struct net_device * dev, int enable);
> >>  		void (*copy_to_card)(struct net_device *dev, int bufnum,
> >>-				     int offset, void *buf, int count);
> >>+					 int offset, void *buf, int count);
> >>  		void (*copy_from_card)(struct net_device *dev, int bufnum,
> >>-				       int offset, void *buf, int count);
> >>+					   int offset, void *buf, int count);
> >>  	} hw;
> >>  	void __iomem *mem_start;	/* pointer to ioremap'ed MMIO */
> >>@@ -360,7 +360,7 @@ struct net_device *alloc_arcdev(const char *name);
> >>  int arcnet_open(struct net_device *dev);
> >>  int arcnet_close(struct net_device *dev);
> >>  netdev_tx_t arcnet_send_packet(struct sk_buff *skb,
> >>-			       struct net_device *dev);
> >>+				   struct net_device *dev);
> >>  void arcnet_timeout(struct net_device *dev);
> 
> Not required modification then all removed.
> 
> >>  /* I/O equivalents */
> >>@@ -371,7 +371,23 @@ void arcnet_timeout(struct net_device *dev);
> >>  #define BUS_ALIGN  1
> >>  #endif
> >>-/* addr and offset allow register like names to define the actual IO  address.
> >>+#ifdef CONFIG_ARCNET_COM20020_MEMORY_BUS
> >>+#define arcnet_inb(addr, offset)					\
> >>+	ioread8((void __iomem *)(addr) + BUS_ALIGN * (offset))
> >>+
> >>+#define arcnet_outb(value, addr, offset)				\
> >>+	iowrite8(value, (void __iomem *)(addr) + BUS_ALIGN * (offset))
> >>+
> >>+#define arcnet_insb(addr, offset, buffer, count)			\
> >>+	ioread8_rep((void __iomem *)					\
> >>+	(addr) + BUS_ALIGN * (offset), buffer, count)
> >>+
> >>+#define arcnet_outsb(addr, offset, buffer, count)			\
> >>+	iowrite8_rep((void __iomem *)					\
> >>+	(addr) + BUS_ALIGN * (offset), buffer, count)
> >>+#else
> >>+/**
> >>+ * addr and offset allow register like names to define the actual IO  address.
> >>   * A configuration option multiplies the offset for alignment.
> >>   */
> >>  #define arcnet_inb(addr, offset)					\
> >>@@ -388,6 +404,7 @@ void arcnet_timeout(struct net_device *dev);
> >>  	readb((addr) + (offset))
> >>  #define arcnet_writeb(value, addr, offset)				\
> >>  	writeb(value, (addr) + (offset))
> >>+#endif
> >>  #endif				/* __KERNEL__ */
> >>  #endif				/* _LINUX_ARCDEVICE_H */
> 
> 
> This is most important part where a suggestion will be very appreciated.
> This part define how arcnet drivers read and write over physical.
> The old driver can always use readb/writeb and friends, this driver rise big
> kernel panic.
> 
> This driver make a ioreamp with: devm_ioremap.
> Then, for r/w operation i use ioread8/iowrite8 and friends.
> 
> My quickly solution was make a ugly #ifdef.
> 
> With #ifndef all other driver implementation could not be used together
> this driver, because break, how driver write over physical.
> A proposal could be add a read/write callback to arcdevice.h struct hw.
> 
> PROS:
> Every driver fill this callback, this is a solution.
> 
> CONS:
> This solution require a small change for all com20020 driver
> implementations. I don't dispose of all hardware for make a accurate
> test. I could only test memory bus version.
> 
> Any other ideas, will be very appreciated.

I had a bit of a think about this for you.  Can I start by saying I am
not an overly experienced driver developer (or kernel developer for that
matter) so please take all suggestions with this in mind.

Instead of using ifdef's to define arnet_inb/outb() what if you define a
set of functions arnet_readb(), arnet_writeb() etc and use them after
you have done the memory map.  (I had to look up the difference between
readb() and inb() so if this suggestion is complete garbage please
ignore me.)

Also while reading com20020-membus.c I saw a few more changes that you
can use if you so please.  Here is a patch with comments added

diff --git a/drivers/net/arcnet/com20020-membus.c b/drivers/net/arcnet/com20020-membus.c
index 9eead734a3cf..9f3d9b8d9d1f 100644
--- a/drivers/net/arcnet/com20020-membus.c
+++ b/drivers/net/arcnet/com20020-membus.c
@@ -39,7 +39,7 @@ static int com20020_probe(struct platform_device *pdev)
        struct net_device *dev;
        struct arcnet_local *lp;
        struct resource res, *iores;
-       int ret, phy_reset, err;
+       int ret, phy_reset;

This function uses 'ret', 'err', and 'phy_reset' for return value.  I
see what you are getting at by using 'phy_reset' but I don't see the
value in having both 'err' and 'ret' in the same function.

        u32 timeout, backplane, clockp, clockm;
        void __iomem *ioaddr;
 
@@ -47,8 +47,9 @@ static int com20020_probe(struct platform_device *pdev)
 
        iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-       if (of_address_to_resource(np, 0, &res))
-               return -EINVAL;
+       ret = of_address_to_resource(np, 0, &res);
+       if (ret)
+               return ret;
 
of_address_to_resource() returns -EINVAL on error so we can return it
and maintain program logic.  I see other places intree however that
call of_address_to_resource() as you have done.

        ret = of_property_read_u32(np, "timeout", &timeout);
        if (ret) {
@@ -77,16 +78,17 @@ static int com20020_probe(struct platform_device *pdev)
        phy_reset = of_get_named_gpio(np, "phy-reset-gpios", 0);
        if (phy_reset == -EPROBE_DEFER) {
                return phy_reset;
-       } else if (!gpio_is_valid(phy_reset)) {
+       }

No need for else statement after 'return' (golang linter complains about
this so I always notice it :)

+       if (!gpio_is_valid(phy_reset)) {
                dev_err(&pdev->dev, "phy-reset-gpios not valid !");
-               return 0;
+               return 0;       /* why return 0 after calling dev_err() */

(Added code comment so it would show up in patch.)  I couldn't
understand why this returns 0 here.  Is it what you meant to do?

        }
 
-       err = devm_gpio_request_one(&pdev->dev, phy_reset, GPIOF_OUT_INIT_LOW,
+       ret = devm_gpio_request_one(&pdev->dev, phy_reset, GPIOF_OUT_INIT_LOW,
                                    "arcnet-phy-reset");
-       if (err) {
-               dev_err(&pdev->dev, "failed to get phy-reset-gpios: %d\n", err);
-               return err;

Already commented on above.


Hope this helps,
Tobin.
