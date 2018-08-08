Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BF1C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78B0219DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78B0219DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeHHOth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:49:37 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17679 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726733AbeHHOth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:49:37 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w78COKT4027774;
        Wed, 8 Aug 2018 14:29:34 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kq7gv6xpt-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 08 Aug 2018 14:29:34 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A969931;
        Wed,  8 Aug 2018 12:29:30 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5C1812B32;
        Wed,  8 Aug 2018 12:29:30 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.44) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 8 Aug
 2018 14:29:29 +0200
Subject: Re: [PATCH] irqchip/stm32: fix init error handling
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
References: <20180808120319.akmstg3ads325xcy@kili.mountain>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <71535398-d59d-4263-e9dd-4874d56cf8fa@st.com>
Date:   Wed, 8 Aug 2018 14:29:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808120319.akmstg3ads325xcy@kili.mountain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oh yes, host_data is dereferenced (for kfree into out_free_mem) if 
stm32_exti_host_init fail

thanks Dan

BR
Ludo

On 08/08/2018 02:03 PM, Dan Carpenter wrote:
> If there are any errors in stm32_exti_host_init() then it leads to a
> NULL dereference in the callers.  The function should clean up after
> itself.
> 
> Fixes: f9fc1745501e ("irqchip/stm32: Add host and driver data structures")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Ludovic Barre <ludovic.barre@st.com>

> 
> diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
> index 3df527fcf4e1..0a2088e12d96 100644
> --- a/drivers/irqchip/irq-stm32-exti.c
> +++ b/drivers/irqchip/irq-stm32-exti.c
> @@ -603,17 +603,24 @@ stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
>   					sizeof(struct stm32_exti_chip_data),
>   					GFP_KERNEL);
>   	if (!host_data->chips_data)
> -		return NULL;
> +		goto free_host_data;
>   
>   	host_data->base = of_iomap(node, 0);
>   	if (!host_data->base) {
>   		pr_err("%pOF: Unable to map registers\n", node);
> -		return NULL;
> +		goto free_chips_data;
>   	}
>   
>   	stm32_host_data = host_data;
>   
>   	return host_data;
> +
> +free_chips_data:
> +	kfree(host_data->chips_data);
> +free_host_data:
> +	kfree(host_data);
> +
> +	return NULL;
>   }
>   
>   static struct
> @@ -665,10 +672,8 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
>   	struct irq_domain *domain;
>   
>   	host_data = stm32_exti_host_init(drv_data, node);
> -	if (!host_data) {
> -		ret = -ENOMEM;
> -		goto out_free_mem;
> -	}
> +	if (!host_data)
> +		return -ENOMEM;
>   
>   	domain = irq_domain_add_linear(node, drv_data->bank_nr * IRQS_PER_BANK,
>   				       &irq_exti_domain_ops, NULL);
> @@ -725,7 +730,6 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
>   	irq_domain_remove(domain);
>   out_unmap:
>   	iounmap(host_data->base);
> -out_free_mem:
>   	kfree(host_data->chips_data);
>   	kfree(host_data);
>   	return ret;
> @@ -752,10 +756,8 @@ __init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
>   	}
>   
>   	host_data = stm32_exti_host_init(drv_data, node);
> -	if (!host_data) {
> -		ret = -ENOMEM;
> -		goto out_free_mem;
> -	}
> +	if (!host_data)
> +		return -ENOMEM;
>   
>   	for (i = 0; i < drv_data->bank_nr; i++)
>   		stm32_exti_chip_init(host_data, i, node);
> @@ -777,7 +779,6 @@ __init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
>   
>   out_unmap:
>   	iounmap(host_data->base);
> -out_free_mem:
>   	kfree(host_data->chips_data);
>   	kfree(host_data);
>   	return ret;
> 
