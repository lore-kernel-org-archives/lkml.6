Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id uw4lHilHGVvQOwAAmS7hNA
	; Thu, 07 Jun 2018 14:54:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 85023608BF; Thu,  7 Jun 2018 14:54:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E45CE601C3;
	Thu,  7 Jun 2018 14:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E45CE601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935400AbeFGOyx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:54:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41010 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935391AbeFGOyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:54:49 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbj-0005dI-HD; Thu, 07 Jun 2018 15:09:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb5-0002yF-59; Thu, 07 Jun 2018 15:09:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "syzbot" <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.80939009@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 185/410] net: igmp: add a missing rcu locking section
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -388,7 +388,11 @@ static struct sk_buff *igmpv3_newpack(st
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
