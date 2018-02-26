Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227jKBOz2xYVJpn5NU0zlWVCV4NmErGStR1MewBD1DMpIZfqAfHx/n+/Nwl4Ewbum+2El3wu
ARC-Seal: i=1; a=rsa-sha256; t=1519676550; cv=none;
        d=google.com; s=arc-20160816;
        b=ZSqhr07OFUt9qVaG6e/WtMgSeKcFUpxxrrx+Id4c+En4q5zUrODFwcl2233kmHJa47
         B6cxUPeKXrutJuhwSai//eAfdsgUNmE51EjeiH4akzLVaZA7gs7ip20p3vCqAljpwlO5
         nM5C4ooBPXMinsvLQaYOMOcQWctsx6A+ot9RN1hnXnMU7FuyvMRwZpzF5xiVxnFSlYHq
         9DJj3XOFULyNIJMDlcXnTFkWSfXKSEEtdNFHb+p6GhWLYOgUEgBBE/6IrObXjk2Bh2Ey
         xFCdpq01/eOju/xhzxWBPgu6f3m5od6BcjeEsQbBco06RQfpVeESKsogI18lW1yMHYdM
         UVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9QxHbkx3ZnQZXyTpFmoXourNltnTpuUT4ZiH0SF8OrQ=;
        b=VgRBF0/1K+fqyrItnoR/vRBmoCLTfp1ZUn/v8am3TL43PDa4vsnKEvTREKAgjpfP3K
         4zJ0WQ1HKsbKXLNwLeu4BdHcTH/70L45DWgiIlbylceSUdSBY5G8OUkqB/jYXWZ1cwAt
         fE2+uo3ruB3iylvdm5lRCSlNygsVhHxXuYVf4Lc5Cv61a6mCjaynno36P6rdxf5qWSwT
         GFBst2qFa3G4ineVsz3i72NIkOSlvhtrJ2LwhlKhD+UPMSxwhb5YpxI2UgllD2CVymty
         9YCTJU6Nr4hgY75AxWwFVcIfZn/CubLLWJH9l8y7mwEcw5+n3abAI95DgxK6wrz2N3vV
         lJLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Doug Ledford <dledford@redhat.com>,
	Hal Rosenstock <hal.rosenstock@gmail.com>,
	Inki Dae <inki.dae@samsung.com>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Jeff Moyer <jmoyer@redhat.com>,
	Joonyoung Shim <jy0922.shim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mel Gorman <mgorman@suse.de>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Sean Hefty <sean.hefty@intel.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 33/39] mm: introduce get_user_pages_longterm
Date: Mon, 26 Feb 2018 21:20:54 +0100
Message-Id: <20180226201645.125678735@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496358725399672?=
X-GMAIL-MSGID: =?utf-8?q?1593496358725399672?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/dax.h |    5 ----
 include/linux/fs.h  |   20 ++++++++++++++++
 include/linux/mm.h  |   13 ++++++++++
 mm/gup.c            |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 5 deletions(-)

--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -61,11 +61,6 @@ static inline int dax_pmd_fault(struct v
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
@@ -3033,6 +3034,25 @@ static inline bool io_is_direct(struct f
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
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1288,6 +1288,19 @@ long __get_user_pages_unlocked(struct ta
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
 
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -982,6 +982,70 @@ long get_user_pages(unsigned long start,
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
