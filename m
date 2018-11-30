Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28F3C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514BA2081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514BA2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeK3NhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:37:11 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35406 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726161AbeK3NhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 08:37:11 -0500
X-IronPort-AV: E=Sophos;i="5.56,297,1539619200"; 
   d="scan'208";a="48852784"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Nov 2018 10:29:29 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 11F114B734C6;
        Fri, 30 Nov 2018 10:29:29 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 30 Nov 2018 10:29:30 +0800
Date:   Fri, 30 Nov 2018 10:29:14 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v12 1/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdline from KEXEC
Message-ID: <20181130022914.GA30941@localhost.localdomain>
References: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
 <20181129081631.11139-2-fanc.fnst@cn.fujitsu.com>
 <20181129162012.hcknuu256trdwnfc@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181129162012.hcknuu256trdwnfc@gabell>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 11F114B734C6.AB9DF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 11:20:13AM -0500, Masayoshi Mizuma wrote:
>On Thu, Nov 29, 2018 at 04:16:27PM +0800, Chao Fan wrote:
>> To fix the conflict between KASLR and memory-hotremove, memory
>> information in SRAT table is necessary.
>> 
>> ACPI SRAT (System/Static Resource Affinity Table) can show the details
>> about memory ranges, including ranges of memory provided by hot-added
>> memory devices. SRAT table must be introduced by RSDP pointer (Root
>> System Description Pointer). So RSDP should be found firstly.
>> 
>> When booting form KEXEC/EFI/BIOS, the methods to find RSDP pointer
>> are different. When booting from KEXEC, 'acpi_rsdp' may have been
>> added to cmdline, so parse the cmdline and find the RSDP pointer.
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/acpitb.c | 33 +++++++++++++++++++++++++++++++
>>  arch/x86/boot/compressed/misc.c   |  5 +++++
>>  arch/x86/boot/compressed/misc.h   |  4 ++++
>>  lib/kstrtox.c                     |  5 +++++
>>  4 files changed, 47 insertions(+)
>>  create mode 100644 arch/x86/boot/compressed/acpitb.c
>> 
>> diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
>> new file mode 100644
>> index 000000000000..614c45655cff
>> --- /dev/null
>> +++ b/arch/x86/boot/compressed/acpitb.c
>> @@ -0,0 +1,33 @@
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
>> +#define STATIC
>> +#include <linux/decompress/mm.h>
>> +
>> +/* Store the immovable memory regions. */
>> +struct mem_vector immovable_mem[MAX_NUMNODES*2];
>> +#endif
>> +
>> +static acpi_physical_address get_acpi_rsdp(void)
>> +{
>> +#ifdef CONFIG_KEXEC
>> +	unsigned long long res;
>> +	int len = 0;
>
>> +	char *val;
>> +
>> +	val = malloc(19);
>> +	len = cmdline_find_option("acpi_rsdp", val, 19);
>> +	if (len > 0) {
>> +		val[len] = 0;
>
>		val[len] = '\0';
>
>> +		return (acpi_physical_address)kstrtoull(val, 16, &res);
>> +	}
>
>I think free() is needed. Or why don't you use stack?

Oh, thanks, will change it
char val[19];

Thanks,
Chao Fan
>
>	char val[19];
>
>	len = cmdline_find_option("acpi_rsdp", val, sizeof(val));
>	if (len > 0) {
>		val[len] = '\0';
>		return (acpi_physical_address)kstrtoull(val, 16, &res);
>	}
>
>Thanks,
>Masa
>
>> +	return 0;
>> +#endif
>> +}
>> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
>> index 8dd1d5ccae58..e51713fe3add 100644
>> --- a/arch/x86/boot/compressed/misc.c
>> +++ b/arch/x86/boot/compressed/misc.c
>> @@ -12,6 +12,7 @@
>>   * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
>>   */
>>  
>> +#define BOOT_CTYPE_H
>>  #include "misc.h"
>>  #include "error.h"
>>  #include "pgtable.h"
>> @@ -426,3 +427,7 @@ void fortify_panic(const char *name)
>>  {
>>  	error("detected buffer overflow");
>>  }
>> +
>> +#ifdef BOOT_STRING
>> +#include "../../../../lib/kstrtox.c"
>> +#endif
>> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
>> index a1d5918765f3..809c31effa4b 100644
>> --- a/arch/x86/boot/compressed/misc.h
>> +++ b/arch/x86/boot/compressed/misc.h
>> @@ -116,3 +116,7 @@ static inline void console_init(void)
>>  void set_sev_encryption_mask(void);
>>  
>>  #endif
>> +
>> +/* acpitb.c */
>> +#define BOOT_STRING
>> +extern int kstrtoull(const char *s, unsigned int base, unsigned long long *res);
>> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
>> index 1006bf70bf74..a0ac1b2257b8 100644
>> --- a/lib/kstrtox.c
>> +++ b/lib/kstrtox.c
>> @@ -126,6 +126,9 @@ int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>>  }
>>  EXPORT_SYMBOL(kstrtoull);
>>  
>> +/* Make compressed period code be able to use kstrtoull(). */
>> +#ifndef BOOT_STRING
>> +
>>  /**
>>   * kstrtoll - convert a string to a long long
>>   * @s: The start of the string. The string must be null-terminated, and may also
>> @@ -408,3 +411,5 @@ kstrto_from_user(kstrtou16_from_user,	kstrtou16,	u16);
>>  kstrto_from_user(kstrtos16_from_user,	kstrtos16,	s16);
>>  kstrto_from_user(kstrtou8_from_user,	kstrtou8,	u8);
>>  kstrto_from_user(kstrtos8_from_user,	kstrtos8,	s8);
>> +
>> +#endif /* BOOT_STRING */
>> -- 
>> 2.19.1
>> 
>> 
>> 
>
>


