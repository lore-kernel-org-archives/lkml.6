Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE31C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2362245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2362245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbeKMMJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 07:09:11 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:65172 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726198AbeKMMJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 07:09:11 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="47980739"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 Nov 2018 10:13:16 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 1E2684B6EC92;
        Tue, 13 Nov 2018 10:13:16 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 10:13:21 +0800
Date:   Tue, 13 Nov 2018 10:12:18 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <keescook@chromium.org>, <bhe@redhat.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v11 3/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdlien from kexec
Message-ID: <20181113021218.GD7453@localhost.localdomain>
References: <20181112094645.4879-1-fanc.fnst@cn.fujitsu.com>
 <20181112094645.4879-4-fanc.fnst@cn.fujitsu.com>
 <20181112174343.mvjri2okwboew2nw@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181112174343.mvjri2okwboew2nw@gabell>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 1E2684B6EC92.ACB7B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 12:43:44PM -0500, Masayoshi Mizuma wrote:
>Hi Chao,
>
>On Mon, Nov 12, 2018 at 05:46:43PM +0800, Chao Fan wrote:
>> Imitate setup_acpi_rsdp() for the early_param of 'acpi_rsdp'.
>> KEXEC writes the RSDP pointer to cmdline for EFI booting.
>> So if 'acpi_rsdp' found in cmdline, use it directely.
>> 
>
>> Since function kstrtoull() is needed, include it in
>> arch/x86/boot/string.h. To solve the definition conflict
>> problem, set BOOT_STRING tag to expose only kstrtoull() and
>> functions used by it. Other functions in lib/kstrtox.c will
>> be covered.
>
>How about the following get_acpi_rsdp()...? It doesn't use kstrtoull().
>
>static void get_acpi_rsdp(acpi_physical_address *rsdp_addr)
>{
>#ifdef CONFIG_KEXEC
>        unsigned long addr;
>        char val[32];
>
>        if (cmdline_find_option("acpi_rsdp", val, sizeof(val)) > 0) {
>                char *e;
>
>                if (!strncmp(val, "0x", 2)) {
>                        addr = simple_strtoull(val + 2, &e, 16);
>                        if ((addr == 0) || ((val + 2) == e))
>                                return;
>                        *rsdp_addr = (acpi_physical_address)addr;
>                }
>        }
>#endif
>}

Thanks for the suggestion.
I used this function. In the old version, Boris said simple_strtoull()
is the old function and told me use the new kstrtoull().

Thanks,
Chao Fan

>
>Thanks,
>Masa
>
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/acpitb.c | 26 ++++++++++++++++++++++++++
>>  arch/x86/boot/string.h            |  4 ++++
>>  lib/kstrtox.c                     |  4 ++++
>>  3 files changed, 34 insertions(+)
>> 
>> diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
>> index 50fa65cf824d..5cfb4efa5a19 100644
>> --- a/arch/x86/boot/compressed/acpitb.c
>> +++ b/arch/x86/boot/compressed/acpitb.c
>> @@ -8,6 +8,12 @@
>>  #include <linux/numa.h>
>>  #include <linux/acpi.h>
>>  
>> +#define STATIC
>> +#include <linux/decompress/mm.h>
>> +
>> +#define BOOT_STRING
>> +#include "../string.h"
>> +
>>  /* Search EFI table for RSDP table. */
>>  static void efi_get_rsdp_addr(acpi_physical_address *rsdp_addr)
>>  {
>> @@ -200,3 +206,23 @@ static void bios_get_rsdp_addr(acpi_physical_address *rsdp_addr)
>>  		*rsdp_addr = (acpi_physical_address)address;
>>  	}
>>  }
>> +
>> +static void get_acpi_rsdp(acpi_physical_address *rsdp_addr)
>> +{
>> +#ifdef CONFIG_KEXEC
>> +	unsigned long long res;
>> +	int len = 0;
>> +	char *val;
>> +
>> +	val = malloc(19);
>> +	len = cmdline_find_option("acpi_rsdp", val, 19);
>> +
>> +	if (len == -1)
>> +		return;
>> +
>> +	if (len > 0) {
>> +		val[len] = 0;
>> +		*rsdp_addr = (acpi_physical_address)kstrtoull(val, 16, &res);
>> +	}
>> +#endif
>> +}
>> diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
>> index 3d78e27077f4..0ff3edb888e4 100644
>> --- a/arch/x86/boot/string.h
>> +++ b/arch/x86/boot/string.h
>> @@ -30,3 +30,7 @@ extern unsigned long long simple_strtoull(const char *cp, char **endp,
>>  					  unsigned int base);
>>  
>>  #endif /* BOOT_STRING_H */
>> +
>> +#ifdef BOOT_STRING
>> +#include "../../../lib/kstrtox.c"
>> +#endif
>> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
>> index 1006bf70bf74..3804db9eed56 100644
>> --- a/lib/kstrtox.c
>> +++ b/lib/kstrtox.c
>> @@ -126,6 +126,8 @@ int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>>  }
>>  EXPORT_SYMBOL(kstrtoull);
>>  
>> +#ifndef BOOT_STRING
>> +
>>  /**
>>   * kstrtoll - convert a string to a long long
>>   * @s: The start of the string. The string must be null-terminated, and may also
>> @@ -408,3 +410,5 @@ kstrto_from_user(kstrtou16_from_user,	kstrtou16,	u16);
>>  kstrto_from_user(kstrtos16_from_user,	kstrtos16,	s16);
>>  kstrto_from_user(kstrtou8_from_user,	kstrtou8,	u8);
>>  kstrto_from_user(kstrtos8_from_user,	kstrtos8,	s8);
>> +
>> +#endif
>> -- 
>> 2.19.1
>> 
>> 
>> 
>
>


