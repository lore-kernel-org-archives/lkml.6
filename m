Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbeFDGOA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:14:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbeFDGN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:13:59 -0400
Date: Mon, 4 Jun 2018 08:13:42 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping updates for Linux 4.18
Message-ID: <20180604061341.v4kdp6nlqd7x7cxx@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull dma dma-mapping update below.  Note that this includes a lot
of changes to the architecture Kconfig files, which have created quite a
few trivial conflicts in linux-next.  In all the cases there is no actual
interaction, just separate additions/removal that are right next to each
other.  For nds32 one of these conflicts already exists for 4.17, so
you'll see it straight away.

The following changes since commit 892a0be43edd63e1cd228af3453a064e9e94f08e:

  swiotlb: fix inversed DMA_ATTR_NO_WARN test (2018-05-02 14:48:55 +0200)

are available in the git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.18

for you to fetch changes up to 2550bbfd495227945e17ed1fa1c05bce4753b86b:

  dma-direct: don't crash on device without dma_mask (2018-05-31 18:35:36 +0200)

----------------------------------------------------------------
dma-mapping updates for 4.18:

 - replaceme the force_dma flag with a dma_configure bus method.
   (Nipun Gupta, although one patch is іncorrectly attributed to me
    due to a git rebase bug)
 - use GFP_DMA32 more agressively in dma-direct. (Takashi Iwai)
 - remove PCI_DMA_BUS_IS_PHYS and rely on the dma-mapping API to do the
   right thing for bounce buffering.
 - move dma-debug initialization to common code, and apply a few cleanups
   to the dma-debug code.
 - cleanup the Kconfig mess around swiotlb selection
 - swiotlb comment fixup (Yisheng Xie)
 - a trivial swiotlb fix. (Dan Carpenter)
 - support swiotlb on RISC-V. (based on a patch from Palmer Dabbelt)
 - add a new generic dma-noncoherent dma_map_ops implementation and use
   it for arc, c6x and nds32.
 - improve scatterlist validity checking in dma-debug. (Robin Murphy)
 - add a struct device quirk to limit the dma-mask to 32-bit due to
   bridge/system issues, and switch x86 to use it instead of a local
   hack for VIA bridges.
 - handle devices without a dma_mask more gracefully in the dma-direct
   code.

----------------------------------------------------------------
Christoph Hellwig (42):
      drivers: remove force dma flag from buses
      scsi: reduce use of block bounce buffers
      ide: kill ide_toggle_bounce
      ide: remove the PCI_DMA_BUS_IS_PHYS check
      net: remove the PCI_DMA_BUS_IS_PHYS check in illegal_highdma
      PCI: remove PCI_DMA_BUS_IS_PHYS
      dma-debug: move initialization to common code
      dma-debug: simplify counting of preallocated requests
      dma-debug: unexport dma_debug_resize_entries and debug_dma_dump_mappings
      dma-debug: remove CONFIG_HAVE_DMA_API_DEBUG
      iommu-common: move to arch/sparc
      iommu-helper: unexport iommu_area_alloc
      iommu-helper: mark iommu_is_span_boundary as inline
      iommu-helper: move the IOMMU_HELPER config symbol to lib/
      scatterlist: move the NEED_SG_DMA_LENGTH config symbol to lib/Kconfig
      dma-mapping: move the NEED_DMA_MAP_STATE config symbol to lib/Kconfig
      arch: remove the ARCH_PHYS_ADDR_T_64BIT config symbol
      arch: define the ARCH_DMA_ADDR_T_64BIT config symbol in lib/Kconfig
      PCI: remove CONFIG_PCI_BUS_ADDR_T_64BIT
      arm: don't build swiotlb by default
      mips,unicore32: swiotlb doesn't need sg->dma_length
      swiotlb: move the SWIOTLB config symbol to lib/Kconfig
      swiotlb: remove the CONFIG_DMA_DIRECT_OPS ifdefs
      riscv: simplify Kconfig magic for 32-bit vs 64-bit kernels
      riscv: only enable ZONE_DMA32 for 64-bit
      riscv: add swiotlb support
      dma-mapping: simplify Kconfig dependencies
      dma-mapping: provide a generic dma-noncoherent implementation
      arc: simplify arc_dma_sync_single_for_{cpu,device}
      arc: fix arc_dma_sync_sg_for_{cpu,device}
      arc: fix arc_dma_{map,unmap}_page
      arc: use generic dma_noncoherent_ops
      c6x: use generic dma_noncoherent_ops
      core, dma-direct: add a flag 32-bit dma limits
      Documentation/x86: remove a stray reference to pci-nommu.c
      x86/pci-dma: remove the experimental forcesac boot option
      x86/pci-dma: remove the explicit nodac and allowdac option
      x86/pci-dma: switch the VIA 32-bit DMA quirk to use the struct device flag
      nds32: consolidate DMA cache maintainance routines
      nds32: implement the unmap_sg DMA operation
      nds32: use generic dma_noncoherent_ops
      dma-direct: don't crash on device without dma_mask

Dan Carpenter (1):
      swiotlb: remove an unecessary NULL check

Huaisheng Ye (1):
      dma-mapping: remove unused gfp_t parameter to arch_dma_alloc_attrs

Nipun Gupta (1):
      dma-mapping: move dma configuration to bus infrastructure

Robin Murphy (1):
      dma-debug: check scatterlist segments

Takashi Iwai (1):
      dma-direct: try reallocation with GFP_DMA32 if possible

Yisheng Xie (1):
      swiotlb: update comments to refer to physical instead of virtual addresses

 Documentation/admin-guide/kernel-parameters.txt    |   1 -
 .../features/io/dma-api-debug/arch-support.txt     |  31 ----
 Documentation/x86/x86_64/boot-options.txt          |  13 +-
 MAINTAINERS                                        |   2 +
 arch/Kconfig                                       |   3 -
 arch/alpha/Kconfig                                 |  14 +-
 arch/alpha/include/asm/pci.h                       |   5 -
 arch/arc/Kconfig                                   |  11 +-
 arch/arc/include/asm/Kbuild                        |   1 +
 arch/arc/include/asm/dma-mapping.h                 |  21 ---
 arch/arc/include/asm/pci.h                         |   6 -
 arch/arc/mm/dma.c                                  | 162 ++---------------
 arch/arm/Kconfig                                   |  15 +-
 arch/arm/include/asm/pci.h                         |   7 -
 arch/arm/kernel/setup.c                            |   2 +-
 arch/arm/mach-axxia/Kconfig                        |   1 -
 arch/arm/mach-bcm/Kconfig                          |   1 -
 arch/arm/mach-exynos/Kconfig                       |   1 -
 arch/arm/mach-highbank/Kconfig                     |   1 -
 arch/arm/mach-rockchip/Kconfig                     |   1 -
 arch/arm/mach-shmobile/Kconfig                     |   1 -
 arch/arm/mach-tegra/Kconfig                        |   1 -
 arch/arm/mm/Kconfig                                |   7 +-
 arch/arm/mm/dma-mapping-nommu.c                    |   9 -
 arch/arm/mm/dma-mapping.c                          |   9 -
 arch/arm64/Kconfig                                 |  22 +--
 arch/arm64/include/asm/pci.h                       |   5 -
 arch/arm64/mm/dma-mapping.c                        |  10 --
 arch/c6x/Kconfig                                   |   4 +-
 arch/c6x/include/asm/Kbuild                        |   1 +
 arch/c6x/include/asm/dma-mapping.h                 |  28 ---
 arch/c6x/include/asm/setup.h                       |   2 +
 arch/c6x/kernel/Makefile                           |   2 +-
 arch/c6x/kernel/dma.c                              | 149 ----------------
 arch/c6x/mm/dma-coherent.c                         |  40 ++++-
 arch/h8300/include/asm/pci.h                       |   2 -
 arch/hexagon/Kconfig                               |   4 +-
 arch/hexagon/kernel/dma.c                          |   1 -
 arch/ia64/Kconfig                                  |  23 +--
 arch/ia64/hp/common/sba_iommu.c                    |   3 -
 arch/ia64/include/asm/pci.h                        |  17 --
 arch/ia64/kernel/dma-mapping.c                     |  10 --
 arch/ia64/kernel/setup.c                           |  12 --
 arch/ia64/sn/kernel/io_common.c                    |   5 -
 arch/m68k/include/asm/pci.h                        |   6 -
 arch/microblaze/Kconfig                            |   1 -
 arch/microblaze/include/asm/pci.h                  |   6 -
 arch/microblaze/kernel/dma.c                       |  11 --
 arch/mips/Kconfig                                  |  22 +--
 arch/mips/cavium-octeon/Kconfig                    |  12 --
 arch/mips/include/asm/pci.h                        |   7 -
 arch/mips/loongson64/Kconfig                       |  15 --
 arch/mips/mm/dma-default.c                         |  10 --
 arch/mips/netlogic/Kconfig                         |   6 -
 arch/nds32/Kconfig                                 |   3 +
 arch/nds32/include/asm/Kbuild                      |   1 +
 arch/nds32/include/asm/dma-mapping.h               |  14 --
 arch/nds32/kernel/dma.c                            | 196 ++++++---------------
 arch/openrisc/kernel/dma.c                         |  11 --
 arch/parisc/Kconfig                                |   8 +-
 arch/parisc/include/asm/pci.h                      |  23 ---
 arch/parisc/kernel/setup.c                         |   5 -
 arch/powerpc/Kconfig                               |  25 +--
 arch/powerpc/include/asm/pci.h                     |  18 --
 arch/powerpc/kernel/dma.c                          |   3 -
 arch/powerpc/platforms/Kconfig.cputype             |   1 +
 arch/riscv/Kconfig                                 |  44 ++---
 arch/riscv/include/asm/dma-mapping.h               |  15 ++
 arch/riscv/include/asm/pci.h                       |   3 -
 arch/riscv/kernel/setup.c                          |   2 +
 arch/s390/Kconfig                                  |  17 +-
 arch/s390/include/asm/pci.h                        |   2 -
 arch/s390/pci/pci_dma.c                            |  11 --
 arch/sh/Kconfig                                    |  10 +-
 arch/sh/include/asm/pci.h                          |   6 -
 arch/sh/kernel/dma-nommu.c                         |   1 -
 arch/sh/mm/consistent.c                            |   9 -
 arch/sparc/Kconfig                                 |  18 +-
 .../sparc/include/asm}/iommu-common.h              |   0
 arch/sparc/include/asm/iommu_64.h                  |   2 +-
 arch/sparc/include/asm/pci_32.h                    |   4 -
 arch/sparc/include/asm/pci_64.h                    |   6 -
 arch/sparc/kernel/Makefile                         |   4 +-
 arch/sparc/kernel/dma.c                            |  13 --
 {lib => arch/sparc/kernel}/iommu-common.c          |   5 +-
 arch/sparc/kernel/iommu.c                          |   2 +-
 arch/sparc/kernel/ldc.c                            |   2 +-
 arch/sparc/kernel/pci_sun4v.c                      |   2 +-
 arch/unicore32/Kconfig                             |   5 +-
 arch/unicore32/mm/Kconfig                          |  11 --
 arch/x86/Kconfig                                   |  36 +---
 arch/x86/include/asm/dma-mapping.h                 |   5 +-
 arch/x86/include/asm/pci.h                         |   3 -
 arch/x86/kernel/pci-dma.c                          |  58 ++----
 arch/xtensa/Kconfig                                |   1 -
 arch/xtensa/include/asm/pci.h                      |   2 -
 arch/xtensa/kernel/pci-dma.c                       |   9 -
 drivers/amba/bus.c                                 |   5 +-
 drivers/base/dma-mapping.c                         |  31 +---
 drivers/base/platform.c                            |  18 +-
 drivers/bcma/main.c                                |   2 +-
 drivers/dma/qcom/hidma_mgmt.c                      |   2 +-
 drivers/gpu/host1x/bus.c                           |   9 +-
 drivers/ide/ide-dma.c                              |   2 -
 drivers/ide/ide-lib.c                              |  26 ---
 drivers/ide/ide-probe.c                            |   6 +-
 drivers/iommu/Kconfig                              |   1 +
 drivers/net/ethernet/sfc/efx.c                     |   5 +-
 drivers/net/ethernet/sfc/falcon/efx.c              |   5 +-
 drivers/of/device.c                                |   6 +-
 drivers/of/of_reserved_mem.c                       |   2 +-
 drivers/parisc/Kconfig                             |   5 -
 drivers/parisc/ccio-dma.c                          |   2 -
 drivers/parisc/sba_iommu.c                         |   2 -
 drivers/pci/Kconfig                                |   4 -
 drivers/pci/bus.c                                  |   4 +-
 drivers/pci/pci-driver.c                           |  33 +++-
 drivers/scsi/scsi_lib.c                            |  24 +--
 include/asm-generic/dma-mapping.h                  |   9 +
 include/asm-generic/pci.h                          |   8 -
 include/linux/device.h                             |  11 +-
 include/linux/dma-debug.h                          |   6 -
 include/linux/dma-direct.h                         |   7 +-
 include/linux/dma-mapping.h                        |  19 +-
 include/linux/dma-noncoherent.h                    |  47 +++++
 include/linux/ide.h                                |   2 -
 include/linux/iommu-helper.h                       |  13 +-
 include/linux/of_device.h                          |   8 +-
 include/linux/pci.h                                |   2 +-
 include/linux/platform_device.h                    |   2 +
 lib/Kconfig                                        |  43 ++++-
 lib/Kconfig.debug                                  |  19 +-
 lib/Makefile                                       |   3 +-
 lib/dma-debug.c                                    |  65 ++++---
 lib/dma-direct.c                                   |  29 ++-
 lib/dma-noncoherent.c                              | 102 +++++++++++
 lib/iommu-helper.c                                 |  14 +-
 lib/swiotlb.c                                      |  11 +-
 mm/Kconfig                                         |   2 +-
 net/core/dev.c                                     |  20 +--
 tools/virtio/linux/dma-mapping.h                   |   2 -
 141 files changed, 624 insertions(+), 1392 deletions(-)
 delete mode 100644 Documentation/features/io/dma-api-debug/arch-support.txt
 delete mode 100644 arch/arc/include/asm/dma-mapping.h
 delete mode 100644 arch/c6x/include/asm/dma-mapping.h
 delete mode 100644 arch/c6x/kernel/dma.c
 delete mode 100644 arch/nds32/include/asm/dma-mapping.h
 create mode 100644 arch/riscv/include/asm/dma-mapping.h
 rename {include/linux => arch/sparc/include/asm}/iommu-common.h (100%)
 delete mode 100644 arch/sparc/kernel/dma.c
 rename {lib => arch/sparc/kernel}/iommu-common.c (98%)
 create mode 100644 include/linux/dma-noncoherent.h
 create mode 100644 lib/dma-noncoherent.c
