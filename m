Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE090C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 16:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1A221019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 16:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeLaQgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 11:36:55 -0500
Received: from 8bytes.org ([81.169.241.247]:55738 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727384AbeLaQgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 11:36:55 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id AC4FC259; Mon, 31 Dec 2018 17:36:53 +0100 (CET)
Date:   Mon, 31 Dec 2018 17:36:58 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Updates for Linux v4.21
Message-ID: <20181231163654.ckgwt2jbxq4g5hl4@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i7b35zq66qwjrtqq"
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i7b35zq66qwjrtqq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

there is a small merge conflict this time in arch/powerpc/kernel/iommu.c
with the tag I send you. I did a test-merge with your latest tree
locally to include my resolution in this email, but for some reason git
shows me a conflict in another file (drivers/iommu/amd_iommu.c) in the
resulting commit, which didn't show a conflict when I did the merge.

Anyway, the conflict exists because my patches modify code in the
powerpc iommu driver which is already removed in your tree.

With that in mind:

The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v4.21

for you to fetch changes up to 03ebe48e235f17d70f34890d34d8153b8a84c02e:

  Merge branches 'iommu/fixes', 'arm/renesas', 'arm/mediatek', 'arm/tegra', 'arm/omap', 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next (2018-12-20 10:05:20 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v4.21

Including (in no particular order):

	- Page table code for AMD IOMMU now supports large pages where
	  smaller page-sizes were mapped before. VFIO had to work around
	  that in the past and I included a patch to remove it (acked by
	  Alex Williamson)

	- Patches to unmodularize a couple of IOMMU drivers that would
	  never work as modules anyway.

	- Work to unify the the iommu-related pointers in
	  'struct device' into one pointer. This work is not finished
	  yet, but will probably be in the next cycle.

	- NUMA aware allocation in iommu-dma code

	- Support for r8a774a1 and r8a774c0 in the Renesas IOMMU driver

	- Scalable mode support for the Intel VT-d driver

	- PM runtime improvements for the ARM-SMMU driver

	- Support for the QCOM-SMMUv2 IOMMU hardware from Qualcom

	- Various smaller fixes and improvements

----------------------------------------------------------------
Arvind Yadav (1):
      iommu/mediatek: Constify iommu_ops

Fabrizio Castro (4):
      iommu/ipmmu-vmsa: Hook up R8A774A1 DT maching code
      dt-bindings: iommu: ipmmu-vmsa: Add r8a774a1 support
      dt-bindings: iommu: ipmmu-vmsa: Add r8a774c0 support
      iommu/ipmmu-vmsa: Hook up r8a774c0 DT matching code

Ganapatrao Kulkarni (1):
      iommu/dma: Use NUMA aware memory allocations in __iommu_dma_alloc_pages()

Hai Nguyen Pham (1):
      iommu/ipmmu-vmsa: Hook up r8a77990 DT matching code

Joerg Roedel (31):
      iommu/amd: Collect page-table pages in freelist
      iommu/amd: Introduce free_sub_pt() function
      iommu/amd: Ignore page-mode 7 in free_sub_pt()
      iommu/amd: Allow downgrading page-sizes in alloc_pte()
      iommu/amd: Restart loop if cmpxchg64 succeeded in alloc_pte()
      iommu/amd: Allow to upgrade page-size
      vfio/type1: Remove map_try_harder() code path
      iommu/amd: Use pr_fmt()
      iommu/amd: Fix line-break in error log reporting
      iommu/amd: Remove leading 0s in error log messages
      iommu: Introduce wrappers around dev->iommu_fwspec
      ACPI/IORT: Use helper functions to access dev->iommu_fwspec
      iommu/arm-smmu: Use helper functions to access dev->iommu_fwspec
      iommu/dma: Use helper functions to access dev->iommu_fwspec
      iommu/ipmmu-vmsa: Use helper functions to access dev->iommu_fwspec
      iommu/mediatek: Use helper functions to access dev->iommu_fwspec
      iommu/of: Use helper functions to access dev->iommu_fwspec
      iommu/qcom: Use helper functions to access dev->iommu_fwspec
      iommu/tegra: Use helper functions to access dev->iommu_fwspec
      driver core: Introduce device_iommu_mapped() function
      iommu/of: Use device_iommu_mapped()
      ACPI/IORT: Use device_iommu_mapped()
      powerpc/iommu: Use device_iommu_mapped()
      xhci: Use device_iommu_mapped()
      dmaengine: sh: rcar-dmac: Use device_iommu_mapped()
      iommu/sysfs: Rename iommu_release_device()
      iommu: Consolitate ->add/remove_device() calls
      iommu/of: Don't call iommu_ops->add_device directly
      ACPI/IORT: Don't call iommu_ops->add_device directly
      iommu: Check for iommu_ops == NULL in iommu_probe_device()
      Merge branches 'iommu/fixes', 'arm/renesas', 'arm/mediatek', 'arm/tegra', 'arm/omap', 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next

Lu Baolu (13):
      iommu/vtd: Cleanup dma_remapping.h header
      iommu/vt-d: Enumerate the scalable mode capability
      iommu/vt-d: Manage scalalble mode PASID tables
      iommu/vt-d: Move page table helpers into header
      iommu/vt-d: Add 256-bit invalidation descriptor support
      iommu/vt-d: Reserve a domain id for FL and PT modes
      iommu/vt-d: Add second level page table interface
      iommu/vt-d: Setup pasid entry for RID2PASID support
      iommu/vt-d: Pass pasid table to context mapping
      iommu/vt-d: Setup context and enable RID2PASID support
      iommu/vt-d: Add first level page table interface
      iommu/vt-d: Shared virtual address in scalable mode
      iommu/vt-d: Remove deferred invalidation

Paul Gortmaker (9):
      iommu: Audit and remove any unnecessary uses of module.h
      iommu/rockchip: Make it explicitly non-modular
      iommu/msm: Make it explicitly non-modular
      iommu/mediatek: Make it explicitly non-modular
      iommu/ipmmu-vmsa: Make it explicitly non-modular
      iommu/qcom: Make it explicitly non-modular
      iommu/tegra: Make it explicitly non-modular
      iommu/arm-smmu: Make arm-smmu explicitly non-modular
      iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular

Robin Murphy (2):
      iommu: Do physical merging in iommu_map_sg()
      iommu/arm-smmu-v3: Fix big-endian CMD_SYNC writes

Sohil Mehta (1):
      iommu/vt-d: Handle domain agaw being less than iommu agaw

Sricharan R (3):
      iommu/arm-smmu: Add pm_runtime/sleep ops
      iommu/arm-smmu: Invoke pm_runtime across the driver
      iommu/arm-smmu: Add the device_link between masters and smmu

Vivek Gautam (3):
      dt-bindings: arm-smmu: Add bindings for qcom,smmu-v2
      iommu/arm-smmu: Add support for qcom,smmu-v2 variant
      dt-bindings: arm-smmu: Add binding doc for Qcom smmu-500

Will Deacon (1):
      iommu/arm-smmu-v3: Use explicit mb() when moving cons pointer

Yangtao Li (3):
      iommu/omap: Remove DEBUG_SEQ_FOPS_RO()
      iommu/tegra: Change to use DEFINE_SHOW_ATTRIBUTE macro
      irq_remapping: Remove unused header files

Yong Wu (1):
      Revert "iommu/io-pgtable-arm: Check for v7s-incapable systems"

Yoshihiro Shimoda (2):
      iommu/ipmmu-vmsa: Modify ipmmu_slave_whitelist() to check SoC revisions
      iommu/ipmmu-vmsa: Add an array of slave devices whitelist

Yu Zhao (1):
      iommu/amd: Fix amd_iommu=force_isolation

Zhen Lei (1):
      iommu/arm-smmu-v3: Avoid memory corruption from Hisilicon MSI payloads

tom (1):
      iommu: Change tlb_range_add to iotlb_range_add and tlb_sync to iotlb_sync

 Documentation/admin-guide/kernel-parameters.txt    |  12 +-
 .../devicetree/bindings/iommu/arm,smmu.txt         |  43 ++
 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |   2 +
 arch/powerpc/kernel/eeh.c                          |   2 +-
 arch/powerpc/kernel/iommu.c                        |   6 +-
 arch/x86/kernel/tboot.c                            |   2 +-
 drivers/acpi/arm64/iort.c                          |  23 +-
 drivers/dma/sh/rcar-dmac.c                         |   2 +-
 drivers/gpu/drm/i915/i915_gem_execbuffer.c         |   2 +-
 drivers/gpu/drm/i915/intel_display.c               |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   2 +-
 drivers/iommu/amd_iommu.c                          | 275 ++++++++-----
 drivers/iommu/amd_iommu_init.c                     |  64 +--
 drivers/iommu/amd_iommu_types.h                    |   1 +
 drivers/iommu/amd_iommu_v2.c                       |   2 +
 drivers/iommu/arm-smmu-v3.c                        |  63 +--
 drivers/iommu/arm-smmu.c                           | 209 ++++++++--
 drivers/iommu/dma-iommu.c                          |  22 +-
 drivers/iommu/dmar.c                               |  91 +++--
 drivers/iommu/intel-iommu.c                        | 351 ++++++++--------
 drivers/iommu/intel-pasid.c                        | 449 ++++++++++++++++++++-
 drivers/iommu/intel-pasid.h                        |  40 +-
 drivers/iommu/intel-svm.c                          | 171 +++-----
 drivers/iommu/intel_irq_remapping.c                |   6 +-
 drivers/iommu/io-pgtable-arm-v7s.c                 |   4 -
 drivers/iommu/iommu-sysfs.c                        |  14 +-
 drivers/iommu/iommu.c                              | 113 +++---
 drivers/iommu/ipmmu-vmsa.c                         |  88 ++--
 drivers/iommu/irq_remapping.c                      |   1 -
 drivers/iommu/msm_iommu.c                          |  13 +-
 drivers/iommu/mtk_iommu.c                          |  25 +-
 drivers/iommu/mtk_iommu_v1.c                       |  47 +--
 drivers/iommu/of_iommu.c                           |  16 +-
 drivers/iommu/omap-iommu-debug.c                   |  25 +-
 drivers/iommu/qcom_iommu.c                         |  34 +-
 drivers/iommu/rockchip-iommu.c                     |  13 +-
 drivers/iommu/tegra-gart.c                         |  37 +-
 drivers/iommu/tegra-smmu.c                         |  26 +-
 drivers/misc/mic/scif/scif_rma.c                   |   2 +-
 drivers/misc/mic/scif/scif_rma.h                   |   2 +-
 drivers/usb/host/xhci.c                            |   2 +-
 drivers/vfio/vfio_iommu_type1.c                    |  33 +-
 include/linux/device.h                             |  10 +
 include/linux/dma_remapping.h                      |  58 ---
 include/linux/intel-iommu.h                        | 108 ++++-
 include/linux/iommu.h                              |  18 +-
 46 files changed, 1613 insertions(+), 918 deletions(-)
 delete mode 100644 include/linux/dma_remapping.h

Please pull.

Thanks,

	Joerg

--i7b35zq66qwjrtqq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJcKkWmAAoJECvwRC2XARrjEIAP/0ox/HqI/wDFoy3QeovM3jCo
BM/3uSQ1Y2QNkAFrptM72KV5rZdJ36CrGk1OUQN3qGKaKpyAVlmjP6rqRdiVjDzK
0MtOI3juFiAefbParr3R2AK4avGxrkSBeRmWYFgYNPbuGEvKdmyLrLocBAONft5O
HQWfpVWZHd+LXNoXZh0WChM69TLg47Cn1seav1F4UYiQADI1L4Y5zdruf7aF1PrB
ePKdEvsdbOnslp0dGQ93OfSeHA1iHCtpp9m4gDutqcST+lm41exCqK3FFvfTgrxR
hM4dyJxkHXQSbe4Uem/auhPOydoXTeYmKGTvoXYQ+Ckf+DCNPjvFr70mS8gK8beN
HMMheyF3dhUJx1rsvfl6mETrsK106qXjFmY4GFAPw9sgQ9LhwzgtvJ4FwAU4rP8D
Rj+y+Tjvi+HGA99o9HJCkN7Gi9khKzjHf2t4LqIu9Eoo2qbASx9LGRGC8gl/8lfa
NYAz+EL7yD7BWrF0PdwFT+MbeOiSPung4WXgNHJTR7v2CEaQlAohqzfoTukdXxLF
HlBuo2OkvSdrolh5/4OjsRw2U+4WO5ir+2sixHPI/iOxWeHa2dO5mY5jZ9JTJW4p
OnHCBvB+8j9G9ybwEbwCZmmvUH4mWSr1bFawZqieNGgiYYsaguEI405wjFZfQ3Ds
oeu4ovtrwVz6sA/LhIvn
=iGeQ
-----END PGP SIGNATURE-----

--i7b35zq66qwjrtqq--
