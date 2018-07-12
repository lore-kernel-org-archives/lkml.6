Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43F0C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10A1213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AhhyUlOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10A1213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732412AbeGLOXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:23:47 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53090 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeGLOXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:23:46 -0400
Received: by mail-it0-f66.google.com with SMTP id p4-v6so7019779itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 07:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KvfAo8SDQ5+PyIA7ArOk5rdKdqRapsK9s15MKvPJWLo=;
        b=AhhyUlOuYBx9a4EDtRvqU3F7pJofU4HAoAI9k038G9Fmhu5l94ZMxlgc9b9CtSNcfI
         NqTBsoZUJzjgzzYzvfmWw4BLk7pwgIDwFUxK9BoT3ukVJvZnLh3PktdglHbN0IpA9cHk
         sq7YMwqaU9xh83v2jjcRHKHpbEXrmgGxbbizU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KvfAo8SDQ5+PyIA7ArOk5rdKdqRapsK9s15MKvPJWLo=;
        b=uYZCIOxOl575qGGY2QP/wUe/6yJN42BTWiZbO/9j68noqU0HK9m2zQJ2bfeKzl+iyI
         wvb4C8IbpQEliPN35/81MYQzpU1DbfS/UJhwehqo/CBfIqCh5zST0zgjHtv0QOUEszHK
         zVXBR5xzNuZhKtY8NWZ3e06sA41pgNGpaICgYajXSSjBSn/d8TjwYjLYwEoDiexelD7Y
         Hka1J4ds67MO0Bk1BhdGsCT+UeYdQbwvnaJPQGhD+2x4DAu7lg3HYSkL5w7xSi9D6hO3
         CYDmn70qKhIrWE/W1huSCZtF15ejf59+olUk9KnDfu7mTEX4h7gMi4SK/e05m5iD4Tji
         4HWg==
X-Gm-Message-State: AOUpUlFfr3Z9XsFdzsfguNLJ1lrDCorCj0GG9qui50YyqL/ZFrqjuOMn
        qfs8lqcXuKzuVQi6V+HWsy+w+HFB/CbxlvROeFOxbw==
X-Google-Smtp-Source: AAOMgpemUgTwBhfMPkBeDydynTFvFN2xPNWS7R7j3kEalx7fX/eZiFtPHSoCU9bgOFzl1+Jon17fXInREcummyfphaw=
X-Received: by 2002:a24:6196:: with SMTP id s144-v6mr1450084itc.68.1531404841008;
 Thu, 12 Jul 2018 07:14:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 07:14:00
 -0700 (PDT)
In-Reply-To: <20180712133220.GA21647@arm.com>
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
 <20180709234229.20181-3-takahiro.akashi@linaro.org> <93c42065-bece-a4c7-ed99-5e98f91315a6@arm.com>
 <CAKv+Gu_fajf3_P0wKpdV34Ungu=fn0=WG1U_MSQ9WF_2GFRfDA@mail.gmail.com> <20180712133220.GA21647@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 12 Jul 2018 16:14:00 +0200
Message-ID: <CAKv+Gu_+XcOFfJBhVaQp3yUZ36Q5gS47vJzFMniwQ2DZp062tw@mail.gmail.com>
Subject: Re: [PATCH v3.1 2/4] efi/arm: preserve early mapping of UEFI memory
 map longer for BGRT
To:     Will Deacon <will.deacon@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 July 2018 at 15:32, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jul 10, 2018 at 08:39:16PM +0200, Ard Biesheuvel wrote:
>> On 10 July 2018 at 19:57, James Morse <james.morse@arm.com> wrote:
>> > Hi Ard,
>> >
>> > On 10/07/18 00:42, AKASHI Takahiro wrote:
>> >> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >>
>> >> The BGRT code validates the contents of the table against the UEFI
>> >> memory map, and so it expects it to be mapped when the code runs.
>> >>
>> >> On ARM, this is currently not the case, since we tear down the early
>> >> mapping after efi_init() completes, and only create the permanent
>> >> mapping in arm_enable_runtime_services(), which executes as an early
>> >> initcall, but still leaves a window where the UEFI memory map is not
>> >> mapped.
>> >>
>> >> So move the call to efi_memmap_unmap() from efi_init() to
>> >> arm_enable_runtime_services().
>> >
>> > I don't have a machine that generates a BGRT, but I can see that efi_mem_type()
>> > call in efi_bgrt_init() would cause the same problems we have with kexec and acpi.
>> >
>>
>> I'm not sure I follow. The BGRT table only contains natively aligned
>> fields, so the alignment faults should not occur when accessing this
>> table after kexec. The issue addressed by this patch is that
>> efi_mem_type() bails when called while EFI_MEMMAP is cleared.
>>
>> >
>> >> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
>> >> index b5214c143fee..388a929baf95 100644
>> >> --- a/drivers/firmware/efi/arm-init.c
>> >> +++ b/drivers/firmware/efi/arm-init.c
>> >> @@ -259,7 +259,6 @@ void __init efi_init(void)
>> >>
>> >>       reserve_regions();
>> >>       efi_esrt_init();
>> >> -     efi_memmap_unmap();
>> >>
>> >>       memblock_reserve(params.mmap & PAGE_MASK,
>> >>                        PAGE_ALIGN(params.mmap_size +
>> >> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
>> >> index 5889cbea60b8..59a8c0ec94d5 100644
>> >> --- a/drivers/firmware/efi/arm-runtime.c
>> >> +++ b/drivers/firmware/efi/arm-runtime.c
>> >> @@ -115,6 +115,8 @@ static int __init arm_enable_runtime_services(void)
>> >>               return 0;
>> >>       }
>> >>
>> >> +     efi_memmap_unmap();
>> >
>> > This can get called twice if uefi_init() fails after setting the EFI_BOOT flag,
>> > but this can only happen if the system table signature is wrong, (or we're out
>> > of memory really early).
>> >
>>
>> I guess we should check the EFI_MEMMAP attribute here as well then.
>
> Do you plan to spin a new version of this patch?
>

Either that or fold in the hunk below.


--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -110,7 +110,7 @@ static int __init arm_enable_runtime_services(void)
 {
        u64 mapsize;

-       if (!efi_enabled(EFI_BOOT)) {
+       if (!efi_enabled(EFI_BOOT) || !efi_enabled(EFI_MEMMAP)) {
                pr_info("EFI services will not be available.\n");
                return 0;
        }
