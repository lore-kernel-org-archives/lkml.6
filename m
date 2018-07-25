Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877D4C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4486320844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4486320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbeGYM35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:29:57 -0400
Received: from foss.arm.com ([217.140.101.70]:36870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728680AbeGYM35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:29:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7845115A2;
        Wed, 25 Jul 2018 04:18:44 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E26E3F575;
        Wed, 25 Jul 2018 04:18:42 -0700 (PDT)
Subject: Re: [PATCH 3/6] irqchip: RISC-V Local Interrupt Controller Driver
To:     Christoph Hellwig <hch@lst.de>, tglx@linutronix.de,
        palmer@sifive.com, jason@lakedaemon.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20180725093649.32332-1-hch@lst.de>
 <20180725093649.32332-4-hch@lst.de>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <c3ccb953-cd75-4a37-636a-ca643602053a@arm.com>
Date:   Wed, 25 Jul 2018 12:18:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725093649.32332-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/18 10:36, Christoph Hellwig wrote:
> From: Palmer Dabbelt <palmer@dabbelt.com>
> 
> This patch adds a driver that manages the local interrupts on each
> RISC-V hart, as specifiec by the RISC-V supervisor level ISA manual.
> The local interrupt controller manages software interrupts, timer
> interrupts, and hardware interrupts (which are routed via the
> platform level interrupt controller).  Per-hart local interrupt
> controllers are found on all RISC-V systems.
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> [hch: Kconfig simplifications, various cleanups]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/irqchip/Kconfig          |   4 +
>  drivers/irqchip/Makefile         |   1 +
>  drivers/irqchip/irq-riscv-intc.c | 197 +++++++++++++++++++++++++++++++
>  3 files changed, 202 insertions(+)
>  create mode 100644 drivers/irqchip/irq-riscv-intc.c
> 

[...]

> +/*
> + * On RISC-V systems local interrupts are masked or unmasked by writing the SIE
> + * (Supervisor Interrupt Enable) CSR.  As CSRs can only be written on the local
> + * hart, these functions can only be called on the hart that corresponds to the
> + * IRQ chip.  They are only called internally to this module, so they BUG_ON if
> + * this condition is violated rather than attempting to handle the error by
> + * forwarding to the target hart, as that's already expected to have been done.
> + */
> +static void riscv_irq_mask(struct irq_data *d)
> +{
> +	struct riscv_irq_data *data = irq_data_get_irq_chip_data(d);
> +
> +	BUG_ON(smp_processor_id() != data->hart);
> +	csr_clear(sie, 1 << d->hwirq);
> +}
> +
> +static void riscv_irq_unmask(struct irq_data *d)
> +{
> +	struct riscv_irq_data *data = irq_data_get_irq_chip_data(d);
> +
> +	BUG_ON(smp_processor_id() != data->hart);
> +	csr_set(sie, 1 << d->hwirq);
> +}
> +
> +/* Callbacks for twiddling SIE on another hart. */
> +static void riscv_irq_enable_helper(void *d)
> +{
> +	riscv_irq_unmask(d);
> +}
> +
> +static void riscv_irq_disable_helper(void *d)
> +{
> +	riscv_irq_mask(d);
> +}
> +
> +static void riscv_remote_ctrl(unsigned int cpu, void (*fn)(void *d),
> +			      struct irq_data *data)
> +{
> +	smp_call_function_single(cpu, fn, data, true);
> +}
> +
> +static void riscv_irq_enable(struct irq_data *d)
> +{
> +	struct riscv_irq_data *data = irq_data_get_irq_chip_data(d);
> +
> +	/*
> +	 * It's only possible to write SIE on the current hart.  This jumps
> +	 * over to the target hart if it's not the current one.  It's invalid
> +	 * to write SIE on a hart that's not currently running.
> +	 */
> +	if (data->hart == smp_processor_id())
> +		riscv_irq_unmask(d);
> +	else if (cpu_online(data->hart))
> +		riscv_remote_ctrl(data->hart, riscv_irq_enable_helper, d);

This feels odd. It means that you cannot have the following sequence:

	local_irq_disable();
	enable_irq(x); // where x is owned by a remote hart

as smp_call_function_single() requires interrupts to be enabled.

More fundamentally, why are you trying to make these interrupts look
global while they aren't? arm/arm64 have similar restrictions with GICv2
and earlier, and treats these interrupts as per-cpu.

Given that the drivers that deal with drivers connected to the per-hart
irqchip are themselves likely to be aware of the per-cpu aspect, it
would make sense to align things (we've been through that same
discussion about the clocksource driver a few weeks back).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
