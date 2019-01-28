Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C23C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB7520663
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390467AbfA1Qag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:30:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390409AbfA1Q10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:27:26 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0SGJPin012122
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:27:24 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qa3mnny5b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:27:24 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 28 Jan 2019 16:27:23 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 28 Jan 2019 16:27:20 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0SGRJ0o18022604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Jan 2019 16:27:19 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85F61B205F;
        Mon, 28 Jan 2019 16:27:19 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55BB9B2067;
        Mon, 28 Jan 2019 16:27:19 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.57])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jan 2019 16:27:19 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 26AEF16C5F12; Mon, 28 Jan 2019 08:27:19 -0800 (PST)
Date:   Mon, 28 Jan 2019 08:27:19 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Jann Horn <jannh@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [BUG] racy access to p->mm in membarrier_global_expedited()
Reply-To: paulmck@linux.ibm.com
References: <CAG48ez2G8ctF8dHS42TF37pThfr3y0RNOOYTmxvACm4u8Yu3cw@mail.gmail.com>
 <20190128141553.GM4240@linux.ibm.com>
 <1963434274.2063.1548691800642.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1963434274.2063.1548691800642.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19012816-0052-0000-0000-0000037F7070
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010493; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153050; UDB=6.00601114; IPR=6.00933411;
 MB=3.00025324; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-28 16:27:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012816-0053-0000-0000-00005FA1EE08
Message-Id: <20190128162719.GT4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 11:10:00AM -0500, Mathieu Desnoyers wrote:
> ----- On Jan 28, 2019, at 9:15 AM, paulmck paulmck@linux.ibm.com wrote:
> 
> > On Fri, Jan 25, 2019 at 06:26:47PM +0100, Jann Horn wrote:
> >> membarrier_global_expedited() runs the following code (introduced in
> >> commit c5f58bd58f43), protected only by an RCU read-side critical
> >> section and the cpu_hotplug_lock:
> >> 
> >>         p = task_rcu_dereference(&cpu_rq(cpu)->curr);
> >>         if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
> >>                            MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
> >>                 if (!fallback)
> >>                         __cpumask_set_cpu(cpu, tmpmask);
> >>                 else
> >>                         smp_call_function_single(cpu, ipi_mb, NULL, 1);
> >>         }
> >> 
> >> p->mm is not protected by either lock. This means that in theory, the
> >> following races could occur:
> >> 
> >> 1. If the compiler emitted two separate reads of ->mm, the second read
> >> of p->mm could return a NULL pointer and crash.
> >> 2. If the mm is deallocated directly before the atomic_read() occurs,
> >> the atomic_read() could access a freed pointer (I think?).
> >> 
> >> Neither of these are particularly likely - looking at the assembly of
> >> a normal build, the first race doesn't exist because the compiler
> >> optimizes the second read away, and the second race isn't going to
> >> cause anything particularly interesting. Still, this should probably
> >> be fixed...
> >> 
> >> As far as I can tell, you'll have to either take the task_lock()
> >> around the "p->mm && (atomic_read(&p->mm->membarrier_state)" or add
> >> RCU to the lifetime of mm_struct. I'm not entirely sure what the
> >> better fix is... probably task_lock() makes more sense?
> > 
> > Ouch!!!
> > 
> > Acquiring task_lock() would work, but would be a global lock.
> > This could be addressed to some extent by batching concurrent
> > membarrier_global_expedited() invocations, so that one call to
> > membarrier_global_expedited() does the job for the set of concurrent
> > calls.  The usual approach would use a counter, a pair of wait queues,
> > and a kthread.
> 
> We could start by grabbing the task_lock() as an initial fix, and
> then address any performance-related complains with your approach
> if need be.

Makes sense to me, always good to start simply.

> > I must defer to the mm guys on adding RCU to the lifetime of mm_struct.
> 
> Likewise.
> 
> > Another approach would be to put the MEMBARRIER_STATE_GLOBAL_EXPEDITED
> > in the task structure.
> 
> Then the tricky part becomes how to make sure the per-task-struct
> state is consistent across all tasks pointing to the same mm_struct
> (including processes created with clone CLONE_VM flag).

If a multi-threaded process can change its mm_struct, agreed.  I was
under the impression that such a change can only happen while the task
is single-threaded, but I wouldn't trust my impression all that much.

> > Yet another approach would be to acquire the
> > runqueue lock, thus preventing the task from switching away -- except
> > that it might be in the middle of exit(), so never mind.
> 
> And I suspect that grabbing the runqueue lock may cause more contention
> that grabbing the task_lock().

Quite possibly.

> I'll send a patch implementing the task_lock() approach as RFC.

Sounds good to me!

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> > 
> > Other approaches?
> > 
> >							Thanx, Paul
> > 
> >> To test the bug, I patched an extra delay into the code:
> >> 
> >> ====================
> >> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> >> index 3cd8a3a795d2..69cc52039576 100644
> >> --- a/kernel/sched/membarrier.c
> >> +++ b/kernel/sched/membarrier.c
> >> @@ -14,6 +14,7 @@
> >>   * GNU General Public License for more details.
> >>   */
> >>  #include "sched.h"
> >> +#include <linux/delay.h>
> >> 
> >>  /*
> >>   * Bitmask made from a "or" of all commands within enum membarrier_cmd,
> >> @@ -81,7 +82,7 @@ static int membarrier_global_expedited(void)
> >> 
> >>                 rcu_read_lock();
> >>                 p = task_rcu_dereference(&cpu_rq(cpu)->curr);
> >> -               if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
> >> +               if (p && p->mm && (mdelay(100), 1) &&
> >> (atomic_read(&p->mm->membarrier_state) &
> >>                                    MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
> >>                         if (!fallback)
> >>                                 __cpumask_set_cpu(cpu, tmpmask);
> >> ====================
> >> 
> >> On a kernel with that patch applied, I ran this test code:
> >> 
> >> ====================
> >> #define _GNU_SOURCE
> >> #include <unistd.h>
> >> #include <sys/syscall.h>
> >> #include <stdio.h>
> >> #include <linux/membarrier.h>
> >> #include <err.h>
> >> 
> >> int main(void) {
> >>   while (1) {
> >>     printf("executing global expedited barrier...\n");
> >>     int res = syscall(__NR_membarrier, MEMBARRIER_CMD_GLOBAL_EXPEDITED, 0);
> >>     if (res) err(1, "barrier");
> >>   }
> >> }
> >> ====================
> >> 
> >> That resulted in this splat:
> >> 
> >> [  212.697681]
> >> ==================================================================
> >> [  212.700582] BUG: KASAN: null-ptr-deref in
> >> membarrier_global_expedited+0x15f/0x220
> >> [  212.703346] Read of size 4 at addr 0000000000000378 by task barrier/1177
> >> 
> >> [  212.706384] CPU: 1 PID: 1177 Comm: barrier Not tainted 5.0.0-rc3+ #246
> >> [  212.708925] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> >> BIOS 1.10.2-1 04/01/2014
> >> [  212.712263] Call Trace:
> >> [  212.713177]  dump_stack+0x71/0xab
> >> [  212.714375]  ? membarrier_global_expedited+0x15f/0x220
> >> [  212.716236]  ? membarrier_global_expedited+0x15f/0x220
> >> [  212.718099]  kasan_report+0x176/0x192
> >> [  212.719445]  ? finish_task_switch+0x340/0x3d0
> >> [  212.721057]  ? membarrier_global_expedited+0x15f/0x220
> >> [  212.722921]  membarrier_global_expedited+0x15f/0x220
> >> [  212.724696]  ? ipi_mb+0x10/0x10
> >> [  212.725816]  ? vfs_write+0x120/0x230
> >> [  212.727113]  ? __ia32_sys_read+0x50/0x50
> >> [  212.728596]  __x64_sys_membarrier+0x85/0xf0
> >> [  212.730056]  do_syscall_64+0x73/0x160
> >> [  212.731428]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >> [  212.733236] RIP: 0033:0x7fbe8747e229
> >> [  212.734540] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
> >> 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
> >> 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3f 4c 2b 00 f7 d8 64 89
> >> 01 48
> >> [  212.741109] RSP: 002b:00007fffcb62a7c8 EFLAGS: 00000202 ORIG_RAX:
> >> 0000000000000144
> >> [  212.743831] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbe8747e229
> >> [  212.746335] RDX: 00007fbe87475730 RSI: 0000000000000000 RDI: 0000000000000002
> >> [  212.748855] RBP: 00007fffcb62a7e0 R08: 00007fffcb62a8c0 R09: 00007fffcb62a8c0
> >> [  212.751374] R10: 00007fbe8793c700 R11: 0000000000000202 R12: 0000563ee2ac9610
> >> [  212.753842] R13: 00007fffcb62a8c0 R14: 0000000000000000 R15: 0000000000000000
> >> [  212.756305]
> >> ==================================================================
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 

