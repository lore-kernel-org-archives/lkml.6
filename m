Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49AAECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 13:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809C92086B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 13:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809C92086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeGNNi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 09:38:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52831 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbeGNNi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 09:38:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0F83620765; Sat, 14 Jul 2018 15:19:20 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id D967920714;
        Sat, 14 Jul 2018 15:19:19 +0200 (CEST)
Date:   Sat, 14 Jul 2018 15:19:20 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: jz4740: Add support for the JZ4725B, JZ4760, JZ4770
Message-ID: <20180714131920.GU16084@piout.net>
References: <20180713151424.13000-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713151424.13000-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 13/07/2018 17:14:24+0200, Paul Cercueil wrote:
> The RTC in the JZ4725B works just like the one in the JZ4740.
> 
> The RTC in the JZ4760 and JZ4770 work just like the one in the JZ4780.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt |  3 +++
>  drivers/rtc/rtc-jz4740.c                                     | 11 ++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> index 41c7ae18fd7b..a9e821de84f2 100644
> --- a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> +++ b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> @@ -4,6 +4,9 @@ Required properties:
>  
>  - compatible: One of:
>    - "ingenic,jz4740-rtc" - for use with the JZ4740 SoC
> +  - "ingenic,jz4725b-rtc" - for use with the JZ4725B SoC
> +  - "ingenic,jz4760-rtc" - for use with the JZ4760 SoC
> +  - "ingenic,jz4770-rtc" - for use with the JZ4770 SoC
>    - "ingenic,jz4780-rtc" - for use with the JZ4780 SoC
>  - reg: Address range of rtc register set
>  - interrupts: IRQ number for the alarm interrupt
> diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
> index d0a891777f44..1c867e3a0ea5 100644
> --- a/drivers/rtc/rtc-jz4740.c
> +++ b/drivers/rtc/rtc-jz4740.c
> @@ -54,6 +54,9 @@
>  
>  enum jz4740_rtc_type {
>  	ID_JZ4740,
> +	ID_JZ4725B,
> +	ID_JZ4760,
> +	ID_JZ4770,

I wouldn't introduce those ids unless there are handling differences at
some point.

>  	ID_JZ4780,
>  };
>  
> @@ -114,7 +117,7 @@ static inline int jz4740_rtc_reg_write(struct jz4740_rtc *rtc, size_t reg,
>  {
>  	int ret = 0;
>  
> -	if (rtc->type >= ID_JZ4780)
> +	if (rtc->type >= ID_JZ4760)

This would avoid that change (and the test would preferably be (rtc->type == ID_JZ4780))

>  		ret = jz4780_rtc_enable_write(rtc);
>  	if (ret == 0)
>  		ret = jz4740_rtc_wait_write_ready(rtc);
> @@ -300,6 +303,9 @@ static void jz4740_rtc_power_off(void)
>  
>  static const struct of_device_id jz4740_rtc_of_match[] = {
>  	{ .compatible = "ingenic,jz4740-rtc", .data = (void *)ID_JZ4740 },
> +	{ .compatible = "ingenic,jz4725b-rtc", .data = (void *)ID_JZ4725B },
> +	{ .compatible = "ingenic,jz4760-rtc", .data = (void *)ID_JZ4760 },
> +	{ .compatible = "ingenic,jz4770-rtc", .data = (void *)ID_JZ4770 },
>  	{ .compatible = "ingenic,jz4780-rtc", .data = (void *)ID_JZ4780 },
>  	{},
>  };
> @@ -428,6 +434,9 @@ static const struct dev_pm_ops jz4740_pm_ops = {
>  
>  static const struct platform_device_id jz4740_rtc_ids[] = {
>  	{ "jz4740-rtc", ID_JZ4740 },
> +	{ "jz4725b-rtc", ID_JZ4725B },
> +	{ "jz4760-rtc", ID_JZ4760 },
> +	{ "jz4770-rtc", ID_JZ4770 },
>  	{ "jz4780-rtc", ID_JZ4780 },
>  	{}
>  };
> -- 
> 2.11.0
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
