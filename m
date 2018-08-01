Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106B0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8388208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8388208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403989AbeHATdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:33:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34618 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389887AbeHATdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:33:01 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkvCN-0005kK-1C; Wed, 01 Aug 2018 19:46:11 +0200
Date:   Wed, 1 Aug 2018 19:46:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [PATCH] nohz: Fix missing tick reprog while interrupting inline
 timer softirq
In-Reply-To: <1533077570-9169-1-git-send-email-frederic@kernel.org>
Message-ID: <alpine.DEB.2.21.1808011812160.1835@nanos.tec.linutronix.de>
References: <1533077570-9169-1-git-send-email-frederic@kernel.org>
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

On Wed, 1 Aug 2018, Frederic Weisbecker wrote:
> Before updating the full nohz tick or the idle time on IRQ exit, we
> check first if we are not in a nesting interrupt, whether the inner
> interrupt is a hard or a soft IRQ.
> 
> There is a historical reason for that: the dyntick idle mode used to
> reprogram the tick on IRQ exit, after softirq processing, and there was
> no point in doing that job in the outer nesting interrupt because the
> tick update will be performed through the end of the inner interrupt
> eventually, with even potential new timer updates.
> 
> One corner case could show up though: if an idle tick interrupts a softirq
> executing inline in the idle loop (through a call to local_bh_enable())

Where does this happen? Why is anything in the idle loop doing a
local_bh_disable/enable() pair?

Or are you talking about NOHZ FULL and arbitrary task context?

> after we entered in dynticks mode, the IRQ won't reprogram the tick
> because it assumes the softirq executes on an inner IRQ-tail. As a
> result we might put the CPU in sleep mode with the tick completely
> stopped whereas a timer can still be enqueued. Indeed there is no tick
> reprogramming in local_bh_enable(). We probably asssumed there was no bh
> disabled section in idle, although there didn't seem to be debug code
> ensuring that.
> 
> Nowadays the nesting interrupt optimization still stands but only concern
> full dynticks. The tick is stopped on IRQ exit in full dynticks mode
> and we want to wait for the end of the inner IRQ to reprogramm the tick.
> But in_interrupt() doesn't make a difference between softirqs executing
> on IRQ tail and those executing inline. What was to be considered a
> corner case in dynticks-idle mode now becomes a serious opportunity for
> a bug in full dynticks mode: if a tick interrupts a task executing
> softirq inline, the tick reprogramming will be ignored and we may exit
> to userspace after local_bh_enable() with an enqueued timer that will
> never fire.
> 
> To fix this, simply keep reprogramming the tick if we are in a hardirq
> interrupting softirq. We can still figure out a way later to restore
> this optimization while excluding inline softirq processing.

I'm not really happy with that 'fix' because what happens if:

  ....
  local_bh_enable()
    do_softirq()
      --> interrupt()
	     tick_nohz_irq_exit();
      arm_timer();

So if that new timer is the only one on the CPU, what is going to arm the
timer hardware which was just switched off in tick_nohz_irq_exit()?

I haven't looked deep enough, but a simple unconditional call to
tick_irq_exit() at the end of do_softirq() might do the trick.

Thanks,

	tglx





	  
