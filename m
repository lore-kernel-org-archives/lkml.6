Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6B9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2373F20811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545299063;
	bh=mLKPcnaPVoLha0Pxrq2BpxJNOEahWuUv7kKa1icOs4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XFaDdTLflNQWX3/k3r1gd9aHD/m1grPVdWgyKoBc0jE9FGkyAtbftO2BB0xlPPHUa
	 48X4UUoihjB86U7ByhjgnjlP/k4h9fHE7G8g+tsIXwt2Ccrq8I9Nzpgnhkm+ki96c8
	 dr8uSQH62i1guv1sURLrD4cuHo+N55373rnYHF3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbeLTJoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:44:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:38818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731216AbeLTJVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:21:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D0A421720;
        Thu, 20 Dec 2018 09:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297715;
        bh=mLKPcnaPVoLha0Pxrq2BpxJNOEahWuUv7kKa1icOs4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g1IDd7LQOuEVeYLbab/xKzIcCJyy7Q4PM8boKZBG/P3bUHy53gtumpt0KH4xYiaUX
         RtHVxCo/YTfcSUc3/Eu+IhBErlixkscdDVkjjvx4zY60ih9F/TF+y0treDFxQH25a4
         x9BxOdzoUKnum6aFJqbpXYMN8W2egDQ7H8JdKmOs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 03/40] lib/rbtree_test.c: make input module parameters
Date:   Thu, 20 Dec 2018 10:18:15 +0100
Message-Id: <20181220085826.630418994@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 223f8911eace60c787f8767c25148b80ece9732a ]

Allows for more flexible debugging.

Link: http://lkml.kernel.org/r/20170719014603.19029-5-dave@stgolabs.net
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/rbtree_test.c | 55 +++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
index 8b3c9dc88262..e83331aa1b7f 100644
--- a/lib/rbtree_test.c
+++ b/lib/rbtree_test.c
@@ -1,11 +1,18 @@
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/rbtree_augmented.h>
 #include <linux/random.h>
+#include <linux/slab.h>
 #include <asm/timex.h>
 
-#define NODES       100
-#define PERF_LOOPS  100000
-#define CHECK_LOOPS 100
+#define __param(type, name, init, msg)		\
+	static type name = init;		\
+	module_param(name, type, 0444);		\
+	MODULE_PARM_DESC(name, msg);
+
+__param(int, nnodes, 100, "Number of nodes in the rb-tree");
+__param(int, perf_loops, 100000, "Number of iterations modifying the rb-tree");
+__param(int, check_loops, 100, "Number of iterations modifying and verifying the rb-tree");
 
 struct test_node {
 	u32 key;
@@ -17,7 +24,7 @@ struct test_node {
 };
 
 static struct rb_root root = RB_ROOT;
-static struct test_node nodes[NODES];
+static struct test_node *nodes = NULL;
 
 static struct rnd_state rnd;
 
@@ -95,7 +102,7 @@ static void erase_augmented(struct test_node *node, struct rb_root *root)
 static void init(void)
 {
 	int i;
-	for (i = 0; i < NODES; i++) {
+	for (i = 0; i < nnodes; i++) {
 		nodes[i].key = prandom_u32_state(&rnd);
 		nodes[i].val = prandom_u32_state(&rnd);
 	}
@@ -177,6 +184,10 @@ static int __init rbtree_test_init(void)
 	int i, j;
 	cycles_t time1, time2, time;
 
+	nodes = kmalloc(nnodes * sizeof(*nodes), GFP_KERNEL);
+	if (!nodes)
+		return -ENOMEM;
+
 	printk(KERN_ALERT "rbtree testing");
 
 	prandom_seed_state(&rnd, 3141592653589793238ULL);
@@ -184,27 +195,27 @@ static int __init rbtree_test_init(void)
 
 	time1 = get_cycles();
 
-	for (i = 0; i < PERF_LOOPS; i++) {
-		for (j = 0; j < NODES; j++)
+	for (i = 0; i < perf_loops; i++) {
+		for (j = 0; j < nnodes; j++)
 			insert(nodes + j, &root);
-		for (j = 0; j < NODES; j++)
+		for (j = 0; j < nnodes; j++)
 			erase(nodes + j, &root);
 	}
 
 	time2 = get_cycles();
 	time = time2 - time1;
 
-	time = div_u64(time, PERF_LOOPS);
+	time = div_u64(time, perf_loops);
 	printk(" -> %llu cycles\n", (unsigned long long)time);
 
-	for (i = 0; i < CHECK_LOOPS; i++) {
+	for (i = 0; i < check_loops; i++) {
 		init();
-		for (j = 0; j < NODES; j++) {
+		for (j = 0; j < nnodes; j++) {
 			check(j);
 			insert(nodes + j, &root);
 		}
-		for (j = 0; j < NODES; j++) {
-			check(NODES - j);
+		for (j = 0; j < nnodes; j++) {
+			check(nnodes - j);
 			erase(nodes + j, &root);
 		}
 		check(0);
@@ -216,32 +227,34 @@ static int __init rbtree_test_init(void)
 
 	time1 = get_cycles();
 
-	for (i = 0; i < PERF_LOOPS; i++) {
-		for (j = 0; j < NODES; j++)
+	for (i = 0; i < perf_loops; i++) {
+		for (j = 0; j < nnodes; j++)
 			insert_augmented(nodes + j, &root);
-		for (j = 0; j < NODES; j++)
+		for (j = 0; j < nnodes; j++)
 			erase_augmented(nodes + j, &root);
 	}
 
 	time2 = get_cycles();
 	time = time2 - time1;
 
-	time = div_u64(time, PERF_LOOPS);
+	time = div_u64(time, perf_loops);
 	printk(" -> %llu cycles\n", (unsigned long long)time);
 
-	for (i = 0; i < CHECK_LOOPS; i++) {
+	for (i = 0; i < check_loops; i++) {
 		init();
-		for (j = 0; j < NODES; j++) {
+		for (j = 0; j < nnodes; j++) {
 			check_augmented(j);
 			insert_augmented(nodes + j, &root);
 		}
-		for (j = 0; j < NODES; j++) {
-			check_augmented(NODES - j);
+		for (j = 0; j < nnodes; j++) {
+			check_augmented(nnodes - j);
 			erase_augmented(nodes + j, &root);
 		}
 		check_augmented(0);
 	}
 
+	kfree(nodes);
+
 	return -EAGAIN; /* Fail will directly unload the module */
 }
 
-- 
2.19.1



