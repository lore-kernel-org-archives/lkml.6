Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21549C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CDA214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="KxgDnMSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfAUI3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:29:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41414 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbfAUI3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:29:41 -0500
Received: from zn.tnic (p200300EC2BC625005DE3D5B66D6AB027.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:2500:5de3:d5b6:6d6a:b027])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 200681EC05A1;
        Mon, 21 Jan 2019 09:29:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548059379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VeI66XspbB0bkH5OMN38eTSaUuyI/lay9vuOltcymts=;
        b=KxgDnMSXDM3iV+683zOYvVmlFKDYgoXSyxkpUHgceU3EExDhjF2j8p5IPyiX76t3HgW1zw
        IPVKCryxl8eUcjYbPFnbwwpVfzp7zadbf6uMGENoLdi8WHr9e4Ne1CzQs6rxQO+QoF+QFi
        V1yXlVSkyjH8Ovw/AzwL8k7CPMWnCQ8=
Date:   Mon, 21 Jan 2019 09:29:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        akpm@linux-foundation.org, robert.moore@intel.com,
        erik.schmauss@intel.com, rafael.j.wysocki@intel.com,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
Message-ID: <20190121082932.GA29166@zn.tnic>
References: <20190115095834.22617-1-kasong@redhat.com>
 <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic>
 <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
 <20190116094619.GB15409@zn.tnic>
 <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
 <20190118102636.GB622@zn.tnic>
 <20190121011830.GA1554@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190121011830.GA1554@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 09:18:30AM +0800, Chao Fan wrote:
> So I have changed as this method and put in my mail thread, you may not
> notice, so I put here for my function if I need to fill the
> boot_parameters:
> 
> static inline acpi_physical_address get_boot_params_rsdp(void)
> {
>         return boot_params->acpi_rsdp_addr;
> }

Why do you need that silly wrapper?

> static acpi_physical_address get_rsdp_addr(void)
> {
>         bool boot_params_rsdp_exist;

What's that bool supposed to do?

>         acpi_physical_address pa;
> 
>         pa = get_acpi_rsdp();
> 
>         if (!pa)
>                 pa = get_boot_params_rsdp();
> 
>         if (!pa) {
>                 pa = efi_get_rsdp_addr();
>                 boot_params_rsdp_exist = false;
>         }
>         else
>                 boot_params_rsdp_exist = true;
> 
>         if (!pa)
>                 pa = bios_get_rsdp_addr();
> 
>         if (pa && !boot_params_rsdp_exist)
>                 boot_params.acpi_rsdp_addr = pa;
> 
>         return pa;
> }
> 
> At the same time, I notice kernel only parses it when
> "#ifdef CONFIG_ACPI", we should keep sync with kernel, but I think
> we are parsing SRAT, CONFIG_ACPI is needed sure, so I am going to
> update the define of EARLY_SRAT_PARSE:
> 
> config EARLY_SRAT_PARSE
>         bool "EARLY SRAT parsing"
>         def_bool y
>         depends on RANDOMIZE_BASE && MEMORY_HOTREMOVE && ACPI

Actually, you don't need that anymore - make it unconditionally
built-in. Because there are a bunch of users which need this and instead
of complicating this config option with a bunch of dependencies, we can
just as well have it always on.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
