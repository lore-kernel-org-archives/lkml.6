Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455DDC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087C2223B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087C2223B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934979AbeGFTfr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:35:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934818AbeGFTea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:34:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E41B3818F051;
        Fri,  6 Jul 2018 19:34:29 +0000 (UTC)
Received: from llong.com (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68BD67C2E;
        Fri,  6 Jul 2018 19:34:29 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v6 4/7] fs/dcache: Spread negative dentry pruning across multiple CPUs
Date:   Fri,  6 Jul 2018 15:32:49 -0400
Message-Id: <1530905572-817-5-git-send-email-longman@redhat.com>
In-Reply-To: <1530905572-817-1-git-send-email-longman@redhat.com>
References: <1530905572-817-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 06 Jul 2018 19:34:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 06 Jul 2018 19:34:30 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing negative dentry pruning using schedule_delayed_work() will
typically concentrate the pruning effort on one particular CPU. That is
not fair to the tasks running on that CPU. In addition, it is possible
that one CPU can have all its negative dentries pruned away while the
others can still have more negative dentries than the percpu limit.

To be fair, negative dentries pruning is now done across all the online
CPUs, if they all have close to the percpu limit of negative dentries.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/dcache.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ac25029..3be9246 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -367,7 +367,8 @@ static void __neg_dentry_inc(struct dentry *dentry)
 			WRITE_ONCE(ndblk.prune_sb, NULL);
 		} else {
 			atomic_inc(&ndblk.prune_sb->s_active);
-			schedule_delayed_work(&prune_neg_dentry_work, 1);
+			schedule_delayed_work_on(smp_processor_id(),
+						&prune_neg_dentry_work, 1);
 		}
 	}
 }
@@ -1508,8 +1509,9 @@ static enum lru_status dentry_negative_lru_isolate(struct list_head *item,
  */
 static void prune_negative_dentry(struct work_struct *work)
 {
+	int cpu = smp_processor_id();
 	int freed, last_n_neg;
-	long nfree;
+	long nfree, excess;
 	struct super_block *sb = READ_ONCE(ndblk.prune_sb);
 	LIST_HEAD(dispose);
 
@@ -1543,9 +1545,40 @@ static void prune_negative_dentry(struct work_struct *work)
 	    (nfree >= neg_dentry_nfree_init/2) || NEG_IS_SB_UMOUNTING(sb))
 		goto stop_pruning;
 
-	schedule_delayed_work(&prune_neg_dentry_work,
-			     (nfree < neg_dentry_nfree_init/8)
-			     ? NEG_PRUNING_FAST_RATE : NEG_PRUNING_SLOW_RATE);
+	/*
+	 * If the negative dentry count in the current cpu is less than the
+	 * per_cpu limit, schedule the pruning in the next cpu if it has
+	 * more negative dentries. This will make the negative dentry count
+	 * reduction spread more evenly across multiple per-cpu counters.
+	 */
+	excess = neg_dentry_percpu_limit - __this_cpu_read(nr_dentry_neg);
+	if (excess > 0) {
+		int next_cpu = cpumask_next(cpu, cpu_online_mask);
+
+		if (next_cpu >= nr_cpu_ids)
+			next_cpu = cpumask_first(cpu_online_mask);
+		if (per_cpu(nr_dentry_neg, next_cpu) >
+		    __this_cpu_read(nr_dentry_neg)) {
+			cpu = next_cpu;
+
+			/*
+			 * Transfer some of the excess negative dentry count
+			 * to the free pool if the current percpu pool is less
+			 * than 3/4 of the limit.
+			 */
+			if ((excess > neg_dentry_percpu_limit/4) &&
+			    raw_spin_trylock(&ndblk.nfree_lock)) {
+				WRITE_ONCE(ndblk.nfree,
+					   ndblk.nfree + NEG_DENTRY_BATCH);
+				__this_cpu_add(nr_dentry_neg, NEG_DENTRY_BATCH);
+				raw_spin_unlock(&ndblk.nfree_lock);
+			}
+		}
+	}
+
+	schedule_delayed_work_on(cpu, &prune_neg_dentry_work,
+			(nfree < neg_dentry_nfree_init/8)
+			? NEG_PRUNING_FAST_RATE : NEG_PRUNING_SLOW_RATE);
 	return;
 
 stop_pruning:
-- 
1.8.3.1

