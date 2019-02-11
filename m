Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C7EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A0D222AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896742;
	bh=9+FFu1JwKgwJM9K971Kqa9e+BDxxVf7c9wRH60atDF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k68+9UJNY3+LQ9M3j0j9CFNkcKCa23jiPi1YJbS2ZZm3AKBQp4dRZtqxUqW8EHxsL
	 tjdykLFZhZsT43DWJRWH4+Wcknbc4cpd/tZBdj4RTz8Kwm9yfoGcJr2Hf75ClPLFxI
	 JpvXEIy5pMJU9IDzbAeASSIM8wxyEh5aZVX+ewWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbfBKOwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:52:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:38498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387619AbfBKOwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:52:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8D2D2081B;
        Mon, 11 Feb 2019 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896737;
        bh=9+FFu1JwKgwJM9K971Kqa9e+BDxxVf7c9wRH60atDF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jl2d3kp5WkhyZvET6abgjvZv2HuD3aprCLDdgXz2MaPMzAoOQVn8+xz/ifd/Do2nq
         pyaFMvPwbdpQkHrlzrgEFhJsJ+gqIy+buEXkBm+dNYRAmuKtNz06Jchreo90UTDbc0
         uGMCwWJBcqVf32NKQ8QIWqqwxg/3Nkcg4RvorvDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 253/313] xfs: fix transient reference count error in xfs_buf_resubmit_failed_buffers
Date:   Mon, 11 Feb 2019 15:18:53 +0100
Message-Id: <20190211141910.239114958@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

commit d43aaf1685aa471f0593685c9f54d53e3af3cf3f upstream.

When retrying a failed inode or dquot buffer,
xfs_buf_resubmit_failed_buffers() clears all the failed flags from
the inde/dquot log items. In doing so, it also drops all the
reference counts on the buffer that the failed log items hold. This
means it can drop all the active references on the buffer and hence
free the buffer before it queues it for write again.

Putting the buffer on the delwri queue takes a reference to the
buffer (so that it hangs around until it has been written and
completed), but this goes bang if the buffer has already been freed.

Hence we need to add the buffer to the delwri queue before we remove
the failed flags from the log items attached to the buffer to ensure
it always remains referenced during the resubmit process.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_buf_item.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 12d8455bfbb2..010db5f8fb00 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -1233,9 +1233,23 @@ xfs_buf_iodone(
 }
 
 /*
- * Requeue a failed buffer for writeback
+ * Requeue a failed buffer for writeback.
  *
- * Return true if the buffer has been re-queued properly, false otherwise
+ * We clear the log item failed state here as well, but we have to be careful
+ * about reference counts because the only active reference counts on the buffer
+ * may be the failed log items. Hence if we clear the log item failed state
+ * before queuing the buffer for IO we can release all active references to
+ * the buffer and free it, leading to use after free problems in
+ * xfs_buf_delwri_queue. It makes no difference to the buffer or log items which
+ * order we process them in - the buffer is locked, and we own the buffer list
+ * so nothing on them is going to change while we are performing this action.
+ *
+ * Hence we can safely queue the buffer for IO before we clear the failed log
+ * item state, therefore  always having an active reference to the buffer and
+ * avoiding the transient zero-reference state that leads to use-after-free.
+ *
+ * Return true if the buffer was added to the buffer list, false if it was
+ * already on the buffer list.
  */
 bool
 xfs_buf_resubmit_failed_buffers(
@@ -1243,16 +1257,16 @@ xfs_buf_resubmit_failed_buffers(
 	struct list_head	*buffer_list)
 {
 	struct xfs_log_item	*lip;
+	bool			ret;
+
+	ret = xfs_buf_delwri_queue(bp, buffer_list);
 
 	/*
-	 * Clear XFS_LI_FAILED flag from all items before resubmit
-	 *
-	 * XFS_LI_FAILED set/clear is protected by ail_lock, caller  this
+	 * XFS_LI_FAILED set/clear is protected by ail_lock, caller of this
 	 * function already have it acquired
 	 */
 	list_for_each_entry(lip, &bp->b_li_list, li_bio_list)
 		xfs_clear_li_failed(lip);
 
-	/* Add this buffer back to the delayed write list */
-	return xfs_buf_delwri_queue(bp, buffer_list);
+	return ret;
 }
-- 
2.19.1



