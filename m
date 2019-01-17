Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C118C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D20320868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MMmupVfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfAQXSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:18:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35482 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725982AbfAQXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:18:17 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0HNDW8f020143
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:18:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=sIJR6OuveyCpeaMtzqutR2EuyW3qcGB5lVGtd/HzzR8=;
 b=MMmupVfK1we+suFaOH/7t/zA1JAjEuNGH7qQh4yoEWjvT/oLv+pmfc9co9Wz8JPaZ6eR
 +wWljt3rOgY0CLyVtypEmyvYOfPR0OhXPbEY9AoTtw2xgKj28XFv/P1jNy5u6RPvgDaE
 jiD/BayoFuh5J9xvTyNmIyCxMPcAWEH5v/Y= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q31vh89b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:18:16 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 17 Jan 2019 15:17:40 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 26ED062E2162; Thu, 17 Jan 2019 15:17:32 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>, <acme@kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH kallsyms, bpf 1/3] rbtree_latch: Introduce latch_tree_first() and latch_tree_next()
Date:   Thu, 17 Jan 2019 15:17:28 -0800
Message-ID: <20190117231730.2413466-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190117231730.2413466-1-songliubraving@fb.com>
References: <20190117231730.2413466-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

These two functions will be used by kallsym_tree for dynamic symbols.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/rbtree_latch.h | 54 ++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/include/linux/rbtree_latch.h b/include/linux/rbtree_latch.h
index 7d012faa509a..d0001a136d3e 100644
--- a/include/linux/rbtree_latch.h
+++ b/include/linux/rbtree_latch.h
@@ -211,4 +211,58 @@ latch_tree_find(void *key, struct latch_tree_root *root,
 	return node;
 }
 
+/**
+ * latch_tree_first() - return the first node in @root per sort order
+ * @root: trees to search
+ *
+ * Does a lockless lookup in the trees @root for the first node.
+ */
+static __always_inline struct latch_tree_node *
+latch_tree_first(struct latch_tree_root *root)
+{
+	struct latch_tree_node *ltn = NULL;
+	struct rb_node *node;
+	unsigned int seq;
+
+	do {
+		struct rb_root *rbr;
+
+		seq = raw_read_seqcount_latch(&root->seq);
+		rbr = &root->tree[seq & 1];
+		node = rb_first(rbr);
+	} while (read_seqcount_retry(&root->seq, seq));
+
+	if (node)
+		ltn = __lt_from_rb(node, seq & 1);
+
+	return ltn;
+}
+
+/**
+ * latch_tree_next() - find the next @ltn in @root per sort order
+ * @root: trees to which @ltn belongs
+ * @ltn: nodes to start from
+ *
+ * Does a lockless lookup in the trees @root for the next node starting at
+ * @ltn.
+ *
+ * Using this function outside of the write side lock is rather dodgy but given
+ * latch_tree_erase() doesn't re-init the nodes and the whole iteration is done
+ * under a single RCU critical section, it should be non-fatal and generate some
+ * semblance of order - albeit possibly missing chunks of the tree.
+ */
+static __always_inline struct latch_tree_node *
+latch_tree_next(struct latch_tree_root *root, struct latch_tree_node *ltn)
+{
+	struct rb_node *node;
+	unsigned int seq;
+
+	do {
+		seq = raw_read_seqcount_latch(&root->seq);
+		node = rb_next(&ltn->node[seq & 1]);
+	} while (read_seqcount_retry(&root->seq, seq));
+
+	return __lt_from_rb(node, seq & 1);
+}
+
 #endif /* RB_TREE_LATCH_H */
-- 
2.17.1

