Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeEPUZz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 16:25:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58669 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbeEPUZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 16:25:54 -0400
Date: Wed, 16 May 2018 22:25:52 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rtc: stm32: rework register management to prepare
 other version of RTC
Message-ID: <20180516202552.GA24496@piout.net>
References: <1525880770-22263-1-git-send-email-amelie.delaunay@st.com>
 <1525880770-22263-2-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525880770-22263-2-git-send-email-amelie.delaunay@st.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/05/2018 17:46:08+0200, Amelie Delaunay wrote:
>  static void stm32_rtc_wpr_unlock(struct stm32_rtc *rtc)
>  {
> -	writel_relaxed(RTC_WPR_1ST_KEY, rtc->base + STM32_RTC_WPR);
> -	writel_relaxed(RTC_WPR_2ND_KEY, rtc->base + STM32_RTC_WPR);
> +	struct stm32_rtc_registers regs = rtc->data->regs;

regs should probably be a pointer to ensure that no copy is made. I've
actually checked and it doesn't make a difference because gcc is smart
enough to not make the copy.

> +
> +	writel_relaxed(RTC_WPR_1ST_KEY, rtc->base + regs.wpr);
> +	writel_relaxed(RTC_WPR_2ND_KEY, rtc->base + regs.wpr);
>  }
>  

...

>  static irqreturn_t stm32_rtc_alarm_irq(int irq, void *dev_id)
>  {
>  	struct stm32_rtc *rtc = (struct stm32_rtc *)dev_id;
> -	unsigned int isr, cr;
> +	struct stm32_rtc_registers regs = rtc->data->regs;
> +	struct stm32_rtc_events evts = rtc->data->events;

Ditto for evts.

> +	unsigned int status, cr;
>  
>  	mutex_lock(&rtc->rtc_dev->ops_lock);
>  
> -	isr = readl_relaxed(rtc->base + STM32_RTC_ISR);
> -	cr = readl_relaxed(rtc->base + STM32_RTC_CR);
> +	status = readl_relaxed(rtc->base + regs.isr);
> +	cr = readl_relaxed(rtc->base + regs.cr);
>  
> -	if ((isr & STM32_RTC_ISR_ALRAF) &&
> +	if ((status & evts.alra) &&
>  	    (cr & STM32_RTC_CR_ALRAIE)) {
>  		/* Alarm A flag - Alarm interrupt */
>  		dev_dbg(&rtc->rtc_dev->dev, "Alarm occurred\n");

...

> @@ -641,7 +710,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
>  
>  	/*
>  	 * After a system reset, RTC_ISR.INITS flag can be read to check if
> -	 * the calendar has been initalized or not. INITS flag is reset by a
> +	 * the calendar has been initialized or not. INITS flag is reset by a
>  	 * power-on reset (no vbat, no power-supply). It is not reset if
>  	 * rtc_ck parent clock has changed (so RTC prescalers need to be
>  	 * changed). That's why we cannot rely on this flag to know if RTC
> @@ -666,7 +735,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
>  			 "alarm won't be able to wake up the system");
>  
>  	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
> -			&stm32_rtc_ops, THIS_MODULE);
> +						&stm32_rtc_ops, THIS_MODULE);
>  	if (IS_ERR(rtc->rtc_dev)) {
>  		ret = PTR_ERR(rtc->rtc_dev);
>  		dev_err(&pdev->dev, "rtc device registration failed, err=%d\n",

Those two changes should go into a separate cleanup patch.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
