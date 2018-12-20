Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8648C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F5521773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297604;
	bh=frfcK32ZYeReY3ZXKHt5gv/bNqcVaWHrZgKFFD6ZuHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HUL8/77OqmbMQ9p7dPckOm2GrOZlKDI7CdGWoQyal5J+4KZdZJJUjzQbvuAT5fXfX
	 CaUszRCS/taomsu9LENniubVaUqY7NESxkD+ECwRI27w3X/JgR5bye6Y1H5Q3Y0Mnr
	 1HQQsu6ywLR44lXj6lLum7Fv/hJSMCOMypEMNDrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbeLTJUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:20:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730488AbeLTJT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:19:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1342C21720;
        Thu, 20 Dec 2018 09:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297598;
        bh=frfcK32ZYeReY3ZXKHt5gv/bNqcVaWHrZgKFFD6ZuHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D12AY/TlxWiO2ZlFfGUC7KWDh3+Y1B530dxEhgff78U1pI5nmHX/fc8u8eEM1B5BM
         fIzzPQrVccgGab7ux1g7HBI9S6jPCcuLWsUxyIyvzbwzjQdKalzEOfdFGyJp3z3c4X
         r+3PxzWNs7pZmE7EsKfwiDudb1sgI+zyBABzBaJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 02/31] lib/interval_tree_test.c: allow full tree search
Date:   Thu, 20 Dec 2018 10:18:14 +0100
Message-Id: <20181220085742.694672774@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085742.601260254@linuxfoundation.org>
References: <20181220085742.601260254@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c46ecce431ebe6b1a9551d1f530eb432dae5c39b ]

...  such that a user can specify visiting all the nodes in the tree
(intersects with the world).  This is a nice opposite from the very
basic default query which is a single point.

Link: http://lkml.kernel.org/r/20170518174936.20265-5-dave@stgolabs.net
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/interval_tree_test.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/interval_tree_test.c b/lib/interval_tree_test.c
index 1093f0496d5e..409383463879 100644
--- a/lib/interval_tree_test.c
+++ b/lib/interval_tree_test.c
@@ -15,6 +15,7 @@ __param(int, perf_loops, 100000, "Number of iterations modifying the tree");
 
 __param(int, nsearches, 100, "Number of searches to the interval tree");
 __param(int, search_loops, 10000, "Number of iterations searching the tree");
+__param(bool, search_all, false, "Searches will iterate all nodes in the tree");
 
 
 static struct rb_root root = RB_ROOT;
@@ -24,13 +25,13 @@ static u32 *queries = NULL;
 static struct rnd_state rnd;
 
 static inline unsigned long
-search(unsigned long query, struct rb_root *root)
+search(struct rb_root *root, unsigned long start, unsigned long last)
 {
 	struct interval_tree_node *node;
 	unsigned long results = 0;
 
-	for (node = interval_tree_iter_first(root, query, query); node;
-	     node = interval_tree_iter_next(node, query, query))
+	for (node = interval_tree_iter_first(root, start, last); node;
+	     node = interval_tree_iter_next(node, start, last))
 		results++;
 	return results;
 }
@@ -99,8 +100,12 @@ static int interval_tree_test_init(void)
 
 	results = 0;
 	for (i = 0; i < search_loops; i++)
-		for (j = 0; j < nsearches; j++)
-			results += search(queries[j], &root);
+		for (j = 0; j < nsearches; j++) {
+			unsigned long start = search_all ? 0 : queries[j];
+			unsigned long last = search_all ? max_endpoint : queries[j];
+
+			results += search(&root, start, last);
+		}
 
 	time2 = get_cycles();
 	time = time2 - time1;
-- 
2.19.1



