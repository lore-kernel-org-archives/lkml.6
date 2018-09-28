Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315EBC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84C7216FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84C7216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbeI1TKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:10:48 -0400
Received: from foss.arm.com ([217.140.101.70]:49036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbeI1TKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:10:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E59BFED1;
        Fri, 28 Sep 2018 05:47:10 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 862313F5D3;
        Fri, 28 Sep 2018 05:47:08 -0700 (PDT)
Date:   Fri, 28 Sep 2018 13:47:05 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: Re: [PATCH v8 5/7] iommu/arm-smmu-v3: Add support for non-strict mode
Message-ID: <20180928124704.GC1577@brain-police>
References: <cover.1537458163.git.robin.murphy@arm.com>
 <b98f8f695178c9c9ac6e081680090d5ac97e8d7c.1537458163.git.robin.murphy@arm.com>
 <20180928121900.GB1577@brain-police>
 <1d2b57f7-be4e-39c5-4981-7f8e2f601b6a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d2b57f7-be4e-39c5-4981-7f8e2f601b6a@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 01:26:00PM +0100, Robin Murphy wrote:
> On 28/09/18 13:19, Will Deacon wrote:
> > On Thu, Sep 20, 2018 at 05:10:25PM +0100, Robin Murphy wrote:
> > > From: Zhen Lei <thunder.leizhen@huawei.com>
> > > 
> > > Now that io-pgtable knows how to dodge strict TLB maintenance, all
> > > that's left to do is bridge the gap between the IOMMU core requesting
> > > DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE for default domains, and showing the
> > > appropriate IO_PGTABLE_QUIRK_NON_STRICT flag to alloc_io_pgtable_ops().
> > > 
> > > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > > [rm: convert to domain attribute, tweak commit message]
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > > 
> > > v8:
> > >   - Use nested switches for attrs
> > >   - Document barrier semantics
> > > 
> > >   drivers/iommu/arm-smmu-v3.c | 79 ++++++++++++++++++++++++++-----------
> > >   1 file changed, 56 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > > index f10c852479fc..db402e8b068b 100644
> > > --- a/drivers/iommu/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm-smmu-v3.c
> > > @@ -612,6 +612,7 @@ struct arm_smmu_domain {
> > >   	struct mutex			init_mutex; /* Protects smmu pointer */
> > >   	struct io_pgtable_ops		*pgtbl_ops;
> > > +	bool				non_strict;
> > >   	enum arm_smmu_domain_stage	stage;
> > >   	union {
> > > @@ -1407,6 +1408,12 @@ static void arm_smmu_tlb_inv_context(void *cookie)
> > >   		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> > >   	}
> > > +	/*
> > > +	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
> > > +	 * PTEs previously cleared by unmaps on the current CPU not yet visible
> > > +	 * to the SMMU. We are relying on the DSB implicit in queue_inc_prod()
> > > +	 * to guarantee those are observed before the TLBI. Do be careful, 007.
> > > +	 */
> > 
> > Good, so you can ignore my comment on the previous patch :)
> 
> Well, I suppose that comment in io-pgtable *could* have explicitly noted
> that same-CPU order is dealt with elsewhere - feel free to fix it up if you
> think it would be a helpful reminder for the future.

I think I'll move it into the documentation for the new attribute, so that
any driver authors wanting to enable lazy invalidation know that they need
to provide this guarantee in their full TLB invalidation callback.

Will
