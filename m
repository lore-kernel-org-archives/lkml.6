Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1764C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 01:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674A720684
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 01:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nx0pfWuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674A720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbeKRL6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 06:58:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54510 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbeKRL6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 06:58:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so2023884wma.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 17:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vI52ho93BaiPE3L/jNpnme5yyJsC48fUm+EVPIHK0Ro=;
        b=Nx0pfWucMMU9pi45rz4IttZ/dm9RBdhvcThTdAPdqNuMdUkJ3dsVEAzBVBqcndACzy
         e4j4erjHuB/L2Hgqsz5Wfl4AXzy/4ra3VGV2L87eb2Q2xKiZ43qeAwbJXkL1K0NITzDC
         eBaLtgci18ZJLzqn4+TabBU+n6BmOgOKZVDP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vI52ho93BaiPE3L/jNpnme5yyJsC48fUm+EVPIHK0Ro=;
        b=FWk8B4oLZoBh+UblVboBIuShwG91F6p+IetOVeRDvzEMnF4L3Po7z3acn8+4WdG0Uo
         NJ7g2d8mhPSyha3D4evoEh0Y5rc/Y/U6bZoQuGdWzWQr++9sEwvoCVRTHPlVTyqsoZ6w
         Wh4A24M3sqeOdl5SFoG9VQkyyPLd4Pqt7k9uklRwxAYhLsqyJXuaRU73rJDVJyDdJsmB
         aGliW18ZxA0qxfPFDmPgG/f6/9D5uSmvw+Ql/lXcTgWeBl0JmK2li5zKNO1T0KbH12W+
         6YnB+rH0SCb4m8UeDe8IiLDvh+RnxWslQDnUa3hrKUj+Uvs3Lahb1NUkIw/RW3aC5W78
         kICA==
X-Gm-Message-State: AGRZ1gLX/iEqM25w8Rla2asPlaHrRemeypHfXBbr+GqrswzZR0V5OZYW
        S2VMxoqiwEnS8iyEioHurthv0fTT/ew=
X-Google-Smtp-Source: AFSGD/VYiCg8YZzREyj/XCxLhCD5MMsYL/+5joIhVVaQlO1jQBwf3vgFXPgwCdRlcodDL5adV+Zojw==
X-Received: by 2002:a1c:8d86:: with SMTP id p128-v6mr3101886wmd.48.1542505173803;
        Sat, 17 Nov 2018 17:39:33 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 64-v6sm30918216wml.22.2018.11.17.17.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 17:39:33 -0800 (PST)
Subject: Re: [RFC v2 5/7] clocksource/drivers/rtl8186: Add RTL8186 timer
 driver
To:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20181001102952.7913-1-yasha.che3@gmail.com>
 <20181001102952.7913-6-yasha.che3@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dd8dbad0-efc3-fab1-e1d8-75819af66879@linaro.org>
Date:   Sun, 18 Nov 2018 02:39:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181001102952.7913-6-yasha.che3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Yasha,

except the few details below, the driver looks good to me.

On 01/10/2018 12:29, Yasha Cherikovsky wrote:
> The Realtek RTL8186 SoC is a MIPS based SoC
> used in some home routers [1][2].
> 
> This adds a driver to handle the built-in timers
> on this SoC.
> 
> Timers 0 and 1 are 24bit timers.
> Timers 2 and 3 are 32bit timers.
> 
> Use Timer2 as clocksource and Timer3 for clockevents.
> Timer2 is also used for sched_clock.
> 
> [1] https://www.linux-mips.org/wiki/Realtek_SOC#Realtek_RTL8186
> [2] https://wikidevi.com/wiki/Realtek_RTL8186
> 
> Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/clocksource/Kconfig         |   9 ++
>  drivers/clocksource/Makefile        |   1 +
>  drivers/clocksource/timer-rtl8186.c | 220 ++++++++++++++++++++++++++++
>  3 files changed, 230 insertions(+)
>  create mode 100644 drivers/clocksource/timer-rtl8186.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index dec0dd88ec15..da87f73d0631 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -609,4 +609,13 @@ config ATCPIT100_TIMER
>  	help
>  	  This option enables support for the Andestech ATCPIT100 timers.
>  
> +config RTL8186_TIMER
> +	bool "RTL8186 timer driver"
> +	depends on MACH_RTL8186
> +	depends on COMMON_CLK
> +	select TIMER_OF
> +	select CLKSRC_MMIO
> +	help
> +	  Enables support for the RTL8186 timer driver.
> +

Please, convert this entry like the MTK_TIMER or the SPRD_TIMER.

>  endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 00caf37e52f9..734e8566e1b6 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -78,3 +78,4 @@ obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
>  obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
>  obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
>  obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
> +obj-$(CONFIG_RTL8186_TIMER)		+= timer-rtl8186.o
> diff --git a/drivers/clocksource/timer-rtl8186.c b/drivers/clocksource/timer-rtl8186.c
> new file mode 100644
> index 000000000000..47ef4b09ad27
> --- /dev/null
> +++ b/drivers/clocksource/timer-rtl8186.c
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Realtek RTL8186 SoC timer driver.
> + *
> + * Timer0 (24bit): Unused
> + * Timer1 (24bit): Unused
> + * Timer2 (32bit): Used as clocksource
> + * Timer3 (32bit): Used as clock event device
> + *
> + * Copyright (C) 2018 Yasha Cherikovsky
> + */
> +
> +#include <linux/init.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
> +#include <linux/sched_clock.h>
> +#include <linux/of_clk.h>
> +#include <linux/io.h>
> +
> +#include <asm/time.h>
> +#include <asm/idle.h>

Why do you need those 2 includes above ?

> +#include "timer-of.h"
> +
> +/* Timer registers */
> +#define TCCNR			0x0
> +#define TCIR			0x4
> +#define TC_DATA(t)		(0x10 + 4 * (t))
> +#define TC_CNT(t)		(0x20 + 4 * (t))
> +
> +/* TCCNR register bits */
> +#define TCCNR_TC_EN_BIT(t)		BIT((t) * 2)
> +#define TCCNR_TC_MODE_BIT(t)		BIT((t) * 2 + 1)
> +#define TCCNR_TC_SRC_BIT(t)		BIT((t) + 8)
> +
> +/* TCIR register bits */
> +#define TCIR_TC_IE_BIT(t)		BIT(t)
> +#define TCIR_TC_IP_BIT(t)		BIT((t) + 4)
> +
> +
> +/* Forward declaration */
> +static struct timer_of to;
> +
> +static void __iomem *base;
> +
> +

nit: extra line

> +#define RTL8186_TIMER_MODE_COUNTER	0
> +#define RTL8186_TIMER_MODE_TIMER	1
> +

[ ... ]

Thanks

  -- Daniel



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

