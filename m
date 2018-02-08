Return-Path: <kernel-hardening-return-11664-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225ILXYSgKZRV4Ju/uoAqVWEvI934G8+ZdpIZwLqzvqfFAk024XClzYCwJAlm3y0PjDLqu8K
ARC-Seal: i=1; a=rsa-sha256; t=1518125883; cv=none;
        d=google.com; s=arc-20160816;
        b=CWOB+LGEYquRYobO6cahCsEhmwOnQ8ql00KAoma1ZNr+sgzFWTREnm6B6+izD5ICWy
         +WwVKccc68oBv+Xjbo9LfFwoS7Dq0gepEqWIR+zIUD9HtSk1kZOd+KVi/zz7UFmIRUfL
         9b4dClKCi5jlb7uevajihEpWsOPeljR5kZ8BRb2jjva1XngpnmH0MWUC1vC9DbBzLe68
         uAumQXA1gg+7HTeSys77M3fbQK9FsoggX+UlDGgO8lbzo2bAXglw8LNpqvsifW9yGhlg
         xqUwIHASvI2SpJZITAhJ+jfnbtxfRgNBxT/y1EICwKa/dVSLcy00enlJT9Y0WvSaMIq5
         rByw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=BfQOMMOu6KzUdHWxvbsoLT+xKufQsPS7BbY7wjQnAeI=;
        b=Ae2FiI1f5ZcIsmlLTBLOfg1O5IYRQ+/CTUjjCcJAwD6fQjV/5bF4A5PBNT3S7CzK5t
         iAWozVE5yZAyEOZswOv2UVf5wipFs/0heLaFJO6E8ipzxk9VU9BKkc+xFLr0SNWAglt3
         mckOxPix6FxdD/fzpmoMl1Q+TmxKlb+e/B/WOoeBHzTyJXYiTwiEGtOq7ugvn2LItoXH
         Vxc75PDgsrJ/oYEVzLELVKEKvWTTijsLtZ2Z+QCQqlF8n4WFtVEqRNP/lgELIvoghQ1f
         JziL5KonH2TuDbZ4okBnEqjsrkrklY/K7pDIH2gCirFZJGvONahSMXm4AEc5LJzhi9hF
         O4cQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=UCV8Z94+;
       spf=pass (google.com: domain of kernel-hardening-return-11664-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11664-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=UCV8Z94+;
       spf=pass (google.com: domain of kernel-hardening-return-11664-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11664-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Feb 2018 13:37:43 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Daniel Micay <danielmicay@gmail.com>
Cc: Jann Horn <jannh@google.com>, linux-mm@kvack.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC] Limit mappings to ten per page per process
Message-ID: <20180208213743.GC3424@bombadil.infradead.org>
References: <20180208021112.GB14918@bombadil.infradead.org>
 <CAG48ez2-MTJ2YrS5fPZi19RY6P_6NWuK1U5CcQpJ25=xrGSy_A@mail.gmail.com>
 <CA+DvKQLHDR0s=6r4uiHL8kw2_PnfJcwYfPxgQOmuLbc=5k39+g@mail.gmail.com>
 <20180208185648.GB9524@bombadil.infradead.org>
 <CA+DvKQLHcFc3+kW_SnD6hs53yyD5Zi+uAeSgDMm1tRzxqy-Opg@mail.gmail.com>
 <20180208194235.GA3424@bombadil.infradead.org>
 <CA+DvKQKba0iU+tydbmGkAJsxCxazORDnuoe32sy-2nggyagUxQ@mail.gmail.com>
 <20180208202100.GB3424@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208202100.GB3424@bombadil.infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591870366530801102?=
X-GMAIL-MSGID: =?utf-8?q?1591870366530801102?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 12:21:00PM -0800, Matthew Wilcox wrote:
> Now that I think about it, though, perhaps the simplest solution is not
> to worry about checking whether _mapcount has saturated, and instead when
> adding a new mmap, check whether this task already has it mapped 10 times.
> If so, refuse the mapping.

That turns out to be quite easy.  Comments on this approach?

diff --git a/mm/mmap.c b/mm/mmap.c
index 9efdc021ad22..fd64ff662117 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1615,6 +1615,34 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
 }
 
+/**
+ * mmap_max_overlaps - Check the process has not exceeded its quota of mappings.
+ * @mm: The memory map for the process creating the mapping.
+ * @file: The file the mapping is coming from.
+ * @pgoff: The start of the mapping in the file.
+ * @count: The number of pages to map.
+ *
+ * Return: %true if this region of the file has too many overlapping mappings
+ *         by this process.
+ */
+bool mmap_max_overlaps(struct mm_struct *mm, struct file *file,
+			pgoff_t pgoff, pgoff_t count)
+{
+	unsigned int overlaps = 0;
+	struct vm_area_struct *vma;
+
+	if (!file)
+		return false;
+
+	vma_interval_tree_foreach(vma, &file->f_mapping->i_mmap,
+				  pgoff, pgoff + count) {
+		if (vma->vm_mm == mm)
+			overlaps++;
+	}
+
+	return overlaps > 9;
+}
+
 unsigned long mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
@@ -1640,6 +1668,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			return -ENOMEM;
 	}
 
+	if (mmap_max_overlaps(mm, file, pgoff, len >> PAGE_SHIFT))
+		return -ENOMEM;
+
 	/* Clear old maps */
 	while (find_vma_links(mm, addr, addr + len, &prev, &rb_link,
 			      &rb_parent)) {
diff --git a/mm/mremap.c b/mm/mremap.c
index 049470aa1e3e..27cf5cf9fc0f 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -430,6 +430,10 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 				(new_len - old_len) >> PAGE_SHIFT))
 		return ERR_PTR(-ENOMEM);
 
+	if (mmap_max_overlaps(mm, vma->vm_file, pgoff,
+				(new_len - old_len) >> PAGE_SHIFT))
+		return ERR_PTR(-ENOMEM);
+
 	if (vma->vm_flags & VM_ACCOUNT) {
 		unsigned long charged = (new_len - old_len) >> PAGE_SHIFT;
 		if (security_vm_enough_memory_mm(mm, charged))
