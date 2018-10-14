Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4ADC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E0A20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E0A20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbeJNXL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36076 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727761AbeJNXL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:56 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLj-0004cU-Ow; Sun, 14 Oct 2018 16:30:36 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLZ-0000hm-Q2; Sun, 14 Oct 2018 16:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Neal Cardwell" <ncardwell@google.com>,
        "syzbot" <syzkaller@googlegroups.com>,
        "Yuchung Cheng" <ycheng@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.93523851@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 323/366] tcp: purge write queue in tcp_connect_init()
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 7f582b248d0a86bae5788c548d7bb5bca6f7691a upstream.

syzkaller found a reliable way to crash the host, hitting a BUG()
in __tcp_retransmit_skb()

Malicous MSG_FASTOPEN is the root cause. We need to purge write queue
in tcp_connect_init() at the point we init snd_una/write_seq.

This patch also replaces the BUG() by a less intrusive WARN_ON_ONCE()

kernel BUG at net/ipv4/tcp_output.c:2837!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 5276 Comm: syz-executor0 Not tainted 4.17.0-rc3+ #51
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__tcp_retransmit_skb+0x2992/0x2eb0 net/ipv4/tcp_output.c:2837
RSP: 0000:ffff8801dae06ff8 EFLAGS: 00010206
RAX: ffff8801b9fe61c0 RBX: 00000000ffc18a16 RCX: ffffffff864e1a49
RDX: 0000000000000100 RSI: ffffffff864e2e12 RDI: 0000000000000005
RBP: ffff8801dae073a0 R08: ffff8801b9fe61c0 R09: ffffed0039c40dd2
R10: ffffed0039c40dd2 R11: ffff8801ce206e93 R12: 00000000421eeaad
R13: ffff8801ce206d4e R14: ffff8801ce206cc0 R15: ffff8801cd4f4a80
FS:  0000000000000000(0000) GS:ffff8801dae00000(0063) knlGS:00000000096bc900
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000001c47b6000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 tcp_retransmit_skb+0x2e/0x250 net/ipv4/tcp_output.c:2923
 tcp_retransmit_timer+0xc50/0x3060 net/ipv4/tcp_timer.c:488
 tcp_write_timer_handler+0x339/0x960 net/ipv4/tcp_timer.c:573
 tcp_write_timer+0x111/0x1d0 net/ipv4/tcp_timer.c:593
 call_timer_fn+0x230/0x940 kernel/time/timer.c:1326
 expire_timers kernel/time/timer.c:1363 [inline]
 __run_timers+0x79e/0xc50 kernel/time/timer.c:1666
 run_timer_softirq+0x4c/0x70 kernel/time/timer.c:1692
 __do_softirq+0x2e0/0xaf5 kernel/softirq.c:285
 invoke_softirq kernel/softirq.c:365 [inline]
 irq_exit+0x1d1/0x200 kernel/softirq.c:405
 exiting_irq arch/x86/include/asm/apic.h:525 [inline]
 smp_apic_timer_interrupt+0x17e/0x710 arch/x86/kernel/apic/apic.c:1052
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863

Fixes: cf60af03ca4e ("net-tcp: Fast Open client - sendmsg(MSG_FASTOPEN)")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Yuchung Cheng <ycheng@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/tcp_output.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2450,8 +2450,10 @@ int __tcp_retransmit_skb(struct sock *sk
 		return -EBUSY;
 
 	if (before(TCP_SKB_CB(skb)->seq, tp->snd_una)) {
-		if (before(TCP_SKB_CB(skb)->end_seq, tp->snd_una))
-			BUG();
+		if (unlikely(before(TCP_SKB_CB(skb)->end_seq, tp->snd_una))) {
+			WARN_ON_ONCE(1);
+			return -EINVAL;
+		}
 		if (tcp_trim_head(sk, skb, tp->snd_una - TCP_SKB_CB(skb)->seq))
 			return -ENOMEM;
 	}
@@ -2948,6 +2950,7 @@ static void tcp_connect_init(struct sock
 	sock_reset_flag(sk, SOCK_DONE);
 	tp->snd_wnd = 0;
 	tcp_init_wl(tp, 0);
+	tcp_write_queue_purge(sk);
 	tp->snd_una = tp->write_seq;
 	tp->snd_sml = tp->write_seq;
 	tp->snd_up = tp->write_seq;

