Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13177C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7AC20578
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeLRDRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:17:44 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:37416 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726303AbeLRDRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:17:44 -0500
X-IronPort-AV: E=Sophos;i="5.56,367,1539619200"; 
   d="scan'208";a="50029210"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Dec 2018 11:17:41 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 60A3A4B734D9;
        Tue, 18 Dec 2018 11:17:38 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 18 Dec 2018 11:17:43 +0800
Date:   Tue, 18 Dec 2018 11:17:10 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v14 4/5] x86/boot: Parse SRAT address from RSDP and store
 immovable memory
Message-ID: <20181218031710.GB10386@localhost.localdomain>
References: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
 <20181214093013.13370-5-fanc.fnst@cn.fujitsu.com>
 <20181217174149.GD90818@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181217174149.GD90818@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 60A3A4B734D9.AA218
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 06:41:49PM +0100, Ingo Molnar wrote:
>
>* Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
>> SRAT should be parsed by RSDP to fix the conflict between KASLR
>> and memory-hotremove, then find the immovable memory regions and store
>> them in an array called immovable_mem[]. With immovable_mem[], KASLR
>> can avoid to extract kernel to specific regions.
>> 
>> Since 'RANDOMIZE_BASE' && 'MEMORY_HOTREMOVE' is needed, introduce
>> 'CONFIG_EARLY_PARSE_RSDP' to make ifdeffery clear.
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/Kconfig                  |  12 +++
>>  arch/x86/boot/compressed/Makefile |   2 +
>>  arch/x86/boot/compressed/acpi.c   | 128 ++++++++++++++++++++++++++++++
>>  arch/x86/boot/compressed/kaslr.c  |   4 -
>>  arch/x86/boot/compressed/misc.h   |  19 +++++
>>  5 files changed, 161 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index ba7e3464ee92..333c383478b7 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2149,6 +2149,18 @@ config X86_NEED_RELOCS
>>  	def_bool y
>>  	depends on RANDOMIZE_BASE || (X86_32 && RELOCATABLE)
>>  
>> +config EARLY_SRAT_PARSE
>> +	bool "Early SRAT table parsing"
>> +	def_bool y
>> +	depends on RANDOMIZE_BASE && MEMORY_HOTREMOVE
>> +	help
>> +	  This option enables early SRAT parsing in compressed boot stage
>> +	  so that memory hot-remove ranges do not overlap with KASLR
>> +	  chosen ranges. Kernel won't be extracted in hot-removable
>> +	  memory, so that make sure memory-hotremove works well with
>> +	  KASLR enabled.
>> +	  Say Y if you want to use both KASLR and memory-hotremove.
>
>So why would we want to make this a config option, instead of enabling it 
>unconditionally?

Well, it can make ifdeffery more clear, and Boris suggested to do that.
If there is no KASLR enabled or MEMORY-HOTREMOVE enabled, the code is
not needed, so it's not good to enable it unconditionally.

>
>How reliable are the hot-removable memory markings in various firmware 
>versions?

But we can only get the information from firmware, I can't figure out
other information. And ACPI also gets the table from here.

>
>> +/* Compute SRAT table from RSDP. */
>> +static struct acpi_table_header *get_acpi_srat_table(void)
>> +{
>> +	acpi_physical_address acpi_table;
>> +	acpi_physical_address root_table;
>> +	struct acpi_table_header *header;
>> +	struct acpi_table_rsdp *rsdp;
>> +	u32 num_entries;
>> +	char arg[10];
>
>The '10' is just a magic number attached to a meaningless local variable 
>name. Please explain the limit in the code, and the role of the variable 
>if it's non-obvious from the name. Or better, try to find a more obvious 
>name?
>

Yes, the '10' is magic number, the meaning is detail. Here, the '10'
is used to store the result of 'acpi=' in cmdline. Well, see
Documentation/admin-guide/kernel-parameters.txt:
        acpi=           [HW,ACPI,X86,ARM64]
                        Advanced Configuration and Power Interface
                        Format: { force | on | off | strict | noirq | rsdt |
                                  copy_dsdt }
'copy_dsdt' is the longest result, its size is '9', plus '\0' is '10'.
So I set it as '10'.

And I see the usage like this is:
        char arg[5];
in pti_check_boottime_disable() of arch/x86/mm/pti.c, since the longest
result of 'pti=' in cmdline is 'auto', so it's '5' here.

And:
        char arg[32];
in fpu__init_parse_early_param() of arch/x86/kernel/fpu/init.c.

And so on. All usage of cmdline_find_option() needs a string, they are
often named as arg[] and with a number which can cover the longest result.

Thanks,
Chao Fan

>Thanks,
>
>	Ingo
>
>


