Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48627C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECDD2177A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="huCXoHha";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W63g19ri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECDD2177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeHCS5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:57:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35174 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeHCS5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:57:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9858C602B7; Fri,  3 Aug 2018 17:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533315632;
        bh=6RJFM3v39Wb2v7D5Smk+rPyw23m0556pRLdxNAyjMOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=huCXoHhamEjpqDDI8EIu/17Ut8eOpxntZW2mX0ijdUTIooQ1kMJrsAoSuuZR43AYW
         Gv4M/hSUUWC7f5d/dbgp7mfy428FFdKcljlM6/3zofhoXdBBbRX/IGUcTxL3PSYJN2
         QdSTKWVfP8uRKxrkmwGanxwbPHv/ybcEXCOJZifs=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1834F602B7;
        Fri,  3 Aug 2018 17:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533315630;
        bh=6RJFM3v39Wb2v7D5Smk+rPyw23m0556pRLdxNAyjMOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W63g19riGJWaLMisWL64cZQ6QEQnftWbcytvtXEimkfT7tDXXBfeosTmwAnVCE5pu
         K0pzJyO/6g2+pE2tZia0xO5Xt6pI5MNm6oNizIeQNvyZXWXlLcK6XHmQ6bIDELWO37
         sQWl2r5qtzrgSq9kFOMxbfYs1U9vXDxpPCRhOe0k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1834F602B7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Fri, 3 Aug 2018 11:00:26 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, nouveau@lists.freedesktop.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-tegra@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/6] Resolve unwanted DMA backing with IOMMU
Message-ID: <20180803170026.GD21283@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Robin Murphy <robin.murphy@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, nouveau@lists.freedesktop.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-tegra@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20180726231624.21084-1-digetx@gmail.com>
 <20180727170326.GA21283@jcrouse-lnx.qualcomm.com>
 <2402373.RyBdR7VSnO@dimapc>
 <2887450.sPhIOOMKZK@dimapc>
 <2e7fab6e-0640-8f48-07b8-2d475538b8ae@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e7fab6e-0640-8f48-07b8-2d475538b8ae@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 04:43:41PM +0100, Robin Murphy wrote:
> On 02/08/18 19:24, Dmitry Osipenko wrote:
> >On Friday, 27 July 2018 20:16:53 MSK Dmitry Osipenko wrote:
> >>On Friday, 27 July 2018 20:03:26 MSK Jordan Crouse wrote:
> >>>On Fri, Jul 27, 2018 at 05:02:37PM +0100, Robin Murphy wrote:
> >>>>On 27/07/18 15:10, Dmitry Osipenko wrote:
> >>>>>On Friday, 27 July 2018 12:03:28 MSK Will Deacon wrote:
> >>>>>>On Fri, Jul 27, 2018 at 10:25:13AM +0200, Joerg Roedel wrote:
> >>>>>>>On Fri, Jul 27, 2018 at 02:16:18AM +0300, Dmitry Osipenko wrote:
> >>>>>>>>The proposed solution adds a new option to the base device driver
> >>>>>>>>structure that allows device drivers to explicitly convey to the
> >>>>>>>>drivers
> >>>>>>>>core that the implicit IOMMU backing for devices must not happen.
> >>>>>>>
> >>>>>>>Why is IOMMU mapping a problem for the Tegra GPU driver?
> >>>>>>>
> >>>>>>>If we add something like this then it should not be the choice of the
> >>>>>>>device driver, but of the user and/or the firmware.
> >>>>>>
> >>>>>>Agreed, and it would still need somebody to configure an identity
> >>>>>>domain
> >>>>>>so
> >>>>>>that transactions aren't aborted immediately. We currently allow the
> >>>>>>identity domain to be used by default via a command-line option, so I
> >>>>>>guess
> >>>>>>we'd need a way for firmware to request that on a per-device basis.
> >>>>>
> >>>>>The IOMMU mapping itself is not a problem, the problem is the
> >>>>>management
> >>>>>of
> >>>>>the IOMMU. For Tegra we don't want anything to intrude into the IOMMU
> >>>>>activities because:
> >>>>>
> >>>>>1) GPU HW require additional configuration for the IOMMU usage and dumb
> >>>>>mapping of the allocations simply doesn't work.
> >>>>
> >>>>Generally, that's already handled by the DRM drivers allocating
> >>>>their own unmanaged domains. The only problem we really need to
> >>>>solve in that regard is that currently the device DMA ops don't get
> >>>>updated when moving away from the managed domain. That's been OK for
> >>>>the VFIO case where the device is bound to a different driver which
> >>>>we know won't make any explicit DMA API calls, but for the more
> >>>>general case of IOMMU-aware drivers we could certainly do with a bit
> >>>>of cooperation between the IOMMU API, DMA API, and arch code to
> >>>>update the DMA ops dynamically to cope with intermediate subsystems
> >>>>making DMA API calls on behalf of devices they don't know the
> >>>>intimate details of.
> >>>>
> >>>>>2) Older Tegra generations have a limited resource and capabilities in
> >>>>>regards to IOMMU usage, allocating IOMMU domain per-device is just
> >>>>>impossible for example.
> >>>>>
> >>>>>3) HW performs context switches and so particular allocations have to
> >>>>>be
> >>>>>assigned to a particular contexts IOMMU domain.
> >>>>
> >>>>I understand Qualcomm SoCs have a similar thing too, and AFAICS that
> >>>>case just doesn't fit into the current API model at all. We need the
> >>>>IOMMU driver to somehow know about the specific details of which
> >>>>devices have magic associations with specific contexts, and we
> >>>>almost certainly need a more expressive interface than
> >>>>iommu_domain_alloc() to have any hope of reliable results.
> >>>
> >>>This is correct for Qualcomm GPUs - The GPU hardware context switching
> >>>requires a specific context and there are some restrictions around
> >>>secure contexts as well.
> >>>
> >>>We don't really care if the DMA attaches to a context just as long as it
> >>>doesn't attach to the one(s) we care about. Perhaps a "valid context" mask
> >>>would work in from the DT or the device struct to give the subsystems a
> >>>clue as to which domains they were allowed to use. I recognize that there
> >>>isn't a one-size-fits-all solution to this problem so I'm open to
> >>>different
> >>>ideas.
> >>
> >>Designating whether implicit IOMMU backing is appropriate for a device via
> >>device-tree property sounds a bit awkward because that will be a kinda
> >>software description (of a custom Linux driver model), while device-tree is
> >>supposed to describe HW.
> >>
> >>What about to grant IOMMU drivers with ability to decide whether the
> >>implicit backing for a device is appropriate? Like this:
> >>
> >>bool implicit_iommu_for_dma_is_allowed(struct device *dev)
> >>{
> >>	const struct iommu_ops *ops = dev->bus->iommu_ops;
> >>	struct iommu_group *group;
> >>
> >>	group = iommu_group_get(dev);
> >>	if (!group)
> >>		return NULL;
> >>
> >>	iommu_group_put(group);
> >>
> >>	if (!ops->implicit_iommu_for_dma_is_allowed)
> >>		return true;
> >>
> >>	return ops->implicit_iommu_for_dma_is_allowed(dev);
> >>}
> >>
> >>Then arch_setup_dma_ops() could have a clue whether implicit IOMMU backing
> >>for a device is appropriate.
> >
> >Guys, does it sound good to you or maybe you have something else on your mind?
> >Even if it's not an ideal solution, it fixes the immediate problem and should
> >be good enough for the starter.
> 
> To me that looks like a step ion the wrong direction that won't help
> at all in actually addressing the underlying issues.
> 
> If the GPU driver wants to explicitly control IOMMU mappings instead
> of relying on the IOMMU_DOMAIN_DMA abstraction, then it should use
> its own unmanaged domain. At that point it shouldn't matter if a DMA
> ops domain was allocated, since the GPU device will no longer be
> attached to it. Yes, there may be some improvements to make like
> having unused domains not consume hardware contexts, but that's
> internal to the relevant IOMMU drivers. If moving in and out of DMA
> ops domains leaves the actual dma_ops broken, that's already a
> problem between the IOMMU API and the arch DMA code as I've
> mentioned before.
> 
> Furthermore, given what the example above is trying to do,
> arch_setup_dma_ops() is way too late to do it - the default domain
> was already set up in iommu_group_get_for_dev() when the IOMMU
> driver first saw that device. An "opt-out" mechanism that doesn't
> actually opt out and just bodges around being opted-in after the
> fact doesn't strike me as something which can grow to be robust and
> maintainable.
> 
> For the case where  a device has some special hardware relationship
> with a particular IOMMU context, the IOMMU driver *has* to be
> completely aware of that, i.e. it needs to be described in DT/ACPI,
> either via some explicit binding or at least inferred from some
> SoC/instance-specific IOMMU compatible. Then the IOMMU driver needs
> to know when the driver for that device is requesting its special
> domain so that it provide the correct context (and *not* allocate
> that context for other uses). Anything which just relies on the
> order in which things currently happen to be allocated is far too
> fragile long-term.

Speculating what this would look like for arm-smmu-v2. Thinking we
would add either a mask or a bit to the per-device smmu data to identify
the "available" contexts for dma (or alternatively, the "reserved" domains
for  the device) and then change up _arm_smmu_alloc_bitmap() to hand out
the right numbers accordingly.

Then that leaves the interface for the device to request a specific context
- I guess a DOMAIN_ATTR would work for that in lieu of changing
iommu_alloc_domain() and friends.

Would this match up with your thinking?

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
