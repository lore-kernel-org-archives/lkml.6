Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F5BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9ED20811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733288AbeLTJi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:38:26 -0500
Received: from ozlabs.org ([203.11.71.1]:33445 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729937AbeLTJiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:38:24 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43L6Bh3bjHz9s8r;
        Thu, 20 Dec 2018 20:38:20 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        Alistair Popple <alistair@popple.id.au>,
        Reza Arbab <arbab@linux.ibm.com>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Piotr Jaroszynski <pjaroszynski@nvidia.com>,
        Leonardo Augusto =?utf-8?Q?Guimar?= =?utf-8?Q?=C3=A3es?=
         Garcia <lagarcia@br.ibm.com>,
        Jose Ricardo Ziviani <joserz@linux.ibm.com>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH kernel v7 00/20] powerpc/powernv/npu, vfio: NVIDIA V100 + P9 passthrough
In-Reply-To: <20181220082350.58113-1-aik@ozlabs.ru>
References: <20181220082350.58113-1-aik@ozlabs.ru>
Date:   Thu, 20 Dec 2018 20:38:20 +1100
Message-ID: <87h8f8r10z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> My bad, I was not cc-ing everyone but now with v7 I am, sorry about that.

I've already applied v6, I'll assume this is unchanged from that unless
you tell me otherwise.

cheers

> This is for passing through NVIDIA V100 GPUs on POWER9 systems.
> 20/20 has the details of hardware setup.
>
> This implements support for NVIDIA V100 GPU with coherent memory and
> NPU/ATS support available in the POWER9 CPU. The aim is to support
> unmodified vendor driver in the guest.
>
> This is pushed to (both guest and host kernels):
> https://github.com/aik/linux/tree/nv2
>
> Matching qemu is pushed to github:
> https://github.com/aik/qemu/tree/nv2
>
> Skiboot bits are here:
> https://github.com/aik/skiboot/tree/nv2
>
> The individual patches have changelogs. v7 fixes compile warning
> and updates a VFIO capability comment in 20/20.
>
> Please comment. Thanks.
>
>
>
> Alexey Kardashevskiy (20):
>   powerpc/ioda/npu: Call skiboot's hot reset hook when disabling NPU2
>   powerpc/mm/iommu/vfio_spapr_tce: Change mm_iommu_get to reference a
>     region
>   powerpc/vfio/iommu/kvm: Do not pin device memory
>   powerpc/powernv: Move npu struct from pnv_phb to pci_controller
>   powerpc/powernv/npu: Move OPAL calls away from context manipulation
>   powerpc/pseries/iommu: Use memory@ nodes in max RAM address
>     calculation
>   powerpc/pseries/npu: Enable platform support
>   powerpc/pseries: Remove IOMMU API support for non-LPAR systems
>   powerpc/powernv/pseries: Rework device adding to IOMMU groups
>   powerpc/iommu_api: Move IOMMU groups setup to a single place
>   powerpc/powernv: Reference iommu_table while it is linked to a group
>   powerpc/powernv/npu: Move single TVE handling to NPU PE
>   powerpc/powernv/npu: Convert NPU IOMMU helpers to
>     iommu_table_group_ops
>   powerpc/powernv/npu: Add compound IOMMU groups
>   powerpc/powernv/npu: Add release_ownership hook
>   powerpc/powernv/npu: Check mmio_atsd array bounds when populating
>   powerpc/powernv/npu: Fault user page into the hypervisor's pagetable
>   vfio_pci: Allow mapping extra regions
>   vfio_pci: Allow regions to add own capabilities
>   vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver
>
>  drivers/vfio/pci/Makefile                     |   1 +
>  arch/powerpc/include/asm/iommu.h              |  17 +-
>  arch/powerpc/include/asm/mmu_context.h        |  15 +-
>  arch/powerpc/include/asm/pci-bridge.h         |   1 +
>  arch/powerpc/include/asm/pci.h                |   4 +
>  arch/powerpc/platforms/powernv/pci.h          |  30 +-
>  drivers/vfio/pci/trace.h                      | 102 ++++
>  drivers/vfio/pci/vfio_pci_private.h           |  20 +
>  include/uapi/linux/vfio.h                     |  37 ++
>  arch/powerpc/kernel/iommu.c                   |  69 +--
>  arch/powerpc/kvm/book3s_64_vio.c              |  18 +-
>  arch/powerpc/mm/mmu_context_iommu.c           | 110 +++-
>  arch/powerpc/platforms/powernv/npu-dma.c      | 549 +++++++++++++++---
>  arch/powerpc/platforms/powernv/pci-ioda-tce.c |   3 +-
>  arch/powerpc/platforms/powernv/pci-ioda.c     | 237 ++++----
>  arch/powerpc/platforms/powernv/pci.c          |  43 +-
>  arch/powerpc/platforms/pseries/iommu.c        |  88 ++-
>  arch/powerpc/platforms/pseries/pci.c          |  22 +
>  drivers/vfio/pci/vfio_pci.c                   |  42 +-
>  drivers/vfio/pci/vfio_pci_nvlink2.c           | 482 +++++++++++++++
>  drivers/vfio/vfio_iommu_spapr_tce.c           |  64 +-
>  drivers/vfio/pci/Kconfig                      |   6 +
>  22 files changed, 1569 insertions(+), 391 deletions(-)
>  create mode 100644 drivers/vfio/pci/trace.h
>  create mode 100644 drivers/vfio/pci/vfio_pci_nvlink2.c
>
> -- 
> 2.17.1
