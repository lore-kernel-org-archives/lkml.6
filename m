Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECE8C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA512146D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA512146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeIMAfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:35:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728264AbeIMAfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:35:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBBBF40216FC;
        Wed, 12 Sep 2018 19:29:07 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F88310DCF4A;
        Wed, 12 Sep 2018 19:29:07 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <andi@firstfloor.org>,
        Dave Chinner <dchinner@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v9 4/5] lib/dlock-list: Make sibling CPUs share the same linked list
Date:   Wed, 12 Sep 2018 15:28:51 -0400
Message-Id: <1536780532-4092-5-git-send-email-longman@redhat.com>
In-Reply-To: <1536780532-4092-1-git-send-email-longman@redhat.com>
References: <1536780532-4092-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 12 Sep 2018 19:29:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 12 Sep 2018 19:29:08 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dlock list needs one list for each of the CPUs available. However,
for sibling CPUs, they are sharing the L2 and probably L1 caches
too. As a result, there is not much to gain in term of avoiding
cacheline contention while increasing the cacheline footprint of the
L1/L2 caches as separate lists may need to be in the cache.

This patch makes all the sibling CPUs share the same list, thus
reducing the number of lists that need to be maintained in each
dlock list without having any noticeable impact on performance. It
also improves dlock list iteration performance as fewer lists need
to be iterated.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 lib/dlock-list.c | 74 ++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 59 insertions(+), 15 deletions(-)

diff --git a/lib/dlock-list.c b/lib/dlock-list.c
index f64ea4c..e286094 100644
--- a/lib/dlock-list.c
+++ b/lib/dlock-list.c
@@ -25,31 +25,65 @@
  * The distributed and locked list is a distributed set of lists each of
  * which is protected by its own spinlock, but acts like a single
  * consolidated list to the callers. For scaling purpose, the number of
- * lists used is equal to the number of possible CPUs in the system to
- * minimize contention.
+ * lists used is equal to the number of possible cores in the system to
+ * minimize contention. All threads of the same CPU core will share the
+ * same list.
  *
- * However, it is possible that individual CPU numbers may be equal to
- * or greater than the number of possible CPUs when there are holes in
- * the CPU number list. As a result, we need to map the CPU number to a
- * list index.
+ * We need to map each CPU number to a list index.
  */
 static DEFINE_PER_CPU_READ_MOSTLY(int, cpu2idx);
+static int nr_dlock_lists __read_mostly;
 
 /*
- * Initialize cpu2idx mapping table
+ * Initialize cpu2idx mapping table & nr_dlock_lists.
  *
  * It is possible that a dlock-list can be allocated before the cpu2idx is
  * initialized. In this case, all the cpus are mapped to the first entry
  * before initialization.
  *
+ * All the sibling CPUs of a sibling group will map to the same dlock list so
+ * as to reduce the number of dlock lists to be maintained while minimizing
+ * cacheline contention.
+ *
+ * As the sibling masks are set up in the core initcall phase, this function
+ * has to be done in the postcore phase to get the right data.
  */
 static int __init cpu2idx_init(void)
 {
 	int idx, cpu;
+	struct cpumask *sibling_mask;
+	static struct cpumask mask __initdata;
 
+	cpumask_clear(&mask);
 	idx = 0;
-	for_each_possible_cpu(cpu)
-		per_cpu(cpu2idx, cpu) = idx++;
+	for_each_possible_cpu(cpu) {
+		int scpu;
+
+		if (cpumask_test_cpu(cpu, &mask))
+			continue;
+		per_cpu(cpu2idx, cpu) = idx;
+		cpumask_set_cpu(cpu, &mask);
+
+		sibling_mask = topology_sibling_cpumask(cpu);
+		if (sibling_mask) {
+			for_each_cpu(scpu, sibling_mask) {
+				per_cpu(cpu2idx, scpu) = idx;
+				cpumask_set_cpu(scpu, &mask);
+			}
+		}
+		idx++;
+	}
+
+	/*
+	 * nr_dlock_lists can only be set after cpu2idx is properly
+	 * initialized.
+	 */
+	smp_mb();
+	nr_dlock_lists = idx;
+	WARN_ON(nr_dlock_lists > nr_cpu_ids);
+
+	pr_info("dlock-list: %d head entries per dlock list.\n",
+		nr_dlock_lists);
 	return 0;
 }
 postcore_initcall(cpu2idx_init);
@@ -67,19 +101,23 @@ static int __init cpu2idx_init(void)
  *
  * Dynamically allocated locks need to have their own special lock class
  * to avoid lockdep warning.
+ *
+ * Since nr_dlock_lists will always be <= nr_cpu_ids, having more lists
+ * than necessary allocated is not a problem other than some wasted memory.
+ * The extra lists will not be ever used as all the cpu2idx entries will be
+ * 0 before initialization.
  */
 int __alloc_dlock_list_heads(struct dlock_list_heads *dlist,
 			     struct lock_class_key *key)
 {
-	int idx;
+	int idx, cnt = nr_dlock_lists ? nr_dlock_lists : nr_cpu_ids;
 
-	dlist->heads = kcalloc(nr_cpu_ids, sizeof(struct dlock_list_head),
-			       GFP_KERNEL);
+	dlist->heads = kcalloc(cnt, sizeof(struct dlock_list_head), GFP_KERNEL);
 
 	if (!dlist->heads)
 		return -ENOMEM;
 
-	for (idx = 0; idx < nr_cpu_ids; idx++) {
+	for (idx = 0; idx < cnt; idx++) {
 		struct dlock_list_head *head = &dlist->heads[idx];
 
 		INIT_LIST_HEAD(&head->list);
@@ -117,7 +155,10 @@ bool dlock_lists_empty(struct dlock_list_heads *dlist)
 {
 	int idx;
 
-	for (idx = 0; idx < nr_cpu_ids; idx++)
+	/* Shouldn't be called before nr_dlock_lists is initialized */
+	WARN_ON_ONCE(!nr_dlock_lists);
+
+	for (idx = 0; idx < nr_dlock_lists; idx++)
 		if (!list_empty(&dlist->heads[idx].list))
 			return false;
 	return true;
@@ -199,6 +240,9 @@ struct dlock_list_node *__dlock_list_next_list(struct dlock_list_iter *iter)
 	struct dlock_list_node *next;
 	struct dlock_list_head *head;
 
+	/* Shouldn't be called before nr_dlock_lists is initialized */
+	WARN_ON_ONCE(!nr_dlock_lists);
+
 restart:
 	if (iter->entry) {
 		spin_unlock(&iter->entry->lock);
@@ -209,7 +253,7 @@ struct dlock_list_node *__dlock_list_next_list(struct dlock_list_iter *iter)
 	/*
 	 * Try next list
 	 */
-	if (++iter->index >= nr_cpu_ids)
+	if (++iter->index >= nr_dlock_lists)
 		return NULL;	/* All the entries iterated */
 
 	if (list_empty(&iter->head[iter->index].list))
-- 
1.8.3.1

