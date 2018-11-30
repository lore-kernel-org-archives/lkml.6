Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8AFC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC5B20989
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j8HSCdb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC5B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeK3Lmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:42:46 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29341 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeK3Lmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543538122; x=1575074122;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dFl/zZLgSDqemqPv+7eT/OSLd89e2+sy3YtrTSVl/Ck=;
  b=j8HSCdb/3EJX/S4Eu+xDM/F0Rtuc/cSHAubMnIUCg+a28Ujx2+oXLrMu
   BcmtVQWKtLunIGUdPXPx3FkLfejCQ0mlAmGkYZh8mydY9OTWxln/yFRV0
   NBcb7wuLQ4dFt4gB/jCi9SvEBrHvttwyuLMHi95rCQVJQgJcNuS7dNP1x
   IGWlinR4mwjPdz4qOUpgS/dx82OL3CKz4wqpo7H4o4z6790UnUk82PhQU
   85V/MEiyi3sFnUe+YxG65KVoV+bbOJeFkXVq+19jvYSC+pr1M+dcYzGqK
   y46h56m2LSr3lexiPXC83jg/ikkDejqe2sVii7I8Rcq6O12kI5BbgxwHy
   g==;
X-IronPort-AV: E=Sophos;i="5.56,296,1539619200"; 
   d="scan'208";a="200043557"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2018 08:35:22 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 29 Nov 2018 16:17:47 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.72.98]) ([10.111.72.98])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Nov 2018 16:35:22 -0800
Subject: Re: [PATCH v2 1/4] irqchip: sifive-plic: Pre-compute context hart
 base and enable base
To:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181127100317.12809-1-anup@brainfault.org>
 <20181127100317.12809-2-anup@brainfault.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <b6ff2593-9113-9b95-ade5-09e7e9fa1be5@wdc.com>
Date:   Thu, 29 Nov 2018 16:35:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181127100317.12809-2-anup@brainfault.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 2:03 AM, Anup Patel wrote:
> This patch does following optimizations:
> 1. Pre-compute hart base for each context handler
> 2. Pre-compute enable base for each context handler
> 3. Have enable lock for each context handler instead
> of global plic_toggle_lock
> 
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>   drivers/irqchip/irq-sifive-plic.c | 41 +++++++++++++------------------
>   1 file changed, 17 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 357e9daf94ae..56fce648a901 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -60,36 +60,24 @@ static void __iomem *plic_regs;
>   struct plic_handler {
>   	bool			present;
>   	int			ctxid;
> +	void __iomem		*hart_base;
> +	raw_spinlock_t		enable_lock;
> +	void __iomem		*enable_base;

It should be u32. Otherwise, plic_toggle calculates incorrect address 
and it does not boot on Unlheased.

>   };
>   static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
>   
> -static inline void __iomem *plic_hart_offset(int ctxid)
> +static inline void plic_toggle(struct plic_handler *handler,
> +				int hwirq, int enable)
>   {
> -	return plic_regs + CONTEXT_BASE + ctxid * CONTEXT_PER_HART;
> -}
> -
> -static inline u32 __iomem *plic_enable_base(int ctxid)
> -{
> -	return plic_regs + ENABLE_BASE + ctxid * ENABLE_PER_HART;
> -}
> -
> -/*
> - * Protect mask operations on the registers given that we can't assume that
> - * atomic memory operations work on them.
> - */

Should we keep the comment for enable_lock ?

> -static DEFINE_RAW_SPINLOCK(plic_toggle_lock);
> -
> -static inline void plic_toggle(int ctxid, int hwirq, int enable)
> -{
> -	u32 __iomem *reg = plic_enable_base(ctxid) + (hwirq / 32);
> +	u32 __iomem *reg = handler->enable_base + (hwirq / 32);
>   	u32 hwirq_mask = 1 << (hwirq % 32);
>   
> -	raw_spin_lock(&plic_toggle_lock);
> +	raw_spin_lock(&handler->enable_lock);
>   	if (enable)
>   		writel(readl(reg) | hwirq_mask, reg);
>   	else
>   		writel(readl(reg) & ~hwirq_mask, reg);
> -	raw_spin_unlock(&plic_toggle_lock);
> +	raw_spin_unlock(&handler->enable_lock);
>   }
>   
>   static inline void plic_irq_toggle(struct irq_data *d, int enable)
> @@ -101,7 +89,7 @@ static inline void plic_irq_toggle(struct irq_data *d, int enable)
>   		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
>   
>   		if (handler->present)
> -			plic_toggle(handler->ctxid, d->hwirq, enable);
> +			plic_toggle(handler, d->hwirq, enable);
>   	}
>   }
>   
> @@ -150,7 +138,7 @@ static struct irq_domain *plic_irqdomain;
>   static void plic_handle_irq(struct pt_regs *regs)
>   {
>   	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> -	void __iomem *claim = plic_hart_offset(handler->ctxid) + CONTEXT_CLAIM;
> +	void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
>   	irq_hw_number_t hwirq;
>   
>   	WARN_ON_ONCE(!handler->present);
> @@ -240,11 +228,16 @@ static int __init plic_init(struct device_node *node,
>   		handler = per_cpu_ptr(&plic_handlers, cpu);
>   		handler->present = true;
>   		handler->ctxid = i;
> +		handler->hart_base =
> +			plic_regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
> +		raw_spin_lock_init(&handler->enable_lock);
> +		handler->enable_base =
> +			plic_regs + ENABLE_BASE + i * ENABLE_PER_HART;
>   
>   		/* priority must be > threshold to trigger an interrupt */
> -		writel(0, plic_hart_offset(i) + CONTEXT_THRESHOLD);
> +		writel(0, handler->hart_base + CONTEXT_THRESHOLD);
>   		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
> -			plic_toggle(i, hwirq, 0);
> +			plic_toggle(handler, hwirq, 0);
>   		nr_mapped++;
>   	}
>   
> 

