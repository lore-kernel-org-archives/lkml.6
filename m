Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeBIEME (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 23:12:04 -0500
Received: from mout.gmx.net ([212.227.15.18]:54321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752239AbeBIEMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 23:12:02 -0500
Message-ID: <1518149468.24350.40.camel@gmx.de>
Subject: Re: [RFC PATCH 2/4] softirq: Per vector deferment to workqueue
From: Mike Galbraith <efault@gmx.de>
To: Dmitry Safonov <dima@arista.com>, David Miller <davem@davemloft.net>
Cc: bigeasy@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, alexander.levin@verizon.com,
        peterz@infradead.org, mchehab@s-opensource.com,
        torvalds@linux-foundation.org, hannes@stressinduktion.org,
        paulmck@linux.vnet.ibm.com, wanpeng.li@hotmail.com, tglx@linutronix.de,
        akpm@linux-foundation.org, pabeni@redhat.com, rrendec@arista.com,
        mingo@kernel.org, sgruszka@redhat.com, riel@redhat.com,
        edumazet@google.com
Date: Fri, 09 Feb 2018 05:11:08 +0100
In-Reply-To: <1518121820.2849.17.camel@arista.com>
References: <20180208174450.qjvjy752jf4ngt2g@breakpoint.cc>
         <20180208.134506.1374787894560277876.davem@davemloft.net>
         <1518120895.2849.14.camel@arista.com>
         <20180208.152236.2148696725742511754.davem@davemloft.net>
         <1518121820.2849.17.camel@arista.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Dqiur88uvVlF0sPtBVSjMdoMvK3edpR3jSPferzKtfe/TvDrhpD
 pAakQs6YcCg0cP5B0971hoOTnGrA59pCAU8/GeVwaJSnrw1m1K/T9vmiO4N/C20ml2Cu91+
 g508It6T6uUGtRX5xNJZyyoZul+MfFUlNL6KxNBWFi/EmGXv5+QURJRc+/rxP+721IukEJL
 R4wzEVzeaqTe3BBcPdA4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:panXECExUjM=:6ZyE6DRozkkFVEL7jDqDcN
 D5JEDfCOsP9a7Y1M+7RscmWUXpSY0co3oPyPVXx8nLdMgv/e37RCv2kzmg4+4GX4O+Vd/LkvJ
 Cxg0yPdyucGe0yT2pB8CPxjSsuuyrmWj+vXIOQpMzXCGEtlkC4LfbMFJfrY0GqvwImkFn9EFu
 qQAhrsw0AnZjXTqG1FbKIDkjNudQ2zYNVGkfwSX7KwJxgzr+ofqZPq1uLnHzUofR6FVRa5B2S
 t/KFfP6m9phVZYcMZR02QiBW/6t4727HshuS8UNq4wtixOXm+eJ7X1F5G+5bkjZlB/yQ33Dun
 a23WIr0LviY+y4D0ck5FVT0uBd8MVhyI4uDOcDpIu1EX/PyTj+wTQghD9g/yTUgGIKc/AbBd7
 M2rGolUNT4XDAjJdHsbpbNitoiLgD35HTqUp6NMlKZWhyTHbNTZqs+JwNdhzjK4KKK3rCkMxG
 elW6D46gwTuIUaXFFuJt5QhxctYeECw+hguT7JEVp5Jzf2orSmIS6kOlhpAqIFCgoyKpH9TTs
 rF2FPWA05CHg84LorL3conAjU4FuoZ6fonfbra0T6F4pZYGLO3/N79cJV595LaJ90boOAQ+53
 bt0yTkUlLfGN0FVIs25BBMGCaDyZVQC4yrg3G1+3mvN5Cw0QyZ9eilYVpmV/Kyz8PDyD4aV4j
 tGStOkoXgY1rWpdMwgxrdx+cEVk3WUKWUYRjwgihoHOs+eD/9BwwjJ+XkAC3IiKU7nkfzCjYA
 cZUjTABz6f8bM6kAB1CO+gimYQV4v0Wfi1ZuWDc3gVfTkZ6pJP+p8o/G9myhcZpOP3hHyBPBo
 DHCQdubvqaXeJhZrwl9Il5UR0P2AoTnb0/C4L1qPL+jctriceI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-08 at 20:30 +0000, Dmitry Safonov wrote:
> On Thu, 2018-02-08 at 15:22 -0500, David Miller wrote:
> > From: Dmitry Safonov <dima@arista.com>
> > Date: Thu, 08 Feb 2018 20:14:55 +0000
> > 
> > > On Thu, 2018-02-08 at 13:45 -0500, David Miller wrote:
> > >> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > >> Date: Thu, 8 Feb 2018 18:44:52 +0100
> > >> 
> > >> > May I instead suggest to stick to ksoftirqd? So you run in
> > softirq
> > >> > context (after return from IRQ) and if takes too long, you
> > offload
> > >> the
> > >> > vector to ksoftirqd instead. You may want to play with the
> > metric
> > >> on
> > >> > which you decide when you want switch to ksoftirqd / account how
> > >> long a
> > >> > vector runs.
> > >> 
> > >> Having read over this stuff for the past few weeks this is how I
> > feel
> > >> as well.  Just make ksofbitrq do what we want (only execute the
> > >> overloaded softirq vectors).
> > >> 
> > >> The more I look at the workqueue stuff, the more complications and
> > >> weird behavioral artifacts we are getting for questionable gain.
> > > 
> > > What about creating several ksoftirqd threads per-cpu?
> > > Like I did with boot parameter to specify how many threads and
> > which
> > > softirqs to serve.
> > 
> > Why do we need more than one per cpu?
> 
> Ugh, yeah, I remember why I did it - I tried to reuse scheduler for
> each ksoftirqd thread to decide if it need to run now or later.
> That would give an admin a way to prioritise softirqs with nice.
> Not sure if it's a nice idea at all..

For RT that can be handy, but for the general case it's a waste of
cycles, so would want to be opt-in.

	-Mike
