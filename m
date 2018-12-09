Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E8DC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2932220837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2932220837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbeLIVz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:55:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35684 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726603AbeLIVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:28 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72r-0002ik-84; Sun, 09 Dec 2018 21:55:25 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0003fM-OW; Sun, 09 Dec 2018 21:55:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Wei Wang" <weiwan@google.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.578820970@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 298/328] ipv6: take rcu lock in rawv6_send_hdrinc()
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Wang <weiwan@google.com>

commit a688caa34beb2fd2a92f1b6d33e40cde433ba160 upstream.

In rawv6_send_hdrinc(), in order to avoid an extra dst_hold(), we
directly assign the dst to skb and set passed in dst to NULL to avoid
double free.
However, in error case, we free skb and then do stats update with the
dst pointer passed in. This causes use-after-free on the dst.
Fix it by taking rcu read lock right before dst could get released to
make sure dst does not get freed until the stats update is done.
Note: we don't have this issue in ipv4 cause dst is not used for stats
update in v4.

Syzkaller reported following crash:
BUG: KASAN: use-after-free in rawv6_send_hdrinc net/ipv6/raw.c:692 [inline]
BUG: KASAN: use-after-free in rawv6_sendmsg+0x4421/0x4630 net/ipv6/raw.c:921
Read of size 8 at addr ffff8801d95ba730 by task syz-executor0/32088

CPU: 1 PID: 32088 Comm: syz-executor0 Not tainted 4.19.0-rc2+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
 print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
 __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
 rawv6_send_hdrinc net/ipv6/raw.c:692 [inline]
 rawv6_sendmsg+0x4421/0x4630 net/ipv6/raw.c:921
 inet_sendmsg+0x1a1/0x690 net/ipv4/af_inet.c:798
 sock_sendmsg_nosec net/socket.c:621 [inline]
 sock_sendmsg+0xd5/0x120 net/socket.c:631
 ___sys_sendmsg+0x7fd/0x930 net/socket.c:2114
 __sys_sendmsg+0x11d/0x280 net/socket.c:2152
 __do_sys_sendmsg net/socket.c:2161 [inline]
 __se_sys_sendmsg net/socket.c:2159 [inline]
 __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2159
 do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457099
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f83756edc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f83756ee6d4 RCX: 0000000000457099
RDX: 0000000000000000 RSI: 0000000020003840 RDI: 0000000000000004
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d4b30 R14: 00000000004c90b1 R15: 0000000000000000

Allocated by task 32088:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
 kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
 kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
 dst_alloc+0xbb/0x1d0 net/core/dst.c:105
 ip6_dst_alloc+0x35/0xa0 net/ipv6/route.c:353
 ip6_rt_cache_alloc+0x247/0x7b0 net/ipv6/route.c:1186
 ip6_pol_route+0x8f8/0xd90 net/ipv6/route.c:1895
 ip6_pol_route_output+0x54/0x70 net/ipv6/route.c:2093
 fib6_rule_lookup+0x277/0x860 net/ipv6/fib6_rules.c:122
 ip6_route_output_flags+0x2c5/0x350 net/ipv6/route.c:2121
 ip6_route_output include/net/ip6_route.h:88 [inline]
 ip6_dst_lookup_tail+0xe27/0x1d60 net/ipv6/ip6_output.c:951
 ip6_dst_lookup_flow+0xc8/0x270 net/ipv6/ip6_output.c:1079
 rawv6_sendmsg+0x12d9/0x4630 net/ipv6/raw.c:905
 inet_sendmsg+0x1a1/0x690 net/ipv4/af_inet.c:798
 sock_sendmsg_nosec net/socket.c:621 [inline]
 sock_sendmsg+0xd5/0x120 net/socket.c:631
 ___sys_sendmsg+0x7fd/0x930 net/socket.c:2114
 __sys_sendmsg+0x11d/0x280 net/socket.c:2152
 __do_sys_sendmsg net/socket.c:2161 [inline]
 __se_sys_sendmsg net/socket.c:2159 [inline]
 __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2159
 do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 5356:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
 kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
 __cache_free mm/slab.c:3498 [inline]
 kmem_cache_free+0x83/0x290 mm/slab.c:3756
 dst_destroy+0x267/0x3c0 net/core/dst.c:141
 dst_destroy_rcu+0x16/0x19 net/core/dst.c:154
 __rcu_reclaim kernel/rcu/rcu.h:236 [inline]
 rcu_do_batch kernel/rcu/tree.c:2576 [inline]
 invoke_rcu_callbacks kernel/rcu/tree.c:2880 [inline]
 __rcu_process_callbacks kernel/rcu/tree.c:2847 [inline]
 rcu_process_callbacks+0xf23/0x2670 kernel/rcu/tree.c:2864
 __do_softirq+0x30b/0xad8 kernel/softirq.c:292

Fixes: 1789a640f556 ("raw: avoid two atomics in xmit")
Signed-off-by: Wei Wang <weiwan@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - We don't set tstamp here
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -643,8 +643,6 @@ static int rawv6_send_hdrinc(struct sock
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->priority = sk->sk_priority;
 	skb->mark = sk->sk_mark;
-	skb_dst_set(skb, &rt->dst);
-	*dstp = NULL;
 
 	skb_put(skb, length);
 	skb_reset_network_header(skb);
@@ -654,24 +652,37 @@ static int rawv6_send_hdrinc(struct sock
 
 	skb->transport_header = skb->network_header;
 	err = memcpy_fromiovecend((void *)iph, from, 0, length);
-	if (err)
-		goto error_fault;
+	if (err) {
+		err = -EFAULT;
+		kfree_skb(skb);
+		goto error;
+	}
 
+	skb_dst_set(skb, &rt->dst);
+	*dstp = NULL;
+
+	/* Acquire rcu_read_lock() in case we need to use rt->rt6i_idev
+	 * in the error path. Since skb has been freed, the dst could
+	 * have been queued for deletion.
+	 */
+	rcu_read_lock();
 	IP6_UPD_PO_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUT, skb->len);
 	err = NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT, skb, NULL,
 		      rt->dst.dev, dst_output);
 	if (err > 0)
 		err = net_xmit_errno(err);
-	if (err)
-		goto error;
+	if (err) {
+		IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTDISCARDS);
+		rcu_read_unlock();
+		goto error_check;
+	}
+	rcu_read_unlock();
 out:
 	return 0;
 
-error_fault:
-	err = -EFAULT;
-	kfree_skb(skb);
 error:
 	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTDISCARDS);
+error_check:
 	if (err == -ENOBUFS && !np->recverr)
 		err = 0;
 	return err;

