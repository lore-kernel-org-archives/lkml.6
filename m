Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80272C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BC12084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfAUHmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:42:20 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:58526 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728470AbfAUHmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:42:19 -0500
X-IronPort-AV: E=Sophos;i="5.56,501,1539619200"; 
   d="scan'208";a="52450269"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 Jan 2019 09:19:37 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 3FCB64BAD9B9;
        Mon, 21 Jan 2019 09:19:36 +0800 (CST)
Received: from localhost.localdomain (10.167.226.29) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Jan 2019 09:19:40 +0800
Date:   Mon, 21 Jan 2019 09:18:30 +0800
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
Message-ID: <20190121011830.GA1554@localhost.localdomain>
References: <20190115095834.22617-1-kasong@redhat.com>
 <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic>
 <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
 <20190116094619.GB15409@zn.tnic>
 <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
 <20190118102636.GB622@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190118102636.GB622@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.226.29]
X-yoursite-MailScanner-ID: 3FCB64BAD9B9.AFF61
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:26:36AM +0100, Borislav Petkov wrote:
>On Thu, Jan 17, 2019 at 03:41:13PM +0800, Kairui Song wrote:
>> How about we refill the boot_params.acpi_rsdp_addr if it is not valid
>> in early code, so it could be used as a reliable RSDP address source?
>> That should make things easier.
>> 
>> But if early code should parse it and store it should be done in
>> Chao's patch, or I can post another patch to do it if Chao's patch is
>> merged.
>
>Chao's stuff does the as early as possible parsing of RDSP. Then, it
>should be saved into boot_params and everything else should read it from
>there. Simple.

Hi Boris,

So I have changed as this method and put in my mail thread, you may not
notice, so I put here for my function if I need to fill the
boot_parameters:

static inline acpi_physical_address get_boot_params_rsdp(void)
{
        return boot_params->acpi_rsdp_addr;
}

static acpi_physical_address get_rsdp_addr(void)
{
        bool boot_params_rsdp_exist;
        acpi_physical_address pa;

        pa = get_acpi_rsdp();

        if (!pa)
                pa = get_boot_params_rsdp();

        if (!pa) {
                pa = efi_get_rsdp_addr();
                boot_params_rsdp_exist = false;
        }
        else
                boot_params_rsdp_exist = true;

        if (!pa)
                pa = bios_get_rsdp_addr();

        if (pa && !boot_params_rsdp_exist)
                boot_params.acpi_rsdp_addr = pa;

        return pa;
}

At the same time, I notice kernel only parses it when
"#ifdef CONFIG_ACPI", we should keep sync with kernel, but I think
we are parsing SRAT, CONFIG_ACPI is needed sure, so I am going to
update the define of EARLY_SRAT_PARSE:

config EARLY_SRAT_PARSE
        bool "EARLY SRAT parsing"
        def_bool y
        depends on RANDOMIZE_BASE && MEMORY_HOTREMOVE && ACPI

If I miss something, please let me know.
Or in my PATCHSET, I don't need to fill boot_parameters, just
leave the job another PATCH?

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


