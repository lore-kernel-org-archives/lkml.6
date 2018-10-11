Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA667C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797572087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ek7tWl87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797572087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeJKWpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:45:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34372 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726235AbeJKWpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:45:13 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w9BFEj8W007418
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 08:17:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=cZHL6nJcHJum6iBbEGgEVuvikLdK/OKVUPg///O9aiE=;
 b=ek7tWl87OfAruQ23SYoXvGpLJUCSRsaaRymWyG5Cb/zCmjPmhxMZS1A0YdNhzpxAokhz
 /VDUOigDhRs5ngFOGUuAlmDBtSMchgNS7MfVtO6fBWUQJZ+BKWQ8axP1IRIt24ZW9qzR
 ZImzBTqE6VmtNPkyqTD3E4DNvgSuf75pVyw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2n25twgpe1-7
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 08:17:35 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.20) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 11 Oct
 2018 08:17:17 -0700
Received: by devvm1658.frc1.facebook.com (Postfix, from userid 119756)  id
 1DFF71A301CF; Thu, 11 Oct 2018 08:17:07 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Dan Schatzberg <dschatzberg@fb.com>
Smtp-Origin-Hostname: devvm1658.frc1.facebook.com
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     <tj@kernel.org>, <kernel-team@fb.com>,
        Dan Schatzberg <dschatzberg@fb.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Smtp-Origin-Cluster: frc1c23
Subject: [PATCH v2] fuse: enable caching of symlinks
Date:   Thu, 11 Oct 2018 08:17:00 -0700
Message-ID: <20181011151700.80485-1-dschatzberg@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FUSE file reads are cached in the page cache, but symlink reads are
not. This patch enables FUSE READLINK operations to be cached which
can improve performance of some FUSE workloads.

In particular, I'm working on a FUSE filesystem for access to source
code and discovered that about a 10% improvement to build times is
achieved with this patch (there are a lot of symlinks in the source
tree).
---
Changes in v2:
  - Gated behind INIT flag for backwards compatibility

 fs/fuse/dir.c             | 67 +++++++++++++++++++++++++++++++++++++--
 fs/fuse/fuse_i.h          |  3 ++
 fs/fuse/inode.c           |  4 ++-
 include/uapi/linux/fuse.h |  7 +++-
 4 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 0979609d6eba..ce23fb6ac5f4 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1398,11 +1398,53 @@ static int fuse_readdir(struct file *file, struct dir_context *ctx)
 	return err;
 }
 
-static const char *fuse_get_link(struct dentry *dentry,
-				 struct inode *inode,
-				 struct delayed_call *done)
+static int fuse_symlink_readpage(struct file *file, struct page *page)
 {
+	struct inode *inode = page->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_req *req;
+	int err;
+	size_t num_read;
+
+	err = -EIO;
+	if (is_bad_inode(inode))
+		goto out;
+
+	req = fuse_get_req(fc, 1);
+	if (IS_ERR(req)) {
+		err = PTR_ERR(req);
+		goto out;
+	}
+
+	req->out.page_zeroing = 1;
+	req->out.argpages = 1;
+	req->num_pages = 1;
+	req->pages[0] = page;
+	req->page_descs[0].length = PAGE_SIZE - 1;
+	req->in.h.opcode = FUSE_READLINK;
+	req->in.h.nodeid = get_node_id(inode);
+	req->out.argvar = 1;
+	req->out.numargs = 1;
+	req->out.args[0].size = PAGE_SIZE - 1;
+	fuse_request_send(fc, req);
+	num_read = req->out.args[0].size;
+	err = req->out.h.error;
+
+	if (!err)
+		SetPageUptodate(page);
+
+	fuse_put_request(fc, req);
+	fuse_invalidate_atime(inode);
+out:
+	unlock_page(page);
+	return err;
+}
+
+static const char *fuse_get_link_nocache(struct dentry *dentry,
+					 struct inode *inode,
+					 struct delayed_call *done,
+					 struct fuse_conn *fc)
+{
 	FUSE_ARGS(args);
 	char *link;
 	ssize_t ret;
@@ -1432,6 +1474,17 @@ static const char *fuse_get_link(struct dentry *dentry,
 	return link;
 }
 
+static const char *fuse_get_link(struct dentry *dentry,
+				 struct inode *inode,
+				 struct delayed_call *done)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	if (fc->cache_symlinks)
+		return page_get_link(dentry, inode, done);
+	else
+		return fuse_get_link_nocache(dentry, inode, done, fc);
+}
+
 static int fuse_dir_open(struct inode *inode, struct file *file)
 {
 	return fuse_open_common(inode, file, true);
@@ -1871,7 +1924,15 @@ void fuse_init_dir(struct inode *inode)
 	inode->i_fop = &fuse_dir_operations;
 }
 
+static const struct address_space_operations fuse_symlink_aops = {
+	.readpage       = fuse_symlink_readpage,
+};
+
 void fuse_init_symlink(struct inode *inode)
 {
 	inode->i_op = &fuse_symlink_inode_operations;
+	inode->i_data.a_ops = &fuse_symlink_aops;
+	mapping_set_gfp_mask(inode->i_mapping,
+			mapping_gfp_constraint(inode->i_mapping,
+					~(__GFP_FS | __GFP_HIGHMEM)));
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f78e9614bb5f..50f1d1e96011 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -551,6 +551,9 @@ struct fuse_conn {
 	/** handle fs handles killing suid/sgid/cap on write/chown/trunc */
 	unsigned handle_killpriv:1;
 
+	/** cache READLINK responses in page cache */
+	unsigned cache_symlinks:1;
+
 	/*
 	 * The following bitfields are only for optimization purposes
 	 * and hence races in setting them will not cause malfunction
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index db9e60b7eb69..0d8c2ee01308 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -926,6 +926,8 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_req *req)
 			}
 			if (arg->flags & FUSE_ABORT_ERROR)
 				fc->abort_err = 1;
+			if (arg->flags & FUSE_CACHE_SYMLINKS)
+				fc->cache_symlinks = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -957,7 +959,7 @@ static void fuse_send_init(struct fuse_conn *fc, struct fuse_req *req)
 		FUSE_DO_READDIRPLUS | FUSE_READDIRPLUS_AUTO | FUSE_ASYNC_DIO |
 		FUSE_WRITEBACK_CACHE | FUSE_NO_OPEN_SUPPORT |
 		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
-		FUSE_ABORT_ERROR;
+		FUSE_ABORT_ERROR | FUSE_CACHE_SYMLINKS;
 	req->in.h.opcode = FUSE_INIT;
 	req->in.numargs = 1;
 	req->in.args[0].size = sizeof(*arg);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 92fa24c24c92..348a38019646 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -116,6 +116,9 @@
  *
  *  7.27
  *  - add FUSE_ABORT_ERROR
+ *
+ *  7.28
+ *  - add FUSE_CACHE_SYMLINKS
  */
 
 #ifndef _LINUX_FUSE_H
@@ -151,7 +154,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 27
+#define FUSE_KERNEL_MINOR_VERSION 28
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -249,6 +252,7 @@ struct fuse_file_lock {
  * FUSE_HANDLE_KILLPRIV: fs handles killing suid/sgid/cap on write/chown/trunc
  * FUSE_POSIX_ACL: filesystem supports posix acls
  * FUSE_ABORT_ERROR: reading the device after abort returns ECONNABORTED
+ * FUSE_CACHE_SYMLINKS: READLINK responses are cached in the page cache
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -272,6 +276,7 @@ struct fuse_file_lock {
 #define FUSE_HANDLE_KILLPRIV	(1 << 19)
 #define FUSE_POSIX_ACL		(1 << 20)
 #define FUSE_ABORT_ERROR	(1 << 21)
+#define FUSE_CACHE_SYMLINKS     (1 << 22)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.17.1

