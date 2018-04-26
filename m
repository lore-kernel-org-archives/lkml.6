Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756763AbeDZPsk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:48:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756519AbeDZPsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:48:36 -0400
Date: Thu, 26 Apr 2018 08:49:44 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Joel Fernandes <joelaf@google.com>, rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>, fweisbec <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        baohong liu <baohong.liu@intel.com>,
        vedang patel <vedang.patel@intel.com>,
        kernel-team <kernel-team@lge.com>
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you
 can
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180423172244.694dbc9d@gandalf.local.home>
 <849066633.939.1524612064698.JavaMail.zimbra@efficios.com>
 <68e4c123-a223-5e26-e57a-da2515041bf3@google.com>
 <20180425001049.GX26088@linux.vnet.ibm.com>
 <20180425042056.GA21412@linux.vnet.ibm.com>
 <CAJWu+orWC=W0Jn2Jo7f+u5mbHMi+D1yuCmhD-xSgjWZ6Ynw32Q@mail.gmail.com>
 <1267842641.1791.1524692456344.JavaMail.zimbra@efficios.com>
 <CAJWu+oq7dqn4PEySyrrETaGNg4TsJvHobu=UdMEves+V3fgVZQ@mail.gmail.com>
 <2099399401.1995.1524755596613.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2099399401.1995.1524755596613.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042615-0036-0000-0000-000002EAB2E5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008926; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01023592; UDB=6.00522556; IPR=6.00802823;
 MB=3.00020793; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-26 15:48:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042615-0037-0000-0000-0000442048F6
Message-Id: <20180426154944.GF26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-26_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804260149
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 11:13:16AM -0400, Mathieu Desnoyers wrote:
> ----- On Apr 25, 2018, at 7:13 PM, Joel Fernandes joelaf@google.com wrote:
> 
> > Hi Mathieu,
> > 
> > On Wed, Apr 25, 2018 at 2:40 PM, Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >> ----- On Apr 25, 2018, at 5:27 PM, Joel Fernandes joelaf@google.com wrote:
> >>
> >>> On Tue, Apr 24, 2018 at 9:20 PM, Paul E. McKenney
> >>> <paulmck@linux.vnet.ibm.com> wrote:
> >>> [..]
> >>>>> >
> >>>>> > Sounds good, thanks.
> >>>>> >
> >>>>> > Also I found the reason for my boot issue. It was because the
> >>>>> > init_srcu_struct in the prototype was being done in an initcall.
> >>>>> > Instead if I do it in start_kernel before the tracepoint is used, it
> >>>>> > fixes it (although I don't know if this is dangerous to do like this
> >>>>> > but I can get it to boot atleast.. Let me know if this isn't the
> >>>>> > right way to do it, or if something else could go wrong)
> >>>>> >
> >>>>> > diff --git a/init/main.c b/init/main.c
> >>>>> > index 34823072ef9e..ecc88319c6da 100644
> >>>>> > --- a/init/main.c
> >>>>> > +++ b/init/main.c
> >>>>> > @@ -631,6 +631,7 @@ asmlinkage __visible void __init start_kernel(void)
> >>>>> >         WARN(!irqs_disabled(), "Interrupts were enabled early\n");
> >>>>> >         early_boot_irqs_disabled = false;
> >>>>> >
> >>>>> > +       init_srcu_struct(&tracepoint_srcu);
> >>>>> >         lockdep_init_early();
> >>>>> >
> >>>>> >         local_irq_enable();
> >>>>> > --
> >>>>> >
> >>>>> > I benchmarked it and the performance also looks quite good compared
> >>>>> > to the rcu tracepoint version.
> >>>>> >
> >>>>> > If you, Paul and other think doing the init_srcu_struct like this
> >>>>> > should be Ok, then I can try to work more on your srcu prototype and
> >>>>> > roll into my series and post them in the next RFC series (or let me
> >>>>> > know if you wanted to work your srcu stuff in a separate series..).
> >>>>>
> >>>>> That is definitely not what I was expecting, but let's see if it works
> >>>>> anyway...  ;-)
> >>>>>
> >>>>> But first, I was instead expecting something like this:
> >>>>>
> >>>>> DEFINE_SRCU(tracepoint_srcu);
> >>>>>
> >>>>> With this approach, some of the initialization happens at compile time
> >>>>> and the rest happens at the first call_srcu().
> >>>>>
> >>>>> This will work -only- if the first call_srcu() doesn't happen until after
> >>>>> workqueue_init_early() has been invoked.  Which I believe must have been
> >>>>> the case in your testing, because otherwise it looks like __call_srcu()
> >>>>> would have complained bitterly.
> >>>>>
> >>>>> On the other hand, if you need to invoke call_srcu() before the call
> >>>>> to workqueue_init_early(), then you need the patch that I am beating
> >>>>> into shape.  Plus you would need to use DEFINE_SRCU() and to avoid
> >>>>> invoking init_srcu_struct().
> >>>>
> >>>> And here is the patch.  I do not intend to send it upstream unless it
> >>>> actually proves necessary, and it appears that current SRCU does what
> >>>> you need.
> >>>>
> >>>> You would only need this patch if you wanted to invoke call_srcu()
> >>>> before workqueue_init_early() was called, which does not seem likely.
> >>>
> >>> Cool. So I was chatting with Paul and just to update everyone as well,
> >>> I tried the DEFINE_SRCU instead of the late init_srcu_struct call and
> >>> can make it past boot too (thanks Paul!). Also I don't see a reason we
> >>> need the RCU callback to execute early and its fine if it runs later.
> >>>
> >>> Also, I was thinking of introducing a separate trace_*event*_srcu API
> >>> as a replacement to the _rcuidle API. Then I can make use of it for my
> >>> tracepoints, and then later can use it for the other tracepoints
> >>> needing _rcuidle. After that we can finally get rid of the _rcuidle
> >>> API if there are no other users of it. This is just a rough plan, but
> >>> let me know if there's any issue with this plan that you can think
> >>> off.
> >>> IMO, I believe its simpler if the caller worries about whether it can
> >>> tolerate if tracepoint probes can block or not, than making it a
> >>> property of the tracepoint. That would also simplify the patch to
> >>> introduce srcu and keep the tracepoint creation API simple and less
> >>> confusing, but let me know if I'm missing something about this.
> >>
> >> One problem with your approach is that you can have multiple callers
> >> for the same tracepoint name, where some could be non-preemptible and
> >> others blocking. Also, there is then no clear way for the callback
> > 
> > Shouldn't it be responsibility of the caller to make sure it calls
> > correct API? So if you're wanting to allow probes to block, then you'd
> > call trace*blocking, if not then you don't. So the caller side can
> > just always do the right thing. That's a caller side issue.
> 
> The issue there is that tracepoint.c has APIs both for instrumentation
> and for registration of probe providers (callbacks). I want tracepoint.c
> to provide guarantees that it won't connect incompatible probes and
> callsites together.
> 
> > 
> >>
> >> Regarding the name, I'm OK with having something along the lines of
> >> trace_*event*_blocking or such. Please don't use "srcu" or other naming
> >> that is explicitly tied to the underlying mechanism used internally
> >> however: what we want to convey is that this specific tracepoint probe
> > 
> > Problem is that _blocking isn't the right word either. In my IRQ trace
> > point case, it will look something like this then:
> > 
> > local_irq_disable();
> > // IRQs are now off.
> > trace_irq_disable_blocking(..);
> > 
> > This wouldn't make sense. What we really want is to use the SRCU
> > implementation so that its low overhead...
> > 
> > So it would be something like:
> > 
> > local_irq_disable();
> > // IRQs are now off.
> > trace_irq_disable_srcu(..);
> > 
> > I also Ok if, as Paul was saying in his last email, that just for
> > _rcuidle, we use SRCU so that we don't have to do the rcu_enter_irq
> > stuff. Or we kill the _rcuidle API completely and use _srcu for those
> > users instead. We already have 1 implementation specific name anyway
> > (rcuidle), we're just replacing it with another one. If in the future,
> > if we want to change that name we can always do so (Also if you will,
> > correcting the existing already bad naming is a different problem and
> > we're not making it any worse tbh).
> 
> Using SRCU rather than the sched-rcu tracepoint synchronization in your
> use-case it caused by a limitation of sched-rcu: it cannot be efficiently
> used within idle code. So you don't care about the "can_sleep" property
> of SRCU. You could event mix SRCU and sched-rcu callsites for the same
> probe name, and it would be perfectly valid.
> 
> So even though both "can_sleep" and "rcuidle" caller variants would end
> up using SRCU under the hood, each can have its own caller API, e.g.:
> 
> * trace_<event>() -> only non-sleeping probes can register to those.
>                      Uses sched-rcu under the hood.
> 
> * trace_<event>_can_sleep() -> both sleeping and non-sleeping probes can
>                                register to those. Uses SRCU under the hood.
> 
> * trace_<event>_rcuidle() -> only non-sleeping probes can register to those,
>                              uses SRCU under the hood.

Of these, only trace_<event>() may be used from NMI handlers.  We should
have a WARN_ON_ONCE(in_nmi()) in any of the ones using SRCU under the
hood.  Yes, I would be surprised if there are tracepoints in functions
invoked both from idle and from NMI handlers, but I have been surprised
before.  And it is much nicer to get surprised by a splat than by weird
hangs or silent data corruption.  ;-)

							Thanx, Paul

> >> can be preempted and block. The underlying implementation could move to
> >> a different RCU flavor brand in the future, and it should not impact
> >> users of the tracepoint APIs.
> >>
> >> In order to ensure that probes that may block only register themselves
> >> to tracepoints that allow blocking, we should introduce new tracepoint
> >> declaration/definition *and* registration APIs also contain the
> >> "BLOCKING/blocking" keywords (or such), so we can ensure that a
> >> tracepoint probe being registered to a "blocking" tracepoint is indeed
> >> allowed to block.
> > 
> > I feel this problem you're describing is slightly out of the scope of
> > the issues we're talking about, I think. Even right now, someone can
> > write a callback that blocks and then bad things will happen. If I
> > understand correctly, all callbacks right now will execute in a
> > preempt disabled section because of rcu_read_lock_sched. So we already
> > have a problem (without the SRCU changes) that if a callback blocks,
> > then we'll have hard to diagnose sleeping while atomic issues. Sorry
> > if I missed your point.
> 
> The current situation is that no callback whatsoever can sleep. If we
> introduce an API allowing some callbacks to sleep, I want to make sure
> we don't end up registering sleepable callbacks to non-preemptible callsites.
> Considering that the callback can be provided by a kernel module whereas the
> callsite is within the kernel, having this kind of correctness validation
> within tracepoint.c appears important.
> 
> Thanks!
> 
> Mathieu
> 
> 
> > 
> > thanks,
> > 
> > - Joel
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
