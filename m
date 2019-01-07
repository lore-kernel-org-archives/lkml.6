Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6F1C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D432089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866784;
	bh=MC64oBcwAxjur5CrMg9Qx0qGpaxNo+6Ux5v5f4Usj/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BvX7V8NQFmrSNuFQ4E6Jb4y/sO7SE6gQBkoywLd+zGWLzcK+RQ3uaV1HxDMfp9GiU
	 8MAGnVCbmkylR7lZ/uWXFmpcIkuGIJ2S+5K8tsmzzah7Xyijvbubf02+eW0POrUcWW
	 zwVq0yEk2szF4b+kxEogNSlfeONiGae5RSaavHMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbfAGNND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:13:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730499AbfAGNEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:04:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A801A21736;
        Mon,  7 Jan 2019 13:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866254;
        bh=MC64oBcwAxjur5CrMg9Qx0qGpaxNo+6Ux5v5f4Usj/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDclR4xMvet6n7lHw8ANz2u3fZT+WaCosnvW6O/qcwjZcpDFvemwbQrA1HzYeOsjD
         gG4iEXMn89nA6PwB0pKxU+wILLm7wt7ctxB1rkA4pAFMRbAQNU6qN2AwW+j4ohz06F
         1pbp4RDr/Jfjw435/tI+8RCPm5qfkaNkfyILLTy8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 081/101] netfilter: nf_conncount: expose connection list interface
Date:   Mon,  7 Jan 2019 13:33:09 +0100
Message-Id: <20190107105337.383462408@linuxfoundation.org>
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

commit 5e5cbc7b23eaf13e18652c03efbad5be6995de6a upstream.

This patch provides an interface to maintain the list of connections and
the lookup function to obtain the number of connections in the list.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

[mfo: backport: refresh context lines and use older symbol/file names:
 - nf_conntrack_count.h: new file, add include guards.
 - nf_conncount.c -> xt_connlimit.c.
   - nf_conncount_rb -> xt_connlimit_rb
   - nf_conncount_tuple -> xt_connlimit_conn
   - conncount_rb_cachep -> connlimit_rb_cachep
   - conncount_conn_cachep -> connlimit_conn_cachep]
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_conntrack_count.h | 14 +++++++++
 net/netfilter/xt_connlimit.c               | 36 ++++++++++++++--------
 2 files changed, 37 insertions(+), 13 deletions(-)
 create mode 100644 include/net/netfilter/nf_conntrack_count.h

diff --git a/include/net/netfilter/nf_conntrack_count.h b/include/net/netfilter/nf_conntrack_count.h
new file mode 100644
index 000000000000..54e43b8a8da1
--- /dev/null
+++ b/include/net/netfilter/nf_conntrack_count.h
@@ -0,0 +1,14 @@
+#ifndef _NF_CONNTRACK_COUNT_H
+#define _NF_CONNTRACK_COUNT_H
+
+unsigned int nf_conncount_lookup(struct net *net, struct hlist_head *head,
+				 const struct nf_conntrack_tuple *tuple,
+				 const struct nf_conntrack_zone *zone,
+				 bool *addit);
+
+bool nf_conncount_add(struct hlist_head *head,
+		      const struct nf_conntrack_tuple *tuple);
+
+void nf_conncount_cache_free(struct hlist_head *hhead);
+
+#endif
diff --git a/net/netfilter/xt_connlimit.c b/net/netfilter/xt_connlimit.c
index 79d41515dd2c..7af58750ab49 100644
--- a/net/netfilter/xt_connlimit.c
+++ b/net/netfilter/xt_connlimit.c
@@ -114,7 +114,7 @@ same_source_net(const union nf_inet_addr *addr,
 	}
 }
 
-static bool add_hlist(struct hlist_head *head,
+bool nf_conncount_add(struct hlist_head *head,
 		      const struct nf_conntrack_tuple *tuple)
 {
 	struct xt_connlimit_conn *conn;
@@ -126,12 +126,12 @@ static bool add_hlist(struct hlist_head *head,
 	hlist_add_head(&conn->node, head);
 	return true;
 }
+EXPORT_SYMBOL_GPL(nf_conncount_add);
 
-static unsigned int check_hlist(struct net *net,
-				struct hlist_head *head,
-				const struct nf_conntrack_tuple *tuple,
-				const struct nf_conntrack_zone *zone,
-				bool *addit)
+unsigned int nf_conncount_lookup(struct net *net, struct hlist_head *head,
+				 const struct nf_conntrack_tuple *tuple,
+				 const struct nf_conntrack_zone *zone,
+				 bool *addit)
 {
 	const struct nf_conntrack_tuple_hash *found;
 	struct xt_connlimit_conn *conn;
@@ -176,6 +176,7 @@ static unsigned int check_hlist(struct net *net,
 
 	return length;
 }
+EXPORT_SYMBOL_GPL(nf_conncount_lookup);
 
 static void tree_nodes_free(struct rb_root *root,
 			    struct xt_connlimit_rb *gc_nodes[],
@@ -222,13 +223,15 @@ count_tree(struct net *net, struct rb_root *root,
 		} else {
 			/* same source network -> be counted! */
 			unsigned int count;
-			count = check_hlist(net, &rbconn->hhead, tuple, zone, &addit);
+
+			count = nf_conncount_lookup(net, &rbconn->hhead, tuple,
+						    zone, &addit);
 
 			tree_nodes_free(root, gc_nodes, gc_count);
 			if (!addit)
 				return count;
 
-			if (!add_hlist(&rbconn->hhead, tuple))
+			if (!nf_conncount_add(&rbconn->hhead, tuple))
 				return 0; /* hotdrop */
 
 			return count + 1;
@@ -238,7 +241,7 @@ count_tree(struct net *net, struct rb_root *root,
 			continue;
 
 		/* only used for GC on hhead, retval and 'addit' ignored */
-		check_hlist(net, &rbconn->hhead, tuple, zone, &addit);
+		nf_conncount_lookup(net, &rbconn->hhead, tuple, zone, &addit);
 		if (hlist_empty(&rbconn->hhead))
 			gc_nodes[gc_count++] = rbconn;
 	}
@@ -378,11 +381,19 @@ static int connlimit_mt_check(const struct xt_mtchk_param *par)
 	return 0;
 }
 
-static void destroy_tree(struct rb_root *r)
+void nf_conncount_cache_free(struct hlist_head *hhead)
 {
 	struct xt_connlimit_conn *conn;
-	struct xt_connlimit_rb *rbconn;
 	struct hlist_node *n;
+
+	hlist_for_each_entry_safe(conn, n, hhead, node)
+		kmem_cache_free(connlimit_conn_cachep, conn);
+}
+EXPORT_SYMBOL_GPL(nf_conncount_cache_free);
+
+static void destroy_tree(struct rb_root *r)
+{
+	struct xt_connlimit_rb *rbconn;
 	struct rb_node *node;
 
 	while ((node = rb_first(r)) != NULL) {
@@ -390,8 +401,7 @@ static void destroy_tree(struct rb_root *r)
 
 		rb_erase(node, r);
 
-		hlist_for_each_entry_safe(conn, n, &rbconn->hhead, node)
-			kmem_cache_free(connlimit_conn_cachep, conn);
+		nf_conncount_cache_free(&rbconn->hhead);
 
 		kmem_cache_free(connlimit_rb_cachep, rbconn);
 	}
-- 
2.19.1



