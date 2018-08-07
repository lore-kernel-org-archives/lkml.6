Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7E4C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DF92151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DF92151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404216AbeHGVJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:09:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33382 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388940AbeHGVJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:09:53 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DCDA23EE;
        Tue,  7 Aug 2018 18:54:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Xu, Wen" <wen.xu@gatech.edu>,
        Eric Sandeen <sandeen@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eduardo Valentin <eduval@amazon.com>
Subject: [PATCH 4.14 20/21] xfs: dont call xfs_da_shrink_inode with NULL bp
Date:   Tue,  7 Aug 2018 20:51:34 +0200
Message-Id: <20180807172331.908603594@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172330.953888701@linuxfoundation.org>
References: <20180807172330.953888701@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Sandeen <sandeen@sandeen.net>

commit bb3d48dcf86a97dc25fe9fc2c11938e19cb4399a upstream.

xfs_attr3_leaf_create may have errored out before instantiating a buffer,
for example if the blkno is out of range.  In that case there is no work
to do to remove it, and in fact xfs_da_shrink_inode will lead to an oops
if we try.

This also seems to fix a flaw where the original error from
xfs_attr3_leaf_create gets overwritten in the cleanup case, and it
removes a pointless assignment to bp which isn't used after this.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199969
Reported-by: Xu, Wen <wen.xu@gatech.edu>
Tested-by: Xu, Wen <wen.xu@gatech.edu>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/libxfs/xfs_attr_leaf.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -785,9 +785,8 @@ xfs_attr_shortform_to_leaf(xfs_da_args_t
 	ASSERT(blkno == 0);
 	error = xfs_attr3_leaf_create(args, blkno, &bp);
 	if (error) {
-		error = xfs_da_shrink_inode(args, 0, bp);
-		bp = NULL;
-		if (error)
+		/* xfs_attr3_leaf_create may not have instantiated a block */
+		if (bp && (xfs_da_shrink_inode(args, 0, bp) != 0))
 			goto out;
 		xfs_idata_realloc(dp, size, XFS_ATTR_FORK);	/* try to put */
 		memcpy(ifp->if_u1.if_data, tmpbuffer, size);	/* it back */


