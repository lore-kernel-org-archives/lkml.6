Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7BFC476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A6D21471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A6D21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbeGLQ51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:57:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732250AbeGLQ5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:57:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7547B818B11B;
        Thu, 12 Jul 2018 16:47:04 +0000 (UTC)
Received: from llong.com (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDE1A1C677;
        Thu, 12 Jul 2018 16:47:03 +0000 (UTC)
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
        Michal Hocko <mhocko@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v7 4/6] fs/dcache: Print negative dentry warning every min until turned off by user
Date:   Thu, 12 Jul 2018 12:46:03 -0400
Message-Id: <1531413965-5401-5-git-send-email-longman@redhat.com>
In-Reply-To: <1531413965-5401-1-git-send-email-longman@redhat.com>
References: <1531413965-5401-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 12 Jul 2018 16:47:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 12 Jul 2018 16:47:04 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there are too many negative dentries, printing a warning once may
not get the attention of the system administrator. So it is now change
to print a warning every minute until it is turned off by either writing
a 0 into fs/neg-dentry-limit or the limit is increased. After that the
system administrator can look into the reason why there are so many
negative dentries.

Note that the warning is printed when the global negative dentry free
pool is depleted even if there are space in other percpu negative dentry
counts for more.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/dcache.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1fad368..b2c1585 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -139,6 +139,7 @@ struct dentry_stat_t dentry_stat = {
  * the extra ones will be returned back to the global pool.
  */
 #define NEG_DENTRY_BATCH	(1 << 8)
+#define NEG_WARN_PERIOD 	(60 * HZ)	/* Print a warning every min */
 
 static struct static_key limit_neg_key = STATIC_KEY_INIT_FALSE;
 static int neg_dentry_limit_old;
@@ -150,6 +151,7 @@ struct dentry_stat_t dentry_stat = {
 static struct {
 	raw_spinlock_t nfree_lock;
 	long nfree;			/* Negative dentry free pool */
+	unsigned long warn_jiffies;	/* Time when last warning is printed */
 } ndblk ____cacheline_aligned_in_smp;
 proc_handler proc_neg_dentry_limit;
 
@@ -309,6 +311,7 @@ static long __neg_dentry_nfree_dec(long cnt)
 static noinline void neg_dentry_inc_slowpath(struct dentry *dentry)
 {
 	long cnt = 0, *pcnt;
+	unsigned long current_time;
 
 	/*
 	 * Try to move some negative dentry quota from the global free
@@ -323,12 +326,38 @@ static noinline void neg_dentry_inc_slowpath(struct dentry *dentry)
 	}
 	put_cpu_ptr(&nr_dentry_neg);
 
+	if (cnt)
+		goto out;
+
 	/*
-	 * Put out a warning if there are too many negative dentries.
+	 * Put out a warning every minute or so if there are just too many
+	 * negative dentries.
 	 */
-	if (!cnt)
-		pr_warn_once("There are too many negative dentries.");
+	current_time = jiffies;
+
+	if (current_time < ndblk.warn_jiffies + NEG_WARN_PERIOD)
+		goto out;
+	/*
+	 * Update the time in ndblk.warn_jiffies and print a warning
+	 * if time update is successful.
+	 */
+	raw_spin_lock(&ndblk.nfree_lock);
+	if (current_time < ndblk.warn_jiffies + NEG_WARN_PERIOD) {
+		raw_spin_unlock(&ndblk.nfree_lock);
+		goto out;
+	}
+	ndblk.warn_jiffies = current_time;
+	raw_spin_unlock(&ndblk.nfree_lock);
 
+	/*
+	 * Get the current negative dentry count & print a warning.
+	 */
+	cnt = get_nr_dentry_neg();
+	pr_warn("Warning: Too many negative dentries (%ld). "
+		"This warning can be disabled by writing 0 to \"fs/neg-dentry-limit\" or increasing the limit.\n",
+		cnt);
+out:
+	return;
 }
 
 /*
-- 
1.8.3.1

