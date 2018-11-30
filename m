Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C292CC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975CA20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975CA20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeLAFZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:25:26 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34176 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeLAFZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:25:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1CD0165C;
        Fri, 30 Nov 2018 10:15:18 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7E8AA3F575;
        Fri, 30 Nov 2018 10:15:18 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 5D94B1AE0FA2; Fri, 30 Nov 2018 18:15:37 +0000 (GMT)
Date:   Fri, 30 Nov 2018 18:15:37 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, sboyd@kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, robh+dt <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>
Subject: Re: [PATCH v18 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
Message-ID: <20181130181536.GA15274@arm.com>
References: <20181127101145.7682-1-vivek.gautam@codeaurora.org>
 <20181127101145.7682-2-vivek.gautam@codeaurora.org>
 <154342225921.88331.14467967828250776155@swboyd.mtv.corp.google.com>
 <0d76b669-6c4f-7c3b-50a1-084201f2c07a@arm.com>
 <CAFp+6iEC8hobAdVF5nLdhQdCUqbi1xa4Vi-NLugGshV=dg+h1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFp+6iEC8hobAdVF5nLdhQdCUqbi1xa4Vi-NLugGshV=dg+h1A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 08:25:20PM +0530, Vivek Gautam wrote:
> On Wed, Nov 28, 2018 at 10:07 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 28/11/2018 16:24, Stephen Boyd wrote:
> > > Quoting Vivek Gautam (2018-11-27 02:11:41)
> > >> @@ -1966,6 +1970,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
> > >>   };
> > >>   MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
> > >>
> > >> +static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
> > >> +                                  const char * const *clks)
> > >> +{
> > >> +       int i;
> > >> +
> > >> +       if (smmu->num_clks < 1)
> > >> +               return;
> > >> +
> > >> +       smmu->clks = devm_kcalloc(smmu->dev, smmu->num_clks,
> > >> +                                 sizeof(*smmu->clks), GFP_KERNEL);
> > >> +       if (!smmu->clks)
> > >> +               return;
> > >> +
> > >> +       for (i = 0; i < smmu->num_clks; i++)
> > >> +               smmu->clks[i].id = clks[i];
> > >
> > > Is this clk_bulk_get_all()?
> 
> From what I remember, and now I could go back to v7 and check [1], we parked
> clk_bulk_get out of OF's sole purview as we also have
> arm_smmu_device_acpi_probe() besides arm_smmu_device_dt_probe().
> 
> arm_smmu_device_dt_probe() could get the clocks from dt and fill in
> the clock bulk data, and
> similarly, arm_smmu_device_acpi_probe() could fill the clock bulk data
> by getting it from ACPI.
> 
> clk_bulk_get_all() seems like going only the OF way.
> Is there another way here to have something common between ACPI
> and OF, and then do the clk_bulk_get?

I'd say just go with clk_bulk_get_all() and if somebody really wants to
mess with the SMMU clocks on a system booted via ACPI, then it's their
problem to solve. My understanding is that the design of IORT makes this
next to impossible to solve anyway, because a static table is used and
therefore we're unable to run whatever ASL methods need to be invoked to
mess with the clocks.

Will
