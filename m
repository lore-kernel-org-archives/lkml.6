Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E702EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF14213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF14213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbeK3DGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:06:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37986 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbeK3DGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:06:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF086A78;
        Thu, 29 Nov 2018 08:00:47 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 928C83F59C;
        Thu, 29 Nov 2018 08:00:47 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 161241AE0FA2; Thu, 29 Nov 2018 16:01:06 +0000 (GMT)
Date:   Thu, 29 Nov 2018 16:01:06 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_spe: handle devm_kasprintf() failure
Message-ID: <20181129160105.GA4546@arm.com>
References: <1543404287-3946-1-git-send-email-hofrat@osadl.org>
 <20181129121432.2ntsfhp2s43gyvfx@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129121432.2ntsfhp2s43gyvfx@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 12:14:32PM +0000, Mark Rutland wrote:
> On Wed, Nov 28, 2018 at 12:24:47PM +0100, Nicholas Mc Guire wrote:
> > diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> > index 54ec278..f1ea00c 100644
> > --- a/drivers/perf/arm_spe_pmu.c
> > +++ b/drivers/perf/arm_spe_pmu.c
> > @@ -927,6 +927,11 @@ static int arm_spe_pmu_perf_init(struct arm_spe_pmu *spe_pmu)
> >  
> >  	idx = atomic_inc_return(&pmu_idx);
> >  	name = devm_kasprintf(dev, GFP_KERNEL, "%s_%d", PMUNAME, idx);
> > +	if (!name) {
> > +		dev_err(dev, "Allocation of name failed\n");
> > +		return -ENOMEM;
> > +	}
> 
> In the other dev_err() messages, we use the form "failed to ...", e.g.
> 
> 	"failed to get IRQ (%d)\n"
> 	"failed to get PPI partition (%d)\n
> 	"failed to allocate spe_pmu\n"
> 
> ... so for consistency could you please change the string to:
> 
> 	"failed to allocate spe_pmu name\n"
> 
> With that, feel free to add:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks, I've queued this for 4.21 with a tweaked error message.

Will
