Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F913C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAB62075B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAB62075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbeLNBbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:31:36 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:27661 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727654AbeLNBbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:31:36 -0500
X-IronPort-AV: E=Sophos;i="5.56,350,1539619200"; 
   d="scan'208";a="49732894"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Dec 2018 09:31:34 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 7947B4B734CC;
        Fri, 14 Dec 2018 09:31:30 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 14 Dec 2018 09:31:29 +0800
Date:   Fri, 14 Dec 2018 09:31:05 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v13 2/6] x86/boot: Introduce get_acpi_rsdp() to parse
 RSDP in cmdline from KEXEC
Message-ID: <20181214013105.GC24409@localhost.localdomain>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
 <20181212031053.1815-3-fanc.fnst@cn.fujitsu.com>
 <20181213194230.GF25287@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181213194230.GF25287@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 7947B4B734CC.ABAB5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:42:30PM +0100, Borislav Petkov wrote:
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
>
>That should be EARLY_SRAT_PARSE or so
>
>> +	bool "Parse RSDP pointer on compressed period for KASLR"
>
>and that should be
>
>	bool "Early SRAT table parsing"
>
>> +	def_bool y
>> +	depends on RANDOMIZE_BASE && MEMORY_HOTREMOVE
>> +	help
>> +	  This option parses RSDP in compressed period. Works
>
>do s/compressed period/compressed stage/g
>
>I think "compressed stage" or "compressed boot stage" is more precise.
>
>> +	  for KASLR to get memory information from SRAT table and choose
>> +	  immovable memory to extract kernel.
>> +	  Say Y if you want to use both KASLR and memory-hotremove.
>
>This help text needs to explain what the functionality is for. "This
>option parses RSDP in compressed period" doesn't tell a whole lot to the
>normal user wondering whether she should enable this or not. You need to
>explain whether people would need this or not so should start along the
>lines of:
>
>"This option enables early SRAT parsing so that memory hot remove ranges do not
>overlap with KASLR chosen ranges..."
>
>Basically, the "***Background" in your 0th message.
>

Thanks, I will rewrite this part.

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
>
>Please sort function local variables declaration in a reverse christmas
>tree order:
>
>	<type A> longest_variable_name;
>	<type B> shorter_var_name;
>	<type C> even_shorter;
>	<type D> i;

I will change the position and check other places like this.

>
>> +
>> +	len = cmdline_find_option("acpi_rsdp", val, MAX_ADDRESS_LENGTH+1);
>
>That MAX_ADDRESS_LENGTH define is used only here, right? So put it at
>the top in this file - no need to have it in a header.
>
>> +	if (len > 0) {
>> +		val[len] = 0;
>> +		return (acpi_physical_address)kstrtoull(val, 16, &res);
>> +	}
>> +	return 0;
>> +#endif
>
>Those two lines need to be the other way around:
>
>#endif
>	return 0;
>
>because in the !CONFIG_KEXEC case that function won't return anything.
>gcc is smart enough to optimize that function away so that there's no
>build error but still.
>
>Ditto for efi_get_rsdp_addr() in your next patch.

Yes, I will change all places like this.

Thanks,
Chao Fan

>
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
>
>Yeah, just put that define in acpi.c.
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


