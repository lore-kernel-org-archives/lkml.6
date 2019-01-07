Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604F3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3074821736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866229;
	bh=aMbJlwyMVJPIJ7LGyCV4RxBP9WmMGkjhUNg3wSTW794=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ddFEPEdjiiGBOLkX0f+CAfR/qyQxdVM8+jADvea/lIStLfOU5qtaZrlezkBMUTKlM
	 g0EZ5nri3c4XeScCOShaWarLFYH6qe8gqXKDmJZKGE/BlVbadcg9M7pG2iLL0EG/gq
	 e/pDYmrN5ssJQzU1ybRf91Cu2xu5OuARkAMi4gXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbfAGNDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:03:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731072AbfAGNDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:03:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 009392089F;
        Mon,  7 Jan 2019 13:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866223;
        bh=aMbJlwyMVJPIJ7LGyCV4RxBP9WmMGkjhUNg3wSTW794=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9sHzFUSbGcMYNm4yFUt9RBl3Pb42p1upTKkstFZM2Kfi+7W9FEeHSqd8fDBcqZ5w
         Pnthl+XGXNyRVZQ3AnvgCGmXuq/mtqC5kTitkFEFmOTPxMDhz6p+DEntTCSWjF6Azx
         Bt82W2of6LniBToTqKXDVd+wGjmjZBezeLt9JXMs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 080/101] netfilter: xt_connlimit: dont store address in the conn nodes
Date:   Mon,  7 Jan 2019 13:33:08 +0100
Message-Id: <20190107105337.326965501@linuxfoundation.org>
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

commit ce49480dba8666cba0106e8e31a942c9ce4c438a upstream.

Only stored, never read.  This is a leftover from commit 7d08487777c8
("netfilter: connlimit: use rbtree for per-host conntrack obj storage"),
which added the rbtree node struct that stores the address instead.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

[mfo: backport: refresh context lines and use older symbol/file names:
 - nf_conncount.c -> xt_connlimit.c.
   - nf_conncount_rb -> xt_connlimit_rb
   - nf_conncount_tuple -> xt_connlimit_conn
  - additionally, remove the add_hlist() 'addr' parameter that isn't used and removed
    later upstream with commit 625c556118f3 ("netfilter: connlimit: split xt_connlimit
    into front and backend") in the rename from 'xt_connlimit.c' to 'nf_conncount.c',
    a big refactor, so do it here, while still here in this related patch.]
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_connlimit.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/xt_connlimit.c b/net/netfilter/xt_connlimit.c
index ffa8eec980e9..79d41515dd2c 100644
--- a/net/netfilter/xt_connlimit.c
+++ b/net/netfilter/xt_connlimit.c
@@ -46,7 +46,6 @@
 struct xt_connlimit_conn {
 	struct hlist_node		node;
 	struct nf_conntrack_tuple	tuple;
-	union nf_inet_addr		addr;
 };
 
 struct xt_connlimit_rb {
@@ -116,8 +115,7 @@ same_source_net(const union nf_inet_addr *addr,
 }
 
 static bool add_hlist(struct hlist_head *head,
-		      const struct nf_conntrack_tuple *tuple,
-		      const union nf_inet_addr *addr)
+		      const struct nf_conntrack_tuple *tuple)
 {
 	struct xt_connlimit_conn *conn;
 
@@ -125,7 +123,6 @@ static bool add_hlist(struct hlist_head *head,
 	if (conn == NULL)
 		return false;
 	conn->tuple = *tuple;
-	conn->addr = *addr;
 	hlist_add_head(&conn->node, head);
 	return true;
 }
@@ -231,7 +228,7 @@ count_tree(struct net *net, struct rb_root *root,
 			if (!addit)
 				return count;
 
-			if (!add_hlist(&rbconn->hhead, tuple, addr))
+			if (!add_hlist(&rbconn->hhead, tuple))
 				return 0; /* hotdrop */
 
 			return count + 1;
@@ -270,7 +267,6 @@ count_tree(struct net *net, struct rb_root *root,
 	}
 
 	conn->tuple = *tuple;
-	conn->addr = *addr;
 	rbconn->addr = *addr;
 
 	INIT_HLIST_HEAD(&rbconn->hhead);
-- 
2.19.1



