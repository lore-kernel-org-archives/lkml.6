Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753100AbeFDMza (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:55:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39530 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752478AbeFDMz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:55:28 -0400
Date: Mon, 4 Jun 2018 14:55:20 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 1.5/5] alpha: atomic: provide asm for the fastpath for
 _atomic_dec_and_lock_irqsave
Message-ID: <20180604125520.pkxvwg4sjlws2lrs@linutronix.de>
References: <20180504154533.8833-1-bigeasy@linutronix.de>
 <20180504154533.8833-2-bigeasy@linutronix.de>
 <20180604102559.2ynbassthjzva62l@linutronix.de>
 <20180604102757.h46feymcfdydl4nz@linutronix.de>
 <20180604114852.GQ12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604114852.GQ12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-04 13:48:52 [+0200], Peter Zijlstra wrote:
> On Mon, Jun 04, 2018 at 12:27:57PM +0200, Sebastian Andrzej Siewior wrote:
> > I just looked at Alpha's atomic_dec_and_lock assembly and did something
> > that should work for atomic_dec_and_lock_irqsave. I think it works but I
> > would prefer for someone from the Alpha-Camp to ack this before it goes
> > in. It is not critical because the non-optimized version should work.
> 
> I would vote to simply delete this entire file and get alpha on the
> generic code.
> 
> Afaict, this asm gets the ordering wrong, and I doubt it is much faster
> than using atomic_add_unless() in any case (+- the ordering of course).

I *think* the Alpha version is slightly wrong here. It does
	load
	dec by one
	cmpeq

while the __atomic_add_unless() implementation does
	load
	cmpeq
	
which is the right thing (unless I can't parse the assembly properly).

Sebastian
