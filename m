Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DB3ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193E42084E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193E42084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeGQJyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:54:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54363 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeGQJyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:54:07 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ffMBd-0003f3-Gw; Tue, 17 Jul 2018 11:22:25 +0200
Date:   Tue, 17 Jul 2018 11:22:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Julien Thierry <julien.thierry@arm.com>
cc:     linux-kernel@vger.kernel.org,
        ricardo.neri-calderon@linux.intel.com, marc.zyngier@arm.com,
        peterz@infradead.org, mingo@kernel.org
Subject: Re: [RFC PATCH 1/4] genirq: Provide basic NMI management for interrupt
 lines
In-Reply-To: <1531152846-19374-2-git-send-email-julien.thierry@arm.com>
Message-ID: <alpine.DEB.2.21.1807171114280.3238@nanos.tec.linutronix.de>
References: <1531152846-19374-1-git-send-email-julien.thierry@arm.com> <1531152846-19374-2-git-send-email-julien.thierry@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018, Julien Thierry wrote:
> +/**
> + *	disable_nmi_nosync - disable an nmi without waiting
> + *	@irq: Interrupt to disable
> + *
> + *	Disable the selected interrupt line. Disables and enables are
> + *	nested.
> + *	The interrupt to disable must have been requested through request_nmi.
> + *	Unlike disable_nmi(), this function does not ensure existing
> + *	instances of the IRQ handler have completed before returning.
> + */
> +void disable_nmi_nosync(unsigned int irq)
> +{
> +	disable_irq_nosync(irq);
> +}
> +
> +/**
> + *	disable_nmi - disable an nmi and wait for completion
> + *	@irq: Interrupt to disable
> + *
> + *	Disable the selected interrupt line. Enables and disables are
> + *	nested.
> + *	The interrupt to disable must have been requested through request_nmi.
> + *	This function waits for any pending IRQ handlers for this interrupt
> + *	to complete before returning. If you use this function while
> + *	holding a resource the IRQ handler may need you will deadlock.

I don't see how that wait would work with NMIs.

> +/* This function must be called with desc->lock held */
> +static const void *__cleanup_nmi(unsigned int irq, struct irq_desc *desc)
> +{
> +	const char *devname = NULL;
> +
> +	desc->istate &= ~IRQS_NMI;
> +
> +#ifdef CONFIG_SMP
> +	if (WARN_ON(desc->affinity_notify))
> +		desc->affinity_notify = NULL;
> +#endif

We should not support that affinity notify horror for NMIs at all.

> +	if (!WARN_ON(desc->action == NULL)) {
> +		irq_pm_remove_action(desc, desc->action);
> +		devname = desc->action->name;
> +		unregister_handler_proc(irq, desc->action);
> +
> +		kfree(desc->action);
> +		desc->action = NULL;
> +	}
> +
> +	irq_settings_clr_disable_unlazy(desc);
> +	irq_shutdown(desc);
> +
> +#ifdef CONFIG_SMP
> +	/* make sure affinity_hint is cleaned up */
> +	if (WARN_ON_ONCE(desc->affinity_hint))
> +		desc->affinity_hint = NULL;
> +#endif

Especially not twice :)

Thanks,

	tglx
