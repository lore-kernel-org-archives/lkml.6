Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8828BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501D520652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130774;
	bh=sXKylQWnJZG1GPecFZVeGGUr7RVdQz7RqJDDZxZUcKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n554sGgt6ZZKxCY/J7xCQ24wOpZXizf5SeAaEQZ+v7YGq7htgC6CLuSL8wc6t00W5
	 BbdvncdGO8IpYV/Y9yRcP9hq2hsO4ahhOs+xHj6tEslemt44EUEzyUPdibkESh/kAB
	 Jj7g6fIPCzZ8UDfDqN8TjnMQbFidxfviqfLufsdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbfBYVgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:36:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:42308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733061AbfBYVf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:35:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E056C21841;
        Mon, 25 Feb 2019 21:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130555;
        bh=sXKylQWnJZG1GPecFZVeGGUr7RVdQz7RqJDDZxZUcKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKJ4A7Ik9x/JEXkFJttFBpFgTfIwBO82PTSzu7iOK6JgCZnW3R1vjw2+lvNYIOR05
         /Bhn5EYVZw1Xv85crXbOpk4lZ2R6EGx2lSVj/7GavQHB/0YZKVEk/PuqPkCUfDNRhw
         uJNKawuGwFdh9gAtQWvxIph4ETOmIxErYqZGpVsw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 141/183] net_sched: fix a memory leak in cls_tcindex
Date:   Mon, 25 Feb 2019 22:11:54 +0100
Message-Id: <20190225195118.645129143@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 033b228e7f26b29ae37f8bfa1bc6b209a5365e9f ]

When tcindex_destroy() destroys all the filter results in
the perfect hash table, it invokes the walker to delete
each of them. However, results with class==0 are skipped
in either tcindex_walk() or tcindex_delete(), which causes
a memory leak reported by kmemleak.

This patch fixes it by skipping the walker and directly
deleting these filter results so we don't miss any filter
result.

As a result of this change, we have to initialize exts->net
properly in tcindex_alloc_perfect_hash(). For net-next, we
need to consider whether we should initialize ->net in
tcf_exts_init() instead, before that just directly test
CONFIG_NET_CLS_ACT=y.

Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_tcindex.c |   46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

--- a/net/sched/cls_tcindex.c
+++ b/net/sched/cls_tcindex.c
@@ -221,14 +221,6 @@ found:
 	return 0;
 }
 
-static int tcindex_destroy_element(struct tcf_proto *tp,
-				   void *arg, struct tcf_walker *walker)
-{
-	bool last;
-
-	return tcindex_delete(tp, arg, &last, NULL);
-}
-
 static void tcindex_destroy_work(struct work_struct *work)
 {
 	struct tcindex_data *p = container_of(to_rcu_work(work),
@@ -279,7 +271,7 @@ static void tcindex_free_perfect_hash(st
 	kfree(cp->perfect);
 }
 
-static int tcindex_alloc_perfect_hash(struct tcindex_data *cp)
+static int tcindex_alloc_perfect_hash(struct net *net, struct tcindex_data *cp)
 {
 	int i, err = 0;
 
@@ -293,6 +285,9 @@ static int tcindex_alloc_perfect_hash(st
 				    TCA_TCINDEX_ACT, TCA_TCINDEX_POLICE);
 		if (err < 0)
 			goto errout;
+#ifdef CONFIG_NET_CLS_ACT
+		cp->perfect[i].exts.net = net;
+#endif
 	}
 
 	return 0;
@@ -341,7 +336,7 @@ tcindex_set_parms(struct net *net, struc
 	if (p->perfect) {
 		int i;
 
-		if (tcindex_alloc_perfect_hash(cp) < 0)
+		if (tcindex_alloc_perfect_hash(net, cp) < 0)
 			goto errout;
 		for (i = 0; i < cp->hash; i++)
 			cp->perfect[i].res = p->perfect[i].res;
@@ -410,7 +405,7 @@ tcindex_set_parms(struct net *net, struc
 	err = -ENOMEM;
 	if (!cp->perfect && !cp->h) {
 		if (valid_perfect_hash(cp)) {
-			if (tcindex_alloc_perfect_hash(cp) < 0)
+			if (tcindex_alloc_perfect_hash(net, cp) < 0)
 				goto errout_alloc;
 			balloc = 1;
 		} else {
@@ -566,13 +561,32 @@ static void tcindex_destroy(struct tcf_p
 			    struct netlink_ext_ack *extack)
 {
 	struct tcindex_data *p = rtnl_dereference(tp->root);
-	struct tcf_walker walker;
+	int i;
 
 	pr_debug("tcindex_destroy(tp %p),p %p\n", tp, p);
-	walker.count = 0;
-	walker.skip = 0;
-	walker.fn = tcindex_destroy_element;
-	tcindex_walk(tp, &walker);
+
+	if (p->perfect) {
+		for (i = 0; i < p->hash; i++) {
+			struct tcindex_filter_result *r = p->perfect + i;
+
+			tcf_unbind_filter(tp, &r->res);
+			if (tcf_exts_get_net(&r->exts))
+				tcf_queue_work(&r->rwork,
+					       tcindex_destroy_rexts_work);
+			else
+				__tcindex_destroy_rexts(r);
+		}
+	}
+
+	for (i = 0; p->h && i < p->hash; i++) {
+		struct tcindex_filter *f, *next;
+		bool last;
+
+		for (f = rtnl_dereference(p->h[i]); f; f = next) {
+			next = rtnl_dereference(f->next);
+			tcindex_delete(tp, &f->result, &last, NULL);
+		}
+	}
 
 	tcf_queue_work(&p->rwork, tcindex_destroy_work);
 }


