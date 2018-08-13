Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F0DC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2420621887
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2420621887
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbeHMSEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:04:34 -0400
Received: from foss.arm.com ([217.140.101.70]:33050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbeHMSEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:04:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C85D80D;
        Mon, 13 Aug 2018 08:21:52 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20E5D3F73C;
        Mon, 13 Aug 2018 08:21:49 -0700 (PDT)
Subject: Re: [PATCH] irqchip/bcm7038-l1: hide cpu offline callback when
 building for !SMP
To:     Jonas Gorski <jonas.gorski@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <20180809085901.26568-1-jonas.gorski@gmail.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <795995ac-8cab-23df-e3f9-bf3578cd525c@arm.com>
Date:   Mon, 13 Aug 2018 16:21:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180809085901.26568-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/18 09:59, Jonas Gorski wrote:
> When compiling bmips with SMP disabled, the build fails with:
> 
> drivers/irqchip/irq-bcm7038-l1.o: In function `bcm7038_l1_cpu_offline':
> drivers/irqchip/irq-bcm7038-l1.c:242: undefined reference to `irq_set_affinity_locked'
> make[5]: *** [vmlinux] Error 1
> 
> Fix this by adding and setting bcm7038_l1_cpu_offline only when actually
> compiling for SMP. It wouldn't have been used anyway, as it requires
> CPU_HOTPLUG, which in turn requires SMP.
> 
> Fixes: 34c535793bcb ("irqchip/bcm7038-l1: Implement irq_cpu_offline() callback")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>  drivers/irqchip/irq-bcm7038-l1.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
> index faf734ff4cf3..0f6e30e9009d 100644
> --- a/drivers/irqchip/irq-bcm7038-l1.c
> +++ b/drivers/irqchip/irq-bcm7038-l1.c
> @@ -217,6 +217,7 @@ static int bcm7038_l1_set_affinity(struct irq_data *d,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_SMP
>  static void bcm7038_l1_cpu_offline(struct irq_data *d)
>  {
>  	struct cpumask *mask = irq_data_get_affinity_mask(d);
> @@ -241,6 +242,7 @@ static void bcm7038_l1_cpu_offline(struct irq_data *d)
>  	}
>  	irq_set_affinity_locked(d, &new_affinity, false);
>  }
> +#endif
>  
>  static int __init bcm7038_l1_init_one(struct device_node *dn,
>  				      unsigned int idx,
> @@ -293,7 +295,9 @@ static struct irq_chip bcm7038_l1_irq_chip = {
>  	.irq_mask		= bcm7038_l1_mask,
>  	.irq_unmask		= bcm7038_l1_unmask,
>  	.irq_set_affinity	= bcm7038_l1_set_affinity,
> +#ifdef CONFIG_SMP
>  	.irq_cpu_offline	= bcm7038_l1_cpu_offline,
> +#endif
>  };
>  
>  static int bcm7038_l1_map(struct irq_domain *d, unsigned int virq,
> 

Queued, thanks.

	M.
-- 
Jazz is not dead. It just smells funny...
