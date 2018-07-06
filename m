Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D7FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2E82404E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2E82404E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeGFGJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:09:55 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:45030 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753457AbeGFGHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:07:51 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0750676|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03308;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.CMxpOBn_1530857260;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CMxpOBn_1530857260)
          by smtp.aliyun-inc.com(10.147.44.118);
          Fri, 06 Jul 2018 14:07:40 +0800
Date:   Fri, 6 Jul 2018 14:07:40 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 16/19] csky: SMP support
Message-ID: <20180706060740.GB8707@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
 <20180705180503.GH2530@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705180503.GH2530@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 08:05:03PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 02, 2018 at 01:30:19AM +0800, Guo Ren wrote:
> > +static irqreturn_t handle_ipi(int irq, void *dev)
> > +{
> > +	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
> > +
> > +	while (true) {
> > +		unsigned long ops;
> > +
> > +		/* Order bit clearing and data access. */
> > +		mb();
> > +
> > +		ops = xchg(pending_ipis, 0);
> > +		if (ops == 0)
> > +			return IRQ_HANDLED;
> > +
> > +		if (ops & (1 << IPI_RESCHEDULE))
> > +			scheduler_ipi();
> > +
> > +		if (ops & (1 << IPI_CALL_FUNC))
> > +			generic_smp_call_function_interrupt();
> > +
> > +		BUG_ON((ops >> IPI_MAX) != 0);
> > +
> > +		/* Order data access and bit testing. */
> > +		mb();
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void (*send_arch_ipi)(const unsigned long *mask, unsigned long irq) = NULL;
> > +
> > +void __init set_send_ipi(void (*func)(const unsigned long *, unsigned long))
> > +{
> > +	if (send_arch_ipi)
> > +		return;
> > +
> > +	send_arch_ipi = func;
> > +}
> > +
> > +static void
> > +send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
> > +{
> > +	int i;
> > +
> > +	mb();
> > +	for_each_cpu(i, to_whom)
> > +		set_bit(operation, &ipi_data[i].bits);
> > +
> > +	mb();
> > +	send_arch_ipi(cpumask_bits(to_whom), IPI_IRQ);
> > +}
> 
> 
> Please explain those mb()'s... I'm thinking you meant to use smp_mb().
Yes, smp_mb(). Current smp_mb()&mb() is the same: sync.is.

In next version patch, I'll seperate smp_mb() and mb() and use ld/st.barrier
instead of sync.is. Sync.is is expensive that it flush cpu's pipeline.

> But then for handle_ipi(), the xchg() should already imply all those.
Yes, approve.

> And the send_ipi_message() only needs the second.
Yes, approve.

 Guo Ren
