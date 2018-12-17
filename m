Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2FFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5A12086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dYJeREXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389012AbeLQScZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:32:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42476 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbeLQScZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DY1kBn9+KKWg6Q7sluxj1KjHphEN2EsxT344TutcRzk=; b=dYJeREXf+8WG97YacBqjW9Cx8
        WeHpJ2rNk4Yoyy0oknlY/xDPRQm7RuCt6Xflqg4OqI4GqSLaUuTp5OCFDzi+KlANXuaRvjdfD72gP
        heTp61W7Wd9yy6yQD+Uz/qRA8VFH53qeDZxz3ByTuI+HGSZ1llcozkmO3XsyAAUtgaSfzhEk/uSRd
        V6O4mamM1PkPyCbMwQ0GRTBhICgS/Q2Clulr0XMZo7fsjWh9t2J4gg9x22JrATE8xfNeSmHrPjy4K
        FFsHsO8WM3+lpkF/Eg8lboThfTd8TwmVi7Lf4l2FCX9roACoX1+7dcT59/haR18uqdYDzjoOzF5Zj
        9x/GRKztw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYxgj-00060O-1Z; Mon, 17 Dec 2018 18:32:21 +0000
Date:   Mon, 17 Dec 2018 10:32:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] irqchip: sifive-plic: Implement
 irq_set_affinity() for SMP host
Message-ID: <20181217183220.GE7086@infradead.org>
References: <20181130080207.20505-1-anup@brainfault.org>
 <20181130080207.20505-7-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130080207.20505-7-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 01:32:07PM +0530, Anup Patel wrote:
> This patch provides irq_set_affinity() implementation for PLIC driver.
> It also updates irq_enable() such that PLIC interrupts are only enabled
> for one of CPUs specified in IRQ affinity mask.

But normally our affinity masks are that - masks of CPUs that can take
it.  It seems a bit odd to then just pick the first one, as this means
with default all-CPU masks we'll have all interrupts handled by the
first CPU only.


> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -106,14 +106,42 @@ static void plic_irq_toggle(const struct cpumask *mask, int hwirq, int enable)
>  
>  static void plic_irq_enable(struct irq_data *d)
>  {
> -	plic_irq_toggle(irq_data_get_affinity_mask(d), d->hwirq, 1);
> +	unsigned int cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
> +					   cpu_online_mask);
> +	WARN_ON(cpu >= nr_cpu_ids);

I think this should be WARN_ON_ONCE and actually return instead of then
proceeding using the invalid cpu index. 

> +#ifdef CONFIG_SMP
static int plic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
> +			    bool force)
> +{
> +	unsigned int cpu;
> +
> +	if (!force)
> +		cpu = cpumask_any_and(mask_val, cpu_online_mask);
> +	else
> +		cpu = cpumask_first(mask_val);

maybe swap the two branches around to avoid the inversion of the force
flag?
