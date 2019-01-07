Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D27C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5352173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866092;
	bh=NRQ+MM4rkmO8QRd9yRbw2ieCvCkyOrMcMQSUhgg0EI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2k4EgEdj5jOy68cKqDAKOAsSkG+NVPk3PZtGO6yKyCxpxXV0NISzXBYCXW1XHjTbF
	 p7i3+AN7evAkOJJkm5IrdLSHpcmt/Tx8o0eUV6vslAdO7rmbcigk+u8KiSPzk/zjjl
	 nzch2ecRgsQaQJIBeZydsaSqXgQBjzYVMC0raJMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfAGNBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:01:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730619AbfAGNB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:01:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36C4F2089F;
        Mon,  7 Jan 2019 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866086;
        bh=NRQ+MM4rkmO8QRd9yRbw2ieCvCkyOrMcMQSUhgg0EI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zMb9l/7oEHRkIvQqdcLuXGVmmOUFxM/kZ0ItS5EQkk1oWyOJIpsM3AvhpLF9v1MhV
         GHiiqyu9EMXQLMCpVb22ouKq0/Hk87KtbZTPWvKxBVKtBCfOz4oasC+RXaQUBdPkkn
         tbQiqvWnvUYwScNT+HNmCXeddkOiNcT0XskwP4n0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 006/101] gro_cell: add napi_disable in gro_cells_destroy
Date:   Mon,  7 Jan 2019 13:31:54 +0100
Message-Id: <20190107105330.799502772@linuxfoundation.org>
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

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit 8e1da73acded4751a93d4166458a7e640f37d26c ]

Add napi_disable routine in gro_cells_destroy since starting from
commit c42858eaf492 ("gro_cells: remove spinlock protecting receive
queues") gro_cell_poll and gro_cells_destroy can run concurrently on
napi_skbs list producing a kernel Oops if the tunnel interface is
removed while gro_cell_poll is running. The following Oops has been
triggered removing a vxlan device while the interface is receiving
traffic

[ 5628.948853] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[ 5628.949981] PGD 0 P4D 0
[ 5628.950308] Oops: 0002 [#1] SMP PTI
[ 5628.950748] CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 4.20.0-rc6+ #41
[ 5628.952940] RIP: 0010:gro_cell_poll+0x49/0x80
[ 5628.955615] RSP: 0018:ffffc9000004fdd8 EFLAGS: 00010202
[ 5628.956250] RAX: 0000000000000000 RBX: ffffe8ffffc08150 RCX: 0000000000000000
[ 5628.957102] RDX: 0000000000000000 RSI: ffff88802356bf00 RDI: ffffe8ffffc08150
[ 5628.957940] RBP: 0000000000000026 R08: 0000000000000000 R09: 0000000000000000
[ 5628.958803] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000040
[ 5628.959661] R13: ffffe8ffffc08100 R14: 0000000000000000 R15: 0000000000000040
[ 5628.960682] FS:  0000000000000000(0000) GS:ffff88803ea00000(0000) knlGS:0000000000000000
[ 5628.961616] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5628.962359] CR2: 0000000000000008 CR3: 000000000221c000 CR4: 00000000000006b0
[ 5628.963188] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 5628.964034] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 5628.964871] Call Trace:
[ 5628.965179]  net_rx_action+0xf0/0x380
[ 5628.965637]  __do_softirq+0xc7/0x431
[ 5628.966510]  run_ksoftirqd+0x24/0x30
[ 5628.966957]  smpboot_thread_fn+0xc5/0x160
[ 5628.967436]  kthread+0x113/0x130
[ 5628.968283]  ret_from_fork+0x3a/0x50
[ 5628.968721] Modules linked in:
[ 5628.969099] CR2: 0000000000000008
[ 5628.969510] ---[ end trace 9d9dedc7181661fe ]---
[ 5628.970073] RIP: 0010:gro_cell_poll+0x49/0x80
[ 5628.972965] RSP: 0018:ffffc9000004fdd8 EFLAGS: 00010202
[ 5628.973611] RAX: 0000000000000000 RBX: ffffe8ffffc08150 RCX: 0000000000000000
[ 5628.974504] RDX: 0000000000000000 RSI: ffff88802356bf00 RDI: ffffe8ffffc08150
[ 5628.975462] RBP: 0000000000000026 R08: 0000000000000000 R09: 0000000000000000
[ 5628.976413] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000040
[ 5628.977375] R13: ffffe8ffffc08100 R14: 0000000000000000 R15: 0000000000000040
[ 5628.978296] FS:  0000000000000000(0000) GS:ffff88803ea00000(0000) knlGS:0000000000000000
[ 5628.979327] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5628.980044] CR2: 0000000000000008 CR3: 000000000221c000 CR4: 00000000000006b0
[ 5628.980929] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 5628.981736] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 5628.982409] Kernel panic - not syncing: Fatal exception in interrupt
[ 5628.983307] Kernel Offset: disabled

Fixes: c42858eaf492 ("gro_cells: remove spinlock protecting receive queues")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Acked-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/gro_cells.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -84,6 +84,7 @@ void gro_cells_destroy(struct gro_cells
 	for_each_possible_cpu(i) {
 		struct gro_cell *cell = per_cpu_ptr(gcells->cells, i);
 
+		napi_disable(&cell->napi);
 		netif_napi_del(&cell->napi);
 		__skb_queue_purge(&cell->napi_skbs);
 	}


