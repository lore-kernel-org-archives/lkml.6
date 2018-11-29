Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC21C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996292081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996292081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeK2XTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:19:49 -0500
Received: from foss.arm.com ([217.140.101.70]:33356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbeK2XTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:19:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C832A78;
        Thu, 29 Nov 2018 04:14:39 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4ED653F5AF;
        Thu, 29 Nov 2018 04:14:38 -0800 (PST)
Date:   Thu, 29 Nov 2018 12:14:32 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_spe: handle devm_kasprintf() failure
Message-ID: <20181129121432.2ntsfhp2s43gyvfx@lakrids.cambridge.arm.com>
References: <1543404287-3946-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543404287-3946-1-git-send-email-hofrat@osadl.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 12:24:47PM +0100, Nicholas Mc Guire wrote:
> devm_kasprintf() may return NULL on failure of internal allocation
> thus the assignment to  name  is not safe if unchecked. if NULL
> is passed in for name then perf_pmu_register() would not fail
> but rather silently jump to skip_type which is not the intent
> here. As perf_pmu_register() may also return -ENOMEM returning 
> -ENOMEM in the (unlikely) failure case of devm_kasprintf() should 
> be fine here as well.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
> ---
> 
> Problem located with an experimental coccinelle script
> 
> The dev_err() might seem a bit much for this unlikely error but as 
> perf_pmu_register() may also return -ENOMEM it would be hard to figure
> out what went wrong without this message.
> 
> Patch was compile tested with: defconfig (ARCH=arm64) +
> ARM_SPE_PMU=y
> 
> Patch is against 4.20-rc3 (localversion-next is next-20181128)
> 
>  drivers/perf/arm_spe_pmu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 54ec278..f1ea00c 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -927,6 +927,11 @@ static int arm_spe_pmu_perf_init(struct arm_spe_pmu *spe_pmu)
>  
>  	idx = atomic_inc_return(&pmu_idx);
>  	name = devm_kasprintf(dev, GFP_KERNEL, "%s_%d", PMUNAME, idx);
> +	if (!name) {
> +		dev_err(dev, "Allocation of name failed\n");
> +		return -ENOMEM;
> +	}

In the other dev_err() messages, we use the form "failed to ...", e.g.

	"failed to get IRQ (%d)\n"
	"failed to get PPI partition (%d)\n
	"failed to allocate spe_pmu\n"

... so for consistency could you please change the string to:

	"failed to allocate spe_pmu name\n"

With that, feel free to add:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
