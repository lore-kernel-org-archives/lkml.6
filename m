Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14671C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7ED2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfBTTrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:47:20 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42393 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfBTTrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:47:19 -0500
Received: by mail-vs1-f65.google.com with SMTP id b20so14708932vsl.9;
        Wed, 20 Feb 2019 11:47:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMPBe1nM5mxaH2yFzKxkajAyj1dgO5nkfxon7PXWM3U=;
        b=bi2BOqbGrAngbQr6PUR5iah+S+wzSzplcDrOQYuZNWMZLbHhWOhhl93YSnhGYJ6KDH
         6rSvjDUblp/Ldlh4BfXD91DNwBTsYcjZkM6pJiKcqX/dIhGdvPd/sKnr+eEB5GX2THWz
         qQcFE/46clQqiYQf3Jeav00pDpSiFAEidG2mxo3zBRZYkzZtyExpVf9wNS5xkDN9Csjp
         4v20Tt/YFeDOYyyxUIP/cEpebke4Cvditoy+4XmJx0KLckHiJZPyGUTqLomG2KYPBr+O
         r6S6CoDg5XPM+9HoQx+bzPkaOTU7m2Ii0He5Na/EUZ8KzY0mIAKPOWVPLgtZJqHVXacP
         Wr4A==
X-Gm-Message-State: AHQUAubH/foxa0i4O5djk+sQAEFglwYJGrGaPr+wIC6bsU+MQvtEfkIy
        hzbFFRHZhCDqXXOyNPT3Ixf1fmbGR5iynnE8V+pJ5SFh
X-Google-Smtp-Source: AHgI3IbSMqFbPE7V+igdDq3vQjkQrJDvRGvseDSCVvcPW0ZjJ4XBxCYkTt+5ynTeO/bgQtU3MoVlYZ7fZzaNSCd+vRc=
X-Received: by 2002:a67:fc9a:: with SMTP id x26mr1518712vsp.166.1550692038002;
 Wed, 20 Feb 2019 11:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20190220150531.2462-1-geert+renesas@glider.be>
 <20190220150531.2462-8-geert+renesas@glider.be> <20190220154236.GI3516@pendragon.ideasonboard.com>
 <CAMuHMdW2KR=rbtgxbnhW94VCzehX821TMxoTZGKh8uQZMY80cA@mail.gmail.com> <20190220161113.GK3516@pendragon.ideasonboard.com>
In-Reply-To: <20190220161113.GK3516@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Feb 2019 20:47:06 +0100
Message-ID: <CAMuHMdVjtFCbY-tu=3urnncEJB0H7Cn2WFhPgrDxnyQXdr+=HQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] iommu/ipmmu-vmsa: Add suspend/resume support
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Wed, Feb 20, 2019 at 5:11 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wed, Feb 20, 2019 at 05:05:49PM +0100, Geert Uytterhoeven wrote:
> > On Wed, Feb 20, 2019 at 4:42 PM Laurent Pinchart wrote:
> > > On Wed, Feb 20, 2019 at 04:05:31PM +0100, Geert Uytterhoeven wrote:
> > >> During PSCI system suspend, R-Car Gen3 SoCs are powered down, and all
> > >> IPMMU state is lost.  Hence after s2ram, devices wired behind an IPMMU,
> > >> and configured to use it, will see their DMA operations hang.
> > >>
> > >> To fix this, restore all IPMMU contexts, and re-enable all active
> > >> micro-TLBs during system resume.
> > >>
> > >> To avoid overhead on platforms not needing it, the resume code has a
> > >> build time dependency on sleep and PSCI support, and a runtime
> > >> dependency on PSCI.

> > >> --- a/drivers/iommu/ipmmu-vmsa.c
> > >> +++ b/drivers/iommu/ipmmu-vmsa.c

> > >> @@ -1158,10 +1166,52 @@ static int ipmmu_remove(struct platform_device *pdev)
> > >>       return 0;
> > >>  }
> > >>
> > >> +#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM_PSCI_FW)
> > >> +static int ipmmu_resume_noirq(struct device *dev)
> > >> +{
> > >> +     struct ipmmu_vmsa_device *mmu = dev_get_drvdata(dev);
> > >> +     unsigned int i;
> > >> +
> > >> +     /* This is the best we can do to check for the presence of PSCI */
> > >> +     if (!psci_ops.cpu_suspend)
> > >> +             return 0;
> > >
> > > PSCI suspend disabling power to the SoC completely may be a common
> > > behaviour on our development boards, but isn't mandated by the PSCI
> > > specification if I'm not mistaken. Is there a way to instead detect that
> > > power has been lost, perhaps by checking whether a register has been
> > > reset to its default value ?
> >
> > The approach here is the same as in the clk and pinctrl drivers.
> >
> > I think we could check if the IMCTR registers for allocated domains in root
> > IPMMUs are non-zero.  But that's about as expensive as doing the full
> > restore, I think.
>
> Would reading just one register be more expensive that full
> reconfiguration ? Or is there no single register that could serve this
> purpose ?
>
> > And it may have to be done for each and every IPMMU instance, or do
> > you trust caching for this?
>
> If we can find a single register I think that reading it for every IPMMU
> instance wouldn't be an issue.

Upon more thought, probably it can be done by reading the IMCTR
for the first non-zero domain. Will look into it...

> > >> +static const struct dev_pm_ops ipmmu_pm  = {
> > >> +     SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, ipmmu_resume_noirq)
> > >> +};
> > >> +#define DEV_PM_OPS   &ipmmu_pm
> > >> +#else
> > >> +#define DEV_PM_OPS   NULL
> > >> +#endif /* CONFIG_PM_SLEEP && CONFIG_ARM_PSCI_FW */
> > >> +
> > >>  static struct platform_driver ipmmu_driver = {
> > >>       .driver = {
> > >>               .name = "ipmmu-vmsa",
> > >>               .of_match_table = of_match_ptr(ipmmu_of_ids),
> > >> +             .pm = DEV_PM_OPS,
> > >
> > > I would have used conditional compilation here instead of using a
> > > DEV_PM_OPS macro, as I think the macro decreases readability (and also
> > > given how its generic name could later conflict with something else).
> >
> > You mean
> >
> >     #ifdef ...
> >     .pm = &ipmmu_pm,
> >     #endif
> >
> > and marking ipmmu_pm __maybe_unused__?
>
> Yes. Up to you.

I'm not such a big fan of __maybe_unused. It's easy to add, and too
easy to forget to remove it when it's no longer needed (casts have the
same problem).

Usually people just annotate the actual suspend/resume methods with
__maybe_unused, which still leaves the (large) struct dev_pm_ops in
memory.

So I started preferring the DEV_PM_OPS approach...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
