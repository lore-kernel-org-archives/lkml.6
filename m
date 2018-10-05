Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54876C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E06206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E06206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeJEVCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:02:30 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:43918 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727581AbeJEVCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:02:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08064312|-1;CH=blue;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03278;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.CzlU2l5_1538748200;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CzlU2l5_1538748200)
          by smtp.aliyun-inc.com(10.147.41.120);
          Fri, 05 Oct 2018 22:03:20 +0800
Date:   Fri, 5 Oct 2018 22:03:19 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, anurup.m@huawei.com,
        Jonathan.Cameron@huawei.com, will.deacon@arm.com,
        zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V10 5/8] clocksource: add C-SKY SMP timer
Message-ID: <20181005140319.GA6789@guoren-Inspiron-7460>
References: <cover.1538672812.git.ren_guo@c-sky.com>
 <76f127a22faf8f110f102ee3534792b2b84a7d78.1538672812.git.ren_guo@c-sky.com>
 <4ec284a4-0cff-91b8-bd0a-6eb578b28432@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ec284a4-0cff-91b8-bd0a-6eb578b28432@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Fri, Oct 05, 2018 at 03:48:58PM +0200, Daniel Lezcano wrote:
> On 04/10/2018 19:22, Guo Ren wrote:
> > This timer is used by SMP system and use mfcr/mtcr instruction
> > to access the regs.
> > 
> > Changelog:
> >  - Add rollback for timer_of_cleanup.
> >  - Use request_percpu_irq separate from time_of.
> >  - Remove #define CPUHP_AP_CSKY_TIMER_STARTING.
> >  - Add CPUHP_AP_CSKY_TIMER_STARTING in cpuhotplug.h.
> >  - Support csky mp timer alpha version.
> >  - Just use low-counter with 32bit width as clocksource.
> >  - Coding convention with upstream feed-back.
> > 
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> >  drivers/clocksource/Kconfig         |  10 +++
> >  drivers/clocksource/Makefile        |   1 +
> >  drivers/clocksource/timer-mp-csky.c | 173 ++++++++++++++++++++++++++++++++++++
> >  include/linux/cpuhotplug.h          |   1 +
> >  4 files changed, 185 insertions(+)
> >  create mode 100644 drivers/clocksource/timer-mp-csky.c
> > 
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index a11f4ba..826a2e8 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -620,4 +620,14 @@ config RISCV_TIMER
> >  	  is accessed via both the SBI and the rdcycle instruction.  This is
> >  	  required for all RISC-V systems.
> >  
> > +config CSKY_MP_TIMER
> > +	bool "SMP Timer for the C-SKY platform"
> > +	depends on CSKY
> > +	select TIMER_OF
> > +	help
> > +	  Say yes here to enable C-SKY SMP timer driver used for C-SKY SMP
> > +	  system.
> > +	  csky,mptimer is not only used in SMP system, it also could be used
> > +	  single core system. It's not a mmio reg and it use mtcr/mfcr instruction.
> 
> 
> ... COMPILE_TEST :)
Ops... I forgot it, should be: 
	bool "SMP Timer for the C-SKY platform" if COMPILE_TEST

Thx for remind and any other review is welcome.

Best Regards
 Guo Ren
