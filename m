Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7001C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3702075B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3702075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbeLNB30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:29:26 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:56048 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728433AbeLNB3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:29:23 -0500
X-IronPort-AV: E=Sophos;i="5.56,350,1539619200"; 
   d="scan'208";a="49732740"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Dec 2018 09:29:19 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 0F8E64B734CC;
        Fri, 14 Dec 2018 09:29:17 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 14 Dec 2018 09:29:16 +0800
Date:   Fri, 14 Dec 2018 09:28:51 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v13 3/6] x86/boot: Introduce efi_get_rsdp_addr() to find
 RSDP from EFI table
Message-ID: <20181214012848.GB24409@localhost.localdomain>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
 <20181212031053.1815-4-fanc.fnst@cn.fujitsu.com>
 <20181213202304.GG25287@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181213202304.GG25287@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 0F8E64B734CC.AE91B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 09:23:04PM +0100, Borislav Petkov wrote:
>On Wed, Dec 12, 2018 at 11:10:50AM +0800, Chao Fan wrote:
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
>> index cad15686f82c..c96008712ec9 100644
>> --- a/arch/x86/boot/compressed/acpi.c
>> +++ b/arch/x86/boot/compressed/acpi.c
>> @@ -28,3 +28,82 @@ static acpi_physical_address get_acpi_rsdp(void)
>>  	return 0;
>>  #endif
>>  }
>> +
>> +/* Search EFI table for RSDP. */
>> +static acpi_physical_address efi_get_rsdp_addr(void)
>> +{
>> +#ifdef CONFIG_EFI
>> +	acpi_physical_address rsdp_addr = 0;
>> +	efi_system_table_t *systab;
>> +	struct efi_info *e;
>> +	bool efi_64;
>> +	char *sig;
>> +	int size;
>> +	int i;
>> +
>> +	e = &boot_params->efi_info;
>> +	sig = (char *)&e->efi_loader_signature;
>> +
>> +	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4))
>> +		efi_64 = true;
>> +	else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4))
>> +		efi_64 = false;
>> +	else {
>> +		debug_putstr("Wrong EFI loader signature.\n");
>> +		return 0;
>> +	}
>
>Use curly braces for all three branches above.
>

OK, I will add in the first and second.

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
>> +
>> +			tmp_table = (efi_config_table_64_t *)config_tables;
>> +			guid = tmp_table->guid;
>> +			table = tmp_table->table;
>> +
>> +			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
>> +				debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
>
>Do s/system/config/ here so that this error message is different from
>the one above.

Yes, will change it.

>
>> +				return 0;
>> +			}
>> +		} else {
>> +			efi_config_table_32_t *tmp_table;
>> +
>> +			tmp_table = (efi_config_table_32_t *)config_tables;
>> +			guid = tmp_table->guid;
>> +			table = tmp_table->table;
>> +		}
>> +
>> +		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
>> +			rsdp_addr = (acpi_physical_address)table;
>> +		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
>> +			return (acpi_physical_address)table;
>> +	}
>> +	return rsdp_addr;
>> +#endif
>
>	}
>#endif
>	return rsdp_addr;
>}
>
>IOW, you have:
>
>static acpi_physical_address efi_get_rsdp_addr(void)
>{
>        acpi_physical_address rsdp_addr = 0;
>#ifdef CONFIG_EFI
>	...
>#endif
>	return rsdp_addr;
>}

Make sense. Thanks.

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


