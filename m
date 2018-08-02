Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CCEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DEA20BED
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DEA20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbeHBI4J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:56:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:56504 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbeHBI4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:56:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 00:06:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,434,1526367600"; 
   d="scan'208";a="78047251"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.250.45])
  by orsmga001.jf.intel.com with SMTP; 02 Aug 2018 00:06:21 -0700
Received: by ubuntu (sSMTP sendmail emulation); Thu, 02 Aug 2018 15:06:20 +0800
Message-ID: <1533193580.23760.1.camel@intel.com>
Subject: Re: [PATCH 2/3] nios2: use generic early_init_dt_add_memory_arch
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Ley Foon Tan <lftan@altera.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        nios2-dev@lists.rocketboards.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 02 Aug 2018 15:06:20 +0800
In-Reply-To: <1530710295-10774-3-git-send-email-rppt@linux.vnet.ibm.com>
References: <1530710295-10774-1-git-send-email-rppt@linux.vnet.ibm.com>
         <1530710295-10774-3-git-send-email-rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-04 at 16:18 +0300, Mike Rapoport wrote:
> All we have to do is to enable memblock, the generic FDT code will
> take
> care of the rest.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
>  arch/nios2/Kconfig        |  1 +
>  arch/nios2/kernel/prom.c  | 10 ----------
>  arch/nios2/kernel/setup.c |  2 ++
>  3 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
> index 3d4ec88..5db8fa1 100644
> --- a/arch/nios2/Kconfig
> +++ b/arch/nios2/Kconfig
> @@ -19,6 +19,7 @@ config NIOS2
>         select SPARSE_IRQ
>         select USB_ARCH_HAS_HCD if USB_SUPPORT
>         select CPU_NO_EFFICIENT_FFS
> +       select HAVE_MEMBLOCK
> 
>  config GENERIC_CSUM
>         def_bool y
> diff --git a/arch/nios2/kernel/prom.c b/arch/nios2/kernel/prom.c
> index 8d7446a..ba96a49 100644
> --- a/arch/nios2/kernel/prom.c
> +++ b/arch/nios2/kernel/prom.c
> @@ -32,16 +32,6 @@
> 
>  #include <asm/sections.h>
> 
> -void __init early_init_dt_add_memory_arch(u64 base, u64 size)
> -{
> -       u64 kernel_start = (u64)virt_to_phys(_text);
> -
> -       if (!memory_size &&
> -           (kernel_start >= base) && (kernel_start < (base + size)))
> -               memory_size = size;
> -
> -}
> -
>  int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
> phys_addr_t size,
>                                              bool nomap)
>  {
> diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
> index 926a02b..0946840 100644
> --- a/arch/nios2/kernel/setup.c
> +++ b/arch/nios2/kernel/setup.c
> @@ -17,6 +17,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/console.h>
>  #include <linux/bootmem.h>
> +#include <linux/memblock.h>
>  #include <linux/initrd.h>
>  #include <linux/of_fdt.h>
>  #include <linux/screen_info.h>
> @@ -147,6 +148,7 @@ void __init setup_arch(char **cmdline_p)
> 
>         console_verbose();
> 
> +       memory_size = memblock_phys_mem_size();
>         memory_start = PAGE_ALIGN((unsigned long)__pa(_end));
>         memory_end = (unsigned long) CONFIG_NIOS2_MEM_BASE +
> memory_size;
> 
> --
Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>
