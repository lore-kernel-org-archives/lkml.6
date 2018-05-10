Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeEJXU6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 19:20:58 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:41310 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750710AbeEJXUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 19:20:53 -0400
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: hoeun.ryu@lge.com
X-Original-SENDERIP: 10.159.138.109
X-Original-MAILFROM: hoeun.ryu@lge.com
From: =?ks_c_5601-1987?B?t/nIo8C6?= <hoeun.ryu@lge.com>
To: "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Hoeun Ryu'" <hoeun.ryu@lge.com.com>
Cc: "'Will Deacon'" <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <1525941385-12766-1-git-send-email-hoeun.ryu@lge.com.com> <20180510102114.obmctt3nn7xakggi@lakrids.cambridge.arm.com>
In-Reply-To: <20180510102114.obmctt3nn7xakggi@lakrids.cambridge.arm.com>
Subject: RE: [PATCH] armpmu: broadcast overflow irq on multi-core system having one muxed SPI for PMU.
Date: Fri, 11 May 2018 08:20:49 +0900
Message-ID: <010c01d3e8b5$8839a480$98aced80$@lge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQI200NC9ZdWhGpfV9y+jNeqofWHPgJPbp5Yo1FA2EA=
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the reply.

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland@arm.com]
> Sent: Thursday, May 10, 2018 7:21 PM
> To: Hoeun Ryu <hoeun.ryu@lge.com.com>
> Cc: Will Deacon <will.deacon@arm.com>; Hoeun Ryu <hoeun.ryu@lge.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] armpmu: broadcast overflow irq on multi-core system
> having one muxed SPI for PMU.
> 
> Hi,
> On Thu, May 10, 2018 at 05:36:17PM +0900, Hoeun Ryu wrote:
> > From: Hoeun Ryu <hoeun.ryu@lge.com>
> >
> >  On some SoCs like i.MX6DL/QL have only one muxed SPI for multi-core
> system.
> > On the systems, a CPU can be interrupted by overflow irq but it is
> > possible that the overflow actually occurs on another CPU.
> 
> Muxing the PMU IRQs is a really broken system design, and there's no good
> way of supporting it.

Yes. I agree with that. I scratched my head when I found the system has one
muxed SPI.

> 
> What we should do for such systems is:
> 
> * Add a flag to the DT to describe that the IRQs are muxed, as this
>   cannot be probed.
> 
> * Add hrtimer code to periodically update the counters, to avoid
>   overflow (e.g. as we do in the l2x0 PMU).
> 
> * Reject sampling for such systems, as this cannot be done reliably or
>   efficiently.
> 
> NAK to broadcasting the IRQ -- there are a number of issues with the
> general approach.
> 

The second solution would be good if sampling is necessary even like those
systems.

Actually I'm working on FIQ available ARM32 system and trying to enable the
hard lockup detector by routing the PMU IRQ to FIQ.
Because of that, I really need the interrupt event if it is a muxed SPI,
beside I also need to make an dedicated IPI FIQ to broadcast the IRQ in
this approach.
What would you do if you were in the same situation ?

> We should update the PMU probing code to warn when we have fewer IRQs than
> CPUs, and fail gracefully to the above.
> 
> [...]
> 
> >  static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)  {
> 
> > +			/* smp_call_function cannot be called with irq
> disabled */
> > +			local_irq_enable();
> > +			preempt_disable();
> > +			smp_call_function_many(&mask, __armpmu_handle_irq,
dev,
> 0);
> > +			preempt_enable();
> > +			local_irq_disable();
> 
> For many reasons, this sequence is not safe.
> 
> It is not safe to enable IRQs in irq handlers. Please never do this.

I was not sure it was safe to enable IRQs in irq handlers.
Thank you for pointing that.

> 
> Thus it's also never safe to call smp_call_function*() in IRQ handlers.

Yes. I found out that it is due to csd lock.

> 
> Futher, If you ever encounter a case where you need to avoid preemption
> across enabling IRQs, preemption must be disabled *before* enabling IRQs.

Ah, OK.
Enabling IRQs can cause scheduling tasks in the end of exception or other
scheduling points, right ?

> 
> Thanks,
> Mark.
