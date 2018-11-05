Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C11C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26B120827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EAgFyOQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26B120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbeKFGVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:21:44 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51979 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFGVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:21:43 -0500
Received: by mail-it1-f196.google.com with SMTP id h13so14867825itl.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 13:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cMCA9LKucrxYPRqZgaduaDwFlyVs9QNnd8Nv6QfrNCk=;
        b=EAgFyOQxGYMqDWF4br+8FboBAQlwrsatsimt0P5LIJwjYHPaT0PAZ7SBhSLBMzf5va
         BrRH3RlZXi9s7Clhwh707n0K2U1116L19eq4BjSOJcJB2Ss0eBgv6LRDZ7LYh6dHgQF9
         Pip5lvffSUMvmNWqVVSw/34M+jQ3zEbWVPHSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cMCA9LKucrxYPRqZgaduaDwFlyVs9QNnd8Nv6QfrNCk=;
        b=fUuJE3J7OsMlJ0DO4PVlXDEeSgLN0099xTx5haw4k9al1KnflOzMqvq632t7f/6k64
         Vze4xpMi0vUBzUqKTCozFCSu1ux9qmw9qVQQqzObe0RDet7HtOeOhDdKZNG4hCv7ErYQ
         WlmKti6KfRoy+8tjxrPv+EaBsRG4SAz770yh5kbqRTxGtMBXfn/w1jCe0bHtC3dyb1uC
         L7VnDIwiE+HpHkT6cqsmrZP8K76CqOn9nnsW8GN99PoEFFOtpGlbcQvTaF4zaqZp4T0y
         Ac6QbNXBYkfMcT8bjq7qpOn79coeD6HdyFSCGtB1nnk3001Lynv5nzQNCFRJPwtN3fFG
         EIfw==
X-Gm-Message-State: AGRZ1gLtauswCY7H/WRePSpTKA8qd9oAOTOh+oePx0L39wVXWpjPaEQX
        YBZI3hT14GlbY0RXvadDon2u2cwMzYjaS316cZTYFQ==
X-Google-Smtp-Source: AJdET5fX9uVrGgh6boHqiT3TiagurpN+Ua25xbKS5UzvEMuEKLdoPgBdiYazgyedZPot3Un+A+tUPRnyV7O69vQmxlI=
X-Received: by 2002:a05:660c:383:: with SMTP id x3mr7428147itj.121.1541451609895;
 Mon, 05 Nov 2018 13:00:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 13:00:09 -0800 (PST)
In-Reply-To: <0257ee07-8b85-5295-1490-72c7aa14943d@gmail.com>
References: <20181031192843.13230-1-f.fainelli@gmail.com> <20181031192843.13230-5-f.fainelli@gmail.com>
 <CAKv+Gu85kRVos-z+1WuV5J8bTHpLDDdUu0hVD2NmZ-w-ry5f4g@mail.gmail.com>
 <537b8384-629a-770b-e506-f4d49b92e758@gmail.com> <CAKv+Gu88HHe-ZpVS3w+0Eu+Q-zYaN3sKDK4uaG+eecVtr-C9PA@mail.gmail.com>
 <0257ee07-8b85-5295-1490-72c7aa14943d@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Nov 2018 22:00:09 +0100
Message-ID: <CAKv+Gu8-ZbNx+oQPfHRVbWrBi4K+sa7JA_5KKSMn2QbStc8kNQ@mail.gmail.com>
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

On 5 November 2018 at 21:51, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 11/5/18 12:44 PM, Ard Biesheuvel wrote:
>> On 5 November 2018 at 21:41, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> On 11/5/18 12:39 PM, Ard Biesheuvel wrote:
>>>> Hi Florian,
>>>>
>>>> On 31 October 2018 at 20:28, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>> ARM64 is the only architecture that re-defines
>>>>> __early_init_dt_declare_initrd() in order for that function to populate
>>>>> initrd_start/initrd_end with physical addresses instead of virtual
>>>>> addresses. Instead of having an override we can leverage
>>>>> drivers/of/fdt.c populating phys_initrd_start/phys_initrd_size to
>>>>> populate those variables for us.
>>>>>
>>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>>> ---
>>>>>  arch/arm64/mm/init.c | 19 +++++++++----------
>>>>>  1 file changed, 9 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>>>> index 3cf87341859f..00ef2166bb73 100644
>>>>> --- a/arch/arm64/mm/init.c
>>>>> +++ b/arch/arm64/mm/init.c
>>>>> @@ -72,8 +72,8 @@ static int __init early_initrd(char *p)
>>>>>         if (*endp == ',') {
>>>>>                 size = memparse(endp + 1, NULL);
>>>>>
>>>>> -               initrd_start = start;
>>>>> -               initrd_end = start + size;
>>>>> +               phys_initrd_start = start;
>>>>> +               phys_initrd_size = size;
>>>>>         }
>>>>>         return 0;
>>>>>  }
>>>>> @@ -408,14 +408,14 @@ void __init arm64_memblock_init(void)
>>>>>                 memblock_add(__pa_symbol(_text), (u64)(_end - _text));
>>>>>         }
>>>>>
>>>>> -       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
>>>>> +       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
>>>>>                 /*
>>>>>                  * Add back the memory we just removed if it results in the
>>>>>                  * initrd to become inaccessible via the linear mapping.
>>>>>                  * Otherwise, this is a no-op
>>>>>                  */
>>>>> -               u64 base = initrd_start & PAGE_MASK;
>>>>> -               u64 size = PAGE_ALIGN(initrd_end) - base;
>>>>> +               u64 base = phys_initrd_start & PAGE_MASK;
>>>>> +               u64 size = PAGE_ALIGN(phys_initrd_size);
>>>>>
>>>>>                 /*
>>>>>                  * We can only add back the initrd memory if we don't end up
>>>>> @@ -460,12 +460,11 @@ void __init arm64_memblock_init(void)
>>>>>          */
>>>>>         memblock_reserve(__pa_symbol(_text), _end - _text);
>>>>>  #ifdef CONFIG_BLK_DEV_INITRD
>>>>> -       if (initrd_start) {
>>>>> -               memblock_reserve(initrd_start, initrd_end - initrd_start);
>>>>> -
>>>>> +       if (phys_initrd_size) {
>>>>>                 /* the generic initrd code expects virtual addresses */
>>>>> -               initrd_start = __phys_to_virt(initrd_start);
>>>>> -               initrd_end = __phys_to_virt(initrd_end);
>>>>> +               initrd_start = __phys_to_virt(phys_initrd_start);
>>>>> +               initrd_end = initrd_start + phys_initrd_size;
>>>>> +               initrd_below_start_ok = 0;
>>>>
>>>> Where is this assignment coming from?
>>>
>>> __early_init_dt_declare_initrd() sets initrd_below_start_ok to 1 though
>>> after patch #5 this is not necessary any more.
>>
>> Yes, but why? The original arm64 version of
>> __early_init_dt_declare_initrd() does not set it but now you set to 1
>> in the IS_ENABLED(CONFIG_ARM64) section in the generic code and set it
>> back to 0 here.
>
> Humm, it is an if (!IS_ENABLED(CONFIG_ARM64)) condition, so we would not
> be taking that branch on an ARM64 kernel.
>

Right. So now that we are not setting it to 1 on arm64, there is no
longer a reason to set it to 0 again, no?

> If you are saying the assignment is not necessary anymore after patch #5
> , that is true, though this can only be done a part of part #5, not as
> part of patch #4 in order not to break initrd functionality in-between
> patches.
>
>>
>> Or am I missing something?
>>
>
> Not sure, I could be too, it's Monday after all :)

Yeah :-)
