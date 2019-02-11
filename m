Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B081C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2AB21A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yt+PzwHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfBKNIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:08:46 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41515 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfBKNIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:08:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so17273478otk.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 05:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E0R70YqGL5UA4oHh6l9Dw6qdZnoVJ5zdyW6C9H8BSqQ=;
        b=yt+PzwHijNpoFRfIPC4YzLcKhA/frcjt5WtsKEp9qiK+VVm8QmGLlCxjrgrgfkz02c
         PivHLWLAXXOBHyDnjTjloxhmNlmaFnHcE9ffax+1ivZmzjohRu0vKqcPGsC8934/i4N/
         ZglAqcVzALE/AmMr5Zhe+HlZaO7Y3Fdbhl+SZEp/NEynfEg3/e5z+pUNkG6HFYNf/tWm
         +H9ApKubEa42hJ2dz1SMdCjCnV/OdKK/uw9vdyDP5UEqzwlX1aJz1iEDl1QqdFqpRSpY
         CjGa7kI4T2JfPTnII2Pm0KgNvW+LtsHpCukr5btFRAXpgqy4XkjU5IQOsAfLTumEYZ9Y
         d6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E0R70YqGL5UA4oHh6l9Dw6qdZnoVJ5zdyW6C9H8BSqQ=;
        b=UiMcuyscIa7yLw8nHPehq9vb1NqjU0x6qN+qWEd83taazrp7cxGjI3wIK8eHzfFAD7
         1XEWqsGok7uq1QbHFCwlUAYTd0sslFHRXt52EOMP51PG2cNH5y8t80zwzlx4CrT0qt04
         eUPbF64yvBmtPHvpq02FuqX/5Q4BGEHL3RTjN3G+c/t/N9uD2tAXgXIZVkBy/mg5zbFe
         C+LczaGG9Of2a88H/4NR6hHYhz5O9BAgDBE8qfiPemcuU0a+hYIRsq4O+3KdKACi7bAJ
         b983XCy/czNM+9bK52ODZ7nauRLk0+xYkPbBo7r+M85BINzf2uMSn36eQsKrJkmsMrBx
         dz1Q==
X-Gm-Message-State: AHQUAuazd5B+VowkXnkusa043eHjE06y4PSA7nSyemk+GxmiAqnBdSRu
        +utkakQIGtWevwtLabaFzAeVNPLJxSQWuVpxNbWdTw==
X-Google-Smtp-Source: AHgI3IYxyihM6bQqrEo0QetjZhsohboYzexPEEJM/IPRqi0mDp29J3USmxH3W4Mf9R5wK+PuIGtKsplXYx8kSn1tBnI=
X-Received: by 2002:a9d:635a:: with SMTP id y26mr26519160otk.27.1549890524141;
 Mon, 11 Feb 2019 05:08:44 -0800 (PST)
MIME-Version: 1.0
References: <20190211122606.8662-1-brgl@bgdev.pl> <20190211122606.8662-4-brgl@bgdev.pl>
 <0220fbc8-a73f-0f40-2b62-14bec019ac7c@arm.com>
In-Reply-To: <0220fbc8-a73f-0f40-2b62-14bec019ac7c@arm.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 11 Feb 2019 14:08:33 +0100
Message-ID: <CAMpxmJU2bMRPYWNRgBRtY9q6JoMLB+M89PYvA17F+=SSZeovag@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 03/33] ARM: davinci: select GENERIC_IRQ_MULTI_HANDLER
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        David Lechner <david@lechnology.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 11 lut 2019 o 13:50 Marc Zyngier <marc.zyngier@arm.com> napisa=C5=82(=
a):
>
> On 11/02/2019 12:25, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > In order to support SPARSE_IRQ we first need to make davinci use the
> > generic irq handler for ARM. Translate the legacy assembly to C and
> > put the irq handlers into their respective drivers (aintc and cp-intc).
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  arch/arm/Kconfig                              |  1 +
> >  arch/arm/mach-davinci/cp_intc.c               | 28 +++++++++++++
> >  .../mach-davinci/include/mach/entry-macro.S   | 39 -------------------
> >  arch/arm/mach-davinci/irq.c                   | 23 +++++++++++
> >  4 files changed, 52 insertions(+), 39 deletions(-)
> >  delete mode 100644 arch/arm/mach-davinci/include/mach/entry-macro.S
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 664e918e2624..f7770fdcad68 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -589,6 +589,7 @@ config ARCH_DAVINCI
> >       select GENERIC_ALLOCATOR
> >       select GENERIC_CLOCKEVENTS
> >       select GENERIC_IRQ_CHIP
> > +     select GENERIC_IRQ_MULTI_HANDLER
> >       select GPIOLIB
> >       select HAVE_IDE
> >       select PM_GENERIC_DOMAINS if PM
> > diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp=
_intc.c
> > index 67805ca74ff8..4a372add8cf9 100644
> > --- a/arch/arm/mach-davinci/cp_intc.c
> > +++ b/arch/arm/mach-davinci/cp_intc.c
> > @@ -19,9 +19,13 @@
> >  #include <linux/of_address.h>
> >  #include <linux/of_irq.h>
> >
> > +#include <asm/exception.h>
> >  #include <mach/common.h>
> >  #include "cp_intc.h"
> >
> > +#define DAVINCI_CP_INTC_PRI_INDX_MASK                GENMASK(9, 0)
> > +#define DAVINCI_CP_INTC_GPIR_NONE            BIT(31)
> > +
> >  static inline unsigned int cp_intc_read(unsigned offset)
> >  {
> >       return __raw_readl(davinci_intc_base + offset);
> > @@ -97,6 +101,28 @@ static struct irq_chip cp_intc_irq_chip =3D {
> >
> >  static struct irq_domain *cp_intc_domain;
> >
> > +static asmlinkage void __exception_irq_entry
> > +cp_intc_handle_irq(struct pt_regs *regs)
> > +{
> > +     int gpir, irqnr, none;
> > +
> > +     /*
> > +      * The interrupt number is in first ten bits. The NONE field set =
to 1
> > +      * indicates a spurious irq.
> > +      */
> > +
> > +     gpir =3D cp_intc_read(CP_INTC_PRIO_IDX);
> > +     irqnr =3D gpir & DAVINCI_CP_INTC_PRI_INDX_MASK;
> > +     none =3D gpir & DAVINCI_CP_INTC_GPIR_NONE;
> > +
> > +     if (unlikely(none)) {
> > +             pr_err_once("%s: spurious irq!\n", __func__);
> > +             return;
> > +     }
> > +
> > +     handle_domain_irq(cp_intc_domain, irqnr, regs);
> > +}
> > +
> >  static int cp_intc_host_map(struct irq_domain *h, unsigned int virq,
> >                         irq_hw_number_t hw)
> >  {
> > @@ -196,6 +222,8 @@ int __init cp_intc_of_init(struct device_node *node=
, struct device_node *parent)
> >               return -EINVAL;
> >       }
> >
> > +     set_handle_irq(cp_intc_handle_irq);
> > +
> >       /* Enable global interrupt */
> >       cp_intc_write(1, CP_INTC_GLOBAL_ENABLE);
> >
> > diff --git a/arch/arm/mach-davinci/include/mach/entry-macro.S b/arch/ar=
m/mach-davinci/include/mach/entry-macro.S
> > deleted file mode 100644
> > index cf5f573eb5fd..000000000000
> > --- a/arch/arm/mach-davinci/include/mach/entry-macro.S
> > +++ /dev/null
> > @@ -1,39 +0,0 @@
> > -/*
> > - * Low-level IRQ helper macros for TI DaVinci-based platforms
> > - *
> > - * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
> > - *
> > - * 2007 (c) MontaVista Software, Inc. This file is licensed under
> > - * the terms of the GNU General Public License version 2. This program
> > - * is licensed "as is" without any warranty of any kind, whether expre=
ss
> > - * or implied.
> > - */
> > -#include <mach/irqs.h>
> > -
> > -             .macro  get_irqnr_preamble, base, tmp
> > -             ldr \base, =3Ddavinci_intc_base
> > -             ldr \base, [\base]
> > -             .endm
> > -
> > -             .macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> > -#if defined(CONFIG_AINTC) && defined(CONFIG_CP_INTC)
> > -             ldr \tmp, =3Ddavinci_intc_type
> > -             ldr \tmp, [\tmp]
> > -             cmp \tmp, #DAVINCI_INTC_TYPE_CP_INTC
> > -             beq 1001f
> > -#endif
> > -#if defined(CONFIG_AINTC)
> > -             ldr \tmp, [\base, #0x14]
> > -             movs \tmp, \tmp, lsr #2
> > -             sub \irqnr, \tmp, #1
> > -             b 1002f
> > -#endif
> > -#if defined(CONFIG_CP_INTC)
> > -1001:                ldr \irqnr, [\base, #0x80] /* get irq number */
> > -             mov \tmp, \irqnr, lsr #31
> > -             and \irqnr, \irqnr, #0xff  /* irq is in bits 0-9 */
> > -             and \tmp, \tmp, #0x1
> > -             cmp \tmp, #0x1
> > -#endif
> > -1002:
> > -             .endm
> > diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
> > index 07d8ef8037e4..3ce821a06e52 100644
> > --- a/arch/arm/mach-davinci/irq.c
> > +++ b/arch/arm/mach-davinci/irq.c
> > @@ -29,11 +29,13 @@
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
> > @@ -48,6 +50,11 @@ static inline void davinci_irq_writel(unsigned long =
value, int offset)
> >       __raw_writel(value, davinci_intc_base + offset);
> >  }
> >
> > +static inline unsigned long davinci_irq_readl(int offset)
> > +{
> > +     return __raw_readl(davinci_intc_base + offset);
>
> I appreciate that you're converting assembly code dating from a while
> back, but if we're going to do this correctly, I don't think we should
> entertain the use of __raw_readl().
>
> Surely the bus has a fixed endianness (and I'd assume it to be LE). Why
> aren't you using readl_relaxed() instead, which will have the exact same
> generated code with an LE kernel, and will do the right thing should you
> run a BE kernel.
>

Oh snap! I actually converted other calls to the relaxed variants, but
missed this patch.

Thanks for spotting that.

Bart
