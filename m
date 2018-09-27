Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03396C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3459216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mrRBUhg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3459216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbeI0ULE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:11:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59760 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727270AbeI0ULD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:11:03 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w8RDiA5l018927
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 06:52:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Yvo0Hdwf7rOZj7He1kTlcXIGqnc0dhTbCmnkInG2boY=;
 b=mrRBUhg2RSA7a7XcIrz/L2TEPtBkhhCBC6wbYjZDHzBA3uVRSxsf/KATg84TWweTZQzP
 eX1eKnacdxmx+nAr02ddkWYfEjHycrMsWjnDR9NUOzWORIxAnoWIAb+SoaNGeAXPuWfZ
 MmJv8lW15fC4zs5d0HcglYy9JLxKgY4+2qg= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2mry1qr9fq-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 06:52:40 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.13) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 27 Sep
 2018 06:52:38 -0700
Received: by devvm1658.frc1.facebook.com (Postfix, from userid 119756)  id
 5F46B10F94A0; Thu, 27 Sep 2018 06:52:30 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Dan Schatzberg <dschatzberg@fb.com>
Smtp-Origin-Hostname: devvm1658.frc1.facebook.com
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     <tj@kernel.org>, <kernel-team@fb.com>,
        Dan Schatzberg <dschatzberg@fb.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Smtp-Origin-Cluster: frc1c23
Subject: [PATCH] fuse: enable caching of symlinks
Date:   Thu, 27 Sep 2018 06:52:10 -0700
Message-ID: <20180927135211.31641-1-dschatzberg@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-27_07:,,
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

Please provide feedback, I'm looking to flesh this out more.

Signed-off-by: Dan Schatzberg <dschatzberg@fb.com>
---
 fs/fuse/dir.c | 70 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 0979609d6eba..3c0a81ef5bca 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1398,38 +1398,46 @@ static int fuse_readdir(struct file *file, struct dir_context *ctx)
 	return err;
 }
 
-static const char *fuse_get_link(struct dentry *dentry,
-				 struct inode *inode,
-				 struct delayed_call *done)
+static int fuse_symlink_readpage(struct file *file, struct page *page)
 {
+	struct inode *inode = page->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	FUSE_ARGS(args);
-	char *link;
-	ssize_t ret;
-
-	if (!dentry)
-		return ERR_PTR(-ECHILD);
+	struct fuse_req *req;
+	int err;
+	size_t num_read;
 
-	link = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!link)
-		return ERR_PTR(-ENOMEM);
+	err = -EIO;
+	if (is_bad_inode(inode))
+		goto out;
 
-	args.in.h.opcode = FUSE_READLINK;
-	args.in.h.nodeid = get_node_id(inode);
-	args.out.argvar = 1;
-	args.out.numargs = 1;
-	args.out.args[0].size = PAGE_SIZE - 1;
-	args.out.args[0].value = link;
-	ret = fuse_simple_request(fc, &args);
-	if (ret < 0) {
-		kfree(link);
-		link = ERR_PTR(ret);
-	} else {
-		link[ret] = '\0';
-		set_delayed_call(done, kfree_link, link);
+	req = fuse_get_req(fc, 1);
+	if (IS_ERR(req)) {
+		err = PTR_ERR(req);
+		goto out;
 	}
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
 	fuse_invalidate_atime(inode);
-	return link;
+out:
+	unlock_page(page);
+	return err;
 }
 
 static int fuse_dir_open(struct inode *inode, struct file *file)
@@ -1855,7 +1863,7 @@ static const struct inode_operations fuse_common_inode_operations = {
 
 static const struct inode_operations fuse_symlink_inode_operations = {
 	.setattr	= fuse_setattr,
-	.get_link	= fuse_get_link,
+	.get_link	= page_get_link,
 	.getattr	= fuse_getattr,
 	.listxattr	= fuse_listxattr,
 };
@@ -1871,7 +1879,15 @@ void fuse_init_dir(struct inode *inode)
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
-- 
2.17.1

