Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150BDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2A920824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2A920824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389252AbeKXFTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:19:38 -0500
Received: from foss.arm.com ([217.140.101.70]:50980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbeKXFTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 00:19:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AC553620;
        Fri, 23 Nov 2018 10:34:13 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC8653F5CF;
        Fri, 23 Nov 2018 10:34:12 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 466221AE1019; Fri, 23 Nov 2018 18:34:29 +0000 (GMT)
Date:   Fri, 23 Nov 2018 18:34:29 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     thor.thayer@linux.intel.com, Tomasz Figa <tfiga@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
        sboyd@kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        alex.williamson@redhat.com, robh+dt <robh+dt@kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RESEND PATCH v17 5/5] iommu/arm-smmu: Add support for
 qcom,smmu-v2 variant
Message-ID: <20181123183428.GD21183@arm.com>
References: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
 <20181116112430.31248-6-vivek.gautam@codeaurora.org>
 <20181121173803.GB9801@arm.com>
 <CAFp+6iELH7Mw3Ue2ksEyV+Ac8hG8--Ki69xrPCA4F-AcireRow@mail.gmail.com>
 <CAAFQd5B-bZR8dmjARb8L4oqgET2YAjXhexAO0GKAvU4JoVU=7g@mail.gmail.com>
 <CAFp+6iFhBRJWGY4Hj30tWedGpEUcnkBJrOvffmbpD2m9QMZB3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFp+6iFhBRJWGY4Hj30tWedGpEUcnkBJrOvffmbpD2m9QMZB3A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 03:06:29PM +0530, Vivek Gautam wrote:
> On Fri, Nov 23, 2018 at 2:52 PM Tomasz Figa <tfiga@chromium.org> wrote:
> > On Fri, Nov 23, 2018 at 6:13 PM Vivek Gautam
> > <vivek.gautam@codeaurora.org> wrote:
> > > On Wed, Nov 21, 2018 at 11:09 PM Will Deacon <will.deacon@arm.com> wrote:
> > > > On Fri, Nov 16, 2018 at 04:54:30PM +0530, Vivek Gautam wrote:
> > > > > @@ -2026,6 +2027,17 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
> > > > >  ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
> > > > >  ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
> > > > >
> > > > > +static const char * const qcom_smmuv2_clks[] = {
> > > > > +     "bus", "iface",
> > > > > +};
> > > > > +
> > > > > +static const struct arm_smmu_match_data qcom_smmuv2 = {
> > > > > +     .version = ARM_SMMU_V2,
> > > > > +     .model = QCOM_SMMUV2,
> > > > > +     .clks = qcom_smmuv2_clks,
> > > > > +     .num_clks = ARRAY_SIZE(qcom_smmuv2_clks),
> > > > > +};
> > > >
> > > > These seems redundant if we go down the route proposed by Thor, where we
> > > > just pull all of the clocks out of the device-tree. In which case, why
> > > > do we need this match_data at all?
> > >
> > > Which is better? Driver relying solely on the device tree to tell
> > > which all clocks
> > > are required to be enabled,
> > > or, the driver deciding itself based on the platform's match data,
> > > that it should
> > > have X, Y, & Z clocks that should be supplied from the device tree.
> >
> > The former would simplify the driver, but would also make it
> > impossible to spot mistakes in DT, which would ultimately surface out
> > as very hard to debug bugs (likely complete system lockups).
> 
> Thanks.
> Yea, this is how I understand things presently. Relying on device tree
> puts the things out of driver's control.

But it also has the undesirable effect of having to update the driver
code whenever we want to add support for a new SMMU implementation. If
we do this all in the DT, as Thor is trying to do, then older kernels
will work well with new hardware.

> Hi Will,
> Am I unable to understand the intentions here for Thor's clock-fetch
> design change?

I'm having trouble parsing your question, sorry. Please work with Thor
so that we have a single way to get the clock information. My preference
is to take it from the firmware, for the reason I stated above.

Will
