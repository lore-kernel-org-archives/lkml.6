Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4524FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E342320870
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jrnBlj2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E342320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeJKHwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:52:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34285 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeJKHwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:52:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id f18-v6so3313411plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=yxmcm75FT6AziqQ/isNaMpYdx5uBTwn2kdGoQhrikVc=;
        b=jrnBlj2MlSt/DoYTDGDQTjlZ55la4dieSxJXR73XY7oleT2emA4P6HWRdqLSdAlVHP
         qgdE6En1Kf+APNNLSOlkk7fvk8Ua2zxFQ3ytjM/qMBdZxotLN02zc3X3wDl0DiYRB5XL
         EyhNrlHRN3Jy5od95IdMqxoR/kxDBR8eOj/8Q+GD/+KsXfcc2WVQJR80zZ5TZ7G4zPcS
         xul0LAnfx8YIlKVeBPOidu/HyhZ/6LEhqSjtvQN0E/SnimUsGL8hzwrfgX1bT9ZNzcVN
         vfmxG/ScQ2DUFuUHGK/5dLMlQal5YVPbQUpQOlComx9qJ017AzKXlRbkTF87CXkiddbW
         CfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=yxmcm75FT6AziqQ/isNaMpYdx5uBTwn2kdGoQhrikVc=;
        b=LeWFHx6MN1yI5cFtoICC45mA5DwW8y28+qXHnMJ4dWEw0IpOxoiPdaB2H3YYCvjpL+
         o6mqcQIwqn9IqEA1+kh1w/3OUgZi8VSfNsf1a93YtnU+3xZowaWeSJ7Auav7ofznLTEw
         Zvu5z1qKm2uLbQPdL7/MrlvnhgoeBabt066Ox3L8wbxPg5Dm9/fN0b3VSCWyxEV63hui
         nfhFkxpurIE04iyBMsQj4RaKTiAspC1SHLFYetICm2fi1Ojf/VXz9rf6Ez+FgSRwj7eS
         OekOrZT7OcMpsdsw3PnhVZTYMBKyCdBB7n6dI2BiMGk/3Dqys2sOG9D4rOK0auxhVMK8
         BOug==
X-Gm-Message-State: ABuFfoi/qDo6yPGmLlZr8a5Pwg+cPNHOV1aueQOReWUhT2OCqEhbj36t
        Q3Q6/HBcZjCSm+vL9oZ5jZjN89OljAU=
X-Google-Smtp-Source: ACcGV62jhXlacAGsScijFV8vlDIBxGjW5FIW/qLAWV/N85UzOV0BwApyvHJ9P7dVB/aH87/Nautyzg==
X-Received: by 2002:a17:902:9a45:: with SMTP id x5-v6mr34886397plv.213.1539217651033;
        Wed, 10 Oct 2018 17:27:31 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id a11-v6sm32384610pfn.66.2018.10.10.17.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 17:27:29 -0700 (PDT)
Date:   Wed, 10 Oct 2018 17:27:29 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Oct 2018 17:27:13 PDT (-0700)
Subject:     Re: [PATCH 5/5] RISC-V: Implement sparsemem
In-Reply-To: <20181005161642.2462-6-logang@deltatee.com>
CC:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        sbates@raithlin.com, aou@eecs.berkeley.edu,
        Christoph Hellwig <hch@lst.de>, logang@deltatee.com,
        Andrew Waterman <andrew@sifive.com>,
        Olof Johansson <olof@lixom.net>,
        Michael Clark <michaeljclark@mac.com>, robh@kernel.org,
        zong@andestech.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     logang@deltatee.com
Message-ID: <mhng-c93e2f59-7121-4964-bd61-3c4c02044cf3@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Oct 2018 09:16:42 PDT (-0700), logang@deltatee.com wrote:
> This patch implements sparsemem support for risc-v which helps pave the
> way for memory hotplug and eventually P2P support.
>
> We introduce Kconfig options for virtual and physical address bits which
> are used to calculate the size of the vmemmap and set the
> MAX_PHYSMEM_BITS.
>
> The vmemmap is located directly before the VMALLOC region and sized
> such that we can allocate enough pages to populate all the virtual
> address space in the system (similar to the way it's done in arm64).
>
> During initialization, call memblocks_present() and sparse_init(),
> and provide a stub for vmemmap_populate() (all of which is similar to
> arm64).
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Andrew Waterman <andrew@sifive.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Michael Clark <michaeljclark@mac.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Zong Li <zong@andestech.com>
> ---
>  arch/riscv/Kconfig                 | 23 +++++++++++++++++++++++
>  arch/riscv/include/asm/pgtable.h   | 24 ++++++++++++++++++++----
>  arch/riscv/include/asm/sparsemem.h | 11 +++++++++++
>  arch/riscv/kernel/setup.c          |  4 +++-
>  arch/riscv/mm/init.c               |  8 ++++++++
>  5 files changed, 65 insertions(+), 5 deletions(-)
>  create mode 100644 arch/riscv/include/asm/sparsemem.h

I don't really know anything about this, but you're welcome to add a

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

if you think it'll help.  I'm assuming you're targeting a different tree for 
the patch set, in which case it's probably best to keep this together with the 
rest of it.

Thanks for porting your stuff to RISC-V!

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a344980287a5..a1b5d758a542 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -52,12 +52,32 @@ config ZONE_DMA32
>  	bool
>  	default y if 64BIT
>
> +config VA_BITS
> +	int
> +	default 32 if 32BIT
> +	default 39 if 64BIT
> +
> +config PA_BITS
> +	int
> +	default 34 if 32BIT
> +	default 56 if 64BIT
> +
>  config PAGE_OFFSET
>  	hex
>  	default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
>  	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
>  	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
>
> +config ARCH_FLATMEM_ENABLE
> +	def_bool y
> +
> +config ARCH_SPARSEMEM_ENABLE
> +	def_bool y
> +	select SPARSEMEM_VMEMMAP_ENABLE
> +
> +config ARCH_SELECT_MEMORY_MODEL
> +	def_bool ARCH_SPARSEMEM_ENABLE
> +
>  config STACKTRACE_SUPPORT
>  	def_bool y
>
> @@ -92,6 +112,9 @@ config PGTABLE_LEVELS
>  config HAVE_KPROBES
>  	def_bool n
>
> +config HAVE_ARCH_PFN_VALID
> +	def_bool y
> +
>  menu "Platform type"
>
>  choice
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 16301966d65b..20c49cded686 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -89,6 +89,26 @@ extern pgd_t swapper_pg_dir[];
>  #define __S110	PAGE_SHARED_EXEC
>  #define __S111	PAGE_SHARED_EXEC
>
> +#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> +#define VMALLOC_END      (PAGE_OFFSET - 1)
> +#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> +
> +/*
> + * Log2 of the upper bound of the size of a struct page. Used for sizing
> + * the vmemmap region only, does not affect actual memory footprint.
> + * We don't use sizeof(struct page) directly since taking its size here
> + * requires its definition to be available at this point in the inclusion
> + * chain, and it may not be a power of 2 in the first place.
> + */
> +#define STRUCT_PAGE_MAX_SHIFT	6
> +
> +#define VMEMMAP_SIZE	(UL(1) << (CONFIG_VA_BITS - PAGE_SHIFT - 1 + \
> +				   STRUCT_PAGE_MAX_SHIFT))
> +#define VMEMMAP_END	(VMALLOC_START - 1)
> +#define VMEMMAP_START	(VMALLOC_START - VMEMMAP_SIZE)
> +
> +#define vmemmap		((struct page *)VMEMMAP_START)
> +
>  /*
>   * ZERO_PAGE is a global shared page that is always zero,
>   * used for zero-mapped memory areas, etc.
> @@ -411,10 +431,6 @@ static inline void pgtable_cache_init(void)
>  	/* No page table caches to initialize */
>  }
>
> -#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> -#define VMALLOC_END      (PAGE_OFFSET - 1)
> -#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> -
>  /*
>   * Task size is 0x40000000000 for RV64 or 0xb800000 for RV32.
>   * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
> diff --git a/arch/riscv/include/asm/sparsemem.h b/arch/riscv/include/asm/sparsemem.h
> new file mode 100644
> index 000000000000..4563e806c788
> --- /dev/null
> +++ b/arch/riscv/include/asm/sparsemem.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_SPARSEMEM_H
> +#define __ASM_SPARSEMEM_H
> +
> +#ifdef CONFIG_SPARSEMEM
> +#define MAX_PHYSMEM_BITS	CONFIG_PA_BITS
> +#define SECTION_SIZE_BITS	30
> +#endif
> +
> +#endif
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index aee603123030..89fa781a9bf8 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -205,6 +205,9 @@ static void __init setup_bootmem(void)
>  		                  PFN_PHYS(end_pfn - start_pfn),
>  		                  &memblock.memory, 0);
>  	}
> +
> +	memblocks_present();
> +	sparse_init();
>  }
>
>  void __init setup_arch(char **cmdline_p)
> @@ -239,4 +242,3 @@ void __init setup_arch(char **cmdline_p)
>
>  	riscv_fill_hwcap();
>  }
> -
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 58a522f9bcc3..5d529878667c 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -70,3 +70,11 @@ void free_initrd_mem(unsigned long start, unsigned long end)
>  {
>  }
>  #endif /* CONFIG_BLK_DEV_INITRD */
> +
> +#ifdef CONFIG_SPARSEMEM
> +int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
> +			       struct vmem_altmap *altmap)
> +{
> +	return vmemmap_populate_basepages(start, end, node);
> +}
> +#endif
