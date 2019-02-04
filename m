Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E010CC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6DF20821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="0C9KPUI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfBDWmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:42:16 -0500
Received: from vern.gendns.com ([98.142.107.122]:36226 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfBDWmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=miIqZ+lWusbBYoObf5376HkMcuNwAbK7xets7VyhXdQ=; b=0C9KPUI7ZJzMNJrgA0v11fTW6f
        W66usJxFtq8l7qVOLRFxS+yBZBxuCnInz/XufCW/RmImzYOrwCwBFpxPCzrPEAvCpmVmQbG4QnHK/
        yH+z+1K0RMX5TG1ZyoATgLeumQA+GTtmpBPeC3TJ156R6M/qJvsp3xERCc4bmgIwqHe0zaQEUbNkJ
        g+mFL0tKW4gpsMTFdlLirTG2vsMKxeFHbMCSTniYRSrXt6dB9L6bYO4/Xp1rzX29pJ7HTUCG9BY8b
        O3jf1X65Z7Xdt6vq25a8v+e1ozJ66Y3Zpv1lzQW/YgIjyKehBJIOahErPV9SGIWul+g3tPp9KC/5b
        1V2JJ5QA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:58422 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gqmsw-0004cc-Cx; Mon, 04 Feb 2019 17:38:38 -0500
Subject: Re: [PATCH 07/35] ARM: davinci: aintc: use irq domain
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-8-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <90995667-37cd-62a9-a40e-ee104016faf9@lechnology.com>
Date:   Mon, 4 Feb 2019 16:42:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-8-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/19 7:39 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We need to create an irq domain if we want to select SPARSE_IRQ. The
> cp-intc driver already supports it, but aintc doesn't. Use the helpers
> provided by the generic irq chip abstraction.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/mach-davinci/irq.c | 38 ++++++++++++++++++++++++++-----------
>   1 file changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
> index e539bc65d4ef..c874ea269411 100644
> --- a/arch/arm/mach-davinci/irq.c
> +++ b/arch/arm/mach-davinci/irq.c
> @@ -23,6 +23,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/irq.h>
>   #include <linux/io.h>
> +#include <linux/irqdomain.h>
>   
>   #include <mach/hardware.h>
>   #include <mach/cputype.h>
> @@ -43,6 +44,7 @@
>   #define IRQ_INTPRI7_REG_OFFSET	0x004C
>   
>   static void __iomem *davinci_intc_base;
> +static struct irq_domain *davinci_irq_domain;
>   
>   static inline void davinci_irq_writel(unsigned long value, int offset)
>   {
> @@ -55,17 +57,15 @@ static inline unsigned long davinci_irq_readl(int offset)
>   }
>   
>   static __init void
> -davinci_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
> +davinci_irq_setup_gc(void __iomem *base,
> +		     unsigned int irq_start, unsigned int num)
>   {
>   	struct irq_chip_generic *gc;
>   	struct irq_chip_type *ct;
>   
> -	gc = irq_alloc_generic_chip("AINTC", 1, irq_start, base, handle_edge_irq);
> -	if (!gc) {
> -		pr_err("%s: irq_alloc_generic_chip for IRQ %u failed\n",
> -		       __func__, irq_start);
> -		return;
> -	}
> +	gc = irq_get_domain_generic_chip(davinci_irq_domain, irq_start);

check for (gc == NULL) here?

