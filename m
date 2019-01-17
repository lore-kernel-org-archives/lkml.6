Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA247C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843E420866
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfAQH6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:58:30 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:25148 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727426AbfAQH6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:58:30 -0500
X-IronPort-AV: E=Sophos;i="5.56,488,1539619200"; 
   d="scan'208";a="52205163"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Jan 2019 15:58:28 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 98EE24C47E61;
        Thu, 17 Jan 2019 15:58:24 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 17 Jan 2019 15:58:31 +0800
Date:   Thu, 17 Jan 2019 15:57:30 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Kairui Song <kasong@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <keescook@chromium.org>,
        Baoquan He <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v15 5/6] x86/boot: Parse SRAT address from RSDP and store
 immovable memory
Message-ID: <20190117075729.GC31097@localhost.localdomain>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-6-fanc.fnst@cn.fujitsu.com>
 <CACPcB9dO8FxpqSeG2whJGpUT7TiuiSJFWNWcF_fkRQwdRHwVcA@mail.gmail.com>
 <20190117062451.GA588@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190117062451.GA588@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 98EE24C47E61.ACFD1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 03:28:52PM +0800, Kairui Song wrote:
>On Mon, Jan 7, 2019 at 11:24 AM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>>
>> +
>> +/* Determine RSDP, based on acpi_os_get_root_pointer(). */
>> +static acpi_physical_address get_rsdp_addr(void)
>> +{
>> +       acpi_physical_address pa;
>> +
>> +       pa = get_acpi_rsdp();
>> +
>> +       if (!pa)
>> +               pa = efi_get_rsdp_addr();
>> +
>> +       if (!pa)
>> +               pa = bios_get_rsdp_addr();
>> +
>> +       return pa;
>> +}
>
>acpi_rsdp might be provided by boot_params.acpi_rsdp_addr too,
>it's introduced in ae7e1238e68f2a for Xen PVH guest and later move to
>boot_params in e6e094e053af,
>kexec could use it to pass RSDP to second kernel as well. Please check
>it as well make sure it always works.
>

Hi Kairui,

I saw the parsing code has been added to kernel, but I didn't see
where to fill in the 'acpi_rsdp_addr'. If only you(KEXEC) use it,
I can add "#ifdef CONFIG_KEXEC", but you said Xen will use it also,
so I didn't add ifdef to control it. I was trying to do as below:

static inline acpi_physical_address get_boot_params_rsdp(void)
{
        return boot_params->acpi_rsdp_addr;
}

static acpi_physical_address get_rsdp_addr(void)
{
	bool boot_params_rsdp_exist;
        acpi_physical_address pa;

        pa = get_acpi_rsdp();

        if (!pa)
                pa = get_boot_params_rsdp();

        if (!pa) {
                pa = efi_get_rsdp_addr();
		boot_params_rsdp_exist = false;
	}
	else
		boot_params_rsdp_exist = true;

        if (!pa)
                pa = bios_get_rsdp_addr();

	if (pa && !boot_params_rsdp_exist)
		boot_params.acpi_rsdp_addr = pa;

        return pa;
}

At the same time, I notice kernel only parses it when
"#ifdef CONFIG_ACPI", we should keep sync with kernel, but I think
we are parsing SRAT, CONFIG_ACPI is needed sure, so I am going to
update the define of EARLY_SRAT_PARSE:

config EARLY_SRAT_PARSE
        bool "EARLY SRAT parsing"
        def_bool y
        depends on RANDOMIZE_BASE && MEMORY_HOTREMOVE && ACPI

Boris, how do you think the update for the new acpi_rsdp_addr?
If I misunderstand something, please let me know.

Thanks,
Chao Fan

>> +
>> +/* Compute SRAT address from RSDP. */
>> +static struct acpi_table_header *get_acpi_srat_table(void)
>> +{
>> +       acpi_physical_address acpi_table;
>> +       acpi_physical_address root_table;
>> +       struct acpi_table_header *header;
>> +       struct acpi_table_rsdp *rsdp;
>> +       u32 num_entries;
>> +       char arg[10];
>> +       u8 *entry;
>> +       u32 size;
>> +       u32 len;
>> +
>> +       rsdp = (struct acpi_table_rsdp *)(long)get_rsdp_addr();
>> +       if (!rsdp)
>> +               return NULL;
>> +
>> +       /* Get RSDT or XSDT from RSDP. */
>> +       if (!(cmdline_find_option("acpi", arg, sizeof(arg)) == 4 &&
>> +           !strncmp(arg, "rsdt", 4)) &&
>> +           rsdp->xsdt_physical_address &&
>> +           rsdp->revision > 1) {
>> +               root_table = rsdp->xsdt_physical_address;
>> +               size = ACPI_XSDT_ENTRY_SIZE;
>> +       } else {
>> +               root_table = rsdp->rsdt_physical_address;
>> +               size = ACPI_RSDT_ENTRY_SIZE;
>> +       }
>> +
>> +       /* Get ACPI root table from RSDT or XSDT.*/
>> +       if (!root_table)
>> +               return NULL;
>> +       header = (struct acpi_table_header *)(long)root_table;
>> +
>> +       len = header->length;
>> +       if (len < sizeof(struct acpi_table_header) + size)
>> +               return NULL;
>> +
>> +       num_entries = (u32)((len - sizeof(struct acpi_table_header)) / size);
>> +       entry = ACPI_ADD_PTR(u8, header, sizeof(struct acpi_table_header));
>> +
>> +       while (num_entries--) {
>> +               u64 address64;
>> +
>> +               if (size == ACPI_RSDT_ENTRY_SIZE)
>> +                       acpi_table =  *ACPI_CAST_PTR(u32, entry);
>> +               else {
>> +                       address64 = *(u64 *)entry;
>> +                       acpi_table = address64;
>> +               }
>> +
>> +               if (acpi_table) {
>> +                       header = (struct acpi_table_header *)(long)acpi_table;
>> +
>> +                       if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_SRAT))
>> +                               return header;
>> +               }
>> +               entry += size;
>> +       }
>> +       return NULL;
>> +}
>> +
>> +/*
>> + * According to ACPI table, filter the immovable memory regions
>> + * and store them in immovable_mem[].
>> + */
>> +void get_immovable_mem(void)
>> +{
>> +       struct acpi_table_header *table_header;
>> +       struct acpi_subtable_header *table;
>> +       struct acpi_srat_mem_affinity *ma;
>> +       char arg[MAX_ACPI_ARG_LENGTH];
>> +       unsigned long table_end;
>> +       int i = 0;
>> +
>> +       if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
>> +           !strncmp(arg, "off", 3))
>> +               return;
>> +
>> +       table_header = get_acpi_srat_table();
>> +       if (!table_header)
>> +               return;
>> +
>> +       table_end = (unsigned long)table_header + table_header->length;
>> +       table = (struct acpi_subtable_header *)
>> +               ((unsigned long)table_header + sizeof(struct acpi_table_srat));
>> +
>> +       while (((unsigned long)table) +
>> +                      sizeof(struct acpi_subtable_header) < table_end) {
>> +               if (table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
>> +                       ma = (struct acpi_srat_mem_affinity *)table;
>> +                       if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
>> +                               immovable_mem[i].start = ma->base_address;
>> +                               immovable_mem[i].size = ma->length;
>> +                               i++;
>> +                       }
>> +
>> +                       if (i >= MAX_NUMNODES*2) {
>> +                               debug_putstr("Too many immovable memory regions, aborting.\n");
>> +                               return;
>> +                       }
>> +               }
>> +               table = (struct acpi_subtable_header *)
>> +                       ((unsigned long)table + table->length);
>> +       }
>> +       num_immovable_mem = i;
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
>> -       unsigned long long start;
>> -       unsigned long long size;
>> -};
>>
>>  /* Only supporting at most 4 unusable memmap regions with kaslr */
>>  #define MAX_MEMMAP_REGIONS     4
>> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
>> index a1d5918765f3..b49748366a5b 100644
>> --- a/arch/x86/boot/compressed/misc.h
>> +++ b/arch/x86/boot/compressed/misc.h
>> @@ -77,6 +77,11 @@ void choose_random_location(unsigned long input,
>>                             unsigned long *output,
>>                             unsigned long output_size,
>>                             unsigned long *virt_addr);
>> +struct mem_vector {
>> +       unsigned long long start;
>> +       unsigned long long size;
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
>> +#endif
>> --
>> 2.20.1
>>
>>
>>
>
>
>-- 
>Best Regards,
>Kairui Song
>
>


