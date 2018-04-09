Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeDIQT6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:19:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753069AbeDIQTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:19:55 -0400
Date: Mon, 9 Apr 2018 09:20:50 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        syzbot <syzbot+2dbc55da20fa246378fd@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs@googlegroups.com, Peter Zijlstra <peterz@infradead.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: INFO: task hung in perf_trace_event_unreg
Reply-To: paulmck@linux.vnet.ibm.com
References: <0000000000003b5a780568da18cf@google.com>
 <20180402094040.5b6f2ace@gandalf.local.home>
 <20180402153332.GM3948@linux.vnet.ibm.com>
 <CACT4Y+brGUyXsogDsSAakSFq=bh+136JptfS_=sBqkQA1Pc=tQ@mail.gmail.com>
 <20180402162135.GW3948@linux.vnet.ibm.com>
 <CACT4Y+Yq1Pus2QjLprJ6Hb=nqNtAME419-SYDzbFoXKBsNpPRA@mail.gmail.com>
 <20180402163912.GY3948@linux.vnet.ibm.com>
 <CACT4Y+Z+PFu8gRSb5Q_nTnvc6uz=-NzcT6numxzDXcmC2dDRFQ@mail.gmail.com>
 <20180402172325.GZ3948@linux.vnet.ibm.com>
 <CACT4Y+Zx4R9EEUkRA_sFb0d5gEtWicFArBisy9bWK6Lnfqdovw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACT4Y+Zx4R9EEUkRA_sFb0d5gEtWicFArBisy9bWK6Lnfqdovw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18040916-0040-0000-0000-00000413E333
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008824; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01015449; UDB=6.00517763; IPR=6.00794699;
 MB=3.00020488; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-09 16:19:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040916-0041-0000-0000-00000814FC8A
Message-Id: <20180409162050.GH3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804090168
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 02:54:20PM +0200, Dmitry Vyukov wrote:
> On Mon, Apr 2, 2018 at 7:23 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >> >> >> >>
> >> >> >> >> > Hello,
> >> >> >> >> >
> >> >> >> >> > syzbot hit the following crash on upstream commit
> >> >> >> >> > 0adb32858b0bddf4ada5f364a84ed60b196dbcda (Sun Apr 1 21:20:27 2018 +0000)
> >> >> >> >> > Linux 4.16
> >> >> >> >> > syzbot dashboard link:
> >> >> >> >> > https://syzkaller.appspot.com/bug?extid=2dbc55da20fa246378fd
> >> >> >> >> >
> >> >> >> >> > Unfortunately, I don't have any reproducer for this crash yet.
> >> >> >> >> > Raw console output:
> >> >> >> >> > https://syzkaller.appspot.com/x/log.txt?id=5487937873510400
> >> >> >> >> > Kernel config:
> >> >> >> >> > https://syzkaller.appspot.com/x/.config?id=-2374466361298166459
> >> >> >> >> > compiler: gcc (GCC) 7.1.1 20170620
> >> >> >> >> >
> >> >> >> >> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> >> >> >> > Reported-by: syzbot+2dbc55da20fa246378fd@syzkaller.appspotmail.com
> >> >> >> >> > It will help syzbot understand when the bug is fixed. See footer for
> >> >> >> >> > details.
> >> >> >> >> > If you forward the report, please keep this part and the footer.
> >> >> >> >> >
> >> >> >> >> > REISERFS warning (device loop4): super-6502 reiserfs_getopt: unknown mount
> >> >> >> >> > option "g �;e�K�׫>pquota"
> >> >> >> >
> >> >> >> > Might not hurt to look into the above, though perhaps this is just syzkaller
> >> >> >> > playing around with mount options.
> >> >> >> >
> >> >> >> >> > INFO: task syz-executor3:10803 blocked for more than 120 seconds.
> >> >> >> >> >        Not tainted 4.16.0+ #10
> >> >> >> >> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >> >> >> >> > syz-executor3   D20944 10803   4492 0x80000002
> >> >> >> >> > Call Trace:
> >> >> >> >> >   context_switch kernel/sched/core.c:2862 [inline]
> >> >> >> >> >   __schedule+0x8fb/0x1ec0 kernel/sched/core.c:3440
> >> >> >> >> >   schedule+0xf5/0x430 kernel/sched/core.c:3499
> >> >> >> >> >   schedule_timeout+0x1a3/0x230 kernel/time/timer.c:1777
> >> >> >> >> >   do_wait_for_common kernel/sched/completion.c:86 [inline]
> >> >> >> >> >   __wait_for_common kernel/sched/completion.c:107 [inline]
> >> >> >> >> >   wait_for_common kernel/sched/completion.c:118 [inline]
> >> >> >> >> >   wait_for_completion+0x415/0x770 kernel/sched/completion.c:139
> >> >> >> >> >   __wait_rcu_gp+0x221/0x340 kernel/rcu/update.c:414
> >> >> >> >> >   synchronize_sched.part.64+0xac/0x100 kernel/rcu/tree.c:3212
> >> >> >> >> >   synchronize_sched+0x76/0xf0 kernel/rcu/tree.c:3213
> >> >> >> >>
> >> >> >> >> I don't think this is a perf issue. Looks like something is preventing
> >> >> >> >> rcu_sched from completing. If there's a CPU that is running in kernel
> >> >> >> >> space and never scheduling, that can cause this issue. Or if RCU
> >> >> >> >> somehow missed a transition into idle or user space.
> >> >> >> >
> >> >> >> > The RCU CPU stall warning below strongly supports this position ...
> >> >> >>
> >> >> >> I think this is this guy then:
> >> >> >>
> >> >> >> https://syzkaller.appspot.com/bug?id=17f23b094cd80df750e5b0f8982c521ee6bcbf40
> >> >> >>
> >> >> >> #syz dup: INFO: rcu detected stall in __process_echoes
> >> >> >
> >> >> > Seems likely to me!
> >> >> >
> >> >> >> Looking retrospectively at the various hang/stall bugs that we have, I
> >> >> >> think we need some kind of priority between them. I.e. we have rcu
> >> >> >> stalls, spinlock stalls, workqueue hangs, task hangs, silent machine
> >> >> >> hang and maybe something else. It would be useful if they fire
> >> >> >> deterministically according to priorities. If there is an rcu stall,
> >> >> >> that's always detected as CPU stall. Then if there is no RCU stall,
> >> >> >> but a workqueue stall, then that's always detected as workqueue stall,
> >> >> >> etc.
> >> >> >> Currently if we have an RCU stall (effectively CPU stall), that can be
> >> >> >> detected either RCU stall or a task hung, producing 2 different bug
> >> >> >> reports (which is bad).
> >> >> >> One can say that it's only a matter of tuning timeouts, but at least
> >> >> >> task hung detector has a problem that if you set timeout to X, it can
> >> >> >> detect hung anywhere between X and 2*X. And on one hand we need quite
> >> >> >> large timeout (a minute may not be enough), and on the other hand we
> >> >> >> can't wait for an hour just to make sure that the machine is indeed
> >> >> >> dead (these things happen every few minutes).
> >> >> >
> >> >> > I suppose that we could have a global variable that was set to the
> >> >> > priority of the complaint in question, which would suppress all
> >> >> > lower-priority complaints.  Might need to be opt-in, though -- I would
> >> >> > guess that not everyone is going to be happy with one complaint suppressing
> >> >> > others, especially given the possibility that the two complaints might
> >> >> > be about different things.
> >> >> >
> >> >> > Or did you have something more deft in mind?
> >> >>
> >> >>
> >> >> syzkaller generally looks only at the first report. One does not know
> >> >> if/when there will be a second one, or the second one can be induced
> >> >> by the first one, and we generally want clean reports on a non-tainted
> >> >> kernel. So we don't just need to suppress lower priority ones, we need
> >> >> to produce the right report first.
> >> >> I am thinking maybe setting:
> >> >>  - rcu stalls at 1.5 minutes
> >> >>  - workqueue stalls at 2 minutes
> >> >>  - task hungs at 2.5 minutes
> >> >>  - and no output whatsoever at 3 minutes
> >> >> Do I miss anything? I think at least spinlocks. Should they go before
> >> >> or after rcu?
> >> >
> >> > That is what I know of, but the Linux kernel being what it is, there is
> >> > probably something more out there.  If not now, in a few months.  The
> >> > RCU CPU stall timeout can be set on the kernel-boot command line, but
> >> > you probably already knew that.
> >>
> >> Well, it's all based solely on a large number of patches and stopgaps.
> >> If we fix main problems for today, it's already good.
> >
> > Fair enough!
> >
> >> > Just for comparison, back in DYNIX/ptx days the RCU CPU stall timeout
> >> > was 1.5 -seconds-.  ;-)
> >>
> >> Have you tried to instrument every basic block with a function call to
> >> collect coverage, check every damn memory access for validity, enable
> >> all thinkable and unthinkable debug configs and put the insanest load
> >> one can imagine from a swarm of parallel threads? It makes things a
> >> bit slower ;)
> >
> > Given that we wouldn't have had enough CPU or memory to accommodate
> > all of that back in DYNIX/ptx days, I am forced to answer "no".  ;-)
> >
> >> >> This will require fixing task hung. Have not yet looked at workqueue detector.
> >> >> Does at least RCU respect the given timeout more or less precisely?
> >> >
> >> > Assuming that there is at least one CPU capable of taking scheduling-clock
> >> > interrupts, it should respect the timeout to within a few jiffies.
> 
> 
> Hi Paul,
> 
> Speaking of stalls and rcu, we are seeing lots of crashes that go like this:
> 
> INFO: rcu_sched self-detected stall on CPU[  404.992530] INFO:
> rcu_sched detected stalls on CPUs/tasks:
> INFO: rcu_sched self-detected stall on CPU[  454.347448] INFO:
> rcu_sched detected stalls on CPUs/tasks:
> INFO: rcu_sched self-detected stall on CPU[  396.073634] INFO:
> rcu_sched detected stalls on CPUs/tasks:
> 
> or like this:
> 
> INFO: rcu_sched self-detected stall on CPU
> INFO: rcu_sched detected stalls on CPUs/tasks:
> 0-....: (125000 ticks this GP) idle=0ba/1/4611686018427387906
> softirq=57641/57641 fqs=31151
> 0-....: (125000 ticks this GP) idle=0ba/1/4611686018427387906
> softirq=57641/57641 fqs=31151
>  (t=125002 jiffies g=31656 c=31655 q=910)
> 
>  INFO: rcu_sched self-detected stall on CPU
> INFO: rcu_sched detected stalls on CPUs/tasks:
> 0-....: (125000 ticks this GP) idle=49a/1/4611686018427387906
> softirq=65194/65194 fqs=31231
> 0-....: (125000 ticks this GP) idle=49a/1/4611686018427387906
> softirq=65194/65194 fqs=31231
>  (t=125002 jiffies g=34421 c=34420 q=1119)
> (detected by 1, t=125002 jiffies, g=34421, c=34420, q=1119)
> 
> 
> and then there is an unintelligible mess of 2 reports. Such crashes go
> to trash bin, because we can't even say which function hanged. It
> seems that in all cases 2 different rcu stall detection facilities
> race with each other. Is it possible to make them not race?

How about the following (untested, not for mainline) patch?  It suppresses
all but the "main" RCU flavor, which is rcu_sched for !PREEMPT builds and
rcu_preempt otherwise.  Either way, this is the RCU flavor corresponding
to synchronize_rcu().  This works well in the common case where there
is almost always an RCU grace period in flight.

One reason that this patch is not for mainline is that I am working on
merging the RCU-bh, RCU-preempt, and RCU-sched flavors into one thing,
at which point there won't be any races.  But that might be a couple
merge windows away from now.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 381b47a68ac6..31f7818f2d63 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1552,7 +1552,7 @@ static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
 	struct rcu_node *rnp;
 
 	if ((rcu_cpu_stall_suppress && !rcu_kick_kthreads) ||
-	    !rcu_gp_in_progress(rsp))
+	    !rcu_gp_in_progress(rsp) || rsp != rcu_state_p)
 		return;
 	rcu_stall_kick_kthreads(rsp);
 	j = jiffies;
