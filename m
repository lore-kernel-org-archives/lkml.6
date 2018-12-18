Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA29C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E52214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbeLRBpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 20:45:55 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:3653 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726285AbeLRBpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 20:45:55 -0500
X-IronPort-AV: E=Sophos;i="5.56,367,1539619200"; 
   d="scan'208";a="50022410"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Dec 2018 09:45:52 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id AA0504B75BD3;
        Tue, 18 Dec 2018 09:45:49 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 18 Dec 2018 09:45:55 +0800
Date:   Tue, 18 Dec 2018 09:45:26 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v14 2/5] x86/boot: Introduce efi_get_rsdp_addr() to find
 RSDP from EFI table
Message-ID: <20181218014526.GC31775@localhost.localdomain>
References: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
 <20181214093013.13370-3-fanc.fnst@cn.fujitsu.com>
 <20181217173032.GB90818@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181217173032.GB90818@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: AA0504B75BD3.AE4BF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 06:30:32PM +0100, Ingo Molnar wrote:
>
>* Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
>> Memory information in SRAT is necessary to fix the conflict between
>> KASLR and memory-hotremove. So RSDP and SRAT should be parsed.
>> 
>> When booting form KEXEC/EFI/BIOS, the methods to compute RSDP
>> are different. When booting from EFI, EFI table points to RSDP.
>> So parse the EFI table and find the RSDP.
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/acpi.c | 79 +++++++++++++++++++++++++++++++++
>>  1 file changed, 79 insertions(+)
>> 
>> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
>> index 44f19546c169..4151881d8713 100644
>> --- a/arch/x86/boot/compressed/acpi.c
>> +++ b/arch/x86/boot/compressed/acpi.c
>> @@ -28,3 +28,82 @@ static acpi_physical_address get_acpi_rsdp(void)
>>  #endif
>>  	return 0;
>>  }
>> +
>> +/* Search EFI table for RSDP. */
>> +static acpi_physical_address efi_get_rsdp_addr(void)
>> +{
>> +	acpi_physical_address rsdp_addr = 0;
>> +#ifdef CONFIG_EFI
>> +	efi_system_table_t *systab;
>> +	struct efi_info *e;
>
>'e' is pretty meaningless, the canonical name for efi_info local 
>variables is typically 'ei' (although this is not consistent across the 
>code).

OK, will change it.
>
>> +	bool efi_64;
>
>Is this a flag that shows whether the EFI loader is 64-bit?

Yes, I use the signature to decide the size of EFI table.
It's used here:
+	size = efi_64 ? sizeof(efi_config_table_64_t) :
+			sizeof(efi_config_table_32_t);

>
>> +	char *sig;
>> +	int size;
>> +	int i;
>> +
>> +	e = &boot_params->efi_info;
>> +	sig = (char *)&e->efi_loader_signature;
>> +
>> +	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
>> +		efi_64 = true;
>> +	} else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4)) {
>> +		efi_64 = false;
>> +	} else {
>> +		debug_putstr("Wrong EFI loader signature.\n");
>> +		return 0;
>> +	}
>> +
>> +	/* Get systab from boot params. Based on efi_init(). */
>> +#ifdef CONFIG_X86_64
>> +	systab = (efi_system_table_t *)(e->efi_systab | ((__u64)e->efi_systab_hi<<32));
>> +#else
>> +	if (e->efi_systab_hi || e->efi_memmap_hi) {
>> +		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
>> +		return 0;
>> +	}
>> +	systab = (efi_system_table_t *)e->efi_systab;
>> +#endif
>> +
>> +	if (!systab)
>> +		return 0;
>
>Is it normal that EFI provides no 'systab'?

I think not normal, to make sure the code run normally.
We will use it below like: i < systab->nr_tables, if
systab is wrong, the code will fail to work.

>
>> +	/*
>> +	 * Get EFI tables from systab. Based on efi_config_init() and
>> +	 * efi_config_parse_tables().
>> +	 */
>> +	size = efi_64 ? sizeof(efi_config_table_64_t) :
>> +			sizeof(efi_config_table_32_t);
>> +
>> +	for (i = 0; i < systab->nr_tables; i++) {
>> +		void *config_tables;
>> +		unsigned long table;
>> +		efi_guid_t guid;
>> +
>> +		config_tables = (void *)(systab->tables + size * i);
>> +		if (efi_64) {
>> +			efi_config_table_64_t *tmp_table;
>> +
>> +			tmp_table = (efi_config_table_64_t *)config_tables;
>
>Since 'config_tables' is a void * there's no need to cast the type.
>
>> +			guid = tmp_table->guid;
>> +			table = tmp_table->table;
>> +
>> +			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
>> +				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
>> +				return 0;
>> +			}
>> +		} else {
>> +			efi_config_table_32_t *tmp_table;
>> +
>> +			tmp_table = (efi_config_table_32_t *)config_tables;
>
>Ditto.
>
>> +			guid = tmp_table->guid;
>> +			table = tmp_table->table;
>> +		}
>
>So it looks like 
>
>> +
>> +		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
>> +			rsdp_addr = (acpi_physical_address)table;
>> +		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
>> +			return (acpi_physical_address)table;
>
>'return' is not a function.

Got it, will clean the type cast.

Thanks,
Chao Fan

>
>Thanks,
>
>	Ingo
>
>


