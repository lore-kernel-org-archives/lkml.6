Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23245C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68DB21887
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68DB21887
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbeHMSFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:05:31 -0400
Received: from foss.arm.com ([217.140.101.70]:33078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbeHMSFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:05:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 800B180D;
        Mon, 13 Aug 2018 08:22:49 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 951923F73C;
        Mon, 13 Aug 2018 08:22:47 -0700 (PDT)
Subject: Re: [PATCH] irqchip/stm32: fix init error handling
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ludovic Barre <ludovic.barre@st.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
References: <20180808120319.akmstg3ads325xcy@kili.mountain>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <99d66ae8-f497-0108-8168-6e46fdf2fe1d@arm.com>
Date:   Mon, 13 Aug 2018 16:22:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808120319.akmstg3ads325xcy@kili.mountain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/18 13:03, Dan Carpenter wrote:
> If there are any errors in stm32_exti_host_init() then it leads to a
> NULL dereference in the callers.  The function should clean up after
> itself.
> 
> Fixes: f9fc1745501e ("irqchip/stm32: Add host and driver data structures")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
> index 3df527fcf4e1..0a2088e12d96 100644
> --- a/drivers/irqchip/irq-stm32-exti.c
> +++ b/drivers/irqchip/irq-stm32-exti.c
> @@ -603,17 +603,24 @@ stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
>  					sizeof(struct stm32_exti_chip_data),
>  					GFP_KERNEL);
>  	if (!host_data->chips_data)
> -		return NULL;
> +		goto free_host_data;
>  
>  	host_data->base = of_iomap(node, 0);
>  	if (!host_data->base) {
>  		pr_err("%pOF: Unable to map registers\n", node);
> -		return NULL;
> +		goto free_chips_data;
>  	}
>  
>  	stm32_host_data = host_data;
>  
>  	return host_data;
> +
> +free_chips_data:
> +	kfree(host_data->chips_data);
> +free_host_data:
> +	kfree(host_data);
> +
> +	return NULL;
>  }
>  
>  static struct
> @@ -665,10 +672,8 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
>  	struct irq_domain *domain;
>  
>  	host_data = stm32_exti_host_init(drv_data, node);
> -	if (!host_data) {
> -		ret = -ENOMEM;
> -		goto out_free_mem;
> -	}
> +	if (!host_data)
> +		return -ENOMEM;
>  
>  	domain = irq_domain_add_linear(node, drv_data->bank_nr * IRQS_PER_BANK,
>  				       &irq_exti_domain_ops, NULL);
> @@ -725,7 +730,6 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
>  	irq_domain_remove(domain);
>  out_unmap:
>  	iounmap(host_data->base);
> -out_free_mem:
>  	kfree(host_data->chips_data);
>  	kfree(host_data);
>  	return ret;
> @@ -752,10 +756,8 @@ __init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
>  	}
>  
>  	host_data = stm32_exti_host_init(drv_data, node);
> -	if (!host_data) {
> -		ret = -ENOMEM;
> -		goto out_free_mem;
> -	}
> +	if (!host_data)
> +		return -ENOMEM;
>  
>  	for (i = 0; i < drv_data->bank_nr; i++)
>  		stm32_exti_chip_init(host_data, i, node);
> @@ -777,7 +779,6 @@ __init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
>  
>  out_unmap:
>  	iounmap(host_data->base);
> -out_free_mem:
>  	kfree(host_data->chips_data);
>  	kfree(host_data);
>  	return ret;
> 

Queued, thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
