Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2241641-1518720650-2-12699997664943422987
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720650; b=jeYnKwPLpMs6m2ghN26Xh5RXwKAlegCGFcgRgmmf98gWmRM
    j6I1UTgtkaOwULdzaEWo1uSy4LKS/ahuSM+ZTjEMq0qoHPiZoSU/7ED82LUUkC51
    hdKHnQXPsz/UZbvOHuidgCwN+3ZEhR7ejfHZb/+PO3BQsdGvXxUavdyRflDMDUGf
    +bLx+LmfOMiCJWk7jWj3BD1wepKrLnScCKJMW0WS2ur6rZzMdg2Sbn7BCC6gjKKR
    C/rgW3YHP1hmBMMhmxwyd4Uu/DsoaPg2ezpI4Eibrry9bb0lCgtiPebkGVMFeA7g
    w5qaRSwVgOU3VtBMS8lBlv7CS+qakT8Vl4i3wwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720650; bh=JKkHUHQlKTclgLVYvQEqWyzAfB
    dnFJzio8t8Q1lf7Mc=; b=adIBempbyu6PgHZC9eGI6B7oXTW+fTWkxuHoxCvecG
    1vvLlw0UUSelvUAq5ptNBSqeIM9UXLQ0uXuKFaMPylrkBrbWn7HH2gEx5tQnXx8W
    qrucG2PgnAnrWlCn7BQNEVTUs7rDUnVGXtbiei7Y8+MvZTpL/5Pe+dd8qnIe4yS4
    dZknD3B1K61Vsy466xCKufiYIgOBBmz6iqCcFxBrkEyopYjNvrN5mahao3veM5xa
    2ndVF0GiyMYc2iWMYWK1224DpRb9BRQczkLSXRwgBaMVAqhRpXt/oHKf/PMrL3G8
    ibwYesO1Tt1nz1ed7oy8/0uCa+hTFvLimE4ReUptWaIQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161898AbeBOPVj (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:21:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162080AbeBOPVg (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:21:36 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 028/108] net: igmp: add a missing rcu locking section
Date: Thu, 15 Feb 2018 16:16:25 +0100
Message-Id: <20180215151226.414267434@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -392,7 +392,11 @@ static struct sk_buff *igmpv3_newpack(st
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
