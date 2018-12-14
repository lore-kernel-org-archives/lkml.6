Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DF3C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E14720866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+BT/Llv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E14720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeLNJY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:24:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40645 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeLNJY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:24:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so5044558wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 01:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4pz4LVo2xw/Nz9f9E3476iZ62QabH9C+7vUJFOIWiVc=;
        b=T+BT/Llvs8hT8xsjRfn/Ajwdbj4WffLH0apUiCEHJswepABq1gg2v2ayAV8B8txqba
         Yic9qRWyfQ053qfyqB8ibecFCt+QlvDm+1U+owkRP8SpBhh//IBWf/mq1QZQQ+ouaZiH
         XXtyU7pVBJhRxDvEFlcLbJnfD+t7IuiRHkn+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4pz4LVo2xw/Nz9f9E3476iZ62QabH9C+7vUJFOIWiVc=;
        b=oompooJi/VI97Uf4GivcqsHPzkPSLy1rxkIfqCgYb7FEeHpZ/+ka6pCKUuFp2wka6G
         Y81Rvi61HkN7FEIylXIaubnG87YxWRudy+cbmLk06eNMYCkoG1v8QIc58HN3JPPFL4MQ
         9udHQBgmm72cMNTDt4el50LZFSbFffMErGxRZOkE3t4eRufF7U5CRC441r5ObJXufu1p
         b2bZTsSYc2/7+wyH1lK3Sh0M5r03NJe0AO9SY9rqrEDdGOxLoBBPIH/sQQ7dvvQU7mAp
         vOxzvv/Q93H0AK1dwm6JGl8KQBnufmMh+UojaxF5az5wPACYqpTyU9NEdonbH8n0u5S+
         6ZgA==
X-Gm-Message-State: AA+aEWbRA6R8QVOlTQFA4DmnuIb2EW89N45VKwqP2HM9BzEav2tXiQ5h
        6vHlizSjRPVRjSiTcpWwv22fAA==
X-Google-Smtp-Source: AFSGD/W1Q4k4ws46VynhAEscyRb7pEJtMCAvfDpTL46MiCOt2WnxmyF887PX2DkUJqD0UI57AUMwlw==
X-Received: by 2002:a1c:68d7:: with SMTP id d206mr2421272wmc.43.1544779463856;
        Fri, 14 Dec 2018 01:24:23 -0800 (PST)
Received: from [192.168.0.40] (77.37.95.92.rev.sfr.net. [92.95.37.77])
        by smtp.googlemail.com with ESMTPSA id v133sm3390933wmf.19.2018.12.14.01.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 01:24:23 -0800 (PST)
Subject: Re: [PATCH v2 2/4] RISC-V: Support per-hart timebase-frequency
To:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1544742869-19980-1-git-send-email-atish.patra@wdc.com>
 <1544742869-19980-3-git-send-email-atish.patra@wdc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b11115c8-b194-0f73-b4ab-5d1d643790ad@linaro.org>
Date:   Fri, 14 Dec 2018 10:24:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544742869-19980-3-git-send-email-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2018 00:14, Atish Patra wrote:
> Follow the updated DT specs and read the timebase-frequency
> from the boot cpu. Keep the old DT reading as well for backward
> compatibility. This patch is rework of old patch from Palmer.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/time.c          |  9 +--------
>  drivers/clocksource/riscv_timer.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
> index 1911c8f6..225fe743 100644
> --- a/arch/riscv/kernel/time.c
> +++ b/arch/riscv/kernel/time.c
> @@ -20,14 +20,7 @@ unsigned long riscv_timebase;
>  
>  void __init time_init(void)
>  {
> -	struct device_node *cpu;
> -	u32 prop;
> -
> -	cpu = of_find_node_by_path("/cpus");
> -	if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
> -		panic(KERN_WARNING "RISC-V system with no 'timebase-frequency' in DTS\n");
> -	riscv_timebase = prop;
> +	timer_probe();
>  
>  	lpj_fine = riscv_timebase / HZ;
> -	timer_probe();
>  }
> diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
> index 084e97dc..75262409 100644
> --- a/drivers/clocksource/riscv_timer.c
> +++ b/drivers/clocksource/riscv_timer.c
> @@ -83,6 +83,35 @@ void riscv_timer_interrupt(void)
>  	evdev->event_handler(evdev);
>  }
>  
> +static void __init riscv_timebase_frequency(struct device_node *node,
> +					    int hartid)
> +{
> +	u32 timebase;
> +
> +	if (!of_property_read_u32(node, "timebase-frequency", &timebase))
> +		goto check;
> +
> +	/*
> +	 * As per the DT specification, timebase-frequency should be present
> +	 * under individual cpu node. Unfortunately, there are already available
> +	 * HiFive Unleashed devices where the timebase-frequency entry is under
> +	 * CPUs. check under parent "cpus" node to cover those devices.
> +	 */
> +	if (!of_property_read_u32(node->parent, "timebase-frequency",
> +				  &timebase))
> +		goto check;
> +
> +	panic("RISC-V system with no timebase-frequency in DTS for hart [%d]\n",
> +	      hartid);

no panic in the driver code please. Alternatively use pr_err and let the
timer-probe function spit the critical error on the console.

It would be nicer to add a fixed-clock and get the rate from it.

> +check:
> +	/* RISC-V ISA specification mandates that every cpu has a timer */
> +	if (!riscv_timebase)
> +		riscv_timebase = timebase;
> +	else if (riscv_timebase && riscv_timebase != timebase)
> +		pr_warn("RISC-V system with different timebase-frequency\n");
> +}
> +
>  static int __init riscv_timer_init_dt(struct device_node *n)
>  {
>  	int cpuid, hartid, error;
> @@ -90,10 +119,12 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>  
>  	hartid = riscv_of_processor_hartid(n);
>  	cpuid = riscv_hartid_to_cpuid(hartid);
> +	riscv_timebase_frequency(n, hartid);
>  
>  	if (cpuid != smp_processor_id())
>  		return 0;

Somehow related to this change. Are you sure the test above makes sense?

> +	/* This should be called only for boot cpu */
>  	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
>  	clocksource_register_hz(cs, riscv_timebase);
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

