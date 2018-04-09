Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbeDIQ2k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:28:40 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:40168 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbeDIQ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:28:38 -0400
X-Google-Smtp-Source: AIpwx4+4ldp3ABfnumeN751kYPZobTKeQrjOCJvPCior6MueFN3gFHOzXqvsQ5inH7Yah/sSZshe4Qne8Wz666IHq8s=
MIME-Version: 1.0
In-Reply-To: <20180409162050.GH3948@linux.vnet.ibm.com>
References: <0000000000003b5a780568da18cf@google.com> <20180402094040.5b6f2ace@gandalf.local.home>
 <20180402153332.GM3948@linux.vnet.ibm.com> <CACT4Y+brGUyXsogDsSAakSFq=bh+136JptfS_=sBqkQA1Pc=tQ@mail.gmail.com>
 <20180402162135.GW3948@linux.vnet.ibm.com> <CACT4Y+Yq1Pus2QjLprJ6Hb=nqNtAME419-SYDzbFoXKBsNpPRA@mail.gmail.com>
 <20180402163912.GY3948@linux.vnet.ibm.com> <CACT4Y+Z+PFu8gRSb5Q_nTnvc6uz=-NzcT6numxzDXcmC2dDRFQ@mail.gmail.com>
 <20180402172325.GZ3948@linux.vnet.ibm.com> <CACT4Y+Zx4R9EEUkRA_sFb0d5gEtWicFArBisy9bWK6Lnfqdovw@mail.gmail.com>
 <20180409162050.GH3948@linux.vnet.ibm.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 9 Apr 2018 18:28:16 +0200
Message-ID: <CACT4Y+bbaih8hym_n4D5dzDF3ig53+a5XLN0+btATPfmXZAZ7A@mail.gmail.com>
Subject: Re: INFO: task hung in perf_trace_event_unreg
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        syzbot <syzbot+2dbc55da20fa246378fd@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs@googlegroups.com, Peter Zijlstra <peterz@infradead.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w39GSmCP018372

On Mon, Apr 9, 2018 at 6:20 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Mon, Apr 09, 2018 at 02:54:20PM +0200, Dmitry Vyukov wrote:
>> On Mon, Apr 2, 2018 at 7:23 PM, Paul E. McKenney
>> <paulmck@linux.vnet.ibm.com> wrote:
>> >> >> >> >>
>> >> >> >> >> > Hello,
>> >> >> >> >> >
>> >> >> >> >> > syzbot hit the following crash on upstream commit
>> >> >> >> >> > 0adb32858b0bddf4ada5f364a84ed60b196dbcda (Sun Apr 1 21:20:27 2018 +0000)
>> >> >> >> >> > Linux 4.16
>> >> >> >> >> > syzbot dashboard link:
>> >> >> >> >> > https://syzkaller.appspot.com/bug?extid=2dbc55da20fa246378fd
>> >> >> >> >> >
>> >> >> >> >> > Unfortunately, I don't have any reproducer for this crash yet.
>> >> >> >> >> > Raw console output:
>> >> >> >> >> > https://syzkaller.appspot.com/x/log.txt?id=5487937873510400
>> >> >> >> >> > Kernel config:
>> >> >> >> >> > https://syzkaller.appspot.com/x/.config?id=-2374466361298166459
>> >> >> >> >> > compiler: gcc (GCC) 7.1.1 20170620
>> >> >> >> >> >
>> >> >> >> >> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> >> >> >> >> > Reported-by: syzbot+2dbc55da20fa246378fd@syzkaller.appspotmail.com
>> >> >> >> >> > It will help syzbot understand when the bug is fixed. See footer for
>> >> >> >> >> > details.
>> >> >> >> >> > If you forward the report, please keep this part and the footer.
>> >> >> >> >> >
>> >> >> >> >> > REISERFS warning (device loop4): super-6502 reiserfs_getopt: unknown mount
>> >> >> >> >> > option "g �;e�K�׫>pquota"
>> >> >> >> >
>> >> >> >> > Might not hurt to look into the above, though perhaps this is just syzkaller
>> >> >> >> > playing around with mount options.
>> >> >> >> >
>> >> >> >> >> > INFO: task syz-executor3:10803 blocked for more than 120 seconds.
>> >> >> >> >> >        Not tainted 4.16.0+ #10
>> >> >> >> >> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> >> >> >> >> > syz-executor3   D20944 10803   4492 0x80000002
>> >> >> >> >> > Call Trace:
>> >> >> >> >> >   context_switch kernel/sched/core.c:2862 [inline]
>> >> >> >> >> >   __schedule+0x8fb/0x1ec0 kernel/sched/core.c:3440
>> >> >> >> >> >   schedule+0xf5/0x430 kernel/sched/core.c:3499
>> >> >> >> >> >   schedule_timeout+0x1a3/0x230 kernel/time/timer.c:1777
>> >> >> >> >> >   do_wait_for_common kernel/sched/completion.c:86 [inline]
>> >> >> >> >> >   __wait_for_common kernel/sched/completion.c:107 [inline]
>> >> >> >> >> >   wait_for_common kernel/sched/completion.c:118 [inline]
>> >> >> >> >> >   wait_for_completion+0x415/0x770 kernel/sched/completion.c:139
>> >> >> >> >> >   __wait_rcu_gp+0x221/0x340 kernel/rcu/update.c:414
>> >> >> >> >> >   synchronize_sched.part.64+0xac/0x100 kernel/rcu/tree.c:3212
>> >> >> >> >> >   synchronize_sched+0x76/0xf0 kernel/rcu/tree.c:3213
>> >> >> >> >>
>> >> >> >> >> I don't think this is a perf issue. Looks like something is preventing
>> >> >> >> >> rcu_sched from completing. If there's a CPU that is running in kernel
>> >> >> >> >> space and never scheduling, that can cause this issue. Or if RCU
>> >> >> >> >> somehow missed a transition into idle or user space.
>> >> >> >> >
>> >> >> >> > The RCU CPU stall warning below strongly supports this position ...
>> >> >> >>
>> >> >> >> I think this is this guy then:
>> >> >> >>
>> >> >> >> https://syzkaller.appspot.com/bug?id=17f23b094cd80df750e5b0f8982c521ee6bcbf40
>> >> >> >>
>> >> >> >> #syz dup: INFO: rcu detected stall in __process_echoes
>> >> >> >
>> >> >> > Seems likely to me!
>> >> >> >
>> >> >> >> Looking retrospectively at the various hang/stall bugs that we have, I
>> >> >> >> think we need some kind of priority between them. I.e. we have rcu
>> >> >> >> stalls, spinlock stalls, workqueue hangs, task hangs, silent machine
>> >> >> >> hang and maybe something else. It would be useful if they fire
>> >> >> >> deterministically according to priorities. If there is an rcu stall,
>> >> >> >> that's always detected as CPU stall. Then if there is no RCU stall,
>> >> >> >> but a workqueue stall, then that's always detected as workqueue stall,
>> >> >> >> etc.
>> >> >> >> Currently if we have an RCU stall (effectively CPU stall), that can be
>> >> >> >> detected either RCU stall or a task hung, producing 2 different bug
>> >> >> >> reports (which is bad).
>> >> >> >> One can say that it's only a matter of tuning timeouts, but at least
>> >> >> >> task hung detector has a problem that if you set timeout to X, it can
>> >> >> >> detect hung anywhere between X and 2*X. And on one hand we need quite
>> >> >> >> large timeout (a minute may not be enough), and on the other hand we
>> >> >> >> can't wait for an hour just to make sure that the machine is indeed
>> >> >> >> dead (these things happen every few minutes).
>> >> >> >
>> >> >> > I suppose that we could have a global variable that was set to the
>> >> >> > priority of the complaint in question, which would suppress all
>> >> >> > lower-priority complaints.  Might need to be opt-in, though -- I would
>> >> >> > guess that not everyone is going to be happy with one complaint suppressing
>> >> >> > others, especially given the possibility that the two complaints might
>> >> >> > be about different things.
>> >> >> >
>> >> >> > Or did you have something more deft in mind?
>> >> >>
>> >> >>
>> >> >> syzkaller generally looks only at the first report. One does not know
>> >> >> if/when there will be a second one, or the second one can be induced
>> >> >> by the first one, and we generally want clean reports on a non-tainted
>> >> >> kernel. So we don't just need to suppress lower priority ones, we need
>> >> >> to produce the right report first.
>> >> >> I am thinking maybe setting:
>> >> >>  - rcu stalls at 1.5 minutes
>> >> >>  - workqueue stalls at 2 minutes
>> >> >>  - task hungs at 2.5 minutes
>> >> >>  - and no output whatsoever at 3 minutes
>> >> >> Do I miss anything? I think at least spinlocks. Should they go before
>> >> >> or after rcu?
>> >> >
>> >> > That is what I know of, but the Linux kernel being what it is, there is
>> >> > probably something more out there.  If not now, in a few months.  The
>> >> > RCU CPU stall timeout can be set on the kernel-boot command line, but
>> >> > you probably already knew that.
>> >>
>> >> Well, it's all based solely on a large number of patches and stopgaps.
>> >> If we fix main problems for today, it's already good.
>> >
>> > Fair enough!
>> >
>> >> > Just for comparison, back in DYNIX/ptx days the RCU CPU stall timeout
>> >> > was 1.5 -seconds-.  ;-)
>> >>
>> >> Have you tried to instrument every basic block with a function call to
>> >> collect coverage, check every damn memory access for validity, enable
>> >> all thinkable and unthinkable debug configs and put the insanest load
>> >> one can imagine from a swarm of parallel threads? It makes things a
>> >> bit slower ;)
>> >
>> > Given that we wouldn't have had enough CPU or memory to accommodate
>> > all of that back in DYNIX/ptx days, I am forced to answer "no".  ;-)
>> >
>> >> >> This will require fixing task hung. Have not yet looked at workqueue detector.
>> >> >> Does at least RCU respect the given timeout more or less precisely?
>> >> >
>> >> > Assuming that there is at least one CPU capable of taking scheduling-clock
>> >> > interrupts, it should respect the timeout to within a few jiffies.
>>
>>
>> Hi Paul,
>>
>> Speaking of stalls and rcu, we are seeing lots of crashes that go like this:
>>
>> INFO: rcu_sched self-detected stall on CPU[  404.992530] INFO:
>> rcu_sched detected stalls on CPUs/tasks:
>> INFO: rcu_sched self-detected stall on CPU[  454.347448] INFO:
>> rcu_sched detected stalls on CPUs/tasks:
>> INFO: rcu_sched self-detected stall on CPU[  396.073634] INFO:
>> rcu_sched detected stalls on CPUs/tasks:
>>
>> or like this:
>>
>> INFO: rcu_sched self-detected stall on CPU
>> INFO: rcu_sched detected stalls on CPUs/tasks:
>> 0-....: (125000 ticks this GP) idle=0ba/1/4611686018427387906
>> softirq=57641/57641 fqs=31151
>> 0-....: (125000 ticks this GP) idle=0ba/1/4611686018427387906
>> softirq=57641/57641 fqs=31151
>>  (t=125002 jiffies g=31656 c=31655 q=910)
>>
>>  INFO: rcu_sched self-detected stall on CPU
>> INFO: rcu_sched detected stalls on CPUs/tasks:
>> 0-....: (125000 ticks this GP) idle=49a/1/4611686018427387906
>> softirq=65194/65194 fqs=31231
>> 0-....: (125000 ticks this GP) idle=49a/1/4611686018427387906
>> softirq=65194/65194 fqs=31231
>>  (t=125002 jiffies g=34421 c=34420 q=1119)
>> (detected by 1, t=125002 jiffies, g=34421, c=34420, q=1119)
>>
>>
>> and then there is an unintelligible mess of 2 reports. Such crashes go
>> to trash bin, because we can't even say which function hanged. It
>> seems that in all cases 2 different rcu stall detection facilities
>> race with each other. Is it possible to make them not race?
>
> How about the following (untested, not for mainline) patch?  It suppresses
> all but the "main" RCU flavor, which is rcu_sched for !PREEMPT builds and
> rcu_preempt otherwise.  Either way, this is the RCU flavor corresponding
> to synchronize_rcu().  This works well in the common case where there
> is almost always an RCU grace period in flight.
>
> One reason that this patch is not for mainline is that I am working on
> merging the RCU-bh, RCU-preempt, and RCU-sched flavors into one thing,
> at which point there won't be any races.  But that might be a couple
> merge windows away from now.
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 381b47a68ac6..31f7818f2d63 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1552,7 +1552,7 @@ static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
>         struct rcu_node *rnp;
>
>         if ((rcu_cpu_stall_suppress && !rcu_kick_kthreads) ||
> -           !rcu_gp_in_progress(rsp))
> +           !rcu_gp_in_progress(rsp) || rsp != rcu_state_p)
>                 return;
>         rcu_stall_kick_kthreads(rsp);
>         j = jiffies;


But doesn't they both relate to the same rcu flavor? They both say
rcu_sched. I assumed that the difference is "self-detected" vs "on
CPUs/tasks", i.e. on the current CPU vs on other CPUs.
