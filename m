Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E45C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0E321757
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0E321757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389650AbeHGQwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:52:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389073AbeHGQwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:52:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6EF187A84;
        Tue,  7 Aug 2018 14:37:22 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8F102026D66;
        Tue,  7 Aug 2018 14:37:22 +0000 (UTC)
Date:   Tue, 7 Aug 2018 10:37:21 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: xfs: cancel dfops on xfs_defer_finish() error
Message-ID: <20180807143720.GA55416@bfoster>
References: <18f3296d-e5d4-4d76-51f8-a40d0ceaa20e@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18f3296d-e5d4-4d76-51f8-a40d0ceaa20e@canonical.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 07 Aug 2018 14:37:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 07 Aug 2018 14:37:22 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bfoster@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 03:14:07PM +0100, Colin Ian King wrote:
> Hi,
> 
> Recent commit 82ff27bc52a88cb5cc400bfa64e210d3ec8dfebd ("xfs: automatic
> dfops buffer relogging") removed the assignment of variable error:
> 
> -       error = xfs_defer_bjoin(tp->t_dfops, bp);
>         if (error) {
>                 xfs_trans_bhold_release(tp, bp);
>                 xfs_trans_brelse(tp, bp);
> 

Hmm, I _think_ we can just drop these error checks now that this
pre-finish error state is non-existent, something like the appended diff
(with additional cleanups). E.g., if the buffer is held in the
transaction then the bjoin is implicit. If the finish fails, then the
state is essentially unchanged by the relogging patch.

That said, the error handling is a bit tricky here. Darrick, I think you
reworked this recently.. thoughts?

Brian

--- 8< ---

diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index 70a76ac41f01..2106c4142ecd 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -311,7 +311,7 @@ xfs_dquot_disk_alloc(
 			XFS_DQUOT_CLUSTER_SIZE_FSB, XFS_BMAPI_METADATA,
 			XFS_QM_DQALLOC_SPACE_RES(mp), &map, &nmaps);
 	if (error)
-		goto error0;
+		return error;
 	ASSERT(map.br_blockcount == XFS_DQUOT_CLUSTER_SIZE_FSB);
 	ASSERT(nmaps == 1);
 	ASSERT((map.br_startblock != DELAYSTARTBLOCK) &&
@@ -326,8 +326,8 @@ xfs_dquot_disk_alloc(
 	bp = xfs_trans_get_buf(tp, mp->m_ddev_targp, dqp->q_blkno,
 			mp->m_quotainfo->qi_dqchunklen, 0);
 	if (!bp) {
-		error = -ENOMEM;
-		goto error1;
+		xfs_defer_cancel(tp);
+		return -ENOMEM;
 	}
 	bp->b_ops = &xfs_dquot_buf_ops;
 
@@ -349,10 +349,8 @@ xfs_dquot_disk_alloc(
 	 * the buffer locked across the _defer_finish call.  We can now do
 	 * this correctly with xfs_defer_bjoin.
 	 *
-	 * Above, we allocated a disk block for the dquot information and
-	 * used get_buf to initialize the dquot.  If the _defer_bjoin fails,
-	 * the buffer is still locked to *tpp, so we must _bhold_release and
-	 * then _trans_brelse the buffer.  If the _defer_finish fails, the old
+	 * Above, we allocated a disk block for the dquot information and used
+	 * get_buf to initialize the dquot. If the _defer_finish fails, the old
 	 * transaction is gone but the new buffer is not joined or held to any
 	 * transaction, so we must _buf_relse it.
 	 *
@@ -362,24 +360,14 @@ xfs_dquot_disk_alloc(
 	 * manually or by committing the transaction.
 	 */
 	xfs_trans_bhold(tp, bp);
-	if (error) {
-		xfs_trans_bhold_release(tp, bp);
-		xfs_trans_brelse(tp, bp);
-		goto error1;
-	}
 	error = xfs_defer_finish(tpp);
 	tp = *tpp;
 	if (error) {
 		xfs_buf_relse(bp);
-		goto error0;
+		return error;
 	}
 	*bpp = bp;
 	return 0;
-
-error1:
-	xfs_defer_cancel(tp);
-error0:
-	return error;
 }
 
 /*
