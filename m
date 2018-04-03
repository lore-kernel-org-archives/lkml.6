Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeDCRII (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:08:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751270AbeDCRIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:08:06 -0400
Date: Tue, 3 Apr 2018 10:08:58 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, cmetcalf@mellanox.com, cl@linux.com,
        lcapitulino@redhat.com, efault@gmx.de, peterz@infradead.org,
        riel@redhat.com, tglx@linutronix.de, kernellwp@gmail.com,
        mingo@kernel.org
Subject: Re: NO_HZ_FULL and tick running within a reasonable amount of time
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180402220438.GA15885@linux.vnet.ibm.com>
 <20180403114130.GA22765@lerouge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403114130.GA22765@lerouge>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18040317-0040-0000-0000-000004110870
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008796; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01012590; UDB=6.00516080; IPR=6.00791856;
 MB=3.00020395; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-03 17:08:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040317-0041-0000-0000-000008121B84
Message-Id: <20180403170858.GO3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-03_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804030176
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 01:41:31PM +0200, Frederic Weisbecker wrote:
> On Mon, Apr 02, 2018 at 03:04:38PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > I am hitting the following on today's mainline under rcutorture, but
> > only on scenarios built with CONFIG_NO_HZ_FULL=y:
> > 
> > ------------------------------------------------------------------------
> > 
> > WARNING: CPU: 0 PID: 7 at /home/paulmck/public_git/linux-rcu/kernel/sched/core.c:3124 sched_tick_remote+0x113/0x120
> > Modules linked in:
> > CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted 4.16.0+ #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> > Workqueue: events_unbound sched_tick_remote
> > RIP: 0010:sched_tick_remote+0x113/0x120
> > RSP: 0018:ffff94d540103e20 EFLAGS: 00010002
> > RAX: 000000012e9bb357 RBX: ffff8f95dfd21840 RCX: 000000000000001f
> > RDX: 00000000b2d05e00 RSI: 00000000ffffffff RDI: ffff8f95dfd21858
> > RBP: ffff94d540103e48 R08: 00000000f6499019 R09: 00000000f6499000
> > R10: 00000000b163d33b R11: ffffffffa5c8c212 R12: ffff8f95dfd25518
> > R13: ffff8f95de9e4200 R14: 0000000000003402 R15: ffff8f95dfd21858
> > FS:  0000000000000000(0000) GS:ffff8f95dfc00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000000a015b40 CR3: 000000001de14000 CR4: 00000000000006f0
> > Call Trace:
> >  process_one_work+0x1d9/0x6a0
> >  worker_thread+0x42/0x420
> >  kthread+0xf3/0x130
> >  ? rescuer_thread+0x340/0x340
> >  ? kthread_delayed_work_timer_fn+0x80/0x80
> >  ret_from_fork+0x3a/0x50
> > Code: ff 48 8b 83 80 0b 00 00 48 85 c0 0f 85 41 ff ff ff e9 45 ff ff ff be ff ff ff ff 4c 89 ff e8 55 44 02 00 85 c0 75 87 0f 0b eb 83 <0f> 0b eb 97 66 0f 1f 84 00 00 00 00 00 41 57 41 56 41 55 41 54
> > ---[ end trace fbdcbe529a8ae799 ]--
> > 
> > ------------------------------------------------------------------------
> > 
> > The WARN_ON_ONCE() triggering is this guy:
> > 
> > 	delta = rq_clock_task(rq) - curr->se.exec_start;
> > 	WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
> 
> Weird. Can you try to print up those values and see how much they drift?
> 
>         if (WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3))
>                printk_once("clock_task: %lld exec_start: %lld\n", rq_clock_task(rq), curr->se.exec_start);

Here you go!

							Thanx, Paul

------------------------------------------------------------------------

WARNING: CPU: 0 PID: 7 at /home/paulmck/public_git/linux-rcu/kernel/sched/core.c:3124 sched_tick_remote+0xdb/0x100
Modules linked in:
CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted 4.16.0+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
Workqueue: events_unbound sched_tick_remote
RIP: 0010:sched_tick_remote+0xdb/0x100
RSP: 0018:ffffa2c440103e60 EFLAGS: 00010006
RAX: 00000000b2d05e00 RBX: ffff96f0dfd20980 RCX: 000000016a8de322
RDX: 000000000d33a301 RSI: 0000000177c18623 RDI: fffffffeb0bf0e53
RBP: ffff96f0dfd24328 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: ffff96f0de9d2640
R13: 0000000000000000 R14: 0ffff96f0de81700 R15: ffff96f0de96f540
FS:  0000000000000000(0000) GS:ffff96f0dfc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f7ec6ca3 CR3: 000000001e03e000 CR4: 00000000000006f0
Call Trace:
 process_one_work+0x139/0x3e0
 worker_thread+0x42/0x420
 kthread+0xf3/0x130
 ? create_worker+0x190/0x190
 ? kthread_destroy_worker+0x40/0x40
 ret_from_fork+0x35/0x40
Code: 89 8b 43 04 85 c0 0f 85 75 ff ff ff 48 8b 83 e0 0a 00 00 48 85 c0 0f 85 65 ff ff ff e9 69 ff ff ff 48 89 df e8 87 fe ff ff eb 8d <0f> 0b 80 3d 7d 57 2b 01 00 75 a8 48 c7 c7 e8 e1 fd a4 c6 05 6d
---[ end trace f0c6a1afa55d130d ]---
clock_task: 6304138787 exec_start: 221487873
