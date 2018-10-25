Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192CAECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C907E20840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmQOCjMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C907E20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeJYVsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 17:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbeJYVsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 17:48:11 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9613320873;
        Thu, 25 Oct 2018 13:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540473327;
        bh=bZCaLGyy/teaz6OaWjiI6j372VpbdHwQ/+uDi/xM0NA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rmQOCjMP4WlmSu7q/6GKpat6ZDwriH0k0T7uU9LpThvPbvqSZMG86LEvpMMtzWve5
         55xfq0E+MRosHuJmT2AJk2rXXZyP6u/UFRLuY46PSLFi1yVaO2B3EDnBnmblyLBFjk
         L9ZwTnE9FwMZZn/fKRAXLHVQrQhOMORTskyDX1WU=
Received: by mail-qt1-f173.google.com with SMTP id z9-v6so9724522qto.7;
        Thu, 25 Oct 2018 06:15:27 -0700 (PDT)
X-Gm-Message-State: AGRZ1gI5izBn0lsv6gynRuqtpeluDP61lbpW422UHKw1Uqvmr89BqNDF
        hDUYb03ZnF1d9moWjYNerPzoHeuJVcED/BxetQ==
X-Google-Smtp-Source: AJdET5doJEr2mxMCRhycLo9mGNj457pXXR2JyagROZiVZ07IyUKOxF1P1ly2I83sHe0Z+PkQjBByf4TUchTE15SVbu4=
X-Received: by 2002:a0c:c3c8:: with SMTP id p8mr1490299qvi.90.1540473326445;
 Thu, 25 Oct 2018 06:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181024193256.23734-1-f.fainelli@gmail.com> <CAL_Jsq+KCOv6pXXHhHDZ+7-QUrmtMDvSjEVhK15yZ3qbnn61Ag@mail.gmail.com>
 <20181025093833.GA23607@rapoport-lnx>
In-Reply-To: <20181025093833.GA23607@rapoport-lnx>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 25 Oct 2018 08:15:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL62ttsGSbE1BS5v-mX3pKE-p_HyvuZD6nB+GUbQyetzg@mail.gmail.com>
Message-ID: <CAL_JsqL62ttsGSbE1BS5v-mX3pKE-p_HyvuZD6nB+GUbQyetzg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] arm64: Cut rebuild time when changing CONFIG_BLK_DEV_INITRD
To:     rppt@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Olof Johansson <olof@lixom.net>, linux-alpha@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        Openrisc <openrisc@lists.librecores.org>,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        SH-Linux <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Ard

On Thu, Oct 25, 2018 at 4:38 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Wed, Oct 24, 2018 at 02:55:17PM -0500, Rob Herring wrote:
> > On Wed, Oct 24, 2018 at 2:33 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > >
> > > Hi all,
> > >
> > > While investigating why ARM64 required a ton of objects to be rebuilt
> > > when toggling CONFIG_DEV_BLK_INITRD, it became clear that this was
> > > because we define __early_init_dt_declare_initrd() differently and we do
> > > that in arch/arm64/include/asm/memory.h which gets included by a fair
> > > amount of other header files, and translation units as well.
> >
> > I scratch my head sometimes as to why some config options rebuild so
> > much stuff. One down, ? to go. :)
> >
> > > Changing the value of CONFIG_DEV_BLK_INITRD is a common thing with build
> > > systems that generate two kernels: one with the initramfs and one
> > > without. buildroot is one of these build systems, OpenWrt is also
> > > another one that does this.
> > >
> > > This patch series proposes adding an empty initrd.h to satisfy the need
> > > for drivers/of/fdt.c to unconditionally include that file, and moves the
> > > custom __early_init_dt_declare_initrd() definition away from
> > > asm/memory.h
> > >
> > > This cuts the number of objects rebuilds from 1920 down to 26, so a
> > > factor 73 approximately.
> > >
> > > Apologies for the long CC list, please let me know how you would go
> > > about merging that and if another approach would be preferable, e.g:
> > > introducing a CONFIG_ARCH_INITRD_BELOW_START_OK Kconfig option or
> > > something like that.
> >
> > There may be a better way as of 4.20 because bootmem is now gone and
> > only memblock is used. This should unify what each arch needs to do
> > with initrd early. We need the physical address early for memblock
> > reserving. Then later on we need the virtual address to access the
> > initrd. Perhaps we should just change initrd_start and initrd_end to
> > physical addresses (or add 2 new variables would be less invasive and
> > allow for different translation than __va()). The sanity checks and
> > memblock reserve could also perhaps be moved to a common location.
> >
> > Alternatively, given arm64 is the only oddball, I'd be fine with an
> > "if (IS_ENABLED(CONFIG_ARM64))" condition in the default
> > __early_init_dt_declare_initrd as long as we have a path to removing
> > it like the above option.
>
> I think arm64 does not have to redefine __early_init_dt_declare_initrd().
> Something like this might be just all we need (completely untested,
> probably it won't even compile):
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9d9582c..e9ca238 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -62,6 +62,9 @@ s64 memstart_addr __ro_after_init = -1;
>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>
>  #ifdef CONFIG_BLK_DEV_INITRD
> +
> +static phys_addr_t initrd_start_phys, initrd_end_phys;
> +
>  static int __init early_initrd(char *p)
>  {
>         unsigned long start, size;
> @@ -71,8 +74,8 @@ static int __init early_initrd(char *p)
>         if (*endp == ',') {
>                 size = memparse(endp + 1, NULL);
>
> -               initrd_start = start;
> -               initrd_end = start + size;
> +               initrd_start_phys = start;
> +               initrd_end_phys = end;
>         }
>         return 0;
>  }
> @@ -407,14 +410,27 @@ void __init arm64_memblock_init(void)
>                 memblock_add(__pa_symbol(_text), (u64)(_end - _text));
>         }
>
> -       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
> +       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
> +           (initrd_start || initrd_start_phys)) {
> +               /*
> +                * FIXME: ensure proper precendence between
> +                * early_initrd and DT when both are present

Command line takes precedence, so just reverse the order.

> +                */
> +               if (initrd_start) {
> +                       initrd_start_phys = __phys_to_virt(initrd_start);
> +                       initrd_end_phys = __phys_to_virt(initrd_end);

AIUI, the original issue was doing the P2V translation was happening
too early and the VA could be wrong if the linear range is adjusted.
So I don't think this would work.

I suppose you could convert the VA back to a PA before any adjustments
and then back to a VA again after. But that's kind of hacky. 2 wrongs
making a right.

> +               } else if (initrd_start_phys) {
> +                       initrd_start = __va(initrd_start_phys);
> +                       initrd_end = __va(initrd_start_phys);
> +               }
> +
>                 /*
>                  * Add back the memory we just removed if it results in the
>                  * initrd to become inaccessible via the linear mapping.
>                  * Otherwise, this is a no-op
>                  */
> -               u64 base = initrd_start & PAGE_MASK;
> -               u64 size = PAGE_ALIGN(initrd_end) - base;
> +               u64 base = initrd_start_phys & PAGE_MASK;
> +               u64 size = PAGE_ALIGN(initrd_end_phys) - base;
>
>                 /*
>                  * We can only add back the initrd memory if we don't end up
> @@ -458,7 +474,7 @@ void __init arm64_memblock_init(void)
>          * pagetables with memblock.
>          */
>         memblock_reserve(__pa_symbol(_text), _end - _text);
> -#ifdef CONFIG_BLK_DEV_INITRD
> +#if 0
>         if (initrd_start) {
>                 memblock_reserve(initrd_start, initrd_end - initrd_start);
>
>
> > Rob
> >
>
> --
> Sincerely yours,
> Mike.
>
