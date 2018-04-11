Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757296AbeDKTfX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:35:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1757062AbeDKTfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:35:20 -0400
Date: Wed, 11 Apr 2018 12:36:19 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        syzbot <syzbot+2dbc55da20fa246378fd@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: INFO: task hung in perf_trace_event_unreg
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180402163912.GY3948@linux.vnet.ibm.com>
 <CACT4Y+Z+PFu8gRSb5Q_nTnvc6uz=-NzcT6numxzDXcmC2dDRFQ@mail.gmail.com>
 <20180402172325.GZ3948@linux.vnet.ibm.com>
 <CACT4Y+Zx4R9EEUkRA_sFb0d5gEtWicFArBisy9bWK6Lnfqdovw@mail.gmail.com>
 <20180409162050.GH3948@linux.vnet.ibm.com>
 <CACT4Y+bbaih8hym_n4D5dzDF3ig53+a5XLN0+btATPfmXZAZ7A@mail.gmail.com>
 <20180409181104.GM3948@linux.vnet.ibm.com>
 <CACT4Y+b95OxNFNBMcgHw-LAid2nNBPSYcG=4tyg7z5DinE7bRw@mail.gmail.com>
 <20180410170205.GW3948@linux.vnet.ibm.com>
 <CACT4Y+aR4cVS8+096MmkxPAUiFZPhhQDa5OUiXH+OS57-3Ucqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACT4Y+aR4cVS8+096MmkxPAUiFZPhhQDa5OUiXH+OS57-3Ucqw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18041119-0036-0000-0000-000002DF882D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008838; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01016474; UDB=6.00518372; IPR=6.00795721;
 MB=3.00020523; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-11 19:35:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041119-0037-0000-0000-000043F1D845
Message-Id: <20180411193619.GW3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804110181
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 12:06:27PM +0200, Dmitry Vyukov wrote:
> On Tue, Apr 10, 2018 at 7:02 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >> >> >> On Mon, Apr 2, 2018 at 7:23 PM, Paul E. McKenney
> >> >> >> <paulmck@linux.vnet.ibm.com> wrote:
> >> >> >> >> >> >> >>
> >> >> >> >> >> >> >> > Hello,
> >> >> >> >> >> >> >> >
> >> >> >> >> >> >> >> > syzbot hit the following crash on upstream commit
> >> >> >> >> >> >> >> > 0adb32858b0bddf4ada5f364a84ed60b196dbcda (Sun Apr 1 21:20:27 2018 +0000)
> >> >> >> >> >> >> >> > Linux 4.16
> >> >> >> >> >> >> >> > syzbot dashboard link:
> >> >> >> >> >> >> >> > https://syzkaller.appspot.com/bug?extid=2dbc55da20fa246378fd
> >> >> >> >> >> >> >> >
> >> >> >> >> >> >> >> > Unfortunately, I don't have any reproducer for this crash yet.
> >> >> >> >> >> >> >> > Raw console output:
> >> >> >> >> >> >> >> > https://syzkaller.appspot.com/x/log.txt?id=5487937873510400
> >> >> >> >> >> >> >> > Kernel config:
> >> >> >> >> >> >> >> > https://syzkaller.appspot.com/x/.config?id=-2374466361298166459
> >> >> >> >> >> >> >> > compiler: gcc (GCC) 7.1.1 20170620
> >> >> >> >> >> >> >> >
> >> >> >> >> >> >> >> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> >> >> >> >> >> >> > Reported-by: syzbot+2dbc55da20fa246378fd@syzkaller.appspotmail.com
> >> >> >> >> >> >> >> > It will help syzbot understand when the bug is fixed. See footer for
> >> >> >> >> >> >> >> > details.
> >> >> >> >> >> >> >> > If you forward the report, please keep this part and the footer.
> >> >> >> >> >> >> >> >
> >> >> >> >> >> >> >> > REISERFS warning (device loop4): super-6502 reiserfs_getopt: unknown mount
> >> >> >> >> >> >> >> > option "g �;e�K�׫>pquota"
> >> >> >> >> >> >> >
> >> >> >> >> >> >> > Might not hurt to look into the above, though perhaps this is just syzkaller
> >> >> >> >> >> >> > playing around with mount options.
> >> >> >> >> >> >> >
> >> >> >> >> >> >> >> > INFO: task syz-executor3:10803 blocked for more than 120 seconds.
> >> >> >> >> >> >> >> >        Not tainted 4.16.0+ #10
> >> >> >> >> >> >> >> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >> >> >> >> >> >> >> > syz-executor3   D20944 10803   4492 0x80000002
> >> >> >> >> >> >> >> > Call Trace:
> >> >> >> >> >> >> >> >   context_switch kernel/sched/core.c:2862 [inline]
> >> >> >> >> >> >> >> >   __schedule+0x8fb/0x1ec0 kernel/sched/core.c:3440
> >> >> >> >> >> >> >> >   schedule+0xf5/0x430 kernel/sched/core.c:3499
> >> >> >> >> >> >> >> >   schedule_timeout+0x1a3/0x230 kernel/time/timer.c:1777
> >> >> >> >> >> >> >> >   do_wait_for_common kernel/sched/completion.c:86 [inline]
> >> >> >> >> >> >> >> >   __wait_for_common kernel/sched/completion.c:107 [inline]
> >> >> >> >> >> >> >> >   wait_for_common kernel/sched/completion.c:118 [inline]
> >> >> >> >> >> >> >> >   wait_for_completion+0x415/0x770 kernel/sched/completion.c:139
> >> >> >> >> >> >> >> >   __wait_rcu_gp+0x221/0x340 kernel/rcu/update.c:414
> >> >> >> >> >> >> >> >   synchronize_sched.part.64+0xac/0x100 kernel/rcu/tree.c:3212
> >> >> >> >> >> >> >> >   synchronize_sched+0x76/0xf0 kernel/rcu/tree.c:3213
> >> >> >> >> >> >> >>
> >> >> >> >> >> >> >> I don't think this is a perf issue. Looks like something is preventing
> >> >> >> >> >> >> >> rcu_sched from completing. If there's a CPU that is running in kernel
> >> >> >> >> >> >> >> space and never scheduling, that can cause this issue. Or if RCU
> >> >> >> >> >> >> >> somehow missed a transition into idle or user space.
> >> >> >> >> >> >> >
> >> >> >> >> >> >> > The RCU CPU stall warning below strongly supports this position ...
> >> >> >> >> >> >>
> >> >> >> >> >> >> I think this is this guy then:
> >> >> >> >> >> >>
> >> >> >> >> >> >> https://syzkaller.appspot.com/bug?id=17f23b094cd80df750e5b0f8982c521ee6bcbf40
> >> >> >> >> >> >>
> >> >> >> >> >> >> #syz dup: INFO: rcu detected stall in __process_echoes
> >> >> >> >> >> >
> >> >> >> >> >> > Seems likely to me!
> >> >> >> >> >> >
> >> >> >> >> >> >> Looking retrospectively at the various hang/stall bugs that we have, I
> >> >> >> >> >> >> think we need some kind of priority between them. I.e. we have rcu
> >> >> >> >> >> >> stalls, spinlock stalls, workqueue hangs, task hangs, silent machine
> >> >> >> >> >> >> hang and maybe something else. It would be useful if they fire
> >> >> >> >> >> >> deterministically according to priorities. If there is an rcu stall,
> >> >> >> >> >> >> that's always detected as CPU stall. Then if there is no RCU stall,
> >> >> >> >> >> >> but a workqueue stall, then that's always detected as workqueue stall,
> >> >> >> >> >> >> etc.
> >> >> >> >> >> >> Currently if we have an RCU stall (effectively CPU stall), that can be
> >> >> >> >> >> >> detected either RCU stall or a task hung, producing 2 different bug
> >> >> >> >> >> >> reports (which is bad).
> >> >> >> >> >> >> One can say that it's only a matter of tuning timeouts, but at least
> >> >> >> >> >> >> task hung detector has a problem that if you set timeout to X, it can
> >> >> >> >> >> >> detect hung anywhere between X and 2*X. And on one hand we need quite
> >> >> >> >> >> >> large timeout (a minute may not be enough), and on the other hand we
> >> >> >> >> >> >> can't wait for an hour just to make sure that the machine is indeed
> >> >> >> >> >> >> dead (these things happen every few minutes).
> >> >> >> >> >> >
> >> >> >> >> >> > I suppose that we could have a global variable that was set to the
> >> >> >> >> >> > priority of the complaint in question, which would suppress all
> >> >> >> >> >> > lower-priority complaints.  Might need to be opt-in, though -- I would
> >> >> >> >> >> > guess that not everyone is going to be happy with one complaint suppressing
> >> >> >> >> >> > others, especially given the possibility that the two complaints might
> >> >> >> >> >> > be about different things.
> >> >> >> >> >> >
> >> >> >> >> >> > Or did you have something more deft in mind?
> >> >> >> >> >>
> >> >> >> >> >>
> >> >> >> >> >> syzkaller generally looks only at the first report. One does not know
> >> >> >> >> >> if/when there will be a second one, or the second one can be induced
> >> >> >> >> >> by the first one, and we generally want clean reports on a non-tainted
> >> >> >> >> >> kernel. So we don't just need to suppress lower priority ones, we need
> >> >> >> >> >> to produce the right report first.
> >> >> >> >> >> I am thinking maybe setting:
> >> >> >> >> >>  - rcu stalls at 1.5 minutes
> >> >> >> >> >>  - workqueue stalls at 2 minutes
> >> >> >> >> >>  - task hungs at 2.5 minutes
> >> >> >> >> >>  - and no output whatsoever at 3 minutes
> >> >> >> >> >> Do I miss anything? I think at least spinlocks. Should they go before
> >> >> >> >> >> or after rcu?
> >> >> >> >> >
> >> >> >> >> > That is what I know of, but the Linux kernel being what it is, there is
> >> >> >> >> > probably something more out there.  If not now, in a few months.  The
> >> >> >> >> > RCU CPU stall timeout can be set on the kernel-boot command line, but
> >> >> >> >> > you probably already knew that.
> >> >> >> >>
> >> >> >> >> Well, it's all based solely on a large number of patches and stopgaps.
> >> >> >> >> If we fix main problems for today, it's already good.
> >> >> >> >
> >> >> >> > Fair enough!
> >> >> >> >
> >> >> >> >> > Just for comparison, back in DYNIX/ptx days the RCU CPU stall timeout
> >> >> >> >> > was 1.5 -seconds-.  ;-)
> >> >> >> >>
> >> >> >> >> Have you tried to instrument every basic block with a function call to
> >> >> >> >> collect coverage, check every damn memory access for validity, enable
> >> >> >> >> all thinkable and unthinkable debug configs and put the insanest load
> >> >> >> >> one can imagine from a swarm of parallel threads? It makes things a
> >> >> >> >> bit slower ;)
> >> >> >> >
> >> >> >> > Given that we wouldn't have had enough CPU or memory to accommodate
> >> >> >> > all of that back in DYNIX/ptx days, I am forced to answer "no".  ;-)
> >> >> >> >
> >> >> >> >> >> This will require fixing task hung. Have not yet looked at workqueue detector.
> >> >> >> >> >> Does at least RCU respect the given timeout more or less precisely?
> >> >> >> >> >
> >> >> >> >> > Assuming that there is at least one CPU capable of taking scheduling-clock
> >> >> >> >> > interrupts, it should respect the timeout to within a few jiffies.
> >> >> >>
> >> >> >>
> >> >> >> Hi Paul,
> >> >> >>
> >> >> >> Speaking of stalls and rcu, we are seeing lots of crashes that go like this:
> >> >> >>
> >> >> >> INFO: rcu_sched self-detected stall on CPU[  404.992530] INFO:
> >> >> >> rcu_sched detected stalls on CPUs/tasks:
> >> >> >> INFO: rcu_sched self-detected stall on CPU[  454.347448] INFO:
> >> >> >> rcu_sched detected stalls on CPUs/tasks:
> >> >> >> INFO: rcu_sched self-detected stall on CPU[  396.073634] INFO:
> >> >> >> rcu_sched detected stalls on CPUs/tasks:
> >> >> >>
> >> >> >> or like this:
> >> >> >>
> >> >> >> INFO: rcu_sched self-detected stall on CPU
> >> >> >> INFO: rcu_sched detected stalls on CPUs/tasks:
> >> >> >> 0-....: (125000 ticks this GP) idle=0ba/1/4611686018427387906
> >> >> >> softirq=57641/57641 fqs=31151
> >> >> >> 0-....: (125000 ticks this GP) idle=0ba/1/4611686018427387906
> >> >> >> softirq=57641/57641 fqs=31151
> >> >> >>  (t=125002 jiffies g=31656 c=31655 q=910)
> >> >> >>
> >> >> >>  INFO: rcu_sched self-detected stall on CPU
> >> >> >> INFO: rcu_sched detected stalls on CPUs/tasks:
> >> >> >> 0-....: (125000 ticks this GP) idle=49a/1/4611686018427387906
> >> >> >> softirq=65194/65194 fqs=31231
> >> >> >> 0-....: (125000 ticks this GP) idle=49a/1/4611686018427387906
> >> >> >> softirq=65194/65194 fqs=31231
> >> >> >>  (t=125002 jiffies g=34421 c=34420 q=1119)
> >> >> >> (detected by 1, t=125002 jiffies, g=34421, c=34420, q=1119)
> >> >> >>
> >> >> >>
> >> >> >> and then there is an unintelligible mess of 2 reports. Such crashes go
> >> >> >> to trash bin, because we can't even say which function hanged. It
> >> >> >> seems that in all cases 2 different rcu stall detection facilities
> >> >> >> race with each other. Is it possible to make them not race?
> >> >> >
> >> >> > How about the following (untested, not for mainline) patch?  It suppresses
> >> >> > all but the "main" RCU flavor, which is rcu_sched for !PREEMPT builds and
> >> >> > rcu_preempt otherwise.  Either way, this is the RCU flavor corresponding
> >> >> > to synchronize_rcu().  This works well in the common case where there
> >> >> > is almost always an RCU grace period in flight.
> >> >> >
> >> >> > One reason that this patch is not for mainline is that I am working on
> >> >> > merging the RCU-bh, RCU-preempt, and RCU-sched flavors into one thing,
> >> >> > at which point there won't be any races.  But that might be a couple
> >> >> > merge windows away from now.
> >> >> >
> >> >> >                                                         Thanx, Paul
> >> >> >
> >> >> > ------------------------------------------------------------------------
> >> >> >
> >> >> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> >> > index 381b47a68ac6..31f7818f2d63 100644
> >> >> > --- a/kernel/rcu/tree.c
> >> >> > +++ b/kernel/rcu/tree.c
> >> >> > @@ -1552,7 +1552,7 @@ static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
> >> >> >         struct rcu_node *rnp;
> >> >> >
> >> >> >         if ((rcu_cpu_stall_suppress && !rcu_kick_kthreads) ||
> >> >> > -           !rcu_gp_in_progress(rsp))
> >> >> > +           !rcu_gp_in_progress(rsp) || rsp != rcu_state_p)
> >> >> >                 return;
> >> >> >         rcu_stall_kick_kthreads(rsp);
> >> >> >         j = jiffies;
> >> >>
> >> >> But doesn't they both relate to the same rcu flavor? They both say
> >> >> rcu_sched. I assumed that the difference is "self-detected" vs "on
> >> >> CPUs/tasks", i.e. on the current CPU vs on other CPUs.
> >> >
> >> > Right you are!
> >> >
> >> > One approach would be to increase the value of RCU_STALL_RAT_DELAY,
> >> > which is currently two jiffies to (say) 20 jiffies.  This is in
> >> > kernel/rcu/tree.h.  But this would fail on a sufficiently overloaded
> >> > system -- and the failure of the two-jiffy delay is a bit of a surprise,
> >> > given interrupts disabled and all that.  Are you by any chance loaded
> >> > heavily enough to see vCPU preemption?
> >> >
> >> > I could avoid at least some of these timing issues instead using cmpxchg()
> >> > on ->jiffies_stall to allow only one CPU in, but leave the non-atomic
> >> > update to discourage overly long stall prints from running into the
> >> > next one.  This is not perfect, either, and is roughly equivalent to
> >> > setting RCU_STALL_RAT_DELAY to many second's worth of jiffies, but
> >> > avoiding that minute's delay.  But it should get rid of the duplication
> >> > in almost all cases, though it could allow a stall warning to overlap
> >> > with a later stall warning for that same grace period.  Which can
> >> > already happen anyway.  Also, a tens-of-seconds vCPU preemption can
> >> > still cause concurrent stall warnings, but if that is happening to you,
> >> > the concurrent stall warnings are probably the least of your problems.
> >> > Besides, we do need at least one CPU to actually report the stall, which
> >> > won't happen if that CPU's vCPU is indefinitely preempted.  So there is
> >> > only so much I can do about that particular corner case.
> >> >
> >> > So how does the following (untested) patch work for you?
> >>
> >> Looks good to me.
> >>
> >> We run on VMs, so we can well have vCPU preemption.
> >
> > Very good!  Please do get me a Tested-by when you get to that point.
> 
> Unfortunately I don't have a good way to test it until it's submitted
> upstream. While we are seeing thousands of such instances, they happen
> episodically on a farm of test machines. But they are still harmful,
> especially when the system tries to reproduce a bug, because it's
> mid-way through and thinks it got a hook, but then suddenly boom! it
> gets some mess that it can't parse and now it does not know if it's
> still the same bug, or maybe a different bug triggered by the same
> program, so it does not know how to properly attribute the reproducer.
> You can see these cases as they happen here (under report/log links in
> the table):
> https://syzkaller.appspot.com/bug?id=d5bc3e0c66d200d72216ab343a67c4327e4a3452
> When the patch is submitted, the rate should go down.

OK, I will bite...  How do you test fixes to problems that syzkaller finds?

                                                        Thanx, Paul

> >> > ------------------------------------------------------------------------
> >> >
> >> > commit 6a5ab1e68f8636d8823bb5a9aee35fc44c2be866
> >> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >> > Date:   Mon Apr 9 11:04:46 2018 -0700
> >> >
> >> >     rcu: Exclude near-simultaneous RCU CPU stall warnings
> >> >
> >> >     There is a two-jiffy delay between the time that a CPU will self-report
> >> >     an RCU CPU stall warning and the time that some other CPU will report a
> >> >     warning on behalf of the first CPU.  This has worked well in the past,
> >> >     but on busy systems, it is possible for the two warnings to overlap,
> >> >     which makes interpreting them extremely difficult.
> >> >
> >> >     This commit therefore uses a cmpxchg-based timing decision that
> >> >     allows only one report in a given one-minute period (assuming default
> >> >     stall-warning Kconfig parameters).  This approach will of course fail
> >> >     if you are seeing minute-long vCPU preemption, but in that case the
> >> >     overlapping RCU CPU stall warnings are the least of your worries.
> >> >
> >> >     Reported-by: Dmitry Vyukov <dvyukov@google.com>
> >> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >> >
> >> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> > index 381b47a68ac6..b7246bcbf633 100644
> >> > --- a/kernel/rcu/tree.c
> >> > +++ b/kernel/rcu/tree.c
> >> > @@ -1429,8 +1429,6 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gpnum)
> >> >                 raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >> >                 return;
> >> >         }
> >> > -       WRITE_ONCE(rsp->jiffies_stall,
> >> > -                  jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
> >> >         raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >> >
> >> >         /*
> >> > @@ -1481,6 +1479,10 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gpnum)
> >> >                         sched_show_task(current);
> >> >                 }
> >> >         }
> >> > +       /* Rewrite if needed in case of slow consoles. */
> >> > +       if (ULONG_CMP_GE(jiffies, READ_ONCE(rsp->jiffies_stall)))
> >> > +               WRITE_ONCE(rsp->jiffies_stall,
> >> > +                          jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
> >> >
> >> >         rcu_check_gp_kthread_starvation(rsp);
> >> >
> >> > @@ -1525,6 +1527,7 @@ static void print_cpu_stall(struct rcu_state *rsp)
> >> >         rcu_dump_cpu_stacks(rsp);
> >> >
> >> >         raw_spin_lock_irqsave_rcu_node(rnp, flags);
> >> > +       /* Rewrite if needed in case of slow consoles. */
> >> >         if (ULONG_CMP_GE(jiffies, READ_ONCE(rsp->jiffies_stall)))
> >> >                 WRITE_ONCE(rsp->jiffies_stall,
> >> >                            jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
> >> > @@ -1548,6 +1551,7 @@ static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
> >> >         unsigned long gpnum;
> >> >         unsigned long gps;
> >> >         unsigned long j;
> >> > +       unsigned long jn;
> >> >         unsigned long js;
> >> >         struct rcu_node *rnp;
> >> >
> >> > @@ -1586,14 +1590,17 @@ static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
> >> >             ULONG_CMP_GE(gps, js))
> >> >                 return; /* No stall or GP completed since entering function. */
> >> >         rnp = rdp->mynode;
> >> > +       jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
> >> >         if (rcu_gp_in_progress(rsp) &&
> >> > -           (READ_ONCE(rnp->qsmask) & rdp->grpmask)) {
> >> > +           (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
> >> > +           cmpxchg(&rsp->jiffies_stall, js, jn) == js) {
> >> >
> >> >                 /* We haven't checked in, so go dump stack. */
> >> >                 print_cpu_stall(rsp);
> >> >
> >> >         } else if (rcu_gp_in_progress(rsp) &&
> >> > -                  ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY)) {
> >> > +                  ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
> >> > +                  cmpxchg(&rsp->jiffies_stall, js, jn) == js) {
> >> >
> >> >                 /* They had a few time units to dump stack, so complain. */
> >> >                 print_other_cpu_stall(rsp, gpnum);
> >> >
> >>
> >
> 
