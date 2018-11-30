Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C10C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E092D2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E092D2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeK3Mcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:32:41 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1821 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726393AbeK3Mcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 07:32:41 -0500
X-IronPort-AV: E=Sophos;i="5.56,296,1539619200"; 
   d="scan'208";a="48850056"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Nov 2018 09:25:08 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id D599B4B734A7;
        Fri, 30 Nov 2018 09:25:08 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 30 Nov 2018 09:25:09 +0800
Date:   Fri, 30 Nov 2018 09:24:54 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v12 4/5] x86/boot: Parse SRAT table from RSDP and store
 immovable memory
Message-ID: <20181130012454.GB1527@localhost.localdomain>
References: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
 <20181129081631.11139-5-fanc.fnst@cn.fujitsu.com>
 <20181129175520.xcmj3bv4yhdr7kk3@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181129175520.xcmj3bv4yhdr7kk3@gabell>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: D599B4B734A7.ACE76
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 12:55:21PM -0500, Masayoshi Mizuma wrote:
>On Thu, Nov 29, 2018 at 04:16:30PM +0800, Chao Fan wrote:
>> To fix the conflict between KASLR and memory-hotremove, SRAT table
>> should be parsed by RSDP pointer, then find the immovable
>> memory regions and store them in an array called immovable_mem[].
>> The array called immovable_mem[] will extern to KASLR, then
>> KASLR will avoid to extract kernel to these regions.
>> 
>> Add 'CONFIG_EARLY_PARSE_RSDP' which depends on RANDOMIZE_BASE &&
>> MEMORY_HOTREMOVE, cause only when both KASLR and memory-hotremove
>> are enabled, RSDP needs to be parsed in compressed period.
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/Kconfig                  |  10 +++
>>  arch/x86/boot/compressed/Makefile |   2 +
>>  arch/x86/boot/compressed/acpitb.c | 125 ++++++++++++++++++++++++++++++
>>  arch/x86/boot/compressed/kaslr.c  |   4 -
>>  arch/x86/boot/compressed/misc.h   |  20 +++++
>>  5 files changed, 157 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index a29d49ef4d56..bc775968557b 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2146,6 +2146,16 @@ config X86_NEED_RELOCS
>>  	def_bool y
>>  	depends on RANDOMIZE_BASE || (X86_32 && RELOCATABLE)
>>  
>
>> +config CONFIG_EARLY_PARSE_RSDP
>
>config EARLY_PARSE_RSDP
>
>> +	bool "Parse RSDP pointer on compressed period for KASLR"
>> +	def_bool n
>
>Should be def_bool y?

I will change it to y.

>It is better to enable EARLY_PARSE_RSDP by default if 
>RANDOMIZE_BASE and MEMORY_HOTREMOVE are enabled.
>
>> +	depends on RANDOMIZE_BASE && MEMORY_HOTREMOVE
>> +	help
>> +	  This option parses RSDP pointer in compressed period. Works
>> +	  for KASLR to get memory information by SRAT table and choose
>> +	  immovable memory to extract kernel.
>> +	  Say Y if you want to use both KASLR and memory-hotremove.
>> +
>>  config PHYSICAL_ALIGN
>>  	hex "Alignment value to which kernel should be aligned"
>>  	default "0x200000"
>> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>> index 466f66c8a7f8..4cbfb58bf083 100644
>> --- a/arch/x86/boot/compressed/Makefile
>> +++ b/arch/x86/boot/compressed/Makefile
>> @@ -84,6 +84,8 @@ ifdef CONFIG_X86_64
>>  	vmlinux-objs-y += $(obj)/pgtable_64.o
>>  endif
>>  
>> +vmlinux-objs-$(CONFIG_EARLY_PARSE_RSDP) += $(obj)/acpitb.o
>> +
>>  $(obj)/eboot.o: KBUILD_CFLAGS += -fshort-wchar -mno-red-zone
>>  
>>  vmlinux-objs-$(CONFIG_EFI_STUB) += $(obj)/eboot.o $(obj)/efi_stub_$(BITS).o \
>> diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
>> index 82d27c4b8978..023b33d0cd3b 100644
>> --- a/arch/x86/boot/compressed/acpitb.c
>> +++ b/arch/x86/boot/compressed/acpitb.c
>> @@ -195,3 +195,128 @@ static acpi_physical_address bios_get_rsdp_addr(void)
>>  		return (acpi_physical_address)address;
>>  	}
>>  }
>> +
>> +/* Used to determine RSDP table, based on acpi_os_get_root_pointer(). */
>> +static acpi_physical_address get_rsdp_addr(void)
>> +{
>> +	acpi_physical_address pa = 0;
>> +
>> +	pa = get_acpi_rsdp();
>> +
>> +	if (!pa)
>> +		pa = efi_get_rsdp_addr();
>> +
>> +	if (!pa)
>> +		pa = bios_get_rsdp_addr();
>> +
>> +	return pa;
>> +}
>> +
>> +/* Compute SRAT table from RSDP. */
>> +static struct acpi_table_header *get_acpi_srat_table(void)
>> +{
>> +	acpi_physical_address acpi_table;
>> +	acpi_physical_address root_table;
>> +	struct acpi_table_header *header;
>> +	struct acpi_table_rsdp *rsdp;
>> +	int num_entries;
>> +	char arg[10];
>> +	u8 *entry;
>> +	u32 size;
>> +	u32 len;
>> +
>> +	rsdp = (struct acpi_table_rsdp *)get_rsdp_addr();
>> +	if (!rsdp)
>> +		return NULL;
>> +
>> +	/* Get RSDT or XSDT from RSDP. */
>
>> +	if (!(cmdline_find_option("acpi", arg, sizeof(arg)) == 4 &&
>> +	    !strncmp(arg, "rsdt", 4)) &&
>> +	    rsdp->xsdt_physical_address &&
>> +	    rsdp->revision > 1) {
>> +		root_table = rsdp->xsdt_physical_address;
>> +		size = ACPI_XSDT_ENTRY_SIZE;
>> +	} else {
>> +		root_table = rsdp->rsdt_physical_address;
>> +		size = ACPI_RSDT_ENTRY_SIZE;
>> +	}
>> +
>> +	/* Get ACPI root table from RSDT or XSDT.*/
>> +	header = (struct acpi_table_header *)root_table;
>> +	if (!header)
>> +		return NULL;
>> +
>> +	len = header->length;
>> +	num_entries = (u32)((len - sizeof(struct acpi_table_header)) / size);
>
>> +	if (num_entries > MAX_ACPI_SIG)
>> +		return NULL;
>
>I think this check isn't needed...
>
>> +
>> +	entry = ACPI_ADD_PTR(u8, header, sizeof(struct acpi_table_header));
>> +
>> +	while (num_entries--) {
>> +		u64 address64;
>> +
>> +		if (size == ACPI_RSDT_ENTRY_SIZE)
>> +			acpi_table = ((acpi_physical_address)
>> +				      (*ACPI_CAST_PTR(u32, entry)));
>> +		else {
>> +			*(u64 *)(void *)&address64 = *(u64 *)(void *)entry;
>> +			acpi_table = (acpi_physical_address) address64;
>> +		}
>> +
>> +		if (acpi_table) {
>> +			header = (struct acpi_table_header *)acpi_table;
>> +
>> +			if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_SRAT))
>> +				return header;
>> +		}
>> +		entry += size;
>> +	}
>> +	return NULL;
>> +}
>> +
>> +/*
>> + * According to ACPI table, filter the immovable memory regions
>> + * and store them in immovable_mem[].
>> + */
>> +void get_immovable_mem(void)
>> +{
>> +	struct acpi_table_header *table_header;
>> +	struct acpi_subtable_header *table;
>> +	struct acpi_srat_mem_affinity *ma;
>> +	unsigned long table_end;
>> +	char arg[10];
>> +	int i = 0;
>> +
>> +	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
>> +	    !strncmp(arg, "off", 3))
>> +		return;
>> +
>> +	table_header = get_acpi_srat_table();
>> +	if (!table_header)
>> +		return;
>> +
>> +	table_end = (unsigned long)table_header + table_header->length;
>> +	table = (struct acpi_subtable_header *)
>> +		((unsigned long)table_header + sizeof(struct acpi_table_srat));
>> +
>> +	while (((unsigned long)table) +
>> +		       sizeof(struct acpi_subtable_header) < table_end) {
>> +		if (table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
>> +			ma = (struct acpi_srat_mem_affinity *)table;
>> +			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
>> +				immovable_mem[i].start = ma->base_address;
>> +				immovable_mem[i].size = ma->length;
>> +				i++;
>> +			}
>> +
>> +			if (i >= MAX_NUMNODES*2) {
>> +				debug_putstr("Too many immovable memory regions, aborting.\n");
>> +				return;
>> +			}
>> +		}
>> +		table = (struct acpi_subtable_header *)
>> +			((unsigned long)table + table->length);
>> +	}
>> +	num_immovable_mem = i;
>> +}
>> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
>> index 9ed9709d9947..b251572e77af 100644
>> --- a/arch/x86/boot/compressed/kaslr.c
>> +++ b/arch/x86/boot/compressed/kaslr.c
>> @@ -87,10 +87,6 @@ static unsigned long get_boot_seed(void)
>>  #define KASLR_COMPRESSED_BOOT
>>  #include "../../lib/kaslr.c"
>>  
>> -struct mem_vector {
>> -	unsigned long long start;
>> -	unsigned long long size;
>> -};
>>  
>>  /* Only supporting at most 4 unusable memmap regions with kaslr */
>>  #define MAX_MEMMAP_REGIONS	4
>> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
>> index 809c31effa4b..d94e2a419c13 100644
>> --- a/arch/x86/boot/compressed/misc.h
>> +++ b/arch/x86/boot/compressed/misc.h
>> @@ -77,6 +77,11 @@ void choose_random_location(unsigned long input,
>>  			    unsigned long *output,
>>  			    unsigned long output_size,
>>  			    unsigned long *virt_addr);
>> +struct mem_vector {
>> +	unsigned long long start;
>> +	unsigned long long size;
>> +};
>> +
>>  /* cpuflags.c */
>>  bool has_cpuflag(int flag);
>>  #else
>> @@ -118,5 +123,20 @@ void set_sev_encryption_mask(void);
>>  #endif
>>  
>>  /* acpitb.c */
>> +#ifdef CONFIG_RANDOMIZE_BASE
>> +/* Store the amount of immovable memory regions */
>> +int num_immovable_mem;
>> +#endif
>> +
>> +#ifdef CONFIG_EARLY_PARSE_RSDP
>> +void get_immovable_mem(void);
>
>> +/* There are 72 kinds of ACPI_SIG in head file of ACPI. */
>> +#define MAX_ACPI_SIG	72
>
>The 72 isn't the specification of ACPI, right? So the number

Yes, it's from  ACPI code, include/acpi/actbl*h.
Boris said there should be a check for the num_entries,
I didn't get a good idea, so I use the max number to check it.
So do you have some advice?

Thanks,
Chao Fan

>of SIG may increase and decrease in the future.
>This macro and the check I commented above isn't needed...
>
>Thanks,
>Masa
>
>> +#else
>> +static void get_immovable_mem(void)
>> +{
>> +}
>> +#endif
>> +
>>  #define BOOT_STRING
>>  extern int kstrtoull(const char *s, unsigned int base, unsigned long long *res);
>> -- 
>> 2.19.1
>> 
>> 
>> 
>
>


