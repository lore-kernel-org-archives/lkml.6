Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-494696-1519963547-2-13705776996967296762
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
    t=1519963546; b=c1hpbwp1EpCFpsiRQWPPUl8k+l54bhgsquu9+24L0iwm47Z
    fzx+ZJFfiGp5E2tWoBSSWArTn0k0adxxAw0UtNQWhZJYHaQsH3TO6DN4bW7o7+Wz
    Ikp9BNYH3hK7yopU8AsL6MpaZRyD0YUuDE+4hAYlu8HM1RMgrnL9ACYwiyXhWKmV
    quSUy3v7Qs/HqOL5bgHxM7hfoSXrAifQMGkqeDMVQc4Qj/VRtLUX0EPOVJy7a3h0
    FkIpWQu21qUKSoLv4MeN6gjL80L8g7nwisgtRCptWVizCORpfksLeQqbTQCO6d21
    xnEAKXmKSQTf+Oztk0s3xHXRzD7jCqDZKhu4iew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519963546; bh=hIzffaiosM/Lp4vPpVMOX11XJU4GR3K5dh6LhngJAg8=; b=O
    XqbWNaVIG1wP57mNTqZMVKPALlBhenA5pBBc1rJmj+0u/pK0epQjwRffyTbHynRC
    yOEKAdtwS3lHlSdi38AW8uCbpTw8g/HRuI1Eftcm0DMsdsfbqiThhbntt8NgIqoW
    n3EXpvsHAPKEUuxbUYPeQh94AorXPVSTCPwwb/aIgnAHHBzYlJg8pvFzkIyuJRfU
    H9xOpM52m0CHgmlWX61l8CaeowzJ6yRb54rrIWQXpgbVPDL0dmDcdEbeZbQQv6CQ
    KUlhr/pUEEzZYAVIOWmb2i24AEvuy3LEx5mmx6HE0ZFGZSQrPxQ3HQpZxQ+HdqFh
    uu1t+FGYf7BpMDIFKJXow==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422656AbeCBEFY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 23:05:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:55261 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164684AbeCBEDB (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Mar 2018 23:03:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="21948180"
Subject: [PATCH v5 04/12] ext2,
 dax: define ext2_dax_*() infrastructure in all cases
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-xfs@vger.kernel.org, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date: Thu, 01 Mar 2018 19:53:55 -0800
Message-ID: <151996283559.28483.2221179891176741624.stgit@dwillia2-desk3.amr.corp.intel.com>
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

In preparation for fixing S_DAX to be defined in the CONFIG_FS_DAX=n +
CONFIG_DEV_DAX=y case, move the definition of these routines outside of
the "#ifdef CONFIG_FS_DAX" guard. This is also a coding-style fix to
move all ifdef handling to header files rather than in the source. The
compiler will still be able to determine that all the related code can
be discarded in the CONFIG_FS_DAX=n case.

Cc: <stable@vger.kernel.org>
Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/ext2/file.c      |    8 --------
 include/linux/dax.h |   10 ++++++++--
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 1c7ea1bcddde..5ac98d074323 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -29,7 +29,6 @@
 #include "xattr.h"
 #include "acl.h"
 
-#ifdef CONFIG_FS_DAX
 static ssize_t ext2_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct inode *inode = iocb->ki_filp->f_mapping->host;
@@ -128,9 +127,6 @@ static int ext2_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vma->vm_flags |= VM_MIXEDMAP;
 	return 0;
 }
-#else
-#define ext2_file_mmap	generic_file_mmap
-#endif
 
 /*
  * Called when filp is released. This happens when all file descriptors
@@ -162,19 +158,15 @@ int ext2_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 
 static ssize_t ext2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-#ifdef CONFIG_FS_DAX
 	if (IS_DAX(iocb->ki_filp->f_mapping->host))
 		return ext2_dax_read_iter(iocb, to);
-#endif
 	return generic_file_read_iter(iocb, to);
 }
 
 static ssize_t ext2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-#ifdef CONFIG_FS_DAX
 	if (IS_DAX(iocb->ki_filp->f_mapping->host))
 		return ext2_dax_write_iter(iocb, from);
-#endif
 	return generic_file_write_iter(iocb, from);
 }
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 0185ecdae135..47edbce4fc52 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -93,8 +93,6 @@ void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 void dax_write_cache(struct dax_device *dax_dev, bool wc);
 bool dax_write_cache_enabled(struct dax_device *dax_dev);
 
-ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops);
 int dax_iomap_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
 		    pfn_t *pfnp, int *errp, const struct iomap_ops *ops);
 int dax_finish_sync_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
@@ -107,6 +105,8 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 int __dax_zero_page_range(struct block_device *bdev,
 		struct dax_device *dax_dev, sector_t sector,
 		unsigned int offset, unsigned int length);
+ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
+		const struct iomap_ops *ops);
 #else
 static inline int __dax_zero_page_range(struct block_device *bdev,
 		struct dax_device *dax_dev, sector_t sector,
@@ -114,6 +114,12 @@ static inline int __dax_zero_page_range(struct block_device *bdev,
 {
 	return -ENXIO;
 }
+
+static inline ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
+		const struct iomap_ops *ops)
+{
+	return -ENXIO;
+}
 #endif
 
 static inline bool dax_mapping(struct address_space *mapping)
