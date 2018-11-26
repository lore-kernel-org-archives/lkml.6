Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3667DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0400E20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0400E20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeK0G0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:26:43 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45968 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbeK0G0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:26:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DCC82381;
        Mon, 26 Nov 2018 11:31:35 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E1D333F5AF;
        Mon, 26 Nov 2018 11:31:34 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 6FDF31AE0839; Mon, 26 Nov 2018 19:31:52 +0000 (GMT)
Date:   Mon, 26 Nov 2018 19:31:52 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alex.williamson@redhat.com,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        freedreno <freedreno@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, robh+dt <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RESEND PATCH v17 2/5] iommu/arm-smmu: Invoke pm_runtime during
 probe, add/remove device
Message-ID: <20181126193151.GC534@arm.com>
References: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
 <20181116112430.31248-3-vivek.gautam@codeaurora.org>
 <20181121173757.GA9801@arm.com>
 <CAFp+6iEH7_XEcZNsbZfn6iBF5_o-ZKBj=DpturH7N85LU289qg@mail.gmail.com>
 <20181123183555.GE21183@arm.com>
 <9064c01e-cef0-9306-078a-8d303cd6614b@codeaurora.org>
 <d66c5dbf-2e44-a915-14a0-1968c8ede832@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d66c5dbf-2e44-a915-14a0-1968c8ede832@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:56:42PM +0530, Vivek Gautam wrote:
> On 11/26/2018 11:33 AM, Vivek Gautam wrote:
> >On 11/24/2018 12:06 AM, Will Deacon wrote:
> >>On Thu, Nov 22, 2018 at 05:32:24PM +0530, Vivek Gautam wrote:
> >>>On Wed, Nov 21, 2018 at 11:09 PM Will Deacon <will.deacon@arm.com>
> >>>wrote:
> >>>>On Fri, Nov 16, 2018 at 04:54:27PM +0530, Vivek Gautam wrote:
> >>>>>From: Sricharan R <sricharan@codeaurora.org>
> >>>>>
> >>>>>The smmu device probe/remove and add/remove master device callbacks
> >>>>>gets called when the smmu is not linked to its master, that is
> >>>>>without
> >>>>>the context of the master device. So calling runtime apis in those
> >>>>>places
> >>>>>separately.
> >>>>>Global locks are also initialized before enabling runtime pm as the
> >>>>>runtime_resume() calls device_reset() which does tlb_sync_global()
> >>>>>that ultimately requires locks to be initialized.
> >>>>>
> >>>>>Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> >>>>>[vivek: Cleanup pm runtime calls]
> >>>>>Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> >>>>>Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> >>>>>Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >>>>>Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> >>>>>---
> >>>>>  drivers/iommu/arm-smmu.c | 101
> >>>>>++++++++++++++++++++++++++++++++++++++++++-----
> >>>>>  1 file changed, 91 insertions(+), 10 deletions(-)
> >>>>Given that you're doing the get/put in the TLBI ops unconditionally:
> >>>>
> >>>>>  static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
> >>>>>  {
> >>>>>       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> >>>>>+     struct arm_smmu_device *smmu = smmu_domain->smmu;
> >>>>>
> >>>>>-     if (smmu_domain->tlb_ops)
> >>>>>+     if (smmu_domain->tlb_ops) {
> >>>>>+             arm_smmu_rpm_get(smmu);
> >>>>>smmu_domain->tlb_ops->tlb_flush_all(smmu_domain);
> >>>>>+             arm_smmu_rpm_put(smmu);
> >>>>>+     }
> >>>>>  }
> >>>>>
> >>>>>  static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
> >>>>>  {
> >>>>>       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> >>>>>+     struct arm_smmu_device *smmu = smmu_domain->smmu;
> >>>>>
> >>>>>-     if (smmu_domain->tlb_ops)
> >>>>>+     if (smmu_domain->tlb_ops) {
> >>>>>+             arm_smmu_rpm_get(smmu);
> >>>>>smmu_domain->tlb_ops->tlb_sync(smmu_domain);
> >>>>>+             arm_smmu_rpm_put(smmu);
> >>>>>+     }
> >>>>Why do you need them around the map/unmap calls as well?
> >>>We still have .tlb_add_flush path?
> >>Ok, so we could add the ops around that as well. Right now, we've got
> >>the runtime pm hooks crossing two parts of the API.
> >
> >Sure, will do that then, and remove the runtime pm hooks from map/unmap.
> 
> I missed this earlier -
> We are adding runtime pm hooks in the 'iommu_ops' callbacks and not really
> to
> 'tlb_ops'. So how the runtime pm hooks crossing the paths?
> '.map/.unmap' iommu_ops don't call '.flush_iotlb_all' or '.iotlb_sync'
> iommu_ops
> anywhere.
> 
> E.g., only callers to domain->ops->flush_iotlb_all() are:
> iommu_dma_flush_iotlb_all(), or iommu_flush_tlb_all() which are not in
> map/unmap paths.

Yes, sorry, I got confused here and completely misled you. In which case,
your original patch is ok because it intercepts the core IOMMU API via
iommu_ops. Apologies.

At that level, should we also annotate arm_smmu_iova_to_phys_hard()
for the iova_to_phys() implementation?

With that detail and clock bits sorted out, we should be able to get this
queued at last.

Will
