Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBD4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DD720892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="g20DTmjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DD720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbeLFUc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:32:26 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40879 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeLFUcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:32:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so1693514oth.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 12:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Xp7Sg5IArtbrr2C++6GeTh72xBYnG/glIJgBLPLQB2U=;
        b=g20DTmjxKvwQa0klW5nooKf/iDQoykr8UT7FPPlWSkZZ7PIEKkMmf35RdZ9Ofrv2YN
         YaA1D7FJMobk+DJH5A0q+zRqKCqvRAqWXk53P34/y8J9Ij3RgYxSrAPvo+4obtbhjT48
         ZgCoS505lAIMcgc9VOyH22FdKGR3SLAuoPeefi57iJtj/fKtdqLpU+ocWUlYqUyQymcy
         iWtUQaRE6vbvM7kMKbE3elwuPUpMEqiii0o2QD/KeLvh9PRcuCjhKi0Tkk3jimmluZsG
         oQ4IAvr+nccl895691Y/Et5V2T2/wKipnNNLgaxA37rDFmZEWnlW0ywODLXnXPshVeMz
         d5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Xp7Sg5IArtbrr2C++6GeTh72xBYnG/glIJgBLPLQB2U=;
        b=ujjs7JLAxMSM1Vui+ujRyO1d7qm+NutXjWstReQx2kqtOhLkWahHpvAoGwq9fEmCUm
         j6hNI47wE20Nl3UdPnVk1+YMiB+4S49Q3sln/4L3AtxXqWjFuiZa3XqYBhwM86nychh7
         C587LV/p5FHFjgDhNKxcofBcYN2RlhRVFm01r4Dm/cp8sHM9PMAPN51IGuQf7SUPS/QK
         hdcLHj7oWwrxm2Ct7Yz0bO3k9FZBBeMdEUnGsXKSv9V+7RFKtcmUbzlvqsCT/u9XO8Vc
         0B67+oGCchXlgcypTJXTMLuxNNVQHxyCLg+WCcYlacz96P3YqFM/5oUru7zdbtAp4mWS
         sTtw==
X-Gm-Message-State: AA+aEWYqrZRUxUK1Zduujmd0LFUwg9xCiIfLgoJNJn72H1pxZSq8zbKr
        x7bqyW5zXq3iC4cgcQ8/V4ChBw==
X-Google-Smtp-Source: AFSGD/VbDnvLGJRUNVQDKNqTV3X/I6vwtYMPkdBvQPRdxgWaIN3cfl5pmdVg/aAZx0mmUp8K1WmXfQ==
X-Received: by 2002:a9d:6a1a:: with SMTP id g26mr8753185otn.172.1544128344761;
        Thu, 06 Dec 2018 12:32:24 -0800 (PST)
Received: from localhost ([208.115.86.72])
        by smtp.gmail.com with ESMTPSA id f127sm671577oia.19.2018.12.06.12.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 12:32:23 -0800 (PST)
Date:   Thu, 06 Dec 2018 12:32:23 -0800 (PST)
X-Google-Original-Date: Thu, 06 Dec 2018 12:27:17 PST (-0800)
Subject:     Re: [PATCH] clocksource: riscv_timer: Provide sched_clock
In-Reply-To: <20181203123524.11778-1-anup@brainfault.org>
CC:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        aou@eecs.berkeley.edu, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-41a72f59-6506-420f-a01e-b01c81ab6e33@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Dec 2018 04:35:24 PST (-0800), anup@brainfault.org wrote:
> Currently, we don't have a sched_clock registered for RISC-V systems.
> This means Linux time keeping will use jiffies (running at HZ) as the
> default sched_clock.
>
> To avoid this, we explicity provide sched_clock using RISC-V rdtime
> instruction (similar to riscv_timer clocksource).
>
> Signed-off-by: Anup Patel <anup@brainfault.org>
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

Shouldn't this just be 64, not BITS_PER_LONG?  We have 64-bit counters on 
RV32I.

> +
>  	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
>  			 "clockevents/riscv/timer:starting",
>  			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
