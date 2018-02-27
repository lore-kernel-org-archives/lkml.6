Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-351074-1519705765-2-18419947111243226613
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES rosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519705764; b=ftgT5cco17ckVgrquThFo25RvMpwPJEzeJaDdfOeJ0MpZ3R
    v4JnwoCBQ79KbLM42oZjl/XrWe4lECUYQ93OG+oduRZ3GxQV5TosNArjrGkovvJf
    oGWyp0mB07UJLaI7HJ6f3G/k54xon4iw6zesgli489DFJV3QMLVA2vZlBlvUe5vu
    ysK5FKV7LD3jJL58HxTyadVYKHJNx+8ZBPg3GXPqDZJsQTzexd7o1fxpwtZgPjGh
    LbVlhvNK5I6oXebWLKnZy2nGabniXZYqWPG2hAtCeL/DVBEqRFYNaQ4ZD6fUJyrQ
    IUBLuKoQOIprUbloXeHiTFubNhrQi2BL5wBMJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519705764; bh=EIzh6StvfEvJamAU6xgF2eXQ8G0UBruTTY7j5lBOOac=; b=Y
    wa31+pNgJg73hRdhUzGmBwpeXa2FmKTAjsukC6/wux4dSdc9FizZYvksvaKpVc4r
    1BbHbXEtZgAUNkvb57sKASgkmHBI660zPIrSZCaVdjmLzzGtaCPt4QrlxLcXayCZ
    WBwP4y6M8nebI6nxFiofL6c+r8GA0aLeCeYu5f8LFc4UOkRXd3i9e/y38LPZX4so
    DfeyNPn0DjWFcpQ5wTdTBsM1b7upkpv/RaIsRR24/AyXyDajQSVVA6D0hHXlRBml
    N1oSOsR/5ZdC3hDhLSdD0JNHYAy/XqyUZgPiZ/RvgfH8DJ3yXq7GVyIOlQhSDiTZ
    ij9I1E5Oz4bdLIGOtIuTw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeB0E3U (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 23:29:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:33145 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751786AbeB0E3R (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 23:29:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,398,1515484800";
   d="scan'208";a="20606078"
Subject: [PATCH v4 03/12] ext2, dax: finish implementing dax_sem helpers
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jan Kara <jack@suse.com>
Date: Mon, 26 Feb 2018 20:20:11 -0800
Message-ID: <151970521121.26729.7741760690622342144.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

dax_sem_{up,down}_write_sem() allow the ext2 dax semaphore to be compiled
out in the CONFIG_FS_DAX=n case. However there are still some open coded
uses of the semaphore. Add dax_sem_{up_read,down_read,_is_locked}()
helpers and convert all open-coded usages of the semaphore to the
helpers.

Cc: Jan Kara <jack@suse.com>
Cc: <stable@vger.kernel.org>
Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/ext2/ext2.h  |    6 ++++++
 fs/ext2/file.c  |    5 ++---
 fs/ext2/inode.c |    4 +---
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 032295e1d386..7ceb29733cdb 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -711,9 +711,15 @@ struct ext2_inode_info {
 #ifdef CONFIG_FS_DAX
 #define dax_sem_down_write(ext2_inode)	down_write(&(ext2_inode)->dax_sem)
 #define dax_sem_up_write(ext2_inode)	up_write(&(ext2_inode)->dax_sem)
+#define dax_sem_is_locked(ext2_inode)	rwsem_is_locked(&(ext2_inode)->dax_sem)
+#define dax_sem_down_read(ext2_inode)	down_read(&(ext2_inode)->dax_sem)
+#define dax_sem_up_read(ext2_inode)	up_read(&(ext2_inode)->dax_sem)
 #else
 #define dax_sem_down_write(ext2_inode)
 #define dax_sem_up_write(ext2_inode)
+#define dax_sem_is_locked(ext2_inode)	(true)
+#define dax_sem_down_read(ext2_inode)
+#define dax_sem_up_read(ext2_inode)
 #endif
 
 /*
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 09640220fda8..1c7ea1bcddde 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -91,18 +91,17 @@ static ssize_t ext2_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static int ext2_dax_fault(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-	struct ext2_inode_info *ei = EXT2_I(inode);
 	int ret;
 
 	if (vmf->flags & FAULT_FLAG_WRITE) {
 		sb_start_pagefault(inode->i_sb);
 		file_update_time(vmf->vma->vm_file);
 	}
-	down_read(&ei->dax_sem);
+	dax_sem_down_read(EXT2_I(inode));
 
 	ret = dax_iomap_fault(vmf, PE_SIZE_PTE, NULL, NULL, &ext2_iomap_ops);
 
-	up_read(&ei->dax_sem);
+	dax_sem_up_read(EXT2_I(inode));
 	if (vmf->flags & FAULT_FLAG_WRITE)
 		sb_end_pagefault(inode->i_sb);
 	return ret;
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 9b2ac55ac34f..e04295e99d90 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1187,9 +1187,7 @@ static void __ext2_truncate_blocks(struct inode *inode, loff_t offset)
 	blocksize = inode->i_sb->s_blocksize;
 	iblock = (offset + blocksize-1) >> EXT2_BLOCK_SIZE_BITS(inode->i_sb);
 
-#ifdef CONFIG_FS_DAX
-	WARN_ON(!rwsem_is_locked(&ei->dax_sem));
-#endif
+	WARN_ON(!dax_sem_is_locked(ei));
 
 	n = ext2_block_to_path(inode, iblock, offsets, NULL);
 	if (n == 0)
