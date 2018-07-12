Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBA5C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA93213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA93213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbeGLNlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:41:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51032 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbeGLNlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:41:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E35A180D;
        Thu, 12 Jul 2018 06:31:38 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B366F3F5B1;
        Thu, 12 Jul 2018 06:31:38 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id F04E11AE53FB; Thu, 12 Jul 2018 14:32:20 +0100 (BST)
Date:   Thu, 12 Jul 2018 14:32:20 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     James Morse <james.morse@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Baicar, Tyler" <tbaicar@codeaurora.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Stone <al.stone@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Subject: Re: [PATCH v3.1 2/4] efi/arm: preserve early mapping of UEFI memory
 map longer for BGRT
Message-ID: <20180712133220.GA21647@arm.com>
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
 <20180709234229.20181-3-takahiro.akashi@linaro.org>
 <93c42065-bece-a4c7-ed99-5e98f91315a6@arm.com>
 <CAKv+Gu_fajf3_P0wKpdV34Ungu=fn0=WG1U_MSQ9WF_2GFRfDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_fajf3_P0wKpdV34Ungu=fn0=WG1U_MSQ9WF_2GFRfDA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 08:39:16PM +0200, Ard Biesheuvel wrote:
> On 10 July 2018 at 19:57, James Morse <james.morse@arm.com> wrote:
> > Hi Ard,
> >
> > On 10/07/18 00:42, AKASHI Takahiro wrote:
> >> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>
> >> The BGRT code validates the contents of the table against the UEFI
> >> memory map, and so it expects it to be mapped when the code runs.
> >>
> >> On ARM, this is currently not the case, since we tear down the early
> >> mapping after efi_init() completes, and only create the permanent
> >> mapping in arm_enable_runtime_services(), which executes as an early
> >> initcall, but still leaves a window where the UEFI memory map is not
> >> mapped.
> >>
> >> So move the call to efi_memmap_unmap() from efi_init() to
> >> arm_enable_runtime_services().
> >
> > I don't have a machine that generates a BGRT, but I can see that efi_mem_type()
> > call in efi_bgrt_init() would cause the same problems we have with kexec and acpi.
> >
> 
> I'm not sure I follow. The BGRT table only contains natively aligned
> fields, so the alignment faults should not occur when accessing this
> table after kexec. The issue addressed by this patch is that
> efi_mem_type() bails when called while EFI_MEMMAP is cleared.
> 
> >
> >> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> >> index b5214c143fee..388a929baf95 100644
> >> --- a/drivers/firmware/efi/arm-init.c
> >> +++ b/drivers/firmware/efi/arm-init.c
> >> @@ -259,7 +259,6 @@ void __init efi_init(void)
> >>
> >>       reserve_regions();
> >>       efi_esrt_init();
> >> -     efi_memmap_unmap();
> >>
> >>       memblock_reserve(params.mmap & PAGE_MASK,
> >>                        PAGE_ALIGN(params.mmap_size +
> >> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> >> index 5889cbea60b8..59a8c0ec94d5 100644
> >> --- a/drivers/firmware/efi/arm-runtime.c
> >> +++ b/drivers/firmware/efi/arm-runtime.c
> >> @@ -115,6 +115,8 @@ static int __init arm_enable_runtime_services(void)
> >>               return 0;
> >>       }
> >>
> >> +     efi_memmap_unmap();
> >
> > This can get called twice if uefi_init() fails after setting the EFI_BOOT flag,
> > but this can only happen if the system table signature is wrong, (or we're out
> > of memory really early).
> >
> 
> I guess we should check the EFI_MEMMAP attribute here as well then.

Do you plan to spin a new version of this patch?

Will
