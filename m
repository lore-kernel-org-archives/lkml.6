Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5DFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11B52080D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbeLRB1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 20:27:35 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49531 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726419AbeLRB1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 20:27:34 -0500
X-IronPort-AV: E=Sophos;i="5.56,367,1539619200"; 
   d="scan'208";a="50021055"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Dec 2018 09:27:32 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id D2DCF4B7348C;
        Tue, 18 Dec 2018 09:27:27 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 18 Dec 2018 09:27:33 +0800
Date:   Tue, 18 Dec 2018 09:27:04 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v14 1/5] x86/boot: Introduce get_acpi_rsdp() to parse
 RSDP in cmdline from KEXEC
Message-ID: <20181218012704.GB31775@localhost.localdomain>
References: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
 <20181214093013.13370-2-fanc.fnst@cn.fujitsu.com>
 <20181217172510.GA90818@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181217172510.GA90818@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: D2DCF4B7348C.AF0F9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 06:25:10PM +0100, Ingo Molnar wrote:
>
>* Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
>> Memory information in SRAT is necessary to fix the conflict between
>> KASLR and memory-hotremove.
>> 
>> ACPI SRAT (System/Static Resource Affinity Table) shows the details
>> about memory ranges, including ranges of memory provided by hot-added
>> memory devices. SRAT is introduced by Root System Description
>> Pointer(RSDP), so RSDP should be found firstly.
>> 
>> When booting form KEXEC/EFI/BIOS, the methods to find RSDP
>> are different. When booting from KEXEC, 'acpi_rsdp' may have been
>> added to cmdline, so parse cmdline to find RSDP.
>
>What is the nature of the basic conflict? Should the kernel only allow 
>hot-removing memory ranges that are explicitly marked as such in the 
>SRAT? I presume that's already so, correct? Or should the kernel avoiding 
>KASLR-randomizing into hot-removable memory areas?

The basic conflict is the kernel avoiding KASLR-randomizing into
hot-removable memory areas.

>
>Some minor nits:
>
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/acpi.c | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>  create mode 100644 arch/x86/boot/compressed/acpi.c
>> 
>> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
>> new file mode 100644
>> index 000000000000..44f19546c169
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
>> +/* Max length of 64-bit hex address string is 18, prefix "0x" + 16 hex digits */
>> +#define MAX_ADDRESS_LENGTH 18
>
>I'd suggest adding the +1 for the string termination \0 as well, and use 
>that below.
>
>Also, 'max address length' is way too generic (and hence pretty 
>meaningless) - how about MAX_HEX_ADDRESS_STRING_LEN or so?

OK, I will change the name and add the \0.

Thanks,
Chao Fan

>
>> +
>> +static acpi_physical_address get_acpi_rsdp(void)
>> +{
>> +#ifdef CONFIG_KEXEC
>> +	char val[MAX_ADDRESS_LENGTH+1];
>> +	unsigned long long res;
>> +	int len;
>> +
>> +	len = cmdline_find_option("acpi_rsdp", val, MAX_ADDRESS_LENGTH+1);
>> +	if (len > 0) {
>> +		char *e;
>> +
>> +		val[len] = '\0';
>> +		return (acpi_physical_address)simple_strtoull(val, &e, 16);
>
>'return' is not a function - no need for the parenthesis.
>
>Thanks,
>
>	Ingo
>
>


