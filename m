Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AF2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF75120841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="HAF/B4e1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF75120841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390049AbeHARw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:52:58 -0400
Received: from imap.thunk.org ([74.207.234.97]:52880 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389698AbeHARw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=iA6bOVCSIdDgY63OXZCvN4RsdqI3f+R2AdrtmoASeHs=; b=HAF/B4e1yJPdnN/mudN1CVjeoB
        LMyYewHHMJPovcw56oURVKFf9GrexsXy+Fsa6prgUSJdULuAUQN4yEhQGqTUSTIEVMYlaVK/iEGtC
        TiRsdSC47CQka3GsVkPtoWbF+NuO7B8pqEtM8Cpj/tJYthkGavD76LGjVcpdPaUx1Nc0=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fktdj-0004I7-CC; Wed, 01 Aug 2018 16:06:19 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4DBC27A614D; Wed,  1 Aug 2018 12:06:18 -0400 (EDT)
Date:   Wed, 1 Aug 2018 12:06:18 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, adilger.kernel@dilger.ca,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Convert int to vm_fault_t type
Message-ID: <20180801160618.GE10761@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, adilger.kernel@dilger.ca,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180728085000.GA9136@jordon-HP-15-Notebook-PC>
 <20180801125512.GA10761@thunk.org>
 <CAFqt6zbxpj5DS=ONUGTJ9zaeH5k=qZpQYy-J+08tr9y0gOsCAg@mail.gmail.com>
 <20180801131330.GA4734@bombadil.infradead.org>
 <CAFqt6zYJv7SdkntY7KOBvNyfk-9MRaXBMmkbsc4J7P-tq616DA@mail.gmail.com>
 <20180801143830.GB10761@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801143830.GB10761@thunk.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 10:38:30AM -0400, Theodore Y. Ts'o wrote:
> I'm going to drop the whole ext4 changes for vm_fault_t for this
> cycle, and I'll let you try to fix it up properly for the next cycle.

Here's the fixed up commit that I'm going to drop since you plan to be
making changes in block_page_mkpage(), and I don't want us to get out
of sync.

						- Ted

commit 37ec0b791ff90c6fe480fdf74c7df934c1756819
Author: Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed Aug 1 11:54:31 2018 -0400

    ext4: use new return type vm_fault_t
    
    Use new return type vm_fault_t for fault handler
    ext4_filemap_fault.
    
    Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 6d7dec48372b..21fb1964a672 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2468,8 +2468,8 @@ extern int ext4_writepage_trans_blocks(struct inode *);
 extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
 extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
 			     loff_t lstart, loff_t lend);
-extern int ext4_page_mkwrite(struct vm_fault *vmf);
-extern int ext4_filemap_fault(struct vm_fault *vmf);
+extern vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf);
+extern vm_fault_t ext4_filemap_fault(struct vm_fault *vmf);
 extern qsize_t *ext4_get_reserved_space(struct inode *inode);
 extern int ext4_get_projid(struct inode *inode, kprojid_t *projid);
 extern void ext4_da_update_reserve_space(struct inode *inode,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ba0de19fb1ad..a6da9eda2194 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6107,27 +6107,27 @@ static int ext4_bh_unmapped(handle_t *handle, struct buffer_head *bh)
 	return !buffer_mapped(bh);
 }
 
-int ext4_page_mkwrite(struct vm_fault *vmf)
+vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page = vmf->page;
 	loff_t size;
 	unsigned long len;
-	int ret;
+	vm_fault_t ret;
 	struct file *file = vma->vm_file;
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
 	handle_t *handle;
 	get_block_t *get_block;
-	int retries = 0;
+	int retries = 0, err;
 
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vma->vm_file);
 
 	down_read(&EXT4_I(inode)->i_mmap_sem);
 
-	ret = ext4_convert_inline_data(inode);
-	if (ret)
+	err = ext4_convert_inline_data(inode);
+	if (err)
 		goto out_ret;
 
 	/* Delalloc case is easy... */
@@ -6135,9 +6135,9 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
 	    !ext4_should_journal_data(inode) &&
 	    !ext4_nonda_switch(inode->i_sb)) {
 		do {
-			ret = block_page_mkwrite(vma, vmf,
-						   ext4_da_get_block_prep);
-		} while (ret == -ENOSPC &&
+			err = block_page_mkwrite(vma, vmf,
+						 ext4_da_get_block_prep);
+		} while (err == -ENOSPC &&
 		       ext4_should_retry_alloc(inode->i_sb, &retries));
 		goto out_ret;
 	}
@@ -6182,8 +6182,8 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
 		ret = VM_FAULT_SIGBUS;
 		goto out;
 	}
-	ret = block_page_mkwrite(vma, vmf, get_block);
-	if (!ret && ext4_should_journal_data(inode)) {
+	err = block_page_mkwrite(vma, vmf, get_block);
+	if (!err && ext4_should_journal_data(inode)) {
 		if (ext4_walk_page_buffers(handle, page_buffers(page), 0,
 			  PAGE_SIZE, NULL, do_journal_get_write_access)) {
 			unlock_page(page);
@@ -6194,24 +6194,24 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
 		ext4_set_inode_state(inode, EXT4_STATE_JDATA);
 	}
 	ext4_journal_stop(handle);
-	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+	if (err == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry_alloc;
 out_ret:
-	ret = block_page_mkwrite_return(ret);
+	ret = block_page_mkwrite_return(err);
 out:
 	up_read(&EXT4_I(inode)->i_mmap_sem);
 	sb_end_pagefault(inode->i_sb);
 	return ret;
 }
 
-int ext4_filemap_fault(struct vm_fault *vmf)
+vm_fault_t ext4_filemap_fault(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-	int err;
+	vm_fault_t ret;
 
 	down_read(&EXT4_I(inode)->i_mmap_sem);
-	err = filemap_fault(vmf);
+	ret = filemap_fault(vmf);
 	up_read(&EXT4_I(inode)->i_mmap_sem);
 
-	return err;
+	return ret;
 }
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 96225a77c112..ed7a81b8f7cc 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include <linux/wait.h>
 #include <linux/atomic.h>
+#include <linux/mm_types.h>
 
 #ifdef CONFIG_BLOCK
 
@@ -242,7 +243,7 @@ int block_commit_write(struct page *page, unsigned from, unsigned to);
 int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 				get_block_t get_block);
 /* Convert errno to return value from ->page_mkwrite() call */
-static inline int block_page_mkwrite_return(int err)
+static inline vm_fault_t block_page_mkwrite_return(int err)
 {
 	if (err == 0)
 		return VM_FAULT_LOCKED;

