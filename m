Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932190AbeCSHEK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 03:04:10 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:47436 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755187AbeCSHEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 03:04:07 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.03240488|-1;CH=blue;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03296;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.BMaJJNV_1521443032;
Date: Mon, 19 Mar 2018 15:03:52 +0800
From: Guo Ren <ren_guo@c-sky.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net,
        arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
Subject: Re: [PATCH 18/19] clocksource: add timer-nationalchip.c
Message-ID: <20180319070351.GB21923@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <04f5a0702fc14e934e6f5a456cad8682d0b15aa2.1521399976.git.ren_guo@c-sky.com>
 <20180319041522.zyjdjrxtd2va3m2a@salmiak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319041522.zyjdjrxtd2va3m2a@salmiak>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Mar 19, 2018 at 04:15:35AM +0000, Mark Rutland wrote:
> > +#define NC_VA_COUNTER_3_CONTROL		(void *)(timer_reg + 0x90)
> > +#define NC_VA_COUNTER_3_CONFIG		(void *)(timer_reg + 0xa0)
> > +#define NC_VA_COUNTER_3_PRE		(void *)(timer_reg + 0xa4)
> > +#define NC_VA_COUNTER_3_INI		(void *)(timer_reg + 0xa8)
> 
> Please define the offsets alone, e.g.
> 
> #define NC_VA_COUNTER_1_STATUS	0x00
> #define NC_VA_COUNTER_1_VALUE	0x04
> 
> ... the base address should be added when calling the io accessor. Please see
> below.
> 
> > +static unsigned int timer_reg;
> 
> This should be a void __iomem *, e.g.
> 
> static void __iomem *timer_base;
> 
> ... though it would be better for this to be associated with the instance of
> the clock_event_device, so that there can be multiple instances in a system.
>
OK

> > +
> > +static inline void timer_reset(void)
> > +{
> > +	__raw_writel(0x1,	NC_VA_COUNTER_1_CONTROL);
> > +	__raw_writel(0x0,	NC_VA_COUNTER_1_CONTROL);
> > +	__raw_writel(0x3,	NC_VA_COUNTER_1_CONFIG);
> > +	__raw_writel(26,	NC_VA_COUNTER_1_PRE);
> 
> Should this be 26 or 0x26?
No

> 
> It would be nice to have mnemonics for these magic numbers.
>
Yes, you are right.

> Please use writel_relaxed() rather than __raw_writel(). e.g.
> 
> 	writel_relaxed(0x1, timer_base + NC_VA_COUNTER_1_CONTROL);
> 	writel_relaxed(0x0, timer_base + NC_VA_COUNTER_1_CONTROL);
> 	writel_relaxed(0x3, timer_base + NC_VA_COUNTER_1_CONTROL);
> 	writel_relaxed(26, timer_base + NC_VA_COUNTER_1_PRE);
>
OK

> > +CLOCKSOURCE_OF_DECLARE(nc_timer, "nationalchip,timer-v1", nc_timer_init);
> 
> This needs a devicetree binding document. Please see Documentation/devicetree/bindings/submitting-patches.txt.
>
OK

Best Regards
  Guo Ren
