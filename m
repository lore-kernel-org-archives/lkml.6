Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-494696-1519963512-2-11127142447504888257
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519963512; b=trN+rMh3wgLnb8KNFGq3ibUPjOVu4yAwhMknHidOUK1ahm3
    4WVHSUg4Yk4j9FtEit5WYQES5CEDKHivDRZqWjhqA9tc3s8ujUCAZAsQcG/HE8Cq
    9ei/AYqBdE0sgAlvls9ry2uiw2syCZdXVklJYlMVDfb7Djh7kPenLiAw7BbK/5dE
    1bdyq9YTOcc5eKOCLYy/TDBbw4AFTwr/81eyvpZUo+22nIksMI6uHFJ7/tC14vvO
    PJagZWD2Iv0l7vMmmMtL/0IOVrZ9PxGgP8NfXatxr5JMcksf67G9Nl+dX8LuVX5u
    jPNBVxWdfT2BCPB6PiVWuvSVu02EVLK+a10QixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519963512; bh=wKOsQN7Tny/lVMXe0jo6uyeKglm0sEA694t1DT3IMb8=; b=M
    Wgpjgl1cQkgofhJGnYEalb+Gj12aobr3YESrnPk+tOh+Tx22Zk9Qr07IM9uRfn1I
    i218R6HpufMR0T0aZsxRm21yx8rTbAitDdAeB8GutDoBRYzbjhczZsK6rIqDH0go
    z6jzF1yeTrA+xH8xCeLy1uAchaibHiB3KMgOy3n00DxMSFLb6Rp9Q5lwIlYbT7RC
    WSMSDTY0mOjon1RfaMUxyYI96hP0igZvjcKDyFQnRMaJKQllFFCpp8g6orCofMil
    rhWFL6jE6P2IyKKEQCmp8YhLnbK1MgJEp4qgfBlQwPEXqpvWoT0iJNBPS4J/Bd6G
    /ecO/zvhBYeT227BoIkZQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164841AbeCBEDU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 23:03:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:28338 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164734AbeCBEDS (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Mar 2018 23:03:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="208265819"
Subject: [PATCH v5 07/12] ext4, dax: replace IS_DAX() with IS_FSDAX()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-xfs@vger.kernel.org, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date: Thu, 01 Mar 2018 19:54:11 -0800
Message-ID: <151996285107.28483.10237358640480864296.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation for fixing the broken definition of S_DAX in the
CONFIG_FS_DAX=n + CONFIG_DEV_DAX=y case, convert all IS_DAX() usages to
use explicit tests for FSDAX since DAX is ambiguous.

Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: <stable@vger.kernel.org>
Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/ext4/file.c  |   12 +++++-------
 fs/ext4/inode.c |    4 ++--
 fs/ext4/ioctl.c |    2 +-
 fs/ext4/super.c |    2 +-
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 51854e7608f0..561ea843b458 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -48,7 +48,7 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	 * Recheck under inode lock - at this point we are sure it cannot
 	 * change anymore
 	 */
-	if (!IS_DAX(inode)) {
+	if (!IS_FSDAX(inode)) {
 		inode_unlock_shared(inode);
 		/* Fallback to buffered IO in case we cannot support DAX */
 		return generic_file_read_iter(iocb, to);
@@ -68,7 +68,7 @@ static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (!iov_iter_count(to))
 		return 0; /* skip atime */
 
-	if (IS_DAX(file_inode(iocb->ki_filp)))
+	if (IS_FSDAX(file_inode(iocb->ki_filp)))
 		return ext4_dax_read_iter(iocb, to);
 	return generic_file_read_iter(iocb, to);
 }
@@ -216,10 +216,8 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
-#ifdef CONFIG_FS_DAX
-	if (IS_DAX(inode))
+	if (IS_FSDAX(inode))
 		return ext4_dax_write_iter(iocb, from);
-#endif
 	if (!o_direct && (iocb->ki_flags & IOCB_NOWAIT))
 		return -EOPNOTSUPP;
 
@@ -361,11 +359,11 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
 	 * We don't support synchronous mappings for non-DAX files. At least
 	 * until someone comes with a sensible use case.
 	 */
-	if (!IS_DAX(file_inode(file)) && (vma->vm_flags & VM_SYNC))
+	if (!IS_FSDAX(file_inode(file)) && (vma->vm_flags & VM_SYNC))
 		return -EOPNOTSUPP;
 
 	file_accessed(file);
-	if (IS_DAX(file_inode(file))) {
+	if (IS_FSDAX(file_inode(file))) {
 		vma->vm_ops = &ext4_dax_vm_ops;
 		vma->vm_flags |= VM_MIXEDMAP | VM_HUGEPAGE;
 	} else {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c94780075b04..1879b33aa391 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3858,7 +3858,7 @@ static ssize_t ext4_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		return 0;
 
 	/* DAX uses iomap path now */
-	if (WARN_ON_ONCE(IS_DAX(inode)))
+	if (WARN_ON_ONCE(IS_FSDAX(inode)))
 		return 0;
 
 	trace_ext4_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
@@ -4076,7 +4076,7 @@ static int ext4_block_zero_page_range(handle_t *handle,
 	if (length > max || length < 0)
 		length = max;
 
-	if (IS_DAX(inode)) {
+	if (IS_FSDAX(inode)) {
 		return iomap_zero_range(inode, from, length, NULL,
 					&ext4_iomap_ops);
 	}
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7e99ad02f1ba..040fc6570ddb 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -790,7 +790,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 				 "Online defrag not supported with bigalloc");
 			err = -EOPNOTSUPP;
 			goto mext_out;
-		} else if (IS_DAX(inode)) {
+		} else if (IS_FSDAX(inode)) {
 			ext4_msg(sb, KERN_ERR,
 				 "Online defrag not supported with DAX");
 			err = -EOPNOTSUPP;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 39bf464c35f1..933e12940181 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1161,7 +1161,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 	if (inode->i_ino == EXT4_ROOT_INO)
 		return -EPERM;
 
-	if (WARN_ON_ONCE(IS_DAX(inode) && i_size_read(inode)))
+	if (WARN_ON_ONCE(IS_FSDAX(inode) && i_size_read(inode)))
 		return -EINVAL;
 
 	res = ext4_convert_inline_data(inode);
