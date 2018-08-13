Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B567FC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C4A2177A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C4A2177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbeHMSDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:03:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33024 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbeHMSDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:03:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B034780D;
        Mon, 13 Aug 2018 08:21:13 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2802B3F73C;
        Mon, 13 Aug 2018 08:21:12 -0700 (PDT)
Subject: Re: [PATCH] irqchip/s3c24xx: Remove unneeded comparison of unsigned
 long to 0
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180813151144.12407-1-krzk@kernel.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <35e59c4f-0f36-6a39-d075-dac32f75bce8@arm.com>
Date:   Mon, 13 Aug 2018 16:21:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180813151144.12407-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/18 16:11, Krzysztof Kozlowski wrote:
> irq_data->hwirq is unsigned long.  This fixes GCC warning:
> 
>     drivers/irqchip/irq-s3c24xx.c: In function 's3c_irqext0_type':
>     drivers/irqchip/irq-s3c24xx.c:253:19: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
>       if ((data->hwirq >= 0) && (data->hwirq <= 3)) {
>                        ^~
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/irqchip/irq-s3c24xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
> index f6fd57ebe6e6..c19766fe8a1a 100644
> --- a/drivers/irqchip/irq-s3c24xx.c
> +++ b/drivers/irqchip/irq-s3c24xx.c
> @@ -250,7 +250,7 @@ static int s3c_irqext0_type(struct irq_data *data, unsigned int type)
>  	void __iomem *gpcon_reg;
>  	unsigned long gpcon_offset, extint_offset;
>  
> -	if ((data->hwirq >= 0) && (data->hwirq <= 3)) {
> +	if (data->hwirq <= 3) {
>  		gpcon_reg = S3C2410_GPFCON;
>  		extint_reg = S3C24XX_EXTINT0;
>  		gpcon_offset = (data->hwirq) * 2;
> 

Queued, thanks.

	M.
-- 
Jazz is not dead. It just smells funny...
