Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-379639-1519705900-2-15054661401695788909
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519705900; b=lY8w1y26bQ9h41qSccHlSOK+8F8hxV/G6Yi077U2RfDiDZu
    4m7dvV02WRvK6mBWdnADXnoYZ09IdQ6uJyqgrqdlZC32rpVJzIgnXdTAOoM7PaE+
    bjrYLrlf6j9zrWj1AANXkxuNkWXnkxgilloCP/goz0XB7IGyGfkXWSNzCxmNSejk
    qpi7SBCZSCEFReWzq6bsJXll5yiDnKL8t4iZeCZts+TzMtrdZxKDpuNG4QrETnhU
    N6y2hxJu2eKXcdYdTjPhubU1L0eE8nbtqvzn34AApe6WWvYqPu5rpdvN0Yt0yLQ1
    ha7gfUVSpUxywIk2APlSCMATRH68WDTv0OcCDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519705900; bh=NaYHvJQkMvktjGMuDAE/O/KmYXXTLR6a8Mn20fF/2O0=; b=e
    2TfwgQUC+FhwM8/I4ns9frMVHOwHz0KewPbjMaYLo3i2/JGocFYZB86Incj0azqc
    9EwATrJ0moqlFJVjuZQTheVSLE880DxfZvfcIgNsitk9tLZ7x1FPLdzD9PMK1I//
    0PTQ0DY4PJqhgwZHso1YMx1wA04dJ172DmLADupLRAVzZmJ5bEG8j6JFYAkXy9YZ
    Jg+AeLuCP3t1W1UnWPXt8uq0W2lMlc2yav7WgelHYUnD+Frs1525vU2Dj1NKbUix
    uWPWq+IGpSTQALFVq+ZPCyzu8/A1cta+8cNLmbSHoyWAL6XgeO7s47k5/TJWIOxp
    MhwGWEQWug+qo1ZTHsxZw==
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
        id S1752050AbeB0E3e (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 23:29:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:30038 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751663AbeB0E3d (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 23:29:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,398,1515484800";
   d="scan'208";a="21054301"
Subject: [PATCH v4 06/12] ext2, dax: replace IS_DAX() with IS_FSDAX()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, Jan Kara <jack@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Date: Mon, 26 Feb 2018 20:20:27 -0800
Message-ID: <151970522696.26729.5581903247926963915.stgit@dwillia2-desk3.amr.corp.intel.com>
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

In preparation for fixing the broken definition of S_DAX in the
CONFIG_FS_DAX=n + CONFIG_DEV_DAX=y case, convert all IS_DAX() usages to
use explicit tests for FSDAX since DAX is ambiguous.

Cc: Jan Kara <jack@suse.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: <stable@vger.kernel.org>
Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/ext2/file.c  |    6 +++---
 fs/ext2/inode.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 5ac98d074323..702a36df6c01 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -119,7 +119,7 @@ static const struct vm_operations_struct ext2_dax_vm_ops = {
 
 static int ext2_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	if (!IS_DAX(file_inode(file)))
+	if (!IS_FSDAX(file_inode(file)))
 		return generic_file_mmap(file, vma);
 
 	file_accessed(file);
@@ -158,14 +158,14 @@ int ext2_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 
 static ssize_t ext2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	if (IS_DAX(iocb->ki_filp->f_mapping->host))
+	if (IS_FSDAX(iocb->ki_filp->f_mapping->host))
 		return ext2_dax_read_iter(iocb, to);
 	return generic_file_read_iter(iocb, to);
 }
 
 static ssize_t ext2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	if (IS_DAX(iocb->ki_filp->f_mapping->host))
+	if (IS_FSDAX(iocb->ki_filp->f_mapping->host))
 		return ext2_dax_write_iter(iocb, from);
 	return generic_file_write_iter(iocb, from);
 }
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index e04295e99d90..72284f9fd034 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -733,7 +733,7 @@ static int ext2_get_blocks(struct inode *inode,
 		goto cleanup;
 	}
 
-	if (IS_DAX(inode)) {
+	if (IS_FSDAX(inode)) {
 		/*
 		 * We must unmap blocks before zeroing so that writeback cannot
 		 * overwrite zeros with stale data from block device page cache.
@@ -940,7 +940,7 @@ ext2_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	loff_t offset = iocb->ki_pos;
 	ssize_t ret;
 
-	if (WARN_ON_ONCE(IS_DAX(inode)))
+	if (WARN_ON_ONCE(IS_FSDAX(inode)))
 		return -EIO;
 
 	ret = blockdev_direct_IO(iocb, inode, iter, ext2_get_block);
@@ -1294,7 +1294,7 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
 
 	inode_dio_wait(inode);
 
-	if (IS_DAX(inode)) {
+	if (IS_FSDAX(inode)) {
 		error = iomap_zero_range(inode, newsize,
 					 PAGE_ALIGN(newsize) - newsize, NULL,
 					 &ext2_iomap_ops);
