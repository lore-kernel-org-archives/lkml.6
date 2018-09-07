Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665EDC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EED20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EED20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeIHCO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:14:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49160 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIHCO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:14:58 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 20D55E84;
        Fri,  7 Sep 2018 21:32:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.14 62/89] NFSv4: Fix locking in pnfs_generic_recover_commit_reqs
Date:   Fri,  7 Sep 2018 23:09:56 +0200
Message-Id: <20180907210859.801338159@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
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

From: Trond Myklebust <trondmy@gmail.com>

commit d0fbb1d8a194c0ec0180c1d073ad709e45503a43 upstream.

The use of the inode->i_lock was converted to a mutex, but we forgot
to remove the old inode unlock/lock() pair that allowed the layout
segment to be put inside the loop.

Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Fixes: e824f99adaaf1 ("NFSv4: Use a mutex to protect the per-inode commit...")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/pnfs_nfs.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -61,7 +61,7 @@ EXPORT_SYMBOL_GPL(pnfs_generic_commit_re
 
 /* The generic layer is about to remove the req from the commit list.
  * If this will make the bucket empty, it will need to put the lseg reference.
- * Note this must be called holding i_lock
+ * Note this must be called holding nfsi->commit_mutex
  */
 void
 pnfs_generic_clear_request_commit(struct nfs_page *req,
@@ -149,9 +149,7 @@ restart:
 		if (list_empty(&b->written)) {
 			freeme = b->wlseg;
 			b->wlseg = NULL;
-			spin_unlock(&cinfo->inode->i_lock);
 			pnfs_put_lseg(freeme);
-			spin_lock(&cinfo->inode->i_lock);
 			goto restart;
 		}
 	}
@@ -167,7 +165,7 @@ static void pnfs_generic_retry_commit(st
 	LIST_HEAD(pages);
 	int i;
 
-	spin_lock(&cinfo->inode->i_lock);
+	mutex_lock(&NFS_I(cinfo->inode)->commit_mutex);
 	for (i = idx; i < fl_cinfo->nbuckets; i++) {
 		bucket = &fl_cinfo->buckets[i];
 		if (list_empty(&bucket->committing))
@@ -177,12 +175,12 @@ static void pnfs_generic_retry_commit(st
 		list_for_each(pos, &bucket->committing)
 			cinfo->ds->ncommitting--;
 		list_splice_init(&bucket->committing, &pages);
-		spin_unlock(&cinfo->inode->i_lock);
+		mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
 		nfs_retry_commit(&pages, freeme, cinfo, i);
 		pnfs_put_lseg(freeme);
-		spin_lock(&cinfo->inode->i_lock);
+		mutex_lock(&NFS_I(cinfo->inode)->commit_mutex);
 	}
-	spin_unlock(&cinfo->inode->i_lock);
+	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
 }
 
 static unsigned int
@@ -222,13 +220,13 @@ void pnfs_fetch_commit_bucket_list(struc
 	struct list_head *pos;
 
 	bucket = &cinfo->ds->buckets[data->ds_commit_index];
-	spin_lock(&cinfo->inode->i_lock);
+	mutex_lock(&NFS_I(cinfo->inode)->commit_mutex);
 	list_for_each(pos, &bucket->committing)
 		cinfo->ds->ncommitting--;
 	list_splice_init(&bucket->committing, pages);
 	data->lseg = bucket->clseg;
 	bucket->clseg = NULL;
-	spin_unlock(&cinfo->inode->i_lock);
+	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
 
 }
 


