Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F71C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE9E2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788924;
	bh=wTY/i1Pil+En3cM6QReBPgSfN+FVgHe5nysM2HBkG0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iWjwC43jomTuhOcYCYFVHusmLUCHTL9dci3bk7nvImRkemA5xNmS1M1gaMYIbTuJL
	 q/ShIrMi3GCWEGNEw3Nw6yXaIxiouQk//thq5tRWU7q3SPPuyqfZXSM34mUj7K3oAr
	 h1LIThafhmFXATbXDmTqgQiu6/JOilrdpSr6+oRA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE9E2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbeLNMCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:02:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729918AbeLNMCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DDD62146F;
        Fri, 14 Dec 2018 12:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788919;
        bh=wTY/i1Pil+En3cM6QReBPgSfN+FVgHe5nysM2HBkG0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kceqkb4a1R6t7nh6xEFuE4D9MtRKHmul0xDTn2nGMqHWtFA8eaXF9fSsqfFgjQfbC
         GH7DI4C8SuQ84AJGWAxJZl6JB6ESL7PXC2ja57OlA9HV7PW1Z1T78+cQyNm26o9+//
         Zdxi6hMlg1W96fbYLY+7Ocb0AAkVWowoSC0WPVIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Tyler Hicks <tyhicks@canonical.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 009/142] net: Prevent invalid access to skb->prev in __qdisc_drop_all
Date:   Fri, 14 Dec 2018 12:58:14 +0100
Message-Id: <20181214115747.421377117@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

From: Christoph Paasch <cpaasch@apple.com>

[ Upstream commit 9410d386d0a829ace9558336263086c2fbbe8aed ]

__qdisc_drop_all() accesses skb->prev to get to the tail of the
segment-list.

With commit 68d2f84a1368 ("net: gro: properly remove skb from list")
the skb-list handling has been changed to set skb->next to NULL and set
the list-poison on skb->prev.

With that change, __qdisc_drop_all() will panic when it tries to
dereference skb->prev.

Since commit 992cba7e276d ("net: Add and use skb_list_del_init().")
__list_del_entry is used, leaving skb->prev unchanged (thus,
pointing to the list-head if it's the first skb of the list).
This will make __qdisc_drop_all modify the next-pointer of the list-head
and result in a panic later on:

[   34.501053] general protection fault: 0000 [#1] SMP KASAN PTI
[   34.501968] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.20.0-rc2.mptcp #108
[   34.502887] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.5.1 01/01/2011
[   34.504074] RIP: 0010:dev_gro_receive+0x343/0x1f90
[   34.504751] Code: e0 48 c1 e8 03 42 80 3c 30 00 0f 85 4a 1c 00 00 4d 8b 24 24 4c 39 65 d0 0f 84 0a 04 00 00 49 8d 7c 24 38 48 89 f8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 74 08 3c 04
[   34.507060] RSP: 0018:ffff8883af507930 EFLAGS: 00010202
[   34.507761] RAX: 0000000000000007 RBX: ffff8883970b2c80 RCX: 1ffff11072e165a6
[   34.508640] RDX: 1ffff11075867008 RSI: ffff8883ac338040 RDI: 0000000000000038
[   34.509493] RBP: ffff8883af5079d0 R08: ffff8883970b2d40 R09: 0000000000000062
[   34.510346] R10: 0000000000000034 R11: 0000000000000000 R12: 0000000000000000
[   34.511215] R13: 0000000000000000 R14: dffffc0000000000 R15: ffff8883ac338008
[   34.512082] FS:  0000000000000000(0000) GS:ffff8883af500000(0000) knlGS:0000000000000000
[   34.513036] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.513741] CR2: 000055ccc3e9d020 CR3: 00000003abf32000 CR4: 00000000000006e0
[   34.514593] Call Trace:
[   34.514893]  <IRQ>
[   34.515157]  napi_gro_receive+0x93/0x150
[   34.515632]  receive_buf+0x893/0x3700
[   34.516094]  ? __netif_receive_skb+0x1f/0x1a0
[   34.516629]  ? virtnet_probe+0x1b40/0x1b40
[   34.517153]  ? __stable_node_chain+0x4d0/0x850
[   34.517684]  ? kfree+0x9a/0x180
[   34.518067]  ? __kasan_slab_free+0x171/0x190
[   34.518582]  ? detach_buf+0x1df/0x650
[   34.519061]  ? lapic_next_event+0x5a/0x90
[   34.519539]  ? virtqueue_get_buf_ctx+0x280/0x7f0
[   34.520093]  virtnet_poll+0x2df/0xd60
[   34.520533]  ? receive_buf+0x3700/0x3700
[   34.521027]  ? qdisc_watchdog_schedule_ns+0xd5/0x140
[   34.521631]  ? htb_dequeue+0x1817/0x25f0
[   34.522107]  ? sch_direct_xmit+0x142/0xf30
[   34.522595]  ? virtqueue_napi_schedule+0x26/0x30
[   34.523155]  net_rx_action+0x2f6/0xc50
[   34.523601]  ? napi_complete_done+0x2f0/0x2f0
[   34.524126]  ? kasan_check_read+0x11/0x20
[   34.524608]  ? _raw_spin_lock+0x7d/0xd0
[   34.525070]  ? _raw_spin_lock_bh+0xd0/0xd0
[   34.525563]  ? kvm_guest_apic_eoi_write+0x6b/0x80
[   34.526130]  ? apic_ack_irq+0x9e/0xe0
[   34.526567]  __do_softirq+0x188/0x4b5
[   34.527015]  irq_exit+0x151/0x180
[   34.527417]  do_IRQ+0xdb/0x150
[   34.527783]  common_interrupt+0xf/0xf
[   34.528223]  </IRQ>

This patch makes sure that skb->prev is set to NULL when entering
netem_enqueue.

Cc: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
Cc: Tyler Hicks <tyhicks@canonical.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Fixes: 68d2f84a1368 ("net: gro: properly remove skb from list")
Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Christoph Paasch <cpaasch@apple.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_netem.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -441,6 +441,9 @@ static int netem_enqueue(struct sk_buff
 	int count = 1;
 	int rc = NET_XMIT_SUCCESS;
 
+	/* Do not fool qdisc_drop_all() */
+	skb->prev = NULL;
+
 	/* Random duplication */
 	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor))
 		++count;


