Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BD1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE19421872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="biERTSTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfBGPti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:49:38 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35949 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfBGPth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:49:37 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so829233itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 07:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UR8a1Ehz6ohzX06Q4NxlU9SbkeWbimRQ+O5ooyRfagw=;
        b=biERTSTP9OFBh7kox/lqYBoN2fRT7L9N74deC0E9eOqXW4iepSibfP9A2MlU79BLtG
         tHzj380gYXqk0W2gMXH80D/peQmFbH/MEUE/6vmSWSTa4V3jmzvwaXi8LNpKMKiyL9o4
         rP13nt291ukskzOqAocadS1SMWkBuxa8I5PmIrPn28ukNP8gZi0MWkb3BklrJ3phd339
         f+qvPeloMiDvJvALH5efK5bVInXIJUvLlRNOohy53Nfgp8WBBXUsdN3GadXrgAbYlC3N
         morhdSeuwi/zOCg5DnzOsFbKAIXDdPPpNxG5qIT0JqdGUi98KAPmcJKX2iKs7q5mta+E
         vBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UR8a1Ehz6ohzX06Q4NxlU9SbkeWbimRQ+O5ooyRfagw=;
        b=i82mLnXfHkY2Pz60YlbMMQF7xpbh+K9Wc9Uz2PNGKzb6FRpxwhpHrKyY3asgQeMfuD
         xWSD0FsnwuzzrgDu5bQ7yIfW5jFFg9jXyJlQ3HS7Hi+eBfl4OBkI0RvB1GXhYekO0k7Z
         4hOT/mHygpeQLe6rLt1YQQamTpJ906dKq67TDIv5TtZDmrMj3xZtDKthdUpDmiI+9yYG
         jLpXhIu2kLgiljpWsqM8tHDV8g1t9n9YnzQOnfk2ZGnLK4tHbhf/h2g+bIJUv8HIg/+K
         hBfrDSeVqV/+HBB9HTG4S2Fr1m1DQN+rw18u/zqrImQaHj69BKq89v/3egX9zV1dNgjN
         kWig==
X-Gm-Message-State: AHQUAua/Q7Umi5as3elc+UgB6WndLfawAjt4+hrT0z+o0hm+bGgyHPf8
        VnA44HxXNFOSwF7ua/BTBl4cxWlq8P8bUkO5T07F1g==
X-Google-Smtp-Source: AHgI3IZW6DSydt7iXZqbioV9Cyh5ArByqWSgu0UjiF9m+iVNpmfHIifEApd2QeJmdJ811DgVpeTv83zMiSI9i4+LaIY=
X-Received: by 2002:a24:5d94:: with SMTP id w142mr4275426ita.74.1549554576631;
 Thu, 07 Feb 2019 07:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl> <20190131133928.17985-3-brgl@bgdev.pl>
 <eb09a892-d965-3ee2-dfe7-2dcbbcb03791@ti.com>
In-Reply-To: <eb09a892-d965-3ee2-dfe7-2dcbbcb03791@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 7 Feb 2019 16:49:25 +0100
Message-ID: <CAMRc=Me9gqfN6WuWPZ61M2pNC+ZrhxAX_=BzAr4_zxnfdL4G7Q@mail.gmail.com>
Subject: Re: [PATCH 02/35] ARM: davinci: select GENERIC_IRQ_MULTI_HANDLER
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 6 lut 2019 o 13:39 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> On 31/01/19 7:08 PM, Bartosz Golaszewski wrote:
>
> > diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp=
_intc.c
> > index 67805ca74ff8..b9aec3c48a6a 100644
> > --- a/arch/arm/mach-davinci/cp_intc.c
> > +++ b/arch/arm/mach-davinci/cp_intc.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/of_address.h>
> >  #include <linux/of_irq.h>
> >
> > +#include <asm/exception.h>
> >  #include <mach/common.h>
> >  #include "cp_intc.h"
> >
> > @@ -97,6 +98,16 @@ static struct irq_chip cp_intc_irq_chip =3D {
> >
> >  static struct irq_domain *cp_intc_domain;
> >
> > +static asmlinkage void __exception_irq_entry
> > +cp_intc_handle_irq(struct pt_regs *regs)
> > +{
> > +     int irqnr =3D cp_intc_read(CP_INTC_PRIO_IDX);
> > +
> > +     irqnr &=3D 0xff;
> > +
> > +     handle_domain_irq(cp_intc_domain, irqnr, regs);
>
> This leaves out spurious interrupt handling present in existing assembly
> code. Can you add it back. May be use omap_intc_handle_irq() as an
> example for handling spurious IRQs.
>

Hi Sekhar,

I started looking at this one and noticed that the manual says
PRI_INDX field in the GPIR register is in bits 0-9 (mask 0x3ff) while
the assembly logically ANDs it with 0xff. I guess it's because there
can be no more interrupts than 255 but I'd at least explain it in a
comment. Or should we use the proper mask? What do you think?

Bart

> > +}
> > +
>
> > diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
> > index 952dc126c390..3bbbef78d9ac 100644
> > --- a/arch/arm/mach-davinci/irq.c
> > +++ b/arch/arm/mach-davinci/irq.c
> > @@ -28,11 +28,13 @@
> >  #include <mach/cputype.h>
> >  #include <mach/common.h>
> >  #include <asm/mach/irq.h>
> > +#include <asm/exception.h>
> >
> >  #define FIQ_REG0_OFFSET              0x0000
> >  #define FIQ_REG1_OFFSET              0x0004
> >  #define IRQ_REG0_OFFSET              0x0008
> >  #define IRQ_REG1_OFFSET              0x000C
> > +#define IRQ_IRQENTRY_OFFSET  0x0014
> >  #define IRQ_ENT_REG0_OFFSET  0x0018
> >  #define IRQ_ENT_REG1_OFFSET  0x001C
> >  #define IRQ_INCTL_REG_OFFSET 0x0020
> > @@ -45,6 +47,11 @@ static inline void davinci_irq_writel(unsigned long =
value, int offset)
> >       __raw_writel(value, davinci_intc_base + offset);
> >  }
> >
> > +static inline unsigned long davinci_irq_readl(int offset)
> > +{
> > +     return __raw_readl(davinci_intc_base + offset);
> > +}
>
> Can we use readl_relaxed() here? I know there is existing __raw_writel()
> usage. May be add a patch to fix the existing code first.
>
> Thanks,
> Sekhar
