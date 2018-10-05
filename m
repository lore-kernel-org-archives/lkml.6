Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9F2C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006752084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNyww/+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006752084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbeJEUrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:47:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45319 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbeJEUrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:47:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id q5-v6so13617214wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 06:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pFowR5rZv27Byo7MG/rb8vt4PHkizLtRCIAEAUNAVvc=;
        b=SNyww/+v2rOWzp3wWlNE2GMDOY2kfILfEMUec9joURmjgU94IBUPrWzgwPtwwe+NxP
         ZUlvOALV23Dpx1eKrKl+Upbx/yNKJs6wQQq9ruuWqUeDx/57QYjI9QJ31EWg8X+sb4+7
         8BSbCxcO9EKGpY2fBN8ATf0fh2w4niAF5XPDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pFowR5rZv27Byo7MG/rb8vt4PHkizLtRCIAEAUNAVvc=;
        b=OBvw/gdxJNyTFQqMOHuvLiVvZHQlPRUp7fp++rlPCYDjnbo5WjSaR354iYkKVxmdsA
         bLrcVPrPPNl1Tf1/PSzXNxw8TTrRIs715Tcv7NvF0RW7sLm8By6A+95csfiMd4PqnTkw
         y2nMAizK0YfAsEMwGfCT3FpvjKKb65FMC5T4pqjgx1M1X72Qe84to2Xkg8uJhE6+ZDog
         jdWj4KHGUG8WABikaKlBuhH2rBk+rPruwaPwK+qX2eSFT2Pxnfq3WtZD019vIXAI58kU
         RQSiMER/+V2bFwLCIcAHBrh4gu3YQU8Xj1298NKCxkoc7o0/e8B2EghNTMhWW1lZO/rZ
         sdAw==
X-Gm-Message-State: ABuFfoi4zYiRMYVQAyjWQz0fH0H2wt/8rkL8KMPRqyPR6q5OxdW7Q24A
        8vOIN/56clFVSsdWw5nMbW1w0A==
X-Google-Smtp-Source: ACcGV60eT7U7YchbZbAhGxRyh0wz86d0uWROmjD29HU1S/kidLt61PBbV1NY0KCsLeH7XM23NJNlzA==
X-Received: by 2002:a5d:4a12:: with SMTP id m18-v6mr8458434wrq.278.1538747340967;
        Fri, 05 Oct 2018 06:49:00 -0700 (PDT)
Received: from [192.168.0.40] (151.240.136.77.rev.sfr.net. [77.136.240.151])
        by smtp.googlemail.com with ESMTPSA id 20-v6sm2453909wml.10.2018.10.05.06.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 06:49:00 -0700 (PDT)
Subject: Re: [PATCH V10 5/8] clocksource: add C-SKY SMP timer
To:     Guo Ren <ren_guo@c-sky.com>, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, anurup.m@huawei.com,
        Jonathan.Cameron@huawei.com, will.deacon@arm.com,
        zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1538672812.git.ren_guo@c-sky.com>
 <76f127a22faf8f110f102ee3534792b2b84a7d78.1538672812.git.ren_guo@c-sky.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4ec284a4-0cff-91b8-bd0a-6eb578b28432@linaro.org>
Date:   Fri, 5 Oct 2018 15:48:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <76f127a22faf8f110f102ee3534792b2b84a7d78.1538672812.git.ren_guo@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 19:22, Guo Ren wrote:
> This timer is used by SMP system and use mfcr/mtcr instruction
> to access the regs.
> 
> Changelog:
>  - Add rollback for timer_of_cleanup.
>  - Use request_percpu_irq separate from time_of.
>  - Remove #define CPUHP_AP_CSKY_TIMER_STARTING.
>  - Add CPUHP_AP_CSKY_TIMER_STARTING in cpuhotplug.h.
>  - Support csky mp timer alpha version.
>  - Just use low-counter with 32bit width as clocksource.
>  - Coding convention with upstream feed-back.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  drivers/clocksource/Kconfig         |  10 +++
>  drivers/clocksource/Makefile        |   1 +
>  drivers/clocksource/timer-mp-csky.c | 173 ++++++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h          |   1 +
>  4 files changed, 185 insertions(+)
>  create mode 100644 drivers/clocksource/timer-mp-csky.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index a11f4ba..826a2e8 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -620,4 +620,14 @@ config RISCV_TIMER
>  	  is accessed via both the SBI and the rdcycle instruction.  This is
>  	  required for all RISC-V systems.
>  
> +config CSKY_MP_TIMER
> +	bool "SMP Timer for the C-SKY platform"
> +	depends on CSKY
> +	select TIMER_OF
> +	help
> +	  Say yes here to enable C-SKY SMP timer driver used for C-SKY SMP
> +	  system.
> +	  csky,mptimer is not only used in SMP system, it also could be used
> +	  single core system. It's not a mmio reg and it use mtcr/mfcr instruction.


... COMPILE_TEST :)





-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

