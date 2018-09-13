Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B94FC6174
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7F2214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7F2214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeIMVCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:02:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbeIMVCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:02:46 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECD4D30024D6;
        Thu, 13 Sep 2018 15:52:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF9E5308BE75;
        Thu, 13 Sep 2018 15:52:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/10] afs: Add O_DIRECT read support
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Sep 2018 16:52:39 +0100
Message-ID: <153685395914.14766.11965704729450128971.stgit@warthog.procyon.org.uk>
In-Reply-To: <153685389564.14766.11306559824641824935.stgit@warthog.procyon.org.uk>
References: <153685389564.14766.11306559824641824935.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 13 Sep 2018 15:52:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add synchronous O_DIRECT read support to AFS (no AIO yet).  It can
theoretically handle reads up to the maximum size describable by loff_t -
and given an iterator with sufficiently capacity to handle that and given
support on the server.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c     |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/internal.h |    1 +
 fs/afs/write.c    |    8 +++++++
 3 files changed, 70 insertions(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 36ba263db749..60f9896e1426 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -27,6 +27,7 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags);
 
 static int afs_readpages(struct file *filp, struct address_space *mapping,
 			 struct list_head *pages, unsigned nr_pages);
+static ssize_t afs_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 
 const struct file_operations afs_file_operations = {
 	.open		= afs_open,
@@ -55,6 +56,7 @@ const struct address_space_operations afs_fs_aops = {
 	.launder_page	= afs_launder_page,
 	.releasepage	= afs_releasepage,
 	.invalidatepage	= afs_invalidatepage,
+	.direct_IO	= afs_direct_IO,
 	.write_begin	= afs_write_begin,
 	.write_end	= afs_write_end,
 	.writepage	= afs_writepage,
@@ -731,3 +733,62 @@ static int afs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		vma->vm_ops = &afs_vm_ops;
 	return ret;
 }
+
+/*
+ * Direct file read operation for an AFS file.
+ */
+static ssize_t afs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct file *file = iocb->ki_filp;
+	struct address_space *mapping = file->f_mapping;
+	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
+	struct afs_read *req;
+	struct key *key = afs_file_key(file);
+	ssize_t ret;
+	size_t count = iov_iter_count(iter), transferred = 0;
+
+	if (!count)
+		return 0;
+	if (!is_sync_kiocb(iocb))
+		return -EOPNOTSUPP;
+
+	req = kzalloc(sizeof(struct afs_read), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	refcount_set(&req->usage, 1);
+	req->pos = iocb->ki_pos;
+	req->len = count;
+	req->iter = *iter;
+
+	task_io_account_read(count);
+
+
+	// TODO afs_start_io_direct(inode);
+	ret = afs_fetch_data(vnode, key, req);
+	if (ret == 0)
+		transferred = req->actual_len;
+	*iter = req->iter;
+	afs_put_read(req);
+
+	// TODO afs_end_io_direct(inode);
+
+	BUG_ON(ret == -EIOCBQUEUED); // TODO
+
+	if (ret == 0)
+		ret = transferred;
+
+	return ret;
+}
+
+/*
+ * Do direct I/O.
+ */
+static ssize_t afs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+{
+	VM_BUG_ON(iov_iter_count(iter) != PAGE_SIZE);
+
+	if (iov_iter_rw(iter) == READ)
+		return afs_file_direct_read(iocb, iter);
+	return afs_file_direct_write(iocb, iter);
+}
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 7c7598856b96..38b48382db52 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1111,6 +1111,7 @@ extern int afs_fsync(struct file *, loff_t, loff_t, int);
 extern vm_fault_t afs_page_mkwrite(struct vm_fault *vmf);
 extern void afs_prune_wb_keys(struct afs_vnode *);
 extern int afs_launder_page(struct page *);
+extern ssize_t afs_file_direct_write(struct kiocb *, struct iov_iter *);
 
 /*
  * xattr.c
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 9f035386b9c7..46a3a911c682 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -874,3 +874,11 @@ int afs_launder_page(struct page *page)
 #endif
 	return ret;
 }
+
+/*
+ * Direct file write operation for an AFS file.
+ */
+ssize_t afs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
+{
+	return -EOPNOTSUPP;
+}

