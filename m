Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFA9ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F66A2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F66A2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbeIQTYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:24:39 -0400
Received: from shell.v3.sk ([90.176.6.54]:48089 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbeIQTYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:24:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C02BCB008C;
        Mon, 17 Sep 2018 15:57:08 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ffr7XtYo9rPZ; Mon, 17 Sep 2018 15:57:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D6DA8B9213;
        Mon, 17 Sep 2018 15:57:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rke2S47klGeU; Mon, 17 Sep 2018 15:57:05 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 2BBDCB008C;
        Mon, 17 Sep 2018 15:57:05 +0200 (CEST)
Message-ID: <5044b51a472137b534ed852aa90c5f617801dd11.camel@v3.sk>
Subject: Re: [PATCH] irqchip/mmp: use cpu_is_pj4() instead of CONFIG_CPU_MMP2
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Date:   Mon, 17 Sep 2018 15:57:05 +0200
In-Reply-To: <20180910121306.168536-1-lkundrak@v3.sk>
References: <20180910121306.168536-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-10 at 14:13 +0200, Lubomir Rintel wrote:
> CONFIG_CPU_MMP2 is not there on multiplatform kernels with
> MACH_MMP2_DT.
> The MMP2 platform uses the PJ4 CPU.

Actually, this patch breaks the DT-only build.

Please ignore it, sorry for the noise.

Lubo

> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/irqchip/irq-mmp.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
> index 25f32e1d7764..10aa2b553145 100644
> --- a/drivers/irqchip/irq-mmp.c
> +++ b/drivers/irqchip/irq-mmp.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  
> +#include <asm/cputype.h>
>  #include <asm/exception.h>
>  #include <asm/hardirq.h>
>  
> @@ -74,11 +75,11 @@ static void icu_mask_ack_irq(struct irq_data *d)
>  		r |= data->conf_disable;
>  		writel_relaxed(r, mmp_icu_base + (hwirq << 2));
>  	} else {
> -#ifdef CONFIG_CPU_MMP2
> -		if ((data->virq_base == data->clr_mfp_irq_base)
> -			&& (hwirq == data->clr_mfp_hwirq))
> -			mmp2_clear_pmic_int();
> -#endif
> +		if (cpu_is_pj4()) {
> +			if ((data->virq_base == data->clr_mfp_irq_base)
> +				&& (hwirq == data->clr_mfp_hwirq))
> +				mmp2_clear_pmic_int();
> +		}
>  		r = readl_relaxed(data->reg_mask) | (1 << hwirq);
>  		writel_relaxed(r, data->reg_mask);
>  	}

