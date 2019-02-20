Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8330C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60F42086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KRvgp1lW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfBTQLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:11:22 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:42410 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfBTQLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:11:21 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 433752D1;
        Wed, 20 Feb 2019 17:11:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1550679078;
        bh=3vktqlHSvk5t4nglVW2sftM3SZBxLGSfZr3JVP9DQ34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KRvgp1lWeVCBolto0SuGp9R8/UZXYh+aW7qYkctZD3OPwcu1KxaI77zBfgAMiRfzh
         nn183l5UvXVm9fU5iGKfO81CWkjaRVGGTCdXAB2G4ACzRp7d6/lHq3bUfKR3njg9aZ
         i1saXdgoFaximEwFgDR9o9daT+mkHu3ghSCuBwbw=
Date:   Wed, 20 Feb 2019 18:11:13 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] iommu/ipmmu-vmsa: Add suspend/resume support
Message-ID: <20190220161113.GK3516@pendragon.ideasonboard.com>
References: <20190220150531.2462-1-geert+renesas@glider.be>
 <20190220150531.2462-8-geert+renesas@glider.be>
 <20190220154236.GI3516@pendragon.ideasonboard.com>
 <CAMuHMdW2KR=rbtgxbnhW94VCzehX821TMxoTZGKh8uQZMY80cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdW2KR=rbtgxbnhW94VCzehX821TMxoTZGKh8uQZMY80cA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Wed, Feb 20, 2019 at 05:05:49PM +0100, Geert Uytterhoeven wrote:
> On Wed, Feb 20, 2019 at 4:42 PM Laurent Pinchart wrote:
> > On Wed, Feb 20, 2019 at 04:05:31PM +0100, Geert Uytterhoeven wrote:
> >> During PSCI system suspend, R-Car Gen3 SoCs are powered down, and all
> >> IPMMU state is lost.  Hence after s2ram, devices wired behind an IPMMU,
> >> and configured to use it, will see their DMA operations hang.
> >>
> >> To fix this, restore all IPMMU contexts, and re-enable all active
> >> micro-TLBs during system resume.
> >>
> >> To avoid overhead on platforms not needing it, the resume code has a
> >> build time dependency on sleep and PSCI support, and a runtime
> >> dependency on PSCI.
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >> This patch takes a different approach than the BSP, which implements a
> >> bulk save/restore of all registers during system suspend/resume.
> >
> > I like this approach better too.
> 
> Thanks ;-)
> 
> >> --- a/drivers/iommu/ipmmu-vmsa.c
> >> +++ b/drivers/iommu/ipmmu-vmsa.c
> 
> >> @@ -58,6 +62,7 @@ struct ipmmu_vmsa_device {
> >>       spinlock_t lock;                        /* Protects ctx and domains[] */
> >>       DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
> >>       struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
> >> +     s8 utlb_ctx[IPMMU_UTLB_MAX];
> >
> > How about making this a bitmask instead to save memory ? I would also
> > rename it as utlb_ctx doesn't really carry the meaning of the field,
> > whose purpose is to store whether the µTLB is enabled or disabled.
> 
> This field isn't just a binary flag, but stores the context used for the
> uTLB, so we can map from micro-TLB to context.
> Given there can be 8 contexts, plus the need to indicate unused contexts,
> that means 4 bits/micro-TLB.  So the overhead is just 24 bytes per IPMMU
> instance.

My bad, I've overlooked that.

> I considered allocating the array dynamically (by having s8 utlb_ctx[]
> at the end of the structure), but didn't go that route, as the domains[]
> array already uses more memory.
> 
> >> @@ -1158,10 +1166,52 @@ static int ipmmu_remove(struct platform_device *pdev)
> >>       return 0;
> >>  }
> >>
> >> +#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM_PSCI_FW)
> >> +static int ipmmu_resume_noirq(struct device *dev)
> >> +{
> >> +     struct ipmmu_vmsa_device *mmu = dev_get_drvdata(dev);
> >> +     unsigned int i;
> >> +
> >> +     /* This is the best we can do to check for the presence of PSCI */
> >> +     if (!psci_ops.cpu_suspend)
> >> +             return 0;
> >
> > PSCI suspend disabling power to the SoC completely may be a common
> > behaviour on our development boards, but isn't mandated by the PSCI
> > specification if I'm not mistaken. Is there a way to instead detect that
> > power has been lost, perhaps by checking whether a register has been
> > reset to its default value ?
> 
> The approach here is the same as in the clk and pinctrl drivers.
> 
> I think we could check if the IMCTR registers for allocated domains in root
> IPMMUs are non-zero.  But that's about as expensive as doing the full
> restore, I think.

Would reading just one register be more expensive that full
reconfiguration ? Or is there no single register that could serve this
purpose ?

> And it may have to be done for each and every IPMMU instance, or do
> you trust caching for this?

If we can find a single register I think that reading it for every IPMMU
instance wouldn't be an issue.

> >> +
> >> +     /* Reset root MMU and restore contexts */
> >
> > I think the rest of the code adds a period at the end of sentences in
> > comments.
> 
> The balance seems to be just under 50% ;-)
> 
> >> +     if (ipmmu_is_root(mmu)) {
> >> +             ipmmu_device_reset(mmu);
> >> +
> >> +             for (i = 0; i < mmu->num_ctx; i++) {
> >> +                     if (!mmu->domains[i])
> >> +                             continue;
> >> +
> >> +                     ipmmu_context_init(mmu->domains[i]);
> >> +             }
> >> +     }
> >> +
> >> +     /* Re-enable active micro-TLBs */
> >> +     for (i = 0; i < mmu->features->num_utlbs; i++) {
> >> +             if (mmu->utlb_ctx[i] == IPMMU_CTX_INVALID)
> >> +                     continue;
> >> +
> >> +             ipmmu_utlb_enable(mmu->root->domains[mmu->utlb_ctx[i]], i);
> >> +     }
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +static const struct dev_pm_ops ipmmu_pm  = {
> >> +     SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, ipmmu_resume_noirq)
> >> +};
> >> +#define DEV_PM_OPS   &ipmmu_pm
> >> +#else
> >> +#define DEV_PM_OPS   NULL
> >> +#endif /* CONFIG_PM_SLEEP && CONFIG_ARM_PSCI_FW */
> >> +
> >>  static struct platform_driver ipmmu_driver = {
> >>       .driver = {
> >>               .name = "ipmmu-vmsa",
> >>               .of_match_table = of_match_ptr(ipmmu_of_ids),
> >> +             .pm = DEV_PM_OPS,
> >
> > I would have used conditional compilation here instead of using a
> > DEV_PM_OPS macro, as I think the macro decreases readability (and also
> > given how its generic name could later conflict with something else).
> 
> You mean
> 
>     #ifdef ...
>     .pm = &ipmmu_pm,
>     #endif
> 
> and marking ipmmu_pm __maybe_unused__?

Yes. Up to you.

-- 
Regards,

Laurent Pinchart
