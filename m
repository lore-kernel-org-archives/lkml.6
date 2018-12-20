Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E774C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC61E21773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297572;
	bh=r3W/y2wfj/ERY9uuxZp1T6xml+r+ZkfqCQfmlJ1ymvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j5acmDwySwg9ZWLgRSWX71zzsGCi1z9sXkAwq2mFEFJxXYAbRgmgNDgYc1RGtcP8x
	 ocXl0xfXr3qrcR5Rd2dWMzdyJzE33d6r2bqBz4ec9AelbKuHmyifE7S/uHT8j4+N7y
	 TSuSqRv7W21y96a9B2OXUMmTRhd2S26/3PdAj98Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbeLTJTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:19:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729564AbeLTJTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:19:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DE8621720;
        Thu, 20 Dec 2018 09:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297568;
        bh=r3W/y2wfj/ERY9uuxZp1T6xml+r+ZkfqCQfmlJ1ymvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AeWJRFreV0OZ8oJ4eVnv4QD7DbaPMlO0OIVdkgBIEKf0U4Y3a+krNebDE7g7elxku
         PXjOCjePVBD/1uxr2MneZKncoIqUsTMAoHiXXNBcUfU27eCAb+Fa9kq+dp6nBSUfDT
         3AXDpjWqGrBEH/MQUI/q9/eZCH7PuuwlUCQRoa2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 01/31] lib/interval_tree_test.c: make test options module parameters
Date:   Thu, 20 Dec 2018 10:18:13 +0100
Message-Id: <20181220085742.655317292@linuxfoundation.org>
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

[ Upstream commit a54dae0338b7f01eb0f9c7571fb9b74f791d1c6b ]

Allows for more flexible debugging.

Link: http://lkml.kernel.org/r/20170518174936.20265-3-dave@stgolabs.net
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/interval_tree_test.c | 57 ++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/lib/interval_tree_test.c b/lib/interval_tree_test.c
index 245900b98c8e..1093f0496d5e 100644
--- a/lib/interval_tree_test.c
+++ b/lib/interval_tree_test.c
@@ -1,16 +1,25 @@
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/interval_tree.h>
 #include <linux/random.h>
+#include <linux/slab.h>
 #include <asm/timex.h>
 
-#define NODES        100
-#define PERF_LOOPS   100000
-#define SEARCHES     100
-#define SEARCH_LOOPS 10000
+#define __param(type, name, init, msg)		\
+	static type name = init;		\
+	module_param(name, type, 0444);		\
+	MODULE_PARM_DESC(name, msg);
+
+__param(int, nnodes, 100, "Number of nodes in the interval tree");
+__param(int, perf_loops, 100000, "Number of iterations modifying the tree");
+
+__param(int, nsearches, 100, "Number of searches to the interval tree");
+__param(int, search_loops, 10000, "Number of iterations searching the tree");
+
 
 static struct rb_root root = RB_ROOT;
-static struct interval_tree_node nodes[NODES];
-static u32 queries[SEARCHES];
+static struct interval_tree_node *nodes = NULL;
+static u32 *queries = NULL;
 
 static struct rnd_state rnd;
 
@@ -29,7 +38,8 @@ search(unsigned long query, struct rb_root *root)
 static void init(void)
 {
 	int i;
-	for (i = 0; i < NODES; i++) {
+
+	for (i = 0; i < nnodes; i++) {
 		u32 a = prandom_u32_state(&rnd);
 		u32 b = prandom_u32_state(&rnd);
 		if (a <= b) {
@@ -40,7 +50,7 @@ static void init(void)
 			nodes[i].last = a;
 		}
 	}
-	for (i = 0; i < SEARCHES; i++)
+	for (i = 0; i < nsearches; i++)
 		queries[i] = prandom_u32_state(&rnd);
 }
 
@@ -50,6 +60,16 @@ static int interval_tree_test_init(void)
 	unsigned long results;
 	cycles_t time1, time2, time;
 
+	nodes = kmalloc(nnodes * sizeof(struct interval_tree_node), GFP_KERNEL);
+	if (!nodes)
+		return -ENOMEM;
+
+	queries = kmalloc(nsearches * sizeof(int), GFP_KERNEL);
+	if (!queries) {
+		kfree(nodes);
+		return -ENOMEM;
+	}
+
 	printk(KERN_ALERT "interval tree insert/remove");
 
 	prandom_seed_state(&rnd, 3141592653589793238ULL);
@@ -57,39 +77,42 @@ static int interval_tree_test_init(void)
 
 	time1 = get_cycles();
 
-	for (i = 0; i < PERF_LOOPS; i++) {
-		for (j = 0; j < NODES; j++)
+	for (i = 0; i < perf_loops; i++) {
+		for (j = 0; j < nnodes; j++)
 			interval_tree_insert(nodes + j, &root);
-		for (j = 0; j < NODES; j++)
+		for (j = 0; j < nnodes; j++)
 			interval_tree_remove(nodes + j, &root);
 	}
 
 	time2 = get_cycles();
 	time = time2 - time1;
 
-	time = div_u64(time, PERF_LOOPS);
+	time = div_u64(time, perf_loops);
 	printk(" -> %llu cycles\n", (unsigned long long)time);
 
 	printk(KERN_ALERT "interval tree search");
 
-	for (j = 0; j < NODES; j++)
+	for (j = 0; j < nnodes; j++)
 		interval_tree_insert(nodes + j, &root);
 
 	time1 = get_cycles();
 
 	results = 0;
-	for (i = 0; i < SEARCH_LOOPS; i++)
-		for (j = 0; j < SEARCHES; j++)
+	for (i = 0; i < search_loops; i++)
+		for (j = 0; j < nsearches; j++)
 			results += search(queries[j], &root);
 
 	time2 = get_cycles();
 	time = time2 - time1;
 
-	time = div_u64(time, SEARCH_LOOPS);
-	results = div_u64(results, SEARCH_LOOPS);
+	time = div_u64(time, search_loops);
+	results = div_u64(results, search_loops);
 	printk(" -> %llu cycles (%lu results)\n",
 	       (unsigned long long)time, results);
 
+	kfree(queries);
+	kfree(nodes);
+
 	return -EAGAIN; /* Fail will directly unload the module */
 }
 
-- 
2.19.1



