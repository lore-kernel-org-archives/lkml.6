Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61087C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3143720827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3143720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeKGSIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:08:49 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:34542 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeKGSIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:08:49 -0500
X-IronPort-AV: E=Sophos;i="5.54,475,1534834800"; 
   d="scan'208";a="23737749"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Nov 2018 01:39:28 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch07.mchp-main.com
 (10.10.76.108) with Microsoft SMTP Server id 14.3.352.0; Wed, 7 Nov 2018
 01:39:27 -0700
Date:   Wed, 7 Nov 2018 09:39:28 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Andrei Stefanescu - M50506 <Andrei.Stefanescu@microchip.com>
CC:     "wsa@the-dreams.de" <wsa@the-dreams.de>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Cristian Birsan - M91496 <Cristian.Birsan@microchip.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: at91: switched to resume/suspend callbacks.
Message-ID: <20181107083928.vqgnpw3mmczjn4el@M43218.corp.atmel.com>
Mail-Followup-To: Andrei Stefanescu - M50506 <Andrei.Stefanescu@microchip.com>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Cristian Birsan - M91496 <Cristian.Birsan@microchip.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1540203006-805-1-git-send-email-andrei.stefanescu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1540203006-805-1-git-send-email-andrei.stefanescu@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 12:17:47PM +0200, Andrei Stefanescu - M50506 wrote:
> In the previous version of the driver resume/suspend_noirq callbacks
> were used. Because of this, when resuming from suspend-to-ram,
> an I2C (belonging to a FLEXCOM) would resume before FLEXCOM.
> The first read on the I2C bus would then result in a timeout.
> 
> This patch switches to resume/suspend callbacks which are 
> called after FLEXCOM resumes. FLEXCOM, SPI and USART drivers use
> resume/suspend callbacks.
> 
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
I can't figure out why we use the _noirq variant. When patches for PM
stuff were sent, suspend/resume callbacks were used but in the latest
version it moved to the _noirq variant without explanation.

Excepting if someone has an argument to keep the _noirq variant,
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 

Thanks

Regards

Ludovic

> ---
>  drivers/i2c/busses/i2c-at91.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index bfd1fdf..81f7b94 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -1174,7 +1174,7 @@ static int at91_twi_runtime_resume(struct device *dev)
>  	return clk_prepare_enable(twi_dev->clk);
>  }
>  
> -static int at91_twi_suspend_noirq(struct device *dev)
> +static int at91_twi_suspend(struct device *dev)
>  {
>  	if (!pm_runtime_status_suspended(dev))
>  		at91_twi_runtime_suspend(dev);
> @@ -1182,7 +1182,7 @@ static int at91_twi_suspend_noirq(struct device *dev)
>  	return 0;
>  }
>  
> -static int at91_twi_resume_noirq(struct device *dev)
> +static int at91_twi_resume(struct device *dev)
>  {
>  	struct at91_twi_dev *twi_dev = dev_get_drvdata(dev);
>  	int ret;
> @@ -1202,8 +1202,8 @@ static int at91_twi_resume_noirq(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops at91_twi_pm = {
> -	.suspend_noirq	= at91_twi_suspend_noirq,
> -	.resume_noirq	= at91_twi_resume_noirq,
> +	.suspend	= at91_twi_suspend,
> +	.resume		= at91_twi_resume,
>  	.runtime_suspend	= at91_twi_runtime_suspend,
>  	.runtime_resume		= at91_twi_runtime_resume,
>  };
> -- 
> 2.7.4
> 
