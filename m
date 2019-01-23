Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9E0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A9F2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfAWQ4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:56:14 -0500
Received: from foss.arm.com ([217.140.101.70]:44376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfAWQ4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:56:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB282EBD;
        Wed, 23 Jan 2019 08:56:11 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6CF03F237;
        Wed, 23 Jan 2019 08:56:09 -0800 (PST)
Date:   Wed, 23 Jan 2019 16:56:07 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pramod Kumar <pramod.kumar@broadcom.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
Message-ID: <20190123165607.GB55887@lakrids.cambridge.arm.com>
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:16:20AM +0530, Pramod Kumar wrote:
> If CPU hotplug is supported, ipi_cpu_stop should use PSCI cpudie
> call to stop the CPU. This call ensures L1/L2 cache flush,
> CPUs cache-cohenrecy setting w.r.to interconnect.
> 
> Apart from this, this gives control to f/w to reduce power consumption
> by take appropriate decesion on power rails for plugging-out core.
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  arch/arm64/kernel/smp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 1598d6f..360e52b 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -822,8 +822,13 @@ static void ipi_cpu_stop(unsigned int cpu)
>  	local_daif_mask();
>  	sdei_mask_local_cpu();
>  
> +#ifdef CONFIG_HOTPLUG_CPU
> +	if (cpu_ops[cpu]->cpu_die)
> +		cpu_ops[cpu]->cpu_die(cpu);
> +#else
>  	while (1)
>  		cpu_relax();
> +#endif

If cpu_ops[cpu]->cpu_die is NULL, this change makes ipi_cpu_stop()
return, which is not correct.

Regardless, I don't think that there is sufficient rationale for this
change, especially given that your commit message describes
platform-specific assumptions which do not hold in general.

Thanks,
Mark.
