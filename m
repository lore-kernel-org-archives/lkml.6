Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752267AbeFENdg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:33:36 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41894 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbeFEN3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:29:55 -0400
X-Google-Smtp-Source: ADUXVKKNApFYE74XOj946Haq9J01CxIL2etcpf86fnq5N9f/CkPuakypz0bsOIoyq3HH7SkcqJcUNA==
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 03/13] blk-cgroup: allow controllers to output their own stats
Date: Tue,  5 Jun 2018 09:29:38 -0400
Message-Id: <20180605132948.1664-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605132948.1664-1-josef@toxicpanda.com>
References: <20180605132948.1664-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

blk-iolatency has a few stats that it would like to print out, and
instead of adding a bunch of crap to the generic code just provide a
helper so that controllers can add stuff to the stat line if they want
to.

Hide it behind a boot option since it changes the output of io.stat from
normal, and these stats are only interesting to developers.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 block/blk-cgroup.c         | 61 +++++++++++++++++++++++++++++++++++++++++++---
 include/linux/blk-cgroup.h |  3 +++
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index eb85cb87c40f..b2ac6a7f851f 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -50,6 +50,8 @@ static struct blkcg_policy *blkcg_policy[BLKCG_MAX_POLS];
 
 static LIST_HEAD(all_blkcgs);		/* protected by blkcg_pol_mutex */
 
+static bool blkcg_debug_stats = false;
+
 static bool blkcg_policy_enabled(struct request_queue *q,
 				 const struct blkcg_policy *pol)
 {
@@ -954,13 +956,28 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
 		const char *dname;
+		char *buf;
 		struct blkg_rwstat rwstat;
 		u64 rbytes, wbytes, rios, wios;
+		size_t size = seq_get_buf(sf, &buf), count = 0, total = 0;
+		int i;
 
 		dname = blkg_dev_name(blkg);
 		if (!dname)
 			continue;
 
+		/*
+		 * Hooray string manipulation, count is the size written NOT
+		 * INCLUDING THE \0, so size is now count+1 less than what we
+		 * had before, but we want to start writing the next bit from
+		 * the \0 so we only add count to buf.
+		 */
+		count = snprintf(buf, size, "%s ", dname);
+		if (count >= size)
+			continue;
+		buf += count;
+		size -= count + 1;
+
 		spin_lock_irq(blkg->q->queue_lock);
 
 		rwstat = blkg_rwstat_recursive_sum(blkg, NULL,
@@ -975,9 +992,44 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 
 		spin_unlock_irq(blkg->q->queue_lock);
 
-		if (rbytes || wbytes || rios || wios)
-			seq_printf(sf, "%s rbytes=%llu wbytes=%llu rios=%llu wios=%llu\n",
-				   dname, rbytes, wbytes, rios, wios);
+		if (rbytes || wbytes || rios || wios) {
+			total += count;
+			count = snprintf(buf, size,
+					 "rbytes=%llu wbytes=%llu rios=%llu wios=%llu",
+					 rbytes, wbytes, rios, wios);
+			if (count >= size)
+				continue;
+			buf += count;
+			total += count;
+			size -= count + 1;
+		}
+
+		if (!blkcg_debug_stats)
+			goto next;
+
+		mutex_lock(&blkcg_pol_mutex);
+		for (i = 0; i < BLKCG_MAX_POLS; i++) {
+			struct blkcg_policy *pol = blkcg_policy[i];
+
+			if (!blkg->pd[i] || !pol->pd_stat_fn)
+				continue;
+
+			count = pol->pd_stat_fn(blkg->pd[i], buf, size);
+			if (count >= size)
+				continue;
+			buf += count;
+			total += count;
+			size -= count + 1;
+		}
+		mutex_unlock(&blkcg_pol_mutex);
+next:
+		if (total) {
+			count = snprintf(buf, size, "\n");
+			if (count >= size)
+				continue;
+			total += count;
+			seq_commit(sf, total);
+		}
 	}
 
 	rcu_read_unlock();
@@ -1547,3 +1599,6 @@ void blkcg_policy_unregister(struct blkcg_policy *pol)
 	mutex_unlock(&blkcg_pol_register_mutex);
 }
 EXPORT_SYMBOL_GPL(blkcg_policy_unregister);
+
+module_param(blkcg_debug_stats, bool, 0444);
+MODULE_PARM_DESC(blkcg_debug_stats, "True if you want debug stats, false if not");
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 69aa71dc0c04..b41292726c0f 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -148,6 +148,8 @@ typedef void (blkcg_pol_online_pd_fn)(struct blkg_policy_data *pd);
 typedef void (blkcg_pol_offline_pd_fn)(struct blkg_policy_data *pd);
 typedef void (blkcg_pol_free_pd_fn)(struct blkg_policy_data *pd);
 typedef void (blkcg_pol_reset_pd_stats_fn)(struct blkg_policy_data *pd);
+typedef size_t (blkcg_pol_stat_pd_fn)(struct blkg_policy_data *pd, char *buf,
+				      size_t size);
 
 struct blkcg_policy {
 	int				plid;
@@ -167,6 +169,7 @@ struct blkcg_policy {
 	blkcg_pol_offline_pd_fn		*pd_offline_fn;
 	blkcg_pol_free_pd_fn		*pd_free_fn;
 	blkcg_pol_reset_pd_stats_fn	*pd_reset_stats_fn;
+	blkcg_pol_stat_pd_fn		*pd_stat_fn;
 };
 
 extern struct blkcg blkcg_root;
-- 
2.14.3
