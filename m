Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16199C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29F92082B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oijYefpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29F92082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbeJ3IQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbeJ3IQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:16:00 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F71721104;
        Mon, 29 Oct 2018 23:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540855502;
        bh=sAasVK4V1LbEtnONT+TBXvpf441PteCxNR4+6vQO6S4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oijYefpGqeV600sVhKURNeWjIFA38kxoobu9YZ2N6OQr+QMEU4Xy7rKsQfQwHY08/
         ptqgIjl2mBE5WEQhplFVVP1xhwf0ZaREa0GXL3g1USadi5uTKXRLWpwQ1rczYmNGnO
         uKqpRB+xsrPej15s5/xJhzjsGIg7bN0afLKUZt1w=
Received: by mail-qt1-f177.google.com with SMTP id q41-v6so11406437qtq.10;
        Mon, 29 Oct 2018 16:25:02 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJVid6GW2lQC4SiHkXLtSBSY+jPy9fICNwZT/ZAm0WigQA1KB0q
        H68r++CXB5XgP2bPKqTcq42xykFLlms+d/DwEA==
X-Google-Smtp-Source: AJdET5exTMsXPo+Jb16mAirTe6X5fgsnOumICFDYxc/ILj8tq0rYZuzwNjB1K2uNL3cYn8Mycyvoy4gndhZ1l/uotwQ=
X-Received: by 2002:aed:3ece:: with SMTP id o14-v6mr408104qtf.26.1540855501326;
 Mon, 29 Oct 2018 16:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181029190014.6455-1-f.fainelli@gmail.com> <20181029190014.6455-2-f.fainelli@gmail.com>
 <CAL_JsqL2g69Duhkqd=f09BStoAKeakJz8Wgz3is37YU0+fc80A@mail.gmail.com> <CAKv+Gu-5vpSJDs3RdTtspO3WmbqTE4YQDWj2us4YOP2zi1PDTg@mail.gmail.com>
In-Reply-To: <CAKv+Gu-5vpSJDs3RdTtspO3WmbqTE4YQDWj2us4YOP2zi1PDTg@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 29 Oct 2018 18:24:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJmGdExHbYA7_ABz0K4b=JPdX+O=2GRzip=_KBakqh9Ug@mail.gmail.com>
Message-ID: <CAL_JsqJmGdExHbYA7_ABz0K4b=JPdX+O=2GRzip=_KBakqh9Ug@mail.gmail.com>
Subject: Re: [PATCH 1/2 v5] arm64: Get rid of __early_init_dt_declare_initrd()
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On Mon, Oct 29, 2018 at 4:58 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On 29 October 2018 at 16:59, Rob Herring <robh+dt@kernel.org> wrote:
> > +Ard who last touched this.
> >
> > On Mon, Oct 29, 2018 at 2:23 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >> ARM64 is the only architecture that re-defines
> >> __early_init_dt_declare_initrd() in order for that function to populate
> >> initrd_start/initrd_end with physical addresses instead of virtual
> >> addresses. Instead of having an override, just get rid of that
> >> implementation and perform the virtual to physical conversion of these
> >> addresses in arm64_memblock_init() where relevant.
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >> ---
> >>  arch/arm64/include/asm/memory.h |  8 -------
> >>  arch/arm64/mm/init.c            | 42 +++++++++++++++++++++------------
> >>  2 files changed, 27 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> >> index b96442960aea..dc3ca21ba240 100644
> >> --- a/arch/arm64/include/asm/memory.h
> >> +++ b/arch/arm64/include/asm/memory.h
> >> @@ -168,14 +168,6 @@
> >>  #define IOREMAP_MAX_ORDER      (PMD_SHIFT)
> >>  #endif
> >>
> >> -#ifdef CONFIG_BLK_DEV_INITRD
> >> -#define __early_init_dt_declare_initrd(__start, __end)                 \
> >> -       do {                                                            \
> >> -               initrd_start = (__start);                               \
> >> -               initrd_end = (__end);                                   \
> >> -       } while (0)
> >> -#endif
> >> -
> >>  #ifndef __ASSEMBLY__
> >>
> >>  #include <linux/bitops.h>
> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> index 3cf87341859f..292570b08f85 100644
> >> --- a/arch/arm64/mm/init.c
> >> +++ b/arch/arm64/mm/init.c
> >> @@ -62,6 +62,8 @@
> >>  s64 memstart_addr __ro_after_init = -1;
> >>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
> >>
> >> +static phys_addr_t phys_initrd_start, phys_initrd_end;
> >> +
> >>  #ifdef CONFIG_BLK_DEV_INITRD
> >>  static int __init early_initrd(char *p)
> >>  {
> >> @@ -72,8 +74,8 @@ static int __init early_initrd(char *p)
> >>         if (*endp == ',') {
> >>                 size = memparse(endp + 1, NULL);
> >>
> >> -               initrd_start = start;
> >> -               initrd_end = start + size;
> >> +               phys_initrd_start = start;
> >> +               phys_initrd_end = start + size;
> >>         }
> >>         return 0;
> >>  }
> >> @@ -364,6 +366,7 @@ static void __init fdt_enforce_memory_region(void)
> >>  void __init arm64_memblock_init(void)
> >>  {
> >>         const s64 linear_region_size = -(s64)PAGE_OFFSET;
> >> +       u64 __maybe_unused base, size;
> >>
> >>         /* Handle linux,usable-memory-range property */
> >>         fdt_enforce_memory_region();
> >> @@ -408,14 +411,25 @@ void __init arm64_memblock_init(void)
> >>                 memblock_add(__pa_symbol(_text), (u64)(_end - _text));
> >>         }
> >>
> >> -       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
> >> +       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
> >> +           (initrd_start || phys_initrd_start)) {
> >
> > I've tried to explain already that this is broken. The problem is
> > __early_init_dt_declare_initrd using __va() which happens before this
> > function is called. __va() uses PHYS_OFFSET which in turn is defined
> > as memstart_addr. However, memstart_addr may be changed just above
> > this hunk, so the earlier conversion to a VA may not be valid at this
> > point. This is explained if you read Ard's commit that added all this
> > mess.
> >
> > You could fix this by converting back to a PA before adjusting
> > memstart_addr, but that's 2 wrongs making a right and fragile. The
> > better solution is the other proposal making the DT code set
> > phys_initrd_* (whatever the ARM code calls them).
> >
>
> On arm64, we have
>
> #define PHYS_OFFSET \
>   ({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })
>
> and
>
> s64 memstart_addr __ro_after_init = -1;
>
> IOW, any attempt to perform PA to VA translations before memstart_addr
> is assigned will BUG() if CONFIG_DEBUG_VM=y, so please enable that
> when playing with this code.

Which will result in a crashed kernel with no console output unless
you have earlycon enabled (or maybe EFI console will be up?). A WARN
would be better.

> The reason we have this code is because the start of the linear region
> might not coincide with memblock_start_of_DRAM(), which could happen,
> e.g., when running a 39-bit VA kernel on a system with a very sparse
> memory map (which is unfortunately what some silicon vendors think is
> what ARM recommends) and the kernel loaded near the top of that
> memory. The ability to load the kernel anywhere in physical memory was
> introduced to accommodate physical KASLR.
>
> Ideally, we'd fix this by only recording physical addresses for the
> initrd in generic code, and deferring the translation until the point
> where we actually do the access.

The plan had been for the core code to set both the phys and virt
addresses and let arm64 calculate the VA again. I guess we'll have to
condition getting the VA on !ARM64 at least until we convert other
platforms to use physaddr.

Rob
