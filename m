Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbeECTZ6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 15:25:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:8165 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751271AbeECTYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 15:24:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,359,1520924400";
   d="scan'208";a="225573197"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm@lists.01.org
Subject: [PATCH 3/5] radix tree test suite: add item_delete_rcu()
Date: Thu,  3 May 2018 13:24:28 -0600
Message-Id: <20180503192430.7582-4-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
References: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the lifetime of "struct item" entries in the radix tree are not
controlled by RCU, but are instead deleted inline as they are removed from
the tree.

In the following patches we add a test which has threads iterating over
items pulled from the tree and verifying them in an
rcu_read_lock()/rcu_read_unlock() section.  This means that though an item
has been removed from the tree it could still be being worked on by other
threads until the RCU grace period expires.  So, we need to actually free
the "struct item" structures at the end of the grace period, just as we do
with "struct radix_tree_node" items.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 tools/testing/radix-tree/test.c | 19 +++++++++++++++++++
 tools/testing/radix-tree/test.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/tools/testing/radix-tree/test.c b/tools/testing/radix-tree/test.c
index 5978ab1f403d..def6015570b2 100644
--- a/tools/testing/radix-tree/test.c
+++ b/tools/testing/radix-tree/test.c
@@ -75,6 +75,25 @@ int item_delete(struct radix_tree_root *root, unsigned long index)
 	return 0;
 }
 
+static void item_free_rcu(struct rcu_head *head)
+{
+	struct item *item = container_of(head, struct item, rcu_head);
+
+	free(item);
+}
+
+int item_delete_rcu(struct radix_tree_root *root, unsigned long index)
+{
+	struct item *item = radix_tree_delete(root, index);
+
+	if (item) {
+		item_sanity(item, index);
+		call_rcu(&item->rcu_head, item_free_rcu);
+		return 1;
+	}
+	return 0;
+}
+
 void item_check_present(struct radix_tree_root *root, unsigned long index)
 {
 	struct item *item;
diff --git a/tools/testing/radix-tree/test.h b/tools/testing/radix-tree/test.h
index d9c031dbeb1a..8cf4a7a7f94c 100644
--- a/tools/testing/radix-tree/test.h
+++ b/tools/testing/radix-tree/test.h
@@ -5,6 +5,7 @@
 #include <linux/rcupdate.h>
 
 struct item {
+	struct rcu_head	rcu_head;
 	unsigned long index;
 	unsigned int order;
 };
@@ -15,6 +16,7 @@ int item_insert(struct radix_tree_root *root, unsigned long index);
 int item_insert_order(struct radix_tree_root *root, unsigned long index,
 			unsigned order);
 int item_delete(struct radix_tree_root *root, unsigned long index);
+int item_delete_rcu(struct radix_tree_root *root, unsigned long index);
 struct item *item_lookup(struct radix_tree_root *root, unsigned long index);
 
 void item_check_present(struct radix_tree_root *root, unsigned long index);
-- 
2.14.3
