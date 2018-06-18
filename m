Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B2DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5B820874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fsr3tUKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5B820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754942AbeFRGni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:43:38 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43813 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754542AbeFRGnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:43:37 -0400
Received: by mail-pf0-f194.google.com with SMTP id y8-v6so7654169pfm.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 23:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AuZugMHtd/MGYq4JNhEo1H0f9rlSnzey8+714SSDSWQ=;
        b=fsr3tUKmGYgXu4L948cWAO0Fv74gysDZqrUtY9FoSjyeIr3AkoL8yuym0zzOZMke+J
         sR+Cht1rOaqnvXA3SrKXfimXeCat5m4jDgrfurVvLakV/zwaFfrMTkvFmSUGEvnZGV/G
         KyG8dwGpKM3+g3chwRIXs+62d8cqIoODQxz7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=AuZugMHtd/MGYq4JNhEo1H0f9rlSnzey8+714SSDSWQ=;
        b=tA4aVDAbpViTeJ4uSO5DUol3TVPf3ud+JVfU2SQ4vA0QrYLzSe2FCvrD0xmRYlKsnU
         tgVarx4uWoP6UQxCuRHD1pQje4WT1NaMpQ4xCmOHQPoVTkDIFbk1Xnsgv+oVAkqZuj8O
         lYURjQk87pczju+aRWbxNQCeMKdGxZEaER71HBx8ASmuHkaPwYBYoLwJoUMiWgws7YdX
         7zTTlMG1zfKSWbmPcM0XLB2Y49aUfIl4khsNYr0WTCah74JKpS0DhMHukuAiVfMWYtTM
         PLqGm3DU+J6lJcy2Vbl7TnwcbBhDzZErQ4ZfZ4HaujbaZ9QrMDyBZ3W82lc3Vp1wFjSK
         2TrQ==
X-Gm-Message-State: APt69E0jx8rPUT7husrmFf9OJjIOlEAKOWZQXaeuqdxaBzQaqr+PVUHZ
        xlPWsnVuyKXtNaKqxlERDmheBA==
X-Google-Smtp-Source: ADUXVKIg/t15JHav0BGUpV0vCwxphqVeC047b8SQgdqQXU0zYqt6TOGRsgplY/owBT7Tf72C5maYtw==
X-Received: by 2002:a63:a84f:: with SMTP id i15-v6mr10185743pgp.422.1529304216691;
        Sun, 17 Jun 2018 23:43:36 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id c12-v6sm19948966pfi.177.2018.06.17.23.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 23:43:36 -0700 (PDT)
Date:   Mon, 18 Jun 2018 15:44:14 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH 2/3] arm64: acpi,efi: fix alignment fault in accessing
 ACPI tables at kdump
Message-ID: <20180618064413.GF23681@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, akpm@linux-foundation.org,
        ard.biesheuvel@linaro.org, tbaicar@codeaurora.org,
        bhsharma@redhat.com, dyoung@redhat.com, mark.rutland@arm.com,
        al.stone@linaro.org, graeme.gregory@linaro.org,
        hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
References: <20180615075623.13454-1-takahiro.akashi@linaro.org>
 <20180615075623.13454-3-takahiro.akashi@linaro.org>
 <026a4d23-ac91-ed35-d711-c55882242037@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <026a4d23-ac91-ed35-d711-c55882242037@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James,

On Fri, Jun 15, 2018 at 05:30:08PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 15/06/18 08:56, AKASHI Takahiro wrote:
> > This is a fix against the issue that crash dump kernel may hang up
> > during booting, which can happen on any ACPI-based system with "ACPI
> > Reclaim Memory."
> > 
> > (kernel messages after panic kicked off kdump)
> > 	   (snip...)
> > 	Bye!
> > 	   (snip...)
> > 	ACPI: Core revision 20170728
> > 	pud=000000002e7d0003, *pmd=000000002e7c0003, *pte=00e8000039710707
> > 	Internal error: Oops: 96000021 [#1] SMP
> > 	Modules linked in:
> > 	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.0-rc6 #1
> > 	task: ffff000008d05180 task.stack: ffff000008cc0000
> > 	PC is at acpi_ns_lookup+0x25c/0x3c0
> > 	LR is at acpi_ds_load1_begin_op+0xa4/0x294
> > 	   (snip...)
> > 	Process swapper/0 (pid: 0, stack limit = 0xffff000008cc0000)
> > 	Call trace:
> > 	   (snip...)
> > 	[<ffff0000084a6764>] acpi_ns_lookup+0x25c/0x3c0
> > 	[<ffff00000849b4f8>] acpi_ds_load1_begin_op+0xa4/0x294
> > 	[<ffff0000084ad4ac>] acpi_ps_build_named_op+0xc4/0x198
> > 	[<ffff0000084ad6cc>] acpi_ps_create_op+0x14c/0x270
> > 	[<ffff0000084acfa8>] acpi_ps_parse_loop+0x188/0x5c8
> > 	[<ffff0000084ae048>] acpi_ps_parse_aml+0xb0/0x2b8
> > 	[<ffff0000084a8e10>] acpi_ns_one_complete_parse+0x144/0x184
> > 	[<ffff0000084a8e98>] acpi_ns_parse_table+0x48/0x68
> > 	[<ffff0000084a82cc>] acpi_ns_load_table+0x4c/0xdc
> > 	[<ffff0000084b32f8>] acpi_tb_load_namespace+0xe4/0x264
> > 	[<ffff000008baf9b4>] acpi_load_tables+0x48/0xc0
> > 	[<ffff000008badc20>] acpi_early_init+0x9c/0xd0
> > 	[<ffff000008b70d50>] start_kernel+0x3b4/0x43c
> > 	Code: b9008fb9 2a000318 36380054 32190318 (b94002c0)
> > 	---[ end trace c46ed37f9651c58e ]---
> > 	Kernel panic - not syncing: Fatal exception
> > 	Rebooting in 10 seconds..
> > 
> > (diagnosis)
> > * This fault is a data abort, alignment fault (ESR=0x96000021)
> >   during reading out ACPI table.
> > * Initial ACPI tables are normally stored in system ram and marked as
> >   "ACPI Reclaim memory" by the firmware.
> > * After the commit f56ab9a5b73c ("efi/arm: Don't mark ACPI reclaim
> >   memory as MEMBLOCK_NOMAP"), those regions are differently handled
> >   as they are "memblock-reserved", without NOMAP bit.
> > * So they are now excluded from device tree's "usable-memory-range"
> >   which kexec-tools determines based on a current view of /proc/iomem.
> > * When crash dump kernel boots up, it tries to accesses ACPI tables by
> >   mapping them with ioremap(), not ioremap_cache(), in acpi_os_ioremap()
> >   since they are no longer part of mapped system ram.
> > * Given that ACPI accessor/helper functions are compiled in without
> >   unaligned access support (ACPI_MISALIGNMENT_NOT_SUPPORTED),
> >   any unaligned access to ACPI tables can cause a fatal panic.
> > 
> > With this patch, acpi_os_ioremap() always honors memory attribute
> > information provided by the firmware (EFI) and retaining cacheability
> > allows the kernel safe access to ACPI tables.
> 
> 
> > Please note that arm_enable_runtime_services() is now renamed to
> > efi_enter_virtual_mode() due to the similarity to x86's.
> 
> Just a rename?:

and maps EFI memory map whether or not runtime service is enabled.

> >  drivers/firmware/efi/arm-runtime.c | 27 ++++++++++++---------------
> 
> 
> 
> > diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> > index 32f465a80e4e..d53c95f4e1a9 100644
> > --- a/arch/arm64/include/asm/acpi.h
> > +++ b/arch/arm64/include/asm/acpi.h
> > @@ -29,18 +31,22 @@
> >  
> >  /* Basic configuration for ACPI */
> >  #ifdef	CONFIG_ACPI
> > +pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
> > +
> >  /* ACPI table mapping after acpi_permanent_mmap is set */
> >  static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> >  					    acpi_size size)
> >  {
> > +	/* For normal memory we already have a cacheable mapping. */
> > +	if (memblock_is_map_memory(phys))
> > +		return (void __iomem *)__phys_to_virt(phys);
> 
> >  	/*
> > -	 * EFI's reserve_regions() call adds memory with the WB attribute
> > -	 * to memblock via early_init_dt_add_memory_arch().
> > +	 * We should still honor the memory's attribute here because
> > +	 * crash dump kernel possibly excludes some ACPI (reclaim)
> > +	 * regions from memblock list.
> >  	 */
> 
> (Even without kdump we would still need this. Regions ACPI wants mapped may not
> be covered by the linear map. In this case we need to use the attributes
> firmware described in the UEFI memory map. Kdump exacerbates this by
> artificially reducing the range of the linear map.)
> 
> 
> > -	if (!memblock_is_memory(phys))
> > -		return ioremap(phys, size);
> > -
> > -	return ioremap_cache(phys, size);
> > +	return __ioremap(phys, size, __acpi_get_mem_attribute(phys));
> >  }
> 
> 
> 
> > diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> > index 5889cbea60b8..566ef0a9edb5 100644
> > --- a/drivers/firmware/efi/arm-runtime.c
> > +++ b/drivers/firmware/efi/arm-runtime.c
> > @@ -106,46 +106,43 @@ static bool __init efi_virtmap_init(void)
> >   * non-early mapping of the UEFI system table and virtual mappings for all
> >   * EFI_MEMORY_RUNTIME regions.
> >   */
> > -static int __init arm_enable_runtime_services(void)
> > +void __init efi_enter_virtual_mode(void)
> >  {
> >  	u64 mapsize;
> >  
> >  	if (!efi_enabled(EFI_BOOT)) {
> >  		pr_info("EFI services will not be available.\n");
> > -		return 0;
> > +		return;
> > +	}
> > +
> > +	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
> > +
> > +	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
> > +		pr_err("Failed to remap EFI memory map\n");
> > +		return;
> >  	}
> >  
> >  	if (efi_runtime_disabled()) {
> >  		pr_info("EFI runtime services will be disabled.\n");
> > -		return 0;
> > +		return;
> >  	}
> >  
> >  	if (efi_enabled(EFI_RUNTIME_SERVICES)) {
> >  		pr_info("EFI runtime services access via paravirt.\n");
> > -		return 0;
> > +		return;
> >  	}
> >  
> >  	pr_info("Remapping and enabling EFI services.\n");
> >  
> > -	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
> > -
> > -	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
> > -		pr_err("Failed to remap EFI memory map\n");
> > -		return -ENOMEM;
> > -	}
> > -
> >  	if (!efi_virtmap_init()) {
> >  		pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
> > -		return -ENOMEM;
> > +		return;
> >  	}
> >  
> >  	/* Set up runtime services function pointers */
> >  	efi_native_runtime_setup();
> >  	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
> > -
> > -	return 0;
> >  }
> 
> Please have the drivers/firmware/efi/arm-runtime.c changes in a separate patch
> (maybe combine it with patch 3). The 'efi/arm: ' prefix is more likely to catch
> the maintainers attention.
>
> I think this is what Ard meant by:
> | Could you please move the changes to this file and init/main.c into a
> | separate patch?
> 
> https://patchwork.kernel.org/patch/10361761/
> 
> 
> > -early_initcall(arm_enable_runtime_services);
> 
> With just this patch, surely nothing ever calls arm_enable_runtime_services(),
> and now acpi_os_ioremap() will return device memory for anything that isn't part
> of the linear region. (This breaks RAS).

Actually I noticed the issue.

> This will make it difficult to bisect through for any RAS or
> efi-runtime-services issue. Its easily fixed: please put the efi+init changes in
> a patch before the acpi_os_ioremap() changes.

I was reluctant to put different part of code changes into one.
But if nobody cares, I will do so in three patches.
  * change arm_enable_runtime_services() with renaming
  * move this function earlier in start_kernel()
  * modify acpi_os_ioremap()

Thanks,
-Takahiro AKASHI


> Otherwise, looks good to me!
> 
> 
> Thanks,
> 
> James
