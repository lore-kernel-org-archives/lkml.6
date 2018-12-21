Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2E5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C656F2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388942AbeLUJsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:48:14 -0500
Received: from verein.lst.de ([213.95.11.211]:57999 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbeLUJsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:48:14 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 16CF168AA6; Fri, 21 Dec 2018 10:48:12 +0100 (CET)
Date:   Fri, 21 Dec 2018 10:48:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] dma-mapping updates for Linux 4.21
Message-ID: <20181221094812.GA2713@lst.de>
References: <20181221094549.GA14522@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181221094549.GA14522@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 10:45:49AM +0100, Christoph Hellwig wrote:
> The following changes since commit c9d76d0655c06b8c1f944e46c4fd9e9cf4b331c0:
> 
>   dma-mapping: fix return type of dma_set_max_seg_size() (2018-11-27 08:39:52 +0100)

And that actually is the first commit already in the tree, sorry.

Updated git-request-pull output attached:


The following changes since commit ef78e5ec9214376c5cb989f5da70b02d0c117b66:

  ia64: export node_distance function (2018-11-26 18:30:40 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.21

for you to fetch changes up to 8b1cce9f5832a8eda17d37a3c49fb7dd2d650f46:

  dma-mapping: fix inverted logic in dma_supported (2018-12-20 17:47:55 +0100)

----------------------------------------------------------------
DMA mapping updates for Linux 4.21

A huge update this time, but a lot of that is just consolidating or
removing code:

 - provide a common DMA_MAPPING_ERROR definition and avoid indirect
   calls for dma_map_* error checking
 - use direct calls for the DMA direct mapping case, avoiding huge
   retpoline overhead for high performance workloads
 - merge the swiotlb dma_map_ops into dma-direct
 - provide a generic remapping DMA consistent allocator for architectures
   that have devices that perform DMA that is not cache coherent. Based
   on the existing arm64 implementation and also used for csky now.
 - improve the dma-debug infrastructure, including dynamic allocation
   of entries (Robin Murphy)
 - default to providing chaining scatterlist everywhere, with opt-outs
   for the few architectures (alpha, parisc, most arm32 variants) that
   can't cope with it
 - misc sparc32 dma-related cleanups
 - remove the dma_mark_clean arch hook used by swiotlb on ia64 and
   replace it with the generic noncoherent infrastructure
 - fix the return type of dma_set_max_seg_size (Niklas Söderlund)
 - move the dummy dma ops for not DMA capable devices from arm64 to
   common code (Robin Murphy)
 - ensure dma_alloc_coherent returns zeroed memory to avoid kernel data
   leaks through userspace.  We already did this for most common
   architectures, but this ensures we do it everywhere.
   dma_zalloc_coherent has been deprecated and can hopefully be
   removed after -rc1 with a coccinelle script.

----------------------------------------------------------------
Christoph Hellwig (60):
      dma-direct: provide page based alloc/free helpers
      dma-direct: reject highmem pages from dma_alloc_from_contiguous
      dma-mapping: move the remap helpers to a separate file
      dma-mapping: move the arm64 noncoherent alloc/free support to common code
      dma-mapping: support highmem in the generic remap allocator
      dma-remap: support DMA_ATTR_NO_KERNEL_MAPPING
      csky: don't select DMA_NONCOHERENT_OPS
      csky: don't use GFP_DMA in atomic_pool_init
      csky: use the generic remapping dma alloc implementation
      dma-mapping: provide a generic DMA_MAPPING_ERROR
      dma-direct: remove the mapping_error dma_map_ops method
      arm: remove the mapping_error dma_map_ops method
      powerpc/iommu: remove the mapping_error dma_map_ops method
      mips/jazz: remove the mapping_error dma_map_ops method
      s390: remove the mapping_error dma_map_ops method
      sparc: remove the mapping_error dma_map_ops method
      parisc/ccio: remove the mapping_error dma_map_ops method
      parisc/sba_iommu: remove the mapping_error dma_map_ops method
      arm64: remove the dummy_dma_ops mapping_error method
      alpha: remove the mapping_error dma_map_ops method
      ia64/sba_iommu: improve internal map_page users
      ia64/sba_iommu: remove the mapping_error dma_map_ops method
      ia64/sn: remove the mapping_error dma_map_ops method
      x86/amd_gart: remove the mapping_error dma_map_ops method
      x86/calgary: remove the mapping_error dma_map_ops method
      iommu: remove the mapping_error dma_map_ops method
      iommu/intel: small map_page cleanup
      iommu/vt-d: remove the mapping_error dma_map_ops method
      iommu/dma-iommu: remove the mapping_error dma_map_ops method
      xen-swiotlb: remove the mapping_error dma_map_ops method
      dma-mapping: remove the mapping_error dma_map_ops method
      dma-mapping: return an error code from dma_mapping_error
      arch: switch the default on ARCH_HAS_SG_CHAIN
      sparc: remove not needed sbus_dma_ops methods
      sparc: factor the dma coherent mapping into helper
      sparc: remove the sparc32_dma_ops indirection
      sparc: remove not required includes from dma-mapping.h
      sparc: move the leon PCI memory space comment to <asm/leon.h>
      sparc: merge 32-bit and 64-bit version of pci.h
      sparc: use DT node full_name in sparc_dma_alloc_resource
      dma-mapping: remove a pointless memset in dma_atomic_pool_init
      dma-mapping: simplify the dma_sync_single_range_for_{cpu,device} implementation
      dma-mapping: merge dma_unmap_page_attrs and dma_unmap_single_attrs
      dma-mapping: move dma_get_required_mask to kernel/dma
      dma-mapping: move various slow path functions out of line
      dma-mapping: move dma_cache_sync out of line
      dma-mapping: always build the direct mapping code
      swiotlb: remove SWIOTLB_MAP_ERROR
      swiotlb: remove dma_mark_clean
      dma-direct: improve addressability error reporting
      dma-direct: use dma_direct_map_page to implement dma_direct_map_sg
      dma-direct: merge swiotlb_dma_ops into the dma_direct code
      vmd: use the proper dma_* APIs instead of direct methods calls
      dma-mapping: bypass indirect calls for dma-direct
      ia64: only select ARCH_HAS_DMA_COHERENT_TO_PFN if swiotlb is enabled
      arm64: default to the direct mapping in get_arch_dma_ops
      sparc/io-unit: fix ->map_sg return value
      sparc/iommu: fix ->map_sg return value
      dma-mapping: zero memory returned from dma_alloc_*
      dma-mapping: deprecate dma_zalloc_coherent

Marek Szyprowski (1):
      dma-mapping: fix lack of DMA address assignment in generic remap allocator

Nathan Chancellor (1):
      PCI: Remove unused attr variable in pci_dma_configure

Niklas Söderlund (1):
      dma-mapping: fix return type of dma_set_max_seg_size()

Robin Murphy (9):
      dma-debug: Expose nr_total_entries in debugfs
      dma-debug: Use pr_fmt()
      dma-debug: Dynamically expand the dma_debug_entry pool
      dma-debug: Make leak-like behaviour apparent
      x86/dma/amd-gart: Stop resizing dma_debug_entry pool
      dma/debug: Remove dma_debug_resize_entries()
      dma-debug: Batch dma_debug_entry allocation
      dma-mapping: factor out dummy DMA ops
      ACPI / scan: Refactor _CCA enforcement

Thierry Reding (1):
      dma-mapping: fix inverted logic in dma_supported

 Documentation/DMA-API.txt                          |  29 +-
 .../features/io/sg-chain/arch-support.txt          |  33 --
 Documentation/x86/x86_64/boot-options.txt          |   5 +-
 arch/alpha/Kconfig                                 |   2 +-
 arch/alpha/include/asm/dma-mapping.h               |   2 +-
 arch/alpha/kernel/pci_iommu.c                      |  16 +-
 arch/arc/Kconfig                                   |   2 -
 arch/arc/mm/cache.c                                |   2 +-
 arch/arc/mm/dma.c                                  |   2 +-
 arch/arm/Kconfig                                   |   4 +-
 arch/arm/common/dmabounce.c                        |  12 +-
 arch/arm/include/asm/dma-iommu.h                   |   2 -
 arch/arm/include/asm/dma-mapping.h                 |   2 +-
 arch/arm/mm/dma-mapping-nommu.c                    |  14 +-
 arch/arm/mm/dma-mapping.c                          |  39 +--
 arch/arm64/Kconfig                                 |   3 +-
 arch/arm64/include/asm/dma-mapping.h               |   8 +-
 arch/arm64/mm/dma-mapping.c                        | 286 +----------------
 arch/c6x/Kconfig                                   |   1 -
 arch/c6x/mm/dma-coherent.c                         |   5 +-
 arch/csky/Kconfig                                  |   3 +-
 arch/csky/mm/dma-mapping.c                         | 142 +--------
 arch/h8300/Kconfig                                 |   1 -
 arch/hexagon/Kconfig                               |   1 -
 arch/ia64/Kconfig                                  |   4 +-
 arch/ia64/hp/common/hwsw_iommu.c                   |   2 +-
 arch/ia64/hp/common/sba_iommu.c                    |  87 ++---
 arch/ia64/kernel/dma-mapping.c                     |  21 +-
 arch/ia64/mm/init.c                                |  19 +-
 arch/ia64/sn/pci/pci_dma.c                         |   8 +-
 arch/m68k/Kconfig                                  |   1 -
 arch/m68k/kernel/dma.c                             |   2 +-
 arch/microblaze/Kconfig                            |   1 -
 arch/microblaze/mm/consistent.c                    |   2 +-
 arch/mips/Kconfig                                  |   1 -
 arch/mips/include/asm/dma-mapping.h                |   4 +-
 arch/mips/include/asm/jazzdma.h                    |   6 -
 arch/mips/jazz/jazzdma.c                           |  16 +-
 arch/nds32/Kconfig                                 |   1 -
 arch/nios2/Kconfig                                 |   1 -
 arch/openrisc/Kconfig                              |   1 -
 arch/openrisc/kernel/dma.c                         |   2 +-
 arch/parisc/Kconfig                                |   2 +-
 arch/parisc/kernel/pci-dma.c                       |   4 +-
 arch/parisc/kernel/setup.c                         |   4 -
 arch/powerpc/Kconfig                               |   1 -
 arch/powerpc/include/asm/dma-mapping.h             |   1 -
 arch/powerpc/include/asm/iommu.h                   |   4 -
 arch/powerpc/kernel/dma-iommu.c                    |   6 -
 arch/powerpc/kernel/dma-swiotlb.c                  |  17 +-
 arch/powerpc/kernel/iommu.c                        |  28 +-
 arch/powerpc/platforms/cell/iommu.c                |   1 -
 arch/powerpc/platforms/pseries/vio.c               |   3 +-
 arch/riscv/Kconfig                                 |   1 -
 arch/riscv/include/asm/dma-mapping.h               |  15 -
 arch/s390/Kconfig                                  |   2 -
 arch/s390/pci/pci_dma.c                            |  20 +-
 arch/sh/Kconfig                                    |   1 -
 arch/sparc/Kconfig                                 |   2 -
 arch/sparc/include/asm/dma-mapping.h               |   8 +-
 arch/sparc/include/asm/dma.h                       |  48 +--
 arch/sparc/include/asm/leon.h                      |   9 +
 arch/sparc/include/asm/pci.h                       |  53 +++-
 arch/sparc/include/asm/pci_32.h                    |  41 ---
 arch/sparc/include/asm/pci_64.h                    |  52 ---
 arch/sparc/kernel/iommu.c                          |  12 +-
 arch/sparc/kernel/iommu_common.h                   |   2 -
 arch/sparc/kernel/ioport.c                         | 243 +++-----------
 arch/sparc/kernel/pci_sun4v.c                      |  14 +-
 arch/sparc/mm/io-unit.c                            |  80 +++--
 arch/sparc/mm/iommu.c                              | 160 ++++++----
 arch/unicore32/Kconfig                             |   1 -
 arch/x86/Kconfig                                   |   2 -
 arch/x86/kernel/amd_gart_64.c                      |  63 +---
 arch/x86/kernel/pci-calgary_64.c                   |  30 +-
 arch/x86/kernel/pci-dma.c                          |   2 +-
 arch/x86/kernel/pci-swiotlb.c                      |   4 +-
 arch/x86/mm/mem_encrypt.c                          |   7 -
 arch/x86/pci/sta2x11-fixup.c                       |   1 -
 arch/xtensa/Kconfig                                |   3 +-
 arch/xtensa/kernel/pci-dma.c                       |   2 +-
 drivers/acpi/scan.c                                |   5 +
 drivers/base/platform.c                            |  34 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   2 +-
 drivers/iommu/amd_iommu.c                          |  31 +-
 drivers/iommu/dma-iommu.c                          |  23 +-
 drivers/iommu/intel-iommu.c                        |  26 +-
 drivers/misc/mic/host/mic_boot.c                   |   2 +-
 drivers/parisc/ccio-dma.c                          |  10 +-
 drivers/parisc/sba_iommu.c                         |  10 +-
 drivers/pci/controller/vmd.c                       |  48 +--
 drivers/pci/pci-driver.c                           |   4 +-
 drivers/xen/swiotlb-xen.c                          |  36 +--
 include/asm-generic/dma-mapping.h                  |   2 +-
 include/linux/dma-debug.h                          |  34 --
 include/linux/dma-direct.h                         |  19 +-
 include/linux/dma-iommu.h                          |   1 -
 include/linux/dma-mapping.h                        | 350 +++++++++------------
 include/linux/dma-noncoherent.h                    |   7 +-
 include/linux/scatterlist.h                        |   6 +-
 include/linux/swiotlb.h                            |  77 ++---
 kernel/dma/Kconfig                                 |  14 +-
 kernel/dma/Makefile                                |   5 +-
 kernel/dma/debug.c                                 | 259 ++++++---------
 kernel/dma/direct.c                                | 222 +++++++------
 kernel/dma/dummy.c                                 |  39 +++
 kernel/dma/mapping.c                               | 223 +++++++++----
 kernel/dma/remap.c                                 | 256 +++++++++++++++
 kernel/dma/swiotlb.c                               | 253 +--------------
 kernel/dma/virt.c                                  |   2 +-
 lib/Kconfig                                        |   2 +-
 lib/scatterlist.c                                  |   2 +-
 112 files changed, 1408 insertions(+), 2340 deletions(-)
 delete mode 100644 Documentation/features/io/sg-chain/arch-support.txt
 delete mode 100644 arch/riscv/include/asm/dma-mapping.h
 delete mode 100644 arch/sparc/include/asm/pci_32.h
 delete mode 100644 arch/sparc/include/asm/pci_64.h
 create mode 100644 kernel/dma/dummy.c
 create mode 100644 kernel/dma/remap.c
