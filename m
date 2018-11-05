Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B81C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B8D2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BPYM4jWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B8D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbeKFGBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:01:14 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34599 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeKFGBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:01:14 -0500
Received: by mail-io1-f66.google.com with SMTP id d80-v6so7587939iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 12:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7/QHLazXFzCb6Lx1A0MxlXNX6Vz/toQbqlcDVBn5Wlw=;
        b=BPYM4jWY5H8490sRjURexpwuozLhD23quawP+gfZMfL7bjxKg4aQvyHdcTJWLildab
         t42DF0DVAMRWoEd9cNIViIxq4rUp7ZpzdjAMskPDUGwZiAodq6s7sSrqwrGoONmObsvK
         e/OThkhNWBgbVuuxyZegOJGQ9lw77GQ53GLto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7/QHLazXFzCb6Lx1A0MxlXNX6Vz/toQbqlcDVBn5Wlw=;
        b=QiCRuKGz8SKIyg7Qk5bGo2phZnwe0NHd85BC8m6t86UBdAsLsrZ1qX60s3bV2rEfgA
         YEOJcqrUF5UYkKLqbsPq955/sF9U+UycrxKNgXoH8vXR1SZP3VrmdcJ2ziMCdeoZ5VE8
         Uf4cKyfqs/fbuz1vkn0/3raY8Nl4ZDyXvOu++vM2d+XXcWJLRVydlMhLeanM7Wm2m886
         N5XEQyM3SVuW7fXKqCj/8PtP+Y49PemNebawRBTv9bCiO/H84/oz3aIDSpFUqF56bJIv
         HXqI5dYUxl2BMHVp992YklnsYCZ7TRSlwCG8iC7g/oYXxbzlzJmBf7sUieeFU9oKSO6L
         dl2w==
X-Gm-Message-State: AGRZ1gKZibJJBuhVPeku7vPzUsv0CjlDdqFoNSl3fvbDRbviexveak8K
        9KGCzF0NvCC4zNMHV2FJD+k8hXhbF99KaLUSFuzqFg==
X-Google-Smtp-Source: AJdET5fBOIWzGSAqSb1bEAMsUAdzMIu5Li5tpogiqpCD6qWV1dyFpzppx7Ry3IneaWlbEO8riFvCEEIAb0JW1ner9ao=
X-Received: by 2002:a6b:37c2:: with SMTP id e185-v6mr19321890ioa.173.1541450385271;
 Mon, 05 Nov 2018 12:39:45 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 12:39:44 -0800 (PST)
In-Reply-To: <20181031192843.13230-5-f.fainelli@gmail.com>
References: <20181031192843.13230-1-f.fainelli@gmail.com> <20181031192843.13230-5-f.fainelli@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Nov 2018 21:39:44 +0100
Message-ID: <CAKv+Gu85kRVos-z+1WuV5J8bTHpLDDdUu0hVD2NmZ-w-ry5f4g@mail.gmail.com>
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

Hi Florian,

On 31 October 2018 at 20:28, Florian Fainelli <f.fainelli@gmail.com> wrote:
> ARM64 is the only architecture that re-defines
> __early_init_dt_declare_initrd() in order for that function to populate
> initrd_start/initrd_end with physical addresses instead of virtual
> addresses. Instead of having an override we can leverage
> drivers/of/fdt.c populating phys_initrd_start/phys_initrd_size to
> populate those variables for us.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm64/mm/init.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 3cf87341859f..00ef2166bb73 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -72,8 +72,8 @@ static int __init early_initrd(char *p)
>         if (*endp == ',') {
>                 size = memparse(endp + 1, NULL);
>
> -               initrd_start = start;
> -               initrd_end = start + size;
> +               phys_initrd_start = start;
> +               phys_initrd_size = size;
>         }
>         return 0;
>  }
> @@ -408,14 +408,14 @@ void __init arm64_memblock_init(void)
>                 memblock_add(__pa_symbol(_text), (u64)(_end - _text));
>         }
>
> -       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
> +       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
>                 /*
>                  * Add back the memory we just removed if it results in the
>                  * initrd to become inaccessible via the linear mapping.
>                  * Otherwise, this is a no-op
>                  */
> -               u64 base = initrd_start & PAGE_MASK;
> -               u64 size = PAGE_ALIGN(initrd_end) - base;
> +               u64 base = phys_initrd_start & PAGE_MASK;
> +               u64 size = PAGE_ALIGN(phys_initrd_size);
>
>                 /*
>                  * We can only add back the initrd memory if we don't end up
> @@ -460,12 +460,11 @@ void __init arm64_memblock_init(void)
>          */
>         memblock_reserve(__pa_symbol(_text), _end - _text);
>  #ifdef CONFIG_BLK_DEV_INITRD
> -       if (initrd_start) {
> -               memblock_reserve(initrd_start, initrd_end - initrd_start);
> -
> +       if (phys_initrd_size) {
>                 /* the generic initrd code expects virtual addresses */
> -               initrd_start = __phys_to_virt(initrd_start);
> -               initrd_end = __phys_to_virt(initrd_end);
> +               initrd_start = __phys_to_virt(phys_initrd_start);
> +               initrd_end = initrd_start + phys_initrd_size;
> +               initrd_below_start_ok = 0;

Where is this assignment coming from?

>         }
>  #endif
>
> --
> 2.17.1
>
