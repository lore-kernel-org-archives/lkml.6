Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DE2A9C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEEA208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEEA208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935372AbeFMLO3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:14:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46026 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934677AbeFMLO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:14:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C7681529;
        Wed, 13 Jun 2018 04:14:28 -0700 (PDT)
Received: from [10.1.207.70] (e112298-lin.cambridge.arm.com [10.1.207.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1028F3F25D;
        Wed, 13 Jun 2018 04:14:25 -0700 (PDT)
Subject: Re: [PATCH v4 24/26] irqchip/gic-v3: Add base support for pseudo-NMI
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
 <1527241772-48007-25-git-send-email-julien.thierry@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <79b13ea0-a549-418c-b69f-1fad87c06357@arm.com>
Date:   Wed, 13 Jun 2018 12:14:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527241772-48007-25-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/05/18 10:49, Julien Thierry wrote:
> Provide a higher priority to be used for pseudo-NMIs. When such an
> interrupt is received, enter the NMI state and prevent other NMIs to
> be raised.
> 
> When returning from a pseudo-NMI, skip preemption and tracing if the
> interrupted context has interrupts disabled.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm/include/asm/arch_gicv3.h   |  6 ++++++
>   arch/arm64/include/asm/arch_gicv3.h |  6 ++++++
>   arch/arm64/kernel/entry.S           | 43 +++++++++++++++++++++++++++++++++++++
>   drivers/irqchip/irq-gic-v3.c        | 41 +++++++++++++++++++++++++++++++++++
>   4 files changed, 96 insertions(+)
> 

[...]

> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index b144f73..4be5996 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -371,6 +379,20 @@ static u64 gic_mpidr_to_affinity(unsigned long mpidr)
>   	return aff;
>   }
>   
> +static void do_handle_nmi(unsigned int hwirq, struct pt_regs *regs)
> +{
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +	unsigned int irq;
> +
> +	nmi_enter();

RAS/SEA also enters NMI state and things will break if asynchronous 
error occurs during a pseudo-NMI.

I'll have this fixed in the next version.

-- 
Julien Thierry
