Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13242C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20982084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCg/DHwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20982084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbeKFG3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:29:08 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52635 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeKFG3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:29:08 -0500
Received: by mail-it1-f193.google.com with SMTP id t190-v6so9155728itb.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 13:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YGpokWZ/1YB0O6/hfj/m240iDE+ATcyb/gBZvxQzu4M=;
        b=cCg/DHwV/eRHBx0n8B4zJoklHY4CgoBePtwkvWP3Cjq8EkZil1OfTaGGnWNF16/1ZI
         WRodIROfTCQJU2fXr7EBe5Nkh8A298ELirL/VxevX/Y5mlAXKR5t2N5z+rAWRL8Z0+yh
         DzVltWIvlJltzM4igwBVHVFl1XH3PrKT5DjUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YGpokWZ/1YB0O6/hfj/m240iDE+ATcyb/gBZvxQzu4M=;
        b=YQ90gAQ98nBM7naAnKfSivYZfraPcasEo9vlrwcJtdl3GK17kYF2zb50JebGvvsTku
         ibpvWC5ZDN9NAut5Wf2PQlb6YkrT1HpR23h6afI2JqLpxcqJ7FyIvhX6rZtoSSrCJZQO
         tlb0kBuTeMXcFJB6NeJRSGPpw6/hhTvy3XwD9O3Rs0OspEUgftAL7gtk8Lh2pev4cDzX
         vZ6XgrJ9jYait61UfXiF8N0l8Q9Jyy6p7xjhn7tkZN6ewiSsOzc+nNJN2eeCUyHXq7MR
         D7TIIWdCQ4pNFU+S1uzydcGEKmVssPBkdyovo9+A985LjzRQQ4+7qPugXQZEx3kWQv1u
         MRUA==
X-Gm-Message-State: AGRZ1gLRQ+I3TP839ZUQcwxHWe3YaabtlYiRoGi6StBXFmz2DDrgZZ6X
        MzJXN7vdF94zTQOSYruWpBgutKcmKSU8DEyDQ/ZA7g==
X-Google-Smtp-Source: AJdET5d2451TZRf2UDvQt32uOEMskK3+/krDs0bwX4q0Jdr8DU4DOvWiMB8nyKyytKUoQ3YGTJ+evpuRXHppLgRuhVA=
X-Received: by 2002:a24:d3c2:: with SMTP id n185-v6mr8409203itg.71.1541452052745;
 Mon, 05 Nov 2018 13:07:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 13:07:32 -0800 (PST)
In-Reply-To: <7de7d83b-fcd4-a11f-a10d-1e20a871caa4@gmail.com>
References: <20181031192843.13230-1-f.fainelli@gmail.com> <20181031192843.13230-5-f.fainelli@gmail.com>
 <CAKv+Gu85kRVos-z+1WuV5J8bTHpLDDdUu0hVD2NmZ-w-ry5f4g@mail.gmail.com>
 <537b8384-629a-770b-e506-f4d49b92e758@gmail.com> <CAKv+Gu88HHe-ZpVS3w+0Eu+Q-zYaN3sKDK4uaG+eecVtr-C9PA@mail.gmail.com>
 <0257ee07-8b85-5295-1490-72c7aa14943d@gmail.com> <CAKv+Gu8-ZbNx+oQPfHRVbWrBi4K+sa7JA_5KKSMn2QbStc8kNQ@mail.gmail.com>
 <7de7d83b-fcd4-a11f-a10d-1e20a871caa4@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Nov 2018 22:07:32 +0100
Message-ID: <CAKv+Gu9YKmMCF5YnCRcsZMBjjAc1L+phtO2=y+5K7Ja385Mx1A@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] arm64: Utilize phys_initrd_start/phys_initrd_size
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Hackmann <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, rppt@linux.ibm.com,
        Russell King <linux@armlinux.org.uk>, green.hu@gmail.com,
        deanbo422@gmail.com, gxt@pku.edu.cn,
        linux-snps-arc@lists.infradead.org, vgupta@synopsys.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 November 2018 at 22:05, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 11/5/18 1:00 PM, Ard Biesheuvel wrote:
>> On 5 November 2018 at 21:51, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> On 11/5/18 12:44 PM, Ard Biesheuvel wrote:
>>>> On 5 November 2018 at 21:41, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>> On 11/5/18 12:39 PM, Ard Biesheuvel wrote:
>>>>>> Hi Florian,
>>>>>>
>>>>>> On 31 October 2018 at 20:28, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>>>> ARM64 is the only architecture that re-defines
>>>>>>> __early_init_dt_declare_initrd() in order for that function to populate
>>>>>>> initrd_start/initrd_end with physical addresses instead of virtual
>>>>>>> addresses. Instead of having an override we can leverage
>>>>>>> drivers/of/fdt.c populating phys_initrd_start/phys_initrd_size to
>>>>>>> populate those variables for us.
>>>>>>>
>>>>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>>>>> ---
>>>>>>>  arch/arm64/mm/init.c | 19 +++++++++----------
>>>>>>>  1 file changed, 9 insertions(+), 10 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>>>>>> index 3cf87341859f..00ef2166bb73 100644
>>>>>>> --- a/arch/arm64/mm/init.c
>>>>>>> +++ b/arch/arm64/mm/init.c
>>>>>>> @@ -72,8 +72,8 @@ static int __init early_initrd(char *p)
>>>>>>>         if (*endp == ',') {
>>>>>>>                 size = memparse(endp + 1, NULL);
>>>>>>>
>>>>>>> -               initrd_start = start;
>>>>>>> -               initrd_end = start + size;
>>>>>>> +               phys_initrd_start = start;
>>>>>>> +               phys_initrd_size = size;
>>>>>>>         }
>>>>>>>         return 0;
>>>>>>>  }
>>>>>>> @@ -408,14 +408,14 @@ void __init arm64_memblock_init(void)
>>>>>>>                 memblock_add(__pa_symbol(_text), (u64)(_end - _text));
>>>>>>>         }
>>>>>>>
>>>>>>> -       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
>>>>>>> +       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
>>>>>>>                 /*
>>>>>>>                  * Add back the memory we just removed if it results in the
>>>>>>>                  * initrd to become inaccessible via the linear mapping.
>>>>>>>                  * Otherwise, this is a no-op
>>>>>>>                  */
>>>>>>> -               u64 base = initrd_start & PAGE_MASK;
>>>>>>> -               u64 size = PAGE_ALIGN(initrd_end) - base;
>>>>>>> +               u64 base = phys_initrd_start & PAGE_MASK;
>>>>>>> +               u64 size = PAGE_ALIGN(phys_initrd_size);
>>>>>>>
>>>>>>>                 /*
>>>>>>>                  * We can only add back the initrd memory if we don't end up
>>>>>>> @@ -460,12 +460,11 @@ void __init arm64_memblock_init(void)
>>>>>>>          */
>>>>>>>         memblock_reserve(__pa_symbol(_text), _end - _text);
>>>>>>>  #ifdef CONFIG_BLK_DEV_INITRD
>>>>>>> -       if (initrd_start) {
>>>>>>> -               memblock_reserve(initrd_start, initrd_end - initrd_start);
>>>>>>> -
>>>>>>> +       if (phys_initrd_size) {
>>>>>>>                 /* the generic initrd code expects virtual addresses */
>>>>>>> -               initrd_start = __phys_to_virt(initrd_start);
>>>>>>> -               initrd_end = __phys_to_virt(initrd_end);
>>>>>>> +               initrd_start = __phys_to_virt(phys_initrd_start);
>>>>>>> +               initrd_end = initrd_start + phys_initrd_size;
>>>>>>> +               initrd_below_start_ok = 0;
>>>>>>
>>>>>> Where is this assignment coming from?
>>>>>
>>>>> __early_init_dt_declare_initrd() sets initrd_below_start_ok to 1 though
>>>>> after patch #5 this is not necessary any more.
>>>>
>>>> Yes, but why? The original arm64 version of
>>>> __early_init_dt_declare_initrd() does not set it but now you set to 1
>>>> in the IS_ENABLED(CONFIG_ARM64) section in the generic code and set it
>>>> back to 0 here.
>>>
>>> Humm, it is an if (!IS_ENABLED(CONFIG_ARM64)) condition, so we would not
>>> be taking that branch on an ARM64 kernel.
>>>
>>
>> Right. So now that we are not setting it to 1 on arm64, there is no
>> longer a reason to set it to 0 again, no?
>
> Correct, and in fact, this is not a problem either at patch #4 (which
> has the custom __early_init_dt_declare_initrd()) or #5 (which removes
> it), any other feedback you would like me to address before addressing
> Rob's suggestion?
>

No, I think this is ok. The conditional on arm64 in generic code is a
bit nasty, and it would be nicer generally if we only have to record a
single memory range, but if this fixes the issue you were addressing
originally, I'm fine with it.
