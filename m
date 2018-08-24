Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD287C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0C52157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0C52157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeHXKeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:34:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39467 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeHXKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:34:25 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ft65f-0001fj-5k; Fri, 24 Aug 2018 09:01:03 +0200
Date:   Fri, 24 Aug 2018 09:01:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        stable@vger.kernel.org
Subject: Re: [PATCH] nohz: Fix missing tick reprog while interrupting inline
 timer softirq
In-Reply-To: <20180824061750.GA20523@kroah.com>
Message-ID: <alpine.DEB.2.21.1808240851420.1668@nanos.tec.linutronix.de>
References: <1533077570-9169-1-git-send-email-frederic@kernel.org> <8ecb9229-4c14-6967-0863-15b47cefd251@ti.com> <20180824061750.GA20523@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018, Greg KH wrote:
> On Thu, Aug 23, 2018 at 05:57:06PM -0500, Grygorii Strashko wrote:
> > This patch was back ported to the Stable linux-4.14.y and It causes regression -
> >  flood of "NOHZ: local_softirq_pending" messages on all TI boards during boot (NFS boot):
> > 
> > [    4.179796] NOHZ: local_softirq_pending 2c2 in sirq 256
> > [    4.185051] NOHZ: local_softirq_pending 2c2 in sirq 256

This printout is weird. Did you add something here?

> > the same is not reproducible with LKML - seems due to changes in tick-sched.c 
> > __tick_nohz_idle_enter()/tick_nohz_irq_exit().
> 
> What changes do you think fixed this?
> 
> > I've generated backtrace from  can_stop_idle_tick() (see below) and seems this
> > patch makes tick_nohz_irq_exit() call unconditional in case of nested interrupt:
> > 
> > gic_handle_irq
> >  |- irq_exit
> >     |- preempt_count_sub(HARDIRQ_OFFSET); <-- [1]
> >     |-__do_softirq 
> > 	<irqs enabled>
> > 	|- gic_handle_irq()
> > 	   |- irq_exit()
> > 		|- tick_irq_exit()
> > 		   if (!in_irq()) <-- My understanding is that this condition will be always true due to [1]

Correct, but that's not the problem. The issue is that this happens in a
softirq disabled region. Does the below fix it?

Thanks,

	tglx

8<--------------------
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 5b33e2f5c0ed..6aab9d54a331 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -888,7 +888,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 	if (unlikely(local_softirq_pending() && cpu_online(cpu))) {
 		static int ratelimit;
 
-		if (ratelimit < 10 &&
+		if (ratelimit < 10 && !in_softirq() &&
 		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
 			pr_warn("NOHZ: local_softirq_pending %02x\n",
 				(unsigned int) local_softirq_pending());


