Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22526ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA22208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDFnvemQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA22208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732865AbeKIHr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:47:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730086AbeKIHr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:47:28 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 886E12089F;
        Thu,  8 Nov 2018 22:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714996;
        bh=wHR4VCGRAbVMM1qVfGXnflz7Z07Vo80LUb9zGtVIm1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YDFnvemQx4uWcZ3/qkQX0iknWW5VAlkKsb860Biy5+gnzT+MVkMgMTlWWk7Q5jHKi
         Uvr2JWRDDrtYgMuTdFDdFgNvFV3AE/ylw7iXidpEY7YkDFAPTLEAU9p3HnboxtGrna
         En5T/RcJhlD7N5ufVIz1VxBuY6KIZzaQhnMM9Idg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 02/34] vfs: swap names of {do,vfs}_clone_file_range()
Date:   Thu,  8 Nov 2018 13:52:31 -0800
Message-Id: <20181108215139.031054167@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

commit a725356b6659469d182d662f22d770d83d3bc7b5 upstream.

Commit 031a072a0b8a ("vfs: call vfs_clone_file_range() under freeze
protection") created a wrapper do_clone_file_range() around
vfs_clone_file_range() moving the freeze protection to former, so
overlayfs could call the latter.

The more common vfs practice is to call do_xxx helpers from vfs_xxx
helpers, where freeze protecction is taken in the vfs_xxx helper, so
this anomality could be a source of confusion.

It seems that commit 8ede205541ff ("ovl: add reflink/copyfile/dedup
support") may have fallen a victim to this confusion -
ovl_clone_file_range() calls the vfs_clone_file_range() helper in the
hope of getting freeze protection on upper fs, but in fact results in
overlayfs allowing to bypass upper fs freeze protection.

Swap the names of the two helpers to conform to common vfs practice
and call the correct helpers from overlayfs and nfsd.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: 031a072a0b8a ("vfs: call vfs_clone_file_range() under freeze...")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ioctl.c             |  2 +-
 fs/nfsd/vfs.c          |  3 ++-
 fs/overlayfs/copy_up.c |  2 +-
 fs/read_write.c        | 17 +++++++++++++++--
 include/linux/fs.h     | 17 +++--------------
 5 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index b445b13fc59b..5444fec607ce 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -229,7 +229,7 @@ static long ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
 	ret = -EXDEV;
 	if (src_file.file->f_path.mnt != dst_file->f_path.mnt)
 		goto fdput;
-	ret = do_clone_file_range(src_file.file, off, dst_file, destoff, olen);
+	ret = vfs_clone_file_range(src_file.file, off, dst_file, destoff, olen);
 fdput:
 	fdput(src_file);
 	return ret;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index b0555d7d8200..613d2fe2dddd 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -541,7 +541,8 @@ __be32 nfsd4_set_nfs4_label(struct svc_rqst *rqstp, struct svc_fh *fhp,
 __be32 nfsd4_clone_file_range(struct file *src, u64 src_pos, struct file *dst,
 		u64 dst_pos, u64 count)
 {
-	return nfserrno(do_clone_file_range(src, src_pos, dst, dst_pos, count));
+	return nfserrno(vfs_clone_file_range(src, src_pos, dst, dst_pos,
+					     count));
 }
 
 ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index ddaddb4ce4c3..26b477f2538d 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -156,7 +156,7 @@ static int ovl_copy_up_data(struct path *old, struct path *new, loff_t len)
 	}
 
 	/* Try to use clone_file_range to clone up within the same fs */
-	error = vfs_clone_file_range(old_file, 0, new_file, 0, len);
+	error = do_clone_file_range(old_file, 0, new_file, 0, len);
 	if (!error)
 		goto out;
 	/* Couldn't clone, so now we try to copy the data */
diff --git a/fs/read_write.c b/fs/read_write.c
index 153f8f690490..c9d489684335 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1818,8 +1818,8 @@ int vfs_clone_file_prep_inodes(struct inode *inode_in, loff_t pos_in,
 }
 EXPORT_SYMBOL(vfs_clone_file_prep_inodes);
 
-int vfs_clone_file_range(struct file *file_in, loff_t pos_in,
-		struct file *file_out, loff_t pos_out, u64 len)
+int do_clone_file_range(struct file *file_in, loff_t pos_in,
+			struct file *file_out, loff_t pos_out, u64 len)
 {
 	struct inode *inode_in = file_inode(file_in);
 	struct inode *inode_out = file_inode(file_out);
@@ -1866,6 +1866,19 @@ int vfs_clone_file_range(struct file *file_in, loff_t pos_in,
 
 	return ret;
 }
+EXPORT_SYMBOL(do_clone_file_range);
+
+int vfs_clone_file_range(struct file *file_in, loff_t pos_in,
+			 struct file *file_out, loff_t pos_out, u64 len)
+{
+	int ret;
+
+	file_start_write(file_out);
+	ret = do_clone_file_range(file_in, pos_in, file_out, pos_out, len);
+	file_end_write(file_out);
+
+	return ret;
+}
 EXPORT_SYMBOL(vfs_clone_file_range);
 
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a3afa50bb79f..e73363bd8646 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1813,8 +1813,10 @@ extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 extern int vfs_clone_file_prep_inodes(struct inode *inode_in, loff_t pos_in,
 				      struct inode *inode_out, loff_t pos_out,
 				      u64 *len, bool is_dedupe);
+extern int do_clone_file_range(struct file *file_in, loff_t pos_in,
+			       struct file *file_out, loff_t pos_out, u64 len);
 extern int vfs_clone_file_range(struct file *file_in, loff_t pos_in,
-		struct file *file_out, loff_t pos_out, u64 len);
+				struct file *file_out, loff_t pos_out, u64 len);
 extern int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 					 struct inode *dest, loff_t destoff,
 					 loff_t len, bool *is_same);
@@ -2755,19 +2757,6 @@ static inline void file_end_write(struct file *file)
 	__sb_end_write(file_inode(file)->i_sb, SB_FREEZE_WRITE);
 }
 
-static inline int do_clone_file_range(struct file *file_in, loff_t pos_in,
-				      struct file *file_out, loff_t pos_out,
-				      u64 len)
-{
-	int ret;
-
-	file_start_write(file_out);
-	ret = vfs_clone_file_range(file_in, pos_in, file_out, pos_out, len);
-	file_end_write(file_out);
-
-	return ret;
-}
-
 /*
  * get_write_access() gets write permission for a file.
  * put_write_access() releases this write permission.
-- 
2.17.1



