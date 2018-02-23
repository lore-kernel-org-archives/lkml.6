Return-Path: <dan.j.williams@intel.com>
X-Google-Smtp-Source: AH8x226L98PHL7zYWSXJHMB1nl5LqcjQsd/+K4locQxsXwIbjleaDboGyg3XhngitpmGBeKFf4yT
ARC-Seal: i=1; a=rsa-sha256; t=1519424094; cv=none;
        d=google.com; s=arc-20160816;
        b=Ih4ugMP6LxYbkTmzz8t3oJBGSd0aSeupCpASy54Yw0aZjCBhN89SPnjWaz0Oc5uqQb
         s1a+o/PE2f7YypRXwOcBgoifRtt051b+4Zol8byTe/hiH8XxxWT6Yqq3miKf7zAVUJ7K
         wyePKIg3ymVp1b03ZqvScGIFsIyZHjgk6Qt9pFQ14Ok+jXMDbTsrczcsg3Tek3ERO5iQ
         p9of60WF2chqpzTAJKtZKvINsqLUAz9mSo5IOyyvnvHBscJ8TqsoteqcHcFyM5P3om07
         SzfeNjZUBGnsZKIVt/wbaUC/Ccerw0JQWZSGmzyCcqltT/5OTJYpHjQAbT7GmEKOjDA9
         aY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject
         :arc-authentication-results;
        bh=st69TYWNKzEWwxWYi9ODhVt8xTx1oyfISCzUXJXUhmw=;
        b=NOl0lVr2/YUbmAl4Hb0Fd+s70qoxz7NX/DVjaXy8DtQ21f6sozcMG/SYmLEw8tsLee
         7TSmA/3YBXcDObBQ+YIqotIxt5OMUlG1C2q8nPwlemf1yrCxtI5DdrE1dXpbD1kzgNHd
         3rgHhYfvtSX05J4OFM4Y6l8TLEeLKw0H6yOjyYndndydC5oSB78kccQmcXMd/xnHilWH
         oxBIMKtuayOdzcp/JZw7/dvvM2QLR7GkpllPBoEXodQDO4FBNoBQn3xgxZV9BvqHQ/hC
         jbRk8kox5hSmysPQByvG9tlm2slH2QuYAZ7JZxVaj30HF2ZWaHzuz178pehu10Ztt9cE
         dxnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="30233926"
Subject: [4.9-stable PATCH 05/11] mm: introduce get_user_pages_longterm
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Cc: Jan Kara <jack@suse.cz>, Joonyoung Shim <jy0922.shim@samsung.com>,
 linux-kernel@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Doug Ledford <dledford@redhat.com>, stable@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Inki Dae <inki.dae@samsung.com>,
 Jeff Moyer <jmoyer@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>,
 Mel Gorman <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>,
 Ross Zwisler <ross.zwisler@linux.intel.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Sean Hefty <sean.hefty@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Hal Rosenstock <hal.rosenstock@gmail.com>, Vlastimil Babka <vbabka@suse.cz>
Bcc: dan.j.williams@intel.com
Date: Fri, 23 Feb 2018 14:05:49 -0800
Message-ID: <151942354920.21775.1595898555475851190.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593231640037667959?=
X-GMAIL-MSGID: =?utf-8?q?1593231640037667959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 2bb6d2837083de722bfdc369cb0d76ce188dd9b4 upstream.

Patch series "introduce get_user_pages_longterm()", v2.

Here is a new get_user_pages api for cases where a driver intends to
keep an elevated page count indefinitely.  This is distinct from usages
like iov_iter_get_pages where the elevated page counts are transient.
The iov_iter_get_pages cases immediately turn around and submit the
pages to a device driver which will put_page when the i/o operation
completes (under kernel control).

In the longterm case userspace is responsible for dropping the page
reference at some undefined point in the future.  This is untenable for
filesystem-dax case where the filesystem is in control of the lifetime
of the block / page and needs reasonable limits on how long it can wait
for pages in a mapping to become idle.

Fixing filesystems to actually wait for dax pages to be idle before
blocks from a truncate/hole-punch operation are repurposed is saved for
a later patch series.

Also, allowing longterm registration of dax mappings is a future patch
series that introduces a "map with lease" semantic where the kernel can
revoke a lease and force userspace to drop its page references.

I have also tagged these for -stable to purposely break cases that might
assume that longterm memory registrations for filesystem-dax mappings
were supported by the kernel.  The behavior regression this policy
change implies is one of the reasons we maintain the "dax enabled.
Warning: EXPERIMENTAL, use at your own risk" notification when mounting
a filesystem in dax mode.

It is worth noting the device-dax interface does not suffer the same
constraints since it does not support file space management operations
like hole-punch.

This patch (of 4):

Until there is a solution to the dma-to-dax vs truncate problem it is
not safe to allow long standing memory registrations against
filesytem-dax vmas.  Device-dax vmas do not have this problem and are
explicitly allowed.

This is temporary until a "memory registration with layout-lease"
mechanism can be implemented for the affected sub-systems (RDMA and
V4L2).

[akpm@linux-foundation.org: use kcalloc()]
Link: http://lkml.kernel.org/r/151068939435.7446.13560129395419350737.stgit@dwillia2-desk3.amr.corp.intel.com
Fixes: 3565fce3a659 ("mm, x86: get_user_pages() for dax mappings")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Hal Rosenstock <hal.rosenstock@gmail.com>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Sean Hefty <sean.hefty@intel.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/dax.h |    5 ----
 include/linux/fs.h  |   20 ++++++++++++++++
 include/linux/mm.h  |   13 ++++++++++
 mm/gup.c            |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/include/linux/dax.h b/include/linux/dax.h
index add6c4bc568f..ed9cf2f5cd06 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -61,11 +61,6 @@ static inline int dax_pmd_fault(struct vm_area_struct *vma, unsigned long addr,
 int dax_pfn_mkwrite(struct vm_area_struct *, struct vm_fault *);
 #define dax_mkwrite(vma, vmf, gb)	dax_fault(vma, vmf, gb)
 
-static inline bool vma_is_dax(struct vm_area_struct *vma)
-{
-	return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
-}
-
 static inline bool dax_mapping(struct address_space *mapping)
 {
 	return mapping->host && IS_DAX(mapping->host);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d705ae084edd..745ea1b2e02c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -18,6 +18,7 @@
 #include <linux/bug.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
+#include <linux/mm_types.h>
 #include <linux/capability.h>
 #include <linux/semaphore.h>
 #include <linux/fiemap.h>
@@ -3033,6 +3034,25 @@ static inline bool io_is_direct(struct file *filp)
 	return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host);
 }
 
+static inline bool vma_is_dax(struct vm_area_struct *vma)
+{
+	return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
+}
+
+static inline bool vma_is_fsdax(struct vm_area_struct *vma)
+{
+	struct inode *inode;
+
+	if (!vma->vm_file)
+		return false;
+	if (!vma_is_dax(vma))
+		return false;
+	inode = file_inode(vma->vm_file);
+	if (inode->i_mode == S_IFCHR)
+		return false; /* device-dax */
+	return true;
+}
+
 static inline int iocb_flags(struct file *file)
 {
 	int res = 0;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2217e2f18247..8e506783631b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1288,6 +1288,19 @@ long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
 			       struct page **pages, unsigned int gup_flags);
 long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 		    struct page **pages, unsigned int gup_flags);
+#ifdef CONFIG_FS_DAX
+long get_user_pages_longterm(unsigned long start, unsigned long nr_pages,
+			    unsigned int gup_flags, struct page **pages,
+			    struct vm_area_struct **vmas);
+#else
+static inline long get_user_pages_longterm(unsigned long start,
+		unsigned long nr_pages, unsigned int gup_flags,
+		struct page **pages, struct vm_area_struct **vmas)
+{
+	return get_user_pages(start, nr_pages, gup_flags, pages, vmas);
+}
+#endif /* CONFIG_FS_DAX */
+
 int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			struct page **pages);
 
diff --git a/mm/gup.c b/mm/gup.c
index c63a0341ae38..6c3b4e822946 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -982,6 +982,70 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
 }
 EXPORT_SYMBOL(get_user_pages);
 
+#ifdef CONFIG_FS_DAX
+/*
+ * This is the same as get_user_pages() in that it assumes we are
+ * operating on the current task's mm, but it goes further to validate
+ * that the vmas associated with the address range are suitable for
+ * longterm elevated page reference counts. For example, filesystem-dax
+ * mappings are subject to the lifetime enforced by the filesystem and
+ * we need guarantees that longterm users like RDMA and V4L2 only
+ * establish mappings that have a kernel enforced revocation mechanism.
+ *
+ * "longterm" == userspace controlled elevated page count lifetime.
+ * Contrast this to iov_iter_get_pages() usages which are transient.
+ */
+long get_user_pages_longterm(unsigned long start, unsigned long nr_pages,
+		unsigned int gup_flags, struct page **pages,
+		struct vm_area_struct **vmas_arg)
+{
+	struct vm_area_struct **vmas = vmas_arg;
+	struct vm_area_struct *vma_prev = NULL;
+	long rc, i;
+
+	if (!pages)
+		return -EINVAL;
+
+	if (!vmas) {
+		vmas = kcalloc(nr_pages, sizeof(struct vm_area_struct *),
+			       GFP_KERNEL);
+		if (!vmas)
+			return -ENOMEM;
+	}
+
+	rc = get_user_pages(start, nr_pages, gup_flags, pages, vmas);
+
+	for (i = 0; i < rc; i++) {
+		struct vm_area_struct *vma = vmas[i];
+
+		if (vma == vma_prev)
+			continue;
+
+		vma_prev = vma;
+
+		if (vma_is_fsdax(vma))
+			break;
+	}
+
+	/*
+	 * Either get_user_pages() failed, or the vma validation
+	 * succeeded, in either case we don't need to put_page() before
+	 * returning.
+	 */
+	if (i >= rc)
+		goto out;
+
+	for (i = 0; i < rc; i++)
+		put_page(pages[i]);
+	rc = -EOPNOTSUPP;
+out:
+	if (vmas != vmas_arg)
+		kfree(vmas);
+	return rc;
+}
+EXPORT_SYMBOL(get_user_pages_longterm);
+#endif /* CONFIG_FS_DAX */
+
 /**
  * populate_vma_page_range() -  populate a range of pages in the vma.
  * @vma:   target vma
