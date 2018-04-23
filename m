Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754001AbeDWDS0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:18:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753925AbeDWDSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:18:21 -0400
Date: Sun, 22 Apr 2018 20:19:26 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>, kernel-team@lge.com
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you
 can
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180417040748.212236-1-joelaf@google.com>
 <20180417040748.212236-4-joelaf@google.com>
 <20180418180250.7b6038dddba46b37c94b796c@kernel.org>
 <20180419054302.GD13370@sejong>
 <CAJWu+ooK5jETwB-L37=8PX+A4ercM8BrVb6g23t7F_xYhH4BSw@mail.gmail.com>
 <CAJWu+opGN5+h4=ggKcQGnqG8h1LvtMjD_XQywU7=ULjjyS-v6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+opGN5+h4=ggKcQGnqG8h1LvtMjD_XQywU7=ULjjyS-v6w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042303-0048-0000-0000-000002618D42
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021903; UDB=6.00521545; IPR=6.00801139;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:18:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0049-0000-0000-000044DF8C26
Message-Id: <20180423031926.GF26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230034
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 06:14:18PM -0700, Joel Fernandes wrote:
> On Fri, Apr 20, 2018 at 12:07 AM, Joel Fernandes <joelaf@google.com> wrote:
> > Hi,
> >
> > Thanks Matsami and Namhyung for the suggestions!
> >
> > On Wed, Apr 18, 2018 at 10:43 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> >> On Wed, Apr 18, 2018 at 06:02:50PM +0900, Masami Hiramatsu wrote:
> >>> On Mon, 16 Apr 2018 21:07:47 -0700
> >>> Joel Fernandes <joelaf@google.com> wrote:
> >>>
> >>> > With TRACE_IRQFLAGS, we call trace_ API too many times. We don't need
> >>> > to if local_irq_restore or local_irq_save didn't actually do anything.
> >>> >
> >>> > This gives around a 4% improvement in performance when doing the
> >>> > following command: "time find / > /dev/null"
> >>> >
> >>> > Also its best to avoid these calls where possible, since in this series,
> >>> > the RCU code in tracepoint.h seems to be call these quite a bit and I'd
> >>> > like to keep this overhead low.
> >>>
> >>> Can we assume that the "flags" has only 1 bit irq-disable flag?
> >>> Since it skips calling raw_local_irq_restore(flags); too,
> >>
> >> I don't know how many it impacts on performance but maybe we can have
> >> an arch-specific config option something like below?
> >
> > The flags restoration I am hoping is "cheap" but I haven't measured
> > specifically the cost of this though.
> >
> >>
> >>
> >>> if there is any state in the flags on any arch, it may change the
> >>> result. In that case, we can do it as below (just skipping trace_hardirqs_*)
> >>>
> >>> int disabled = irqs_disabled();
> >>
> >>   if (disabled == raw_irqs_disabled_flags(flags)) {
> >> #ifndef CONFIG_ARCH_CAN_SKIP_NESTED_IRQ_RESTORE
> >>         raw_local_irq_restore(flags);
> >> #endif
> >>         return;
> >>   }
> >
> > Hmm, somehow I feel this part should be written generically enough
> > that it applies to all architectures (as a first step).
> >
> >>
> >>>
> >>> if (!raw_irqs_disabled_flags(flags) && disabled)
> >>>       trace_hardirqs_on();
> >>>
> >>> raw_local_irq_restore(flags);
> >>>
> >>> if (raw_irqs_disabled_flags(flags) && !disabled)
> >>>       trace_hardirqs_off();
> >
> > I like this idea since its a good thing to do the flag restoration
> > just to be safe and preserve the current behaviors. Also my goal was
> > to reduce the trace_ calls in this series, so its probably better I
> > just do as you're suggesting. I will do some experiments and make the
> > changes for the next series.
> 
> So about performance of this series..
> 
> lockdep hooking into tracepoint code is a bit heavy, compared to
> without this series. That's because of the design approach of
> IRQ on/off -> Trace point -> lockdep
> 
> Versus without this series which does
> IRQ on/off -> lockdep
> 
> So we lose performance because of that.
> 
> This particular patch improves the situation, as such so this
> particular patch is probably good to merge once we can test
> performance of Matsami's suggestion as well.
> 
> However, patch 4/4 which makes lockdep use the tracepoint causes a
> performance hit of around 8% of mean time when I run:
> hackbench -g 4 -f 2 -l 30000
> 
> I narrowed the performance hit down to the call to
> rcu_irq_enter_irqson() and rcu_irq_exit_irqson() in __DO_TRACE.
> Commenting these 2 functions brings the perf level back.
> 
> I was thinking about RCU usage here, and really we never change this
> particular performance-sensitive tracepoint's function table 99.9% of
> the time, so it seems there's quite in a win if we just had another
> read-mostly synchronization mechanism that doesn't do all the RCU
> tracking that's currently done here and such a mechanism can be
> simpler..
> 
> If I understand correctly, RCU also adds other complications such as
> that it can't be used from the idle path, that's why the
> rcu_irq_enter_* was added in the first place. Would be nice if we can
> just avoid these RCU calls for the preempt/irq tracepoints... Any
> thoughts about this or any other ideas to solve this?

In theory, the tracepoint code could use SRCU instead of RCU, given that
SRCU readers can be in the idle loop, although at the expense of a couple
of smp_mb() calls in each tracepoint.  In practice, I must defer to the
people who know the tracepoint code better than I.

							Thanx, Paul

> Meanwhile I'll also do some performance testing with Matsami's idea as well..
> 
> thanks,
> 
> - Joel
> 
