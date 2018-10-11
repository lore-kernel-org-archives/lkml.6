Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2980CC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AC6205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AC6205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbeJKTb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:31:57 -0400
Received: from mail1.windriver.com ([147.11.146.13]:63727 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbeJKTb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:31:56 -0400
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w9BC4ji3023274
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 11 Oct 2018 05:04:45 -0700 (PDT)
Received: from pek-yxue-d1.wrs.com (128.224.155.90) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.408.0; Thu, 11 Oct 2018
 05:04:38 -0700
From:   Ying Xue <ying.xue@windriver.com>
To:     <jon.maloy@ericsson.com>, <dvyukov@google.com>
CC:     <davem@davemloft.net>, <parthasarathy.bhuvaragan@ericsson.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tipc-discussion@lists.sourceforge.net>
Subject: [PATCH net] tipc: eliminate possible recursive locking detected by LOCKDEP
Date:   Thu, 11 Oct 2018 19:57:56 +0800
Message-ID: <1539259076-8562-1-git-send-email-ying.xue@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting kernel with LOCKDEP option, below warning info was found:

WARNING: possible recursive locking detected
4.19.0-rc7+ #14 Not tainted
--------------------------------------------
swapper/0/1 is trying to acquire lock:
00000000dcfc0fc8 (&(&list->lock)->rlock#4){+...}, at: spin_lock_bh
include/linux/spinlock.h:334 [inline]
00000000dcfc0fc8 (&(&list->lock)->rlock#4){+...}, at:
tipc_link_reset+0x125/0xdf0 net/tipc/link.c:850

but task is already holding lock:
00000000cbb9b036 (&(&list->lock)->rlock#4){+...}, at: spin_lock_bh
include/linux/spinlock.h:334 [inline]
00000000cbb9b036 (&(&list->lock)->rlock#4){+...}, at:
tipc_link_reset+0xfa/0xdf0 net/tipc/link.c:849

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&(&list->lock)->rlock#4);
  lock(&(&list->lock)->rlock#4);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by swapper/0/1:
 #0: 00000000f7539d34 (pernet_ops_rwsem){+.+.}, at:
register_pernet_subsys+0x19/0x40 net/core/net_namespace.c:1051
 #1: 00000000cbb9b036 (&(&list->lock)->rlock#4){+...}, at:
spin_lock_bh include/linux/spinlock.h:334 [inline]
 #1: 00000000cbb9b036 (&(&list->lock)->rlock#4){+...}, at:
tipc_link_reset+0xfa/0xdf0 net/tipc/link.c:849

stack backtrace:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc7+ #14
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1af/0x295 lib/dump_stack.c:113
 print_deadlock_bug kernel/locking/lockdep.c:1759 [inline]
 check_deadlock kernel/locking/lockdep.c:1803 [inline]
 validate_chain kernel/locking/lockdep.c:2399 [inline]
 __lock_acquire+0xf1e/0x3c60 kernel/locking/lockdep.c:3411
 lock_acquire+0x1db/0x520 kernel/locking/lockdep.c:3900
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
 _raw_spin_lock_bh+0x31/0x40 kernel/locking/spinlock.c:168
 spin_lock_bh include/linux/spinlock.h:334 [inline]
 tipc_link_reset+0x125/0xdf0 net/tipc/link.c:850
 tipc_link_bc_create+0xb5/0x1f0 net/tipc/link.c:526
 tipc_bcast_init+0x59b/0xab0 net/tipc/bcast.c:521
 tipc_init_net+0x472/0x610 net/tipc/core.c:82
 ops_init+0xf7/0x520 net/core/net_namespace.c:129
 __register_pernet_operations net/core/net_namespace.c:940 [inline]
 register_pernet_operations+0x453/0xac0 net/core/net_namespace.c:1011
 register_pernet_subsys+0x28/0x40 net/core/net_namespace.c:1052
 tipc_init+0x83/0x104 net/tipc/core.c:140
 do_one_initcall+0x109/0x70a init/main.c:885
 do_initcall_level init/main.c:953 [inline]
 do_initcalls init/main.c:961 [inline]
 do_basic_setup init/main.c:979 [inline]
 kernel_init_freeable+0x4bd/0x57f init/main.c:1144
 kernel_init+0x13/0x180 init/main.c:1063
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413

The reason why the noise above was complained by LOCKDEP is because we
nested to hold l->wakeupq.lock and l->inputq->lock in tipc_link_reset
function. In fact it's unnecessary to move skb buffer from l->wakeupq
queue to l->inputq queue while holding the two locks at the same time.
Instead, we can move skb buffers in l->wakeupq queue to a temporary
list first and then move the buffers of the temporary list to l->inputq
queue, which is also safe for us.

Fixes: 3f32d0be6c16 ("tipc: lock wakeup & inputq at tipc_link_reset()")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Ying Xue <ying.xue@windriver.com>
---
 net/tipc/link.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index fb886b5..1d21ae4 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -843,14 +843,21 @@ static void link_prepare_wakeup(struct tipc_link *l)
 
 void tipc_link_reset(struct tipc_link *l)
 {
+	struct sk_buff_head list;
+
+	__skb_queue_head_init(&list);
+
 	l->in_session = false;
 	l->session++;
 	l->mtu = l->advertised_mtu;
+
 	spin_lock_bh(&l->wakeupq.lock);
+	skb_queue_splice_init(&l->wakeupq, &list);
+	spin_unlock_bh(&l->wakeupq.lock);
+
 	spin_lock_bh(&l->inputq->lock);
-	skb_queue_splice_init(&l->wakeupq, l->inputq);
+	skb_queue_splice_init(&list, l->inputq);
 	spin_unlock_bh(&l->inputq->lock);
-	spin_unlock_bh(&l->wakeupq.lock);
 
 	__skb_queue_purge(&l->transmq);
 	__skb_queue_purge(&l->deferdq);
-- 
2.7.4

