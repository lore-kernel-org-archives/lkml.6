Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754451AbeDBKeI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:34:08 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36385 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754266AbeDBKeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 06:34:06 -0400
X-Google-Smtp-Source: AIpwx499826GLcvrXZFmyaNll5Oj94mA29wOs4+GSjvgbOIWebEAVr/00i6WM/YvlvB5qTXKtiYPrg==
Date: Mon, 2 Apr 2018 12:34:02 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] DMA updates for v4.17
Message-ID: <20180402103402.yucim64oll6a352r@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-dma-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-dma-for-linus

   # HEAD: e89f5b37015309a8bdf0b21d08007580b92f92a4 dma-mapping: Don't clear GFP_ZERO in dma_alloc_attrs

NOTE: this tree depends on the x86/mm tree - if you have not pulled that tree
      then please disregard this pull request.

This tree, by Christoph Hellwig, switches over the x86 architecture to the generic 
dma-direct and swiotlb code, and also unifies more of the dma-direct code between 
architectures. The now unused x86-only primitives are removed.

 Thanks,

	Ingo

------------------>
Christoph Hellwig (15):
      x86/dma: Remove dma_alloc_coherent_mask()
      x86/dma: Use DMA-direct (CONFIG_DMA_DIRECT_OPS=y)
      x86/dma: Use generic swiotlb_ops
      x86/dma/amd_gart: Look at dev->coherent_dma_mask instead of GFP_DMA
      x86/dma/amd_gart: Use dma_direct_{alloc,free}()
      iommu/amd_iommu: Use CONFIG_DMA_DIRECT_OPS=y and dma_direct_{alloc,free}()
      iommu/intel-iommu: Enable CONFIG_DMA_DIRECT_OPS=y and clean up intel_{alloc,free}_coherent()
      x86/dma: Remove dma_alloc_coherent_gfp_flags()
      set_memory.h: Provide set_memory_{en,de}crypted() stubs
      dma/swiotlb: Remove swiotlb_set_mem_attributes()
      dma/direct: Handle the memory encryption bit in common code
      dma/direct: Handle force decryption for DMA coherent buffers in common code
      dma/swiotlb: Remove swiotlb_{alloc,free}_coherent()
      swiotlb: Make swiotlb_{alloc,free}_buffer depend on CONFIG_DMA_DIRECT_OPS
      dma-mapping: Don't clear GFP_ZERO in dma_alloc_attrs

Ingo Molnar (2):
      Merge branch 'x86/mm' into x86/dma, to pick up dependencies
      Merge branch 'linus' into x86/dma, to resolve a conflict with upstream

 arch/arm/include/asm/dma-direct.h                        |  4 ++--
 arch/mips/cavium-octeon/dma-octeon.c                     | 10 +++++-----
 arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h |  4 ++--
 arch/mips/include/asm/mach-loongson64/dma-coherence.h    | 10 +++++-----
 arch/mips/loongson64/common/dma-swiotlb.c                |  4 ++--
 arch/powerpc/include/asm/dma-direct.h                    |  4 ++--
 arch/x86/Kconfig                                         |  3 ++-
 arch/x86/include/asm/device.h                            |  3 +++
 arch/x86/include/asm/dma-direct.h                        | 25 ++-----------------------
 arch/x86/include/asm/dma-mapping.h                       | 33 ---------------------------------
 arch/x86/include/asm/iommu.h                             |  3 ---
 arch/x86/include/asm/mem_encrypt.h                       |  2 --
 arch/x86/include/asm/swiotlb.h                           |  8 --------
 arch/x86/kernel/Makefile                                 |  2 +-
 arch/x86/kernel/amd_gart_64.c                            | 41 ++++++++++++++++-------------------------
 arch/x86/kernel/pci-calgary_64.c                         |  5 ++---
 arch/x86/kernel/pci-dma.c                                | 70 +---------------------------------------------------------------------
 arch/x86/kernel/pci-swiotlb.c                            | 48 +-----------------------------------------------
 arch/x86/mm/mem_encrypt.c                                | 90 +++---------------------------------------------------------------------------------------
 arch/x86/pci/sta2x11-fixup.c                             | 52 ++++++++--------------------------------------------
 drivers/iommu/Kconfig                                    |  2 ++
 drivers/iommu/amd_iommu.c                                | 75 +++++++++++++++++++++++++--------------------------------------------------
 drivers/iommu/intel-iommu.c                              | 65 ++++++++++++++++++-----------------------------------------------
 drivers/xen/swiotlb-xen.c                                | 16 +---------------
 include/linux/dma-direct.h                               | 21 +++++++++++++++++++--
 include/linux/dma-mapping.h                              |  8 ++------
 include/linux/set_memory.h                               | 12 ++++++++++++
 include/linux/swiotlb.h                                  |  8 --------
 lib/dma-direct.c                                         | 35 +++++++++++++++++++++++++++++------
 lib/swiotlb.c                                            | 77 +++++++++++++++++------------------------------------------------------------
 30 files changed, 182 insertions(+), 558 deletions(-)
