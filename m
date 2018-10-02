Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E36C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980FD205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980FD205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeJBMWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:22:04 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:58981 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbeJBMWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:22:04 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07440893|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03297;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.CyTRBK6_1538458825;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CyTRBK6_1538458825)
          by smtp.aliyun-inc.com(10.147.41.231);
          Tue, 02 Oct 2018 13:40:25 +0800
Date:   Tue, 2 Oct 2018 13:40:25 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, anurup.m@huawei.com,
        Jonathan.Cameron@huawei.com, will.deacon@arm.com,
        zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, f.fainelli@gmail.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V9 3/8] clocksource: add C-SKY SMP timer
Message-ID: <20181002054024.GA12645@guoren>
References: <cover.1538355281.git.ren_guo@c-sky.com>
 <eee964dd57d12bc630280ab84235b5356799b1fb.1538355281.git.ren_guo@c-sky.com>
 <88e320f2-8cf0-fdb9-c9b0-ee25d7a4d00f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88e320f2-8cf0-fdb9-c9b0-ee25d7a4d00f@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 11:14:14AM +0200, Daniel Lezcano wrote:
> On 01/10/2018 03:35, Guo Ren wrote:
> > This timer is used by SMP system and use mfcr/mtcr instruction
> > to access the regs.
> > 
> > Changelog:
> >  - Remove #define CPUHP_AP_CSKY_TIMER_STARTING
> >  - Add CPUHP_AP_CSKY_TIMER_STARTING in cpuhotplug.h
> >  - Support csky mp timer alpha version.
> >  - Just use low-counter with 32bit width as clocksource.
> >  - Coding convention with upstream feed-back.
> > 
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> >  drivers/clocksource/Kconfig        |   8 ++
> >  drivers/clocksource/Makefile       |   1 +
> >  drivers/clocksource/csky_mptimer.c | 176 +++++++++++++++++++++++++++++++++++++
> >  include/linux/cpuhotplug.h         |   1 +
> >  4 files changed, 186 insertions(+)
> >  create mode 100644 drivers/clocksource/csky_mptimer.c
> > 
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index a11f4ba..a28043f 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -620,4 +620,12 @@ config RISCV_TIMER
> >  	  is accessed via both the SBI and the rdcycle instruction.  This is
> >  	  required for all RISC-V systems.
> >  
> > +config CSKY_MPTIMER
> > +	bool "C-SKY Multi Processor Timer"
> > +	depends on CSKY
> > +	select TIMER_OF
> > +	help
> > +	  Say yes here to enable C-SKY SMP timer driver used for C-SKY SMP
> > +	  system.
> > +
> >  endmenu
> 
> The same rule applies here for COMPILE_TEST.
Ok

> And please rename the file: timer-mp-csky.c
Ok

> > +	return (u64) mfcr(PTIM_CCVR);
> 
> extra space
Ok

> 
> > +}
> > +
> > +static u64 clksrc_read(struct clocksource *c)
> > +{
> > +	return (u64) mfcr(PTIM_CCVR);
> 
> extra space
Ok

> > +	 */
> > +
> 
> extra line
Ok

> 
> > +	for_each_possible_cpu(cpu) {
> > +		to = per_cpu_ptr(&csky_to, cpu);
> > +
> > +		if (cpu == 0) {
> > +			to->flags	  |= TIMER_OF_IRQ;
> > +			to->of_irq.handler = timer_interrupt;
> > +
> > +			ret = timer_of_init(np, to);
> > +			if (ret)
> > +				return ret;
> > +
> > +			rate	= timer_of_rate(to);
> > +			irq	= to->of_irq.irq;
> > +		} else {
> > +			ret = timer_of_init(np, to);
> > +			if (ret)
> > +				return ret;
> > +
> > +			to->of_clk.rate	= rate;
> > +			to->of_irq.irq	= irq;
> > +		}
> > +	}
> 
> 
> Isn't possible to replace this loop which is a bit confusing by:
> 
>  - no irq flag specified for timer-of
>  - request irq before
Ok, but I've a bit different :)
 
> So we end up with:
> 
> 	irq = irq_of_parse_and_map(np, 0);
> 	if (irq <= 0)
> 		return -EINVAL;
		panic();
I want a panic here. Return will make debug confused and directly tell
the people where is wrong. It's root-timer for us and it must bootup.

If it's a co-timer, I also think return is good.

> 
> 	ret = request_irq(irq, csky_timer_interrupt,
> 			IRQF_TIMER | IRQF_PERCPU,
>                         "csky_mp_timer", &csky_to));
	ret = request_percpu_irq(irq, csky_timer_interrupt,
			"csky_mp_timer", &csky_to);
I'll use request_percpu_irq the same as in timer_of and I've tested it's
Ok.

> 	if (ret)
> 		return ret;
Pls let me panic here.

> 
> 	for_each_possible_cpu(cpu) {
> 		to = per_cpu_ptr(&csky_to, cpu);
> 		ret = timer_of_init(np, to);
> 		if (ret)
> 			goto rollback;
		Pls let me panic here.
> 	}

Best Regards
 Guo Ren
