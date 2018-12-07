Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF8FC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5272081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ng+pLLfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5272081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbeLGQmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:42:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42312 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeLGQmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:42:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so2191275pfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=X5gv29cw/jua0qOKLhYdOHAw86A0bWuonl9yHT8iJZk=;
        b=Ng+pLLflO6Jka5NOPi/y3P+cHuAcXeKQatJZkCgE823OlDEUy/RQ9gawBRAPDk/ec4
         Cq+M13fOicQkNa0fljAph5T7p7Y6d2sby0rFi39MUcbusbBlv8uwF5X/Xw/+gR0rXvlz
         XuqO+38avgA6v3J52u4TX0DvixQqHY0Dlc7OEdb4uW8xB/ISU/+irO2FiK51ZPrDUAcY
         ddM/nbObTfvwxVq830pdNXZMiqqkFiB7VD6vrC4wpowoAuvFX2LsS0E+j//J87+VdW/B
         AdiZKvUU+bSKX8Dsmkaip12Evh5jziLGOUj7XOwqIYkYr4J/UrgM+Xu9CjzWAK9PFNVX
         ADfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=X5gv29cw/jua0qOKLhYdOHAw86A0bWuonl9yHT8iJZk=;
        b=hvLpJLeb5hzfYrsxJtbd900u9NB9rBj09f4aCHKXCnW1CWWKFSLfoQOTDyrKTfHw7U
         rOYIy7kd1ObhInLamk2PcF7hbZjsUNeORVIyz1j1yW6r/s7ytBEHaddZNk2F9HBR//hB
         3q9E2PKGQyu3Kb0uhPRsRS0yzN/+wS3g7Gum8+Ojn1aJsSiQ9AQGp7qMnqWOI2uYvLr9
         pYGIQaG/xzpEmPv5yxCyhL7zXS56fZZSHGyTNny9xOV9A0hU/1pBjtcUlyyKen6dxjqz
         5FfBVfjXuTdauN5Bp5dN1XNG+uFfqynmiUq6lJPEEdKnSAntV825SFHrEp6me47y4Qzh
         bASw==
X-Gm-Message-State: AA+aEWYlJp98WJ5pMXCHSy4l582HRdYgA5ObWrTTSLC8Sv3GcFdCyFYu
        VoQmb4iVyLS32Ri3K3niZogyonhv5no=
X-Google-Smtp-Source: AFSGD/W4LRXLJ1eTVRgzgmhs+O8evoxzKUGEUzmcaPnhaGqkthgmhsP1bY80x0+Kt0LR9uk3wtankg==
X-Received: by 2002:a63:f444:: with SMTP id p4mr2569422pgk.124.1544200951086;
        Fri, 07 Dec 2018 08:42:31 -0800 (PST)
Received: from localhost ([216.3.10.7])
        by smtp.gmail.com with ESMTPSA id r83sm6995312pfc.115.2018.12.07.08.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 08:42:30 -0800 (PST)
Date:   Fri, 07 Dec 2018 08:42:30 -0800 (PST)
X-Google-Original-Date: Fri, 07 Dec 2018 08:42:19 PST (-0800)
Subject:     Re: [PATCH 2/4] RISC-V: Support per-hart timebase-frequency
In-Reply-To: <1543870651-16669-3-git-send-email-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, atish.patra@wdc.com,
        aou@eecs.berkeley.edu, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, dmitriy@oss-tech.org,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org, tglx@linutronix.de, anup@brainfault.org,
        Damien.LeMoal@wdc.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     atish.patra@wdc.com
Message-ID: <mhng-531f9ae3-9ab2-48cb-9f1f-4e6814498753@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Dec 2018 12:57:29 PST (-0800), atish.patra@wdc.com wrote:
> Follow the updated DT specs and read the timebase-frequency
> from the boot cpu. Keep the old DT reading as well for backward
> compatibility. This patch is rework of old patch from Palmer.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/time.c          |  9 +--------
>  drivers/clocksource/riscv_timer.c | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 8 deletions(-)
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
> index 084e97dc..96af7058 100644
> --- a/drivers/clocksource/riscv_timer.c
> +++ b/drivers/clocksource/riscv_timer.c
> @@ -83,6 +83,26 @@ void riscv_timer_interrupt(void)
>  	evdev->event_handler(evdev);
>  }
>
> +static long __init riscv_timebase_frequency(struct device_node *node)
> +{
> +	u32 timebase;
> +
> +	if (!of_property_read_u32(node, "timebase-frequency", &timebase))
> +		return timebase;
> +
> +	/*
> +	 * As per the DT specification, timebase-frequency should be present
> +	 * under individual cpu node. Unfortunately, there are already available
> +	 * HiFive Unleashed devices where the timebase-frequency entry is under
> +	 * CPUs. check under parent "cpus" node to cover those devices.
> +	 */
> +	if (!of_property_read_u32(node->parent, "timebase-frequency",
> +				  &timebase))
> +		return timebase;
> +
> +	panic("RISC-V system with no 'timebase-frequency' in DTS\n");
> +}
> +
>  static int __init riscv_timer_init_dt(struct device_node *n)
>  {
>  	int cpuid, hartid, error;
> @@ -94,6 +114,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>  	if (cpuid != smp_processor_id())
>  		return 0;
>
> +	/* This should be called only for boot cpu */
> +	riscv_timebase = riscv_timebase_frequency(n);
>  	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
>  	clocksource_register_hz(cs, riscv_timebase);

We need to check to make sure the timebase-frequency of each hart is the same.  
This is mandated by the RISC-V ISA specification but should be checked in the 
code.
