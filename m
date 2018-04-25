Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753769AbeDYL1E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:27:04 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:54119 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753297AbeDYL0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:26:54 -0400
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
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: [PATCH 06/22] arc: use generic dma_noncoherent_ops
Thread-Topic: [PATCH 06/22] arc: use generic dma_noncoherent_ops
Thread-Index: AQHT2H4VURtktiHrREGui6QsrcbxH6QJKXmAgAgR3wA=
Date: Wed, 25 Apr 2018 11:17:01 +0000
Message-ID: <1524655020.5315.9.camel@synopsys.com>
References: <20180420080313.18796-1-hch@lst.de>
         <20180420080313.18796-7-hch@lst.de>
In-Reply-To: <20180420080313.18796-7-hch@lst.de>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <213720B0788595488614ECA66BA22CC2@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3PBR9ow023648

Hi Christoph,

On Fri, 2018-04-20 at 10:02 +0200, Christoph Hellwig wrote:
> Switch to the generic noncoherent direct mapping implementation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arc/Kconfig                   |   4 +
>  arch/arc/include/asm/Kbuild        |   1 +
>  arch/arc/include/asm/dma-mapping.h |  21 -----
>  arch/arc/mm/dma.c                  | 141 +++--------------------------
>  4 files changed, 19 insertions(+), 148 deletions(-)
>  delete mode 100644 arch/arc/include/asm/dma-mapping.h
> 

[snip]

> @@ -135,7 +134,7 @@ static int arc_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   * CPU accesses page via normal paddr, thus needs to explicitly made
>   * consistent before each use
>   */
> -static void _dma_cache_sync(phys_addr_t paddr, size_t size,
> +static void _dma_cache_sync(struct device *dev, phys_addr_t paddr size_t size,
>  		enum dma_data_direction dir)

Seems like there's a missing comma:
----------------------------------->8------------------------------------
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -134,7 +134,7 @@ int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
  * CPU accesses page via normal paddr, thus needs to explicitly made
  * consistent before each use
  */
-static void _dma_cache_sync(struct device *dev, phys_addr_t paddr size_t size,
+static void _dma_cache_sync(struct device *dev, phys_addr_t paddr, size_t size,
                enum dma_data_direction dir)
 {
        switch (dir) {
----------------------------------->8------------------------------------

Which is actually strange as I would expect ARC code to be built by bots.

Anyways with above fix I do see problems with both USB and Ethernet controllers
on ARC HSDK board.
----------------------------------->8------------------------------------
usb 1-1: new high-speed USB device number 2 using ehci-platform
usb 1-1: device descriptor read/64, error -32
usb 1-1: device descriptor read/64, error -32
usb 1-1: new high-speed USB device number 3 using ehci-platform
usb 1-1: device descriptor read/64, error -32
usb 1-1: device descriptor read/64, error -32
usb usb1-port1: attempt power cycle
usb 1-1: new high-speed USB device number 4 using ehci-platform
usb 1-1: device not accepting address 4, error -32
usb 1-1: new high-speed USB device number 5 using ehci-platform
usb 1-1: device not accepting address 5, error -32

...

# wget ftp://ftp.denx.de/pub/u-boot/u-boot-1.0.0.tar.bz2
Connecting to ftp.denx.de (81.169.202.6:21)
wget: can't connect to remote host (81.169.202.6): No route to host
----------------------------------->8------------------------------------

Will all patches from the series reverted (i.e. with
your base-line) all issues go away.

I'll need to spend more time on checking what's actually wrong.

-Alexey

P.S. Note to my ARC colleagues - it's required to disable IO Coherency
to get DMA ops really used, it could be obviously done with:
----------------------------------->8------------------------------------
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -27,7 +27,7 @@
 
 static int l2_line_sz;
 static int ioc_exists;
-int slc_enable = 1, ioc_enable = 1;
+int slc_enable = 1, ioc_enable = 0;
 unsigned long perip_base = ARC_UNCACHED_ADDR_SPACE; /* legacy value for boot */
 unsigned long perip_end = 0xFFFFFFFF; /* legacy value */
----------------------------------->8------------------------------------
