Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CC1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA8A2081C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA8A2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbeKMQ3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:29:10 -0500
Received: from foss.arm.com ([217.140.101.70]:48122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeKMQ3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 11:29:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB6FCA78;
        Mon, 12 Nov 2018 22:32:31 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 888F33F718;
        Mon, 12 Nov 2018 22:32:31 -0800 (PST)
Date:   Tue, 13 Nov 2018 06:32:26 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu: arm-smmu: Set SCTLR.HUPCF bit
Message-ID: <20181113063225.GA3109@brain-police>
References: <20180927224609.19515-1-robdclark@gmail.com>
 <20181029191000.GD16739@arm.com>
 <CAF6AEGtgC0V6ii2=p2HGmqvHFKNJhaOLi8873SGPDsrg70xGRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGtgC0V6ii2=p2HGmqvHFKNJhaOLi8873SGPDsrg70xGRg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 01:01:55PM -0500, Rob Clark wrote:
> On Mon, Oct 29, 2018 at 3:09 PM Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Sep 27, 2018 at 06:46:07PM -0400, Rob Clark wrote:
> > > We seem to need to set either this or CFCFG (stall), otherwise gpu
> > > faults trigger problems with other in-flight transactions from the
> > > GPU causing CP errors, etc.
> > >
> > > In the ARM SMMU spec, the 'Hit under previous context fault' bit is
> > > described as:
> > >
> > >  '0' - Stall or terminate subsequent transactions in the presence
> > >        of an outstanding context fault
> > >  '1' - Process all subsequent transactions independently of any
> > >        outstanding context fault.
> > >
> > > Since we don't enable CFCFG (stall) the behavior of terminating
> > > other transactions makes sense.  And is probably not what we want
> > > (and definately not what we want for GPU).
> > >
> > > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > > ---
> > > So I hit this issue a long time back on 820 (msm8996) and at the
> > > time I solved it with a patch that enabled CFCFG.  And it resurfaced
> > > more recently on sdm845.  But at the time CFCFG was rejected, iirc
> > > because of concern that it would cause problems on other non-qcom
> > > arm smmu implementations.  And I think I forgot to send this version
> > > of the solution.
> > >
> > > If enabling HUPCF is anticipated to cause problems on other ARM
> > > SMMU implementations, I think I can come up with a variant of this
> > > patch which conditionally enables it for snapdragon.
> > >
> > > Either way, I'd really like to get some variant of this fix merged
> > > (and probably it would be a good idea for stable kernel branches
> > > too), since current behaviour with the GPU means faults turn into
> > > a fantastic cascade of fail.
> >
> > Can you describe how this fantastic cascade of fail improves with this
> > patch, please? If you're getting context faults then something has already
> > gone horribly wrong, so I'm trying to work out how this improves things.
> >
> 
> There are plenty of cases where getting iommu faults with a GPU is
> "normal", or at least not something the kernel or even GL driver can
> control.

Such as? All the mainline driver does is print a diagnostic and clear the
fault, which doesn't seem generally useful.

> With this patch, you still get the iommu fault, but it doesn't cause
> the gpu to crash.  But without it, other memory accesses in flight
> while the fault occurs, like the GPU command-processor reading further
> ahead in the cmdstream to setup next draw, would return zero's,
> causing the GPU to crash or get into a bad state.

I get that part, but I don't understand why we're seeing faults in the first
place and I worry that this patch is just the tip of the iceberg. It's also
not clear that processing subsequent transactions is always the right thing
to do in a world where we actually want to report (and handle) synchronous
faults from devices.

Will
