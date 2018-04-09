Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeDINaW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:30:22 -0400
Received: from foss.arm.com ([217.140.101.70]:56276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751697AbeDINaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:30:21 -0400
Date: Mon, 9 Apr 2018 14:30:17 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: v4.16 in_dev_finish_destroy() accessing freed idev->dev->pcpu_refcnt
Message-ID: <20180409133017.x6bhopqwcokafee6@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

As a heads-up, while fuzzing v4.16 on arm64, I'm hitting an intermittent
issue where in_dev_finish_destroy() calls dev_put() on idev->dev, where
idev->dev->pcpu_refcnt is NULL. Apparently idev->dev has already been
freed.

This results in a fault where we try to access the percpu offset of
NULL, such as in the example splat at the end of this mail.

So far I've had no luck in extracting a reliable reproducer, but I've
uploaded the relevant syzkaller logs (and reports) to my kernel.org
webspace [1].

Thanks,
Mark.

[1] https://www.kernel.org/pub/linux/kernel/people/mark/bugs/20180409-in_dev_finish_destroy-null-pcpu_refcnt/

Unable to handle kernel paging request at virtual address 60002be80000
Mem abort info:
  ESR = 0x96000004
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp = 00000000fb56b784
[000060002be80000] pgd=0000000000000000
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 2 PID: 22 Comm: ksoftirqd/2 Not tainted 4.16.0-00006-g6eee13dfb529 #1
Hardware name: linux,dummy-virt (DT)
pstate: 80400005 (Nzcv daif +PAN -UAO)
pc : __percpu_add arch/arm64/include/asm/percpu.h:102 [inline]
pc : dev_put include/linux/netdevice.h:3395 [inline]
pc : in_dev_finish_destroy+0xcc/0x230 net/ipv4/devinet.c:231
lr : dev_put include/linux/netdevice.h:3395 [inline]
lr : in_dev_finish_destroy+0xa4/0x230 net/ipv4/devinet.c:231
sp : ffff800036317b70
x29: ffff800036317b70 x28: ffff80001f39d338 
x27: ffff20000a917460 x26: ffff20000a917000 
x25: 000000000000000a x24: ffff20000a919000 
x23: ffff800036317c90 x22: ffff200009b84da8 
x21: 1ffff00003e73a68 x20: ffff80006e7a9100 
x19: ffff80001f39d180 x18: 0000000000000000 
x17: 0000000000000000 x16: ffff2000082951f0 
x15: 0000000000000001 x14: 00000000f2000000 
x13: ffff20000a9fb560 x12: 0000000000000002 
x11: 1ffff0000c147fbb x10: 0000000000000004 
x9 : 0000000000000000 x8 : 1fffe4000178908c 
x7 : 0000000000000000 x6 : 0000000000000000 
x5 : 0000000000000000 x4 : 1fffe4000178908c 
x3 : 1fffe4000178908c x2 : ffffffffffffffff 
x1 : 000060002be80000 x0 : 000060002be80000 
Process ksoftirqd/2 (pid: 22, stack limit = 0x00000000e96adbb2)
Call trace:
 __percpu_add arch/arm64/include/asm/percpu.h:102 [inline]
 dev_put include/linux/netdevice.h:3395 [inline]
 in_dev_finish_destroy+0xcc/0x230 net/ipv4/devinet.c:231
 in_dev_put include/linux/inetdevice.h:248 [inline]
 in_dev_rcu_put+0x34/0x48 net/ipv4/devinet.c:287
 __rcu_reclaim kernel/rcu/rcu.h:172 [inline]
 rcu_do_batch kernel/rcu/tree.c:2674 [inline]
 invoke_rcu_callbacks kernel/rcu/tree.c:2933 [inline]
 __rcu_process_callbacks kernel/rcu/tree.c:2900 [inline]
 rcu_process_callbacks+0x350/0x988 kernel/rcu/tree.c:2917
 __do_softirq+0x318/0x734 kernel/softirq.c:285
 run_ksoftirqd+0x70/0xa8 kernel/softirq.c:666
 smpboot_thread_fn+0x544/0x9d0 kernel/smpboot.c:164
 kthread+0x2f8/0x380 kernel/kthread.c:238
 ret_from_fork+0x10/0x18 arch/arm64/kernel/entry.S:1158
Code: d538d081 f9425a80 92800002 8b010000 (885f7c04) 
---[ end trace 577c2c0fbbf0d4d4 ]---
