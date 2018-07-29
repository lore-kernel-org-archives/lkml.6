Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953D1C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1662E20881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1662E20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbeG2Tr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 15:47:59 -0400
Received: from smtprelay0054.hostedemail.com ([216.40.44.54]:42153 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726776AbeG2Tr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 15:47:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 5B61818026598;
        Sun, 29 Jul 2018 18:16:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: flock27_1cdcc773a8724
X-Filterd-Recvd-Size: 33122
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sun, 29 Jul 2018 18:16:38 +0000 (UTC)
Message-ID: <350ebd4172e21efc02d972420b9dbb06e506a014.camel@perches.com>
Subject: Re: [TRIVIAL RFC PATCH] Kconfigs - reduce use of "depends on EXPERT"
From:   Joe Perches <joe@perches.com>
To:     Michael =?ISO-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 29 Jul 2018 11:16:37 -0700
In-Reply-To: <20180729134202.5ab56762@wiggum>
References: <27780ceb2056b871d746803a2ac23464396f3026.camel@perches.com>
         <20180729134202.5ab56762@wiggum>
X-Priority: 1
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(removing a bunch of cc's)

On Sun, 2018-07-29 at 13:42 +0200, Michael Büsch wrote:
> On Sat, 28 Jul 2018 15:13:00 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> >  config SSB_SILENT
> > -	bool "No SSB kernel messages"
> > -	depends on SSB && EXPERT
> > +	bool "No SSB kernel messages" if EXPERT
> > +	depends on SSB
> >  	help
> >  	  This option turns off all Sonics Silicon Backplane printks.
> >  	  Note that you won't be able to identify problems, once
> 
> 
> What about removing this option entirely?
> We would just have to remove it from Kconfig and from its only use in
> drivers/ssb/ssb_private.h
> I don't think anybody uses (or should use) this option anyway.
> That would reduce the EXPERT dependencies by one, which is a good
> thing. :)

I'm fine with that, but it was originally your code from
the first ssb commit in 2007:

	This might only be desired for production kernels on
	embedded devices to reduce the kernel size.

Presumably for ddwrt and such.

Removal could simplify the ssb_<foo> printk logic a bit too.

Perhaps something like the below,
but your code, your decisions...:

---
 drivers/ssb/Kconfig                 | 14 +---------
 drivers/ssb/bridge_pcmcia_80211.c   |  2 +-
 drivers/ssb/driver_chipcommon.c     |  2 +-
 drivers/ssb/driver_chipcommon_pmu.c | 41 ++++++++++++++---------------
 drivers/ssb/driver_mipscore.c       | 26 +++++++++----------
 drivers/ssb/driver_pcicore.c        | 14 +++++-----
 drivers/ssb/embedded.c              |  4 +--
 drivers/ssb/main.c                  | 49 +++++++++++++++++-----------------
 drivers/ssb/pci.c                   | 52 ++++++++++++++++++-------------------
 drivers/ssb/pcmcia.c                | 44 ++++++++++++++-----------------
 drivers/ssb/scan.c                  | 30 ++++++++++-----------
 drivers/ssb/sprom.c                 |  4 +--
 drivers/ssb/ssb_private.h           | 25 ------------------
 13 files changed, 130 insertions(+), 177 deletions(-)

diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
index c574dd210500..6c438c819eb9 100644
--- a/drivers/ssb/Kconfig
+++ b/drivers/ssb/Kconfig
@@ -89,21 +89,9 @@ config SSB_HOST_SOC
 
 	  If unsure, say N
 
-config SSB_SILENT
-	bool "No SSB kernel messages"
-	depends on SSB && EXPERT
-	help
-	  This option turns off all Sonics Silicon Backplane printks.
-	  Note that you won't be able to identify problems, once
-	  messages are turned off.
-	  This might only be desired for production kernels on
-	  embedded devices to reduce the kernel size.
-
-	  Say N
-
 config SSB_DEBUG
 	bool "SSB debugging"
-	depends on SSB && !SSB_SILENT
+	depends on SSB
 	help
 	  This turns on additional runtime checks and debugging
 	  messages. Turn this on for SSB troubleshooting.
diff --git a/drivers/ssb/bridge_pcmcia_80211.c b/drivers/ssb/bridge_pcmcia_80211.c
index d70568ea02d5..fb623bb01d3b 100644
--- a/drivers/ssb/bridge_pcmcia_80211.c
+++ b/drivers/ssb/bridge_pcmcia_80211.c
@@ -70,7 +70,7 @@ static int ssb_host_pcmcia_probe(struct pcmcia_device *dev)
 err_kfree_ssb:
 	kfree(ssb);
 out_error:
-	ssb_err("Initialization failed (%d, %d)\n", res, err);
+	pr_err("Initialization failed (%d, %d)\n", res, err);
 	return err;
 }
 
diff --git a/drivers/ssb/driver_chipcommon.c b/drivers/ssb/driver_chipcommon.c
index 7cb7d2c8fd86..6df0929b26eb 100644
--- a/drivers/ssb/driver_chipcommon.c
+++ b/drivers/ssb/driver_chipcommon.c
@@ -354,7 +354,7 @@ void ssb_chipcommon_init(struct ssb_chipcommon *cc)
 
 	if (cc->dev->id.revision >= 11)
 		cc->status = chipco_read32(cc, SSB_CHIPCO_CHIPSTAT);
-	ssb_dbg("chipcommon status is 0x%x\n", cc->status);
+	pr_debug("chipcommon status is 0x%x\n", cc->status);
 
 	if (cc->dev->id.revision >= 20) {
 		chipco_write32(cc, SSB_CHIPCO_GPIOPULLUP, 0);
diff --git a/drivers/ssb/driver_chipcommon_pmu.c b/drivers/ssb/driver_chipcommon_pmu.c
index c5352ea4821e..25e3b15070eb 100644
--- a/drivers/ssb/driver_chipcommon_pmu.c
+++ b/drivers/ssb/driver_chipcommon_pmu.c
@@ -110,8 +110,8 @@ static void ssb_pmu0_pllinit_r0(struct ssb_chipcommon *cc,
 		return;
 	}
 
-	ssb_info("Programming PLL to %u.%03u MHz\n",
-		 crystalfreq / 1000, crystalfreq % 1000);
+	pr_info("Programming PLL to %u.%03u MHz\n",
+		crystalfreq / 1000, crystalfreq % 1000);
 
 	/* First turn the PLL off. */
 	switch (bus->chip_id) {
@@ -138,7 +138,7 @@ static void ssb_pmu0_pllinit_r0(struct ssb_chipcommon *cc,
 	}
 	tmp = chipco_read32(cc, SSB_CHIPCO_CLKCTLST);
 	if (tmp & SSB_CHIPCO_CLKCTLST_HAVEHT)
-		ssb_emerg("Failed to turn the PLL off!\n");
+		pr_emerg("Failed to turn the PLL off!\n");
 
 	/* Set PDIV in PLL control 0. */
 	pllctl = ssb_chipco_pll_read(cc, SSB_PMU0_PLLCTL0);
@@ -249,8 +249,8 @@ static void ssb_pmu1_pllinit_r0(struct ssb_chipcommon *cc,
 		return;
 	}
 
-	ssb_info("Programming PLL to %u.%03u MHz\n",
-		 crystalfreq / 1000, crystalfreq % 1000);
+	pr_info("Programming PLL to %u.%03u MHz\n",
+		crystalfreq / 1000, crystalfreq % 1000);
 
 	/* First turn the PLL off. */
 	switch (bus->chip_id) {
@@ -275,7 +275,7 @@ static void ssb_pmu1_pllinit_r0(struct ssb_chipcommon *cc,
 	}
 	tmp = chipco_read32(cc, SSB_CHIPCO_CLKCTLST);
 	if (tmp & SSB_CHIPCO_CLKCTLST_HAVEHT)
-		ssb_emerg("Failed to turn the PLL off!\n");
+		pr_emerg("Failed to turn the PLL off!\n");
 
 	/* Set p1div and p2div. */
 	pllctl = ssb_chipco_pll_read(cc, SSB_PMU1_PLLCTL0);
@@ -349,8 +349,8 @@ static void ssb_pmu_pll_init(struct ssb_chipcommon *cc)
 	case 43222:
 		break;
 	default:
-		ssb_err("ERROR: PLL init unknown for device %04X\n",
-			bus->chip_id);
+		pr_err("ERROR: PLL init unknown for device %04X\n",
+		       bus->chip_id);
 	}
 }
 
@@ -471,8 +471,8 @@ static void ssb_pmu_resources_init(struct ssb_chipcommon *cc)
 		max_msk = 0xFFFFF;
 		break;
 	default:
-		ssb_err("ERROR: PMU resource config unknown for device %04X\n",
-			bus->chip_id);
+		pr_err("ERROR: PMU resource config unknown for device %04X\n",
+		       bus->chip_id);
 	}
 
 	if (updown_tab) {
@@ -524,8 +524,8 @@ void ssb_pmu_init(struct ssb_chipcommon *cc)
 	pmucap = chipco_read32(cc, SSB_CHIPCO_PMU_CAP);
 	cc->pmu.rev = (pmucap & SSB_CHIPCO_PMU_CAP_REVISION);
 
-	ssb_dbg("Found rev %u PMU (capabilities 0x%08X)\n",
-		cc->pmu.rev, pmucap);
+	pr_debug("Found rev %u PMU (capabilities 0x%08X)\n",
+		 cc->pmu.rev, pmucap);
 
 	if (cc->pmu.rev == 1)
 		chipco_mask32(cc, SSB_CHIPCO_PMU_CTL,
@@ -636,8 +636,8 @@ u32 ssb_pmu_get_alp_clock(struct ssb_chipcommon *cc)
 	case 0x5354:
 		return ssb_pmu_get_alp_clock_clk0(cc);
 	default:
-		ssb_err("ERROR: PMU alp clock unknown for device %04X\n",
-			bus->chip_id);
+		pr_err("ERROR: PMU alp clock unknown for device %04X\n",
+		       bus->chip_id);
 		return 0;
 	}
 }
@@ -651,8 +651,8 @@ u32 ssb_pmu_get_cpu_clock(struct ssb_chipcommon *cc)
 		/* 5354 chip uses a non programmable PLL of frequency 240MHz */
 		return 240000000;
 	default:
-		ssb_err("ERROR: PMU cpu clock unknown for device %04X\n",
-			bus->chip_id);
+		pr_err("ERROR: PMU cpu clock unknown for device %04X\n",
+		       bus->chip_id);
 		return 0;
 	}
 }
@@ -665,8 +665,8 @@ u32 ssb_pmu_get_controlclock(struct ssb_chipcommon *cc)
 	case 0x5354:
 		return 120000000;
 	default:
-		ssb_err("ERROR: PMU controlclock unknown for device %04X\n",
-			bus->chip_id);
+		pr_err("ERROR: PMU controlclock unknown for device %04X\n",
+		       bus->chip_id);
 		return 0;
 	}
 }
@@ -705,9 +705,8 @@ void ssb_pmu_spuravoid_pllupdate(struct ssb_chipcommon *cc, int spuravoid)
 		pmu_ctl = SSB_CHIPCO_PMU_CTL_PLL_UPD;
 		break;
 	default:
-		ssb_printk(KERN_ERR PFX
-			   "Unknown spuravoidance settings for chip 0x%04X, not changing PLL\n",
-			   cc->dev->bus->chip_id);
+		pr_err("Unknown spuravoidance settings for chip 0x%04X, not changing PLL\n",
+		       cc->dev->bus->chip_id);
 		return;
 	}
 
diff --git a/drivers/ssb/driver_mipscore.c b/drivers/ssb/driver_mipscore.c
index f87efef42252..ff06fab6a44d 100644
--- a/drivers/ssb/driver_mipscore.c
+++ b/drivers/ssb/driver_mipscore.c
@@ -170,22 +170,22 @@ static void set_irq(struct ssb_device *dev, unsigned int irq)
 		irqflag |= (ipsflag & ~ipsflag_irq_mask[irq]);
 		ssb_write32(mdev, SSB_IPSFLAG, irqflag);
 	}
-	ssb_dbg("set_irq: core 0x%04x, irq %d => %d\n",
-		dev->id.coreid, oldirq+2, irq+2);
+	pr_debug("set_irq: core 0x%04x, irq %d => %d\n",
+		 dev->id.coreid, oldirq+2, irq+2);
 }
 
 static void print_irq(struct ssb_device *dev, unsigned int irq)
 {
 	static const char *irq_name[] = {"2(S)", "3", "4", "5", "6", "D", "I"};
-	ssb_dbg("core 0x%04x, irq : %s%s %s%s %s%s %s%s %s%s %s%s %s%s\n",
-		dev->id.coreid,
-		irq_name[0], irq == 0 ? "*" : " ",
-		irq_name[1], irq == 1 ? "*" : " ",
-		irq_name[2], irq == 2 ? "*" : " ",
-		irq_name[3], irq == 3 ? "*" : " ",
-		irq_name[4], irq == 4 ? "*" : " ",
-		irq_name[5], irq == 5 ? "*" : " ",
-		irq_name[6], irq == 6 ? "*" : " ");
+	pr_debug("core 0x%04x, irq : %s%s %s%s %s%s %s%s %s%s %s%s %s%s\n",
+		 dev->id.coreid,
+		 irq_name[0], irq == 0 ? "*" : " ",
+		 irq_name[1], irq == 1 ? "*" : " ",
+		 irq_name[2], irq == 2 ? "*" : " ",
+		 irq_name[3], irq == 3 ? "*" : " ",
+		 irq_name[4], irq == 4 ? "*" : " ",
+		 irq_name[5], irq == 5 ? "*" : " ",
+		 irq_name[6], irq == 6 ? "*" : " ");
 }
 
 static void dump_irq(struct ssb_bus *bus)
@@ -299,7 +299,7 @@ void ssb_mipscore_init(struct ssb_mipscore *mcore)
 	if (!mcore->dev)
 		return; /* We don't have a MIPS core */
 
-	ssb_dbg("Initializing MIPS core...\n");
+	pr_debug("Initializing MIPS core...\n");
 
 	bus = mcore->dev->bus;
 	hz = ssb_clockspeed(bus);
@@ -347,7 +347,7 @@ void ssb_mipscore_init(struct ssb_mipscore *mcore)
 			break;
 		}
 	}
-	ssb_dbg("after irq reconfiguration\n");
+	pr_debug("after irq reconfiguration\n");
 	dump_irq(bus);
 
 	ssb_mips_serial_init(mcore);
diff --git a/drivers/ssb/driver_pcicore.c b/drivers/ssb/driver_pcicore.c
index 5fe1c22e289b..911c6d4aec32 100644
--- a/drivers/ssb/driver_pcicore.c
+++ b/drivers/ssb/driver_pcicore.c
@@ -263,7 +263,7 @@ int ssb_pcicore_plat_dev_init(struct pci_dev *d)
 		return -ENODEV;
 	}
 
-	ssb_info("PCI: Fixing up device %s\n", pci_name(d));
+	pr_info("PCI: Fixing up device %s\n", pci_name(d));
 
 	/* Fix up interrupt lines */
 	d->irq = ssb_mips_irq(extpci_core->dev) + 2;
@@ -284,12 +284,12 @@ static void ssb_pcicore_fixup_pcibridge(struct pci_dev *dev)
 	if (dev->bus->number != 0 || PCI_SLOT(dev->devfn) != 0)
 		return;
 
-	ssb_info("PCI: Fixing up bridge %s\n", pci_name(dev));
+	pr_info("PCI: Fixing up bridge %s\n", pci_name(dev));
 
 	/* Enable PCI bridge bus mastering and memory space */
 	pci_set_master(dev);
 	if (pcibios_enable_device(dev, ~0) < 0) {
-		ssb_err("PCI: SSB bridge enable failed\n");
+		pr_err("PCI: SSB bridge enable failed\n");
 		return;
 	}
 
@@ -298,8 +298,8 @@ static void ssb_pcicore_fixup_pcibridge(struct pci_dev *dev)
 
 	/* Make sure our latency is high enough to handle the devices behind us */
 	lat = 168;
-	ssb_info("PCI: Fixing latency timer of device %s to %u\n",
-		 pci_name(dev), lat);
+	pr_info("PCI: Fixing latency timer of device %s to %u\n",
+		pci_name(dev), lat);
 	pci_write_config_byte(dev, PCI_LATENCY_TIMER, lat);
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, ssb_pcicore_fixup_pcibridge);
@@ -322,7 +322,7 @@ static void ssb_pcicore_init_hostmode(struct ssb_pcicore *pc)
 		return;
 	extpci_core = pc;
 
-	ssb_dbg("PCIcore in host mode found\n");
+	pr_debug("PCIcore in host mode found\n");
 	/* Reset devices on the external PCI bus */
 	val = SSB_PCICORE_CTL_RST_OE;
 	val |= SSB_PCICORE_CTL_CLK_OE;
@@ -337,7 +337,7 @@ static void ssb_pcicore_init_hostmode(struct ssb_pcicore *pc)
 	udelay(1); /* Assertion time demanded by the PCI standard */
 
 	if (pc->dev->bus->has_cardbus_slot) {
-		ssb_dbg("CardBus slot detected\n");
+		pr_debug("CardBus slot detected\n");
 		pc->cardbusmode = 1;
 		/* GPIO 1 resets the bridge */
 		ssb_gpio_out(pc->dev->bus, 1, 1);
diff --git a/drivers/ssb/embedded.c b/drivers/ssb/embedded.c
index 55e101115038..3f311b399b69 100644
--- a/drivers/ssb/embedded.c
+++ b/drivers/ssb/embedded.c
@@ -57,8 +57,8 @@ int ssb_watchdog_register(struct ssb_bus *bus)
 					     bus->busnumber, &wdt,
 					     sizeof(wdt));
 	if (IS_ERR(pdev)) {
-		ssb_dbg("can not register watchdog device, err: %li\n",
-			PTR_ERR(pdev));
+		pr_debug("can not register watchdog device, err: %li\n",
+			 PTR_ERR(pdev));
 		return PTR_ERR(pdev);
 	}
 
diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index 116594413f66..5d841332d413 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -256,8 +256,8 @@ int ssb_devices_thaw(struct ssb_freeze_context *ctx)
 
 		err = sdrv->probe(sdev, &sdev->id);
 		if (err) {
-			ssb_err("Failed to thaw device %s\n",
-				dev_name(sdev->dev));
+			pr_err("Failed to thaw device %s\n",
+			       dev_name(sdev->dev));
 			result = err;
 		}
 		ssb_device_put(sdev);
@@ -431,9 +431,9 @@ void ssb_bus_unregister(struct ssb_bus *bus)
 
 	err = ssb_gpio_unregister(bus);
 	if (err == -EBUSY)
-		ssb_dbg("Some GPIOs are still in use\n");
+		pr_debug("Some GPIOs are still in use\n");
 	else if (err)
-		ssb_dbg("Can not unregister GPIO driver: %i\n", err);
+		pr_debug("Can not unregister GPIO driver: %i\n", err);
 
 	ssb_buses_lock();
 	ssb_devices_unregister(bus);
@@ -518,7 +518,7 @@ static int ssb_devices_register(struct ssb_bus *bus)
 		sdev->dev = dev;
 		err = device_register(dev);
 		if (err) {
-			ssb_err("Could not register %s\n", dev_name(dev));
+			pr_err("Could not register %s\n", dev_name(dev));
 			/* Set dev to NULL to not unregister
 			 * dev on error unwinding. */
 			sdev->dev = NULL;
@@ -576,9 +576,9 @@ static int ssb_attach_queued_buses(void)
 
 		err = ssb_gpio_init(bus);
 		if (err == -ENOTSUPP)
-			ssb_dbg("GPIO driver not activated\n");
+			pr_debug("GPIO driver not activated\n");
 		else if (err)
-			ssb_dbg("Error registering GPIO driver: %i\n", err);
+			pr_debug("Error registering GPIO driver: %i\n", err);
 
 		ssb_bus_may_powerdown(bus);
 
@@ -707,11 +707,11 @@ int ssb_bus_pcibus_register(struct ssb_bus *bus, struct pci_dev *host_pci)
 
 	err = ssb_bus_register(bus, ssb_pci_get_invariants, 0);
 	if (!err) {
-		ssb_info("Sonics Silicon Backplane found on PCI device %s\n",
-			 dev_name(&host_pci->dev));
+		pr_info("Sonics Silicon Backplane found on PCI device %s\n",
+			dev_name(&host_pci->dev));
 	} else {
-		ssb_err("Failed to register PCI version of SSB with error %d\n",
-			err);
+		pr_err("Failed to register PCI version of SSB with error %d\n",
+		       err);
 	}
 
 	return err;
@@ -731,8 +731,8 @@ int ssb_bus_pcmciabus_register(struct ssb_bus *bus,
 
 	err = ssb_bus_register(bus, ssb_pcmcia_get_invariants, baseaddr);
 	if (!err) {
-		ssb_info("Sonics Silicon Backplane found on PCMCIA device %s\n",
-			 pcmcia_dev->devname);
+		pr_info("Sonics Silicon Backplane found on PCMCIA device %s\n",
+			pcmcia_dev->devname);
 	}
 
 	return err;
@@ -752,8 +752,8 @@ int ssb_bus_sdiobus_register(struct ssb_bus *bus, struct sdio_func *func,
 
 	err = ssb_bus_register(bus, ssb_sdio_get_invariants, ~0);
 	if (!err) {
-		ssb_info("Sonics Silicon Backplane found on SDIO device %s\n",
-			 sdio_func_id(func));
+		pr_info("Sonics Silicon Backplane found on SDIO device %s\n",
+			sdio_func_id(func));
 	}
 
 	return err;
@@ -771,8 +771,8 @@ int ssb_bus_host_soc_register(struct ssb_bus *bus, unsigned long baseaddr)
 
 	err = ssb_bus_register(bus, ssb_host_soc_get_invariants, baseaddr);
 	if (!err) {
-		ssb_info("Sonics Silicon Backplane found at address 0x%08lX\n",
-			 baseaddr);
+		pr_info("Sonics Silicon Backplane found at address 0x%08lX\n",
+			baseaddr);
 	}
 
 	return err;
@@ -1057,9 +1057,8 @@ static int ssb_wait_bits(struct ssb_device *dev, u16 reg, u32 bitmask,
 		}
 		udelay(10);
 	}
-	printk(KERN_ERR PFX "Timeout waiting for bitmask %08X on "
-			    "register %04X to %s.\n",
-	       bitmask, reg, (set ? "set" : "clear"));
+	pr_err("Timeout waiting for bitmask %08X on register %04X to %s\n",
+	       bitmask, reg, set ? "set" : "clear");
 
 	return -ETIMEDOUT;
 }
@@ -1169,7 +1168,7 @@ int ssb_bus_may_powerdown(struct ssb_bus *bus)
 #endif
 	return err;
 error:
-	ssb_err("Bus powerdown failed\n");
+	pr_err("Bus powerdown failed\n");
 	goto out;
 }
 EXPORT_SYMBOL(ssb_bus_may_powerdown);
@@ -1192,7 +1191,7 @@ int ssb_bus_powerup(struct ssb_bus *bus, bool dynamic_pctl)
 
 	return 0;
 error:
-	ssb_err("Bus powerup failed\n");
+	pr_err("Bus powerup failed\n");
 	return err;
 }
 EXPORT_SYMBOL(ssb_bus_powerup);
@@ -1300,19 +1299,19 @@ static int __init ssb_modinit(void)
 
 	err = b43_pci_ssb_bridge_init();
 	if (err) {
-		ssb_err("Broadcom 43xx PCI-SSB-bridge initialization failed\n");
+		pr_err("Broadcom 43xx PCI-SSB-bridge initialization failed\n");
 		/* don't fail SSB init because of this */
 		err = 0;
 	}
 	err = ssb_host_pcmcia_init();
 	if (err) {
-		ssb_err("PCMCIA host initialization failed\n");
+		pr_err("PCMCIA host initialization failed\n");
 		/* don't fail SSB init because of this */
 		err = 0;
 	}
 	err = ssb_gige_init();
 	if (err) {
-		ssb_err("SSB Broadcom Gigabit Ethernet driver initialization failed\n");
+		pr_err("SSB Broadcom Gigabit Ethernet driver initialization failed\n");
 		/* don't fail SSB init because of this */
 		err = 0;
 	}
diff --git a/drivers/ssb/pci.c b/drivers/ssb/pci.c
index 77b551da5728..04d424e10077 100644
--- a/drivers/ssb/pci.c
+++ b/drivers/ssb/pci.c
@@ -56,7 +56,7 @@ int ssb_pci_switch_coreidx(struct ssb_bus *bus, u8 coreidx)
 	}
 	return 0;
 error:
-	ssb_err("Failed to switch to core %u\n", coreidx);
+	pr_err("Failed to switch to core %u\n", coreidx);
 	return -ENODEV;
 }
 
@@ -67,9 +67,8 @@ int ssb_pci_switch_core(struct ssb_bus *bus,
 	unsigned long flags;
 
 #if SSB_VERBOSE_PCICORESWITCH_DEBUG
-	ssb_info("Switching to %s core, index %d\n",
-		 ssb_core_name(dev->id.coreid),
-		 dev->core_index);
+	pr_info("Switching to %s core, index %d\n",
+		ssb_core_name(dev->id.coreid), dev->core_index);
 #endif
 
 	spin_lock_irqsave(&bus->bar_lock, flags);
@@ -161,7 +160,7 @@ int ssb_pci_xtal(struct ssb_bus *bus, u32 what, int turn_on)
 	return err;
 
 err_pci:
-	printk(KERN_ERR PFX "Error: ssb_pci_xtal() could not access PCI config space!\n");
+	pr_err("Error: ssb_pci_xtal() could not access PCI config space!\n");
 	err = -EBUSY;
 	goto out;
 }
@@ -286,7 +285,7 @@ static int sprom_do_write(struct ssb_bus *bus, const u16 *sprom)
 	u32 spromctl;
 	u16 size = bus->sprom_size;
 
-	ssb_notice("Writing SPROM. Do NOT turn off the power! Please stand by...\n");
+	pr_notice("Writing SPROM. Do NOT turn off the power! Please stand by...\n");
 	err = pci_read_config_dword(pdev, SSB_SPROMCTL, &spromctl);
 	if (err)
 		goto err_ctlreg;
@@ -294,17 +293,17 @@ static int sprom_do_write(struct ssb_bus *bus, const u16 *sprom)
 	err = pci_write_config_dword(pdev, SSB_SPROMCTL, spromctl);
 	if (err)
 		goto err_ctlreg;
-	ssb_notice("[ 0%%");
+	pr_notice("[ 0%%");
 	msleep(500);
 	for (i = 0; i < size; i++) {
 		if (i == size / 4)
-			ssb_cont("25%%");
+			pr_cont("25%%");
 		else if (i == size / 2)
-			ssb_cont("50%%");
+			pr_cont("50%%");
 		else if (i == (size * 3) / 4)
-			ssb_cont("75%%");
+			pr_cont("75%%");
 		else if (i % 2)
-			ssb_cont(".");
+			pr_cont(".");
 		writew(sprom[i], bus->mmio + bus->sprom_offset + (i * 2));
 		mmiowb();
 		msleep(20);
@@ -317,12 +316,12 @@ static int sprom_do_write(struct ssb_bus *bus, const u16 *sprom)
 	if (err)
 		goto err_ctlreg;
 	msleep(500);
-	ssb_cont("100%% ]\n");
-	ssb_notice("SPROM written\n");
+	pr_cont("100%% ]\n");
+	pr_notice("SPROM written\n");
 
 	return 0;
 err_ctlreg:
-	ssb_err("Could not access SPROM control register.\n");
+	pr_err("Could not access SPROM control register.\n");
 	return err;
 }
 
@@ -816,7 +815,7 @@ static int sprom_extract(struct ssb_bus *bus, struct ssb_sprom *out,
 	memset(out, 0, sizeof(*out));
 
 	out->revision = in[size - 1] & 0x00FF;
-	ssb_dbg("SPROM revision %d detected\n", out->revision);
+	pr_debug("SPROM revision %d detected\n", out->revision);
 	memset(out->et0mac, 0xFF, 6);		/* preset et0 and et1 mac */
 	memset(out->et1mac, 0xFF, 6);
 
@@ -825,7 +824,7 @@ static int sprom_extract(struct ssb_bus *bus, struct ssb_sprom *out,
 		 * number stored in the SPROM.
 		 * Always extract r1. */
 		out->revision = 1;
-		ssb_dbg("SPROM treated as revision %d\n", out->revision);
+		pr_debug("SPROM treated as revision %d\n", out->revision);
 	}
 
 	switch (out->revision) {
@@ -842,8 +841,8 @@ static int sprom_extract(struct ssb_bus *bus, struct ssb_sprom *out,
 		sprom_extract_r8(out, in);
 		break;
 	default:
-		ssb_warn("Unsupported SPROM revision %d detected. Will extract v1\n",
-			 out->revision);
+		pr_warn("Unsupported SPROM revision %d detected. Will extract v1\n",
+			out->revision);
 		out->revision = 1;
 		sprom_extract_r123(out, in);
 	}
@@ -863,7 +862,7 @@ static int ssb_pci_sprom_get(struct ssb_bus *bus,
 	u16 *buf;
 
 	if (!ssb_is_sprom_available(bus)) {
-		ssb_err("No SPROM available!\n");
+		pr_err("No SPROM available!\n");
 		return -ENODEV;
 	}
 	if (bus->chipco.dev) {	/* can be unavailable! */
@@ -882,7 +881,7 @@ static int ssb_pci_sprom_get(struct ssb_bus *bus,
 	} else {
 		bus->sprom_offset = SSB_SPROM_BASE1;
 	}
-	ssb_dbg("SPROM offset is 0x%x\n", bus->sprom_offset);
+	pr_debug("SPROM offset is 0x%x\n", bus->sprom_offset);
 
 	buf = kcalloc(SSB_SPROMSIZE_WORDS_R123, sizeof(u16), GFP_KERNEL);
 	if (!buf)
@@ -907,16 +906,16 @@ static int ssb_pci_sprom_get(struct ssb_bus *bus,
 			 * available for this device in some other storage */
 			err = ssb_fill_sprom_with_fallback(bus, sprom);
 			if (err) {
-				ssb_warn("WARNING: Using fallback SPROM failed (err %d)\n",
-					 err);
+				pr_warn("WARNING: Using fallback SPROM failed (err %d)\n",
+					err);
 				goto out_free;
 			} else {
-				ssb_dbg("Using SPROM revision %d provided by platform\n",
-					sprom->revision);
+				pr_debug("Using SPROM revision %d provided by platform\n",
+					 sprom->revision);
 				err = 0;
 				goto out_free;
 			}
-			ssb_warn("WARNING: Invalid SPROM CRC (corrupt SPROM)\n");
+			pr_warn("WARNING: Invalid SPROM CRC (corrupt SPROM)\n");
 		}
 	}
 	err = sprom_extract(bus, sprom, buf, bus->sprom_size);
@@ -953,8 +952,7 @@ static int ssb_pci_assert_buspower(struct ssb_bus *bus)
 	if (likely(bus->powered_up))
 		return 0;
 
-	printk(KERN_ERR PFX "FATAL ERROR: Bus powered down "
-	       "while accessing PCI MMIO space\n");
+	pr_err("FATAL ERROR: Bus powered down while accessing PCI MMIO space\n");
 	if (bus->power_warn_count <= 10) {
 		bus->power_warn_count++;
 		dump_stack();
diff --git a/drivers/ssb/pcmcia.c b/drivers/ssb/pcmcia.c
index f03422bbf087..50a8355f3e3d 100644
--- a/drivers/ssb/pcmcia.c
+++ b/drivers/ssb/pcmcia.c
@@ -143,7 +143,7 @@ int ssb_pcmcia_switch_coreidx(struct ssb_bus *bus,
 
 	return 0;
 error:
-	ssb_err("Failed to switch to core %u\n", coreidx);
+	pr_err("Failed to switch to core %u\n", coreidx);
 	return err;
 }
 
@@ -152,9 +152,8 @@ static int ssb_pcmcia_switch_core(struct ssb_bus *bus, struct ssb_device *dev)
 	int err;
 
 #if SSB_VERBOSE_PCMCIACORESWITCH_DEBUG
-	ssb_info("Switching to %s core, index %d\n",
-		 ssb_core_name(dev->id.coreid),
-		 dev->core_index);
+	pr_info("Switching to %s core, index %d\n",
+		ssb_core_name(dev->id.coreid), dev->core_index);
 #endif
 
 	err = ssb_pcmcia_switch_coreidx(bus, dev->core_index);
@@ -190,7 +189,7 @@ int ssb_pcmcia_switch_segment(struct ssb_bus *bus, u8 seg)
 
 	return 0;
 error:
-	ssb_err("Failed to switch pcmcia segment\n");
+	pr_err("Failed to switch pcmcia segment\n");
 	return err;
 }
 
@@ -547,39 +546,39 @@ static int ssb_pcmcia_sprom_write_all(struct ssb_bus *bus, const u16 *sprom)
 	bool failed = 0;
 	size_t size = SSB_PCMCIA_SPROM_SIZE;
 
-	ssb_notice("Writing SPROM. Do NOT turn off the power! Please stand by...\n");
+	pr_notice("Writing SPROM. Do NOT turn off the power! Please stand by...\n");
 	err = ssb_pcmcia_sprom_command(bus, SSB_PCMCIA_SPROMCTL_WRITEEN);
 	if (err) {
-		ssb_notice("Could not enable SPROM write access\n");
+		pr_notice("Could not enable SPROM write access\n");
 		return -EBUSY;
 	}
-	ssb_notice("[ 0%%");
+	pr_notice("[ 0%%");
 	msleep(500);
 	for (i = 0; i < size; i++) {
 		if (i == size / 4)
-			ssb_cont("25%%");
+			pr_cont("25%%");
 		else if (i == size / 2)
-			ssb_cont("50%%");
+			pr_cont("50%%");
 		else if (i == (size * 3) / 4)
-			ssb_cont("75%%");
+			pr_cont("75%%");
 		else if (i % 2)
-			ssb_cont(".");
+			pr_cont(".");
 		err = ssb_pcmcia_sprom_write(bus, i, sprom[i]);
 		if (err) {
-			ssb_notice("Failed to write to SPROM\n");
+			pr_notice("Failed to write to SPROM\n");
 			failed = 1;
 			break;
 		}
 	}
 	err = ssb_pcmcia_sprom_command(bus, SSB_PCMCIA_SPROMCTL_WRITEDIS);
 	if (err) {
-		ssb_notice("Could not disable SPROM write access\n");
+		pr_notice("Could not disable SPROM write access\n");
 		failed = 1;
 	}
 	msleep(500);
 	if (!failed) {
-		ssb_cont("100%% ]\n");
-		ssb_notice("SPROM written\n");
+		pr_cont("100%% ]\n");
+		pr_notice("SPROM written\n");
 	}
 
 	return failed ? -EBUSY : 0;
@@ -693,9 +692,8 @@ static int ssb_pcmcia_do_get_invariants(struct pcmcia_device *p_dev,
 	return -ENOSPC; /* continue with next entry */
 
 error:
-	ssb_err(
-		   "PCMCIA: Failed to fetch device invariants: %s\n",
-		   error_description);
+	pr_err("PCMCIA: Failed to fetch device invariants: %s\n",
+	       error_description);
 	return -ENODEV;
 }
 
@@ -715,8 +713,7 @@ int ssb_pcmcia_get_invariants(struct ssb_bus *bus,
 	res = pcmcia_loop_tuple(bus->host_pcmcia, CISTPL_FUNCE,
 				ssb_pcmcia_get_mac, sprom);
 	if (res != 0) {
-		ssb_err(
-			"PCMCIA: Failed to fetch MAC address\n");
+		pr_err("PCMCIA: Failed to fetch MAC address\n");
 		return -ENODEV;
 	}
 
@@ -726,8 +723,7 @@ int ssb_pcmcia_get_invariants(struct ssb_bus *bus,
 	if ((res == 0) || (res == -ENOSPC))
 		return 0;
 
-	ssb_err(
-			"PCMCIA: Failed to fetch device invariants\n");
+	pr_err("PCMCIA: Failed to fetch device invariants\n");
 	return -ENODEV;
 }
 
@@ -836,6 +832,6 @@ int ssb_pcmcia_init(struct ssb_bus *bus)
 
 	return 0;
 error:
-	ssb_err("Failed to initialize PCMCIA host device\n");
+	pr_err("Failed to initialize PCMCIA host device\n");
 	return err;
 }
diff --git a/drivers/ssb/scan.c b/drivers/ssb/scan.c
index b9429df583eb..56caa189d966 100644
--- a/drivers/ssb/scan.c
+++ b/drivers/ssb/scan.c
@@ -125,7 +125,7 @@ static u16 pcidev_to_chipid(struct pci_dev *pci_dev)
 		chipid_fallback = 0x4401;
 		break;
 	default:
-		ssb_err("PCI-ID not in fallback list\n");
+		pr_err("PCI-ID not in fallback list\n");
 	}
 
 	return chipid_fallback;
@@ -151,7 +151,7 @@ static u8 chipid_to_nrcores(u16 chipid)
 	case 0x4704:
 		return 9;
 	default:
-		ssb_err("CHIPID not in nrcores fallback list\n");
+		pr_err("CHIPID not in nrcores fallback list\n");
 	}
 
 	return 1;
@@ -318,13 +318,13 @@ int ssb_bus_scan(struct ssb_bus *bus,
 			bus->chip_package = 0;
 		}
 	}
-	ssb_info("Found chip with id 0x%04X, rev 0x%02X and package 0x%02X\n",
-		 bus->chip_id, bus->chip_rev, bus->chip_package);
+	pr_info("Found chip with id 0x%04X, rev 0x%02X and package 0x%02X\n",
+		bus->chip_id, bus->chip_rev, bus->chip_package);
 	if (!bus->nr_devices)
 		bus->nr_devices = chipid_to_nrcores(bus->chip_id);
 	if (bus->nr_devices > ARRAY_SIZE(bus->devices)) {
-		ssb_err("More than %d ssb cores found (%d)\n",
-			SSB_MAX_NR_CORES, bus->nr_devices);
+		pr_err("More than %d ssb cores found (%d)\n",
+		       SSB_MAX_NR_CORES, bus->nr_devices);
 		goto err_unmap;
 	}
 	if (bus->bustype == SSB_BUSTYPE_SSB) {
@@ -355,18 +355,16 @@ int ssb_bus_scan(struct ssb_bus *bus,
 		dev->bus = bus;
 		dev->ops = bus->ops;
 
-		printk(KERN_DEBUG PFX
-			    "Core %d found: %s "
-			    "(cc 0x%03X, rev 0x%02X, vendor 0x%04X)\n",
-			    i, ssb_core_name(dev->id.coreid),
-			    dev->id.coreid, dev->id.revision, dev->id.vendor);
+		pr_debug("Core %d found: %s (cc 0x%03X, rev 0x%02X, vendor 0x%04X)\n",
+			 i, ssb_core_name(dev->id.coreid),
+			 dev->id.coreid, dev->id.revision, dev->id.vendor);
 
 		switch (dev->id.coreid) {
 		case SSB_DEV_80211:
 			nr_80211_cores++;
 			if (nr_80211_cores > 1) {
 				if (!we_support_multiple_80211_cores(bus)) {
-					ssb_dbg("Ignoring additional 802.11 core\n");
+					pr_debug("Ignoring additional 802.11 core\n");
 					continue;
 				}
 			}
@@ -374,7 +372,7 @@ int ssb_bus_scan(struct ssb_bus *bus,
 		case SSB_DEV_EXTIF:
 #ifdef CONFIG_SSB_DRIVER_EXTIF
 			if (bus->extif.dev) {
-				ssb_warn("WARNING: Multiple EXTIFs found\n");
+				pr_warn("WARNING: Multiple EXTIFs found\n");
 				break;
 			}
 			bus->extif.dev = dev;
@@ -382,7 +380,7 @@ int ssb_bus_scan(struct ssb_bus *bus,
 			break;
 		case SSB_DEV_CHIPCOMMON:
 			if (bus->chipco.dev) {
-				ssb_warn("WARNING: Multiple ChipCommon found\n");
+				pr_warn("WARNING: Multiple ChipCommon found\n");
 				break;
 			}
 			bus->chipco.dev = dev;
@@ -391,7 +389,7 @@ int ssb_bus_scan(struct ssb_bus *bus,
 		case SSB_DEV_MIPS_3302:
 #ifdef CONFIG_SSB_DRIVER_MIPS
 			if (bus->mipscore.dev) {
-				ssb_warn("WARNING: Multiple MIPS cores found\n");
+				pr_warn("WARNING: Multiple MIPS cores found\n");
 				break;
 			}
 			bus->mipscore.dev = dev;
@@ -412,7 +410,7 @@ int ssb_bus_scan(struct ssb_bus *bus,
 				}
 			}
 			if (bus->pcicore.dev) {
-				ssb_warn("WARNING: Multiple PCI(E) cores found\n");
+				pr_warn("WARNING: Multiple PCI(E) cores found\n");
 				break;
 			}
 			bus->pcicore.dev = dev;
diff --git a/drivers/ssb/sprom.c b/drivers/ssb/sprom.c
index e753fbe302a7..4f028a80d6c4 100644
--- a/drivers/ssb/sprom.c
+++ b/drivers/ssb/sprom.c
@@ -127,13 +127,13 @@ ssize_t ssb_attr_sprom_store(struct ssb_bus *bus,
 		goto out_kfree;
 	err = ssb_devices_freeze(bus, &freeze);
 	if (err) {
-		ssb_err("SPROM write: Could not freeze all devices\n");
+		pr_err("SPROM write: Could not freeze all devices\n");
 		goto out_unlock;
 	}
 	res = sprom_write(bus, sprom);
 	err = ssb_devices_thaw(&freeze);
 	if (err)
-		ssb_err("SPROM write: Could not thaw all devices\n");
+		pr_err("SPROM write: Could not thaw all devices\n");
 out_unlock:
 	mutex_unlock(&bus->sprom_mutex);
 out_kfree:
diff --git a/drivers/ssb/ssb_private.h b/drivers/ssb/ssb_private.h
index ef9ac8efcab4..b184fa38dfd7 100644
--- a/drivers/ssb/ssb_private.h
+++ b/drivers/ssb/ssb_private.h
@@ -6,33 +6,8 @@
 #include <linux/types.h>
 #include <linux/bcm47xx_wdt.h>
 
-
 #define PFX	"ssb: "
 
-#ifdef CONFIG_SSB_SILENT
-# define ssb_printk(fmt, ...)					\
-	do { if (0) printk(fmt, ##__VA_ARGS__); } while (0)
-#else
-# define ssb_printk(fmt, ...)					\
-	printk(fmt, ##__VA_ARGS__)
-#endif /* CONFIG_SSB_SILENT */
-
-#define ssb_emerg(fmt, ...)	ssb_printk(KERN_EMERG PFX fmt, ##__VA_ARGS__)
-#define ssb_err(fmt, ...)	ssb_printk(KERN_ERR PFX fmt, ##__VA_ARGS__)
-#define ssb_warn(fmt, ...)	ssb_printk(KERN_WARNING PFX fmt, ##__VA_ARGS__)
-#define ssb_notice(fmt, ...)	ssb_printk(KERN_NOTICE PFX fmt, ##__VA_ARGS__)
-#define ssb_info(fmt, ...)	ssb_printk(KERN_INFO PFX fmt, ##__VA_ARGS__)
-#define ssb_cont(fmt, ...)	ssb_printk(KERN_CONT fmt, ##__VA_ARGS__)
-
-/* dprintk: Debugging printk; vanishes for non-debug compilation */
-#ifdef CONFIG_SSB_DEBUG
-# define ssb_dbg(fmt, ...)					\
-	ssb_printk(KERN_DEBUG PFX fmt, ##__VA_ARGS__)
-#else
-# define ssb_dbg(fmt, ...)					\
-	do { if (0) printk(KERN_DEBUG PFX fmt, ##__VA_ARGS__); } while (0)
-#endif
-
 #ifdef CONFIG_SSB_DEBUG
 # define SSB_WARN_ON(x)		WARN_ON(x)
 # define SSB_BUG_ON(x)		BUG_ON(x)
