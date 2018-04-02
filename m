Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754533AbeDBWDt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 18:03:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754469AbeDBWDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 18:03:48 -0400
Date: Mon, 2 Apr 2018 15:04:38 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: frederic@kernel.org, cmetcalf@mellanox.com, cl@linux.com,
        lcapitulino@redhat.com, efault@gmx.de, peterz@infradead.org,
        riel@redhat.com, tglx@linutronix.de, kernellwp@gmail.com,
        mingo@kernel.org
Subject: NO_HZ_FULL and tick running within a reasonable amount of time
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18040222-0048-0000-0000-0000025438E7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008791; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01012210; UDB=6.00515856; IPR=6.00791477;
 MB=3.00020380; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-02 22:03:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040222-0049-0000-0000-000044A341FE
Message-Id: <20180402220438.GA15885@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-02_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804020240
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I am hitting the following on today's mainline under rcutorture, but
only on scenarios built with CONFIG_NO_HZ_FULL=y:

------------------------------------------------------------------------

WARNING: CPU: 0 PID: 7 at /home/paulmck/public_git/linux-rcu/kernel/sched/core.c:3124 sched_tick_remote+0x113/0x120
Modules linked in:
CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted 4.16.0+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
Workqueue: events_unbound sched_tick_remote
RIP: 0010:sched_tick_remote+0x113/0x120
RSP: 0018:ffff94d540103e20 EFLAGS: 00010002
RAX: 000000012e9bb357 RBX: ffff8f95dfd21840 RCX: 000000000000001f
RDX: 00000000b2d05e00 RSI: 00000000ffffffff RDI: ffff8f95dfd21858
RBP: ffff94d540103e48 R08: 00000000f6499019 R09: 00000000f6499000
R10: 00000000b163d33b R11: ffffffffa5c8c212 R12: ffff8f95dfd25518
R13: ffff8f95de9e4200 R14: 0000000000003402 R15: ffff8f95dfd21858
FS:  0000000000000000(0000) GS:ffff8f95dfc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000a015b40 CR3: 000000001de14000 CR4: 00000000000006f0
Call Trace:
 process_one_work+0x1d9/0x6a0
 worker_thread+0x42/0x420
 kthread+0xf3/0x130
 ? rescuer_thread+0x340/0x340
 ? kthread_delayed_work_timer_fn+0x80/0x80
 ret_from_fork+0x3a/0x50
Code: ff 48 8b 83 80 0b 00 00 48 85 c0 0f 85 41 ff ff ff e9 45 ff ff ff be ff ff ff ff 4c 89 ff e8 55 44 02 00 85 c0 75 87 0f 0b eb 83 <0f> 0b eb 97 66 0f 1f 84 00 00 00 00 00 41 57 41 56 41 55 41 54
---[ end trace fbdcbe529a8ae799 ]--

------------------------------------------------------------------------

The WARN_ON_ONCE() triggering is this guy:

	delta = rq_clock_task(rq) - curr->se.exec_start;
	WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);

But given that ->se.exec_start is zeroed from time to time, for example,
in migrate_task_rq_fair(), I am a bit suspicious of this check.

What am I missing here?

							Thanx, Paul
