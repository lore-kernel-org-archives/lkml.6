Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2949C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D1220864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D1220864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935522AbeFRITh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:19:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54906 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935488AbeFRITf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:19:35 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 85437BAD;
        Mon, 18 Jun 2018 08:19:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 055/279] netfilter: nf_tables: fix out-of-bounds in nft_chain_commit_update
Date:   Mon, 18 Jun 2018 10:10:40 +0200
Message-Id: <20180618080611.115752044@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit d71efb599ad42ef1e564c652d8084252bdc85edf ]

When chain name is changed, nft_chain_commit_update is called.
In the nft_chain_commit_update, trans->ctx.chain->name has old chain name
and nft_trans_chain_name(trans) has new chain name.
If new chain name is longer than old chain name, KASAN warns
slab-out-of-bounds.

[  175.015012] BUG: KASAN: slab-out-of-bounds in strcpy+0x9e/0xb0
[  175.022735] Write of size 1 at addr ffff880114e022da by task iptables-compat/1458

[  175.031353] CPU: 0 PID: 1458 Comm: iptables-compat Not tainted 4.16.0-rc7+ #146
[  175.031353] Hardware name: To be filled by O.E.M. To be filled by O.E.M./Aptio CRB, BIOS 5.6.5 07/08/2015
[  175.031353] Call Trace:
[  175.031353]  dump_stack+0x68/0xa0
[  175.031353]  print_address_description+0xd0/0x260
[  175.031353]  ? strcpy+0x9e/0xb0
[  175.031353]  kasan_report+0x234/0x350
[  175.031353]  __asan_report_store1_noabort+0x1c/0x20
[  175.031353]  strcpy+0x9e/0xb0
[  175.031353]  nf_tables_commit+0x1ccc/0x2990
[  175.031353]  nfnetlink_rcv+0x141e/0x16c0
[  175.031353]  ? nfnetlink_net_init+0x150/0x150
[  175.031353]  ? lock_acquire+0x370/0x370
[  175.031353]  ? lock_acquire+0x370/0x370
[  175.031353]  netlink_unicast+0x444/0x640
[  175.031353]  ? netlink_attachskb+0x700/0x700
[  175.031353]  ? _copy_from_iter_full+0x180/0x740
[  175.031353]  ? kasan_check_write+0x14/0x20
[  175.031353]  ? _copy_from_user+0x9b/0xd0
[  175.031353]  netlink_sendmsg+0x845/0xc70
[ ... ]

Steps to reproduce:
   iptables-compat -N 1
   iptables-compat -E 1 aaaaaaaaa

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5741,7 +5741,7 @@ static void nft_chain_commit_update(stru
 	struct nft_base_chain *basechain;
 
 	if (nft_trans_chain_name(trans))
-		strcpy(trans->ctx.chain->name, nft_trans_chain_name(trans));
+		swap(trans->ctx.chain->name, nft_trans_chain_name(trans));
 
 	if (!nft_is_base_chain(trans->ctx.chain))
 		return;


