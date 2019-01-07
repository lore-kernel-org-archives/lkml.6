Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7978DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E2D2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866035;
	bh=XpXBBcDpBoz6zn9QVcn6U5nSdgTzozie1ng1aBJM8h8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Abx8HFrobxVEK89yWeCNtnK4g3NWvKHCyWJ89ATdarvIvpRV5o0iFWATM4GeULYaD
	 DwNMcUuZQ5+I0XpLulKHBzaIEGC5vY6LPluDtCFc0yjsLlo41rzSMcMJdGCTrLhxPK
	 o8rJya8Ioz3dulC4RXKQY4fKCElPYGp2FzAEtkfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfAGNAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:00:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730196AbfAGNAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:00:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A0552173C;
        Mon,  7 Jan 2019 13:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866030;
        bh=XpXBBcDpBoz6zn9QVcn6U5nSdgTzozie1ng1aBJM8h8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WgoRkk8lwYL4P64dRMozhDW3gcVWvUT10Lleoc5gaeRmjekcMAd7rYSY0L0+FL1o8
         Aj//HuwaBBZRwCWVzhbBfYmZb3laVyjdFuobdNQZ2Son28J+gi80+9nT3o1uazsPWl
         oOvk5NK9K8PJ34AlOfjrN6kI4MwoMD53gp6BWxts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 022/101] tcp: fix a race in inet_diag_dump_icsk()
Date:   Mon,  7 Jan 2019 13:32:10 +0100
Message-Id: <20190107105334.160445756@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f0c928d878e7d01b613c9ae5c971a6b1e473a938 ]

Alexei reported use after frees in inet_diag_dump_icsk() [1]

Because we use refcount_set() when various sockets are setup and
inserted into ehash, we also need to make sure inet_diag_dump_icsk()
wont race with the refcount_set() operations.

Jonathan Lemon sent a patch changing net_twsk_hashdance() but
other spots would need risky changes.

Instead, fix inet_diag_dump_icsk() as this bug came with
linux-4.10 only.

[1] Quoting Alexei :

First something iterating over sockets finds already freed tw socket:

refcount_t: increment on 0; use-after-free.
WARNING: CPU: 2 PID: 2738 at lib/refcount.c:153 refcount_inc+0x26/0x30
RIP: 0010:refcount_inc+0x26/0x30
RSP: 0018:ffffc90004c8fbc0 EFLAGS: 00010282
RAX: 000000000000002b RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88085ee9d680 RSI: ffff88085ee954c8 RDI: ffff88085ee954c8
RBP: ffff88010ecbd2c0 R08: 0000000000000000 R09: 000000000000174c
R10: ffffffff81e7c5a0 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8806ba9bf210 R14: ffffffff82304600 R15: ffff88010ecbd328
FS:  00007f81f5a7d700(0000) GS:ffff88085ee80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f81e2a95000 CR3: 000000069b2eb006 CR4: 00000000003606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 inet_diag_dump_icsk+0x2b3/0x4e0 [inet_diag]  // sock_hold(sk); in net/ipv4/inet_diag.c:1002
 ? kmalloc_large_node+0x37/0x70
 ? __kmalloc_node_track_caller+0x1cb/0x260
 ? __alloc_skb+0x72/0x1b0
 ? __kmalloc_reserve.isra.40+0x2e/0x80
 __inet_diag_dump+0x3b/0x80 [inet_diag]
 netlink_dump+0x116/0x2a0
 netlink_recvmsg+0x205/0x3c0
 sock_read_iter+0x89/0xd0
 __vfs_read+0xf7/0x140
 vfs_read+0x8a/0x140
 SyS_read+0x3f/0xa0
 do_syscall_64+0x5a/0x100

then a minute later twsk timer fires and hits two bad refcnts
for this freed socket:

refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 31 PID: 0 at lib/refcount.c:228 refcount_dec+0x2e/0x40
Modules linked in:
RIP: 0010:refcount_dec+0x2e/0x40
RSP: 0018:ffff88085f5c3ea8 EFLAGS: 00010296
RAX: 000000000000002c RBX: ffff88010ecbd2c0 RCX: 000000000000083f
RDX: 0000000000000000 RSI: 00000000000000f6 RDI: 000000000000003f
RBP: ffffc90003c77280 R08: 0000000000000000 R09: 00000000000017d3
R10: ffffffff81e7c5a0 R11: 0000000000000000 R12: ffffffff82ad2d80
R13: ffffffff8182de00 R14: ffff88085f5c3ef8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88085f5c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbe42685250 CR3: 0000000002209001 CR4: 00000000003606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 inet_twsk_kill+0x9d/0xc0  // inet_twsk_bind_unhash(tw, hashinfo);
 call_timer_fn+0x29/0x110
 run_timer_softirq+0x36b/0x3a0

refcount_t: underflow; use-after-free.
WARNING: CPU: 31 PID: 0 at lib/refcount.c:187 refcount_sub_and_test+0x46/0x50
RIP: 0010:refcount_sub_and_test+0x46/0x50
RSP: 0018:ffff88085f5c3eb8 EFLAGS: 00010296
RAX: 0000000000000026 RBX: ffff88010ecbd2c0 RCX: 000000000000083f
RDX: 0000000000000000 RSI: 00000000000000f6 RDI: 000000000000003f
RBP: ffff88010ecbd358 R08: 0000000000000000 R09: 000000000000185b
R10: ffffffff81e7c5a0 R11: 0000000000000000 R12: ffff88010ecbd358
R13: ffffffff8182de00 R14: ffff88085f5c3ef8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88085f5c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbe42685250 CR3: 0000000002209001 CR4: 00000000003606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 inet_twsk_put+0x12/0x20  // inet_twsk_put(tw);
 call_timer_fn+0x29/0x110
 run_timer_softirq+0x36b/0x3a0

Fixes: 67db3e4bfbc9 ("tcp: no longer hold ehash lock while calling tcp_get_info()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Alexei Starovoitov <ast@kernel.org>
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>
Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/inet_diag.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -991,7 +991,9 @@ next_chunk:
 			if (!inet_diag_bc_sk(bc, sk))
 				goto next_normal;
 
-			sock_hold(sk);
+			if (!refcount_inc_not_zero(&sk->sk_refcnt))
+				goto next_normal;
+
 			num_arr[accum] = num;
 			sk_arr[accum] = sk;
 			if (++accum == SKARR_SZ)


