Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C29C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCCA2418C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LDmWxdII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCCA2418C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753419AbeGEJmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:42:07 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45513 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753171AbeGEJmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:42:05 -0400
Received: by mail-io0-f194.google.com with SMTP id l25-v6so7157673ioh.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T37z1A6EF3ZchVjLPo7UVeLfeGfXtL2s2qQ6FHp2znk=;
        b=LDmWxdIIupK/btG4SXr1YqanJQDjGpP5XdavE6Mjn4Q6qxgeOxE3aRy/zjSnMnzlEq
         0ENqzyvuULNjzUktCuhV5RqHHUSTymdvubpvTZ4s0mKllbe7KItxBKY6+zTA+bgImbEx
         cYzdMirSrrda+ps6N6hqGW/q77ho1O7n0gP2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=T37z1A6EF3ZchVjLPo7UVeLfeGfXtL2s2qQ6FHp2znk=;
        b=qixglolYB7pjshSd+VVaphSg0oVOafGFCCE1aQG7TFhvCRYrrkhMwrW5WOUi6FCooK
         cnr+/s7A+ld4Jc5znSqFYcXW8AFcifqqcl8Qnq/TWG0DoLHt8F5KfAAq+lxPdwo0UCm4
         JDvj0fVsbtjPq8qcjhax2b4FhBXWG5ns7myjcch02KGkpzmeFawfmajpKjiZm0Bli7ui
         kzskBHkaQtvomK+HIaLBihFa70XhwQ/pqO4LEHfEiTZfk8LR6XB/UN0zKaOzma4hsshZ
         0GdXQOp3lfIJf3bddGx/YEKhlLB1gPMBEVXX8C0CXsUsrYvgBLlfXCZ7VI0MlOOfAeQr
         nB2w==
X-Gm-Message-State: AOUpUlFzhD0k2aoHGSKJH0ZQxbHML21/orXq1+lDrJNTODJoDGHi0jBg
        z2gAcSEZ78bCGccTCs4l8YeiDg==
X-Google-Smtp-Source: AAOMgpcB81hwcDBCvgH80f86oUl2UIf2/bPcnG0PLcQtL00KRL5qc7gf0u+an6WciIPAXRjtb1tMhA==
X-Received: by 2002:a6b:8b0a:: with SMTP id n10-v6mr3950867iod.229.1530783724777;
        Thu, 05 Jul 2018 02:42:04 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id k16-v6sm2554722iog.45.2018.07.05.02.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 02:42:04 -0700 (PDT)
Date:   Thu, 5 Jul 2018 18:43:14 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Baicar, Tyler" <tbaicar@codeaurora.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Stone <al.stone@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Subject: Re: [PATCH v2 3/4] efi/arm: map UEFI memory map earlier on boot
Message-ID: <20180705094313.GL28220@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Baicar, Tyler" <tbaicar@codeaurora.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>, James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Al Stone <al.stone@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-4-takahiro.akashi@linaro.org>
 <20180704170655.GD8370@arm.com>
 <CAKv+Gu9_rYYyQ+t89otz46DR0D4GDj-cCjhx9q=p+D8LWFRkgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9_rYYyQ+t89otz46DR0D4GDj-cCjhx9q=p+D8LWFRkgQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 08:49:32PM +0200, Ard Biesheuvel wrote:
> On 4 July 2018 at 19:06, Will Deacon <will.deacon@arm.com> wrote:
> > Hi all,
> >
> > [Ard -- please can you look at the EFI parts of this patch]
> >
> > On Tue, Jun 19, 2018 at 03:44:23PM +0900, AKASHI Takahiro wrote:
> >> Since arm_enter_runtime_services() was modified to always create a virtual
> >> mapping of UEFI memory map in the previous patch, it is now renamed to
> >> efi_enter_virtual_mode() and called earlier before acpi_load_tables()
> >> in acpi_early_init().
> >>
> >> This will allow us to use UEFI memory map in acpi_os_ioremap() to create
> >> mappings of ACPI tables using memory attributes described in UEFI memory
> >> map.
> >>
> >> See a relevant commit:
> >>     arm64: acpi: fix alignment fault in accessing ACPI tables
> >>
> >> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> ---
> >>  drivers/firmware/efi/arm-runtime.c | 15 ++++++---------
> >>  init/main.c                        |  3 +++
> >>  2 files changed, 9 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> >> index 30ac5c82051e..566ef0a9edb5 100644
> >> --- a/drivers/firmware/efi/arm-runtime.c
> >> +++ b/drivers/firmware/efi/arm-runtime.c
> >> @@ -106,46 +106,43 @@ static bool __init efi_virtmap_init(void)
> >>   * non-early mapping of the UEFI system table and virtual mappings for all
> >>   * EFI_MEMORY_RUNTIME regions.
> >>   */
> >> -static int __init arm_enable_runtime_services(void)
> >> +void __init efi_enter_virtual_mode(void)
> >>  {
> >>       u64 mapsize;
> >>
> >>       if (!efi_enabled(EFI_BOOT)) {
> >>               pr_info("EFI services will not be available.\n");
> >> -             return 0;
> >> +             return;
> >>       }
> >>
> >>       mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
> >>
> >>       if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
> >>               pr_err("Failed to remap EFI memory map\n");
> >> -             return 0;
> >> +             return;
> >>       }
> >>
> >>       if (efi_runtime_disabled()) {
> >>               pr_info("EFI runtime services will be disabled.\n");
> >> -             return 0;
> >> +             return;
> >>       }
> >>
> >>       if (efi_enabled(EFI_RUNTIME_SERVICES)) {
> >>               pr_info("EFI runtime services access via paravirt.\n");
> >> -             return 0;
> >> +             return;
> >>       }
> >>
> >>       pr_info("Remapping and enabling EFI services.\n");
> >>
> >>       if (!efi_virtmap_init()) {
> >>               pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
> >> -             return -ENOMEM;
> >> +             return;
> >>       }
> >>
> >>       /* Set up runtime services function pointers */
> >>       efi_native_runtime_setup();
> >>       set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
> >> -
> >> -     return 0;
> >>  }
> >> -early_initcall(arm_enable_runtime_services);
> >>
> >>  void efi_virtmap_load(void)
> >>  {
> >> diff --git a/init/main.c b/init/main.c
> >> index 3b4ada11ed52..532fc0d02353 100644
> >> --- a/init/main.c
> >> +++ b/init/main.c
> >> @@ -694,6 +694,9 @@ asmlinkage __visible void __init start_kernel(void)
> >>       debug_objects_mem_init();
> >>       setup_per_cpu_pageset();
> >>       numa_policy_init();
> >> +     if (IS_ENABLED(CONFIG_EFI) &&
> >> +         (IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_ARM)))
> >> +             efi_enter_virtual_mode();
> >
> > Hmm, this is ugly as hell. Is there nothing else we can piggy-back off?
> > It's also fairly jarring that, on x86, efi_enter_virtual_mode() is called
> > a few lines later, *after* acpi_early_init() has been called.
> >
> 
> Currently, there is a gap where we have already torn down the early
> mapping and haven't created the definitive mapping of the UEFI memory
> map. There are other reasons why this is an issue, and I recently
> proposed [0] myself to address one of them (and I didn't remember this
> particular series, or the fact that I actually suggested this approach
> IIRC)
> 
> Akashi-san, could you please confirm whether the patch below would be
> sufficient for you? Apologies for going back and forth on this, but I
> agree with Will that we should try to avoid warts like the one above
> in generic code.
> 
> [0] https://marc.info/?l=linux-efi&m=152930773507524&w=2

I think that this patch will also work.
Please drop my patch#2 and #3 if you want to pick up my patchset, Will.

Thanks,
-Takahiro AKASHI


> > The rest of the series looks fine to me, but I'm not comfortable taking
> > changes like this via the arm64 tree.
> >
> > Will
