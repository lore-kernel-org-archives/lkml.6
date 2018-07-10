Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48D1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9216D20B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9216D20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389569AbeGJSnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:43:49 -0400
Received: from foss.arm.com ([217.140.101.70]:51804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389001AbeGJSdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:33:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE6591BA8;
        Tue, 10 Jul 2018 10:57:36 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2937F3F589;
        Tue, 10 Jul 2018 10:57:33 -0700 (PDT)
Subject: Re: [PATCH v3.1 2/4] efi/arm: preserve early mapping of UEFI memory
 map longer for BGRT
To:     ard.biesheuvel@linaro.org
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
 <20180709234229.20181-3-takahiro.akashi@linaro.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <93c42065-bece-a4c7-ed99-5e98f91315a6@arm.com>
Date:   Tue, 10 Jul 2018 18:57:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709234229.20181-3-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On 10/07/18 00:42, AKASHI Takahiro wrote:
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> The BGRT code validates the contents of the table against the UEFI
> memory map, and so it expects it to be mapped when the code runs.
> 
> On ARM, this is currently not the case, since we tear down the early
> mapping after efi_init() completes, and only create the permanent
> mapping in arm_enable_runtime_services(), which executes as an early
> initcall, but still leaves a window where the UEFI memory map is not
> mapped.
> 
> So move the call to efi_memmap_unmap() from efi_init() to
> arm_enable_runtime_services().

I don't have a machine that generates a BGRT, but I can see that efi_mem_type()
call in efi_bgrt_init() would cause the same problems we have with kexec and acpi.


> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> index b5214c143fee..388a929baf95 100644
> --- a/drivers/firmware/efi/arm-init.c
> +++ b/drivers/firmware/efi/arm-init.c
> @@ -259,7 +259,6 @@ void __init efi_init(void)
>  
>  	reserve_regions();
>  	efi_esrt_init();
> -	efi_memmap_unmap();
>  
>  	memblock_reserve(params.mmap & PAGE_MASK,
>  			 PAGE_ALIGN(params.mmap_size +
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 5889cbea60b8..59a8c0ec94d5 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -115,6 +115,8 @@ static int __init arm_enable_runtime_services(void)
>  		return 0;
>  	}
>  
> +	efi_memmap_unmap();

This can get called twice if uefi_init() fails after setting the EFI_BOOT flag,
but this can only happen if the system table signature is wrong, (or we're out
of memory really early).

I think this is harmless as we end up passing NULL to early_memunmap() which
WARN()s and returns as its outside the fixmap range. Its just more noise on
systems with a corrupt efi system table.

Acked-by: James Morse <james.morse@arm.com>


Thanks,

James
