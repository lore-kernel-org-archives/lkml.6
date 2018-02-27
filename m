Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-379639-1519705799-2-17220884320856450131
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
    t=1519705799; b=BACklPe96wWONGMRahyQlLRV8r6twfc0Et38qHKi2KOZHZB
    me3/EMyTbGaDETk93YRXJxbOcdiLi5NH34s1AYFdQ53N5S1WZMMJzmo1Hyz2gPVx
    DsOOIQPus7EM1KTK4qAcLe4gZfycSigVRVGrNmrt7POQKEzICKWCMDeWpBho+Eht
    RZvDiQN3ks/IeAwHzvJmZ3RxIK89hQzdE6Xnl94GuwFS1iexgmkxXYa9/tWpfmUa
    k35xyiAR7IdBrrQgx6tG1tU50tA4p9TTJqE7YRQzQattJhHCI1Twz1ffrNK7KLFc
    zoa89HPODL38GDNMnsG76q3ZgM9ADOCbu9JGTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519705799; bh=8V9UXi4sMIVpeakxkj+/afzE8HaGxi7cM6TiYO75TvQ=; b=E
    zYvW148qCPnt+S8NtlMoWUFJEBq+4n0bUJnJ5T6AV1RufL9F8pbZJ1vOiOEfP90S
    h9ctqeWNB+91wmeidSna7iApZSYjZM6jSx8vmTSfy+/kjUrekygTlWMm6TXH2Bkb
    Iz6swu2OsjhyYIUzM9/d8pWByOUpEosqw6TIHZAELTbfntM/DjhVgxuqhbULE9++
    IQOuZLmXIzmr0abzrFzwDwBg/M2mD6KA+WzZQmmQZdyYphi5zdCbsxWo8v0AHp69
    Cjps705Kb8N0jTlu5sT6M8Fywu9yyByVJc0YMygY3FmsUfD3/LFXc6ELRUW9wHAK
    FIcdjI0zkLn/8T3ylaxfw==
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
        id S1752124AbeB0E3x (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 23:29:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:32579 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751663AbeB0E3t (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 23:29:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,398,1515484800";
   d="scan'208";a="23442608"
Subject: [PATCH v4 09/12] mm,
 dax: replace IS_DAX() with IS_DEVDAX() or IS_FSDAX()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, Jan Kara <jack@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Date: Mon, 26 Feb 2018 20:20:42 -0800
Message-ID: <151970524289.26729.18096955322602992171.stgit@dwillia2-desk3.amr.corp.intel.com>
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
use explicit tests for the DEVDAX and FSDAX sub-cases of DAX
functionality.

Cc: Jan Kara <jack@suse.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: <stable@vger.kernel.org>
Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/fs.h |   16 +++++++---------
 mm/fadvise.c       |    3 ++-
 mm/filemap.c       |    4 ++--
 mm/huge_memory.c   |    4 +++-
 mm/madvise.c       |    3 ++-
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index bd0c46880572..4a5aa8761011 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3208,21 +3208,19 @@ static inline bool io_is_direct(struct file *filp)
 
 static inline bool vma_is_dax(struct vm_area_struct *vma)
 {
-	return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
+	struct inode *inode;
+
+	if (!vma->vm_file)
+		return false;
+	inode = vma->vm_file->f_mapping->host;
+	return IS_FSDAX(inode) || IS_DEVDAX(inode);
 }
 
 static inline bool vma_is_fsdax(struct vm_area_struct *vma)
 {
-	struct inode *inode;
-
 	if (!vma->vm_file)
 		return false;
-	if (!vma_is_dax(vma))
-		return false;
-	inode = file_inode(vma->vm_file);
-	if (S_ISCHR(inode->i_mode))
-		return false; /* device-dax */
-	return true;
+	return IS_FSDAX(file_inode(vma->vm_file));
 }
 
 static inline int iocb_flags(struct file *file)
diff --git a/mm/fadvise.c b/mm/fadvise.c
index 767887f5f3bf..00d9317636a2 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -55,7 +55,8 @@ SYSCALL_DEFINE4(fadvise64_64, int, fd, loff_t, offset, loff_t, len, int, advice)
 
 	bdi = inode_to_bdi(mapping->host);
 
-	if (IS_DAX(inode) || (bdi == &noop_backing_dev_info)) {
+	if (IS_FSDAX(inode) || IS_DEVDAX(inode)
+			|| (bdi == &noop_backing_dev_info)) {
 		switch (advice) {
 		case POSIX_FADV_NORMAL:
 		case POSIX_FADV_RANDOM:
diff --git a/mm/filemap.c b/mm/filemap.c
index 693f62212a59..4bc4e067ebf2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2357,7 +2357,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		 * DAX files, so don't bother trying.
 		 */
 		if (retval < 0 || !count || iocb->ki_pos >= size ||
-		    IS_DAX(inode))
+		    IS_FSDAX(inode))
 			goto out;
 	}
 
@@ -3225,7 +3225,7 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		 * not succeed (even if it did, DAX does not handle dirty
 		 * page-cache pages correctly).
 		 */
-		if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
+		if (written < 0 || !iov_iter_count(from) || IS_FSDAX(inode))
 			goto out;
 
 		status = generic_perform_write(file, from, pos = iocb->ki_pos);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 87ab9b8f56b5..ed238936e29b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -529,10 +529,12 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	loff_t off = (loff_t)pgoff << PAGE_SHIFT;
+	struct inode *inode;
 
 	if (addr)
 		goto out;
-	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
+	inode = filp->f_mapping->host;
+	if (!IS_FSDAX(inode) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
 		goto out;
 
 	addr = __thp_get_unmapped_area(filp, len, off, flags, PMD_SIZE);
diff --git a/mm/madvise.c b/mm/madvise.c
index 4d3c922ea1a1..bdb83cf018b1 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -275,6 +275,7 @@ static long madvise_willneed(struct vm_area_struct *vma,
 			     unsigned long start, unsigned long end)
 {
 	struct file *file = vma->vm_file;
+	struct inode *inode = file_inode(file);
 
 	*prev = vma;
 #ifdef CONFIG_SWAP
@@ -293,7 +294,7 @@ static long madvise_willneed(struct vm_area_struct *vma,
 		return -EBADF;
 #endif
 
-	if (IS_DAX(file_inode(file))) {
+	if (IS_FSDAX(inode) || IS_DEVDAX(inode)) {
 		/* no bad return value, but ignore advice */
 		return 0;
 	}
