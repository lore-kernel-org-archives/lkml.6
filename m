Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5467BC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296AC2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296AC2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbeJ3D7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:59:53 -0400
Received: from foss.arm.com ([217.140.101.70]:45106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729441AbeJ3D7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:59:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B184F341;
        Mon, 29 Oct 2018 12:09:53 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 810B23F6A8;
        Mon, 29 Oct 2018 12:09:53 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 985121AE091C; Mon, 29 Oct 2018 19:10:00 +0000 (GMT)
Date:   Mon, 29 Oct 2018 19:10:00 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: arm-smmu: Set SCTLR.HUPCF bit
Message-ID: <20181029191000.GD16739@arm.com>
References: <20180927224609.19515-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927224609.19515-1-robdclark@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 06:46:07PM -0400, Rob Clark wrote:
> We seem to need to set either this or CFCFG (stall), otherwise gpu
> faults trigger problems with other in-flight transactions from the
> GPU causing CP errors, etc.
> 
> In the ARM SMMU spec, the 'Hit under previous context fault' bit is
> described as:
> 
>  '0' - Stall or terminate subsequent transactions in the presence
>        of an outstanding context fault
>  '1' - Process all subsequent transactions independently of any
>        outstanding context fault.
> 
> Since we don't enable CFCFG (stall) the behavior of terminating
> other transactions makes sense.  And is probably not what we want
> (and definately not what we want for GPU).
> 
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---
> So I hit this issue a long time back on 820 (msm8996) and at the
> time I solved it with a patch that enabled CFCFG.  And it resurfaced
> more recently on sdm845.  But at the time CFCFG was rejected, iirc
> because of concern that it would cause problems on other non-qcom
> arm smmu implementations.  And I think I forgot to send this version
> of the solution.
> 
> If enabling HUPCF is anticipated to cause problems on other ARM
> SMMU implementations, I think I can come up with a variant of this
> patch which conditionally enables it for snapdragon.
> 
> Either way, I'd really like to get some variant of this fix merged
> (and probably it would be a good idea for stable kernel branches
> too), since current behaviour with the GPU means faults turn into
> a fantastic cascade of fail.

Can you describe how this fantastic cascade of fail improves with this
patch, please? If you're getting context faults then something has already
gone horribly wrong, so I'm trying to work out how this improves things.

> diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> index a1226e4ab5f8..2291925eb800 100644
> --- a/drivers/iommu/arm-smmu-regs.h
> +++ b/drivers/iommu/arm-smmu-regs.h
> @@ -178,6 +178,7 @@ enum arm_smmu_s2cr_privcfg {
>  #define ARM_SMMU_CB_ATSR		0x8f0
>  
>  #define SCTLR_S1_ASIDPNE		(1 << 12)
> +#define SCTLR_HUPCF			(1 << 8)
>  #define SCTLR_CFCFG			(1 << 7)
>  #define SCTLR_CFIE			(1 << 6)
>  #define SCTLR_CFRE			(1 << 5)
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index f7a96bcf94a6..47ffc9aade72 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -713,9 +713,9 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
>  	reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_AFE | SCTLR_TRE | SCTLR_M;
>  	if (stage1)
>  		reg |= SCTLR_S1_ASIDPNE;
> +	reg |= SCTLR_HUPCF;

Maybe just throw this into the assignment a couple of lines above?

>  	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>  		reg |= SCTLR_E;
> -

Random whitespace change.

Will
