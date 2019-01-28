Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B7FC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371C1214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfA1OQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:16:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726683AbfA1OQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:16:00 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0SEBaIr116996
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 09:15:59 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qa39gr6n6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 09:15:59 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 28 Jan 2019 14:15:58 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 28 Jan 2019 14:15:54 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0SEFrpg24051748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Jan 2019 14:15:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5743B2064;
        Mon, 28 Jan 2019 14:15:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5DB4B2066;
        Mon, 28 Jan 2019 14:15:53 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.57])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jan 2019 14:15:53 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5E8A616C19DB; Mon, 28 Jan 2019 06:15:53 -0800 (PST)
Date:   Mon, 28 Jan 2019 06:15:53 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Jann Horn <jannh@google.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [BUG] racy access to p->mm in membarrier_global_expedited()
Reply-To: paulmck@linux.ibm.com
References: <CAG48ez2G8ctF8dHS42TF37pThfr3y0RNOOYTmxvACm4u8Yu3cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2G8ctF8dHS42TF37pThfr3y0RNOOYTmxvACm4u8Yu3cw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19012814-2213-0000-0000-00000345B9EF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010493; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153006; UDB=6.00601088; IPR=6.00933368;
 MB=3.00025322; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-28 14:15:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012814-2214-0000-0000-00005D24E5EB
Message-Id: <20190128141553.GM4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 06:26:47PM +0100, Jann Horn wrote:
> membarrier_global_expedited() runs the following code (introduced in
> commit c5f58bd58f43), protected only by an RCU read-side critical
> section and the cpu_hotplug_lock:
> 
>         p = task_rcu_dereference(&cpu_rq(cpu)->curr);
>         if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
>                            MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
>                 if (!fallback)
>                         __cpumask_set_cpu(cpu, tmpmask);
>                 else
>                         smp_call_function_single(cpu, ipi_mb, NULL, 1);
>         }
> 
> p->mm is not protected by either lock. This means that in theory, the
> following races could occur:
> 
> 1. If the compiler emitted two separate reads of ->mm, the second read
> of p->mm could return a NULL pointer and crash.
> 2. If the mm is deallocated directly before the atomic_read() occurs,
> the atomic_read() could access a freed pointer (I think?).
> 
> Neither of these are particularly likely - looking at the assembly of
> a normal build, the first race doesn't exist because the compiler
> optimizes the second read away, and the second race isn't going to
> cause anything particularly interesting. Still, this should probably
> be fixed...
> 
> As far as I can tell, you'll have to either take the task_lock()
> around the "p->mm && (atomic_read(&p->mm->membarrier_state)" or add
> RCU to the lifetime of mm_struct. I'm not entirely sure what the
> better fix is... probably task_lock() makes more sense?

Ouch!!!

Acquiring task_lock() would work, but would be a global lock.
This could be addressed to some extent by batching concurrent
membarrier_global_expedited() invocations, so that one call to
membarrier_global_expedited() does the job for the set of concurrent
calls.  The usual approach would use a counter, a pair of wait queues,
and a kthread.

I must defer to the mm guys on adding RCU to the lifetime of mm_struct.

Another approach would be to put the MEMBARRIER_STATE_GLOBAL_EXPEDITED
in the task structure.  Yet another approach would be to acquire the
runqueue lock, thus preventing the task from switching away -- except
that it might be in the middle of exit(), so never mind.

Other approaches?

							Thanx, Paul

> To test the bug, I patched an extra delay into the code:
> 
> ====================
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index 3cd8a3a795d2..69cc52039576 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -14,6 +14,7 @@
>   * GNU General Public License for more details.
>   */
>  #include "sched.h"
> +#include <linux/delay.h>
> 
>  /*
>   * Bitmask made from a "or" of all commands within enum membarrier_cmd,
> @@ -81,7 +82,7 @@ static int membarrier_global_expedited(void)
> 
>                 rcu_read_lock();
>                 p = task_rcu_dereference(&cpu_rq(cpu)->curr);
> -               if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
> +               if (p && p->mm && (mdelay(100), 1) &&
> (atomic_read(&p->mm->membarrier_state) &
>                                    MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
>                         if (!fallback)
>                                 __cpumask_set_cpu(cpu, tmpmask);
> ====================
> 
> On a kernel with that patch applied, I ran this test code:
> 
> ====================
> #define _GNU_SOURCE
> #include <unistd.h>
> #include <sys/syscall.h>
> #include <stdio.h>
> #include <linux/membarrier.h>
> #include <err.h>
> 
> int main(void) {
>   while (1) {
>     printf("executing global expedited barrier...\n");
>     int res = syscall(__NR_membarrier, MEMBARRIER_CMD_GLOBAL_EXPEDITED, 0);
>     if (res) err(1, "barrier");
>   }
> }
> ====================
> 
> That resulted in this splat:
> 
> [  212.697681] ==================================================================
> [  212.700582] BUG: KASAN: null-ptr-deref in
> membarrier_global_expedited+0x15f/0x220
> [  212.703346] Read of size 4 at addr 0000000000000378 by task barrier/1177
> 
> [  212.706384] CPU: 1 PID: 1177 Comm: barrier Not tainted 5.0.0-rc3+ #246
> [  212.708925] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.10.2-1 04/01/2014
> [  212.712263] Call Trace:
> [  212.713177]  dump_stack+0x71/0xab
> [  212.714375]  ? membarrier_global_expedited+0x15f/0x220
> [  212.716236]  ? membarrier_global_expedited+0x15f/0x220
> [  212.718099]  kasan_report+0x176/0x192
> [  212.719445]  ? finish_task_switch+0x340/0x3d0
> [  212.721057]  ? membarrier_global_expedited+0x15f/0x220
> [  212.722921]  membarrier_global_expedited+0x15f/0x220
> [  212.724696]  ? ipi_mb+0x10/0x10
> [  212.725816]  ? vfs_write+0x120/0x230
> [  212.727113]  ? __ia32_sys_read+0x50/0x50
> [  212.728596]  __x64_sys_membarrier+0x85/0xf0
> [  212.730056]  do_syscall_64+0x73/0x160
> [  212.731428]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  212.733236] RIP: 0033:0x7fbe8747e229
> [  212.734540] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
> 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
> 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3f 4c 2b 00 f7 d8 64 89
> 01 48
> [  212.741109] RSP: 002b:00007fffcb62a7c8 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000144
> [  212.743831] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbe8747e229
> [  212.746335] RDX: 00007fbe87475730 RSI: 0000000000000000 RDI: 0000000000000002
> [  212.748855] RBP: 00007fffcb62a7e0 R08: 00007fffcb62a8c0 R09: 00007fffcb62a8c0
> [  212.751374] R10: 00007fbe8793c700 R11: 0000000000000202 R12: 0000563ee2ac9610
> [  212.753842] R13: 00007fffcb62a8c0 R14: 0000000000000000 R15: 0000000000000000
> [  212.756305] ==================================================================
> 

