Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CBDC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A5620892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791374;
	bh=9gP476RgejefkUA8qDreNsGkVgFgMte0QCk7+Goc8P4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iU+8CFGbyYAeYs7enMzwTlOhkTLCT0TQdBQCwcJX2dGsC0piAghtptBbscJsFgLAF
	 b3KTWpOLZfj0h1wlw/GqS26asrZ3Sjb9bYl5TsJfoXzBqYWBXgCr0h0t4KXJLmFE3H
	 /zvN31bH04qv4CRnNPYq8+NFa5FEZsLbxq9DqsEw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A5620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbeLNMCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:02:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730069AbeLNMCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A82A2145D;
        Fri, 14 Dec 2018 12:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788956;
        bh=9gP476RgejefkUA8qDreNsGkVgFgMte0QCk7+Goc8P4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x0Q1tRZqcOhgOF1lTnIOCK22MDDqH+AOkpDo5TUYB+gVFZfUOuNOLJDmqGDCrUEje
         3Q2+jvsYU7+j6EBOGPCgPyWuwv3G1561kXUH6HuvlmfwHfFSMVhJLOAHfn9mamacUU
         36GnzsU+NYyOAuUUSSO5kWEbTWOR7C8pb5Z19Nf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 037/142] netfilter: nf_conncount: fix list_del corruption in conn_free
Date:   Fri, 14 Dec 2018 12:58:42 +0100
Message-Id: <20181214115748.533172606@linuxfoundation.org>
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

[ Upstream commit 31568ec09ea02a050249921698c9729419539cce ]

nf_conncount_tuple is an element of nft_connlimit and that is deleted by
conn_free(). Elements can be deleted by both GC routine and data path
functions (nf_conncount_lookup, nf_conncount_add) and they call
conn_free() to free elements. But conn_free() only protects lists, not
each element. So that list_del corruption could occurred.

The conn_free() doesn't check whether element is already deleted. In
order to protect elements, dead flag is added. If an element is deleted,
dead flag is set. The only conn_free() can delete elements so that both
list lock and dead flag are enough to protect it.

test commands:
   %nft add table ip filter
   %nft add chain ip filter input { type filter hook input priority 0\; }
   %nft add rule filter input meter test { ip id ct count over 2 } counter

splat looks like:
[ 1779.495778] list_del corruption, ffff8800b6e12008->prev is LIST_POISON2 (dead000000000200)
[ 1779.505453] ------------[ cut here ]------------
[ 1779.506260] kernel BUG at lib/list_debug.c:50!
[ 1779.515831] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
[ 1779.516772] CPU: 0 PID: 33 Comm: kworker/0:2 Not tainted 4.19.0-rc6+ #22
[ 1779.516772] Workqueue: events_power_efficient nft_rhash_gc [nf_tables_set]
[ 1779.516772] RIP: 0010:__list_del_entry_valid+0xd8/0x150
[ 1779.516772] Code: 39 48 83 c4 08 b8 01 00 00 00 5b 5d c3 48 89 ea 48 c7 c7 00 c3 5b 98 e8 0f dc 40 ff 0f 0b 48 c7 c7 60 c3 5b 98 e8 01 dc 40 ff <0f> 0b 48 c7 c7 c0 c3 5b 98 e8 f3 db 40 ff 0f 0b 48 c7 c7 20 c4 5b
[ 1779.516772] RSP: 0018:ffff880119127420 EFLAGS: 00010286
[ 1779.516772] RAX: 000000000000004e RBX: dead000000000200 RCX: 0000000000000000
[ 1779.516772] RDX: 000000000000004e RSI: 0000000000000008 RDI: ffffed0023224e7a
[ 1779.516772] RBP: ffff88011934bc10 R08: ffffed002367cea9 R09: ffffed002367cea9
[ 1779.516772] R10: 0000000000000001 R11: ffffed002367cea8 R12: ffff8800b6e12008
[ 1779.516772] R13: ffff8800b6e12010 R14: ffff88011934bc20 R15: ffff8800b6e12008
[ 1779.516772] FS:  0000000000000000(0000) GS:ffff88011b200000(0000) knlGS:0000000000000000
[ 1779.516772] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1779.516772] CR2: 00007fc876534010 CR3: 000000010da16000 CR4: 00000000001006f0
[ 1779.516772] Call Trace:
[ 1779.516772]  conn_free+0x9f/0x2b0 [nf_conncount]
[ 1779.516772]  ? nf_ct_tmpl_alloc+0x2a0/0x2a0 [nf_conntrack]
[ 1779.516772]  ? nf_conncount_add+0x520/0x520 [nf_conncount]
[ 1779.516772]  ? do_raw_spin_trylock+0x1a0/0x1a0
[ 1779.516772]  ? do_raw_spin_trylock+0x10/0x1a0
[ 1779.516772]  find_or_evict+0xe5/0x150 [nf_conncount]
[ 1779.516772]  nf_conncount_gc_list+0x162/0x360 [nf_conncount]
[ 1779.516772]  ? nf_conncount_lookup+0xee0/0xee0 [nf_conncount]
[ 1779.516772]  ? _raw_spin_unlock_irqrestore+0x45/0x50
[ 1779.516772]  ? trace_hardirqs_off+0x6b/0x220
[ 1779.516772]  ? trace_hardirqs_on_caller+0x220/0x220
[ 1779.516772]  nft_rhash_gc+0x16b/0x540 [nf_tables_set]
[ ... ]

Fixes: 5c789e131cbb ("netfilter: nf_conncount: Add list lock and gc worker, and RCU for init tree search")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conncount.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index 71b1f4f99580..cb33709138df 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -49,6 +49,7 @@ struct nf_conncount_tuple {
 	struct nf_conntrack_zone	zone;
 	int				cpu;
 	u32				jiffies32;
+	bool				dead;
 	struct rcu_head			rcu_head;
 };
 
@@ -106,6 +107,7 @@ nf_conncount_add(struct nf_conncount_list *list,
 	conn->zone = *zone;
 	conn->cpu = raw_smp_processor_id();
 	conn->jiffies32 = (u32)jiffies;
+	conn->dead = false;
 	spin_lock_bh(&list->list_lock);
 	if (list->dead == true) {
 		kmem_cache_free(conncount_conn_cachep, conn);
@@ -134,12 +136,13 @@ static bool conn_free(struct nf_conncount_list *list,
 
 	spin_lock_bh(&list->list_lock);
 
-	if (list->count == 0) {
+	if (conn->dead) {
 		spin_unlock_bh(&list->list_lock);
-                return free_entry;
+		return free_entry;
 	}
 
 	list->count--;
+	conn->dead = true;
 	list_del_rcu(&conn->node);
 	if (list->count == 0)
 		free_entry = true;
-- 
2.19.1



