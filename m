Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4570C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EDE20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfAKBYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:24:51 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:15592 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726369AbfAKBYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:24:51 -0500
X-IronPort-AV: E=Sophos;i="5.56,463,1539619200"; 
   d="scan'208";a="51752292"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Jan 2019 09:24:49 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 5C2A14BAD7CC;
        Fri, 11 Jan 2019 09:24:49 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 11 Jan 2019 09:24:48 +0800
Date:   Fri, 11 Jan 2019 09:23:53 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v15 3/6] x86/boot: Introduce efi_get_rsdp_addr() to find
 RSDP from EFI table
Message-ID: <20190111012353.GD2216@localhost.localdomain>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-4-fanc.fnst@cn.fujitsu.com>
 <20190110211523.GG17621@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190110211523.GG17621@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 5C2A14BAD7CC.A08FF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:15:23PM +0100, Borislav Petkov wrote:
>On Mon, Jan 07, 2019 at 11:22:40AM +0800, Chao Fan wrote:
>> Memory information in SRAT is necessary to fix the conflict between
>> KASLR and memory-hotremove. So RSDP and SRAT should be parsed.
>> 
>> When booting form KEXEC/EFI/BIOS, the methods to compute RSDP
>> are different. When booting from EFI, EFI table points to RSDP.
>> So parse the EFI table and find the RSDP.
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/acpi.c | 83 +++++++++++++++++++++++++++++++++
>>  1 file changed, 83 insertions(+)
>> 
>> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
>> index 7ca5001d7639..f74c5d033d79 100644
>> --- a/arch/x86/boot/compressed/acpi.c
>> +++ b/arch/x86/boot/compressed/acpi.c
>> @@ -5,6 +5,8 @@
>>  #include "../string.h"
>>  
>>  #include <linux/acpi.h>
>> +#include <linux/efi.h>
>> +#include <asm/efi.h>
>>  
>>  /*
>>   * Max length of 64-bit hex address string is 19, prefix "0x" + 16 hex
>> @@ -28,3 +30,84 @@ static acpi_physical_address get_acpi_rsdp(void)
>>  #endif
>>  	return 0;
>>  }
>> +
>> +/* Search EFI table for RSDP. */
>> +static acpi_physical_address efi_get_rsdp_addr(void)
>> +{
>> +	acpi_physical_address rsdp_addr = 0;
>
>
><---- newline here.
>

Will add it.

>> +#ifdef CONFIG_EFI
>> +	efi_system_table_t *systab;
>> +	struct efi_info *ei;
>> +	bool efi_64;
>> +	char *sig;
>> +	int size;
>> +	int i;
>> +
>> +	ei = &boot_params->efi_info;
>> +	sig = (char *)&ei->efi_loader_signature;
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
>> +	systab = (efi_system_table_t *)(ei->efi_systab | ((__u64)ei->efi_systab_hi<<32));
>> +#else
>> +	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
>> +		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
>> +		return 0;
>> +	}
>> +	systab = (efi_system_table_t *)ei->efi_systab;
>> +#endif
>> +
>> +	if (!systab)
>> +		error("EFI system table is not found.");
>
>s/is//

Will drop the 'is'.

>
>> +
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
>> +			u64 table64;
>> +
>> +			tmp_table = config_tables;
>> +			guid = tmp_table->guid;
>> +			table64 = tmp_table->table;
>> +			table = table64;
>
>That table64 looks superfluous.

Yes, 'table64' looks superfluous here, but after these lines, there is:
                        if (!IS_ENABLED(CONFIG_X86_64) && table64 >> 32) {
so the 'table64' is useful here for i386. 'table' is unsigned long, it
can't do the right shift. But the 'table64' who is u64 can do that right
shift.

Thanks,
Chao Fan

>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


