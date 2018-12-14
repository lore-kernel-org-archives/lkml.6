Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF75C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CE42075B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CE42075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbeLNBc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:32:57 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:21862 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727654AbeLNBc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:32:56 -0500
X-IronPort-AV: E=Sophos;i="5.56,350,1539619200"; 
   d="scan'208";a="49732996"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Dec 2018 09:32:54 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id C1E5C4B7349D;
        Fri, 14 Dec 2018 09:32:50 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 14 Dec 2018 09:32:49 +0800
Date:   Fri, 14 Dec 2018 09:32:25 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v13 2/6] x86/boot: Introduce get_acpi_rsdp() to parse
 RSDP in cmdline from KEXEC
Message-ID: <20181214013225.GD24409@localhost.localdomain>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
 <20181212031053.1815-3-fanc.fnst@cn.fujitsu.com>
 <20181213192529.yjklliaxy4tk4kck@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181213192529.yjklliaxy4tk4kck@gabell>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: C1E5C4B7349D.ACF58
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 02:25:30PM -0500, Masayoshi Mizuma wrote:
>Hi Chao,
>
>Great work! Let me say some trivial comments.

Thanks for your help, any comments will be welcome.

>
>On Wed, Dec 12, 2018 at 11:10:49AM +0800, Chao Fan wrote:
>> Memory information in SRAT is necessary to fix the conflict between
>> KASLR and memory-hotremove.
>> 
>> ACPI SRAT (System/Static Resource Affinity Table) shows the details
>> about memory ranges, including ranges of memory provided by hot-added
>> memory devices. SRAT is introduced by Root System Description
>> Pointer(RSDP). So RSDP should be found firstly.
>> 
>> When booting form KEXEC/EFI/BIOS, the methods to find RSDP
>> are different. When booting from KEXEC, 'acpi_rsdp' may have been
>> added to cmdline, so parse cmdline to find RSDP.
>> 
>> Since 'RANDOMIZE_BASE' && 'MEMORY_HOTREMOVE' is needed, introduce
>> 'CONFIG_EARLY_PARSE_RSDP' to make ifdeffery clear.
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/Kconfig                | 10 ++++++++++
>>  arch/x86/boot/compressed/acpi.c | 30 ++++++++++++++++++++++++++++++
>>  arch/x86/boot/compressed/misc.h |  6 ++++++
>>  3 files changed, 46 insertions(+)
>>  create mode 100644 arch/x86/boot/compressed/acpi.c
>> 
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index ba7e3464ee92..455da382fa9e 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2149,6 +2149,16 @@ config X86_NEED_RELOCS
>>  	def_bool y
>>  	depends on RANDOMIZE_BASE || (X86_32 && RELOCATABLE)
>>  
>> +config EARLY_PARSE_RSDP
>> +	bool "Parse RSDP pointer on compressed period for KASLR"
>> +	def_bool y
>> +	depends on RANDOMIZE_BASE && MEMORY_HOTREMOVE
>> +	help
>> +	  This option parses RSDP in compressed period. Works
>> +	  for KASLR to get memory information from SRAT table and choose
>> +	  immovable memory to extract kernel.
>> +	  Say Y if you want to use both KASLR and memory-hotremove.
>> +
>>  config PHYSICAL_ALIGN
>>  	hex "Alignment value to which kernel should be aligned"
>>  	default "0x200000"
>> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
>> new file mode 100644
>> index 000000000000..cad15686f82c
>> --- /dev/null
>> +++ b/arch/x86/boot/compressed/acpi.c
>> @@ -0,0 +1,30 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#define BOOT_CTYPE_H
>> +#include "misc.h"
>> +#include "error.h"
>> +
>> +#include <linux/efi.h>
>> +#include <linux/numa.h>
>> +#include <linux/acpi.h>
>> +#include <asm/efi.h>
>> +
>> +#define STATIC
>> +#include <linux/decompress/mm.h>
>> +
>> +#include "../string.h"
>> +
>> +static acpi_physical_address get_acpi_rsdp(void)
>> +{
>> +#ifdef CONFIG_KEXEC
>> +	unsigned long long res;
>> +	int len = 0;
>> +	char val[MAX_ADDRESS_LENGTH+1];
>> +
>
>> +	len = cmdline_find_option("acpi_rsdp", val, MAX_ADDRESS_LENGTH+1);
>
>sizeof() is better here.
>
>	len = cmdline_find_option("acpi_rsdp", val, sizeof(var));
>
>> +	if (len > 0) {
>> +		val[len] = 0;
>
>'\0' should be fine here not 0.
>
>		val[len] = '\0';
Will change it.

Thanks,
Chao Fan
>
>> +		return (acpi_physical_address)kstrtoull(val, 16, &res);
>> +	}
>> +	return 0;
>> +#endif
>> +}
>> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
>> index a1d5918765f3..72fcfbfec3c6 100644
>> --- a/arch/x86/boot/compressed/misc.h
>> +++ b/arch/x86/boot/compressed/misc.h
>> @@ -116,3 +116,9 @@ static inline void console_init(void)
>>  void set_sev_encryption_mask(void);
>>  
>>  #endif
>> +
>> +/* acpi.c */
>> +#ifdef CONFIG_EARLY_PARSE_RSDP
>> +/* Max length of 64-bit hex address string is 18, prefix "0x" + 16 hex digit. */
>> +#define MAX_ADDRESS_LENGTH 18
>> +#endif
>> -- 
>> 2.19.2
>> 
>> 
>
>


