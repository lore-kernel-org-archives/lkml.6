Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55900C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B3E2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3twotvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B3E2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbeJ3EuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbeJ3EuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:50:15 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A7FF21019;
        Mon, 29 Oct 2018 20:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540843204;
        bh=ZMNJfLeHJO9coG8PKL/4oh4nH6KMZh+zkUMB/iFKFB0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q3twotvLE4Q0PcViX4aGRQxI+OSahToZu9uS1Yd7rKvkxbKJxTQXLERwsaUbpiOoJ
         FI4sj1+juItgJQS+FQsdiSGOrFcaP9CVzA0zFSxprhvBrH/7OSb2Xo6/ZRz2LBSRkY
         zArZKB0wesh1A/762IcvuxOA3QZ/YFZXWQ6F65w8=
Received: by mail-qt1-f172.google.com with SMTP id u34-v6so10810687qth.3;
        Mon, 29 Oct 2018 13:00:04 -0700 (PDT)
X-Gm-Message-State: AGRZ1gL0W5W1xBQ8/aZUUs7tXsLgW9/1tNy7rM9+QvvixHctxH432pBu
        2H5XH/lKTSOVuu64XSYVxCOrNTIRPLUUsfhSgg==
X-Google-Smtp-Source: AJdET5dS7w4c7S8BPm/lVESa1pL8sV2XVqdt/Qf9bW35vQ2WXL5SPM2osioxDj3W7g8ZGONK/AxaWnHZHGdUFV/GCNo=
X-Received: by 2002:a0c:c3c8:: with SMTP id p8mr14455498qvi.90.1540843203112;
 Mon, 29 Oct 2018 13:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181029190014.6455-1-f.fainelli@gmail.com> <20181029190014.6455-2-f.fainelli@gmail.com>
In-Reply-To: <20181029190014.6455-2-f.fainelli@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 29 Oct 2018 14:59:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL2g69Duhkqd=f09BStoAKeakJz8Wgz3is37YU0+fc80A@mail.gmail.com>
Message-ID: <CAL_JsqL2g69Duhkqd=f09BStoAKeakJz8Wgz3is37YU0+fc80A@mail.gmail.com>
Subject: Re: [PATCH 1/2 v5] arm64: Get rid of __early_init_dt_declare_initrd()
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rppt@linux.ibm.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        aryabinin@virtuozzo.com, Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>, ghackmann@android.com,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        chandan.vn@samsung.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Ard who last touched this.

On Mon, Oct 29, 2018 at 2:23 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> ARM64 is the only architecture that re-defines
> __early_init_dt_declare_initrd() in order for that function to populate
> initrd_start/initrd_end with physical addresses instead of virtual
> addresses. Instead of having an override, just get rid of that
> implementation and perform the virtual to physical conversion of these
> addresses in arm64_memblock_init() where relevant.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm64/include/asm/memory.h |  8 -------
>  arch/arm64/mm/init.c            | 42 +++++++++++++++++++++------------
>  2 files changed, 27 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b96442960aea..dc3ca21ba240 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -168,14 +168,6 @@
>  #define IOREMAP_MAX_ORDER      (PMD_SHIFT)
>  #endif
>
> -#ifdef CONFIG_BLK_DEV_INITRD
> -#define __early_init_dt_declare_initrd(__start, __end)                 \
> -       do {                                                            \
> -               initrd_start = (__start);                               \
> -               initrd_end = (__end);                                   \
> -       } while (0)
> -#endif
> -
>  #ifndef __ASSEMBLY__
>
>  #include <linux/bitops.h>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 3cf87341859f..292570b08f85 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -62,6 +62,8 @@
>  s64 memstart_addr __ro_after_init = -1;
>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>
> +static phys_addr_t phys_initrd_start, phys_initrd_end;
> +
>  #ifdef CONFIG_BLK_DEV_INITRD
>  static int __init early_initrd(char *p)
>  {
> @@ -72,8 +74,8 @@ static int __init early_initrd(char *p)
>         if (*endp == ',') {
>                 size = memparse(endp + 1, NULL);
>
> -               initrd_start = start;
> -               initrd_end = start + size;
> +               phys_initrd_start = start;
> +               phys_initrd_end = start + size;
>         }
>         return 0;
>  }
> @@ -364,6 +366,7 @@ static void __init fdt_enforce_memory_region(void)
>  void __init arm64_memblock_init(void)
>  {
>         const s64 linear_region_size = -(s64)PAGE_OFFSET;
> +       u64 __maybe_unused base, size;
>
>         /* Handle linux,usable-memory-range property */
>         fdt_enforce_memory_region();
> @@ -408,14 +411,25 @@ void __init arm64_memblock_init(void)
>                 memblock_add(__pa_symbol(_text), (u64)(_end - _text));
>         }
>
> -       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
> +       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
> +           (initrd_start || phys_initrd_start)) {

I've tried to explain already that this is broken. The problem is
__early_init_dt_declare_initrd using __va() which happens before this
function is called. __va() uses PHYS_OFFSET which in turn is defined
as memstart_addr. However, memstart_addr may be changed just above
this hunk, so the earlier conversion to a VA may not be valid at this
point. This is explained if you read Ard's commit that added all this
mess.

You could fix this by converting back to a PA before adjusting
memstart_addr, but that's 2 wrongs making a right and fragile. The
better solution is the other proposal making the DT code set
phys_initrd_* (whatever the ARM code calls them).

>                 /*
>                  * Add back the memory we just removed if it results in the
>                  * initrd to become inaccessible via the linear mapping.
>                  * Otherwise, this is a no-op
>                  */
> -               u64 base = initrd_start & PAGE_MASK;
> -               u64 size = PAGE_ALIGN(initrd_end) - base;
> +               if (phys_initrd_start) {
> +                       /* Command line specified the initrd location */
> +                       initrd_start = __phys_to_virt(phys_initrd_start);
> +                       initrd_end = __phys_to_virt(phys_initrd_end);
> +               } else if (initrd_start) {
> +                       /* FDT specified the initrd location */
> +                       phys_initrd_start = __pa(initrd_start);
> +                       phys_initrd_end = __pa(initrd_end);

Kind of inconsistent to mix __phys_to_virt and __pa flavors.

Rob
