Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3237FC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CA22082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="R8Jpelen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CA22082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeLGR7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:59:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42426 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeLGR67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:58:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so2035349pga.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 09:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=A7O+8UhdX6omDOFY0XLZhv+eaCAxPxhbfqQJ8TGsiCo=;
        b=R8JpelenRlbRKmrd41K0aiUWnHuUcHcMfxFAIw8n9rtEIvl7JoANB3W0u3IXSLdq/B
         dqZU76vaG59eynuUeT6af5araUkrjRQ8uUrmIe2uTMJa7tkvSfjN33K2eayD00EERH0/
         2hjgaiyqRFAA9qkYSVj1xd9K7C3JmNPDUXOKS3ltxdt4BAMpNha95vX4TS94nIoMpqWE
         syrH8IWd//bBJ+Mclkb3aHPAHEoop8yrfebazb2uQr/PgTMsZkPROnpxWb/Ar790vaXH
         0k+u7BcNvk3lXUNAATL/Ryw6U9AMsrESpUUlMoO3NWwzIBuu0dZ1FPXcZ4Cpcm72LKqh
         T5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=A7O+8UhdX6omDOFY0XLZhv+eaCAxPxhbfqQJ8TGsiCo=;
        b=kteZTKMJivPtSkpjDLW8CtcB+URS0UxJuvCgTHdPRnQVKJ1SwgZenYPudHeZmR8Edw
         g5oah0bhT8V08dqhtbS5DRIJ+XOGF+PVG+1sleLNvOHT/8ENW0Q3KBMVA10ZcMH9JkJ3
         OIginXBR0EqNItsLLQvacy41t8vtSJUrlLEGHWe05j/Z8X2Uvx+sy0TVi0EVv2rh4b2y
         o0uE8YuBlGBH7kQQnf2Bt5TZ/LXwqxkvQ6BGeNfV8twjOUsb+YwlCeA+c79/Ooogi/kQ
         H5MO1xQzVCjovuwLyw+r68VsSH1isMrv+WTQMNSlvrP+zslM1ef1HUBOx3CyR18h4F/3
         XJeg==
X-Gm-Message-State: AA+aEWbbjVzaQO5Cf+fZdd9FePahyfhRbWJvc3ZoCC9iEkrh4/8u5J7q
        ccQnHhXmUsbJdXkhtn9wuGbcaQ==
X-Google-Smtp-Source: AFSGD/UvUr6eHOVVNoCXD5NDhhmI5/TiXeQvRUzimKhg477Ui9bk4LnzDwc0phQHaY75lnIGWdygww==
X-Received: by 2002:a63:31d0:: with SMTP id x199mr2798749pgx.10.1544205538165;
        Fri, 07 Dec 2018 09:58:58 -0800 (PST)
Received: from localhost ([216.3.10.7])
        by smtp.gmail.com with ESMTPSA id 69sm4707846pgg.86.2018.12.07.09.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 09:58:57 -0800 (PST)
Date:   Fri, 07 Dec 2018 09:58:57 -0800 (PST)
X-Google-Original-Date: Fri, 07 Dec 2018 09:58:25 PST (-0800)
Subject:     Re: [PATCH v2 2/2] clocksource: riscv_timer: Provide sched_clock
In-Reply-To: <20181204102952.21297-3-anup@brainfault.org>
CC:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        aou@eecs.berkeley.edu, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-bc852f88-ce32-4f21-a9fa-d67d50f24f2d@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2018 02:29:52 PST (-0800), anup@brainfault.org wrote:
> Currently, we don't have a sched_clock registered for RISC-V systems.
> This means Linux time keeping will use jiffies (running at HZ) as the
> default sched_clock.
>
> To avoid this, we explicity provide sched_clock using RISC-V rdtime
> instruction (similar to riscv_timer clocksource).
>
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>  drivers/clocksource/Kconfig       | 2 +-
>  drivers/clocksource/riscv_timer.c | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 55c77e44bb2d..19649abd7c75 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -611,7 +611,7 @@ config ATCPIT100_TIMER
>
>  config RISCV_TIMER
>  	bool "Timer for the RISC-V platform"
> -	depends on RISCV
> +	depends on GENERIC_SCHED_CLOCK && RISCV
>  	default y
>  	select TIMER_PROBE
>  	select TIMER_OF
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

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
