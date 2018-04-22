Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49esWHtGKjxaMp9iBguxMTEcBU1vl2FPE8N9mnTZlTzvO0NNiuzofm/ogRped7+rBM0qJKw
ARC-Seal: i=1; a=rsa-sha256; t=1524406759; cv=none;
        d=google.com; s=arc-20160816;
        b=xeaFkZaMj4irLfIoSVfiFshFn5nm+qp+ze9beHNJUjMIuDJ7m1R01G3MpwA7bmCen2
         CP/YJtg8Fcv95Uym/4dsosRKpJWVD45/REUvALR3stDrDm5YeBY2nPcIJdzezOQ88Ehg
         YeV9WH0Z3mdmJY0l8eAIKE8ncq4ksluGwAmLK5d6k5ju0l7kw4qesjdaao2Hw4F69CPa
         oJ8ElbJeQ2JlCP71AhonxyG7zZfUnJ2NhtXiYtwQbyLyAGHrjxtW4emHGTk9GTiIXMNI
         NrVCaJdEhWbf3JpxuYXGkf2Wj/qeLzkBnloVEZEHQuP56ciWXsZrcwz/Yfz3NWDP4WgU
         bULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KgAzRg6u1ZPzjM110wG+hWVTQKcLxEsrNHKJliB/lZo=;
        b=v6c3fVgbPkAFSDTrv+eXDAJwC77JBtCzTP11Mvq5M24au+oAhIjJfqTxta64jsL94V
         Ogh77kC3pi7+Ynw9OYbo5EVKxE4QT2VnrBI+Cl3mFR0O6Fn/PnWCPltAqHgNl9fH+pSY
         SbbCHDLmcAghoQoNW5RbfhPMV2iBs8YJxA+bMiKTE4EjRWM1kPyunl+uqRie1LJppQCK
         ib/7rUz9/OHPtPNhRRN+MIwP+WVMiYmscvOfsOrOAf6DCBUD782hSfJtxs5QBrzc1GG4
         LkLWSdRyYa8bPS8u3utaBFN7dfueopXJk+K9LZKVQToO0ckzG03GKTIpA4jyNtnANJdh
         /iFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Jan Kara <jack@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@suse.de>,
	Dave Chinner <david@fromorbit.com>,
	Mark Fasheh <mfasheh@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 93/97] mm: allow GFP_{FS,IO} for page_cache_read page cache allocation
Date: Sun, 22 Apr 2018 15:54:11 +0200
Message-Id: <20180422135310.256979609@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598456343231195050?=
X-GMAIL-MSGID: =?utf-8?q?1598456343231195050?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.com>

commit c20cd45eb01748f0fba77a504f956b000df4ea73 upstream.

page_cache_read has been historically using page_cache_alloc_cold to
allocate a new page.  This means that mapping_gfp_mask is used as the
base for the gfp_mask.  Many filesystems are setting this mask to
GFP_NOFS to prevent from fs recursion issues.  page_cache_read is called
from the vm_operations_struct::fault() context during the page fault.
This context doesn't need the reclaim protection normally.

ceph and ocfs2 which call filemap_fault from their fault handlers seem
to be OK because they are not taking any fs lock before invoking generic
implementation.  xfs which takes XFS_MMAPLOCK_SHARED is safe from the
reclaim recursion POV because this lock serializes truncate and punch
hole with the page faults and it doesn't get involved in the reclaim.

There is simply no reason to deliberately use a weaker allocation
context when a __GFP_FS | __GFP_IO can be used.  The GFP_NOFS protection
might be even harmful.  There is a push to fail GFP_NOFS allocations
rather than loop within allocator indefinitely with a very limited
reclaim ability.  Once we start failing those requests the OOM killer
might be triggered prematurely because the page cache allocation failure
is propagated up the page fault path and end up in
pagefault_out_of_memory.

We cannot play with mapping_gfp_mask directly because that would be racy
wrt.  parallel page faults and it might interfere with other users who
really rely on NOFS semantic from the stored gfp_mask.  The mask is also
inode proper so it would even be a layering violation.  What we can do
instead is to push the gfp_mask into struct vm_fault and allow fs layer
to overwrite it should the callback need to be called with a different
allocation context.

Initialize the default to (mapping_gfp_mask | __GFP_FS | __GFP_IO)
because this should be safe from the page fault path normally.  Why do
we care about mapping_gfp_mask at all then? Because this doesn't hold
only reclaim protection flags but it also might contain zone and
movability restrictions (GFP_DMA32, __GFP_MOVABLE and others) so we have
to respect those.

Signed-off-by: Michal Hocko <mhocko@suse.com>
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: Jan Kara <jack@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Mark Fasheh <mfasheh@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/mm.h |    4 ++++
 mm/filemap.c       |    9 ++++-----
 mm/memory.c        |   17 +++++++++++++++++
 3 files changed, 25 insertions(+), 5 deletions(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -225,10 +225,14 @@ extern pgprot_t protection_map[16];
  * ->fault function. The vma's ->fault is responsible for returning a bitmask
  * of VM_FAULT_xxx flags that give details about how the fault was handled.
  *
+ * MM layer fills up gfp_mask for page allocations but fault handler might
+ * alter it if its implementation requires a different allocation context.
+ *
  * pgoff should be used in favour of virtual_address, if possible.
  */
 struct vm_fault {
 	unsigned int flags;		/* FAULT_FLAG_xxx flags */
+	gfp_t gfp_mask;			/* gfp mask to be used for allocations */
 	pgoff_t pgoff;			/* Logical page offset based on vma */
 	void __user *virtual_address;	/* Faulting virtual address */
 
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1827,19 +1827,18 @@ EXPORT_SYMBOL(generic_file_read_iter);
  * This adds the requested page to the page cache if it isn't already there,
  * and schedules an I/O to read in its contents from disk.
  */
-static int page_cache_read(struct file *file, pgoff_t offset)
+static int page_cache_read(struct file *file, pgoff_t offset, gfp_t gfp_mask)
 {
 	struct address_space *mapping = file->f_mapping;
 	struct page *page;
 	int ret;
 
 	do {
-		page = page_cache_alloc_cold(mapping);
+		page = __page_cache_alloc(gfp_mask|__GFP_COLD);
 		if (!page)
 			return -ENOMEM;
 
-		ret = add_to_page_cache_lru(page, mapping, offset,
-				mapping_gfp_constraint(mapping, GFP_KERNEL));
+		ret = add_to_page_cache_lru(page, mapping, offset, gfp_mask & GFP_KERNEL);
 		if (ret == 0)
 			ret = mapping->a_ops->readpage(file, page);
 		else if (ret == -EEXIST)
@@ -2020,7 +2019,7 @@ no_cached_page:
 	 * We're only likely to ever get here if MADV_RANDOM is in
 	 * effect.
 	 */
-	error = page_cache_read(file, offset);
+	error = page_cache_read(file, offset, vmf->gfp_mask);
 
 	/*
 	 * The page we want has now been added to the page cache.
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1990,6 +1990,20 @@ static inline void cow_user_page(struct
 		copy_user_highpage(dst, src, va, vma);
 }
 
+static gfp_t __get_fault_gfp_mask(struct vm_area_struct *vma)
+{
+	struct file *vm_file = vma->vm_file;
+
+	if (vm_file)
+		return mapping_gfp_mask(vm_file->f_mapping) | __GFP_FS | __GFP_IO;
+
+	/*
+	 * Special mappings (e.g. VDSO) do not have any file so fake
+	 * a default GFP_KERNEL for them.
+	 */
+	return GFP_KERNEL;
+}
+
 /*
  * Notify the address space that the page is about to become writable so that
  * it can prohibit this or wait for the page to get into an appropriate state.
@@ -2005,6 +2019,7 @@ static int do_page_mkwrite(struct vm_are
 	vmf.virtual_address = (void __user *)(address & PAGE_MASK);
 	vmf.pgoff = page->index;
 	vmf.flags = FAULT_FLAG_WRITE|FAULT_FLAG_MKWRITE;
+	vmf.gfp_mask = __get_fault_gfp_mask(vma);
 	vmf.page = page;
 	vmf.cow_page = NULL;
 
@@ -2770,6 +2785,7 @@ static int __do_fault(struct vm_area_str
 	vmf.pgoff = pgoff;
 	vmf.flags = flags;
 	vmf.page = NULL;
+	vmf.gfp_mask = __get_fault_gfp_mask(vma);
 	vmf.cow_page = cow_page;
 
 	ret = vma->vm_ops->fault(vma, &vmf);
@@ -2936,6 +2952,7 @@ static void do_fault_around(struct vm_ar
 	vmf.pgoff = pgoff;
 	vmf.max_pgoff = max_pgoff;
 	vmf.flags = flags;
+	vmf.gfp_mask = __get_fault_gfp_mask(vma);
 	vma->vm_ops->map_pages(vma, &vmf);
 }
 
