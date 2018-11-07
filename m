Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750A4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F5B2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F5B2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeKGR1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 12:27:43 -0500
Received: from verein.lst.de ([213.95.11.211]:47485 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbeKGR1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 12:27:43 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0AA8B68C44; Wed,  7 Nov 2018 08:58:29 +0100 (CET)
Date:   Wed, 7 Nov 2018 08:58:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: SiByte: Set 32-bit bus mask for BCM1250 PCI
Message-ID: <20181107075828.GC24381@lst.de>
References: <alpine.LFD.2.21.1811050350070.20378@eddie.linux-mips.org> <alpine.LFD.2.21.1811050428180.20378@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1811050428180.20378@eddie.linux-mips.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 12:08:23AM +0000, Maciej W. Rozycki wrote:
> The Broadcom SiByte BCM1250, BCM1125H and BCM1125 SOCs have an onchip 
> 32-bit PCI host bridge, and the two former SOCs also have an onchip HT 
> host bridge.  The HT host bridge, where present, appears in the PCI 
> configuration space as if it was a device on the 32-bit PCI bus behind 
> the PCI host bridge, however at the hardware level its signals are 
> routed separately, so these two devices are actually peer host bridges.
> 
> As documented[1] and observed in reality the 32-bit PCI host bridge does 
> not support 64-bit addressing as it does not support the Dual Address 
> Cycle (DAC) PCI command, and naturally, being 32-bit only, it has no 
> means to carry the high 32 address bits otherwise.  However the DRAM 
> controller also included in the SOC supports memory amounts of up to 
> 16GiB, and due to how the address decoder has been wired in the SOC any 
> memory beyond 1GiB is actually mapped starting from 4GiB physical up, 
> that is beyond the 32-bit addressable limit.  Consequently if the 
> maximum amount of memory has been installed, then it will span up to 
> 19GiB.
> 
> Contrariwise, the HT host bridge does support full 40-bit addressing 
> defined by the HyperTransport (formerly LDT) specification the bridge 
> adheres to, depending on the peripherals revision of the SOC[2] either 
> revision 0.17[3] or revision 1.03[4].  This allows addressing any and 
> all memory installed, and well beyond.
> 
> Set the bus mask then to limit DMA addressing to 32 bits for all the 
> devices down the 32-bit PCI host bridge, excluding however any devices 
> that are down the HT host bridge.
> 
> References:
> 
> [1] "BCM1250/BCM1125/BCM1125H User Manual", Revision 1250_1125-UM100-R, 
>     Broadcom Corporation, 21 Oct 2002, Section 8: "PCI Bus and 
>     HyperTransport Fabric", "Introduction", p. 190
> 
> [2] same, Table 140: "HyperTransport Configuration Header (Type 1)", p. 
>     245
> 
> [3] "Lightning Data Transport IO Specification", Revision 0.17, Advanced 
>     Micro Devices, 21 Jan 2000, Section 3.2.1.2 "Command Packet", p. 8
> 
> [4] "HyperTransport I/O Link Specification", Revision 1.03, 
>     HyperTransport Technology Consortium, 10 Oct 2001, Section 3.2.1.2 
>     "Request Packet", pp. 27-28
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
> Hi,
> 
>  This has been verified with a Broadcom SWARM board and an XHCI USB 32-bit 
> PCI option board plugged to one of the mainboard's 32-bit slots wired to 
> the PCI host bridge, and then a flash storage device plugged to adapter's 
> USB socket.
> 
>  With 2/2 applied first so that the bus mask is respected and a diagnostic 
> patch for `dma_direct_alloc' made to debug an earlier issue also applied
> the system shows these messages upon boot:
> 
> xhci_hcd 0000:03:00.0: assign IRQ: got 56
> xhci_hcd 0000:03:00.0: enabling bus mastering
> xhci_hcd 0000:03:00.0: xHCI Host Controller
> xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a800000185b48000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a800000185b4c000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a800000185b54000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a800000185b58000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a800000185b5c000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a800000185b60000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a800000185b64000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a800000185b68000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a800000185b6c000
> xhci_hcd 0000:03:00.0: hcc params 0x014051c7 hci version 0x100 quirks 0x0000000100000090
> xhci_hcd 0000:03:00.0: enabling Mem-Wr-Inval
> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: xHCI Host Controller
> usb usb1: Manufacturer: Linux 4.19.0 xhci-hcd
> usb usb1: SerialNumber: 0000:03:00.0
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected
> xhci_hcd 0000:03:00.0: xHCI Host Controller
> xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 2
> xhci_hcd 0000:03:00.0: Host supports USB 3.0  SuperSpeed
> xhci_hcd 0000:03:00.0: Host took too long to start, waited 16000 microseconds.
> xhci_hcd 0000:03:00.0: startup error -19
> xhci_hcd 0000:03:00.0: USB bus 2 deregistered
> xhci_hcd 0000:03:00.0: remove, state 1
> usb usb1: USB disconnect, device number 1
> xhci_hcd 0000:03:00.0: USB bus 1 deregistered
> usbcore: registered new interface driver usb-storage
> 
> As you can see `dma_direct_alloc' hands out addresses outside the 32-bit 
> physical range and then the USB host controller cannot be communicated to.  
> Also some memory has likely got corrupted (or random MMIO poked at).
> 
>  Then with this change applied the messages change to these:
> 
> xhci_hcd 0000:03:00.0: assign IRQ: got 56
> xhci_hcd 0000:03:00.0: enabling bus mastering
> xhci_hcd 0000:03:00.0: xHCI Host Controller
> xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a8000000ca050000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a8000000ca054000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a8000000ca058000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a8000000ca05c000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a8000000ca060000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a8000000ca064000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a8000000ca068000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a8000000ca06c000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a8000000ca070000
> xhci_hcd 0000:03:00.0: hcc params 0x014051c7 hci version 0x100 quirks 0x0000000100000090
> xhci_hcd 0000:03:00.0: enabling Mem-Wr-Inval
> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: xHCI Host Controller
> usb usb1: Manufacturer: Linux 4.19.0 xhci-hcd
> usb usb1: SerialNumber: 0000:03:00.0
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected
> xhci_hcd 0000:03:00.0: xHCI Host Controller
> xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 2
> xhci_hcd 0000:03:00.0: Host supports USB 3.0  SuperSpeed
> usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
> usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
> usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb2: Product: xHCI Host Controller
> usb usb2: Manufacturer: Linux 4.19.0 xhci-hcd
> usb usb2: SerialNumber: 0000:03:00.0
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> usbcore: registered new interface driver usb-storage
> 
> and then later on these:
> 
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a8000000ca074000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a8000000ca078000
> usb 2-1: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
> usb 2-1: New USB device found, idVendor=0781, idProduct=5583, bcdDevice= 1.00
> usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 2-1: Product: Ultra Fit
> usb 2-1: Manufacturer: SanDisk
> usb 2-1: SerialNumber: 4C531001340112110513
> usb-storage 2-1:1.0: USB Mass Storage device detected
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a8000000ca07c000
> scsi host5: usb-storage 2-1:1.0
> scsi 5:0:0:0: Direct-Access     SanDisk  Ultra Fit        1.00 PQ: 0 ANSI: 6
> sd 5:0:0:0: Attached scsi generic sg2 type 0
> sd 5:0:0:0: [sdc] 120127488 512-byte logical blocks: (61.5 GB/57.3 GiB)
> sd 5:0:0:0: [sdc] Write Protect is off
> sd 5:0:0:0: [sdc] Mode Sense: 43 00 00 00
> sd 5:0:0:0: [sdc] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
>  sdc: sdc1 sdc2
> sd 5:0:0:0: [sdc] Attached SCSI removable disk
> 
> moving addresses handed out by `dma_direct_alloc' to the 32-bit physical 
> range and consequently both the USB host controller and the storage device 
> behind responsive.
> 
>  If moved to one of the PCI slots down the HT link it works correctly with 
> 64-bit addressing:
> 
> xhci_hcd 0000:03:00.0: assign IRQ: got 58
> xhci_hcd 0000:03:00.0: enabling bus mastering
> xhci_hcd 0000:03:00.0: xHCI Host Controller
> xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a800000185aec000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a800000185af0000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a800000185af8000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a800000185afc000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a800000185b00000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a800000185b04000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a800000185b08000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a800000185b0c000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a800000185b10000
> xhci_hcd 0000:03:00.0: hcc params 0x014051c7 hci version 0x100 quirks 0x0000000100000090
> xhci_hcd 0000:03:00.0: enabling Mem-Wr-Inval
> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.20
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: xHCI Host Controller
> usb usb1: Manufacturer: Linux 4.20.0-rc1 xhci-hcd
> usb usb1: SerialNumber: 0000:03:00.0
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected
> xhci_hcd 0000:03:00.0: xHCI Host Controller
> xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 2
> xhci_hcd 0000:03:00.0: Host supports USB 3.0  SuperSpeed
> usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
> usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.20
> usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb2: Product: xHCI Host Controller
> usb usb2: Manufacturer: Linux 4.20.0-rc1 xhci-hcd
> usb usb2: SerialNumber: 0000:03:00.0
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> usbcore: registered new interface driver usb-storage
> 
> and:
> 
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a8000001830d4000
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a8000001830d8000
> usb 2-1: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
> usb 2-1: New USB device found, idVendor=0781, idProduct=5583, bcdDevice= 1.00
> usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 2-1: Product: Ultra Fit
> usb 2-1: Manufacturer: SanDisk
> usb 2-1: SerialNumber: 4C531001340112110513
> usb-storage 2-1:1.0: USB Mass Storage device detected
> xhci_hcd 0000:03:00.0: dma_direct_alloc: coherent: 1
> xhci_hcd 0000:03:00.0: dma_direct_alloc: returned: a8000001830dc000
> scsi host5: usb-storage 2-1:1.0
> scsi 5:0:0:0: Direct-Access     SanDisk  Ultra Fit        1.00 PQ: 0 ANSI: 6
> sd 5:0:0:0: Attached scsi generic sg2 type 0
> sd 5:0:0:0: [sdc] 120127488 512-byte logical blocks: (61.5 GB/57.3 GiB)
> sd 5:0:0:0: [sdc] Write Protect is off
> sd 5:0:0:0: [sdc] Mode Sense: 43 00 00 00
> sd 5:0:0:0: [sdc] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> 
> confirming that indeed the devices down the PCI-HT bridge don't need the 
> bus mask to be set.
> 
>  NB the reason for the bus address of the XHCI PCI device remaining the 
> same (0000:03:00.0) in the logs above regardless of the slot it has been 
> plugged in is that the option board actually includes a PCI-PCIe bridge 
> the actual XHCI device is behind, and that secondary PCIe link happens to 
> get the same bus number in enumeration.
> 
>  The BCM1480 SOC may or may not require a similar quirk, but I have no 
> documentation nor hardware to check with, so let's leave it for someone 
> who can verify it.  My understanding is it implements a PCI-X rather than 
> a plain PCI host bridge, so the limitation may well have been lifted in 
> the redesign.
> 
>   Maciej
> ---
>  arch/mips/pci/fixup-sb1250.c |   48 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> linux-mips-sibyte-sb1250-bus-dma-mask.diff
> Index: linux-20181104-swarm64-eb/arch/mips/pci/fixup-sb1250.c
> ===================================================================
> --- linux-20181104-swarm64-eb.orig/arch/mips/pci/fixup-sb1250.c
> +++ linux-20181104-swarm64-eb/arch/mips/pci/fixup-sb1250.c
> @@ -1,6 +1,7 @@
>  /*
>   *	Copyright (C) 2004, 2006  MIPS Technologies, Inc.  All rights reserved.
>   *	    Author:	Maciej W. Rozycki <macro@mips.com>
> + *	Copyright (C) 2018  Maciej W. Rozycki
>   *
>   *	This program is free software; you can redistribute it and/or
>   *	modify it under the terms of the GNU General Public License
> @@ -8,6 +9,7 @@
>   *	2 of the License, or (at your option) any later version.
>   */
>  
> +#include <linux/dma-mapping.h>
>  #include <linux/pci.h>
>  
>  /*
> @@ -22,6 +24,52 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SI
>  			quirk_sb1250_pci);
>  
>  /*
> + * The BCM1250, etc. PCI host bridge does not support DAC on its 32-bit
> + * bus, so we set the bus's DMA mask accordingly.  However the HT link
> + * down the artificial PCI-HT bridge supports 40-bit addressing and the
> + * SP1011 HT-PCI bridge downstream supports both DAC and a 64-bit bus
> + * width, so we record the PCI-HT bridge's secondary and subordinate bus
> + * numbers and do not set the mask for devices present in the inclusive
> + * range of those.
> + */
> +struct sb1250_bus_dma_mask_exclude {
> +	bool set;
> +	unsigned char start;
> +	unsigned char end;
> +};
> +
> +static int sb1250_bus_dma_mask(struct pci_dev *dev, void *data)
> +{
> +	struct sb1250_bus_dma_mask_exclude *exclude = data;
> +
> +	if (!exclude->set && (dev->vendor == PCI_VENDOR_ID_SIBYTE &&
> +			      dev->device == PCI_DEVICE_ID_BCM1250_HT)) {
> +		exclude->start = dev->subordinate->number;
> +		exclude->end = pci_bus_max_busnr(dev->subordinate);
> +		exclude->set = true;
> +		dev_dbg(&dev->dev, "not disabling DAC for [bus %02x-%02x]",
> +			exclude->start, exclude->end);
> +	} else if (!exclude->set ||
> +		   (exclude->set && (dev->bus->number < exclude->start ||
> +				     dev->bus->number > exclude->end))) {
> +		dev_dbg(&dev->dev, "disabling DAC for device");
> +		dev->dev.bus_dma_mask = DMA_BIT_MASK(32);
> +	} else {
> +		dev_dbg(&dev->dev, "not disabling DAC for device");
> +	}
> +	return 0;

Hmm, these conditions look very hard to read to me.  Wouldn't this
have the same effect?

	if (exclude->set)
		return;

	if (dev->vendor == PCI_VENDOR_ID_SIBYTE &&
	    dev->device == PCI_DEVICE_ID_BCM1250_HT) {
		exclude->start = dev->subordinate->number;
		exclude->end = pci_bus_max_busnr(dev->subordinate);
		exclude->set = true;
		dev_dbg(&dev->dev, "not disabling DAC for [bus %02x-%02x]",
			exclude->start, exclude->end);
		return;
	}

	if (dev->bus->number < exclude->start ||
	    dev->bus->number > exclude->end))) {
		dev_dbg(&dev->dev, "disabling DAC for device");
		dev->dev.bus_dma_mask = DMA_BIT_MASK(32);
		return;
	}

	dev_dbg(&dev->dev, "not disabling DAC for device");
	return 0;

Otherwise this looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
