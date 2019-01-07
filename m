Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B56C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7069121736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866270;
	bh=RqfecMqVd4p+8vp0lH/1NKMDEWxhl74hBX0XHQECKW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gQJsIrCxf6m9nGDsiAhUsJHzF3FV8C6dTD2oqdopmSPKVxIUgJNyQHKOOtUQoRJDd
	 ePNUP06I7plYiqQJLPSD0k1sBM+7csfGI8qdRXXwXQmga9tJOIe7c+GhsKn/MUcb7r
	 OSeruAvKKC6cIQzi8Yj8dtXXTYnIlFR3qFDUAuPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbfAGNE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:04:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731382AbfAGNE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:04:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05DFC21736;
        Mon,  7 Jan 2019 13:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866265;
        bh=RqfecMqVd4p+8vp0lH/1NKMDEWxhl74hBX0XHQECKW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p6sOkB/+dNnWocrSh/AjAJdbqMIR4+MfcqT0ZJbDEqfVOTQf0TjSXubTqo25RqHm3
         CN6nkuoKsl5Gvi9T3mFLBmgH7169ZYTvBHIAU2F/XdpqZ4MVsw8ugI87KoFLMbPay0
         WE8VWNDmQ03h7jkB3J6VTcktBtD7mUbgMys+L6Lk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yi-Hung Wei <yihung.wei@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 082/101] netfilter: nf_conncount: Fix garbage collection with zones
Date:   Mon,  7 Jan 2019 13:33:10 +0100
Message-Id: <20190107105337.426859757@linuxfoundation.org>
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

commit 21ba8847f857028dc83a0f341e16ecc616e34740 upstream.

Currently, we use check_hlist() for garbage colleciton. However, we
use the ‘zone’ from the counted entry to query the existence of
existing entries in the hlist. This could be wrong when they are in
different zones, and this patch fixes this issue.

Fixes: e59ea3df3fc2 ("netfilter: xt_connlimit: honor conntrack zone if available")
Signed-off-by: Yi-Hung Wei <yihung.wei@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

[mfo: backport: refresh context lines and use older symbol/file names, note hunk 5:
 - nf_conncount.c -> xt_connlimit.c
   - nf_conncount_rb -> xt_connlimit_rb
   - nf_conncount_tuple -> xt_connlimit_conn
   - hunk 5: remove check for non-NULL 'tuple', that isn't required as it's introduced
     by upstream commit 35d8deb80 ("netfilter: conncount: Support count only use case")
     which addresses nf_conncount_count() that does not exist yet -- it's introduced by
     upstream commit 625c556118f3 ("netfilter: connlimit: split xt_connlimit into front
     and backend"), a refactor change.
 - nft_connlimit.c -> removed, not used/doesn't exist yet.]
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_conntrack_count.h |  3 ++-
 net/netfilter/xt_connlimit.c               | 13 +++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_count.h b/include/net/netfilter/nf_conntrack_count.h
index 54e43b8a8da1..4b71a2f4c351 100644
--- a/include/net/netfilter/nf_conntrack_count.h
+++ b/include/net/netfilter/nf_conntrack_count.h
@@ -7,7 +7,8 @@ unsigned int nf_conncount_lookup(struct net *net, struct hlist_head *head,
 				 bool *addit);
 
 bool nf_conncount_add(struct hlist_head *head,
-		      const struct nf_conntrack_tuple *tuple);
+		      const struct nf_conntrack_tuple *tuple,
+		      const struct nf_conntrack_zone *zone);
 
 void nf_conncount_cache_free(struct hlist_head *hhead);
 
diff --git a/net/netfilter/xt_connlimit.c b/net/netfilter/xt_connlimit.c
index 7af58750ab49..ab1f849464fa 100644
--- a/net/netfilter/xt_connlimit.c
+++ b/net/netfilter/xt_connlimit.c
@@ -46,6 +46,7 @@
 struct xt_connlimit_conn {
 	struct hlist_node		node;
 	struct nf_conntrack_tuple	tuple;
+	struct nf_conntrack_zone	zone;
 };
 
 struct xt_connlimit_rb {
@@ -115,7 +116,8 @@ same_source_net(const union nf_inet_addr *addr,
 }
 
 bool nf_conncount_add(struct hlist_head *head,
-		      const struct nf_conntrack_tuple *tuple)
+		      const struct nf_conntrack_tuple *tuple,
+		      const struct nf_conntrack_zone *zone)
 {
 	struct xt_connlimit_conn *conn;
 
@@ -123,6 +125,7 @@ bool nf_conncount_add(struct hlist_head *head,
 	if (conn == NULL)
 		return false;
 	conn->tuple = *tuple;
+	conn->zone = *zone;
 	hlist_add_head(&conn->node, head);
 	return true;
 }
@@ -143,7 +146,7 @@ unsigned int nf_conncount_lookup(struct net *net, struct hlist_head *head,
 
 	/* check the saved connections */
 	hlist_for_each_entry_safe(conn, n, head, node) {
-		found = nf_conntrack_find_get(net, zone, &conn->tuple);
+		found = nf_conntrack_find_get(net, &conn->zone, &conn->tuple);
 		if (found == NULL) {
 			hlist_del(&conn->node);
 			kmem_cache_free(connlimit_conn_cachep, conn);
@@ -152,7 +155,8 @@ unsigned int nf_conncount_lookup(struct net *net, struct hlist_head *head,
 
 		found_ct = nf_ct_tuplehash_to_ctrack(found);
 
-		if (nf_ct_tuple_equal(&conn->tuple, tuple)) {
+		if (nf_ct_tuple_equal(&conn->tuple, tuple) &&
+		    nf_ct_zone_equal(found_ct, zone, zone->dir)) {
 			/*
 			 * Just to be sure we have it only once in the list.
 			 * We should not see tuples twice unless someone hooks
@@ -231,7 +235,7 @@ count_tree(struct net *net, struct rb_root *root,
 			if (!addit)
 				return count;
 
-			if (!nf_conncount_add(&rbconn->hhead, tuple))
+			if (!nf_conncount_add(&rbconn->hhead, tuple, zone))
 				return 0; /* hotdrop */
 
 			return count + 1;
@@ -270,6 +274,7 @@ count_tree(struct net *net, struct rb_root *root,
 	}
 
 	conn->tuple = *tuple;
+	conn->zone = *zone;
 	rbconn->addr = *addr;
 
 	INIT_HLIST_HEAD(&rbconn->hhead);
-- 
2.19.1



