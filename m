Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE6AC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9273420876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9273420876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeJNXNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:13:48 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36340 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728201AbeJNXMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:05 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLr-0004cH-G6; Sun, 14 Oct 2018 16:30:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLX-0000VZ-6f; Sun, 14 Oct 2018 16:30:23 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Gerrit Renker" <gerrit@erg.abdn.ac.uk>,
        "syzbot" <syzkaller@googlegroups.com>, dccp@vger.kernel.org,
        "Eric Dumazet" <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.909258199@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 257/366] dccp: fix tasklet usage
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

commit a8d7aa17bbc970971ccdf71988ea19230ab368b1 upstream.

syzbot reported a crash in tasklet_action_common() caused by dccp.

dccp needs to make sure socket wont disappear before tasklet handler
has completed.

This patch takes a reference on the socket when arming the tasklet,
and moves the sock_put() from dccp_write_xmit_timer() to dccp_write_xmitlet()

kernel BUG at kernel/softirq.c:514!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 17 Comm: ksoftirqd/1 Not tainted 4.17.0-rc3+ #30
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:tasklet_action_common.isra.19+0x6db/0x700 kernel/softirq.c:515
RSP: 0018:ffff8801d9b3faf8 EFLAGS: 00010246
dccp_close: ABORT with 65423 bytes unread
RAX: 1ffff1003b367f6b RBX: ffff8801daf1f3f0 RCX: 0000000000000000
RDX: ffff8801cf895498 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffff8801d9b3fc40 R08: ffffed0039f12a95 R09: ffffed0039f12a94
dccp_close: ABORT with 65423 bytes unread
R10: ffffed0039f12a94 R11: ffff8801cf8954a3 R12: 0000000000000000
R13: ffff8801d9b3fc18 R14: dffffc0000000000 R15: ffff8801cf895490
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2bc28000 CR3: 00000001a08a9000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 tasklet_action+0x1d/0x20 kernel/softirq.c:533
 __do_softirq+0x2e0/0xaf5 kernel/softirq.c:285
dccp_close: ABORT with 65423 bytes unread
 run_ksoftirqd+0x86/0x100 kernel/softirq.c:646
 smpboot_thread_fn+0x417/0x870 kernel/smpboot.c:164
 kthread+0x345/0x410 kernel/kthread.c:238
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Code: 48 8b 85 e8 fe ff ff 48 8b 95 f0 fe ff ff e9 94 fb ff ff 48 89 95 f0 fe ff ff e8 81 53 6e 00 48 8b 95 f0 fe ff ff e9 62 fb ff ff <0f> 0b 48 89 cf 48 89 8d e8 fe ff ff e8 64 53 6e 00 48 8b 8d e8
RIP: tasklet_action_common.isra.19+0x6db/0x700 kernel/softirq.c:515 RSP: ffff8801d9b3faf8

Fixes: dc841e30eaea ("dccp: Extend CCID packet dequeueing interface")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Cc: dccp@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: Timer parameter is still an unsigned long]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/dccp/ccids/ccid2.c | 14 ++++++++++++--
 net/dccp/timer.c       |  2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

--- a/net/dccp/ccids/ccid2.c
+++ b/net/dccp/ccids/ccid2.c
@@ -126,6 +126,16 @@ static void ccid2_change_l_seq_window(st
 						  DCCPF_SEQ_WMAX));
 }
 
+static void dccp_tasklet_schedule(struct sock *sk)
+{
+	struct tasklet_struct *t = &dccp_sk(sk)->dccps_xmitlet;
+
+	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
+		sock_hold(sk);
+		__tasklet_schedule(t);
+	}
+}
+
 static void ccid2_hc_tx_rto_expire(unsigned long data)
 {
 	struct sock *sk = (struct sock *)data;
@@ -166,7 +176,7 @@ static void ccid2_hc_tx_rto_expire(unsig
 
 	/* if we were blocked before, we may now send cwnd=1 packet */
 	if (sender_was_blocked)
-		tasklet_schedule(&dccp_sk(sk)->dccps_xmitlet);
+		dccp_tasklet_schedule(sk);
 	/* restart backed-off timer */
 	sk_reset_timer(sk, &hc->tx_rtotimer, jiffies + hc->tx_rto);
 out:
@@ -706,7 +716,7 @@ static void ccid2_hc_tx_packet_recv(stru
 done:
 	/* check if incoming Acks allow pending packets to be sent */
 	if (sender_was_blocked && !ccid2_cwnd_network_limited(hc))
-		tasklet_schedule(&dccp_sk(sk)->dccps_xmitlet);
+		dccp_tasklet_schedule(sk);
 	dccp_ackvec_parsed_cleanup(&hc->tx_av_chunks);
 }
 
--- a/net/dccp/timer.c
+++ b/net/dccp/timer.c
@@ -252,12 +252,12 @@ static void dccp_write_xmitlet(unsigned
 	else
 		dccp_write_xmit(sk);
 	bh_unlock_sock(sk);
+	sock_put(sk);
 }
 
 static void dccp_write_xmit_timer(unsigned long data)
 {
 	dccp_write_xmitlet(data);
-	sock_put((struct sock *)data);
 }
 
 void dccp_init_xmit_timers(struct sock *sk)

