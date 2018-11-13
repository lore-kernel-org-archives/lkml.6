Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB14BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7974622507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7974622507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbeKMLya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:54:30 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:45781 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725991AbeKMLya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:54:30 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="47979662"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 Nov 2018 09:58:37 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 383024B6ED4F;
        Tue, 13 Nov 2018 09:58:37 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 09:58:41 +0800
Date:   Tue, 13 Nov 2018 09:57:30 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v11 1/5] x86/boot: Add efi_get_rsdp_addr() to dig out
 RSDP from EFI table
Message-ID: <20181113015730.GB7453@localhost.localdomain>
References: <20181112094645.4879-1-fanc.fnst@cn.fujitsu.com>
 <20181112094645.4879-2-fanc.fnst@cn.fujitsu.com>
 <20181112145433.GF8167@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181112145433.GF8167@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 383024B6ED4F.AB123
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 03:54:33PM +0100, Borislav Petkov wrote:
>On Mon, Nov 12, 2018 at 05:46:41PM +0800, Chao Fan wrote:
>> In order to parse SRAT table and get memory information, RSDP pointer
>> should be found. In kernel, there are three methods to get RSDP:
>> EFI condition, BIOS condition and KEXEC condition. The first works
>> for EFI condition.
>
>"condition"?
>
>Also, please explain shortly what all those abbreviations mean: think
>of a person reading your commit message who doesn't have any clue from
>ACPI.

I will try to improve in next version.
>
>> Imitate ACPI code and EFI code to dig RSDP pointer from EFI tables.
>> Process: boot_param->systab->efi_config_table->RSDP.
>> Based on efi_init(), efi_config_init(), efi_config_parse_tables().
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/acpitb.c | 96 +++++++++++++++++++++++++++++++
>>  1 file changed, 96 insertions(+)
>>  create mode 100644 arch/x86/boot/compressed/acpitb.c
>> 
>> diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
>> new file mode 100644
>> index 000000000000..56b54b0e0889
>> --- /dev/null
>> +++ b/arch/x86/boot/compressed/acpitb.c
>> @@ -0,0 +1,96 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#define BOOT_CTYPE_H
>> +#include "misc.h"
>> +#include "error.h"
>> +
>> +#include <linux/efi.h>
>> +#include <asm/efi.h>
>> +#include <linux/numa.h>
>> +#include <linux/acpi.h>
>> +
>> +/* Search EFI table for RSDP table. */
>> +static void efi_get_rsdp_addr(acpi_physical_address *rsdp_addr)
>
>This is just silly: the function returns void and has a single parameter
>which is an *output* parameter?!
>
>Why isn't the signature
>
>static acpi_physical_address *efi_get_rsdp_addr(void)
>
>instead?

I will change the function style.

>
>> +{
>> +#ifdef CONFIG_EFI
>> +	efi_system_table_t *systab;
>> +	bool efi_64 = false;
>
>You're setting it below already, why here too?

I will drop.

>
>> +	void *config_tables;
>> +	struct efi_info *e;
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
>> +		return;
>> +	}
>> +
>> +	/* Get systab from boot params. Based on efi_init(). */
>> +#ifdef CONFIG_X86_64
>> +	systab = (efi_system_table_t *)(
>> +			e->efi_systab | ((__u64)e->efi_systab_hi<<32));
>
>No ugly line breaks with open braces trailing like that, pls - just let
>it stick out.

Thanks for this suggestion.

>
>> +#else
>> +	if (e->efi_systab_hi || e->efi_memmap_hi) {
>> +		debug_putstr("Table located above 4GB. EFI should be disabled.\n");
>
>You need to say here what really happens here:
>
>		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
>
>The same below.

I will change all the all the same message.
>
>> +		return;
>> +	}
>> +	systab = (efi_system_table_t *)e->efi_systab;
>> +#endif
>> +
>> +	if (!systab)
>> +		return;
>> +
>> +	/*
>> +	 * Get EFI tables from systab. Based on efi_config_init() and
>> +	 * efi_config_parse_tables(). Only dig out the config_table.
>> +	 */
>> +	size = efi_64 ? sizeof(efi_config_table_64_t) :
>> +			sizeof(efi_config_table_32_t);
>> +
>> +	for (i = 0; i < systab->nr_tables; i++) {
>> +		efi_guid_t guid;
>> +		unsigned long table;
>
>Put the void *config_tables declaration here.

OK.

>
>> +
>> +		config_tables = (void *)(systab->tables + size * i);
>> +		if (efi_64) {
>> +			efi_config_table_64_t *tmp_table;
>> +
>> +			tmp_table = (efi_config_table_64_t *)config_tables;
>> +			guid = tmp_table->guid;
>> +			table = tmp_table->table;
>> +#ifndef CONFIG_64BIT
>
>Above you have CONFIG_X86_64, here CONFIG_64BIT. Please use one only.
>
>Also, use IS_ENABLED() instead.

OK.

>
>> +			if (table >> 32) {
>> +				debug_putstr("Table located above 4G. EFI should be disabled.\n");
>> +				return;
>> +			}
>> +#endif
>> +		} else {
>> +			efi_config_table_32_t *tmp_table;
>> +
>> +			tmp_table = (efi_config_table_32_t *)config_tables;
>> +			guid = tmp_table->guid;
>> +			table = tmp_table->table;
>> +		}
>> +
>> +		/*
>> +		 * Get RSDP from EFI tables.
>> +		 * If ACPI20 table found, use it.
>> +		 * If ACPI20 table not found, but ACPI table found,
>> +		 * use the ACPI table.
>> +		 */
>
>That comment is the opposite of what the code does. Also, why is that
>comment needed at all? If anything, it should say *why* ACPI_TABLE_GUID
>is preferred and then the fallback to ACPI_20_TABLE_GUID is done - not
>*what* it does. That's easily visible in the code.

I will drop the comment.

Thanks,
Chao Fan
>
>Thx.
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


