Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2097AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC63420871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AALeqw8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC63420871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbeKLISn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733070AbeKLISm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:42 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A07921508;
        Sun, 11 Nov 2018 22:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975326;
        bh=cN0wSZxstLfEOKx1EFausJa3RJkM0U+vew/d2orEHEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AALeqw8PCKaxFEHOtQPf8rjZN4Xxh8oGRff53GGNOZWPQ2bdMvHLFnCvtevdg/5+E
         8aFFKcEkQG3p+V8qnxV/KVI4wi4jHq94Ua4we7szO0U4UCJRbabyAO09LPxDQWSB5e
         HJOYWf+m+6hmZFEaZCQc1/wmhtP9gD28bAfRpKeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 335/361] btrfs: keep trim from interfering with transaction commits
Date:   Sun, 11 Nov 2018 14:21:22 -0800
Message-Id: <20181111221700.234209394@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Mahoney <jeffm@suse.com>

commit fee7acc361314df6561208c2d3c0882d663dd537 upstream.

Commit 499f377f49f08 (btrfs: iterate over unused chunk space in FITRIM)
fixed free space trimming, but introduced latency when it was running.
This is due to it pinning the transaction using both a incremented
refcount and holding the commit root sem for the duration of a single
trim operation.

This was to ensure safety but it's unnecessary.  We already hold the the
chunk mutex so we know that the chunk we're using can't be allocated
while we're trimming it.

In order to check against chunks allocated already in this transaction,
we need to check the pending chunks list.  To to that safely without
joining the transaction (or attaching than then having to commit it) we
need to ensure that the dev root's commit root doesn't change underneath
us and the pending chunk lists stays around until we're done with it.

We can ensure the former by holding the commit root sem and the latter
by pinning the transaction.  We do this now, but the critical section
covers the trim operation itself and we don't need to do that.

This patch moves the pinning and unpinning logic into helpers and unpins
the transaction after performing the search and check for pending
chunks.

Limiting the critical section of the transaction pinning improves the
latency substantially on slower storage (e.g. image files over NFS).

Fixes: 499f377f49f08 ("btrfs: iterate over unused chunk space in FITRIM")
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -10772,14 +10772,16 @@ int btrfs_error_unpin_extent_range(struc
  * We don't want a transaction for this since the discard may take a
  * substantial amount of time.  We don't require that a transaction be
  * running, but we do need to take a running transaction into account
- * to ensure that we're not discarding chunks that were released in
- * the current transaction.
+ * to ensure that we're not discarding chunks that were released or
+ * allocated in the current transaction.
  *
  * Holding the chunks lock will prevent other threads from allocating
  * or releasing chunks, but it won't prevent a running transaction
  * from committing and releasing the memory that the pending chunks
  * list head uses.  For that, we need to take a reference to the
- * transaction.
+ * transaction and hold the commit root sem.  We only need to hold
+ * it while performing the free space search since we have already
+ * held back allocations.
  */
 static int btrfs_trim_free_extents(struct btrfs_device *device,
 				   u64 minlen, u64 *trimmed)
@@ -10810,9 +10812,13 @@ static int btrfs_trim_free_extents(struc
 
 		ret = mutex_lock_interruptible(&fs_info->chunk_mutex);
 		if (ret)
-			return ret;
+			break;
 
-		down_read(&fs_info->commit_root_sem);
+		ret = down_read_killable(&fs_info->commit_root_sem);
+		if (ret) {
+			mutex_unlock(&fs_info->chunk_mutex);
+			break;
+		}
 
 		spin_lock(&fs_info->trans_lock);
 		trans = fs_info->running_transaction;
@@ -10820,13 +10826,17 @@ static int btrfs_trim_free_extents(struc
 			refcount_inc(&trans->use_count);
 		spin_unlock(&fs_info->trans_lock);
 
+		if (!trans)
+			up_read(&fs_info->commit_root_sem);
+
 		ret = find_free_dev_extent_start(trans, device, minlen, start,
 						 &start, &len);
-		if (trans)
+		if (trans) {
+			up_read(&fs_info->commit_root_sem);
 			btrfs_put_transaction(trans);
+		}
 
 		if (ret) {
-			up_read(&fs_info->commit_root_sem);
 			mutex_unlock(&fs_info->chunk_mutex);
 			if (ret == -ENOSPC)
 				ret = 0;
@@ -10834,7 +10844,6 @@ static int btrfs_trim_free_extents(struc
 		}
 
 		ret = btrfs_issue_discard(device->bdev, start, len, &bytes);
-		up_read(&fs_info->commit_root_sem);
 		mutex_unlock(&fs_info->chunk_mutex);
 
 		if (ret)


