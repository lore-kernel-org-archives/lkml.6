Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FB0C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF5E2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkfiqrBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF5E2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbeJYXEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbeJYXEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:04:47 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3509A20868;
        Thu, 25 Oct 2018 14:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477905;
        bh=CDv7mcxhb6+5XRnDvdRkMPjM7WqVyWF5zBghFhtIM9E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qkfiqrBHvbgiZet8EZSWVVXjwbRnFtZaxBaj40JRmG1BY5/RntEz+AupPxJmfRF6T
         3m2AUoI5t/mQAS/35Nc/EAICCF5k5wbfi3HZr+e5UsJPIir81lpzb8UvU/IM7LcghE
         sycbyNDOczGbG/mqPzCJyKpHhCYCA+cydIjoohgs=
Received: by mail-qk1-f171.google.com with SMTP id o89so5838698qko.0;
        Thu, 25 Oct 2018 07:31:45 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLkErq8h+j5qx+U36Ozz+cywlCLxA17RtbPVivAN3Gs1UG9hapz
        TkZ8tBegZ9chUYV2yAwkuVvjrWZBIWjK8e/gtw==
X-Google-Smtp-Source: AJdET5dHkNDfLfIBNSe4u6U1jOQLBq34efehfLDiMNzvKMxlZyx4EnE3wFBEbViV8vC1ejMugNr/A+4M0dJ3hzSt+2w=
X-Received: by 2002:a37:4dc5:: with SMTP id a188-v6mr1649408qkb.326.1540477904349;
 Thu, 25 Oct 2018 07:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181025001742.6510-1-f.fainelli@gmail.com> <20181025001742.6510-2-f.fainelli@gmail.com>
 <CAL_JsqK-bSu520fx-dWMyHsooOU9=24DEf6fZSudQ-QKDkXbGA@mail.gmail.com> <20181025140636.GA30658@n2100.armlinux.org.uk>
In-Reply-To: <20181025140636.GA30658@n2100.armlinux.org.uk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 25 Oct 2018 09:31:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJU67p+Qck-38uaV81MWfGshPem96cAKcz3W7--dzyzoA@mail.gmail.com>
Message-ID: <CAL_JsqJU67p+Qck-38uaV81MWfGshPem96cAKcz3W7--dzyzoA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] of/fdt: Absorb ARM64's __early_init_dt_declare_initrd()
To:     Russell King <linux@armlinux.org.uk>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        christoffer.dall@arm.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        bcm-kernel-feedback-list@broadcom.com, andreyknvl@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 9:06 AM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Thu, Oct 25, 2018 at 08:25:04AM -0500, Rob Herring wrote:
> > On Wed, Oct 24, 2018 at 7:17 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > >
> > > ARM64 is the only architecture that requires a re-definition of
> > > __early_init_dt_declare_initrd(), absorb its custom implemention in
> > > drivers/of/fdt.c.
> > >
> > > Suggested-by: Rob Herring <robh@kernel.org.
> >
> > You forgot a shift key. :)
> >
> > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > > ---
> > >  drivers/of/fdt.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > index 800ad252cf9c..7d316f008f22 100644
> > > --- a/drivers/of/fdt.c
> > > +++ b/drivers/of/fdt.c
> > > @@ -896,9 +896,14 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
> > >  static void __early_init_dt_declare_initrd(unsigned long start,
> > >                                            unsigned long end)
> > >  {
> > > +#if IS_ENABLED(CONFIG_ARM64)
> >
> > C code, not preprocessor please.
> >
> > > +       initrd_start = start;
> > > +       initrd_end = end;
> >
> > Thinking some more about this, perhaps it is better to just add the
> > *_phys variants now along side the VA variants and set them here. Then
> > the arm64 code can override the initrd_start, initrd_end, and
> > initrd_below_start_ok values.
>
> Please, let's not make the age old mistake of inventing new symbols
> for stuff that already exists:
>
> $ grep phys_initrd_start arch/ -rl
> arch/arm/mm/init.c
> arch/nds32/mm/init.c
> arch/unicore32/mm/init.c
> $ grep initrd_start_phys arch/ -rl
> $
>
> Please use the "phys_initrd_start" and "phys_initrd_end" naming,

Yes, of course. That is what I intended. I assumed Florian would be
aware of it from your other email.

> which already exist on some architectures rather than inventing a new
> set of symbols for the same thing and then forcing arches to change.
> We could then get rid of:
>
>         /* FDT scan will populate initrd_start */
>         if (initrd_start && !phys_initrd_size) {
>                 phys_initrd_start = __virt_to_phys(initrd_start);
>                 phys_initrd_size = initrd_end - initrd_start;
>         }
>
>         initrd_start = initrd_end = 0;
>
> in ARM, which exists purely to cope with DT.
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
