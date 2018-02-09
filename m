Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184469-2-4329132333363270718
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
    t=1518184469; b=aFzfTzPRJhgkFDR2XVcU9yDIY+AEI+iBo7C3z2/zqza8E5s
    RbYOYizd6QechCu4HY9zxcYg3KfWhv8TMc4e/r4/gSpxLyi2QEur3Fa9CspoCc9J
    kaA52GmVV77jOlTo9sIf89XITYcWOL/kyza4C4r0FUYI6lY3pOUh1PDrtdMFESXK
    Elf2MAgAcEiG29bumSt6e2+SO4HCI4eL5u15/U1GfYyVbiqaXYYRGkYgaBI6raO4
    1lDNgYnb7BzE8SZu+hwu1QCX9q6nak8WSGH2DAjTNb2wv+oXBS5fK1wwAsx9+AUu
    NtsrHuKwFIOLwijtwIvYdXggONrZ/aEHLLp2+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184469; bh=o0X7OHthX46YuIhrXiBUTSp1gs
    U6H7de3lu3M3Su6/o=; b=ILoC9EisVk/qlkX8lYNYJQuuOpH/R+REI86lz5oOVX
    pKZldvFqpLBeWxeBo4OzFONN4kWCbrOKflOeNGBvDlI9AtFtyWRba77+Tsp/J65V
    hZf/XcKkdNknvGTry8E9ggj4tpVJkv2Pf2fo7NDaPUZOPCiF/oOEUf4NnSfcpHfQ
    OlTTRM8xCAdUsyggcfMUyUxqOwxe4cIVHji+u9xai4MbCtqzhVNVYDAvBoDswjDa
    y12kn726aICu7W8FuuxUDFQdMfeDPb1J+4GXsLACPEHQSjNT1g3bYTSAebT21EOi
    CGvHWI1G1ydkzIq4eVJdITLvAhMKSN9+SuNZFUjHEvaQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753437AbeBINyI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:54:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51978 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932117AbeBINpr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:45:47 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 05/22] net: igmp: add a missing rcu locking section
Date: Fri,  9 Feb 2018 14:39:54 +0100
Message-Id: <20180209133934.423549422@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
