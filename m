Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED32DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B306B20811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298773;
	bh=Nj9zUHsK+UQ+zvMWre8HY3wZDxW3obLl76pCSvLmvD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q5+ay/aVKXWi2jypAHxuxy5HmAvVJiD2q7jHLXK6tJbsh4qJiwt0f8i0Cdm3r5Tlg
	 FQkGCO02+9EfmBY3sKtYjCoHYwCQx0VYumBSLPW0nANtHmXyEbOMmVfgLWgYm/uT7S
	 Uq2CQzYbiecNUx3C2c5kobqffFzfXkxDoc73dSl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733294AbeLTJjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:39:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:46248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731150AbeLTJZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:25:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8947D217D7;
        Thu, 20 Dec 2018 09:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297934;
        bh=Nj9zUHsK+UQ+zvMWre8HY3wZDxW3obLl76pCSvLmvD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wVX2rifySaK5jXCxnaNZ+Uxu0y6mjwE9zWDCaQT/5bHxyx4whXmQXluqgsCw6PfJZ
         rnrBzwzVdCJvpPNee9YsVo+giKIaFTH/SU7Hpg1di4+XEnnroV5NE9CAl9dEGV487M
         wXncR6YSSa0THhA/CqBzy1ns4/3nUoBnei6bM7xw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 10/72] dm thin: send event about thin-pool state change _after_ making it
Date:   Thu, 20 Dec 2018 10:18:09 +0100
Message-Id: <20181220085922.743865996@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Snitzer <snitzer@redhat.com>

commit f6c367585d0d851349d3a9e607c43e5bea993fa1 upstream.

Sending a DM event before a thin-pool state change is about to happen is
a bug.  It wasn't realized until it became clear that userspace response
to the event raced with the actual state change that the event was
meant to notify about.

Fix this by first updating internal thin-pool state to reflect what the
DM event is being issued about.  This fixes a long-standing racey/buggy
userspace device-mapper-test-suite 'resize_io' test that would get an
event but not find the state it was looking for -- so it would just go
on to hang because no other events caused the test to reevaluate the
thin-pool's state.

Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-thin.c |   68 ++++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -195,7 +195,7 @@ static void throttle_unlock(struct throt
 struct dm_thin_new_mapping;
 
 /*
- * The pool runs in 4 modes.  Ordered in degraded order for comparisons.
+ * The pool runs in various modes.  Ordered in degraded order for comparisons.
  */
 enum pool_mode {
 	PM_WRITE,		/* metadata may be changed */
@@ -281,9 +281,38 @@ struct pool {
 	struct dm_bio_prison_cell **cell_sort_array;
 };
 
-static enum pool_mode get_pool_mode(struct pool *pool);
 static void metadata_operation_failed(struct pool *pool, const char *op, int r);
 
+static enum pool_mode get_pool_mode(struct pool *pool)
+{
+	return pool->pf.mode;
+}
+
+static void notify_of_pool_mode_change(struct pool *pool)
+{
+	const char *descs[] = {
+		"write",
+		"out-of-data-space",
+		"read-only",
+		"read-only",
+		"fail"
+	};
+	const char *extra_desc = NULL;
+	enum pool_mode mode = get_pool_mode(pool);
+
+	if (mode == PM_OUT_OF_DATA_SPACE) {
+		if (!pool->pf.error_if_no_space)
+			extra_desc = " (queue IO)";
+		else
+			extra_desc = " (error IO)";
+	}
+
+	dm_table_event(pool->ti->table);
+	DMINFO("%s: switching pool to %s%s mode",
+	       dm_device_name(pool->pool_md),
+	       descs[(int)mode], extra_desc ? : "");
+}
+
 /*
  * Target context for a pool.
  */
@@ -2362,8 +2391,6 @@ static void do_waker(struct work_struct
 	queue_delayed_work(pool->wq, &pool->waker, COMMIT_PERIOD);
 }
 
-static void notify_of_pool_mode_change_to_oods(struct pool *pool);
-
 /*
  * We're holding onto IO to allow userland time to react.  After the
  * timeout either the pool will have been resized (and thus back in
@@ -2376,7 +2403,7 @@ static void do_no_space_timeout(struct w
 
 	if (get_pool_mode(pool) == PM_OUT_OF_DATA_SPACE && !pool->pf.error_if_no_space) {
 		pool->pf.error_if_no_space = true;
-		notify_of_pool_mode_change_to_oods(pool);
+		notify_of_pool_mode_change(pool);
 		error_retry_list_with_code(pool, BLK_STS_NOSPC);
 	}
 }
@@ -2444,26 +2471,6 @@ static void noflush_work(struct thin_c *
 
 /*----------------------------------------------------------------*/
 
-static enum pool_mode get_pool_mode(struct pool *pool)
-{
-	return pool->pf.mode;
-}
-
-static void notify_of_pool_mode_change(struct pool *pool, const char *new_mode)
-{
-	dm_table_event(pool->ti->table);
-	DMINFO("%s: switching pool to %s mode",
-	       dm_device_name(pool->pool_md), new_mode);
-}
-
-static void notify_of_pool_mode_change_to_oods(struct pool *pool)
-{
-	if (!pool->pf.error_if_no_space)
-		notify_of_pool_mode_change(pool, "out-of-data-space (queue IO)");
-	else
-		notify_of_pool_mode_change(pool, "out-of-data-space (error IO)");
-}
-
 static bool passdown_enabled(struct pool_c *pt)
 {
 	return pt->adjusted_pf.discard_passdown;
@@ -2512,8 +2519,6 @@ static void set_pool_mode(struct pool *p
 
 	switch (new_mode) {
 	case PM_FAIL:
-		if (old_mode != new_mode)
-			notify_of_pool_mode_change(pool, "failure");
 		dm_pool_metadata_read_only(pool->pmd);
 		pool->process_bio = process_bio_fail;
 		pool->process_discard = process_bio_fail;
@@ -2527,8 +2532,6 @@ static void set_pool_mode(struct pool *p
 
 	case PM_OUT_OF_METADATA_SPACE:
 	case PM_READ_ONLY:
-		if (!is_read_only_pool_mode(old_mode))
-			notify_of_pool_mode_change(pool, "read-only");
 		dm_pool_metadata_read_only(pool->pmd);
 		pool->process_bio = process_bio_read_only;
 		pool->process_discard = process_bio_success;
@@ -2549,8 +2552,6 @@ static void set_pool_mode(struct pool *p
 		 * alarming rate.  Adjust your low water mark if you're
 		 * frequently seeing this mode.
 		 */
-		if (old_mode != new_mode)
-			notify_of_pool_mode_change_to_oods(pool);
 		pool->out_of_data_space = true;
 		pool->process_bio = process_bio_read_only;
 		pool->process_discard = process_discard_bio;
@@ -2563,8 +2564,6 @@ static void set_pool_mode(struct pool *p
 		break;
 
 	case PM_WRITE:
-		if (old_mode != new_mode)
-			notify_of_pool_mode_change(pool, "write");
 		if (old_mode == PM_OUT_OF_DATA_SPACE)
 			cancel_delayed_work_sync(&pool->no_space_timeout);
 		pool->out_of_data_space = false;
@@ -2584,6 +2583,9 @@ static void set_pool_mode(struct pool *p
 	 * doesn't cause an unexpected mode transition on resume.
 	 */
 	pt->adjusted_pf.mode = new_mode;
+
+	if (old_mode != new_mode)
+		notify_of_pool_mode_change(pool);
 }
 
 static void abort_transaction(struct pool *pool)


