Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CECC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2256D20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278071;
	bh=ilevQr29/1eO6yJDr1HSGYCLSTrGGw7rXrz3c5qosLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XmrBA7mFihhdvSYqcLeot481dED5XIg33cFZ2qS7s9hiHzCUDqYFzpFiUTorzG2Xv
	 WnW3t4cYhMXFaeQhwWAUIUw4uNfy33yNzN0rBw5axNRY/ADdglSeJT3+M0FCRvLcIN
	 QkjrPECkJ3Ccy2Kr90j4fP35WOcRLGa74e7rnNtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfBDKsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:48:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731808AbfBDKsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:48:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C222070C;
        Mon,  4 Feb 2019 10:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277299;
        bh=ilevQr29/1eO6yJDr1HSGYCLSTrGGw7rXrz3c5qosLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uZN8XEPxlef7tjShOb+oydZz4fLXwngWiQ7GfFJO3bSKe5ZZRohP1z4fw/ogd5Sa8
         D/LWpgVc5F6zcCSKrM1etk3OdTjc96r0stwTdywybPkFLON34tZlnzNU3H0NwLCjXG
         sdzzmHSy4kX3iw0GAT+n8Pfd3IQl2kJUJzqXCSUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nir Dotan <nird@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 22/74] ip6mr: Fix notifiers call on mroute_clean_tables()
Date:   Mon,  4 Feb 2019 11:36:35 +0100
Message-Id: <20190204103622.608116310@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nir Dotan <nird@mellanox.com>

[ Upstream commit 146820cc240f4389cf33481c058d9493aef95e25 ]

When the MC route socket is closed, mroute_clean_tables() is called to
cleanup existing routes. Mistakenly notifiers call was put on the cleanup
of the unresolved MC route entries cache.
In a case where the MC socket closes before an unresolved route expires,
the notifier call leads to a crash, caused by the driver trying to
increment a non initialized refcount_t object [1] and then when handling
is done, to decrement it [2]. This was detected by a test recently added in
commit 6d4efada3b82 ("selftests: forwarding: Add multicast routing test").

Fix that by putting notifiers call on the resolved entries traversal,
instead of on the unresolved entries traversal.

[1]

[  245.748967] refcount_t: increment on 0; use-after-free.
[  245.754829] WARNING: CPU: 3 PID: 3223 at lib/refcount.c:153 refcount_inc_checked+0x2b/0x30
...
[  245.802357] Hardware name: Mellanox Technologies Ltd. MSN2740/SA001237, BIOS 5.6.5 06/07/2016
[  245.811873] RIP: 0010:refcount_inc_checked+0x2b/0x30
...
[  245.907487] Call Trace:
[  245.910231]  mlxsw_sp_router_fib_event.cold.181+0x42/0x47 [mlxsw_spectrum]
[  245.917913]  notifier_call_chain+0x45/0x7
[  245.922484]  atomic_notifier_call_chain+0x15/0x20
[  245.927729]  call_fib_notifiers+0x15/0x30
[  245.932205]  mroute_clean_tables+0x372/0x3f
[  245.936971]  ip6mr_sk_done+0xb1/0xc0
[  245.940960]  ip6_mroute_setsockopt+0x1da/0x5f0
...

[2]

[  246.128487] refcount_t: underflow; use-after-free.
[  246.133859] WARNING: CPU: 0 PID: 7 at lib/refcount.c:187 refcount_sub_and_test_checked+0x4c/0x60
[  246.183521] Hardware name: Mellanox Technologies Ltd. MSN2740/SA001237, BIOS 5.6.5 06/07/2016
...
[  246.193062] Workqueue: mlxsw_core_ordered mlxsw_sp_router_fibmr_event_work [mlxsw_spectrum]
[  246.202394] RIP: 0010:refcount_sub_and_test_checked+0x4c/0x60
...
[  246.298889] Call Trace:
[  246.301617]  refcount_dec_and_test_checked+0x11/0x20
[  246.307170]  mlxsw_sp_router_fibmr_event_work.cold.196+0x47/0x78 [mlxsw_spectrum]
[  246.315531]  process_one_work+0x1fa/0x3f0
[  246.320005]  worker_thread+0x2f/0x3e0
[  246.324083]  kthread+0x118/0x130
[  246.327683]  ? wq_update_unbound_numa+0x1b0/0x1b0
[  246.332926]  ? kthread_park+0x80/0x80
[  246.337013]  ret_from_fork+0x1f/0x30

Fixes: 088aa3eec2ce ("ip6mr: Support fib notifications")
Signed-off-by: Nir Dotan <nird@mellanox.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6mr.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1506,6 +1506,9 @@ static void mroute_clean_tables(struct m
 			continue;
 		rhltable_remove(&mrt->mfc_hash, &c->mnode, ip6mr_rht_params);
 		list_del_rcu(&c->list);
+		call_ip6mr_mfc_entry_notifiers(read_pnet(&mrt->net),
+					       FIB_EVENT_ENTRY_DEL,
+					       (struct mfc6_cache *)c, mrt->id);
 		mr6_netlink_event(mrt, (struct mfc6_cache *)c, RTM_DELROUTE);
 		mr_cache_put(c);
 	}
@@ -1514,10 +1517,6 @@ static void mroute_clean_tables(struct m
 		spin_lock_bh(&mfc_unres_lock);
 		list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
 			list_del(&c->list);
-			call_ip6mr_mfc_entry_notifiers(read_pnet(&mrt->net),
-						       FIB_EVENT_ENTRY_DEL,
-						       (struct mfc6_cache *)c,
-						       mrt->id);
 			mr6_netlink_event(mrt, (struct mfc6_cache *)c,
 					  RTM_DELROUTE);
 			ip6mr_destroy_unres(mrt, (struct mfc6_cache *)c);


