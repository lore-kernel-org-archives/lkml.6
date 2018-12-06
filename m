Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A58C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21D320700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21D320700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbeLFCWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 21:22:35 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1772 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727762AbeLFCWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 21:22:35 -0500
X-IronPort-AV: E=Sophos;i="5.56,320,1539619200"; 
   d="scan'208";a="49080905"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 06 Dec 2018 10:22:33 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id D43914B734CC;
        Thu,  6 Dec 2018 10:22:31 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 6 Dec 2018 10:22:39 +0800
Date:   Thu, 6 Dec 2018 10:22:17 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v12 1/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdline from KEXEC
Message-ID: <20181206022217.GH30941@localhost.localdomain>
References: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
 <20181129081631.11139-2-fanc.fnst@cn.fujitsu.com>
 <20181205145814.GJ29510@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181205145814.GJ29510@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: D43914B734CC.AB74F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 03:58:14PM +0100, Borislav Petkov wrote:
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
>
>Also, I guess calling that file simply "acpi.c" is good enough.

Fine, so change it next version.

>
>> @@ -0,0 +1,33 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#define BOOT_CTYPE_H
>> +#include "misc.h"
>> +#include "error.h"
>> +
>> +#include <linux/efi.h>
>> +#include <asm/efi.h>
>
>asm/ headers come after linux/ header.

Will change the place of header.

Thanks,
Chao Fan

>
>...
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


