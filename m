Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7148DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3951820859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388419AbfAPH3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 02:29:05 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55378 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfAPH3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 02:29:05 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so1590532ith.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 23:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NivkMja/MANSYVyCMoZeaCQ2ezXYfLwQtMUw7iieL44=;
        b=l0TAoEVKEGHx+F9SflU0iRKe2ak1M7yqoNhFxThhEaHJWQQaTEneGM/DyRyrhrGrEK
         sP13VSW05CZbGu5Fc+ibmGBNkuQtPkgIxjPi98UrtjeV6FhRDSjvutmHTmkwDTAzCIGb
         ykbYc/i/2bfOkKv0GUFuxJSzjRAe40gXZestuk5O/AffYbPLq2Q+Kf9yfN2uqb6Rs7+v
         uOMWLnpEIwxjw3NCRZE8vomX4WLRiCP057qPOeQg/PRfgqK0rMWJ/0gBAcUopqepECQI
         EWlf5i0wPZMXs7QRqSU4lGqndyOglBya61heDS9lYiYaH1wuIkgB0MKgd+0HQCIr2sPi
         FFlQ==
X-Gm-Message-State: AJcUukfpJZ6j77R1aFtF1Yn7xv/GwAXY1wcyE13t7H57QVCLnH3JWDzo
        chW+IsxK6eQ/d6VESBw8u74V4fE1bjun55Xx9doU8A==
X-Google-Smtp-Source: ALg8bN5/EiKV/YtPEAqpqyajbk9ZDWwPt0Oufp9jy1IPDbPi3rCY9VS/EtoZUsb9oqv5BmlTBOrCiti+/tc5XSAz5a8=
X-Received: by 2002:a24:ce42:: with SMTP id v63mr4762510itg.136.1547623743645;
 Tue, 15 Jan 2019 23:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com> <20190107032243.25324-6-fanc.fnst@cn.fujitsu.com>
In-Reply-To: <20190107032243.25324-6-fanc.fnst@cn.fujitsu.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 16 Jan 2019 15:28:52 +0800
Message-ID: <CACPcB9dO8FxpqSeG2whJGpUT7TiuiSJFWNWcF_fkRQwdRHwVcA@mail.gmail.com>
Subject: Re: [PATCH v15 5/6] x86/boot: Parse SRAT address from RSDP and store
 immovable memory
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        Baoquan He <bhe@redhat.com>, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 11:24 AM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
> +
> +/* Determine RSDP, based on acpi_os_get_root_pointer(). */
> +static acpi_physical_address get_rsdp_addr(void)
> +{
> +       acpi_physical_address pa;
> +
> +       pa = get_acpi_rsdp();
> +
> +       if (!pa)
> +               pa = efi_get_rsdp_addr();
> +
> +       if (!pa)
> +               pa = bios_get_rsdp_addr();
> +
> +       return pa;
> +}

acpi_rsdp might be provided by boot_params.acpi_rsdp_addr too,
it's introduced in ae7e1238e68f2a for Xen PVH guest and later move to
boot_params in e6e094e053af,
kexec could use it to pass RSDP to second kernel as well. Please check
it as well make sure it always works.

> +
> +/* Compute SRAT address from RSDP. */
> +static struct acpi_table_header *get_acpi_srat_table(void)
> +{
> +       acpi_physical_address acpi_table;
> +       acpi_physical_address root_table;
> +       struct acpi_table_header *header;
> +       struct acpi_table_rsdp *rsdp;
> +       u32 num_entries;
> +       char arg[10];
> +       u8 *entry;
> +       u32 size;
> +       u32 len;
> +
> +       rsdp = (struct acpi_table_rsdp *)(long)get_rsdp_addr();
> +       if (!rsdp)
> +               return NULL;
> +
> +       /* Get RSDT or XSDT from RSDP. */
> +       if (!(cmdline_find_option("acpi", arg, sizeof(arg)) == 4 &&
> +           !strncmp(arg, "rsdt", 4)) &&
> +           rsdp->xsdt_physical_address &&
> +           rsdp->revision > 1) {
> +               root_table = rsdp->xsdt_physical_address;
> +               size = ACPI_XSDT_ENTRY_SIZE;
> +       } else {
> +               root_table = rsdp->rsdt_physical_address;
> +               size = ACPI_RSDT_ENTRY_SIZE;
> +       }
> +
> +       /* Get ACPI root table from RSDT or XSDT.*/
> +       if (!root_table)
> +               return NULL;
> +       header = (struct acpi_table_header *)(long)root_table;
> +
> +       len = header->length;
> +       if (len < sizeof(struct acpi_table_header) + size)
> +               return NULL;
> +
> +       num_entries = (u32)((len - sizeof(struct acpi_table_header)) / size);
> +       entry = ACPI_ADD_PTR(u8, header, sizeof(struct acpi_table_header));
> +
> +       while (num_entries--) {
> +               u64 address64;
> +
> +               if (size == ACPI_RSDT_ENTRY_SIZE)
> +                       acpi_table =  *ACPI_CAST_PTR(u32, entry);
> +               else {
> +                       address64 = *(u64 *)entry;
> +                       acpi_table = address64;
> +               }
> +
> +               if (acpi_table) {
> +                       header = (struct acpi_table_header *)(long)acpi_table;
> +
> +                       if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_SRAT))
> +                               return header;
> +               }
> +               entry += size;
> +       }
> +       return NULL;
> +}
> +
> +/*
> + * According to ACPI table, filter the immovable memory regions
> + * and store them in immovable_mem[].
> + */
> +void get_immovable_mem(void)
> +{
> +       struct acpi_table_header *table_header;
> +       struct acpi_subtable_header *table;
> +       struct acpi_srat_mem_affinity *ma;
> +       char arg[MAX_ACPI_ARG_LENGTH];
> +       unsigned long table_end;
> +       int i = 0;
> +
> +       if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
> +           !strncmp(arg, "off", 3))
> +               return;
> +
> +       table_header = get_acpi_srat_table();
> +       if (!table_header)
> +               return;
> +
> +       table_end = (unsigned long)table_header + table_header->length;
> +       table = (struct acpi_subtable_header *)
> +               ((unsigned long)table_header + sizeof(struct acpi_table_srat));
> +
> +       while (((unsigned long)table) +
> +                      sizeof(struct acpi_subtable_header) < table_end) {
> +               if (table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
> +                       ma = (struct acpi_srat_mem_affinity *)table;
> +                       if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
> +                               immovable_mem[i].start = ma->base_address;
> +                               immovable_mem[i].size = ma->length;
> +                               i++;
> +                       }
> +
> +                       if (i >= MAX_NUMNODES*2) {
> +                               debug_putstr("Too many immovable memory regions, aborting.\n");
> +                               return;
> +                       }
> +               }
> +               table = (struct acpi_subtable_header *)
> +                       ((unsigned long)table + table->length);
> +       }
> +       num_immovable_mem = i;
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
> -       unsigned long long start;
> -       unsigned long long size;
> -};
>
>  /* Only supporting at most 4 unusable memmap regions with kaslr */
>  #define MAX_MEMMAP_REGIONS     4
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index a1d5918765f3..b49748366a5b 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -77,6 +77,11 @@ void choose_random_location(unsigned long input,
>                             unsigned long *output,
>                             unsigned long output_size,
>                             unsigned long *virt_addr);
> +struct mem_vector {
> +       unsigned long long start;
> +       unsigned long long size;
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
> +#endif
> --
> 2.20.1
>
>
>


-- 
Best Regards,
Kairui Song
