Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753533AbeFASsn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:48:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:51325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753088AbeFASsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:48:42 -0400
Message-ID: <1527878882.4448.11.camel@gmx.de>
Subject: Re: [PATCH] x86,switch_mm: skip atomic operations for init_mm
From: Mike Galbraith <efault@gmx.de>
To: Rik van Riel <riel@surriel.com>, Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, songliubraving@fb.com,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date: Fri, 01 Jun 2018 20:48:02 +0200
In-Reply-To: <1527877328.7898.80.camel@surriel.com>
References: <20180601082811.4c0d33ba@imladris.surriel.com>
         <CALCETrUVFdrtorJBVg1fizUx+c23MVVqNnzGs3oWpN8LHyEvMA@mail.gmail.com>
         <1527877328.7898.80.camel@surriel.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YPTCoe4qK6A7sYvb6wwR+AZf491bTDF4UQbze8iUgoCxdhkrC6O
 1DY4DahuKFVuaD+vD1stwjVMebMoqaBJIrtjJLfOothslLfAahl9njV1wGLVMj54DUDPzBy
 wZvLiAKI1hrKFTMczYMJ2/pN9AwdyiuK/UU+0sn12wg3paMlqPBETa/784xIM3KeTitS+Iz
 ObaNCFa7ZLVneMJWkZNIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NkPIzEmi/i4=:ghrB1mczJvSpOz/3VuAYId
 EOxG8p9h/UhRcr1C5r9aEeKC/2IK24fJMzt7T2Oyi4V8Q3bvF1nUQK2ap0F8ySPj9zBWxr+3j
 MLEJ6kuJITgnDlL+Ust1kaJPLlLvyw/hAECAiPdVStiDpyanTYOkXYXQB8Ddv83y7UMTBgmgP
 a5T7FNG7Ptm2+s1TqczO6C6ThOkCzS38qLlUPGfCrJQKEWX2MecxomH5x9Zo7feLL1TWrEHSE
 YBovRoB1w/kjsBgNvshymvqc1w5hAcN4F6HJkx/EAlJpgGmsesU6m86NBdpiwkraeVMqR4q4t
 POqgSIm+dnUXbe39G6cDIvllfe41iSiF0q36w9p2mr0pexzNRwhWUGlYge4agRqeDti3eFkfK
 A66KyXjxLi9A5uTdJBPZrcL7pzMSxJaqiREJX7Fied5xyrPyU3JbdUtHJDpfGVnlTVM7+If4E
 eQMIDJiaKiwfer4P+DiadFR9JU9dNRT6Wqc9e00YFaspbY2bhaeEI1xIHANB2fFLy73SuPfAg
 DWep7Yx0t3AyaHMcliqizz7D//zDzWReBks34t7DbXeDUaZNGIOAS+oFseJSWdueCjntBbRWt
 bav5a/JUJExF6FUwIfxQ0KsOSOXs/2iTHaP85Wcp4qI7ahFPLvrgDN/TxYATE87Md0+/NwYxY
 c94Z4Le4zUmzX3EH5K4zq+dZljNkQOYdh1Mrix1D/N+2oChyaYsiyCIkhVthcbnQkCafwbXW1
 4RAC1jhEThq8snybHB4BqwUyyku+Ew29THwsBCu/ZnFwM/M29tpjF3hEbFuUoFjUORnD03Vek
 rwkgMd0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-01 at 14:22 -0400, Rik van Riel wrote:
> On Fri, 2018-06-01 at 08:11 -0700, Andy Lutomirski wrote:
> > On Fri, Jun 1, 2018 at 5:28 AM Rik van Riel <riel@surriel.com> wrote:
> > > 
> > > Song noticed switch_mm_irqs_off taking a lot of CPU time in recent
> > > kernels,using 2.4% of a 48 CPU system during a netperf to localhost
> > > run.
> > > Digging into the profile, we noticed that cpumask_clear_cpu and
> > > cpumask_set_cpu together take about half of the CPU time taken by
> > > switch_mm_irqs_off.
> > > 
> > > However, the CPUs running netperf end up switching back and forth
> > > between netperf and the idle task, which does not require changes
> > > to the mm_cpumask. Furthermore, the init_mm cpumask ends up being
> > > the most heavily contended one in the system.`
> > > 
> > > Skipping cpumask_clear_cpu and cpumask_set_cpu for init_mm
> > > (mostly the idle task) reduced CPU use of switch_mm_irqs_off
> > > from 2.4% of the CPU to 1.9% of the CPU, with the following
> > > netperf commandline:
> > 
> > I'm conceptually fine with this change.  Does mm_cpumask(&init_mm)
> > end
> > up in a deterministic state?
> 
> Given that we do not touch mm_cpumask(&init_mm)
> any more, and that bitmask never appears to be
> used for things like tlb shootdowns (kernel TLB
> shootdowns simply go to everybody), I suspect
> it ends up in whatever state it is initialized
> to on startup.
> 
> I had not looked into this much, because it does
> not appear to be used for anything.
> 
> > Mike, depending on exactly what's going on with your benchmark, this
> > might help recover a bit of your performance, too.
> 
> It will be interesting to know how this change
> impacts others.

previous pipe-test numbers
4.13.16         2.024978 usecs/loop -- avg 2.045250 977.9 KHz
4.14.47         2.234518 usecs/loop -- avg 2.227716 897.8 KHz
4.15.18         2.287815 usecs/loop -- avg 2.295858 871.1 KHz
4.16.13         2.286036 usecs/loop -- avg 2.279057 877.6 KHz
4.17.0.g88a8676 2.288231 usecs/loop -- avg 2.288917 873.8 KHz

new numbers
4.17.0.g0512e01 2.268629 usecs/loop -- avg 2.269493 881.3 KHz
4.17.0.g0512e01 2.035401 usecs/loop -- avg 2.038341 981.2 KHz +andy
4.17.0.g0512e01 2.238701 usecs/loop -- avg 2.231828 896.1 KHz -andy+rik

There might be something there with your change Rik, but it's small
enough to be wary of variance.  Andy's "invert the return of
tlb_defer_switch_to_init_mm()" is OTOH pretty clear.

	-Mike
