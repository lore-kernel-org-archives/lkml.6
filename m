Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B584C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAD8208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791380;
	bh=NfFg36CY4k29j8xsgFfx0T6bJ+Oq/UU7Dm3dAYUgrRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hna/Opo6EYzTiWLGttZSVoBglRr/X3R3fuoOAUL+RrU/1Zb2RxjhszgHyYUb/3xC+
	 +2AeVOYupYqINHk+xelZ2LJuTMzixuvr5lp8lxq5rjG0U0kMy5yZ4RsCs9iAi2nHOX
	 WnwUh/gbRqQ3mLbvXTBtLqnbc/2ya76qjo5cNE1c=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAD8208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbeLNMCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:02:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730065AbeLNMCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 663402146F;
        Fri, 14 Dec 2018 12:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788950;
        bh=NfFg36CY4k29j8xsgFfx0T6bJ+Oq/UU7Dm3dAYUgrRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MWHHpHpyqBAwJJDOJd7naozMsmU1TM79pPRnulGKPwfFWDz3Ol0pMJ/pvqDTyhEhq
         GG9OymRLrB8sNWcDjcnXzf4Gt9NgSzuLeUoPtKbPf1vgnHCOOvNNkVEv442rOA2uEG
         WaHrJwUKP5T7P3iu2FZAHT3hQD1f18tSqKQDLgLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 036/142] netfilter: nf_conncount: use spin_lock_bh instead of spin_lock
Date:   Fri, 14 Dec 2018 12:58:41 +0100
Message-Id: <20181214115748.492248333@linuxfoundation.org>
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
2.19.1



