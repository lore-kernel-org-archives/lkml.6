Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B025ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC4521479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC4521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeJJBLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:11:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:39678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeJJBLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:11:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 200C7AFF1;
        Tue,  9 Oct 2018 17:53:29 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] ceph: only allow punch hole mode in fallocate
Date:   Tue,  9 Oct 2018 18:54:28 +0100
Message-Id: <20181009175428.18543-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation of cephfs fallocate isn't correct as it doesn't
really reserve the space in the cluster, which means that a subsequent
call to a write may actually fail due to lack of space.  In fact, it is
currently possible to fallocate an amount space that is larger than the
free space in the cluster.

Since there's no easy solution to fix this at the moment, this patch
simply removes support for all fallocate operations but
FALLOC_FL_PUNCH_HOLE (which implies FALLOC_FL_KEEP_SIZE).

Link: https://tracker.ceph.com/issues/36317
Cc: stable@vger.kernel.org
Fixes: ad7a60de882a ("ceph: punch hole support")
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/file.c | 45 +++++++++------------------------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 92ab20433682..91a7ad259bcf 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1735,7 +1735,6 @@ static long ceph_fallocate(struct file *file, int mode,
 	struct ceph_file_info *fi = file->private_data;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	struct ceph_cap_flush *prealloc_cf;
 	int want, got = 0;
 	int dirty;
@@ -1743,10 +1742,7 @@ static long ceph_fallocate(struct file *file, int mode,
 	loff_t endoff = 0;
 	loff_t size;
 
-	if ((offset + length) > max(i_size_read(inode), fsc->max_file_size))
-		return -EFBIG;
-
-	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
+	if (mode != (FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
 		return -EOPNOTSUPP;
 
 	if (!S_ISREG(inode->i_mode))
@@ -1763,18 +1759,6 @@ static long ceph_fallocate(struct file *file, int mode,
 		goto unlock;
 	}
 
-	if (!(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)) &&
-	    ceph_quota_is_max_bytes_exceeded(inode, offset + length)) {
-		ret = -EDQUOT;
-		goto unlock;
-	}
-
-	if (ceph_osdmap_flag(&fsc->client->osdc, CEPH_OSDMAP_FULL) &&
-	    !(mode & FALLOC_FL_PUNCH_HOLE)) {
-		ret = -ENOSPC;
-		goto unlock;
-	}
-
 	if (ci->i_inline_version != CEPH_INLINE_NONE) {
 		ret = ceph_uninline_data(file, NULL);
 		if (ret < 0)
@@ -1782,12 +1766,12 @@ static long ceph_fallocate(struct file *file, int mode,
 	}
 
 	size = i_size_read(inode);
-	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
-		endoff = offset + length;
-		ret = inode_newsize_ok(inode, endoff);
-		if (ret)
-			goto unlock;
-	}
+
+	/* Are we punching a hole beyond EOF? */
+	if (offset >= size)
+		goto unlock;
+	if ((offset + length) > size)
+		length = size - offset;
 
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
 		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
@@ -1798,16 +1782,8 @@ static long ceph_fallocate(struct file *file, int mode,
 	if (ret < 0)
 		goto unlock;
 
-	if (mode & FALLOC_FL_PUNCH_HOLE) {
-		if (offset < size)
-			ceph_zero_pagecache_range(inode, offset, length);
-		ret = ceph_zero_objects(inode, offset, length);
-	} else if (endoff > size) {
-		truncate_pagecache_range(inode, size, -1);
-		if (ceph_inode_set_size(inode, endoff))
-			ceph_check_caps(ceph_inode(inode),
-				CHECK_CAPS_AUTHONLY, NULL);
-	}
+	ceph_zero_pagecache_range(inode, offset, length);
+	ret = ceph_zero_objects(inode, offset, length);
 
 	if (!ret) {
 		spin_lock(&ci->i_ceph_lock);
@@ -1817,9 +1793,6 @@ static long ceph_fallocate(struct file *file, int mode,
 		spin_unlock(&ci->i_ceph_lock);
 		if (dirty)
 			__mark_inode_dirty(inode, dirty);
-		if ((endoff > size) &&
-		    ceph_quota_is_max_bytes_approaching(inode, endoff))
-			ceph_check_caps(ci, CHECK_CAPS_NODELAY, NULL);
 	}
 
 	ceph_put_cap_refs(ci, got);
