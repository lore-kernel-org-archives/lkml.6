Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755352AbeDWNkz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:40:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754881AbeDWNkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:40:51 -0400
Date: Mon, 23 Apr 2018 15:40:45 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi
To: "Theodore Ts'o" <tytso@mit.edu>
cc: linux-kernel@vger.kernel.org
Subject: [BUG, PATCH] random: sleep in irq context
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Martina?=
 =?ISO-8859-15?Q?_Koederitz_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 18042313-0040-0000-0000-00000431FDCA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042313-0041-0000-0000-00002636245D
Message-Id: <alpine.LFD.2.21.1804231518060.1767@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Today I observed the following lockdep splat:

irq event stamp: 36

================================
hardirqs last  enabled at (35): [<00000000008e6bc6>] _raw_spin_unlock_irqrestore+0x7e/0xb0
hardirqs last disabled at (36): [<00000000008e6884>] _raw_spin_lock_irqsave+0x3c/0xb8
softirqs last  enabled at (0): [<00000000001431da>] copy_process.part.8+0x42a/0x1e10
softirqs last disabled at (0): [<0000000000000000>]           (null)
WARNING: inconsistent lock state
4.17.0-rc2-00001-gc50517a06b5f #186 Not tainted
--------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
swapper/4/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
        (ptrval) (fs_reclaim){?.+.}, at: fs_reclaim_acquire.part.13+0x0/0x60
{HARDIRQ-ON-W} state was registered at:
  __lock_acquire+0x3da/0x13f0
  lock_acquire+0xf6/0x290
  fs_reclaim_acquire.part.13+0x52/0x60
  kmem_cache_alloc_node_trace+0x52/0x408
  alloc_worker+0x3e/0x88
  init_rescuer.part.7+0x32/0xc8
  workqueue_init+0x26a/0x388
  kernel_init_freeable+0x11a/0x5a0
  kernel_init+0x2a/0x158
  kernel_thread_starter+0x6/0xc
  kernel_thread_starter+0x0/0xc
irq event stamp: 1780
hardirqs last  enabled at (1777): [<000000000010386a>] enabled_wait+0x52/0x138
hardirqs last disabled at (1778): [<00000000008e8336>] ext_int_handler+0x122/0x140
softirqs last  enabled at (1780): [<000000000014f424>] irq_enter+0x8c/0x98
softirqs last disabled at (1779): [<000000000014f408>] irq_enter+0x70/0x98

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(fs_reclaim);
  <Interrupt>
    lock(fs_reclaim);

 *** DEADLOCK ***

no locks held by swapper/4/0.

stack backtrace:
CPU: 4 PID: 0 Comm: swapper/4 Not tainted 4.17.0-rc2-00001-gc50517a06b5f #186
Hardware name: IBM 3906 M04 704 (LPAR)
Call Trace:
([<0000000000114bbc>] show_stack+0x9c/0x108)
 [<00000000008c52ca>] dump_stack+0x9a/0xd8 
 [<00000000001b9a64>] print_usage_bug+0x25c/0x300 
 [<00000000001ba1aa>] mark_lock+0x6a2/0x6f8 
 [<00000000001bb49c>] __lock_acquire+0xc64/0x13f0 
 [<00000000001bc49e>] lock_acquire+0xf6/0x290 
 [<00000000002edc82>] fs_reclaim_acquire.part.13+0x52/0x60 
 [<0000000000375e42>] __kmalloc+0x62/0x438 
 [<00000000006283b2>] crng_reseed+0x142/0x368 
 [<0000000000628998>] credit_entropy_bits+0x3c0/0x3f8 
 [<000000000062959c>] add_interrupt_randomness+0x204/0x298 
 [<00000000001d44a4>] handle_irq_event_percpu+0x54/0x88 
 [<00000000001d8e54>] handle_percpu_irq+0x84/0xb0 
 [<00000000001d2ffa>] generic_handle_irq+0x42/0x60 
 [<000000000010d3c4>] do_IRQ+0xa4/0xf0 
 [<00000000008e8350>] ext_int_handler+0x13c/0x140 
 [<0000000000103882>] enabled_wait+0x6a/0x138 
([<000000000010386a>] enabled_wait+0x52/0x138)
 [<0000000000103d4a>] arch_cpu_idle+0x32/0x50 
 [<00000000008e659e>] default_idle_call+0x3e/0x68 
 [<00000000001889aa>] do_idle+0xea/0x1c0 
 [<0000000000188d26>] cpu_startup_entry+0x3e/0x48 
 [<000000000011758e>] smp_start_secondary+0x13e/0x158 
 [<00000000008e87a2>] restart_int_handler+0x5a/0x70 
 [<0000000000000000>]           (null) 
INFO: lockdep is turned off.
BUG: sleeping function called from invalid context at mm/slab.h:421
in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper/4
INFO: lockdep is turned off.
irq event stamp: 1780
hardirqs last  enabled at (1777): [<000000000010386a>] enabled_wait+0x52/0x138
hardirqs last disabled at (1778): [<00000000008e8336>] ext_int_handler+0x122/0x140
softirqs last  enabled at (1780): [<000000000014f424>] irq_enter+0x8c/0x98
softirqs last disabled at (1779): [<000000000014f408>] irq_enter+0x70/0x98
Preemption disabled at:
[<00000000001174f6>] smp_start_secondary+0xa6/0x158
CPU: 4 PID: 0 Comm: swapper/4 Not tainted 4.17.0-rc2-00001-gc50517a06b5f #186
Hardware name: IBM 3906 M04 704 (LPAR)
Call Trace:
([<0000000000114bbc>] show_stack+0x9c/0x108)
 [<00000000008c52ca>] dump_stack+0x9a/0xd8 
 [<000000000017d256>] ___might_sleep+0x216/0x278 
 [<000000000037607c>] __kmalloc+0x29c/0x438 
 [<00000000006283b2>] crng_reseed+0x142/0x368 
 [<0000000000628998>] credit_entropy_bits+0x3c0/0x3f8 
 [<000000000062959c>] add_interrupt_randomness+0x204/0x298 
 [<00000000001d44a4>] handle_irq_event_percpu+0x54/0x88 
 [<00000000001d8e54>] handle_percpu_irq+0x84/0xb0 
 [<00000000001d2ffa>] generic_handle_irq+0x42/0x60 
 [<000000000010d3c4>] do_IRQ+0xa4/0xf0 
 [<00000000008e8350>] ext_int_handler+0x13c/0x140 
 [<0000000000103882>] enabled_wait+0x6a/0x138 
([<000000000010386a>] enabled_wait+0x52/0x138)
 [<0000000000103d4a>] arch_cpu_idle+0x32/0x50 
 [<00000000008e659e>] default_idle_call+0x3e/0x68 
 [<00000000001889aa>] do_idle+0xea/0x1c0 
 [<0000000000188d26>] cpu_startup_entry+0x3e/0x48 
 [<000000000011758e>] smp_start_secondary+0x13e/0x158 
 [<00000000008e87a2>] restart_int_handler+0x5a/0x70 
 [<0000000000000000>]           (null) 
INFO: lockdep is turned off.

This happend once during boot and I could not reproduce this since, but I
think the following patch should fix the issue:

----->8
>From 9d29e0c92efaf94277bc178782523283958ae8c8 Mon Sep 17 00:00:00 2001
From: Sebastian Ott <sebott@linux.ibm.com>
Date: Mon, 23 Apr 2018 14:59:20 +0200
Subject: [PATCH] random: don't sleep during allocations in irq context

Since numa_crng_init() can be called from irq context let's
use __GFP_ATOMIC for allocations.

Fixes: 8ef35c866f88 ("random: set up the NUMA crng instances...")
Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
---
 drivers/char/random.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 3cd3aae24d6d..e96ea2bf7241 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -791,14 +791,14 @@ static void crng_initialize(struct crng_state *crng)
 #ifdef CONFIG_NUMA
 static void numa_crng_init(void)
 {
+	gfp_t gfp_flags = GFP_KERNEL | __GFP_NOFAIL | __GFP_ATOMIC;
 	int i;
 	struct crng_state *crng;
 	struct crng_state **pool;
 
-	pool = kcalloc(nr_node_ids, sizeof(*pool), GFP_KERNEL|__GFP_NOFAIL);
+	pool = kcalloc(nr_node_ids, sizeof(*pool), gfp_flags);
 	for_each_online_node(i) {
-		crng = kmalloc_node(sizeof(struct crng_state),
-				    GFP_KERNEL | __GFP_NOFAIL, i);
+		crng = kmalloc_node(sizeof(struct crng_state), gfp_flags, i);
 		spin_lock_init(&crng->lock);
 		crng_initialize(crng);
 		pool[i] = crng;
-- 
2.13.4
