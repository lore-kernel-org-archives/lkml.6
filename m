Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B12FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 01:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14451214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 01:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14451214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbeKNMA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:00:58 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24803 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726496AbeKNMA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:00:57 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="48048013"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Nov 2018 09:59:50 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id EEB144B73488;
        Wed, 14 Nov 2018 09:59:48 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 14 Nov 2018 09:59:54 +0800
Date:   Wed, 14 Nov 2018 09:59:45 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v11 3/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdlien from kexec
Message-ID: <20181114015945.GB2875@localhost.localdomain>
References: <20181112094645.4879-1-fanc.fnst@cn.fujitsu.com>
 <20181112094645.4879-4-fanc.fnst@cn.fujitsu.com>
 <20181113175150.GK10502@zn.tnic>
 <20181114015450.GA2875@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181114015450.GA2875@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: EEB144B73488.AC1D4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 09:54:50AM +0800, Chao Fan wrote:
>On Tue, Nov 13, 2018 at 06:51:50PM +0100, Borislav Petkov wrote:
>>On Mon, Nov 12, 2018 at 05:46:43PM +0800, Chao Fan wrote:
>>> Imitate setup_acpi_rsdp() for the early_param of 'acpi_rsdp'.
>>> KEXEC writes the RSDP pointer to cmdline for EFI booting.
>>> So if 'acpi_rsdp' found in cmdline, use it directely.
>>> 
>>> Since function kstrtoull() is needed, include it in
>>> arch/x86/boot/string.h. To solve the definition conflict
>>> problem, set BOOT_STRING tag to expose only kstrtoull() and
>>> functions used by it. Other functions in lib/kstrtox.c will
>>> be covered.
>>> 
>>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>>> ---
>>>  arch/x86/boot/compressed/acpitb.c | 26 ++++++++++++++++++++++++++
>>>  arch/x86/boot/string.h            |  4 ++++
>>>  lib/kstrtox.c                     |  4 ++++
>>>  3 files changed, 34 insertions(+)
>>> 
>>> diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
>>> index 50fa65cf824d..5cfb4efa5a19 100644
>>> --- a/arch/x86/boot/compressed/acpitb.c
>>> +++ b/arch/x86/boot/compressed/acpitb.c
>>> @@ -8,6 +8,12 @@
>>>  #include <linux/numa.h>
>>>  #include <linux/acpi.h>
>>>  
>>> +#define STATIC
>>> +#include <linux/decompress/mm.h>
>>> +
>>> +#define BOOT_STRING
>>> +#include "../string.h"
>>> +
>>>  /* Search EFI table for RSDP table. */
>>>  static void efi_get_rsdp_addr(acpi_physical_address *rsdp_addr)
>>>  {
>>> @@ -200,3 +206,23 @@ static void bios_get_rsdp_addr(acpi_physical_address *rsdp_addr)
>>>  		*rsdp_addr = (acpi_physical_address)address;
>>>  	}
>>>  }
>>> +
>>> +static void get_acpi_rsdp(acpi_physical_address *rsdp_addr)
>>> +{
>>> +#ifdef CONFIG_KEXEC
>>
>>Ok, why is that CONFIG_KEXEC dependency needed now too?
>>
>
>CONFIG_KEXEC is only needed in this function.
>
>When searching RSDP, there are three methods in order:
>1. When booting from KEXEC, 'acpi_rsdp' is added to cmdline by KEXEC,
>   so it can be parsed and used. CONFIG_KEXEC is needed here.
>2. When booting from EFI, parse EFI table and find RSDP.
>3. When booting from BIOS, search memory for RSDP just like
>   acpi_find_root_pointer() in drivers/acpi/acpica/tbxfroot.c did.
>
>So, CONFIG_KEXEC is only needed in 1, exactly in this function
>get_acpi_rsdp() of my PATCH.
>
>Thanks,
>Chao Fan
>

That means, CONFIG_KEXEC is needed by a little part of the whole PATCHSET.
Without CONFIG_KEXEC, RSDP can only be found in other methods.

Thanks,
Chao Fan

>>Ok, let's recap: so far, for your use case you need:
>>
>>CONFIG_MEMORY_HOTREMOVE
>>CONFIG_RANDOMIZE_BASE
>>and now
>>CONFIG_KEXEC
>>
>>So, you can clean up all that ifdeffery by defining a new config item
>>CONFIG_EARLY_PARSE_RSDP or so which depends on all those three items and
>>then you can do
>>
>>vmlinux-objs-$(CONFIG_EARLY_PARSE_RSDP) += $(obj)/acpitb.o
>>
>>and get rid of the most of the ifdeffery.
>>
>>Yes?
>>
>>> +	unsigned long long res;
>>> +	int len = 0;
>>> +	char *val;
>>> +
>>> +	val = malloc(19);
>>> +	len = cmdline_find_option("acpi_rsdp", val, 19);
>>> +
>>
>>^ Superfluous newline.
>>
>>> +	if (len == -1)
>>> +		return;
>>
>>That check is not needed since you do > 0 below.
>>
>>> +
>>> +	if (len > 0) {
>>> +		val[len] = 0;
>>> +		*rsdp_addr = (acpi_physical_address)kstrtoull(val, 16, &res);
>>> +	}
>>> +#endif
>>> +}
>>> diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
>>> index 3d78e27077f4..0ff3edb888e4 100644
>>> --- a/arch/x86/boot/string.h
>>> +++ b/arch/x86/boot/string.h
>>> @@ -30,3 +30,7 @@ extern unsigned long long simple_strtoull(const char *cp, char **endp,
>>>  					  unsigned int base);
>>>  
>>>  #endif /* BOOT_STRING_H */
>>> +
>>> +#ifdef BOOT_STRING
>>> +#include "../../../lib/kstrtox.c"
>>> +#endif
>>> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
>>> index 1006bf70bf74..3804db9eed56 100644
>>> --- a/lib/kstrtox.c
>>> +++ b/lib/kstrtox.c
>>> @@ -126,6 +126,8 @@ int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>>>  }
>>>  EXPORT_SYMBOL(kstrtoull);
>>
>>This needs a comment to explain what is that guard used for.
>>
>>> +#ifndef BOOT_STRING
>>> +
>>>  /**
>>>   * kstrtoll - convert a string to a long long
>>>   * @s: The start of the string. The string must be null-terminated, and may also
>>> @@ -408,3 +410,5 @@ kstrto_from_user(kstrtou16_from_user,	kstrtou16,	u16);
>>>  kstrto_from_user(kstrtos16_from_user,	kstrtos16,	s16);
>>>  kstrto_from_user(kstrtou8_from_user,	kstrtou8,	u8);
>>>  kstrto_from_user(kstrtos8_from_user,	kstrtos8,	s8);
>>> +
>>> +#endif
>>
>>#endif /* BOOT_STRING */
>>
>>-- 
>>Regards/Gruss,
>>    Boris.
>>
>>Good mailing practices for 400: avoid top-posting and trim the reply.
>>
>>


