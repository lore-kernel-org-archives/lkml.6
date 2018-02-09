Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbeBIMf0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:35:26 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34374 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbeBIMfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:35:24 -0500
Date: Fri, 9 Feb 2018 13:35:10 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
Cc: Dmitry Safonov <dima@arista.com>, David Miller <davem@davemloft.net>,
        frederic@kernel.org, linux-kernel@vger.kernel.org,
        alexander.levin@verizon.com, peterz@infradead.org,
        mchehab@s-opensource.com, torvalds@linux-foundation.org,
        hannes@stressinduktion.org, paulmck@linux.vnet.ibm.com,
        wanpeng.li@hotmail.com, tglx@linutronix.de, akpm@linux-foundation.org,
        pabeni@redhat.com, rrendec@arista.com, mingo@kernel.org,
        sgruszka@redhat.com, riel@redhat.com, edumazet@google.com
Subject: Re: [RFC PATCH 2/4] softirq: Per vector deferment to workqueue
Message-ID: <20180209123510.2qxgkky5juejjvcg@linutronix.de>
References: <20180208174450.qjvjy752jf4ngt2g@breakpoint.cc>
 <20180208.134506.1374787894560277876.davem@davemloft.net>
 <1518120895.2849.14.camel@arista.com>
 <20180208.152236.2148696725742511754.davem@davemloft.net>
 <1518121820.2849.17.camel@arista.com>
 <1518149468.24350.40.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1518149468.24350.40.camel@gmx.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-09 05:11:08 [+0100], Mike Galbraith wrote:
> On Thu, 2018-02-08 at 20:30 +0000, Dmitry Safonov wrote:
> > On Thu, 2018-02-08 at 15:22 -0500, David Miller wrote:
> > > Why do we need more than one per cpu?
> > 
> > Ugh, yeah, I remember why I did it - I tried to reuse scheduler for
> > each ksoftirqd thread to decide if it need to run now or later.
> > That would give an admin a way to prioritise softirqs with nice.
> > Not sure if it's a nice idea at all..
> 
> For RT that can be handy, but for the general case it's a waste of
> cycles, so would want to be opt-in.

We used to have it in RT. It got replaced because the context switch from
one thread to the other simply took time.
If you need to prioritise one softirqs over the other I think you would
be better off running with threaded-interrupts. In "normal" mode, if you
have a raised NAPI and say a TASKLET then once both IRQ handler complete
(and interrupts get enabled again) then the softirqs are run. With
threaded interrupts enabled, the NAPI-softirq is invoked once the
threaded-handler completes that raised it - same goes the other threaded
handler which raised the tasklet softirq.
So you could simply change the priority of the threaded interrupt in
order to prefer NAPI over tasklet handling (or the other way around).

> 	-Mike

Sebastian
