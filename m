Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B87C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE38205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfAQBRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 20:17:21 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:2205 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725864AbfAQBRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 20:17:19 -0500
X-IronPort-AV: E=Sophos;i="5.56,488,1539619200"; 
   d="scan'208";a="52178838"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Jan 2019 09:17:17 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id AC6BF4BAD9C3;
        Thu, 17 Jan 2019 09:17:16 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 17 Jan 2019 09:17:23 +0800
Date:   Thu, 17 Jan 2019 09:16:22 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v15 5/6] x86/boot: Parse SRAT address from RSDP and store
 immovable memory
Message-ID: <20190117011621.GD30900@localhost.localdomain>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-6-fanc.fnst@cn.fujitsu.com>
 <20190116110158.GC15409@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190116110158.GC15409@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: AC6BF4BAD9C3.A112A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 12:01:58PM +0100, Borislav Petkov wrote:
>On Mon, Jan 07, 2019 at 11:22:42AM +0800, Chao Fan wrote:
[...]
>> +	rsdp = (struct acpi_table_rsdp *)(long)get_rsdp_addr();
>> +	if (!rsdp)
>> +		return NULL;
>> +
>> +	/* Get RSDT or XSDT from RSDP. */
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
>
>This comment is wrong here - should be above.

I will change the comment
>
>> +	if (!root_table)
>> +		return NULL;
>
><---- newline here.

Will add
>
>> +	header = (struct acpi_table_header *)(long)root_table;
>> +
>> +	len = header->length;
>> +	if (len < sizeof(struct acpi_table_header) + size)
>> +		return NULL;
>> +
>> +	num_entries = (u32)((len - sizeof(struct acpi_table_header)) / size);
>> +	entry = ACPI_ADD_PTR(u8, header, sizeof(struct acpi_table_header));
>> +
>> +	while (num_entries--) {
>> +		u64 address64;
>> +
>> +		if (size == ACPI_RSDT_ENTRY_SIZE)
>> +			acpi_table =  *ACPI_CAST_PTR(u32, entry);
>> +		else {
>> +			address64 = *(u64 *)entry;
>> +			acpi_table = address64;
>
>The same thing as in the previous patch - get rid of address64.

Got it.
>
>> +		}
>> +
>> +		if (acpi_table) {
>> +			header = (struct acpi_table_header *)(long)acpi_table;
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
>> +	char arg[MAX_ACPI_ARG_LENGTH];
>> +	unsigned long table_end;
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
>
>That's a lot of unnecessary casting AFAICT. You can return an unsigned
>long from get_acpi_srat_table() and get rid of all that casting here.

I will clean the type casting
>
>
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
>> index a1d5918765f3..b49748366a5b 100644
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
>> @@ -116,3 +121,17 @@ static inline void console_init(void)
>>  void set_sev_encryption_mask(void);
>>  
>>  #endif
>> +
>> +/* acpi.c */
>> +#ifdef CONFIG_RANDOMIZE_BASE
>> +/* Amount of immovable memory regions */
>> +int num_immovable_mem;
>> +#endif
>> +
>> +#ifdef CONFIG_EARLY_SRAT_PARSE
>> +void get_immovable_mem(void);
>> +#else
>> +static void get_immovable_mem(void)
>> +{
>> +}
>
>Put those on a single line:
>
>static void get_immovable_mem(void) {}

OK.

Thanks,
Chao Fan

>
>> +#endif
>> -- 
>> 2.20.1
>> 
>> 
>> 
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


