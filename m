Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFDCC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E988020861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfAUIpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:45:02 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:20038 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727993AbfAUIpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:45:02 -0500
X-IronPort-AV: E=Sophos;i="5.56,502,1539619200"; 
   d="scan'208";a="52482817"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 Jan 2019 16:44:59 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 973A04C47E9E;
        Mon, 21 Jan 2019 16:44:58 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Jan 2019 16:45:03 +0800
Date:   Mon, 21 Jan 2019 16:43:52 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Kairui Song <kasong@redhat.com>, <linux-kernel@vger.kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, <kexec@lists.infradead.org>,
        <akpm@linux-foundation.org>, <robert.moore@intel.com>,
        <erik.schmauss@intel.com>, <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
Message-ID: <20190121084352.GA15754@localhost.localdomain>
References: <20190115095834.22617-1-kasong@redhat.com>
 <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic>
 <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
 <20190116094619.GB15409@zn.tnic>
 <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
 <20190118102636.GB622@zn.tnic>
 <20190121011830.GA1554@localhost.localdomain>
 <20190121082932.GA29166@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190121082932.GA29166@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 973A04C47E9E.ABDEF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 09:29:32AM +0100, Borislav Petkov wrote:
>On Mon, Jan 21, 2019 at 09:18:30AM +0800, Chao Fan wrote:
>> So I have changed as this method and put in my mail thread, you may not
>> notice, so I put here for my function if I need to fill the
>> boot_parameters:
>> 
>> static inline acpi_physical_address get_boot_params_rsdp(void)
>> {
>>         return boot_params->acpi_rsdp_addr;
>> }
>
>Why do you need that silly wrapper?

Will drop it.

>
>> static acpi_physical_address get_rsdp_addr(void)
>> {
>>         bool boot_params_rsdp_exist;
>
>What's that bool supposed to do?

Since I didn't see where Xen to fill the value, if
boot_params->acpi_rsdp_addr is filled before my code, I just need to
read it. If when I try to read it but not found, then parse RSDP and
fill the RSDP address to boot_params->acpi_rsdp_addr.
>
>>         acpi_physical_address pa;
>> 
>>         pa = get_acpi_rsdp();
>> 
>>         if (!pa)
>>                 pa = get_boot_params_rsdp();
>> 
>>         if (!pa) {
>>                 pa = efi_get_rsdp_addr();
>>                 boot_params_rsdp_exist = false;
>>         }
>>         else
>>                 boot_params_rsdp_exist = true;
>> 
>>         if (!pa)
>>                 pa = bios_get_rsdp_addr();
>> 
>>         if (pa && !boot_params_rsdp_exist)
>>                 boot_params.acpi_rsdp_addr = pa;
>> 
>>         return pa;
>> }
>> 
>> At the same time, I notice kernel only parses it when
>> "#ifdef CONFIG_ACPI", we should keep sync with kernel, but I think
>> we are parsing SRAT, CONFIG_ACPI is needed sure, so I am going to
>> update the define of EARLY_SRAT_PARSE:
>> 
>> config EARLY_SRAT_PARSE
>>         bool "EARLY SRAT parsing"
>>         def_bool y
>>         depends on RANDOMIZE_BASE && MEMORY_HOTREMOVE && ACPI
>
>Actually, you don't need that anymore - make it unconditionally
>built-in. Because there are a bunch of users which need this and instead
>of complicating this config option with a bunch of dependencies, we can
>just as well have it always on.

If I need to fill boot_params->acpi_rsdp_addr, I think we can make it
unconditionally built-in.

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


