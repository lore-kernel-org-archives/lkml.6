Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29869ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC30208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oKUyY5cX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ln88VuGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC30208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbeITBPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:15:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38872 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731812AbeITBPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:15:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AFF28607BD; Wed, 19 Sep 2018 19:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537385743;
        bh=2NzT+LzwrGCE0hqlHYzR1gSBaNSFnC9qxSW5NDVsDe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKUyY5cXrauBPVhxU/5qvKxlTZ5ZEhfwNw+gYDuYwGdlOCk9avTIjo6uj5mesHLa7
         hr/+dM5sAc6vU7prhZQ/NqPlztAByO1G1AJmHcXIRmepFZmHtpx025wnkYC4pKibJD
         S7QuihADBZsQ5nzjUnOk8W2h3Coiv5lmENw4kiZk=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1BFAD600ED;
        Wed, 19 Sep 2018 19:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537385742;
        bh=2NzT+LzwrGCE0hqlHYzR1gSBaNSFnC9qxSW5NDVsDe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ln88VuGaFGPfja59BUQ5SjPo4s41/t6bd+90U8WUFgMLG+5aifRvED0jnpYPG4tTj
         xjP7OWcLZsLk/9AZJGcfAhCtvOI1gNWaMyVkEA8jBrAN2oD5KFoXgUcCAeiQTNp4TP
         TDOHZfRwgMQrkgzdamYD6qjrdKW2zkZYZAQ0FSPY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1BFAD600ED
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Wed, 19 Sep 2018 13:35:39 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        pdaly@codeaurora.org
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
Message-ID: <20180919193539.GB809@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Vivek Gautam <vivek.gautam@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        pdaly@codeaurora.org
References: <20180615105329.26800-1-vivek.gautam@codeaurora.org>
 <20180615165232.GE2202@arm.com>
 <CAFp+6iFm29ufb2Pr7Gb-2O_aN3GQLH4rcyWhbQGZ3QiwCC8vPg@mail.gmail.com>
 <20180627163749.GA8729@arm.com>
 <CAFp+6iHnA1Jj8wKO08YYEBKVF2_3oEuOQOcW2boL=AYZ9+b=UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFp+6iHnA1Jj8wKO08YYEBKVF2_3oEuOQOcW2boL=AYZ9+b=UA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 03:13:37PM +0530, Vivek Gautam wrote:
> Hi Will,
> 
> 
> On Wed, Jun 27, 2018 at 10:07 PM, Will Deacon <will.deacon@arm.com> wrote:
> > Hi Vivek,
> >
> > On Tue, Jun 19, 2018 at 02:04:44PM +0530, Vivek Gautam wrote:
> >> On Fri, Jun 15, 2018 at 10:22 PM, Will Deacon <will.deacon@arm.com> wrote:
> >> > On Fri, Jun 15, 2018 at 04:23:29PM +0530, Vivek Gautam wrote:
> >> >> Qualcomm SoCs have an additional level of cache called as
> >> >> System cache or Last level cache[1]. This cache sits right
> >> >> before the DDR, and is tightly coupled with the memory
> >> >> controller.
> >> >> The cache is available to all the clients present in the
> >> >> SoC system. The clients request their slices from this system
> >> >> cache, make it active, and can then start using it. For these
> >> >> clients with smmu, to start using the system cache for
> >> >> dma buffers and related page tables [2], few of the memory
> >> >> attributes need to be set accordingly.
> >> >> This change makes the related memory Outer-Shareable, and
> >> >> updates the MAIR with necessary protection.
> >> >>
> >> >> The MAIR attribute requirements are:
> >> >>     Inner Cacheablity = 0
> >> >>     Outer Cacheablity = 1, Write-Back Write Allocate
> >> >>     Outer Shareablity = 1
> >> >
> >> > Hmm, so is this cache coherent with the CPU or not?
> >>
> >> Thanks for reviewing.
> >> Yes, this LLC is cache coherent with CPU, so we mark for Outer-cacheable.
> >> The different masters such as GPU as able to allocated and activate a slice
> >> in this Last Level Cache.
> >
> > What I mean is, for example, if the CPU writes some data using Normal, Inner
> > Shareable, Inner/Outer Cacheable, Inner/Outer Write-back, Non-transient
> > Read/Write-allocate and a device reads that data using your MAIR encoding
> > above, is the device guaranteed to see the CPU writes after the CPU has
> > executed a DSB instruction?
> >
> > I don't think so, because the ARM ARM would say that there's a mismatch on
> > the Inner Cacheability attribute.
> >
> >> > Why don't normal
> >> > non-cacheable mappings allocated in the LLC by default?
> >>
> >> Sorry, I couldn't fully understand your question here.
> >> Few of the masters on qcom socs are not io-coherent, so for them
> >> the IC has to be marked as 0.
> >
> > By IC you mean Inner Cacheability? In your MAIR encoding above, it is zero
> > so I don't understand the problem. What goes wrong if non-coherent devices
> > use your MAIR encoding for their DMA buffers?
> >
> >> But they are able to use the LLC with OC marked as 1.
> >
> > The issue here is that whatever attributes we put in the SMMU need to align
> > with the attributes used by the CPU in order to avoid introducing mismatched
> > aliases. Currently, we support three types of mapping in the SMMU:
> >
> > 1. DMA non-coherent (e.g. "dma-coherent" is not set on the device)
> >         Normal, Inner Shareable, Inner/Outer Non-Cacheable
> >
> > 2. DMA coherent (e.g. "dma-coherent" is set on the device) [IOMMU_CACHE]
> >         Normal, Inner Shareable, Inner/Outer Cacheable, Inner/Outer
> >         Write-back, Non-transient Read/Write-allocate
> >
> > 3. MMIO (e.g. MSI doorbell) [IOMMU_MMIO]
> >         Device-nGnRE (Outer Shareable)
> >
> > So either you override one of these types (I was suggesting (1)) or you need
> > to create a new memory type, along with the infrastructure for it to be
> > recognised on a per-device basis and used by the DMA API so that we don't
> > get mismatched aliases on the CPU.
> 
> My apologies for delay in responding to this thread.
> I have been digging and getting in touch with internal tech teams
> to get more information on this. I will update as soon as I have enough
> details.
> Thanks.

Hi Vivek.  I want to revive this discussion. I believe that Andy has pulled
in the base LLCC support so this the remaining dependency we need to implement
the LLCC in the GPU driver. 

Thanks,
Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
