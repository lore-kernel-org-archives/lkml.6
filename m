Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D497AC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98912214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789386;
	bh=NYoppy5cNTuvTgQ0sKRaobGJc20XkgCxYB63BRoc4ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DBg6y/YJmzRruh5t0XMB9a/YyA8KgB8EXQqfsePVgK6FpCbnfK8xAQvkAGB1RA3eH
	 y67Fl0jfXubss1sxbDbkjwsbtZNonVh/Ih0qMtOUCNxTiPWbmCXj5wkTa13WSCzcBu
	 b5wvXjY2VoTId8Ip8W2fwqLZ/G2dKRmXR/gPubHQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98912214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbeLNMJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:09:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:55388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730131AbeLNMJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:09:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5750D21486;
        Fri, 14 Dec 2018 12:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789379;
        bh=NYoppy5cNTuvTgQ0sKRaobGJc20XkgCxYB63BRoc4ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tSKSPqnZYaVaNYXoKody/UBErRvUtbfuiHa+xipi09LuaoN/ptfEhFYsToEjD3aZC
         6q4pf1u2f/9kAKcOjyAfADA2eeTfODi0/TZUvsROz69om6zw9GKcfpsZaxsamaXtJH
         C4ROecTb5CsedizNov/vCsoHtiBiTbuCrkFLD3tE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 59/89] netfilter: nf_tables: deactivate expressions in rule replecement routine
Date:   Fri, 14 Dec 2018 13:00:12 +0100
Message-Id: <20181214115732.584176166@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

[ Upstream commit ca08987885a147643817d02bf260bc4756ce8cd4 ]

There is no expression deactivation call from the rule replacement path,
hence, chain counter is not decremented. A few steps to reproduce the
problem:

   %nft add table ip filter
   %nft add chain ip filter c1
   %nft add chain ip filter c1
   %nft add rule ip filter c1 jump c2
   %nft replace rule ip filter c1 handle 3 accept
   %nft flush ruleset

<jump c2> expression means immediate NFT_JUMP to chain c2.
Reference count of chain c2 is increased when the rule is added.

When rule is deleted or replaced, the reference counter of c2 should be
decreased via nft_rule_expr_deactivate() which calls
nft_immediate_deactivate().

Splat looks like:
[  214.396453] WARNING: CPU: 1 PID: 21 at net/netfilter/nf_tables_api.c:1432 nf_tables_chain_destroy.isra.38+0x2f9/0x3a0 [nf_tables]
[  214.398983] Modules linked in: nf_tables nfnetlink
[  214.398983] CPU: 1 PID: 21 Comm: kworker/1:1 Not tainted 4.20.0-rc2+ #44
[  214.398983] Workqueue: events nf_tables_trans_destroy_work [nf_tables]
[  214.398983] RIP: 0010:nf_tables_chain_destroy.isra.38+0x2f9/0x3a0 [nf_tables]
[  214.398983] Code: 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 8e 00 00 00 48 8b 7b 58 e8 e1 2c 4e c6 48 89 df e8 d9 2c 4e c6 eb 9a <0f> 0b eb 96 0f 0b e9 7e fe ff ff e8 a7 7e 4e c6 e9 a4 fe ff ff e8
[  214.398983] RSP: 0018:ffff8881152874e8 EFLAGS: 00010202
[  214.398983] RAX: 0000000000000001 RBX: ffff88810ef9fc28 RCX: ffff8881152876f0
[  214.398983] RDX: dffffc0000000000 RSI: 1ffff11022a50ede RDI: ffff88810ef9fc78
[  214.398983] RBP: 1ffff11022a50e9d R08: 0000000080000000 R09: 0000000000000000
[  214.398983] R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff11022a50eba
[  214.398983] R13: ffff888114446e08 R14: ffff8881152876f0 R15: ffffed1022a50ed6
[  214.398983] FS:  0000000000000000(0000) GS:ffff888116400000(0000) knlGS:0000000000000000
[  214.398983] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  214.398983] CR2: 00007fab9bb5f868 CR3: 000000012aa16000 CR4: 00000000001006e0
[  214.398983] Call Trace:
[  214.398983]  ? nf_tables_table_destroy.isra.37+0x100/0x100 [nf_tables]
[  214.398983]  ? __kasan_slab_free+0x145/0x180
[  214.398983]  ? nf_tables_trans_destroy_work+0x439/0x830 [nf_tables]
[  214.398983]  ? kfree+0xdb/0x280
[  214.398983]  nf_tables_trans_destroy_work+0x5f5/0x830 [nf_tables]
[ ... ]

Fixes: bb7b40aecbf7 ("netfilter: nf_tables: bogus EBUSY in chain deletions")
Reported by: Christoph Anton Mitterer <calestyo@scientia.net>
Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=914505
Link: https://bugzilla.kernel.org/show_bug.cgi?id=201791
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index ea1e57daf50e..623ec29ade26 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2400,21 +2400,14 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 	}
 
 	if (nlh->nlmsg_flags & NLM_F_REPLACE) {
-		if (!nft_is_active_next(net, old_rule)) {
-			err = -ENOENT;
-			goto err2;
-		}
-		trans = nft_trans_rule_add(&ctx, NFT_MSG_DELRULE,
-					   old_rule);
+		trans = nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule);
 		if (trans == NULL) {
 			err = -ENOMEM;
 			goto err2;
 		}
-		nft_deactivate_next(net, old_rule);
-		chain->use--;
-
-		if (nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule) == NULL) {
-			err = -ENOMEM;
+		err = nft_delrule(&ctx, old_rule);
+		if (err < 0) {
+			nft_trans_destroy(trans);
 			goto err2;
 		}
 
-- 
2.19.1



