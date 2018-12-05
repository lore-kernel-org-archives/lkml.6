Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE29C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2F520878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjQkN2fe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2F520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeLEJgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbeLEJgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:36:52 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BF5020850;
        Wed,  5 Dec 2018 09:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002611;
        bh=F8aNq/gbD7KtLF3mpx+acKuTnXwRJbL2PwOXAGlxNkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HjQkN2fewnuZgNGtoS86dOZZxClSo5Kgk0DGPsIgg3Xv8A6UZw7OWGAjDC9bjteIq
         yabLYq4QCUJYseLTKiBuogoWX3XTNMsC3gBLbBDX5J5m8YQ3S6QSuKaV6g/9Xwqd5e
         dy3U9FnoUhUL1MhBWYOkiiQHUEdna0QAWciXDO5U=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 017/123] netfilter: nf_conncount: use spin_lock_bh instead of spin_lock
Date:   Wed,  5 Dec 2018 04:34:09 -0500
Message-Id: <20181205093555.5386-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit fd3e71a9f71e232181a225301a75936373636ccc ]

conn_free() holds lock with spin_lock() and it is called by both
nf_conncount_lookup() and nf_conncount_gc_list(). nf_conncount_lookup()
is called from bottom-half context and nf_conncount_gc_list() from
process context. So that spin_lock() call is not safe. Hence
conn_free() should use spin_lock_bh() instead of spin_lock().

test commands:
   %nft add table ip filter
   %nft add chain ip filter input { type filter hook input priority 0\; }
   %nft add rule filter input meter test { ip saddr ct count over 2 } \
	   counter

splat looks like:
[  461.996507] ================================
[  461.998999] WARNING: inconsistent lock state
[  461.998999] 4.19.0-rc6+ #22 Not tainted
[  461.998999] --------------------------------
[  461.998999] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
[  461.998999] kworker/0:2/134 [HC0[0]:SC0[0]:HE1:SE1] takes:
[  461.998999] 00000000a71a559a (&(&list->list_lock)->rlock){+.?.}, at: conn_free+0x69/0x2b0 [nf_conncount]
[  461.998999] {IN-SOFTIRQ-W} state was registered at:
[  461.998999]   _raw_spin_lock+0x30/0x70
[  461.998999]   nf_conncount_add+0x28a/0x520 [nf_conncount]
[  461.998999]   nft_connlimit_eval+0x401/0x580 [nft_connlimit]
[  461.998999]   nft_dynset_eval+0x32b/0x590 [nf_tables]
[  461.998999]   nft_do_chain+0x497/0x1430 [nf_tables]
[  461.998999]   nft_do_chain_ipv4+0x255/0x330 [nf_tables]
[  461.998999]   nf_hook_slow+0xb1/0x160
[ ... ]
[  461.998999] other info that might help us debug this:
[  461.998999]  Possible unsafe locking scenario:
[  461.998999]
[  461.998999]        CPU0
[  461.998999]        ----
[  461.998999]   lock(&(&list->list_lock)->rlock);
[  461.998999]   <Interrupt>
[  461.998999]     lock(&(&list->list_lock)->rlock);
[  461.998999]
[  461.998999]  *** DEADLOCK ***
[  461.998999]
[ ... ]

Fixes: 5c789e131cbb ("netfilter: nf_conncount: Add list lock and gc worker, and RCU for init tree search")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conncount.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index 02ca7df793f5..71b1f4f99580 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -106,15 +106,15 @@ nf_conncount_add(struct nf_conncount_list *list,
 	conn->zone = *zone;
 	conn->cpu = raw_smp_processor_id();
 	conn->jiffies32 = (u32)jiffies;
-	spin_lock(&list->list_lock);
+	spin_lock_bh(&list->list_lock);
 	if (list->dead == true) {
 		kmem_cache_free(conncount_conn_cachep, conn);
-		spin_unlock(&list->list_lock);
+		spin_unlock_bh(&list->list_lock);
 		return NF_CONNCOUNT_SKIP;
 	}
 	list_add_tail(&conn->node, &list->head);
 	list->count++;
-	spin_unlock(&list->list_lock);
+	spin_unlock_bh(&list->list_lock);
 	return NF_CONNCOUNT_ADDED;
 }
 EXPORT_SYMBOL_GPL(nf_conncount_add);
@@ -132,10 +132,10 @@ static bool conn_free(struct nf_conncount_list *list,
 {
 	bool free_entry = false;
 
-	spin_lock(&list->list_lock);
+	spin_lock_bh(&list->list_lock);
 
 	if (list->count == 0) {
-		spin_unlock(&list->list_lock);
+		spin_unlock_bh(&list->list_lock);
                 return free_entry;
 	}
 
@@ -144,7 +144,7 @@ static bool conn_free(struct nf_conncount_list *list,
 	if (list->count == 0)
 		free_entry = true;
 
-	spin_unlock(&list->list_lock);
+	spin_unlock_bh(&list->list_lock);
 	call_rcu(&conn->rcu_head, __conn_free);
 	return free_entry;
 }
-- 
2.17.1

