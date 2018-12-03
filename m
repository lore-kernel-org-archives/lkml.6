Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6D4C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4882087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KxR7qqTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4882087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbeLCNAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:00:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37495 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeLCNAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:00:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id j10so12054470wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 04:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oznX/kWjvnBF6iJxy125LWHVTKyXkJdryOV7MUn29P8=;
        b=KxR7qqTeZb8jgfT6jR2QNWBlel4j69NR7E/WhwvcnDZNLJi5o9C3EUSgI2SVfDjcvv
         y+ulkX1Fh0NAoi/nADkn0A5pyuQ/Htezo1iuNHfPtYCrfHDXCLhEASHwBWxCGid1GoNO
         s1dPtyhLz2eNHM/SmvA+yS0akgyswe2PceLSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oznX/kWjvnBF6iJxy125LWHVTKyXkJdryOV7MUn29P8=;
        b=U6VM4Tf4TFCnYnQyGDKCtEIAZHLAIYXT/uCPw/LUCczt+IcJ7FkkzPa7ZAfGkTJz3S
         QdoZu1KBb2RrQSOC1FC5LBr3xpgwbtUebR3jY5Crs7w5xlf0STY3KIelfeBe4b/+AY1g
         lVdZn/nn4kQGSwRdk0BuB5qx1mmlVwLcVm1w689yGnpyhdvqjORvGkls7oV2iqwsBjuR
         Ju2cDbuB9wENdbUJRN8IFWOO2TZXXQhkiO74zn44Bri8Bomk79EnuOiYua5uysa37P4K
         ZmAVqRvVE58lk/UY4zqNXu1g65gv+fAJZtlLrpapQdQ8cUyk2IXExIo6UTV2dLUcTRtS
         l6ww==
X-Gm-Message-State: AA+aEWbH6W2KAtdfqa8nlwrWVrcXXBuNAfsznfPVpLP8yUk+iXJTFeA5
        lCGu2eR+MgDT31UYM1TRghVKgBtO9B8=
X-Google-Smtp-Source: AFSGD/XsE7g2YVjF/B+VbNrY6Pp7anbqj5CRbctuDT5n3Ih6RTmpiMW7rkP2BUJp8RhhzaELc7S8XQ==
X-Received: by 2002:adf:f785:: with SMTP id q5mr14892076wrp.9.1543841951065;
        Mon, 03 Dec 2018 04:59:11 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id g67sm14717299wmd.38.2018.12.03.04.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 04:59:10 -0800 (PST)
Subject: Re: [PATCH] clocksource: riscv_timer: Provide sched_clock
To:     Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181203123524.11778-1-anup@brainfault.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c970d873-9dbc-9f21-3380-89635d6f574a@linaro.org>
Date:   Mon, 3 Dec 2018 13:59:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203123524.11778-1-anup@brainfault.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 13:35, Anup Patel wrote:
> Currently, we don't have a sched_clock registered for RISC-V systems.
> This means Linux time keeping will use jiffies (running at HZ) as the
> default sched_clock.
> 
> To avoid this, we explicity provide sched_clock using RISC-V rdtime
> instruction (similar to riscv_timer clocksource).
> 
> Signed-off-by: Anup Patel <anup@brainfault.org>

Hi Anup,

the GENERIC_SCHED_CLOCK dependency in the Kconfig is missing.

Thanks

> ---
>  drivers/clocksource/riscv_timer.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
> index 084e97dc10ed..431892200a08 100644
> --- a/drivers/clocksource/riscv_timer.c
> +++ b/drivers/clocksource/riscv_timer.c
> @@ -8,6 +8,7 @@
>  #include <linux/cpu.h>
>  #include <linux/delay.h>
>  #include <linux/irq.h>
> +#include <linux/sched_clock.h>
>  #include <asm/smp.h>
>  #include <asm/sbi.h>
>  
> @@ -49,6 +50,11 @@ static unsigned long long riscv_clocksource_rdtime(struct clocksource *cs)
>  	return get_cycles64();
>  }
>  
> +static u64 riscv_sched_clock(void)
> +{
> +	return get_cycles64();
> +}
> +
>  static DEFINE_PER_CPU(struct clocksource, riscv_clocksource) = {
>  	.name		= "riscv_clocksource",
>  	.rating		= 300,
> @@ -97,6 +103,9 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>  	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
>  	clocksource_register_hz(cs, riscv_timebase);
>  
> +	sched_clock_register(riscv_sched_clock,
> +			BITS_PER_LONG, riscv_timebase);
> +
>  	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
>  			 "clockevents/riscv/timer:starting",
>  			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

