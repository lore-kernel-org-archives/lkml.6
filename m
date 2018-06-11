Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rjgrLXp3HlsjKQAAmS7hNA
	; Mon, 11 Jun 2018 13:22:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A711E607A4; Mon, 11 Jun 2018 13:22:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1ED8960541;
	Mon, 11 Jun 2018 13:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1ED8960541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933291AbeFKNWA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 09:22:00 -0400
Received: from foss.arm.com ([217.140.101.70]:51464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932668AbeFKNV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:21:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C28981529;
        Mon, 11 Jun 2018 06:21:58 -0700 (PDT)
Received: from [10.1.206.75] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 075EE3F53D;
        Mon, 11 Jun 2018 06:21:57 -0700 (PDT)
Subject: Re: [PATCH v3] irqchip/gic-v3-its: fix ITS queue timeout
To: Yang Yingliang <yangyingliang@huawei.com>, julien.thierry@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1528719909-16572-1-git-send-email-yangyingliang@huawei.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <ee543de9-8a9c-877f-2070-8009da35b3a8@arm.com>
Date: Mon, 11 Jun 2018 14:21:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528719909-16572-1-git-send-email-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/18 13:25, Yang Yingliang wrote:
> On a NUMA system, if an ITS is local to an offline
> node, the ITS driver may pick an offline CPU to bind
> the LPI. In this case, we need to pick an online CPU.
> But on some systems, binding LPI to non-local node
> CPU will cause deadlock. In this case, we don't
> bind the LPI to any online CPU and return an error code.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 5416f2b..137c433 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2309,7 +2309,13 @@ static int its_irq_domain_activate(struct irq_domain *domain,
>  		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
>  
>  	/* Bind the LPI to the first possible CPU */
> -	cpu = cpumask_first(cpu_mask);
> +	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
> +	if (cpu >= nr_cpu_ids) {
> +		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
> +			return -EINVAL;
> +
> +		cpu = cpumask_first(cpu_online_mask);
> +	}
>  	its_dev->event_map.col_map[event] = cpu;
>  	irq_data_update_effective_affinity(d, cpumask_of(cpu));
>  
> 

Queued as a fix for 4.18 with a slightly updated change-log and a cc to
stable.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
