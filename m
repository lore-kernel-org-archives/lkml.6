Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E3AC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27844213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JomXrF9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27844213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeK3NFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:05:13 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60172 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3NFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 08:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543543058; x=1575079058;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=FUgCmVQ2VKNgaCsb1HVvTlj5dWNTY50OFk8kPVfHZIc=;
  b=JomXrF9UurDFwvs12d9eH8FHKOFjJlVpTyvCVsbLPCuMweD1Z48lkFNy
   Va+0TyYNpdJhy1xUlZ8CXr+JrvD4KIFs0hYBLNaeSe/sd4XVfrUM2C2v9
   TMqANhpTogb+N7rTKoAFurtoPn8Ltuefx60HomjZNovfxw4wn3q5rQ9Tq
   Ef0a1ys5m6dzVXXMk3dCjw21PCxhgBH7B0tEwhBt/AjDjFgRhg/bElO0R
   YIZuEOhh0CskRyyzJpkcA/WnAVNxR7YlNRLIH6BNLFn9GeezIniC2aspG
   Ca7si+Zovzf652oIEvDFBgfHn8tSIhTEclmSsTfQSlbmJ4B+W8nqjm+IW
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,297,1539619200"; 
   d="scan'208";a="96654545"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2018 09:57:38 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 29 Nov 2018 17:40:33 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.72.98]) ([10.111.72.98])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Nov 2018 17:57:38 -0800
Subject: Re: [PATCH v2 3/4] irqchip: sifive-plic: Differentiate between PLIC
 handler and context
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
 <20181127100317.12809-4-anup@brainfault.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <93356e4f-ccd9-39ba-6afe-88dcdc72945d@wdc.com>
Date:   Thu, 29 Nov 2018 17:57:36 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181127100317.12809-4-anup@brainfault.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 2:04 AM, Anup Patel wrote:
> We explicitly differentiate between PLIC handler and context because
> PLIC context is for given mode of HART whereas PLIC handler is per-CPU
> software construct meant for handling interrupts from a particular
> PLIC context.
> 
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>   drivers/irqchip/irq-sifive-plic.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 95b4b92ca9b8..ffd4deaca057 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -66,8 +66,8 @@ static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
>   
>   struct plic_hw {
>   	u32			nr_irqs;
> +	u32			nr_contexts;
>   	u32			nr_handlers;
> -	u32			nr_mapped;
>   	void __iomem		*regs;
>   	struct irq_domain	*irqdomain;
>   };
> @@ -191,10 +191,10 @@ static int __init plic_init(struct device_node *node,
>   	if (WARN_ON(!plic.nr_irqs))
>   		goto out_iounmap;
>   
> -	plic.nr_handlers = of_irq_count(node);
> -	if (WARN_ON(!plic.nr_handlers))
> +	plic.nr_contexts = of_irq_count(node);
> +	if (WARN_ON(!plic.nr_contexts))
>   		goto out_iounmap;
> -	if (WARN_ON(plic.nr_handlers < num_possible_cpus()))
> +	if (WARN_ON(plic.nr_contexts < num_possible_cpus()))
>   		goto out_iounmap;
>   
>   	plic.irqdomain = irq_domain_add_linear(node, plic.nr_irqs + 1,
> @@ -202,7 +202,7 @@ static int __init plic_init(struct device_node *node,
>   	if (WARN_ON(!plic.irqdomain))
>   		goto out_iounmap;
>   
> -	for (i = 0; i < plic.nr_handlers; i++) {
> +	for (i = 0; i < plic.nr_contexts; i++) {
>   		struct of_phandle_args parent;
>   		struct plic_handler *handler;
>   		irq_hw_number_t hwirq;
> @@ -225,6 +225,11 @@ static int __init plic_init(struct device_node *node,
>   
>   		cpu = riscv_hartid_to_cpuid(hartid);
>   		handler = per_cpu_ptr(&plic_handlers, cpu);
> +		if (handler->present) {
> +			pr_warn("handler not available for context %d.\n", i);
> +			continue;
> +		}
> +

Ahh you have the handler->present check here in this patch. This should 
be in the 2nd patch. This change doesn't match the commit text anyways.

Everything else just variable renaming which can be separated.
nr_handlers->nr_contexts
nr_mapped->nr_handlers


Regards,
Atish
>   		handler->present = true;
>   		handler->hart_base =
>   			plic.regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
> @@ -237,11 +242,11 @@ static int __init plic_init(struct device_node *node,
>   		for (hwirq = 1; hwirq <= plic.nr_irqs; hwirq++)
>   			plic_toggle(handler, hwirq, 0);
>   
> -		plic.nr_mapped++;
> +		plic.nr_handlers++;
>   	}
>   
> -	pr_info("mapped %d interrupts to %d (out of %d) handlers.\n",
> -		plic.nr_irqs, plic.nr_mapped, plic.nr_handlers);
> +	pr_info("mapped %d interrupts with %d handlers for %d contexts.\n",
> +		plic.nr_irqs, plic.nr_handlers, plic.nr_contexts);
>   	set_handle_irq(plic_handle_irq);
>   	return 0;
>   
> 

