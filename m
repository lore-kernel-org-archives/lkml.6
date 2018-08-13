Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24899C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C078A2178C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlpc+odh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C078A2178C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbeHMW4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728540AbeHMW4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:56:37 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DEC12174B;
        Mon, 13 Aug 2018 20:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534191172;
        bh=yIAzzfjBY9PZlUrd04jSBokQJnj9FW2UlBdURTxmfhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nlpc+odhWb6gzg45h9Hzga1gaS4O2nmjBF1ozjQh6B4vB3a7oW69/7A9cZGoEWEYe
         RoSa95OEV983Cv5rs0pecSjHGSlwuJoIA9qsMh4YhdaioyIkaPZRbS+wGrUQGhmnUF
         4QLnXuKPvt9Smo3KI8CyGkpkloAKkshsv6Lg8YyY=
Date:   Mon, 13 Aug 2018 13:12:51 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid fi->i_gc_rwsem[WRITE] lock in
 f2fs_gc
Message-ID: <20180813201251.GB27044@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180730013242.15647-1-jaegeuk@kernel.org>
 <f62425be-b378-1e6b-e305-64a61b139dd9@huawei.com>
 <20180730041805.GA20178@jaegeuk-macbookpro.roam.corp.google.com>
 <aa12112e-0ff3-997a-24bd-12db30ad7284@huawei.com>
 <20180730090849.GA22089@jaegeuk-macbookpro.roam.corp.google.com>
 <171084b5-acd5-97fa-205e-202b752baaf0@huawei.com>
 <20180730100039.GA25037@jaegeuk-macbookpro.roam.corp.google.com>
 <5dfbb141-9bd9-f4fe-6250-5ec0baddd0fd@kernel.org>
 <d0cbc6bb-9e92-2803-b84d-729c78b21d5b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0cbc6bb-9e92-2803-b84d-729c78b21d5b@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12, Chao Yu wrote:
> On 2018/8/4 10:31, Chao Yu wrote:
> > How about keep lock order as:
> > 
> > - inode_lock
> >  - i_mmap_sem
> >   - lock_all()
> >   - unlock_all()
> >   - i_gc_rwsem[WRITE]
> >    - lock_op()
> 
> I got below warning when testing last dev-test:
> 
> - f2fs_direct_IO			current lock dependency
>  - i_gc_rwsem[WRITE]
> 					- i_mmap_sem
>   - do_blockdev_direct_IO
>    - i_mmap_sem
> 					 - i_gc_rwsem[WRITE]
> 

Yeah, it seems it's true.
How about this?

---
 fs/f2fs/data.c |  4 ++--
 fs/f2fs/file.c | 43 +++++++++++++++++++++++--------------------
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f09231b1cc74..021923dc666b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2208,14 +2208,14 @@ static void f2fs_write_failed(struct address_space *mapping, loff_t to)
 	loff_t i_size = i_size_read(inode);
 
 	if (to > i_size) {
-		down_write(&F2FS_I(inode)->i_mmap_sem);
 		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+		down_write(&F2FS_I(inode)->i_mmap_sem);
 
 		truncate_pagecache(inode, i_size);
 		f2fs_truncate_blocks(inode, i_size, true);
 
-		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		up_write(&F2FS_I(inode)->i_mmap_sem);
+		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	}
 }
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 560751adba01..8b13afb23734 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -798,8 +798,8 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	if (attr->ia_valid & ATTR_SIZE) {
 		bool to_smaller = (attr->ia_size <= i_size_read(inode));
 
-		down_write(&F2FS_I(inode)->i_mmap_sem);
 		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+		down_write(&F2FS_I(inode)->i_mmap_sem);
 
 		truncate_setsize(inode, attr->ia_size);
 
@@ -809,8 +809,8 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 		 * do not trim all blocks after i_size if target size is
 		 * larger than i_size.
 		 */
-		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		up_write(&F2FS_I(inode)->i_mmap_sem);
+		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 		if (err)
 			return err;
@@ -963,8 +963,8 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 			blk_start = (loff_t)pg_start << PAGE_SHIFT;
 			blk_end = (loff_t)pg_end << PAGE_SHIFT;
 
-			down_write(&F2FS_I(inode)->i_mmap_sem);
 			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+			down_write(&F2FS_I(inode)->i_mmap_sem);
 
 			truncate_inode_pages_range(mapping, blk_start,
 					blk_end - 1);
@@ -973,8 +973,8 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 			ret = f2fs_truncate_hole(inode, pg_start, pg_end);
 			f2fs_unlock_op(sbi);
 
-			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 			up_write(&F2FS_I(inode)->i_mmap_sem);
+			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		}
 	}
 
@@ -1201,6 +1201,7 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 
 	/* avoid gc operation during block exchange */
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	down_write(&F2FS_I(inode)->i_mmap_sem);
 
 	f2fs_lock_op(sbi);
 	f2fs_drop_extent_tree(inode);
@@ -1208,6 +1209,7 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 	ret = __exchange_data_block(inode, inode, end, start, nrpages - end, true);
 	f2fs_unlock_op(sbi);
 
+	up_write(&F2FS_I(inode)->i_mmap_sem);
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	return ret;
 }
@@ -1228,17 +1230,17 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
-	down_write(&F2FS_I(inode)->i_mmap_sem);
 	/* write out all dirty pages from offset */
 	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	ret = f2fs_do_collapse(inode, offset, len);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	/* write out all moved pages, if possible */
+	down_write(&F2FS_I(inode)->i_mmap_sem);
 	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
 	truncate_pagecache(inode, offset);
 
@@ -1246,10 +1248,9 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	truncate_pagecache(inode, new_size);
 
 	ret = f2fs_truncate_blocks(inode, new_size, true);
+	up_write(&F2FS_I(inode)->i_mmap_sem);
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
-out_unlock:
-	up_write(&F2FS_I(inode)->i_mmap_sem);
 	return ret;
 }
 
@@ -1315,10 +1316,9 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	if (ret)
 		return ret;
 
-	down_write(&F2FS_I(inode)->i_mmap_sem);
 	ret = filemap_write_and_wait_range(mapping, offset, offset + len - 1);
 	if (ret)
-		goto out_sem;
+		return ret;
 
 	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
@@ -1330,7 +1330,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 		ret = fill_zero(inode, pg_start, off_start,
 						off_end - off_start);
 		if (ret)
-			goto out_sem;
+			return ret;
 
 		new_size = max_t(loff_t, new_size, offset + len);
 	} else {
@@ -1338,7 +1338,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			ret = fill_zero(inode, pg_start++, off_start,
 						PAGE_SIZE - off_start);
 			if (ret)
-				goto out_sem;
+				return ret;
 
 			new_size = max_t(loff_t, new_size,
 					(loff_t)pg_start << PAGE_SHIFT);
@@ -1350,6 +1350,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			pgoff_t end;
 
 			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+			down_write(&F2FS_I(inode)->i_mmap_sem);
 
 			truncate_pagecache_range(inode,
 				(loff_t)index << PAGE_SHIFT,
@@ -1361,6 +1362,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			ret = f2fs_get_dnode_of_data(&dn, index, ALLOC_NODE);
 			if (ret) {
 				f2fs_unlock_op(sbi);
+				up_write(&F2FS_I(inode)->i_mmap_sem);
 				up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 				goto out;
 			}
@@ -1372,6 +1374,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			f2fs_put_dnode(&dn);
 
 			f2fs_unlock_op(sbi);
+			up_write(&F2FS_I(inode)->i_mmap_sem);
 			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 			f2fs_balance_fs(sbi, dn.node_changed);
@@ -1400,9 +1403,6 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 		else
 			f2fs_i_size_write(inode, new_size);
 	}
-out_sem:
-	up_write(&F2FS_I(inode)->i_mmap_sem);
-
 	return ret;
 }
 
@@ -1433,13 +1433,14 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
 	down_write(&F2FS_I(inode)->i_mmap_sem);
 	ret = f2fs_truncate_blocks(inode, i_size_read(inode), true);
+	up_write(&F2FS_I(inode)->i_mmap_sem);
 	if (ret)
-		goto out;
+		return ret;
 
 	/* write out all dirty pages from offset */
 	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
 	if (ret)
-		goto out;
+		return ret;
 
 	pg_start = offset >> PAGE_SHIFT;
 	pg_end = (offset + len) >> PAGE_SHIFT;
@@ -1448,6 +1449,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
 	/* avoid gc operation during block exchange */
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	down_write(&F2FS_I(inode)->i_mmap_sem);
 	truncate_pagecache(inode, offset);
 
 	while (!ret && idx > pg_start) {
@@ -1463,16 +1465,17 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 					idx + delta, nr, false);
 		f2fs_unlock_op(sbi);
 	}
+	up_write(&F2FS_I(inode)->i_mmap_sem);
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 	/* write out all moved pages, if possible */
+	down_write(&F2FS_I(inode)->i_mmap_sem);
 	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
 	truncate_pagecache(inode, offset);
+	up_write(&F2FS_I(inode)->i_mmap_sem);
 
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
-out:
-	up_write(&F2FS_I(inode)->i_mmap_sem);
 	return ret;
 }
 
-- 
2.17.0.441.gb46fe60e1d-goog

