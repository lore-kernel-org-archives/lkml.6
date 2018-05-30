Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753330AbeE3LRZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:17:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:32820 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752598AbeE3LHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:08 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Eric Dumazet" <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        "syzbot" <syzkaller@googlegroups.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.180345241@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 070/153] net: igmp: add a missing rcu locking section
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit e7aadb27a5415e8125834b84a74477bfbee4eff5 upstream.

Newly added igmpv3_get_srcaddr() needs to be called under rcu lock.

Timer callbacks do not ensure this locking.

=============================
WARNING: suspicious RCU usage
4.15.0+ #200 Not tainted
-----------------------------
./include/linux/inetdevice.h:216 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
3 locks held by syzkaller616973/4074:
 #0:  (&mm->mmap_sem){++++}, at: [<00000000bfce669e>] __do_page_fault+0x32d/0xc90 arch/x86/mm/fault.c:1355
 #1:  ((&im->timer)){+.-.}, at: [<00000000619d2f71>] lockdep_copy_map include/linux/lockdep.h:178 [inline]
 #1:  ((&im->timer)){+.-.}, at: [<00000000619d2f71>] call_timer_fn+0x1c6/0x820 kernel/time/timer.c:1316
 #2:  (&(&im->lock)->rlock){+.-.}, at: [<000000005f833c5c>] spin_lock_bh include/linux/spinlock.h:315 [inline]
 #2:  (&(&im->lock)->rlock){+.-.}, at: [<000000005f833c5c>] igmpv3_send_report+0x98/0x5b0 net/ipv4/igmp.c:600

stack backtrace:
CPU: 0 PID: 4074 Comm: syzkaller616973 Not tainted 4.15.0+ #200
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x194/0x257 lib/dump_stack.c:53
 lockdep_rcu_suspicious+0x123/0x170 kernel/locking/lockdep.c:4592
 __in_dev_get_rcu include/linux/inetdevice.h:216 [inline]
 igmpv3_get_srcaddr net/ipv4/igmp.c:329 [inline]
 igmpv3_newpack+0xeef/0x12e0 net/ipv4/igmp.c:389
 add_grhead.isra.27+0x235/0x300 net/ipv4/igmp.c:432
 add_grec+0xbd3/0x1170 net/ipv4/igmp.c:565
 igmpv3_send_report+0xd5/0x5b0 net/ipv4/igmp.c:605
 igmp_send_report+0xc43/0x1050 net/ipv4/igmp.c:722
 igmp_timer_expire+0x322/0x5c0 net/ipv4/igmp.c:831
 call_timer_fn+0x228/0x820 kernel/time/timer.c:1326
 expire_timers kernel/time/timer.c:1363 [inline]
 __run_timers+0x7ee/0xb70 kernel/time/timer.c:1666
 run_timer_softirq+0x4c/0x70 kernel/time/timer.c:1692
 __do_softirq+0x2d7/0xb85 kernel/softirq.c:285
 invoke_softirq kernel/softirq.c:365 [inline]
 irq_exit+0x1cc/0x200 kernel/softirq.c:405
 exiting_irq arch/x86/include/asm/apic.h:541 [inline]
 smp_apic_timer_interrupt+0x16b/0x700 arch/x86/kernel/apic/apic.c:1052
 apic_timer_interrupt+0xa9/0xb0 arch/x86/entry/entry_64.S:938

Fixes: a46182b00290 ("net: igmp: Use correct source address on IGMPv3 reports")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/igmp.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -363,7 +363,11 @@ static struct sk_buff *igmpv3_newpack(st
 	pip->frag_off = htons(IP_DF);
 	pip->ttl      = 1;
 	pip->daddr    = fl4.daddr;
+
+	rcu_read_lock();
 	pip->saddr    = igmpv3_get_srcaddr(dev, &fl4);
+	rcu_read_unlock();
+
 	pip->protocol = IPPROTO_IGMP;
 	pip->tot_len  = 0;	/* filled in later */
 	ip_select_ident(skb, NULL);
