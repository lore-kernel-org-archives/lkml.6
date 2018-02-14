Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754701AbeBNMDC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 07:03:02 -0500
Received: from foss.arm.com ([217.140.101.70]:41294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754616AbeBNMDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 07:03:01 -0500
Date: Wed, 14 Feb 2018 12:02:54 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: mingo@kernel.org, peterz@infradead.org, will.deacon@arm.com,
        mathieu.desnoyers@efficios.com
Subject: arm64/v4.16-rc1: KASAN: use-after-free Read in finish_task_switch
Message-ID: <20180214120254.qq4w4s42ecxio7lu@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As a heads-up, I hit the splat below when fuzzing v4.16-rc1 on arm64.

Evidently, we get to finish_task_switch() with rq->prev_mm != NULL,
despite rq->prev_mm having been freed. KASAN spots the dereference of
mm->membarrier_state in membarrier_mm_sync_core_before_usermode(mm), but
AFAICT the underlying issue is independent of the membarrier code, and
we could get a splat on the subsequent mmdrop(mm).

I've seen this once in ~2500 CPU hours of fuzzing, so it looks pretty
difficult to hit, and I have no reproducer so far.

Syzkaller report below, mirrored with Syzkaller log at [1]. If I hit
this again, I'll upload new info there.

Thanks,
Mark.

[1] https://www.kernel.org/pub/linux/kernel/people/mark/bugs/20180214-finish_task_switch-stale-mm/

==================================================================
BUG: KASAN: use-after-free in __read_once_size include/linux/compiler.h:183 [inline]
BUG: KASAN: use-after-free in membarrier_mm_sync_core_before_usermode include/linux/sched/mm.h:216 [inline]
BUG: KASAN: use-after-free in finish_task_switch+0x590/0x5e8 kernel/sched/core.c:2720
Read of size 4 at addr ffff800073dd4980 by task swapper/1/0

CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.16.0-rc1-00001-g3fffa6166965-dirty #13
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x388 arch/arm64/kernel/time.c:52
 show_stack+0x20/0x30 arch/arm64/kernel/traps.c:151
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0xd0/0x120 lib/dump_stack.c:53
 print_address_description+0x5c/0x2a8 mm/kasan/report.c:262
 kasan_report_error mm/kasan/report.c:362 [inline]
 kasan_report+0x210/0x340 mm/kasan/report.c:420
 __asan_report_load4_noabort+0x18/0x20 mm/kasan/report.c:440
 __read_once_size include/linux/compiler.h:183 [inline]
 membarrier_mm_sync_core_before_usermode include/linux/sched/mm.h:216 [inline]
 finish_task_switch+0x590/0x5e8 kernel/sched/core.c:2720
 context_switch kernel/sched/core.c:2860 [inline]
 __schedule+0x4f0/0x1558 kernel/sched/core.c:3435
 schedule_idle+0x40/0x80 kernel/sched/core.c:3521
 do_idle+0x114/0x2e0 kernel/sched/idle.c:269
 cpu_startup_entry+0x24/0x28 kernel/sched/idle.c:351
 secondary_start_kernel+0x290/0x318 arch/arm64/kernel/smp.c:283

Allocated by task 12964:
 save_stack mm/kasan/kasan.c:447 [inline]
 set_track mm/kasan/kasan.c:459 [inline]
 kasan_kmalloc+0xd0/0x180 mm/kasan/kasan.c:552
 kasan_slab_alloc+0x14/0x20 mm/kasan/kasan.c:489
 slab_post_alloc_hook mm/slab.h:443 [inline]
 slab_alloc_node mm/slub.c:2725 [inline]
 slab_alloc mm/slub.c:2733 [inline]
 kmem_cache_alloc+0x150/0x240 mm/slub.c:2738
 dup_mm kernel/fork.c:1235 [inline]
 copy_mm kernel/fork.c:1298 [inline]
 copy_process.isra.7.part.8+0x1a10/0x5018 kernel/fork.c:1804
 copy_process kernel/fork.c:1617 [inline]
 _do_fork+0x178/0x998 kernel/fork.c:2098
 SYSC_clone kernel/fork.c:2205 [inline]
 SyS_clone+0x48/0x60 kernel/fork.c:2183
 el0_svc_naked+0x30/0x34

Freed by task 10882:
 save_stack mm/kasan/kasan.c:447 [inline]
 set_track mm/kasan/kasan.c:459 [inline]
 __kasan_slab_free+0x114/0x220 mm/kasan/kasan.c:520
 kasan_slab_free+0x10/0x18 mm/kasan/kasan.c:527
 slab_free_hook mm/slub.c:1393 [inline]
 slab_free_freelist_hook mm/slub.c:1414 [inline]
 slab_free mm/slub.c:2968 [inline]
 kmem_cache_free+0x88/0x270 mm/slub.c:2990
 __mmdrop+0x164/0x248 kernel/fork.c:604
 mmdrop+0x50/0x60 kernel/fork.c:615
 __mmput kernel/fork.c:981 [inline]
 mmput+0x270/0x338 kernel/fork.c:992
 exit_mm kernel/exit.c:544 [inline]
 do_exit+0x640/0x2100 kernel/exit.c:852
 do_group_exit+0xdc/0x260 kernel/exit.c:968
 get_signal+0x2ec/0xfc8 kernel/signal.c:2469
 do_signal+0x270/0x4f8 arch/arm64/kernel/signal.c:869
 do_notify_resume+0x150/0x1c0 arch/arm64/kernel/signal.c:927
 work_pending+0x8/0x14

The buggy address belongs to the object at ffff800073dd4600
 which belongs to the cache mm_struct of size 1104
The buggy address is located 896 bytes inside of
 1104-byte region [ffff800073dd4600, ffff800073dd4a50)
The buggy address belongs to the page:
page:ffff7e0001cf7400 count:1 mapcount:0 mapping:          (null) index:0x0 compound_mapcount: 0
flags: 0x4fffc00000008100(slab|head)
raw: 4fffc00000008100 0000000000000000 0000000000000000 0000000180190019
raw: ffff7e0001d2b000 0000000700000007 ffff800075803000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff800073dd4880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff800073dd4900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff800073dd4980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff800073dd4a00: fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc
 ffff800073dd4a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
