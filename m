Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0184C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B901240C2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNHUYyC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B901240C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbeGEW1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:27:53 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40379 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753471AbeGEW1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:27:52 -0400
Received: by mail-io0-f193.google.com with SMTP id t135-v6so9174917iof.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 15:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UxRcbdE1oNw3BSXTwV9MezTNBrFXXmq8PRoRdtcey9Y=;
        b=UNHUYyC/GZ7B9mGYVO3SrpaonGRrTQ7hzelGJaCxV5ngUiY+ulIpoZX6ShsaGLUxCH
         o1h3BZ7/bCYVpd07CHCijjgZRFDwJQtpLRUYfMJah5Gu6MZB02KlrSc21VA5yM4xLmSg
         9nU5DXTpipvl7sv7wnoQMJJeC5hCZLda+LEQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UxRcbdE1oNw3BSXTwV9MezTNBrFXXmq8PRoRdtcey9Y=;
        b=DabEuQw8N6aHSmlGJCSlMAROGmAIHfQ9E2DTnKqwJg3JsHPoS8vjTGFo0MVCPi8bnj
         IXDBjQ+iVz6pd8ygP5r3dwEvgvVn7w2k6RIXBH231G4BB1lF5DIiPSAlVCrcH2IgH/l4
         KlOlnN1F31x1n667eSFsf+josLrUwumcHbFjGBRxWzUJaYlWL8hwvWYfqTpHFAtjSEj0
         dJs3MpDABGPyPmjXQHTRoOCvW2osfPBUdmrlAfX5a2n8zUnyop17sJ7hPbilku0DyywY
         U92mJmd4btbOFBhhlZbGFgBPvt/5pz0IADFcqSKTbXtuYUaNlIZuE/AVdxU3F4Vpxla0
         tZRw==
X-Gm-Message-State: AOUpUlFKb1h1NATkdmVrFzKV9kZ/kZv8WYXmQVk77ZH7w/Vg4HoorMe8
        rI9yvPqjK64rlDe4ENEFeSoG4EeavSk3g+5dpK/+GQ==
X-Google-Smtp-Source: AAOMgpft7hwkaaoKjiG82SvJfFd5mSsVL4slfEIS5jnz13Bk4rCl0jj9MX1UlF+be4VcPj6Q9hNoVxAo6RrHVnExKzM=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr6463073iof.173.1530829671458;
 Thu, 05 Jul 2018 15:27:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 15:27:51 -0700 (PDT)
In-Reply-To: <20180619064424.6642-5-takahiro.akashi@linaro.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org> <20180619064424.6642-5-takahiro.akashi@linaro.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 6 Jul 2018 00:27:51 +0200
Message-ID: <CAKv+Gu83YXdM=bjNLhCQncu+fvjrETgsrr8PR37U1F9xE+K4ow@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: acpi: fix alignment fault in accessing ACPI
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Baicar, Tyler" <tbaicar@codeaurora.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Stone <al.stone@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 June 2018 at 08:44, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> This is a fix against the issue that crash dump kernel may hang up
> during booting, which can happen on any ACPI-based system with "ACPI
> Reclaim Memory."
>
> (kernel messages after panic kicked off kdump)
>            (snip...)
>         Bye!
>            (snip...)
>         ACPI: Core revision 20170728
>         pud=000000002e7d0003, *pmd=000000002e7c0003, *pte=00e8000039710707
>         Internal error: Oops: 96000021 [#1] SMP
>         Modules linked in:
>         CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.0-rc6 #1
>         task: ffff000008d05180 task.stack: ffff000008cc0000
>         PC is at acpi_ns_lookup+0x25c/0x3c0
>         LR is at acpi_ds_load1_begin_op+0xa4/0x294
>            (snip...)
>         Process swapper/0 (pid: 0, stack limit = 0xffff000008cc0000)
>         Call trace:
>            (snip...)
>         [<ffff0000084a6764>] acpi_ns_lookup+0x25c/0x3c0
>         [<ffff00000849b4f8>] acpi_ds_load1_begin_op+0xa4/0x294
>         [<ffff0000084ad4ac>] acpi_ps_build_named_op+0xc4/0x198
>         [<ffff0000084ad6cc>] acpi_ps_create_op+0x14c/0x270
>         [<ffff0000084acfa8>] acpi_ps_parse_loop+0x188/0x5c8
>         [<ffff0000084ae048>] acpi_ps_parse_aml+0xb0/0x2b8
>         [<ffff0000084a8e10>] acpi_ns_one_complete_parse+0x144/0x184
>         [<ffff0000084a8e98>] acpi_ns_parse_table+0x48/0x68
>         [<ffff0000084a82cc>] acpi_ns_load_table+0x4c/0xdc
>         [<ffff0000084b32f8>] acpi_tb_load_namespace+0xe4/0x264
>         [<ffff000008baf9b4>] acpi_load_tables+0x48/0xc0
>         [<ffff000008badc20>] acpi_early_init+0x9c/0xd0
>         [<ffff000008b70d50>] start_kernel+0x3b4/0x43c
>         Code: b9008fb9 2a000318 36380054 32190318 (b94002c0)
>         ---[ end trace c46ed37f9651c58e ]---
>         Kernel panic - not syncing: Fatal exception
>         Rebooting in 10 seconds..
>
> (diagnosis)
> * This fault is a data abort, alignment fault (ESR=0x96000021)
>   during reading out ACPI table.
> * Initial ACPI tables are normally stored in system ram and marked as
>   "ACPI Reclaim memory" by the firmware.
> * After the commit f56ab9a5b73c ("efi/arm: Don't mark ACPI reclaim
>   memory as MEMBLOCK_NOMAP"), those regions are differently handled
>   as they are "memblock-reserved", without NOMAP bit.
> * So they are now excluded from device tree's "usable-memory-range"
>   which kexec-tools determines based on a current view of /proc/iomem.
> * When crash dump kernel boots up, it tries to accesses ACPI tables by
>   mapping them with ioremap(), not ioremap_cache(), in acpi_os_ioremap()
>   since they are no longer part of mapped system ram.
> * Given that ACPI accessor/helper functions are compiled in without
>   unaligned access support (ACPI_MISALIGNMENT_NOT_SUPPORTED),
>   any unaligned access to ACPI tables can cause a fatal panic.
>
> With this patch, acpi_os_ioremap() always honors memory attribute
> information provided by the firmware (EFI) and retaining cacheability
> allows the kernel safe access to ACPI tables.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Suggested-by: James Morse <james.morse@arm.com>
> Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reported-by and Tested-by: Bhupesh Sharma <bhsharma@redhat.com>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/include/asm/acpi.h | 23 ++++++++++++++++-------
>  arch/arm64/kernel/acpi.c      | 11 +++--------
>  2 files changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 0db62a4cbce2..68bc18cb2b85 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -12,10 +12,12 @@
>  #ifndef _ASM_ACPI_H
>  #define _ASM_ACPI_H
>
> +#include <linux/efi.h>
>  #include <linux/memblock.h>
>  #include <linux/psci.h>
>
>  #include <asm/cputype.h>
> +#include <asm/io.h>
>  #include <asm/smp_plat.h>
>  #include <asm/tlbflush.h>
>
> @@ -29,18 +31,22 @@
>
>  /* Basic configuration for ACPI */
>  #ifdef CONFIG_ACPI
> +pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
> +
>  /* ACPI table mapping after acpi_permanent_mmap is set */
>  static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
>                                             acpi_size size)
>  {
> +       /* For normal memory we already have a cacheable mapping. */
> +       if (memblock_is_map_memory(phys))
> +               return (void __iomem *)__phys_to_virt(phys);
> +
>         /*
> -        * EFI's reserve_regions() call adds memory with the WB attribute
> -        * to memblock via early_init_dt_add_memory_arch().
> +        * We should still honor the memory's attribute here because
> +        * crash dump kernel possibly excludes some ACPI (reclaim)
> +        * regions from memblock list.
>          */
> -       if (!memblock_is_memory(phys))
> -               return ioremap(phys, size);
> -
> -       return ioremap_cache(phys, size);
> +       return __ioremap(phys, size, __acpi_get_mem_attribute(phys));
>  }
>  #define acpi_os_ioremap acpi_os_ioremap
>
> @@ -129,7 +135,10 @@ static inline const char *acpi_get_enable_method(int cpu)
>   * for compatibility.
>   */
>  #define acpi_disable_cmcff 1
> -pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
> +static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
> +{
> +       return __acpi_get_mem_attribute(addr);
> +}
>  #endif /* CONFIG_ACPI_APEI */
>
>  #ifdef CONFIG_ACPI_NUMA
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 7b09487ff8fb..ed46dc188b22 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -18,6 +18,7 @@
>  #include <linux/acpi.h>
>  #include <linux/bootmem.h>
>  #include <linux/cpumask.h>
> +#include <linux/efi.h>
>  #include <linux/efi-bgrt.h>
>  #include <linux/init.h>
>  #include <linux/irq.h>
> @@ -29,13 +30,9 @@
>
>  #include <asm/cputype.h>
>  #include <asm/cpu_ops.h>
> +#include <asm/pgtable.h>
>  #include <asm/smp_plat.h>
>
> -#ifdef CONFIG_ACPI_APEI
> -# include <linux/efi.h>
> -# include <asm/pgtable.h>
> -#endif
> -
>  int acpi_noirq = 1;            /* skip ACPI IRQ initialization */
>  int acpi_disabled = 1;
>  EXPORT_SYMBOL(acpi_disabled);
> @@ -239,8 +236,7 @@ void __init acpi_boot_table_init(void)
>         }
>  }
>
> -#ifdef CONFIG_ACPI_APEI
> -pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
> +pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
>  {
>         /*
>          * According to "Table 8 Map: EFI memory types to AArch64 memory
> @@ -261,4 +257,3 @@ pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
>                 return __pgprot(PROT_NORMAL_NC);
>         return __pgprot(PROT_DEVICE_nGnRnE);
>  }
> -#endif
> --
> 2.17.0
>
