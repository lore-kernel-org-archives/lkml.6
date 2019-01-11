Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC2EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E98D2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfAKBSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:18:34 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36724 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726369AbfAKBSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:18:33 -0500
X-IronPort-AV: E=Sophos;i="5.56,463,1539619200"; 
   d="scan'208";a="51751907"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Jan 2019 09:18:32 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id A4B154BAD7CC;
        Fri, 11 Jan 2019 09:18:32 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 11 Jan 2019 09:18:32 +0800
Date:   Fri, 11 Jan 2019 09:17:36 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v15 2/6] x86/boot: Introduce get_acpi_rsdp() to parse
 RSDP in cmdline from KEXEC
Message-ID: <20190111011736.GC2216@localhost.localdomain>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-3-fanc.fnst@cn.fujitsu.com>
 <20190110170103.GF17621@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190110170103.GF17621@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: A4B154BAD7CC.ADA73
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 06:01:03PM +0100, Borislav Petkov wrote:
>On Mon, Jan 07, 2019 at 11:22:39AM +0800, Chao Fan wrote:
>> KASLR may randomly choose some positions which are located in movable
>> memory regions. This will make the movable memory chosen by KASLR
>> can't be removed.
>> 
>> Memory information in SRAT is necessary to fix the conflict between
>> KASLR and memory-hotremove.
>> 
>> ACPI SRAT (System/Static Resource Affinity Table) shows the details
>> about memory ranges, including ranges of memory provided by hot-added
>> memory devices. SRAT is introduced by Root System Description
>> Pointer(RSDP). So RSDP should be found firstly.
>> 
>> When booting form KEXEC/EFI/BIOS, the methods to find RSDP
>> are different. When booting from KEXEC, 'acpi_rsdp=' may have been
>> added to cmdline, so parse cmdline to find RSDP.
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/acpi.c | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>  create mode 100644 arch/x86/boot/compressed/acpi.c
>> 
>> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
>> new file mode 100644
>> index 000000000000..7ca5001d7639
>> --- /dev/null
>> +++ b/arch/x86/boot/compressed/acpi.c
>> @@ -0,0 +1,30 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#define BOOT_CTYPE_H
>> +#include "misc.h"
>> +#include "error.h"
>> +#include "../string.h"
>> +
>> +#include <linux/acpi.h>
>
>Ok, I corrected it to this, please replace in your version:
>
>/*
> * Max length of 64-bit hex address string is 19, prefix "0x" + 16 hex
> * digits, and '\0' for termination.
> */
>#define MAX_ADDR_LEN 19
>
>static acpi_physical_address get_acpi_rsdp(void)
>{
>	acpi_physical_address addr = 0;
>
>#ifdef CONFIG_KEXEC
>	char val[MAX_ADDR_LEN] = { };
>	int ret;
>
>	ret = cmdline_find_option("acpi_rsdp", val, MAX_ADDR_LEN);
>	if (ret < 0)
>		return 0;
>
>	if (kstrtoull(val, 16, &addr))
>		return 0;
>#endif
>	return addr;
>}
>

Thanks for your suggestion, will change it.

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


