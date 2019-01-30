Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF453C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C23520989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QIgehZKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfA3N1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:27:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40252 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfA3N1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:27:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so26060660wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Cqm8f720jgcK1cibwpzSH5gyQWQEtlUryUeecvq+zJs=;
        b=QIgehZKKNMSfwOPOt/LHGh+Kl5jhAl7ll0UeidZMMDu4qLxZlUa+p3Rzw8V72Br2EE
         sMXxk8mNqjQESqevYWOsPU3fepeCJOYU+TcCNmmZ9edBKSFgK5LFhJzd7pICd/AYpQ1v
         RRXO2QvaDcmTfwku3kc9wz+er/2Afi2nfsw+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Cqm8f720jgcK1cibwpzSH5gyQWQEtlUryUeecvq+zJs=;
        b=rYzuUmWmmUMn5CrObvv/dFg5VH8r1DCYbsj+yt1czCJjUIIqugXztEhaLMotoXou27
         PGRqD81ddFFhjDlwk1ZL617KrHN6u/sQynmMzrYTXi2lOBhccQFkjO7P2fA11DzCgTsS
         6jpTvHk5pt2jR3XI5GaGBtZ3HlzvpWOwio81ouhVA7Yi0NlWqsTIySzANuZtAiaIN6rm
         WkvYTkxJLe8/O29Q7r+IbnWr9Ra81djVbpBIDSMhUIjKD1N7kIAZyAbFPrRqza4rgZLY
         nf/TO2zcQbfoU/PoaXw1DiBAxLQ/wmFAEevcUo3bXcnQy1b92+He5yyr4RpnGoGcj8BJ
         1N8w==
X-Gm-Message-State: AJcUukc7ftJE2cSI5QowQICh1QSDgM6SrNskb2bHAblUuHv4TvWY7dqt
        c1tGZQujCUq4jnjReuoocqsjKQ==
X-Google-Smtp-Source: ALg8bN6587rmhe6LubN7U6oOQtuzZ5REVxxJnKeiDPvHiyYukKZ/6GTD05e0KlHko4SAsMRTcsXMkQ==
X-Received: by 2002:a5d:5649:: with SMTP id j9mr29903101wrw.256.1548854862284;
        Wed, 30 Jan 2019 05:27:42 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id g129sm2201530wmf.39.2019.01.30.05.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 05:27:41 -0800 (PST)
Date:   Wed, 30 Jan 2019 13:27:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, tglx@linutronix.de, shawnguo@kernel.org,
        dianders@chromium.org, linux-gpio@vger.kernel.org,
        nicolas.dechesne@linaro.org, niklas.cassel@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/9] mfd: pm8xxx: convert to v2 irq interfaces to support
 hierarchical IRQ chips
Message-ID: <20190130132739.GE4701@dell>
References: <20190125162302.14036-1-masneyb@onstation.org>
 <20190125162302.14036-4-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190125162302.14036-4-masneyb@onstation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019, Brian Masney wrote:

> Convert the PM8XXX IRQ code to use the version 2 IRQ interface in order
> to support hierarchical IRQ chips. This is necessary so that ssbi-gpio
> can be setup as a hierarchical IRQ chip with PM8xxx as the parent. IRQ
> chips in device tree should be usable from the start without the
> having to make an additional call to gpio[d]_to_irq() to get the proper
> IRQ on the parent.
> 
> The IRQ handler was hardcoded as handle_level_irq and this patch
> properly sets the handler to either handle_edge_irq or handle_level_irq
> depending on the IRQ type.
> 
> pm8821_irq_domain_ops and pm8821_irq_domain_map are removed by this
> patch since the irq_chip is now contained in the pm_irq_data struct, and
> that allows us to use a common IRQ mapping function.
> 
> This change was not tested on any actual hardware, however the same
> change was made to spmi-gpio and tested on a LG Nexus 5 (hammerhead)
> phone.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/mfd/qcom-pm8xxx.c | 86 +++++++++++++++++++++++----------------
>  1 file changed, 50 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
> index e6e8d81c15fd..a976890c4019 100644
> --- a/drivers/mfd/qcom-pm8xxx.c
> +++ b/drivers/mfd/qcom-pm8xxx.c
> @@ -70,20 +70,20 @@
>  #define PM8XXX_NR_IRQS		256
>  #define PM8821_NR_IRQS		112
>  
> +struct pm_irq_data {
> +	int num_irqs;
> +	struct irq_chip *irq_chip;
> +	void (*irq_handler)(struct irq_desc *desc);
> +};
> +
>  struct pm_irq_chip {
>  	struct regmap		*regmap;
>  	spinlock_t		pm_irq_lock;
>  	struct irq_domain	*irqdomain;
> -	unsigned int		num_irqs;
>  	unsigned int		num_blocks;
>  	unsigned int		num_masters;
>  	u8			config[0];
> -};
> -
> -struct pm_irq_data {
> -	int num_irqs;
> -	const struct irq_domain_ops  *irq_domain_ops;
> -	void (*irq_handler)(struct irq_desc *desc);
> +	const struct pm_irq_data *pm_irq_data;
>  };
>  
>  static int pm8xxx_read_block_irq(struct pm_irq_chip *chip, unsigned int bp,
> @@ -303,6 +303,7 @@ static int pm8xxx_irq_set_type(struct irq_data *d, unsigned int flow_type)
>  {
>  	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
>  	unsigned int pmirq = irqd_to_hwirq(d);
> +	irq_flow_handler_t flow_handler;
>  	int irq_bit;
>  	u8 block, config;
>  
> @@ -316,6 +317,8 @@ static int pm8xxx_irq_set_type(struct irq_data *d, unsigned int flow_type)
>  			chip->config[pmirq] &= ~PM_IRQF_MASK_RE;
>  		if (flow_type & IRQF_TRIGGER_FALLING)
>  			chip->config[pmirq] &= ~PM_IRQF_MASK_FE;
> +
> +		flow_handler = handle_edge_irq;
>  	} else {
>  		chip->config[pmirq] |= PM_IRQF_LVL_SEL;
>  
> @@ -323,8 +326,12 @@ static int pm8xxx_irq_set_type(struct irq_data *d, unsigned int flow_type)
>  			chip->config[pmirq] &= ~PM_IRQF_MASK_RE;
>  		else
>  			chip->config[pmirq] &= ~PM_IRQF_MASK_FE;
> +
> +		flow_handler = handle_level_irq;
>  	}
>  
> +	irq_set_handler_locked(d, flow_handler);
> +

Why don't you save yourself 3 lines of code and a variable and just
call irq_set_handler_locked() where you set flow_handler?

Apart from that nit, the code looks good to me.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
