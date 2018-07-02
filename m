Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A476C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40C12522C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40C12522C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933324AbeGBHoK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:44:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54914 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933055AbeGBHoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:44:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34E317A9;
        Mon,  2 Jul 2018 00:44:08 -0700 (PDT)
Received: from [10.1.206.75] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0F533F5AD;
        Mon,  2 Jul 2018 00:44:06 -0700 (PDT)
Subject: Re: [PATCH 4.14 088/157] irqchip/gic-v3-its: Dont bind LPI to
 unavailable NUMA node
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sumit Garg <sumit.garg@linaro.org>
References: <20180701160852.287307684@linuxfoundation.org>
 <20180701160856.970708088@linuxfoundation.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <b7959075-2874-c774-9e01-221cb5e4e18c@arm.com>
Date:   Mon, 2 Jul 2018 08:44:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180701160856.970708088@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/18 17:22, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Yang Yingliang <yangyingliang@huawei.com>
> 
> commit c1797b11a09c8323c92b074fd48b89a936c991d0 upstream.
> 
> On a NUMA system, if an ITS is local to an offline node, the ITS driver may
> pick an offline CPU to bind the LPI.  In this case, pick an online CPU (and
> the first one will do).
> 
> But on some systems, binding an LPI to non-local node CPU may cause
> deadlock (see Cavium erratum 23144).  In this case, just fail the activate
> and return an error code.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: stable@vger.kernel.org
> Link: https://lkml.kernel.org/r/20180622095254.5906-5-marc.zyngier@arm.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  drivers/irqchip/irq-gic-v3-its.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2221,7 +2221,14 @@ static void its_irq_domain_activate(stru
>  		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
>  
>  	/* Bind the LPI to the first possible CPU */
> -	cpu = cpumask_first(cpu_mask);
> +	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
> +	if (cpu >= nr_cpu_ids) {
> +		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
> +			return -EINVAL;

As reported by the kbuild robot, you need to drop the return value here
(the prototype was changed post 4.14). A WARN_ON() could be useful to
detect the case though.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
