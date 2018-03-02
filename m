Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-441027-1519963499-2-17772319386195351383
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519963498; b=ur/dSsUAQ0fAlc2aJ9+ELYJYcw7WSTNmbWlmWomDHp85Oqs
    dhF6E4votEe8llZ5jsXTWW3o3AemvwairXyCnL/sq3vwSTysUawZdAzxqKsJU4T0
    ZEFLQXOR7phtB/DZuODqHHvNlKRyA0Em6VfOZJKEyTdSLCOpLNfYfyw5GP0gP7RG
    XGMQ+l4Qmiy4Ln5rl6Bs+5ySs08GYUnq7hKXdzNMjPKZEGmiONqt1W9YkdH/sDfP
    +DRP594+mMQGHXZPkYPYuR+Ex6Dvkj8VNshbLfsvGYTxtjsqDY08lSB6BKiKHjNd
    zfY8A8vLT3l9bh84nxjAcr9nXKUSAXU47oPYhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519963498; bh=G0zukMsoR1s8ueyW2JTSCJK1fOmV/HKxp/3Ex38whRE=; b=s
    oi9Yq+layR6MTTZBugfXw4Oh3Xya2XH3o3FJAIz5Vbci4ynGBAK1LrP4fjLzZ+7T
    Pi4MoGMt87hjLIuis7H72HDGzrlpQvVDo9Gqv0G14TXAkmAXEwXXvLf5qWQXUqTY
    EMr12qv2EaETlJokyA3NyDSeb9eC5DcWeBDmL1tjwctZGlPgC/fqxiAxoXdcKbV0
    c3C4c0yBstmpsSwA9xowHnereiPPWRMOGiHzwyJKUrPctcO1WV4auPAyC/DVHoP4
    uwHmJfkzhfFao9OFbRnkL/T1HjF/VsvVtyJGqgxhk66O8/9jqMMePWs06GE1qNdR
    t0mK1PEIIuLI6ZTabhQrg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164859AbeCBED2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 23:03:28 -0500
Received: from mga07.intel.com ([134.134.136.100]:9465 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164734AbeCBEDX (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Mar 2018 23:03:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="21317069"
Subject: [PATCH v5 08/12] xfs, dax: replace IS_DAX() with IS_FSDAX()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date: Thu, 01 Mar 2018 19:54:16 -0800
Message-ID: <151996285683.28483.13394624369523668388.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: linux-xfs@vger.kernel.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: <stable@vger.kernel.org>
Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/xfs/xfs_file.c    |   14 +++++++-------
 fs/xfs/xfs_ioctl.c   |    4 ++--
 fs/xfs/xfs_iomap.c   |    6 +++---
 fs/xfs/xfs_reflink.c |    2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 9ea08326f876..46a098b90fd0 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -288,7 +288,7 @@ xfs_file_read_iter(
 	if (XFS_FORCED_SHUTDOWN(mp))
 		return -EIO;
 
-	if (IS_DAX(inode))
+	if (IS_FSDAX(inode))
 		ret = xfs_file_dax_read(iocb, to);
 	else if (iocb->ki_flags & IOCB_DIRECT)
 		ret = xfs_file_dio_aio_read(iocb, to);
@@ -726,7 +726,7 @@ xfs_file_write_iter(
 	if (XFS_FORCED_SHUTDOWN(ip->i_mount))
 		return -EIO;
 
-	if (IS_DAX(inode))
+	if (IS_FSDAX(inode))
 		ret = xfs_file_dax_write(iocb, from);
 	else if (iocb->ki_flags & IOCB_DIRECT) {
 		/*
@@ -1045,7 +1045,7 @@ __xfs_filemap_fault(
 	}
 
 	xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
-	if (IS_DAX(inode)) {
+	if (IS_FSDAX(inode)) {
 		pfn_t pfn;
 
 		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &xfs_iomap_ops);
@@ -1070,7 +1070,7 @@ xfs_filemap_fault(
 {
 	/* DAX can shortcut the normal fault path on write faults! */
 	return __xfs_filemap_fault(vmf, PE_SIZE_PTE,
-			IS_DAX(file_inode(vmf->vma->vm_file)) &&
+			IS_FSDAX(file_inode(vmf->vma->vm_file)) &&
 			(vmf->flags & FAULT_FLAG_WRITE));
 }
 
@@ -1079,7 +1079,7 @@ xfs_filemap_huge_fault(
 	struct vm_fault		*vmf,
 	enum page_entry_size	pe_size)
 {
-	if (!IS_DAX(file_inode(vmf->vma->vm_file)))
+	if (!IS_FSDAX(file_inode(vmf->vma->vm_file)))
 		return VM_FAULT_FALLBACK;
 
 	/* DAX can shortcut the normal fault path on write faults! */
@@ -1124,12 +1124,12 @@ xfs_file_mmap(
 	 * We don't support synchronous mappings for non-DAX files. At least
 	 * until someone comes with a sensible use case.
 	 */
-	if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
+	if (!IS_FSDAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
 		return -EOPNOTSUPP;
 
 	file_accessed(filp);
 	vma->vm_ops = &xfs_file_vm_ops;
-	if (IS_DAX(file_inode(filp)))
+	if (IS_FSDAX(file_inode(filp)))
 		vma->vm_flags |= VM_MIXEDMAP | VM_HUGEPAGE;
 	return 0;
 }
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 89fb1eb80aae..234279ff66ce 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1108,9 +1108,9 @@ xfs_ioctl_setattr_dax_invalidate(
 	}
 
 	/* If the DAX state is not changing, we have nothing to do here. */
-	if ((fa->fsx_xflags & FS_XFLAG_DAX) && IS_DAX(inode))
+	if ((fa->fsx_xflags & FS_XFLAG_DAX) && IS_FSDAX(inode))
 		return 0;
-	if (!(fa->fsx_xflags & FS_XFLAG_DAX) && !IS_DAX(inode))
+	if (!(fa->fsx_xflags & FS_XFLAG_DAX) && !IS_FSDAX(inode))
 		return 0;
 
 	/* lock, flush and invalidate mapping in preparation for flag change */
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 66e1edbfb2b2..cf794d429aec 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -241,7 +241,7 @@ xfs_iomap_write_direct(
 	 * the reserve block pool for bmbt block allocation if there is no space
 	 * left but we need to do unwritten extent conversion.
 	 */
-	if (IS_DAX(VFS_I(ip))) {
+	if (IS_FSDAX(VFS_I(ip))) {
 		bmapi_flags = XFS_BMAPI_CONVERT | XFS_BMAPI_ZERO;
 		if (imap->br_state == XFS_EXT_UNWRITTEN) {
 			tflags |= XFS_TRANS_RESERVE;
@@ -952,7 +952,7 @@ static inline bool imap_needs_alloc(struct inode *inode,
 	return !nimaps ||
 		imap->br_startblock == HOLESTARTBLOCK ||
 		imap->br_startblock == DELAYSTARTBLOCK ||
-		(IS_DAX(inode) && imap->br_state == XFS_EXT_UNWRITTEN);
+		(IS_FSDAX(inode) && imap->br_state == XFS_EXT_UNWRITTEN);
 }
 
 static inline bool need_excl_ilock(struct xfs_inode *ip, unsigned flags)
@@ -988,7 +988,7 @@ xfs_file_iomap_begin(
 		return -EIO;
 
 	if (((flags & (IOMAP_WRITE | IOMAP_DIRECT)) == IOMAP_WRITE) &&
-			!IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
+			!IS_FSDAX(inode) && !xfs_get_extsz_hint(ip)) {
 		/* Reserve delalloc blocks for regular writeback. */
 		return xfs_file_iomap_begin_delay(inode, offset, length, iomap);
 	}
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 270246943a06..a126e00e05e3 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1351,7 +1351,7 @@ xfs_reflink_remap_range(
 		goto out_unlock;
 
 	/* Don't share DAX file data for now. */
-	if (IS_DAX(inode_in) || IS_DAX(inode_out))
+	if (IS_FSDAX(inode_in) || IS_FSDAX(inode_out))
 		goto out_unlock;
 
 	ret = vfs_clone_file_prep_inodes(inode_in, pos_in, inode_out, pos_out,
