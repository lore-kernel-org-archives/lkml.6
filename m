Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id LhoBCQdIGVudQAAAmS7hNA
	; Thu, 07 Jun 2018 15:08:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2F256601B4; Thu,  7 Jun 2018 15:08:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 476B8601B4;
	Thu,  7 Jun 2018 15:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 476B8601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936081AbeFGPIh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:08:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41522 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935927AbeFGPDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:03:40 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbS-0005hO-9s; Thu, 07 Jun 2018 15:09:26 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbB-0003C6-TZ; Thu, 07 Jun 2018 15:09:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Guillaume Nault" <g.nault@alphalink.fr>,
        "Eric Dumazet" <edumazet@google.com>,
        "syzbot" <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>,
        "James Chapman" <jchapman@katalix.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.168359152@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 330/410] l2tp: do not accept arbitrary sockets
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

commit 17cfe79a65f98abe535261856c5aef14f306dff7 upstream.

syzkaller found an issue caused by lack of sufficient checks
in l2tp_tunnel_create()

RAW sockets can not be considered as UDP ones for instance.

In another patch, we shall replace all pr_err() by less intrusive
pr_debug() so that syzkaller can find other bugs faster.
Acked-by: Guillaume Nault <g.nault@alphalink.fr>
Acked-by: James Chapman <jchapman@katalix.com>

==================================================================
BUG: KASAN: slab-out-of-bounds in setup_udp_tunnel_sock+0x3ee/0x5f0 net/ipv4/udp_tunnel.c:69
dst_release: dst:00000000d53d0d0f refcnt:-1
Write of size 1 at addr ffff8801d013b798 by task syz-executor3/6242

CPU: 1 PID: 6242 Comm: syz-executor3 Not tainted 4.16.0-rc2+ #253
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x194/0x24d lib/dump_stack.c:53
 print_address_description+0x73/0x250 mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report+0x23b/0x360 mm/kasan/report.c:412
 __asan_report_store1_noabort+0x17/0x20 mm/kasan/report.c:435
 setup_udp_tunnel_sock+0x3ee/0x5f0 net/ipv4/udp_tunnel.c:69
 l2tp_tunnel_create+0x1354/0x17f0 net/l2tp/l2tp_core.c:1596
 pppol2tp_connect+0x14b1/0x1dd0 net/l2tp/l2tp_ppp.c:707
 SYSC_connect+0x213/0x4a0 net/socket.c:1640
 SyS_connect+0x24/0x30 net/socket.c:1621
 do_syscall_64+0x280/0x940 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x42/0xb7

Fixes: fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1581,9 +1581,14 @@ int l2tp_tunnel_create(struct net *net,
 		encap = cfg->encap;
 
 	/* Quick sanity checks */
+	err = -EPROTONOSUPPORT;
+	if (sk->sk_type != SOCK_DGRAM) {
+		pr_debug("tunl %hu: fd %d wrong socket type\n",
+			 tunnel_id, fd);
+		goto err;
+	}
 	switch (encap) {
 	case L2TP_ENCAPTYPE_UDP:
-		err = -EPROTONOSUPPORT;
 		if (sk->sk_protocol != IPPROTO_UDP) {
 			pr_err("tunl %hu: fd %d wrong protocol, got %d, expected %d\n",
 			       tunnel_id, fd, sk->sk_protocol, IPPROTO_UDP);
@@ -1591,7 +1596,6 @@ int l2tp_tunnel_create(struct net *net,
 		}
 		break;
 	case L2TP_ENCAPTYPE_IP:
-		err = -EPROTONOSUPPORT;
 		if (sk->sk_protocol != IPPROTO_L2TP) {
 			pr_err("tunl %hu: fd %d wrong protocol, got %d, expected %d\n",
 			       tunnel_id, fd, sk->sk_protocol, IPPROTO_L2TP);
