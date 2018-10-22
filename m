Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B045C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1A1205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PxhmVXt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1A1205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeJVQZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:25:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbeJVQZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XZwlipywSvSqiUraBSlNOp437bMvWe5EhHYBhoHuxuU=; b=PxhmVXt1ubJzGjUwz1aVY3hRe3
        X4b9Md+ILekqUnUDI955Z0ZZdVFVmX7wX7A/W5lUVDi81Gtj3LWoQqekoRwsD31zHr5U794UxKYJe
        rKBiQEMbl/BzMCLEKqpBpJmBUbpJHED6GboSn0mFFhx/BQcGLD5/dfCoon5oL47Zp5uK/yBBOhFnE
        h9BRirMGhdYh/C2HZR7w3ksR9j6HoWH3nQx+tVZMf7KKDXUk+qU/zSiVLac4QOBoLTyHc+e6TCnyO
        rXEhU1f7jCjv14tA6361wJrFu5j86/dUWr879rW71luRoevmk+F2H2NnBzLzIDz83ZpX/thc1ZAPw
        3ixyUAYg==;
Received: from [109.144.216.89] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEVFQ-00057r-5Q; Mon, 22 Oct 2018 08:07:36 +0000
Date:   Mon, 22 Oct 2018 10:07:33 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] first round of dma mapping updates for 4.20
Message-ID: <20181022080733.GA1960@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, below is the first round of dma-mapping updates for 4.20.

There will be a second PR as some big changes were only applied just
before the end of the merge window, and I want to give them a few
more days in linux-next.

Note that "dma-mapping: add the missing ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
declaration" was applied here and later cherry picked into 4.19, so it
will show up as a duplicate commit.  That also causes an easy to solve
merge conflict in kernel/dma/Kconfig (just make sure there are no
duplicate symbols).

There also are some Kconfig conflicts in linux-next for the architecture
Kconfig files, but those are only due to non-related symbols close to
each other, and trivial to resolve.

The following changes since commit d7b686ebf704e3d91925a535a0905ba6be23757c:

  Merge branch 'i2c/for-current' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux (2018-09-07 17:30:40 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.20

for you to fetch changes up to b9fd04262a8abc366f40a9e97598e94591352c26:

  dma-direct: respect DMA_ATTR_NO_WARN (2018-10-09 15:08:46 +0200)

----------------------------------------------------------------
First batch of dma-mapping changes for 4.20:

 - mostly more consolidation of the direct mapping code, including
   converting over hexagon, and merging the coherent and non-coherent
   code into a single dma_map_ops instance (me)
 - cleanups for the dma_configure/dma_unconfigure callchains (me)
 - better handling of dma_masks in odd setups (me, Alexander Duyck)
 - better debugging of passing vmalloc address to the DMA API
   (Stephen Boyd)
 - CMA command line parsing fix (He Zhe)

----------------------------------------------------------------
Alexander Duyck (1):
      dma-direct: fix return value of dma_direct_supported

Christoph Hellwig (24):
      hexagon: remove the sync_single_for_cpu DMA operation
      hexagon: implement the sync_sg_for_device DMA operation
      hexagon: use generic dma_noncoherent_ops
      arm-nommu: don't define arch_teardown_dma_ops
      dma-mapping: remove dma_configure
      dma-mapping: remove dma_deconfigure
      dma-mapping: clear dev->dma_ops in arch_teardown_dma_ops
      dma-mapping: add the missing ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration
      MIPS: don't select DMA_MAYBE_COHERENT from DMA_PERDEV_COHERENT
      dma-mapping: move the dma_coherent flag to struct device
      dma-mapping: merge direct and noncoherent ops
      dma-mapping: consolidate the dma mmap implementations
      dma-mapping: support non-coherent devices in dma_common_get_sgtable
      Revert "dma-mapping: clear dev->dma_ops in arch_teardown_dma_ops"
      unicore32: remove swiotlb support
      dma-mapping: make the get_required_mask method available unconditionally
      dma-direct: add an explicit dma_direct_get_required_mask
      dma-direct: refine dma_direct_alloc zone selection
      dma-direct: implement complete bus_dma_mask handling
      dma-direct: always allow dma mask <= physiscal memory size
      dma-mapping: move dma_default_get_required_mask under ifdef
      dma-direct: document the zone selection logic
      dma-mapping: translate __GFP_NOFAIL to DMA_ATTR_NO_WARN
      dma-direct: respect DMA_ATTR_NO_WARN

He Zhe (1):
      dma-mapping: fix panic caused by passing empty cma command line argument

Stephen Boyd (1):
      dma-debug: Check for drivers mapping invalid addresses in dma_map_single()

 arch/arc/Kconfig                         |   4 +-
 arch/arc/mm/dma.c                        |  41 ++----
 arch/arm/include/asm/dma-mapping.h       |   2 +
 arch/arm/mm/dma-mapping-nommu.c          |  11 +-
 arch/c6x/Kconfig                         |   2 +-
 arch/hexagon/Kconfig                     |   2 +
 arch/hexagon/include/asm/Kbuild          |   1 +
 arch/hexagon/include/asm/dma-mapping.h   |  40 ------
 arch/hexagon/kernel/dma.c                | 143 ++------------------
 arch/ia64/include/asm/dma-mapping.h      |   2 -
 arch/ia64/include/asm/machvec.h          |   7 -
 arch/ia64/include/asm/machvec_init.h     |   1 -
 arch/ia64/include/asm/machvec_sn2.h      |   2 -
 arch/ia64/pci/pci.c                      |  26 ----
 arch/ia64/sn/pci/pci_dma.c               |   4 +-
 arch/m68k/Kconfig                        |   2 +-
 arch/microblaze/Kconfig                  |   4 +-
 arch/microblaze/include/asm/pgtable.h    |   2 -
 arch/microblaze/kernel/dma.c             |  22 ---
 arch/microblaze/mm/consistent.c          |   3 +-
 arch/mips/Kconfig                        |   7 +-
 arch/mips/include/asm/Kbuild             |   1 +
 arch/mips/include/asm/device.h           |  19 ---
 arch/mips/include/asm/dma-coherence.h    |   6 +
 arch/mips/include/asm/dma-mapping.h      |   4 +-
 arch/mips/jazz/jazzdma.c                 |   7 +-
 arch/mips/kernel/setup.c                 |   2 +-
 arch/mips/mm/c-r4k.c                     |  17 ++-
 arch/mips/mm/dma-noncoherent.c           |  79 +++--------
 arch/nds32/Kconfig                       |   2 +-
 arch/nios2/Kconfig                       |   2 +-
 arch/openrisc/Kconfig                    |   2 +-
 arch/parisc/Kconfig                      |   2 +-
 arch/parisc/kernel/setup.c               |   2 +-
 arch/sh/Kconfig                          |   3 +-
 arch/sparc/Kconfig                       |   2 +-
 arch/sparc/include/asm/dma-mapping.h     |   4 +-
 arch/unicore32/Kconfig                   |   2 +-
 arch/unicore32/include/asm/Kbuild        |   1 +
 arch/unicore32/include/asm/dma-mapping.h |  22 ---
 arch/unicore32/mm/init.c                 |   3 -
 arch/x86/kernel/amd_gart_64.c            |   6 +-
 arch/xtensa/Kconfig                      |   2 +-
 drivers/acpi/arm64/iort.c                |   2 +-
 drivers/acpi/scan.c                      |  10 --
 drivers/base/dd.c                        |  12 +-
 drivers/base/platform.c                  |  11 +-
 drivers/of/device.c                      |  12 --
 drivers/pci/controller/vmd.c             |   4 -
 drivers/xen/swiotlb-xen.c                |   4 +-
 include/acpi/acpi_bus.h                  |   1 -
 include/asm-generic/dma-mapping.h        |   9 --
 include/linux/acpi.h                     |   2 -
 include/linux/device.h                   |   7 +
 include/linux/dma-debug.h                |   8 ++
 include/linux/dma-direct.h               |   8 +-
 include/linux/dma-mapping.h              |  42 +++---
 include/linux/dma-noncoherent.h          |  27 +++-
 include/linux/of_device.h                |   3 -
 kernel/dma/Kconfig                       |  19 +--
 kernel/dma/Makefile                      |   1 -
 kernel/dma/contiguous.c                  |   6 +-
 kernel/dma/debug.c                       |  16 +++
 kernel/dma/direct.c                      | 222 +++++++++++++++++++++++++------
 kernel/dma/mapping.c                     |  71 +++++-----
 kernel/dma/noncoherent.c                 | 106 ---------------
 66 files changed, 423 insertions(+), 698 deletions(-)
 delete mode 100644 arch/hexagon/include/asm/dma-mapping.h
 delete mode 100644 arch/mips/include/asm/device.h
 delete mode 100644 arch/unicore32/include/asm/dma-mapping.h
 delete mode 100644 kernel/dma/noncoherent.c
