Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE40C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678AD2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y88WoVt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678AD2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeLDK4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:56:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbeLDK4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:56:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE2922146D;
        Tue,  4 Dec 2018 10:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543920960;
        bh=UXIOhB0AtVtuZhkTjzNH0NZMYfjgobGgfBBM8krb84Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y88WoVt/C/xsIcCia+7NXJU7c0pdBiL8iEtN0VBs0I48up1Z1yog7bn9ZGLKn6IMn
         ZopBQw4e3msitfnix/U4kee1yGGsHV3DpvYrNGvDUd8IW6o2v5pTOe42CJN68RY12z
         vTMbmV9b7ScDZ1BQWSiErP+4QVJhMkO1J8rnqYP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ying Xue <ying.xue@windriver.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 026/139] tipc: fix lockdep warning during node delete
Date:   Tue,  4 Dec 2018 11:48:27 +0100
Message-Id: <20181204103651.053425177@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

From: Jon Maloy <donmalo99@gmail.com>

[ Upstream commit ec835f891232d7763dea9da0358f31e24ca6dfb7 ]

We see the following lockdep warning:

[ 2284.078521] ======================================================
[ 2284.078604] WARNING: possible circular locking dependency detected
[ 2284.078604] 4.19.0+ #42 Tainted: G            E
[ 2284.078604] ------------------------------------------------------
[ 2284.078604] rmmod/254 is trying to acquire lock:
[ 2284.078604] 00000000acd94e28 ((&n->timer)#2){+.-.}, at: del_timer_sync+0x5/0xa0
[ 2284.078604]
[ 2284.078604] but task is already holding lock:
[ 2284.078604] 00000000f997afc0 (&(&tn->node_list_lock)->rlock){+.-.}, at: tipc_node_stop+0xac/0x190 [tipc]
[ 2284.078604]
[ 2284.078604] which lock already depends on the new lock.
[ 2284.078604]
[ 2284.078604]
[ 2284.078604] the existing dependency chain (in reverse order) is:
[ 2284.078604]
[ 2284.078604] -> #1 (&(&tn->node_list_lock)->rlock){+.-.}:
[ 2284.078604]        tipc_node_timeout+0x20a/0x330 [tipc]
[ 2284.078604]        call_timer_fn+0xa1/0x280
[ 2284.078604]        run_timer_softirq+0x1f2/0x4d0
[ 2284.078604]        __do_softirq+0xfc/0x413
[ 2284.078604]        irq_exit+0xb5/0xc0
[ 2284.078604]        smp_apic_timer_interrupt+0xac/0x210
[ 2284.078604]        apic_timer_interrupt+0xf/0x20
[ 2284.078604]        default_idle+0x1c/0x140
[ 2284.078604]        do_idle+0x1bc/0x280
[ 2284.078604]        cpu_startup_entry+0x19/0x20
[ 2284.078604]        start_secondary+0x187/0x1c0
[ 2284.078604]        secondary_startup_64+0xa4/0xb0
[ 2284.078604]
[ 2284.078604] -> #0 ((&n->timer)#2){+.-.}:
[ 2284.078604]        del_timer_sync+0x34/0xa0
[ 2284.078604]        tipc_node_delete+0x1a/0x40 [tipc]
[ 2284.078604]        tipc_node_stop+0xcb/0x190 [tipc]
[ 2284.078604]        tipc_net_stop+0x154/0x170 [tipc]
[ 2284.078604]        tipc_exit_net+0x16/0x30 [tipc]
[ 2284.078604]        ops_exit_list.isra.8+0x36/0x70
[ 2284.078604]        unregister_pernet_operations+0x87/0xd0
[ 2284.078604]        unregister_pernet_subsys+0x1d/0x30
[ 2284.078604]        tipc_exit+0x11/0x6f2 [tipc]
[ 2284.078604]        __x64_sys_delete_module+0x1df/0x240
[ 2284.078604]        do_syscall_64+0x66/0x460
[ 2284.078604]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 2284.078604]
[ 2284.078604] other info that might help us debug this:
[ 2284.078604]
[ 2284.078604]  Possible unsafe locking scenario:
[ 2284.078604]
[ 2284.078604]        CPU0                    CPU1
[ 2284.078604]        ----                    ----
[ 2284.078604]   lock(&(&tn->node_list_lock)->rlock);
[ 2284.078604]                                lock((&n->timer)#2);
[ 2284.078604]                                lock(&(&tn->node_list_lock)->rlock);
[ 2284.078604]   lock((&n->timer)#2);
[ 2284.078604]
[ 2284.078604]  *** DEADLOCK ***
[ 2284.078604]
[ 2284.078604] 3 locks held by rmmod/254:
[ 2284.078604]  #0: 000000003368be9b (pernet_ops_rwsem){+.+.}, at: unregister_pernet_subsys+0x15/0x30
[ 2284.078604]  #1: 0000000046ed9c86 (rtnl_mutex){+.+.}, at: tipc_net_stop+0x144/0x170 [tipc]
[ 2284.078604]  #2: 00000000f997afc0 (&(&tn->node_list_lock)->rlock){+.-.}, at: tipc_node_stop+0xac/0x19
[...}

The reason is that the node timer handler sometimes needs to delete a
node which has been disconnected for too long. To do this, it grabs
the lock 'node_list_lock', which may at the same time be held by the
generic node cleanup function, tipc_node_stop(), during module removal.
Since the latter is calling del_timer_sync() inside the same lock, we
have a potential deadlock.

We fix this letting the timer cleanup function use spin_trylock()
instead of just spin_lock(), and when it fails to grab the lock it
just returns so that the timer handler can terminate its execution.
This is safe to do, since tipc_node_stop() anyway is about to
delete both the timer and the node instance.

Fixes: 6a939f365bdb ("tipc: Auto removal of peer down node instance")
Acked-by: Ying Xue <ying.xue@windriver.com>
Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/node.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -584,12 +584,15 @@ static void  tipc_node_clear_links(struc
 /* tipc_node_cleanup - delete nodes that does not
  * have active links for NODE_CLEANUP_AFTER time
  */
-static int tipc_node_cleanup(struct tipc_node *peer)
+static bool tipc_node_cleanup(struct tipc_node *peer)
 {
 	struct tipc_net *tn = tipc_net(peer->net);
 	bool deleted = false;
 
-	spin_lock_bh(&tn->node_list_lock);
+	/* If lock held by tipc_node_stop() the node will be deleted anyway */
+	if (!spin_trylock_bh(&tn->node_list_lock))
+		return false;
+
 	tipc_node_write_lock(peer);
 
 	if (!node_is_up(peer) && time_after(jiffies, peer->delete_at)) {


