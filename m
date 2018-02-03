Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeBCDsG convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 22:48:06 -0500
Received: from mout.gmx.net ([212.227.15.15]:60007 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752328AbeBCDsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 22:48:00 -0500
Message-ID: <1517629652.18310.33.camel@gmx.de>
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
From: Mike Galbraith <efault@gmx.de>
To: Steven Sistare <steven.sistare@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        dhaval.giani@oracle.com
Date: Sat, 03 Feb 2018 04:47:32 +0100
In-Reply-To: <5b9f0828-8d35-885b-3eba-d31ca46da642@oracle.com>
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
         <20180201123335.GV2249@hirez.programming.kicks-ass.net>
         <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
         <20180202172153.GO2269@hirez.programming.kicks-ass.net>
         <ed78c502-c1f8-43b3-f3d4-e0256e4085ee@oracle.com>
         <5b9f0828-8d35-885b-3eba-d31ca46da642@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:ejE3z5s0lXGQXRPB72t9YgRWw83nn6+MlaE8Rc9zX/BRxkkhk78
 C0tAeXbfdgo9tekec/r7IX7cH/moe/FEYZ9/uSb6DSv8Qs1Ga8LKN1OtgFmROZ9S4t0jzp8
 qM//UfBEN4VNyGH+D5bdx6AXnidPAm61AqDLRmeb9c0vOdF31V4rsQ291xunCebdwfo+hQN
 N705YRUrZ9KF/4ssoK0gw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rSsLz8V7dxg=:eHDaX9MN+ZcXLTOAs+6nPZ
 FPKWcfOj0WoyIj+De8XMhDGjLAWAUpth3yutHWe+asDX30f8jHGS4rHKbiB69vhmTlAg2jh/B
 ruGbAYDAVGpkDEwGNw5JBmdHx4hPpaiY9deIz5Y1YaDI7qklCYv6HHoQZ1q/thE/zciOD3l+2
 5AHTe/2GJN9AqXn9VeX/CeCF6FS4l4eYyQy70j1p6PPVkXDoNYox5JT7/oP51GTo9Br1FlQNa
 uLxUMubAW3JlLtE36BB5sxL9cZ7STqPv1JnN9TD7MNYPOgHh7nIAWrnmv9K7/pwK2GJn1sfzW
 2n3nNrdzje7N+DioylWiy2PYdkak2xf4TRf9uff46s+crGf7hOcR2SR1LjBXWbImepZW+q2BS
 mu3GudRKGQs+BDjtIcecRzJat0zd8nz0TyocoFyo0H2F8/y22PF1X1AMlJFuw1PMycoi5KaE2
 djoMg2rLEO/QRB5gKtyDp61zYLlRguZN2Z1qXVsTSXI2OaYwiBl5eQVddiohCkdMTwOitaUC9
 +v7surB8dpwI0mAZ7THq8AeQ0GnbSxPdcpkRFnGRmLXm8pUyrPluZqAGsUzA8cQ+RUL7A7vbS
 4mnKwRHLM06Ydiel4+98gp2ccMqehAGPDWqpzv/iO5lJ2XfkCi+Zv9GEhnuu8QROZYeDfLGdm
 uXx9ICQWrWkHojCYy7skcoiAqyqDVrpUGPLar4T3eqWx9zdgIWBtyR+owVzmJit02LtfSsNeR
 +tIafuv8eEXq+HIP3fRaK1ctUXzQEsJXUCur8W1ydWfx2vPvVCb2Hs+IU5WfvXRjM+QePkZYI
 AID84xuHphOS8T6VuEaLgnPJusd6v6FLN7MtAHuQjoh+LaEHYs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-02 at 13:34 -0500, Steven Sistare wrote:
> On 2/2/2018 12:39 PM, Steven Sistare wrote:
> > On 2/2/2018 12:21 PM, Peter Zijlstra wrote:
> >> On Fri, Feb 02, 2018 at 11:53:40AM -0500, Steven Sistare wrote:
> >>> It might be interesting to add a tunable for the number of random choices to
> >>> make, and clamp it at the max nr computed from avg_cost in select_idle_cpu.
> >>
> >> This needs a fairly complicated PRNG for it would need to visit each
> >> possible CPU once before looping. A LFSR does that, but requires 2^n-1
> >> elements and we have topology masks that don't match that.. The trivial
> >> example is something with 6 cores.
> > 
> > Or keep it simple and accept the possibility of choosing the same candidate
> > more than once.
> > 
> >>> Or, choose a random starting point and then search for nr sequential 
> >>> candidates; possibly limited by a tunable.
> >>
> >> And this is basically what we already do. Except with the task-cpu
> >> instead of a per-cpu rotor.
> > 
> > Righto.  Disregard this suggestion.
> 
> Actually, I take back my take back.  I suspect the primary benefit
> of random selection is that it breaks up resonance states where
> CPUs that are busy tend to stay busy, and CPUs that are idle tend
> to stay idle, which is reinforced by starting the search at target =
> last cpu ran.

I suspect the primary benefit is reduction of bouncing.  The absolutely
maddening thing about SIS is that some stuff out there (like FB's load)
doesn't give a rats ass about anything other than absolute minimum
sched latency while other stuff notices cache going missing.  Joy.

	-Mike
