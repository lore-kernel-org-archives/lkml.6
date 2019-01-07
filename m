Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0C8C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623A3218B0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865029;
	bh=omYbFQerSKtGyLfnFVztcU0wQLHtI7Jo2ahFjhYWdDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SzUn99fXCfgTrEF/3hl4qVE6DwCsI1huuoJQw5tAwL9cWGBpsu/v6VVDSn5yi7MyU
	 RyZzvzBJTOTsoZQYBP4irYULQzbXEle/gnIQIuf+4Nfl0ZzQkHQUOKmLt3mhFLmS5a
	 T07kWH1Tw43RFZ9wtQUeIC+X4INLbysGzGC73R3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfAGMns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:43:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbfAGMno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:43:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E395220449;
        Mon,  7 Jan 2019 12:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865023;
        bh=omYbFQerSKtGyLfnFVztcU0wQLHtI7Jo2ahFjhYWdDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRC9YO+sUBZsjnH6R3tjJezdUact4zlBORm9Fy9GELPHyI8tV39bgwgbSByre254d
         ACDdNPl29lXL0qBjjxAUslDNCepWwiVwd1PareM81ngWaSeHJkXWJiG9weuHeBgy6q
         iH6Ift6q13Lp8ztr5hQFjSVeYURpNoWl7/eJdWws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.20 094/145] Btrfs: fix deadlock with memory reclaim during scrub
Date:   Mon,  7 Jan 2019 13:32:11 +0100
Message-Id: <20190107104449.511419128@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

From: Filipe Manana <fdmanana@suse.com>

commit a5fb11429167ee6ddeeacc554efaf5776b36433a upstream.

When a transaction commit starts, it attempts to pause scrub and it blocks
until the scrub is paused. So while the transaction is blocked waiting for
scrub to pause, we can not do memory allocation with GFP_KERNEL from scrub,
otherwise we risk getting into a deadlock with reclaim.

Checking for scrub pause requests is done early at the beginning of the
while loop of scrub_stripe() and later in the loop, scrub_extent() and
scrub_raid56_parity() are called, which in turn call scrub_pages() and
scrub_pages_for_parity() respectively. These last two functions do memory
allocations using GFP_KERNEL. Same problem could happen while scrubbing
the super blocks, since it calls scrub_pages().

We also can not have any of the worker tasks, created by the scrub task,
doing GFP_KERNEL allocations, because before pausing, the scrub task waits
for all the worker tasks to complete (also done at scrub_stripe()).

So make sure GFP_NOFS is used for the memory allocations because at any
time a scrub pause request can happen from another task that started to
commit a transaction.

Fixes: 58c4e173847a ("btrfs: scrub: use GFP_KERNEL on the submission path")
CC: stable@vger.kernel.org # 4.6+
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/scrub.c |   35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -322,6 +322,7 @@ static struct full_stripe_lock *insert_f
 	struct rb_node *parent = NULL;
 	struct full_stripe_lock *entry;
 	struct full_stripe_lock *ret;
+	unsigned int nofs_flag;
 
 	lockdep_assert_held(&locks_root->lock);
 
@@ -339,8 +340,17 @@ static struct full_stripe_lock *insert_f
 		}
 	}
 
-	/* Insert new lock */
+	/*
+	 * Insert new lock.
+	 *
+	 * We must use GFP_NOFS because the scrub task might be waiting for a
+	 * worker task executing this function and in turn a transaction commit
+	 * might be waiting the scrub task to pause (which needs to wait for all
+	 * the worker tasks to complete before pausing).
+	 */
+	nofs_flag = memalloc_nofs_save();
 	ret = kmalloc(sizeof(*ret), GFP_KERNEL);
+	memalloc_nofs_restore(nofs_flag);
 	if (!ret)
 		return ERR_PTR(-ENOMEM);
 	ret->logical = fstripe_logical;
@@ -1620,8 +1630,19 @@ static int scrub_add_page_to_wr_bio(stru
 	mutex_lock(&sctx->wr_lock);
 again:
 	if (!sctx->wr_curr_bio) {
+		unsigned int nofs_flag;
+
+		/*
+		 * We must use GFP_NOFS because the scrub task might be waiting
+		 * for a worker task executing this function and in turn a
+		 * transaction commit might be waiting the scrub task to pause
+		 * (which needs to wait for all the worker tasks to complete
+		 * before pausing).
+		 */
+		nofs_flag = memalloc_nofs_save();
 		sctx->wr_curr_bio = kzalloc(sizeof(*sctx->wr_curr_bio),
 					      GFP_KERNEL);
+		memalloc_nofs_restore(nofs_flag);
 		if (!sctx->wr_curr_bio) {
 			mutex_unlock(&sctx->wr_lock);
 			return -ENOMEM;
@@ -3772,6 +3793,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info
 	struct scrub_ctx *sctx;
 	int ret;
 	struct btrfs_device *dev;
+	unsigned int nofs_flag;
 
 	if (btrfs_fs_closing(fs_info))
 		return -EINVAL;
@@ -3875,6 +3897,16 @@ int btrfs_scrub_dev(struct btrfs_fs_info
 	atomic_inc(&fs_info->scrubs_running);
 	mutex_unlock(&fs_info->scrub_lock);
 
+	/*
+	 * In order to avoid deadlock with reclaim when there is a transaction
+	 * trying to pause scrub, make sure we use GFP_NOFS for all the
+	 * allocations done at btrfs_scrub_pages() and scrub_pages_for_parity()
+	 * invoked by our callees. The pausing request is done when the
+	 * transaction commit starts, and it blocks the transaction until scrub
+	 * is paused (done at specific points at scrub_stripe() or right above
+	 * before incrementing fs_info->scrubs_running).
+	 */
+	nofs_flag = memalloc_nofs_save();
 	if (!is_dev_replace) {
 		/*
 		 * by holding device list mutex, we can
@@ -3887,6 +3919,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info
 
 	if (!ret)
 		ret = scrub_enumerate_chunks(sctx, dev, start, end);
+	memalloc_nofs_restore(nofs_flag);
 
 	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
 	atomic_dec(&fs_info->scrubs_running);


