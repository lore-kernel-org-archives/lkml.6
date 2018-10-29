Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83ABECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640F52082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2c2fTDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640F52082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeJ3Gsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:48:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38838 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeJ3Gsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:48:45 -0400
Received: by mail-io1-f65.google.com with SMTP id q18-v6so6014470iod.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZKkdV+Lsv7o74Uq/K4tBFdG32VfGm2CSxGpq37Oln/c=;
        b=J2c2fTDv0gHhUeyK+QiCX1pqkRrQ4LkTwZvu90GU0Vbra5jnAoIVRXZ8vD7kcr6NRW
         FnNbBUtW+jgMuVxVCG0dJ8YK2Dbs9JpTkYpthluTYc64NqHemtVCB0yfPXRjZQNMWtNf
         VupS+9R74izL1p7DhjbVH+rfRgUG7UOhYAFKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZKkdV+Lsv7o74Uq/K4tBFdG32VfGm2CSxGpq37Oln/c=;
        b=ClQHQsS2V2pDv0vzZL1yLFOtrlmJ4SCaFRI8HrmRmGTXfesFpW6Dq1if4hbzOq1NOK
         q5dhbhTvczAgifxV7SLhfb2z60FzWZZfUp6H7CT/zputudDSuFJNCAsjc5J9fNha9B4l
         M5UE+fVogugN3/XFKqUYqSkIFkmyInaxnfOyaxYP6NpkmE12EiD6pigPSqab/2fK7oYh
         7EzvVGYQ5O5gMbF0/Rit/g5PEesJBx/f5UAjoyb2Ipwmej9emcmp/Yp2BZdchEt8terC
         ZmsFV2apLIx5dGe+JI0V+4M/pwEtAdLS5akkm1NXZlIagN9VHatpltfC7PmJQhVx8NQF
         r4hA==
X-Gm-Message-State: AGRZ1gKxeXik9DHxoIeKfnawTxwoPcwwfCaduREFgq2arMpVTaP4Ez3s
        UaZqWxC+Q7sJIA0Ty9USejZznE85fHuctb/tLGA78A==
X-Google-Smtp-Source: AJdET5et4uDioYw4piN2DdoJjHZ5hsSTJ6kKvBB3yNxaT0mbebsbBPl8l32TSpqiARTOdTCEslXOgni4LqR4xk9lkQs=
X-Received: by 2002:a6b:3707:: with SMTP id e7-v6mr10049878ioa.60.1540850289853;
 Mon, 29 Oct 2018 14:58:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 29 Oct 2018 14:58:09
 -0700 (PDT)
In-Reply-To: <CAL_JsqL2g69Duhkqd=f09BStoAKeakJz8Wgz3is37YU0+fc80A@mail.gmail.com>
References: <20181029190014.6455-1-f.fainelli@gmail.com> <20181029190014.6455-2-f.fainelli@gmail.com>
 <CAL_JsqL2g69Duhkqd=f09BStoAKeakJz8Wgz3is37YU0+fc80A@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 29 Oct 2018 18:58:09 -0300
Message-ID: <CAKv+Gu-5vpSJDs3RdTtspO3WmbqTE4YQDWj2us4YOP2zi1PDTg@mail.gmail.com>
Subject: Re: [PATCH 1/2 v5] arm64: Get rid of __early_init_dt_declare_initrd()
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rppt@linux.ibm.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>, ghackmann@android.com,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        chandan.vn@samsung.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 October 2018 at 16:59, Rob Herring <robh+dt@kernel.org> wrote:
> +Ard who last touched this.
>
> On Mon, Oct 29, 2018 at 2:23 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> ARM64 is the only architecture that re-defines
>> __early_init_dt_declare_initrd() in order for that function to populate
>> initrd_start/initrd_end with physical addresses instead of virtual
>> addresses. Instead of having an override, just get rid of that
>> implementation and perform the virtual to physical conversion of these
>> addresses in arm64_memblock_init() where relevant.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>> ---
>>  arch/arm64/include/asm/memory.h |  8 -------
>>  arch/arm64/mm/init.c            | 42 +++++++++++++++++++++------------
>>  2 files changed, 27 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index b96442960aea..dc3ca21ba240 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -168,14 +168,6 @@
>>  #define IOREMAP_MAX_ORDER      (PMD_SHIFT)
>>  #endif
>>
>> -#ifdef CONFIG_BLK_DEV_INITRD
>> -#define __early_init_dt_declare_initrd(__start, __end)                 \
>> -       do {                                                            \
>> -               initrd_start = (__start);                               \
>> -               initrd_end = (__end);                                   \
>> -       } while (0)
>> -#endif
>> -
>>  #ifndef __ASSEMBLY__
>>
>>  #include <linux/bitops.h>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 3cf87341859f..292570b08f85 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -62,6 +62,8 @@
>>  s64 memstart_addr __ro_after_init = -1;
>>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>
>> +static phys_addr_t phys_initrd_start, phys_initrd_end;
>> +
>>  #ifdef CONFIG_BLK_DEV_INITRD
>>  static int __init early_initrd(char *p)
>>  {
>> @@ -72,8 +74,8 @@ static int __init early_initrd(char *p)
>>         if (*endp == ',') {
>>                 size = memparse(endp + 1, NULL);
>>
>> -               initrd_start = start;
>> -               initrd_end = start + size;
>> +               phys_initrd_start = start;
>> +               phys_initrd_end = start + size;
>>         }
>>         return 0;
>>  }
>> @@ -364,6 +366,7 @@ static void __init fdt_enforce_memory_region(void)
>>  void __init arm64_memblock_init(void)
>>  {
>>         const s64 linear_region_size = -(s64)PAGE_OFFSET;
>> +       u64 __maybe_unused base, size;
>>
>>         /* Handle linux,usable-memory-range property */
>>         fdt_enforce_memory_region();
>> @@ -408,14 +411,25 @@ void __init arm64_memblock_init(void)
>>                 memblock_add(__pa_symbol(_text), (u64)(_end - _text));
>>         }
>>
>> -       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
>> +       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
>> +           (initrd_start || phys_initrd_start)) {
>
> I've tried to explain already that this is broken. The problem is
> __early_init_dt_declare_initrd using __va() which happens before this
> function is called. __va() uses PHYS_OFFSET which in turn is defined
> as memstart_addr. However, memstart_addr may be changed just above
> this hunk, so the earlier conversion to a VA may not be valid at this
> point. This is explained if you read Ard's commit that added all this
> mess.
>
> You could fix this by converting back to a PA before adjusting
> memstart_addr, but that's 2 wrongs making a right and fragile. The
> better solution is the other proposal making the DT code set
> phys_initrd_* (whatever the ARM code calls them).
>

On arm64, we have

#define PHYS_OFFSET \
  ({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })

and

s64 memstart_addr __ro_after_init = -1;

IOW, any attempt to perform PA to VA translations before memstart_addr
is assigned will BUG() if CONFIG_DEBUG_VM=y, so please enable that
when playing with this code.

The reason we have this code is because the start of the linear region
might not coincide with memblock_start_of_DRAM(), which could happen,
e.g., when running a 39-bit VA kernel on a system with a very sparse
memory map (which is unfortunately what some silicon vendors think is
what ARM recommends) and the kernel loaded near the top of that
memory. The ability to load the kernel anywhere in physical memory was
introduced to accommodate physical KASLR.

Ideally, we'd fix this by only recording physical addresses for the
initrd in generic code, and deferring the translation until the point
where we actually do the access.

>>                 /*
>>                  * Add back the memory we just removed if it results in the
>>                  * initrd to become inaccessible via the linear mapping.
>>                  * Otherwise, this is a no-op
>>                  */
>> -               u64 base = initrd_start & PAGE_MASK;
>> -               u64 size = PAGE_ALIGN(initrd_end) - base;
>> +               if (phys_initrd_start) {
>> +                       /* Command line specified the initrd location */
>> +                       initrd_start = __phys_to_virt(phys_initrd_start);
>> +                       initrd_end = __phys_to_virt(phys_initrd_end);
>> +               } else if (initrd_start) {
>> +                       /* FDT specified the initrd location */
>> +                       phys_initrd_start = __pa(initrd_start);
>> +                       phys_initrd_end = __pa(initrd_end);
>
> Kind of inconsistent to mix __phys_to_virt and __pa flavors.
>
> Rob
