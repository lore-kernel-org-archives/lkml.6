Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6018CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B9B2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NgrC7BWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B9B2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbeHWSim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:38:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732739AbeHWSim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hn1sh7ZZMJifaHa5laEuwKkR4kuFkwNedzbcEwfl6nA=; b=NgrC7BWJ9fVZdIevhBpd/FpC4
        0zqPzG11Bbc6h8f+c0LHPMvWe7DgS1C2qpzgQ5tbNRX3RvDIbc62ntxuWrKSMmyPIezvrhH0srQaM
        wSlA8o6RU/SnaT5A36WToDJDwlcg/0sWNl0Acc1EnqBJgD5CUD/P8aDb7tUwTauuobRntlIpre8zS
        KwdV1fm2jTWpP8pXoIriLcg384foUbGgytaZRygHUDV0f6KNYEIQQCzVcDmmVNaw8ib2/i2GzOYYh
        o5IxF9zmqhikL4FeKu0mLRgRxvzvZ23dVfRvZJvCJsKfqzKrfvHjmmEQptSgJfGh+zNDnXiK4ZipH
        23IGnvMjQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsrDw-0004wT-HB; Thu, 23 Aug 2018 15:08:36 +0000
Subject: Re: [PATCH 1/2] GPIO: add single-register gpio via creg driver
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-snps-arc@lists.infradead.org, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
References: <20180823150013.21837-1-Eugeniy.Paltsev@synopsys.com>
 <20180823150013.21837-2-Eugeniy.Paltsev@synopsys.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c5f75b43-6ef3-31e2-0366-b6c8623d3f5d@infradead.org>
Date:   Thu, 23 Aug 2018 08:08:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180823150013.21837-2-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23/2018 08:00 AM, Eugeniy Paltsev wrote:
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 71c0ab46f216..0f9cc1582cab 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -430,6 +430,15 @@ config GPIO_REG
>  	  A 32-bit single register GPIO fixed in/out implementation.  This
>  	  can be used to represent any register as a set of GPIO signals.
>  
> +config GPIO_SNPS_CREG
> +	bool "GPIO via CREG (Control REGisers) driver"

	                             REGisters)

> +	select OF_GPIO
> +	help
> +	  This driver supports GPIOs via CREG on various Synopsys SoCs.
> +	  This is is single-register MMIO gpio driver for complex cases

	  This is a                  MMIO GPIO

> +	  where only several fields in register belong to GPIO and

	                            in a register

> +	  each GPIO owns field with different length and on/off values.

maybe:
	                 fields with different lengths

> +
>  config GPIO_SPEAR_SPICS
>  	bool "ST SPEAr13xx SPI Chip Select as GPIO support"
>  	depends on PLAT_SPEAR


-- 
~Randy
