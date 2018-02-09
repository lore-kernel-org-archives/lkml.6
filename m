Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225M0AD0PRniAnSRHxyoHLANWpY9FQKFktgcc13C/mwiSnO/QNbTRsCET3zHFkPZV5kL5V5e
ARC-Seal: i=1; a=rsa-sha256; t=1518184002; cv=none;
        d=google.com; s=arc-20160816;
        b=MxoBSY5MMvdxOC1Q5bXB1QdcLFv3XbZ4rO7aT4gQBB0E9lt6NqUZmG3UZnTaNO5Svk
         QAASeBwc8zedRcY2xwcvQWveKmvRJZXKJn0Z231TrIxJXuJyuHNY93pQvubf9eTZeopz
         sxnt/kqiQJiSgV4uOC4l+zUg1KDhi6iiMkJJ4iohdLh+vj3OsDIPcKnCCcIjNtRwcSsG
         K+Vox8kIFd8I8qgZ6mNt0mY0pHqXczydgkQulORTPhOWrK5WrUgBD+NPei18pnabgWA7
         /XvuAosvajar3xXGdLLBjFjDN/TD1NMKh0eWv2Hfk20WRoj75P6LgOFtsyCvBha552OY
         t8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fxDOoaI4CuQ76Kq68YHyf1OCpPIE59W3sRY8b/0Ybko=;
        b=blurfvRvPyqHHc1o5JnhFhnozNvv5L0pQum6JN1LoomN2o/i1M5x/Z9xSybhuRAHJb
         ugmcL/rpx6okvt5kZv0bqO/Xzmb6pbEb04OaV/7b229x7Cx6T0Yr7jcoTVWxMZV7aAPn
         De7dbsJPoDIXuhIA+3gUy8T83lE86lYN5kb5FV/PdbIWXjmeYEDrUSSzvH9vasIdvdCO
         9OrBfXlNFW42IV9nHgaEHJ7VbeCVVRbktqvyruSSzt/laWAq93QfY1tjklQbF5v+sxW3
         OUJDnn8ApI/7+4whY6EaFwPkG50IN/OjLh4j4mWWjsbySH/X7VFR4XGWk8uo2xP6eksq
         9A2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 02/23] net: igmp: add a missing rcu locking section
Date: Fri,  9 Feb 2018 14:40:00 +0100
Message-Id: <20180209133938.499936166@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591930956543927304?=
X-GMAIL-MSGID: =?utf-8?q?1591931308209524121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit e7aadb27a5415e8125834b84a74477bfbee4eff5 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/igmp.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -386,7 +386,11 @@ static struct sk_buff *igmpv3_newpack(st
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
 	ip_select_ident(net, skb, NULL);
