Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90E8C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AF6217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866272;
	bh=9a2Ub2wUaexXd6c4x9e5CO6pUtKSivbKm5PauN/7UqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rsCd7uVOwp7DIhIXh04sit6FKAMhEbvzuEGECmW7cCLTKsd947hQRwZtuDyavqh6I
	 HGj1H/LF/9DC6+R/U6MmkP2dDh9UsrgF9NncvvM5q6FXppjRIxoq2otMMOBzO4Se5S
	 yyZ81A3elT1+8pt+HEFLRVilGRKawwWH9eZSXRqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbfAGNEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:04:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731179AbfAGNE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:04:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E92F52089F;
        Mon,  7 Jan 2019 13:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866268;
        bh=9a2Ub2wUaexXd6c4x9e5CO6pUtKSivbKm5PauN/7UqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bi12AorUFQZhwLFYRUz3x1mySDl+4qlDs31giPvMBwaLTwTZ8OD1pvMEHCae9zDNA
         U/W+/OZLB58lEY4KUOiIuUdBXkfrD32rKv2N/aFq7xKufm9+H1X/pbD8Dlm7/5HBiu
         e3D+DdbnjI9iaHFKU+bpiAWCvEc28EpS1bSGDU8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Andrianov <dmitry.andrianov@alertme.com>,
        Justin Pettit <jpettit@vmware.com>,
        Yi-Hung Wei <yihung.wei@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 083/101] netfilter: nf_conncount: fix garbage collection confirm race
Date:   Mon,  7 Jan 2019 13:33:11 +0100
Message-Id: <20190107105337.481551812@linuxfoundation.org>
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

commit b36e4523d4d56e2595e28f16f6ccf1cd6a9fc452 upstream.

Yi-Hung Wei and Justin Pettit found a race in the garbage collection scheme
used by nf_conncount.

When doing list walk, we lookup the tuple in the conntrack table.
If the lookup fails we remove this tuple from our list because
the conntrack entry is gone.

This is the common cause, but turns out its not the only one.
The list entry could have been created just before by another cpu, i.e. the
conntrack entry might not yet have been inserted into the global hash.

The avoid this, we introduce a timestamp and the owning cpu.
If the entry appears to be stale, evict only if:
 1. The current cpu is the one that added the entry, or,
 2. The timestamp is older than two jiffies

The second constraint allows GC to be taken over by other
cpu too (e.g. because a cpu was offlined or napi got moved to another
cpu).

We can't pretend the 'doubtful' entry wasn't in our list.
Instead, when we don't find an entry indicate via IS_ERR
that entry was removed ('did not exist' or withheld
('might-be-unconfirmed').

This most likely also fixes a xt_connlimit imbalance earlier reported by
Dmitry Andrianov.

Cc: Dmitry Andrianov <dmitry.andrianov@alertme.com>
Reported-by: Justin Pettit <jpettit@vmware.com>
Reported-by: Yi-Hung Wei <yihung.wei@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Acked-by: Yi-Hung Wei <yihung.wei@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

[mfo: backport: refresh context lines and use older symbol/file names:
 - nf_conncount.c -> xt_connlimit.c.
   - nf_conncount_rb -> xt_connlimit_rb
   - nf_conncount_tuple -> xt_connlimit_conn
   - conncount_conn_cachep -> connlimit_conn_cachep]
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_connlimit.c | 52 ++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/xt_connlimit.c b/net/netfilter/xt_connlimit.c
index ab1f849464fa..913b86ef3a8d 100644
--- a/net/netfilter/xt_connlimit.c
+++ b/net/netfilter/xt_connlimit.c
@@ -47,6 +47,8 @@ struct xt_connlimit_conn {
 	struct hlist_node		node;
 	struct nf_conntrack_tuple	tuple;
 	struct nf_conntrack_zone	zone;
+	int				cpu;
+	u32				jiffies32;
 };
 
 struct xt_connlimit_rb {
@@ -126,11 +128,42 @@ bool nf_conncount_add(struct hlist_head *head,
 		return false;
 	conn->tuple = *tuple;
 	conn->zone = *zone;
+	conn->cpu = raw_smp_processor_id();
+	conn->jiffies32 = (u32)jiffies;
 	hlist_add_head(&conn->node, head);
 	return true;
 }
 EXPORT_SYMBOL_GPL(nf_conncount_add);
 
+static const struct nf_conntrack_tuple_hash *
+find_or_evict(struct net *net, struct xt_connlimit_conn *conn)
+{
+	const struct nf_conntrack_tuple_hash *found;
+	unsigned long a, b;
+	int cpu = raw_smp_processor_id();
+	__s32 age;
+
+	found = nf_conntrack_find_get(net, &conn->zone, &conn->tuple);
+	if (found)
+		return found;
+	b = conn->jiffies32;
+	a = (u32)jiffies;
+
+	/* conn might have been added just before by another cpu and
+	 * might still be unconfirmed.  In this case, nf_conntrack_find()
+	 * returns no result.  Thus only evict if this cpu added the
+	 * stale entry or if the entry is older than two jiffies.
+	 */
+	age = a - b;
+	if (conn->cpu == cpu || age >= 2) {
+		hlist_del(&conn->node);
+		kmem_cache_free(connlimit_conn_cachep, conn);
+		return ERR_PTR(-ENOENT);
+	}
+
+	return ERR_PTR(-EAGAIN);
+}
+
 unsigned int nf_conncount_lookup(struct net *net, struct hlist_head *head,
 				 const struct nf_conntrack_tuple *tuple,
 				 const struct nf_conntrack_zone *zone,
@@ -138,18 +171,27 @@ unsigned int nf_conncount_lookup(struct net *net, struct hlist_head *head,
 {
 	const struct nf_conntrack_tuple_hash *found;
 	struct xt_connlimit_conn *conn;
-	struct hlist_node *n;
 	struct nf_conn *found_ct;
+	struct hlist_node *n;
 	unsigned int length = 0;
 
 	*addit = true;
 
 	/* check the saved connections */
 	hlist_for_each_entry_safe(conn, n, head, node) {
-		found = nf_conntrack_find_get(net, &conn->zone, &conn->tuple);
-		if (found == NULL) {
-			hlist_del(&conn->node);
-			kmem_cache_free(connlimit_conn_cachep, conn);
+		found = find_or_evict(net, conn);
+		if (IS_ERR(found)) {
+			/* Not found, but might be about to be confirmed */
+			if (PTR_ERR(found) == -EAGAIN) {
+				length++;
+				if (!tuple)
+					continue;
+
+				if (nf_ct_tuple_equal(&conn->tuple, tuple) &&
+				    nf_ct_zone_id(&conn->zone, conn->zone.dir) ==
+				    nf_ct_zone_id(zone, zone->dir))
+					*addit = false;
+			}
 			continue;
 		}
 
-- 
2.19.1



