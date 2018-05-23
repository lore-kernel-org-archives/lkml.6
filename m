Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933551AbeEWPas (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:30:48 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42223 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932667AbeEWPap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:30:45 -0400
X-Google-Smtp-Source: AB8JxZrYioCn73SbEGKTwlwr8ThI4cqjugQdX4a7m7r1hsF+FcFJi1ok/dK6A6RxcjNigOZRnRPgmA==
Date: Wed, 23 May 2018 21:02:58 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: mfasheh@versity.com, jlbec@evilplan.org, willy@infradead.org
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs: ocfs2: Adding new return type vm_fault_t
Message-ID: <20180523153258.GA28451@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")

vmf_error() is the newly introduce inline function
in 4.18.

Fix one checkpatch.pl warning by replacing BUG_ON()
with WARN_ON()

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/ocfs2/mmap.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
index fb9a20e..036177e 100644
--- a/fs/ocfs2/mmap.c
+++ b/fs/ocfs2/mmap.c
@@ -44,11 +44,11 @@
 #include "ocfs2_trace.h"
 
 
-static int ocfs2_fault(struct vm_fault *vmf)
+static vm_fault_t ocfs2_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	sigset_t oldset;
-	int ret;
+	vm_fault_t ret;
 
 	ocfs2_block_signals(&oldset);
 	ret = filemap_fault(vmf);
@@ -59,10 +59,11 @@ static int ocfs2_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-static int __ocfs2_page_mkwrite(struct file *file, struct buffer_head *di_bh,
-				struct page *page)
+static vm_fault_t __ocfs2_page_mkwrite(struct file *file,
+			struct buffer_head *di_bh, struct page *page)
 {
-	int ret = VM_FAULT_NOPAGE;
+	int err;
+	vm_fault_t ret = VM_FAULT_NOPAGE;
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
 	loff_t pos = page_offset(page);
@@ -105,15 +106,12 @@ static int __ocfs2_page_mkwrite(struct file *file, struct buffer_head *di_bh,
 	if (page->index == last_index)
 		len = ((size - 1) & ~PAGE_MASK) + 1;
 
-	ret = ocfs2_write_begin_nolock(mapping, pos, len, OCFS2_WRITE_MMAP,
+	err = ocfs2_write_begin_nolock(mapping, pos, len, OCFS2_WRITE_MMAP,
 				       &locked_page, &fsdata, di_bh, page);
-	if (ret) {
-		if (ret != -ENOSPC)
-			mlog_errno(ret);
-		if (ret == -ENOMEM)
-			ret = VM_FAULT_OOM;
-		else
-			ret = VM_FAULT_SIGBUS;
+	if (err) {
+		if (err != -ENOSPC)
+			mlog_errno(err);
+		ret = vmf_error(err);
 		goto out;
 	}
 
@@ -121,20 +119,21 @@ static int __ocfs2_page_mkwrite(struct file *file, struct buffer_head *di_bh,
 		ret = VM_FAULT_NOPAGE;
 		goto out;
 	}
-	ret = ocfs2_write_end_nolock(mapping, pos, len, len, fsdata);
-	BUG_ON(ret != len);
+	err = ocfs2_write_end_nolock(mapping, pos, len, len, fsdata);
+	WARN_ON(err != len);
 	ret = VM_FAULT_LOCKED;
 out:
 	return ret;
 }
 
-static int ocfs2_page_mkwrite(struct vm_fault *vmf)
+static vm_fault_t ocfs2_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct buffer_head *di_bh = NULL;
 	sigset_t oldset;
-	int ret;
+	int err;
+	vm_fault_t ret;
 
 	sb_start_pagefault(inode->i_sb);
 	ocfs2_block_signals(&oldset);
@@ -144,13 +143,10 @@ static int ocfs2_page_mkwrite(struct vm_fault *vmf)
 	 * node. Taking the data lock will also ensure that we don't
 	 * attempt page truncation as part of a downconvert.
 	 */
-	ret = ocfs2_inode_lock(inode, &di_bh, 1);
-	if (ret < 0) {
-		mlog_errno(ret);
-		if (ret == -ENOMEM)
-			ret = VM_FAULT_OOM;
-		else
-			ret = VM_FAULT_SIGBUS;
+	err = ocfs2_inode_lock(inode, &di_bh, 1);
+	if (err < 0) {
+		mlog_errno(err);
+		ret = vmf_error(err);
 		goto out;
 	}
 
-- 
1.9.1
