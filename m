Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1653FC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DB92087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bagB2Xim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DB92087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeKTVBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:01:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34825 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbeKTVBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:01:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so1390026wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 02:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x3AWmt8F1MWYOzHe4bq8ZRg+v3imYsqPx+POcXBK8Fw=;
        b=bagB2XimQ5W0mOtcgtoQECc8+ktvZ8V5/74Sr3WrYC72ZwnY/w96UIkw7No6gCApyQ
         u8+ZOZmzeio5w9WK7P+RV0m1uLaalfgCiYvJ2aN7NSdv8b36IJ4fEP2fvG6Jtwq3Uqt1
         Zq6GU8YtNK24Us9Rpy39lzcKLumkmraoX1C+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x3AWmt8F1MWYOzHe4bq8ZRg+v3imYsqPx+POcXBK8Fw=;
        b=PjQwo5ksrosLnKVrQFDpQ6vQWzekVA9UH2w/DyIlsaLOxyQDGgkq7nb0ryIGnjXkO4
         y6gB/vYi12DWKBcJFwN5rW43kZCbaRsR7vysQseBHLAmgXiB3z6VfH6gpOa3Fs6EMbIG
         WORI+2FjRSkvoYdYuoxLMGMV2u18kSsezIOraTlxwbrL9xnWQuBCHFWDu4wcw6w9bJqF
         lRMZSgBIs+NeSuCCG/OYZXuUihS0HYbsS54Z1t9/dE8w0WyJbWJKZD1apJLLqKopx2rj
         9paUvXdgWl37ORUb4mT5Veh3WVZxFOEzFNbCJTdh35RFH6rFA5IHyLahd7+kJj4XmCo6
         qhiw==
X-Gm-Message-State: AA+aEWal8H6vwgOjfR1QespL1YVHaD84dBut1YyRvnqxdBm3bxNdggtp
        Rr1I70yh4oIQZsKg7XS3DUQAkQ==
X-Google-Smtp-Source: AFSGD/Vv5b8DNPt3TuymtgnEWXR/j/MsTkuH/YPznKh8G1dLuxM0jWnxk02nOnTM/27o/VaXkW325g==
X-Received: by 2002:a5d:5745:: with SMTP id q5-v6mr1379999wrw.161.1542709975226;
        Tue, 20 Nov 2018 02:32:55 -0800 (PST)
Received: from [192.168.0.40] (98.242.136.77.rev.sfr.net. [77.136.242.98])
        by smtp.googlemail.com with ESMTPSA id g8-v6sm49016596wri.58.2018.11.20.02.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 02:32:54 -0800 (PST)
Subject: Re: [PATCH 12/16] clocksource: Add clock driver for RDA8810PL SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        service@rdamicro.com,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-13-manivannan.sadhasivam@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0df98ec5-1189-7297-b58d-8c0f5cbfa2ac@linaro.org>
Date:   Tue, 20 Nov 2018 11:32:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119170939.19153-13-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Manivannan,


On 19/11/2018 18:09, Manivannan Sadhasivam wrote:
> Add clock driver for RDA Micro RDA8810PL SoC supporting OSTIMER
> and HWTIMER.

As it is a new driver, can you elaborate the log and describe the timer.

> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

[ ... ]

> +static int __init rda_timer_init(struct device_node *node)
> +{
> +	unsigned long rate = 2000000;
> +	int ostimer_irq, ret;
> +
> +	rda_timer_base = of_io_request_and_map(node, 0, "rda-timer");
> +	if (IS_ERR(rda_timer_base)) {
> +		pr_err("Can't map timer registers");
> +		return PTR_ERR(rda_timer_base);
> +	}
> +
> +	ostimer_irq = of_irq_get_byname(node, "ostimer");
> +	if (ostimer_irq <= 0) {
> +		pr_err("Can't parse ostimer IRQ");
> +		return -EINVAL;
> +	}
> +
> +	clocksource_register_hz(&rda_clocksource, rate);
> +
> +	ret = request_irq(ostimer_irq, rda_ostimer_interrupt, IRQF_TIMER,
> +			  "rda-ostimer", &rda_clockevent);
> +	if (ret) {
> +		pr_err("failed to request irq %d\n", ostimer_irq);
> +		return ret;
> +	}
> +

Use the timer-of API.

> +
> +TIMER_OF_DECLARE(rda8810pl, "rda,8810pl-timer", rda_timer_init);


Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

