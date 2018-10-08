Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AA6C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8C521479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+YDJ7ef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8C521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbeJIB4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:56:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730165AbeJIB4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:56:42 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26AC621479;
        Mon,  8 Oct 2018 18:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024216;
        bh=722hRECxJsd1Z5X4H9bUyazelq03IUpml87++cIkTgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u+YDJ7efWwk3do16eadj0j7T8nz1ltI0gCxB6uspL2/vPy9yvCDK2XveWkKP0KxLH
         A03AKCHSO8pV6r2h5221a11AxLQ/TW+VRoiDrh5qPgDIen/sT2trS1qVSmO2WzBrAN
         W2qePLDRMN6iCdAVGKR96RbeY5iWGu59wE5RF7Gk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 52/94] netfilter: nf_tables: release chain in flushing set
Date:   Mon,  8 Oct 2018 20:31:33 +0200
Message-Id: <20181008175607.699475628@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 7acfda539c0b9636a58bfee56abfb3aeee806d96 ]

When element of verdict map is deleted, the delete routine should
release chain. however, flush element of verdict map routine doesn't
release chain.

test commands:
   %nft add table ip filter
   %nft add chain ip filter c1
   %nft add map ip filter map1 { type ipv4_addr : verdict \; }
   %nft add element ip filter map1 { 1 : jump c1 }
   %nft flush map ip filter map1
   %nft flush ruleset

splat looks like:
[ 4895.170899] kernel BUG at net/netfilter/nf_tables_api.c:1415!
[ 4895.178114] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
[ 4895.178880] CPU: 0 PID: 1670 Comm: nft Not tainted 4.18.0+ #55
[ 4895.178880] RIP: 0010:nf_tables_chain_destroy.isra.28+0x39/0x220 [nf_tables]
[ 4895.178880] Code: fc ff df 53 48 89 fb 48 83 c7 50 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 09 3c 03 7f 05 e8 3e 4c 25 e1 8b 43 50 85 c0 74 02 <0f> 0b 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02
[ 4895.228342] RSP: 0018:ffff88010b98f4c0 EFLAGS: 00010202
[ 4895.234841] RAX: 0000000000000001 RBX: ffff8801131c6968 RCX: ffff8801146585b0
[ 4895.234841] RDX: 1ffff10022638d37 RSI: ffff8801191a9348 RDI: ffff8801131c69b8
[ 4895.234841] RBP: ffff8801146585a8 R08: 1ffff1002323526a R09: 0000000000000000
[ 4895.234841] R10: 0000000000000000 R11: 0000000000000000 R12: dead000000000200
[ 4895.234841] R13: dead000000000100 R14: ffffffffa3638af8 R15: dffffc0000000000
[ 4895.234841] FS:  00007f6d188e6700(0000) GS:ffff88011b600000(0000) knlGS:0000000000000000
[ 4895.234841] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4895.234841] CR2: 00007ffe72b8df88 CR3: 000000010e2d4000 CR4: 00000000001006f0
[ 4895.234841] Call Trace:
[ 4895.234841]  nf_tables_commit+0x2704/0x2c70 [nf_tables]
[ 4895.234841]  ? nfnetlink_rcv_batch+0xa4f/0x11b0 [nfnetlink]
[ 4895.234841]  ? nf_tables_setelem_notify.constprop.48+0x1a0/0x1a0 [nf_tables]
[ 4895.323824]  ? __lock_is_held+0x9d/0x130
[ 4895.323824]  ? kasan_unpoison_shadow+0x30/0x40
[ 4895.333299]  ? kasan_kmalloc+0xa9/0xc0
[ 4895.333299]  ? kmem_cache_alloc_trace+0x2c0/0x310
[ 4895.333299]  ? nfnetlink_rcv_batch+0xa4f/0x11b0 [nfnetlink]
[ 4895.333299]  nfnetlink_rcv_batch+0xdb9/0x11b0 [nfnetlink]
[ 4895.333299]  ? debug_show_all_locks+0x290/0x290
[ 4895.333299]  ? nfnetlink_net_init+0x150/0x150 [nfnetlink]
[ 4895.333299]  ? sched_clock_cpu+0xe5/0x170
[ 4895.333299]  ? sched_clock_local+0xff/0x130
[ 4895.333299]  ? sched_clock_cpu+0xe5/0x170
[ 4895.333299]  ? find_held_lock+0x39/0x1b0
[ 4895.333299]  ? sched_clock_local+0xff/0x130
[ 4895.333299]  ? memset+0x1f/0x40
[ 4895.333299]  ? nla_parse+0x33/0x260
[ 4895.333299]  ? ns_capable_common+0x6e/0x110
[ 4895.333299]  nfnetlink_rcv+0x2c0/0x310 [nfnetlink]
[ ... ]

Fixes: 591054469b3e ("netfilter: nf_tables: revisit chain/object refcounting from elements")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4250,6 +4250,7 @@ static int nft_flush_set(const struct nf
 	}
 	set->ndeact++;
 
+	nft_set_elem_deactivate(ctx->net, set, elem);
 	nft_trans_elem_set(trans) = set;
 	nft_trans_elem(trans) = *elem;
 	list_add_tail(&trans->list, &ctx->net->nft.commit_list);


