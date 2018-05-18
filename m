Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeERNEE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:04:04 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:57583 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeERNDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:03:54 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: "hch@lst.de" <hch@lst.de>
CC: "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: [PATCH 02/20] dma-mapping: provide a generic dma-noncoherent
 implementation
Thread-Topic: [PATCH 02/20] dma-mapping: provide a generic dma-noncoherent
 implementation
Thread-Index: AQHT6P5rOSqikBCSDk25UJEllltUWqQ1XcqA
Date: Fri, 18 May 2018 13:03:46 +0000
Message-ID: <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
References: <20180511075945.16548-1-hch@lst.de>
         <20180511075945.16548-3-hch@lst.de>
In-Reply-To: <20180511075945.16548-3-hch@lst.de>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <994FD47D919A664AB275AA5865AC4C92@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4ID4Iw8021518

Hi Christoph,

On Fri, 2018-05-11 at 09:59 +0200, Christoph Hellwig wrote:

[snip]

There seems to be one subtle issue with map/unmap code.
While investigating problems on ARC I added instrumentation as below:
---------------------------------------->8------------------------------------
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -152,14 +152,37 @@ static void _dma_cache_sync(struct device *dev, phys_addr_t paddr, size_t size,
        }
 }
 
+static const char *dir_to_str(enum dma_data_direction dir)
+{
+       switch (dir) {
+       case DMA_BIDIRECTIONAL: return "DMA_BIDIRECTIONAL";
+       case DMA_TO_DEVICE: return "DMA_TO_DEVICE";
+       case DMA_FROM_DEVICE: return "DMA_FROM_DEVICE";
+       case DMA_NONE: return "DMA_NONE";
+       default: return "WRONG_VALUE!";
+       }
+}
+
 void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
                size_t size, enum dma_data_direction dir)
 {
+       if (dir != DMA_TO_DEVICE){
+               dump_stack();
+               printk(" *** %s@%d: DMA direction is %s instead of %s\n",
+                      __func__, __LINE__, dir_to_str(dir), dir_to_str(DMA_TO_DEVICE));
+       }
+
        return _dma_cache_sync(dev, paddr, size, dir);
 }
 
 void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
                size_t size, enum dma_data_direction dir)
 {
+       if (dir != DMA_FROM_DEVICE) {
+               dump_stack();
+               printk(" *** %s@%d: DMA direction is %s instead of %s\n",
+                      __func__, __LINE__, dir_to_str(dir), dir_to_str(DMA_FROM_DEVICE));
+       }
+
        return _dma_cache_sync(dev, paddr, size, dir);
 }
---------------------------------------->8------------------------------------

And with that I noticed a bit unexpected output, see below:
---------------------------------------->8------------------------------------
Stack Trace:
  arc_unwind_core.constprop.1+0xd4/0xf8
  dump_stack+0x68/0x80
  arch_sync_dma_for_device+0x34/0xc4
  dma_noncoherent_map_sg+0x80/0x94
  __dw_mci_start_request+0x1ee/0x868
  dw_mci_request+0x17e/0x1c8
  mmc_wait_for_req+0x106/0x1ac
  mmc_app_sd_status+0x108/0x130
  mmc_sd_setup_card+0xc6/0x2e8
  mmc_attach_sd+0x1b6/0x394
  mmc_rescan+0x2f4/0x3bc
  process_one_work+0x194/0x348
  worker_thread+0xf2/0x478
  kthread+0x120/0x13c
  ret_from_fork+0x18/0x1c
 *** arch_sync_dma_for_device@172: DMA direction is DMA_FROM_DEVICE instead of DMA_TO_DEVICE
...
Stack Trace:
  arc_unwind_core.constprop.1+0xd4/0xf8
  dump_stack+0x68/0x80
  arch_sync_dma_for_device+0x34/0xc4
  dma_noncoherent_map_page+0x86/0x8c
  usb_hcd_map_urb_for_dma+0x49e/0x53c
  usb_hcd_submit_urb+0x43c/0x8c4
  usb_control_msg+0xbe/0x16c
  hub_port_init+0x5e0/0xb0c
  hub_event+0x4e6/0x1164
  process_one_work+0x194/0x348
  worker_thread+0xf2/0x478
  kthread+0x120/0x13c
  ret_from_fork+0x18/0x1c
 mmcblk0: p1 p2
 *** arch_sync_dma_for_device@172: DMA direction is DMA_FROM_DEVICE instead of DMA_TO_DEVICE

...
and quite some more of the similar
...
---------------------------------------->8------------------------------------

In case of MMC/DW_MCI (AKA DesignWare MobileStorage controller) that's an execution flow:
1) __dw_mci_start_request()
2) dw_mci_pre_dma_transfer()
3) dma_map_sg(..., mmc_get_dma_dir(data))

Note mmc_get_dma_dir() is just "data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE".
I.e. if we're preparing for sending data dma_noncoherent_map_sg() will have DMA_TO_DEVICE which
is quite OK for passing to dma_noncoherent_sync_sg_for_device() but in case of reading we'll have
DMA_FROM_DEVICE which we'll pass to dma_noncoherent_sync_sg_for_device() in dma_noncoherent_map_sg().

I'd say this is not entirely correct because IMHO arch_sync_dma_for_cpu() is supposed to only be used
in case of DMA_FROM_DEVICE and arch_sync_dma_for_device() only in case of DMA_TO_DEVICE.


> +static dma_addr_t dma_noncoherent_map_page(struct device *dev, struct page *page,
> +		unsigned long offset, size_t size, enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +	dma_addr_t addr;
> +
> +	addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
> +	if (!dma_mapping_error(dev, addr) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		arch_sync_dma_for_device(dev, page_to_phys(page), size, dir);
> +	return addr;
> +}
> +
> +static int dma_noncoherent_map_sg(struct device *dev, struct scatterlist *sgl,
> +		int nents, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	nents = dma_direct_map_sg(dev, sgl, nents, dir, attrs);
> +	if (nents > 0 && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		dma_noncoherent_sync_sg_for_device(dev, sgl, nents, dir);
> +	return nents;
> +}

The same is for unmap functions.
My guess is we need to respect direction in map/unmap functions and use
either dma_noncoherent_sync_single_for_cpu(..., DMA_FROM_DEVICE) or
dma_noncoherent_sync_single_for_device(...,DMA_TO_DEVICE).


> +static void dma_noncoherent_unmap_page(struct device *dev, dma_addr_t addr,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		dma_noncoherent_sync_single_for_cpu(dev, addr, size, dir);
> +}
> +
> +static void dma_noncoherent_unmap_sg(struct device *dev, struct scatterlist *sgl,
> +		int nents, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		dma_noncoherent_sync_sg_for_cpu(dev, sgl, nents, dir);
> +}
> +#endif

But the real fix of my problem is:
---------------------------------------->8------------------------------------
--- a/lib/dma-noncoherent.c
+++ b/lib/dma-noncoherent.c
@@ -35,7 +35,7 @@ static dma_addr_t dma_noncoherent_map_page(struct device *dev, struct page *page
 
        addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
        if (!dma_mapping_error(dev, addr) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-               arch_sync_dma_for_device(dev, page_to_phys(page), size, dir);
+               arch_sync_dma_for_device(dev, page_to_phys(page) + offset, size, dir);
        return addr;
 }
---------------------------------------->8------------------------------------

You seem to lost an offset in the page so if we happen to have a buffer not aligned to
a page boundary then we were obviously corrupting data outside our data :)

-Alexey
