Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE23EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682E620657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qHOf7Wt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392344AbfAPLCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:02:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47812 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389534AbfAPLCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:02:07 -0500
Received: from zn.tnic (p200300EC2BC98A00BDE8DF251329FBA0.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:8a00:bde8:df25:1329:fba0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5874A1EC0570;
        Wed, 16 Jan 2019 12:02:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547636525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=O/+Tc3X8aX99bUusRKq5sIj1LB7nyy0d/udkV18m06A=;
        b=qHOf7Wt5M/jQSWNMw0f2RwdND0lWRDAja4Q8HYqb1EQcc35WcyuJHALMnAgLrJBSQcbena
        TvlK8JQ/DkT2Eu5CoXh8ZeE3kLAQX5+kCstUAkustd7sVEjmbiAbwqQWLWBpMtBXzs87IS
        ax+X4Wm8Vk70TjyiReIp211a03dgCbw=
Date:   Wed, 16 Jan 2019 12:01:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v15 5/6] x86/boot: Parse SRAT address from RSDP and store
 immovable memory
Message-ID: <20190116110158.GC15409@zn.tnic>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-6-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107032243.25324-6-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 11:22:42AM +0800, Chao Fan wrote:
> SRAT should be parsed by RSDP to fix the conflict between KASLR and
> memory-hotremove, then find the immovable memory regions and store
> them in an array called immovable_mem[]. With immovable_mem[], KASLR
> can avoid to extract kernel to specific regions.
> 
> Since 'RANDOMIZE_BASE' && 'MEMORY_HOTREMOVE' is needed, introduce
> 'CONFIG_EARLY_SRAT_PARSE' to make ifdeffery clear.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/Kconfig                  |  12 +++
>  arch/x86/boot/compressed/Makefile |   2 +
>  arch/x86/boot/compressed/acpi.c   | 138 ++++++++++++++++++++++++++++++
>  arch/x86/boot/compressed/kaslr.c  |   4 -
>  arch/x86/boot/compressed/misc.h   |  19 ++++
>  5 files changed, 171 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index ba7e3464ee92..c1457609f2e3 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2149,6 +2149,18 @@ config X86_NEED_RELOCS
>  	def_bool y
>  	depends on RANDOMIZE_BASE || (X86_32 && RELOCATABLE)
>  
> +config EARLY_SRAT_PARSE
> +	bool "EARLY SRAT parsing"
> +	def_bool y
> +	depends on RANDOMIZE_BASE && MEMORY_HOTREMOVE
> +	help
> +	  This option enables early SRAT parsing in compressed boot stage
> +	  so that memory hot-remove ranges do not overlap with KASLR
> +	  chosen ranges. Kernel won't be extracted in hot-removable
> +	  memory, so that make sure memory-hotremove works well with
> +	  KASLR enabled.
> +	  Say Y if you want to use both KASLR and memory-hotremove.
> +

One argument for Ingo's suggestion to have this enabled unconditionally
is all the other code needing RSDP. It might be easier to have it always
built-in instead of a long "depends on" line in Kconfig. We'll see.

>  config PHYSICAL_ALIGN
>  	hex "Alignment value to which kernel should be aligned"
>  	default "0x200000"
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 466f66c8a7f8..23491d74939d 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -84,6 +84,8 @@ ifdef CONFIG_X86_64
>  	vmlinux-objs-y += $(obj)/pgtable_64.o
>  endif
>  
> +vmlinux-objs-$(CONFIG_EARLY_SRAT_PARSE) += $(obj)/acpi.o
> +
>  $(obj)/eboot.o: KBUILD_CFLAGS += -fshort-wchar -mno-red-zone
>  
>  vmlinux-objs-$(CONFIG_EFI_STUB) += $(obj)/eboot.o $(obj)/efi_stub_$(BITS).o \
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index e9dd84f459ed..f7a9e9cbd254 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -5,6 +5,7 @@
>  #include "../string.h"
>  
>  #include <linux/acpi.h>
> +#include <linux/numa.h>
>  #include <linux/efi.h>
>  #include <asm/efi.h>
>  
> @@ -14,6 +15,19 @@
>   */
>  #define MAX_HEX_ADDRESS_STRING_LEN 19
>  
> +/*
> + * Longest parameter of 'acpi=' in cmldine is 'copy_dsdt', so max length
> + * is 10, which contains '\0' for termination.
> + */
> +#define MAX_ACPI_ARG_LENGTH 10
> +
> +/*
> + * Information of immovable memory regions.
> + * Max amount of memory regions is MAX_NUMNODES*2, so need such array
> + * to place immovable memory regions if all of the memory is immovable.
> + */
> +struct mem_vector immovable_mem[MAX_NUMNODES*2];
> +
>  static acpi_physical_address get_acpi_rsdp(void)
>  {
>  #ifdef CONFIG_KEXEC
> @@ -197,3 +211,127 @@ static acpi_physical_address bios_get_rsdp_addr(void)
>  	}
>  	return 0;
>  }
> +
> +/* Determine RSDP, based on acpi_os_get_root_pointer(). */
> +static acpi_physical_address get_rsdp_addr(void)
> +{
> +	acpi_physical_address pa;
> +
> +	pa = get_acpi_rsdp();
> +
> +	if (!pa)
> +		pa = efi_get_rsdp_addr();
> +
> +	if (!pa)
> +		pa = bios_get_rsdp_addr();
> +
> +	return pa;
> +}
> +
> +/* Compute SRAT address from RSDP. */
> +static struct acpi_table_header *get_acpi_srat_table(void)
> +{
> +	acpi_physical_address acpi_table;
> +	acpi_physical_address root_table;
> +	struct acpi_table_header *header;
> +	struct acpi_table_rsdp *rsdp;
> +	u32 num_entries;
> +	char arg[10];
> +	u8 *entry;
> +	u32 size;
> +	u32 len;
> +
> +	rsdp = (struct acpi_table_rsdp *)(long)get_rsdp_addr();
> +	if (!rsdp)
> +		return NULL;
> +
> +	/* Get RSDT or XSDT from RSDP. */
> +	if (!(cmdline_find_option("acpi", arg, sizeof(arg)) == 4 &&
> +	    !strncmp(arg, "rsdt", 4)) &&
> +	    rsdp->xsdt_physical_address &&
> +	    rsdp->revision > 1) {
> +		root_table = rsdp->xsdt_physical_address;
> +		size = ACPI_XSDT_ENTRY_SIZE;
> +	} else {
> +		root_table = rsdp->rsdt_physical_address;
> +		size = ACPI_RSDT_ENTRY_SIZE;
> +	}
> +
> +	/* Get ACPI root table from RSDT or XSDT.*/

This comment is wrong here - should be above.

> +	if (!root_table)
> +		return NULL;

<---- newline here.

> +	header = (struct acpi_table_header *)(long)root_table;
> +
> +	len = header->length;
> +	if (len < sizeof(struct acpi_table_header) + size)
> +		return NULL;
> +
> +	num_entries = (u32)((len - sizeof(struct acpi_table_header)) / size);
> +	entry = ACPI_ADD_PTR(u8, header, sizeof(struct acpi_table_header));
> +
> +	while (num_entries--) {
> +		u64 address64;
> +
> +		if (size == ACPI_RSDT_ENTRY_SIZE)
> +			acpi_table =  *ACPI_CAST_PTR(u32, entry);
> +		else {
> +			address64 = *(u64 *)entry;
> +			acpi_table = address64;

The same thing as in the previous patch - get rid of address64.

> +		}
> +
> +		if (acpi_table) {
> +			header = (struct acpi_table_header *)(long)acpi_table;
> +
> +			if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_SRAT))
> +				return header;
> +		}
> +		entry += size;
> +	}
> +	return NULL;
> +}
> +
> +/*
> + * According to ACPI table, filter the immovable memory regions
> + * and store them in immovable_mem[].
> + */
> +void get_immovable_mem(void)
> +{
> +	struct acpi_table_header *table_header;
> +	struct acpi_subtable_header *table;
> +	struct acpi_srat_mem_affinity *ma;
> +	char arg[MAX_ACPI_ARG_LENGTH];
> +	unsigned long table_end;
> +	int i = 0;
> +
> +	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
> +	    !strncmp(arg, "off", 3))
> +		return;
> +
> +	table_header = get_acpi_srat_table();
> +	if (!table_header)
> +		return;
> +
> +	table_end = (unsigned long)table_header + table_header->length;
> +	table = (struct acpi_subtable_header *)
> +		((unsigned long)table_header + sizeof(struct acpi_table_srat));
> +
> +	while (((unsigned long)table) +
> +		       sizeof(struct acpi_subtable_header) < table_end) {
> +		if (table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
> +			ma = (struct acpi_srat_mem_affinity *)table;
> +			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
> +				immovable_mem[i].start = ma->base_address;
> +				immovable_mem[i].size = ma->length;
> +				i++;
> +			}
> +
> +			if (i >= MAX_NUMNODES*2) {
> +				debug_putstr("Too many immovable memory regions, aborting.\n");
> +				return;
> +			}
> +		}
> +		table = (struct acpi_subtable_header *)
> +			((unsigned long)table + table->length);

That's a lot of unnecessary casting AFAICT. You can return an unsigned
long from get_acpi_srat_table() and get rid of all that casting here.


> +	}
> +	num_immovable_mem = i;
> +}
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 9ed9709d9947..b251572e77af 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -87,10 +87,6 @@ static unsigned long get_boot_seed(void)
>  #define KASLR_COMPRESSED_BOOT
>  #include "../../lib/kaslr.c"
>  
> -struct mem_vector {
> -	unsigned long long start;
> -	unsigned long long size;
> -};
>  
>  /* Only supporting at most 4 unusable memmap regions with kaslr */
>  #define MAX_MEMMAP_REGIONS	4
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index a1d5918765f3..b49748366a5b 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -77,6 +77,11 @@ void choose_random_location(unsigned long input,
>  			    unsigned long *output,
>  			    unsigned long output_size,
>  			    unsigned long *virt_addr);
> +struct mem_vector {
> +	unsigned long long start;
> +	unsigned long long size;
> +};
> +
>  /* cpuflags.c */
>  bool has_cpuflag(int flag);
>  #else
> @@ -116,3 +121,17 @@ static inline void console_init(void)
>  void set_sev_encryption_mask(void);
>  
>  #endif
> +
> +/* acpi.c */
> +#ifdef CONFIG_RANDOMIZE_BASE
> +/* Amount of immovable memory regions */
> +int num_immovable_mem;
> +#endif
> +
> +#ifdef CONFIG_EARLY_SRAT_PARSE
> +void get_immovable_mem(void);
> +#else
> +static void get_immovable_mem(void)
> +{
> +}

Put those on a single line:

static void get_immovable_mem(void) {}

> +#endif
> -- 
> 2.20.1
> 
> 
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
