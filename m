Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20888ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9892086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9892086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeJTBv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:51:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56420 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbeJTBv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:51:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BC2BA78;
        Fri, 19 Oct 2018 10:44:54 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33F863F71D;
        Fri, 19 Oct 2018 10:44:52 -0700 (PDT)
Date:   Fri, 19 Oct 2018 18:44:48 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu: arm-smmu: handle client iommu translation fault
 handlers
Message-ID: <20181019174447.GB4429@brain-police>
References: <20181010144407.23336-1-stanimir.varbanov@linaro.org>
 <20181010170837.GC16512@arm.com>
 <6edd8f71-4363-01b6-6b45-aebc92604559@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6edd8f71-4363-01b6-6b45-aebc92604559@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 03:26:57PM +0300, Stanimir Varbanov wrote:
> On 10/10/2018 08:08 PM, Will Deacon wrote:
> > On Wed, Oct 10, 2018 at 05:44:07PM +0300, Stanimir Varbanov wrote:
> >> Call iommu client translation fault handler(s).
> >>
> >> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> >> ---
> >>  drivers/iommu/arm-smmu.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> >> index 066f4c8daf4e..02a8aab0cc59 100644
> >> --- a/drivers/iommu/arm-smmu.c
> >> +++ b/drivers/iommu/arm-smmu.c
> >> @@ -568,6 +568,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >>  			    fsr, iova, fsynr, cfg->cbndx);
> >>  
> >>  	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
> >> +
> >> +	report_iommu_fault(domain, smmu->dev, iova, 0);
> > 
> > Who's using this? Generally, the callback here isn't so useful because it's
> 
> The idea was to use it from video driver to dump few multimedia
> interconnect registers which will give us some more info about the fault.
> 
> > called in irq context. We also don't enable stalling since 3714ce1d6655.
> > 
> > We previously had fairly detailed discussions on the list with Rob Clark
> > about alternative ways to design this, but I don't remember where it ended
> > up.
> 
> It will be useful if you point me to the discussion. Thanks!

There's more, but some stuff I managed to dig up is here:

https://lists.linuxfoundation.org/pipermail/iommu/2017-January/019931.html
https://lists.linuxfoundation.org/pipermail/iommu/2017-September/024143.html

Will
