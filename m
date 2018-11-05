Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE8FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9732081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVcWicKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9732081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbeKFGGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:06:22 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33181 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbeKFGGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:06:22 -0500
Received: by mail-it1-f194.google.com with SMTP id p11-v6so8663534itf.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 12:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0KKLKawLAUyul1EhydR8qJG3GdG6bI+jwIu8g0xmbpg=;
        b=GVcWicKGpP93aVd6xiZ+5iwWD+RUHCAk1SOv89bcNimRvzYlpd3YPghaBYgbf95FOe
         SjDbetYdMbAV4n714Ka2+Z59pb6oK8lWpXRDVeFnZNBu2VaRrweDrbDiF513CyusGYAa
         gvcYf3I0IBunKejJjKhIr/pSrmyae6NJNotGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0KKLKawLAUyul1EhydR8qJG3GdG6bI+jwIu8g0xmbpg=;
        b=TTkO4Jz92JfNwElR0/Oi2ru+5peXH7p+Q9lWx+MO6LLfjxASAe+mqlQuhy4uVkG2iZ
         D8eWeqVBE05oFy7ocf5SN8S+Izt6FP9yK3nhrJ00JDoXUKV9RSFaFIVvhOZqgzCaUmMq
         xMyTlMGIgl6ixNK0aeVG9lQqeRZEeFZv38//ZkbBmkEU+xybo8bF0R2rlASy9t/vHQP1
         WHvY05WUL55OJ0N/o+CJAk8NKppa9/chqVBSrhHeg5itdTvMGyji9/EJYSVasJn0xKIM
         oqKy/NNZpI0TU9LZ/iZi4R+VN8hTA5K+RGyt+RR9pCxkGJHxC5m38yfKE1eMX44VOHDO
         OBaQ==
X-Gm-Message-State: AGRZ1gJ9ADnWMpdWd00KPosraoz9d3VICmdt4z69LtM5hQFNmJfAnqpL
        3VIeRmxYjEPo8gFFV+yf6sC7CPfJhdsFOdw+PukrfQ==
X-Google-Smtp-Source: AJdET5dHtUpVmveSoNx8xT0Wnqvc43+ByDXXGFO8QzNIAIi9Ah96XEEOu53nlKwwxPE8dd8v2wgn6WEt30OwJi+Nzww=
X-Received: by 2002:a02:8449:: with SMTP id l9-v6mr9161869jah.130.1541450691633;
 Mon, 05 Nov 2018 12:44:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 12:44:51 -0800 (PST)
In-Reply-To: <537b8384-629a-770b-e506-f4d49b92e758@gmail.com>
References: <20181031192843.13230-1-f.fainelli@gmail.com> <20181031192843.13230-5-f.fainelli@gmail.com>
 <CAKv+Gu85kRVos-z+1WuV5J8bTHpLDDdUu0hVD2NmZ-w-ry5f4g@mail.gmail.com> <537b8384-629a-770b-e506-f4d49b92e758@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Nov 2018 21:44:51 +0100
Message-ID: <CAKv+Gu88HHe-ZpVS3w+0Eu+Q-zYaN3sKDK4uaG+eecVtr-C9PA@mail.gmail.com>
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

On 5 November 2018 at 21:41, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 11/5/18 12:39 PM, Ard Biesheuvel wrote:
>> Hi Florian,
>>
>> On 31 October 2018 at 20:28, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> ARM64 is the only architecture that re-defines
>>> __early_init_dt_declare_initrd() in order for that function to populate
>>> initrd_start/initrd_end with physical addresses instead of virtual
>>> addresses. Instead of having an override we can leverage
>>> drivers/of/fdt.c populating phys_initrd_start/phys_initrd_size to
>>> populate those variables for us.
>>>
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>> ---
>>>  arch/arm64/mm/init.c | 19 +++++++++----------
>>>  1 file changed, 9 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>> index 3cf87341859f..00ef2166bb73 100644
>>> --- a/arch/arm64/mm/init.c
>>> +++ b/arch/arm64/mm/init.c
>>> @@ -72,8 +72,8 @@ static int __init early_initrd(char *p)
>>>         if (*endp == ',') {
>>>                 size = memparse(endp + 1, NULL);
>>>
>>> -               initrd_start = start;
>>> -               initrd_end = start + size;
>>> +               phys_initrd_start = start;
>>> +               phys_initrd_size = size;
>>>         }
>>>         return 0;
>>>  }
>>> @@ -408,14 +408,14 @@ void __init arm64_memblock_init(void)
>>>                 memblock_add(__pa_symbol(_text), (u64)(_end - _text));
>>>         }
>>>
>>> -       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
>>> +       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
>>>                 /*
>>>                  * Add back the memory we just removed if it results in the
>>>                  * initrd to become inaccessible via the linear mapping.
>>>                  * Otherwise, this is a no-op
>>>                  */
>>> -               u64 base = initrd_start & PAGE_MASK;
>>> -               u64 size = PAGE_ALIGN(initrd_end) - base;
>>> +               u64 base = phys_initrd_start & PAGE_MASK;
>>> +               u64 size = PAGE_ALIGN(phys_initrd_size);
>>>
>>>                 /*
>>>                  * We can only add back the initrd memory if we don't end up
>>> @@ -460,12 +460,11 @@ void __init arm64_memblock_init(void)
>>>          */
>>>         memblock_reserve(__pa_symbol(_text), _end - _text);
>>>  #ifdef CONFIG_BLK_DEV_INITRD
>>> -       if (initrd_start) {
>>> -               memblock_reserve(initrd_start, initrd_end - initrd_start);
>>> -
>>> +       if (phys_initrd_size) {
>>>                 /* the generic initrd code expects virtual addresses */
>>> -               initrd_start = __phys_to_virt(initrd_start);
>>> -               initrd_end = __phys_to_virt(initrd_end);
>>> +               initrd_start = __phys_to_virt(phys_initrd_start);
>>> +               initrd_end = initrd_start + phys_initrd_size;
>>> +               initrd_below_start_ok = 0;
>>
>> Where is this assignment coming from?
>
> __early_init_dt_declare_initrd() sets initrd_below_start_ok to 1 though
> after patch #5 this is not necessary any more.

Yes, but why? The original arm64 version of
__early_init_dt_declare_initrd() does not set it but now you set to 1
in the IS_ENABLED(CONFIG_ARM64) section in the generic code and set it
back to 0 here.

Or am I missing something?
