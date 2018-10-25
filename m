Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF8EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8328F20854
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXVuT8t8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8328F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbeJYWr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728726AbeJYWr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:47:56 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B5922084A;
        Thu, 25 Oct 2018 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476899;
        bh=AwmCt0rSu7dXLN6W93U1bkeII823hEi4Ou1OOM1tzFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXVuT8t87g248tbP5IcGgkcs8PLdAT+aYecNsk+B5FZ+fY4y7ym9c2OEIel34aqiC
         Qits46R3NnYedJ57xDBN3IF1XubmH92Zmp40+dkgr07rnlaT2Mn5rLOc7LDT15xYAL
         cbqpuXqBLY8C2vnyNGdd7skm9lotcL45Bxeul4YA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ying Xue <ying.xue@windriver.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 22/98] tipc: fix a race condition of releasing subscriber object
Date:   Thu, 25 Oct 2018 10:13:07 -0400
Message-Id: <20181025141423.213774-22-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ying Xue <ying.xue@windriver.com>

[ Upstream commit fd849b7c41f0fabfe783d0691a63c5518e8ebc99 ]

No matter whether a request is inserted into workqueue as a work item
to cancel a subscription or to delete a subscription's subscriber
asynchronously, the work items may be executed in different workers.
As a result, it doesn't mean that one request which is raised prior to
another request is definitely handled before the latter. By contrast,
if the latter request is executed before the former request, below
error may happen:

[  656.183644] BUG: spinlock bad magic on CPU#0, kworker/u8:0/12117
[  656.184487] general protection fault: 0000 [#1] SMP
[  656.185160] Modules linked in: tipc ip6_udp_tunnel udp_tunnel 9pnet_virtio 9p 9pnet virtio_net virtio_pci virtio_ring virtio [last unloaded: ip6_udp_tunnel]
[  656.187003] CPU: 0 PID: 12117 Comm: kworker/u8:0 Not tainted 4.11.0-rc7+ #6
[  656.187920] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  656.188690] Workqueue: tipc_rcv tipc_recv_work [tipc]
[  656.189371] task: ffff88003f5cec40 task.stack: ffffc90004448000
[  656.190157] RIP: 0010:spin_bug+0xdd/0xf0
[  656.190678] RSP: 0018:ffffc9000444bcb8 EFLAGS: 00010202
[  656.191375] RAX: 0000000000000034 RBX: ffff88003f8d1388 RCX: 0000000000000000
[  656.192321] RDX: ffff88003ba13708 RSI: ffff88003ba0cd08 RDI: ffff88003ba0cd08
[  656.193265] RBP: ffffc9000444bcd0 R08: 0000000000000030 R09: 000000006b6b6b6b
[  656.194208] R10: ffff8800bde3e000 R11: 00000000000001b4 R12: 6b6b6b6b6b6b6b6b
[  656.195157] R13: ffffffff81a3ca64 R14: ffff88003f8d1388 R15: ffff88003f8d13a0
[  656.196101] FS:  0000000000000000(0000) GS:ffff88003ba00000(0000) knlGS:0000000000000000
[  656.197172] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  656.197935] CR2: 00007f0b3d2e6000 CR3: 000000003ef9e000 CR4: 00000000000006f0
[  656.198873] Call Trace:
[  656.199210]  do_raw_spin_lock+0x66/0xa0
[  656.199735]  _raw_spin_lock_bh+0x19/0x20
[  656.200258]  tipc_subscrb_subscrp_delete+0x28/0xf0 [tipc]
[  656.200990]  tipc_subscrb_rcv_cb+0x45/0x260 [tipc]
[  656.201632]  tipc_receive_from_sock+0xaf/0x100 [tipc]
[  656.202299]  tipc_recv_work+0x2b/0x60 [tipc]
[  656.202872]  process_one_work+0x157/0x420
[  656.203404]  worker_thread+0x69/0x4c0
[  656.203898]  kthread+0x138/0x170
[  656.204328]  ? process_one_work+0x420/0x420
[  656.204889]  ? kthread_create_on_node+0x40/0x40
[  656.205527]  ret_from_fork+0x29/0x40
[  656.206012] Code: 48 8b 0c 25 00 c5 00 00 48 c7 c7 f0 24 a3 81 48 81 c1 f0 05 00 00 65 8b 15 61 ef f5 7e e8 9a 4c 09 00 4d 85 e4 44 8b 4b 08 74 92 <45> 8b 84 24 40 04 00 00 49 8d 8c 24 f0 05 00 00 eb 8d 90 0f 1f
[  656.208504] RIP: spin_bug+0xdd/0xf0 RSP: ffffc9000444bcb8
[  656.209798] ---[ end trace e2a800e6eb0770be ]---

In above scenario, the request of deleting subscriber was performed
earlier than the request of canceling a subscription although the
latter was issued before the former, which means tipc_subscrb_delete()
was called before tipc_subscrp_cancel(). As a result, when
tipc_subscrb_subscrp_delete() called by tipc_subscrp_cancel() was
executed to cancel a subscription, the subscription's subscriber
refcnt had been decreased to 1. After tipc_subscrp_delete() where
the subscriber was freed because its refcnt was decremented to zero,
but the subscriber's lock had to be released, as a consequence, panic
happened.

By contrast, if we increase subscriber's refcnt before
tipc_subscrb_subscrp_delete() is called in tipc_subscrp_cancel(),
the panic issue can be avoided.

Fixes: d094c4d5f5c7 ("tipc: add subscription refcount to avoid invalid delete")
Reported-by: Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>
Signed-off-by: Ying Xue <ying.xue@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/subscr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/subscr.c b/net/tipc/subscr.c
index 271cd66e4b3b..c2646446e157 100644
--- a/net/tipc/subscr.c
+++ b/net/tipc/subscr.c
@@ -256,7 +256,9 @@ static void tipc_subscrp_delete(struct tipc_subscription *sub)
 static void tipc_subscrp_cancel(struct tipc_subscr *s,
 				struct tipc_subscriber *subscriber)
 {
+	tipc_subscrb_get(subscriber);
 	tipc_subscrb_subscrp_delete(subscriber, s);
+	tipc_subscrb_put(subscriber);
 }
 
 static struct tipc_subscription *tipc_subscrp_create(struct net *net,
-- 
2.17.1

