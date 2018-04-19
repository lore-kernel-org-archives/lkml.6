Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbeDSLFu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 07:05:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39134 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDSLFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 07:05:48 -0400
Date: Thu, 19 Apr 2018 13:05:39 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Imre Deak <imre.deak@intel.com>
cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Early timeouts due to inaccurate jiffies during system
 suspend/resume
In-Reply-To: <20180419013200.wxkzqfdacfsijci5@ideak-desk.fi.intel.com>
Message-ID: <alpine.DEB.2.21.1804191256200.1563@nanos.tec.linutronix.de>
References: <20180419013200.wxkzqfdacfsijci5@ideak-desk.fi.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018, Imre Deak wrote:
> Hi,
> 
> while checking bug [1], I noticed that jiffies based timing loops like
> 
> 	expire = jiffies + timeout + 1;
> 	while (!time_after(jiffies, expire))
> 		do_something;
> 
> can last shorter than expected (that is less than timeout).

Yes, that can happen when the timer interrupt is delayed long enough for
whatever reason. If you need accurate timing then you need to use
ktime_get().

> After some ftracing it seems like jiffies gets stale due to a missed
> LAPIC timer interrupt after the interrupt is armed in
> lapic_next_deadline() and before jiffies is sampled at 2. above.
> Eventually the interrupt does get delivered, at which point jiffies gets
> updated via tick_do_update_jiffies64() with a >1 ticks increment.
> Between lapic_next_deadline() and the - late - delivery of the interrupt
> the CPU on which the interrupt is armed doesn't go idle.

That's odd. I have no real explanation for that.

Thanks,

	tglx
