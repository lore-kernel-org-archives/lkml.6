Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9812EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD0120896
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD0120896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934197AbeGFFvQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:51:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33218 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933516AbeGFFvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:51:12 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B02FBBC6;
        Fri,  6 Jul 2018 05:51:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 33/61] netfilter: nf_tables: fix NULL-ptr in nf_tables_dump_obj()
Date:   Fri,  6 Jul 2018 07:46:57 +0200
Message-Id: <20180706054713.603352386@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Taehee Yoo <ap420073@gmail.com>

commit 360cc79d9d299ce297b205508276285ceffc5fa8 upstream.

The table field in nft_obj_filter is not an array. In order to check
tablename, we should check if the pointer is set.

Test commands:

   %nft add table ip filter
   %nft add counter ip filter ct1
   %nft reset counters

Splat looks like:

[  306.510504] kasan: CONFIG_KASAN_INLINE enabled
[  306.516184] kasan: GPF could be caused by NULL-ptr deref or user memory access
[  306.524775] general protection fault: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
[  306.528284] Modules linked in: nft_objref nft_counter nf_tables nfnetlink ip_tables x_tables
[  306.528284] CPU: 0 PID: 1488 Comm: nft Not tainted 4.17.0-rc4+ #17
[  306.528284] Hardware name: To be filled by O.E.M. To be filled by O.E.M./Aptio CRB, BIOS 5.6.5 07/08/2015
[  306.528284] RIP: 0010:nf_tables_dump_obj+0x52c/0xa70 [nf_tables]
[  306.528284] RSP: 0018:ffff8800b6cb7520 EFLAGS: 00010246
[  306.528284] RAX: 0000000000000000 RBX: ffff8800b6c49820 RCX: 0000000000000000
[  306.528284] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffffed0016d96e9a
[  306.528284] RBP: ffff8800b6cb75c0 R08: ffffed00236fce7c R09: ffffed00236fce7b
[  306.528284] R10: ffffffff9f6241e8 R11: ffffed00236fce7c R12: ffff880111365108
[  306.528284] R13: 0000000000000000 R14: ffff8800b6c49860 R15: ffff8800b6c49860
[  306.528284] FS:  00007f838b007700(0000) GS:ffff88011b600000(0000) knlGS:0000000000000000
[  306.528284] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  306.528284] CR2: 00007ffeafabcf78 CR3: 00000000b6cbe000 CR4: 00000000001006f0
[  306.528284] Call Trace:
[  306.528284]  netlink_dump+0x470/0xa20
[  306.528284]  __netlink_dump_start+0x5ae/0x690
[  306.528284]  ? nf_tables_getobj+0x1b3/0x740 [nf_tables]
[  306.528284]  nf_tables_getobj+0x2f5/0x740 [nf_tables]
[  306.528284]  ? nft_obj_notify+0x100/0x100 [nf_tables]
[  306.528284]  ? nf_tables_getobj+0x740/0x740 [nf_tables]
[  306.528284]  ? nf_tables_dump_flowtable_done+0x70/0x70 [nf_tables]
[  306.528284]  ? nft_obj_notify+0x100/0x100 [nf_tables]
[  306.528284]  nfnetlink_rcv_msg+0x8ff/0x932 [nfnetlink]
[  306.528284]  ? nfnetlink_rcv_msg+0x216/0x932 [nfnetlink]
[  306.528284]  netlink_rcv_skb+0x1c9/0x2f0
[  306.528284]  ? nfnetlink_bind+0x1d0/0x1d0 [nfnetlink]
[  306.528284]  ? debug_check_no_locks_freed+0x270/0x270
[  306.528284]  ? netlink_ack+0x7a0/0x7a0
[  306.528284]  ? ns_capable_common+0x6e/0x110
[ ... ]

Fixes: e46abbcc05aa8 ("netfilter: nf_tables: Allow table names of up to 255 chars")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4614,7 +4614,7 @@ static int nf_tables_dump_obj(struct sk_
 				if (idx > s_idx)
 					memset(&cb->args[1], 0,
 					       sizeof(cb->args) - sizeof(cb->args[0]));
-				if (filter && filter->table[0] &&
+				if (filter && filter->table &&
 				    strcmp(filter->table, table->name))
 					goto cont;
 				if (filter &&


