Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF7EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2660921736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfBSNXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:23:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43737 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbfBSNXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:23:07 -0500
Received: by mail-ed1-f65.google.com with SMTP id m35so12747712ede.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 05:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hfkGdySoQCzWZ8jGRYKbA1EKMfqb0tqLUT2kHc7bsCI=;
        b=Lh181nVPkRwio3J8df0whpgEe6OKr+Au3J3Sh5LJpQNO4nUuGCySXMrVnS3BSyCMsk
         1swaM56PP6TGaVHB5hEKS/IaWUVHWTJjm2feewH0w7pjHMhUybldQgXPTrt7ExYBbrvS
         cZYcCkAgw1yuYrHzRf6sdEum4W2tieSHvPil6i8sfr9EjMTqYRtz2GW3GC6rAu+2ZbNp
         GPjr/xs5fx+LRUqdjDCz6GBCbyeZuo6O1+G9a5gnJlag6MUfOOTU7MgFlzyQiMxfSGoY
         ueWMf5Bd9yn15YtLi2D98FTqWztiKKVjq/gSH3HVSmM8XLXmezBdWH0tZqWvVaNEbaRh
         g2yw==
X-Gm-Message-State: AHQUAubMEAmn24ICpDDXs2rrXm1MfQuRNh7FYyWHCo0rnHuiatBnSIH9
        UqlygzY5h0Z4iMAXiIA/dCvWDppEh5c=
X-Google-Smtp-Source: AHgI3IZyEyfBelUAWYlPZOypjkjFIUhz4svU9v8zYHp+4Ad+QxzwrhQM+cuKKoCCEVW8SgjI1hz8Qg==
X-Received: by 2002:a17:906:1602:: with SMTP id m2mr8943719ejd.228.1550582585040;
        Tue, 19 Feb 2019 05:23:05 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id cd11sm707579ejb.61.2019.02.19.05.23.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 05:23:04 -0800 (PST)
Subject: Re: [RFC] pinctrl/amd: Clear interrupt enable bits on probe
To:     Leonard Crestez <cdleonard@gmail.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc:     Daniel Drake <drake@endlessm.com>,
        Nitesh Kumar Agrawal <Nitesh-kumar.Agrawal@amd.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <2155095e66a8b6329fa6b316b0e9ecd4b6d0c9bb.1550573871.git.cdleonard@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c64f4836-fb32-ed03-e5ab-807c42aa95b7@redhat.com>
Date:   Tue, 19 Feb 2019 14:23:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <2155095e66a8b6329fa6b316b0e9ecd4b6d0c9bb.1550573871.git.cdleonard@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19-02-19 11:59, Leonard Crestez wrote:
> My Acer Nitro 5 AN515-42 laptop with a Ryzen 2700U hangs on boot because
> of spurious interrupts from pinctrl-amd.
> 
> This seems to happen because the touchpad interrupt is enabled on boot
> in "level" mode and there is no way to clear it until a touchpad driver
> probes.
> 
> Fix by disabling all gpio interrupts at probe time until they are
> explicitly requested by drivers.
> 
> Signed-off-by: Leonard Crestez <cdleonard@gmail.com>
> 
> ---
> 
> It's strange that nobody else has run into this problem, AMD hardware is
> relatively common. Maybe firmware generally disables GPIO interrupts
> itself?

Others have run into the problem, but no-one so far has had both time and
access to the hardware to actually get to the bottom of this, see:
https://bugzilla.kernel.org/show_bug.cgi?id=201817#c4

Your patch looks like it is exactly what is needed to fix this,
thank you very much for the patch!

I will attach a copy of your patch to that bug and ask people who are
having similar problems to test it.

Regards,

Hans




>
> This patch fixes boot but this same laptop has other issues:
> 
>   * Suspend is broken
>   * Ethernet is broken (only sometimes)
>   * The CPU freq gets stuck at 400 Mhz (sometimes)
> 
> Those issues happen on maybe 80% of boots without a clear pattern. It
> seems that inserting/removing the ethernet jack during boot helps
> cpufreq? It's possible that these problems are also caused by pin
> misconfiguration so this fix might be incomplete.
> 
> When the cpufreq issue happens `rdmsr 0xc0010061 -a` shows 0x22 for all
> cpus; maybe this is some broken thermal throttling?
> 
> Also, perhaps amd_gpio_irq_disable_all should enumerate in a nicer less
> verbose way?
> 
> Previously: https://lore.kernel.org/patchwork/patch/1028047/
> 
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
> index 2a7d638978d8..3cb7ea46f32c 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -592,10 +592,53 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
>   	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
>   
>   	return ret;
>   }
>   
> +static void amd_gpio_irq_disable_all(struct amd_gpio *gpio_dev)
> +{
> +	unsigned int bank, i, pin_num;
> +	u32 regval;
> +
> +	for (bank = 0; bank < gpio_dev->hwbank_num; bank++) {
> +		switch (bank) {
> +		case 0:
> +			i = 0;
> +			pin_num = AMD_GPIO_PINS_BANK0;
> +			break;
> +		case 1:
> +			i = 64;
> +			pin_num = AMD_GPIO_PINS_BANK1 + i;
> +			break;
> +		case 2:
> +			i = 128;
> +			pin_num = AMD_GPIO_PINS_BANK2 + i;
> +			break;
> +		case 3:
> +			i = 192;
> +			pin_num = AMD_GPIO_PINS_BANK3 + i;
> +			break;
> +		default:
> +			/* Illegal bank number, ignore */
> +			continue;
> +		}
> +
> +		for (; i < pin_num; i++) {
> +			unsigned long flags;
> +			raw_spin_lock_irqsave(&gpio_dev->lock, flags);
> +			regval = readl(gpio_dev->base + i * 4);
> +			if (regval & BIT(INTERRUPT_ENABLE_OFF)) {
> +				dev_info(&gpio_dev->pdev->dev,
> +						"Pin %d interrupt enabled on boot: disable\n", i);
> +				regval &= ~BIT(INTERRUPT_ENABLE_OFF);
> +				writel(regval, gpio_dev->base + i * 4);
> +			}
> +			raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
> +		}
> +	}
> +}
> +
>   static int amd_get_groups_count(struct pinctrl_dev *pctldev)
>   {
>   	struct amd_gpio *gpio_dev = pinctrl_dev_get_drvdata(pctldev);
>   
>   	return gpio_dev->ngroups;
> @@ -910,10 +953,12 @@ static int amd_gpio_probe(struct platform_device *pdev)
>   
>   	ret = gpiochip_add_data(&gpio_dev->gc, gpio_dev);
>   	if (ret)
>   		return ret;
>   
> +	amd_gpio_irq_disable_all(gpio_dev);
> +
>   	ret = gpiochip_add_pin_range(&gpio_dev->gc, dev_name(&pdev->dev),
>   				0, 0, gpio_dev->gc.ngpio);
>   	if (ret) {
>   		dev_err(&pdev->dev, "Failed to add pin range\n");
>   		goto out2;
> 
