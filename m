Return-Path: <kernel-hardening-return-12079-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELswuQZtYss/tOsexQA+7MnqjepBw/WNbH/2ppsldVRJyPkSzZaGQcAgsS7cWP9cum+OVwik
ARC-Seal: i=1; a=rsa-sha256; t=1520026016; cv=none;
        d=google.com; s=arc-20160816;
        b=lZnYU5vvw9LGLKwJ2atpz4zAtP5+94aHK3Kmv+bPVqz+e89OyuChtF6IQllil0W6WA
         BCoVxH4LcRvF1j4DNpvBi3ZX9m/EF3NvM8+dJ6prxsN1zArRrDfGZuIgwQkmQHGlghaF
         K/GOwy98M9Rw+y9aNoXCnaYe78pzRG64DTyDJX6qNmcq8dp39uMtvztIAcs98xhVpPun
         38+iMlM1FALyVecTrXGsmbkDWOUECHoC/BUDSNbYyzqloAzSvgTl/4a2a74GBepARwa+
         4/jx6TfrwFbqGd/FXuehWz7uF/xluZCLFEJgiIwVhHWir5ZjaB4D1BuQqlLXucbGOATO
         lPdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=Kjw4KLsYxrNBv9OqNayEHk3oHiUnr7Dvv+SCU6b6Ev4=;
        b=zMfFf0jX8HsbXuYG0grG56+Pp/WVwbohmsx2S6niSo/cKYsVkBK2EimouXTLoC1mll
         6DxHMkGX7DSlItDDnLyH1SAgbXSyQ4k7nFBmVFxkUK7Vc5zqY0ezs02FXVeBXXt22LoU
         4yWz6rJ/jldxkfa0Kqi6Ohwxi6pMcidDxR5eFEAFllDFtjeU0dGLTgip6CuZjuLya18S
         ooh08LciWMOFCL/h/8KZ95zxP0ZxxO2w5A0KyspaEzh1UKGBz11ziHCu6PWJDJyvdXot
         8FIeeCu2dymu0YZGlTFVAl4dC1KVcAfTlMg2rokHLsEW7QTN1RpnbKodFDksKwY52q4a
         7W0g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=tpr5ydUC;
       spf=pass (google.com: domain of kernel-hardening-return-12079-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12079-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=tpr5ydUC;
       spf=pass (google.com: domain of kernel-hardening-return-12079-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12079-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 2 Mar 2018 13:26:37 -0800
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC] Handle mapcount overflows
Message-ID: <20180302212637.GB671@bombadil.infradead.org>
References: <20180208021112.GB14918@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208021112.GB14918@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593862799647691952?=
X-GMAIL-MSGID: =?utf-8?q?1593862799647691952?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Here's my third effort to handle page->_mapcount overflows.

The idea is to minimise overhead, so we keep a list of users with more
than 5000 mappings.  In order to overflow _mapcount, you have to have
2 billion mappings, so you'd need 400,000 tasks to evade the tracking,
and your sysadmin has probably accused you of forkbombing the system
long before then.  Not to mention the 6GB of RAM you consumed just in
stacks and the 24GB of RAM you consumed in page tables ... but I digress.

Let's assume that the sysadmin has increased the number of processes to
100,000.  You'd need to create 20,000 mappings per process to overflow
_mapcount, and they'd end up on the 'heavy_users' list.  Not everybody
on the heavy_users list is going to be guilty, but if we hit an overflow,
we look at everybody on the heavy_users list and if they've got the page
mapped more than 1000 times, they get a SIGSEGV.

I'm not entirely sure how to forcibly tear down a task's mappings, so
I've just left a comment in there to do that.  Looking for feedback on
this approach.

diff --git a/mm/internal.h b/mm/internal.h
index 7059a8389194..977852b8329e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -97,6 +97,11 @@ extern void putback_lru_page(struct page *page);
  */
 extern pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
 
+#ifdef CONFIG_64BIT
+extern void mm_mapcount_overflow(struct page *page);
+#else
+static inline void mm_mapcount_overflow(struct page *page) { }
+#endif
 /*
  * in mm/page_alloc.c
  */
diff --git a/mm/mmap.c b/mm/mmap.c
index 9efdc021ad22..575766ec02f8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1315,6 +1315,115 @@ static inline int mlock_future_check(struct mm_struct *mm,
 	return 0;
 }
 
+#ifdef CONFIG_64BIT
+/*
+ * Machines with more than 2TB of memory can create enough VMAs to overflow
+ * page->_mapcount if they all point to the same page.  32-bit machines do
+ * not need to be concerned.
+ */
+/*
+ * Experimentally determined.  gnome-shell currently uses fewer than
+ * 3000 mappings, so should have zero effect on desktop users.
+ */
+#define mm_track_threshold	5000
+static DEFINE_SPINLOCK(heavy_users_lock);
+static DEFINE_IDR(heavy_users);
+
+static void mmap_track_user(struct mm_struct *mm, int max)
+{
+	struct mm_struct *entry;
+	unsigned int id;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&heavy_users_lock);
+	idr_for_each_entry(&heavy_users, entry, id) {
+		if (entry == mm)
+			break;
+		if (entry->map_count < mm_track_threshold)
+			idr_remove(&heavy_users, id);
+	}
+	if (!entry)
+		idr_alloc(&heavy_users, mm, 0, 0, GFP_ATOMIC);
+	spin_unlock(&heavy_users_lock);
+}
+
+static void mmap_untrack_user(struct mm_struct *mm)
+{
+	struct mm_struct *entry;
+	unsigned int id;
+
+	spin_lock(&heavy_users_lock);
+	idr_for_each_entry(&heavy_users, entry, id) {
+		if (entry == mm) {
+			idr_remove(&heavy_users, id);
+			break;
+		}
+	}
+	spin_unlock(&heavy_users_lock);
+}
+
+static void kill_mm(struct task_struct *tsk)
+{
+	/* Tear down the mappings first */
+	do_send_sig_info(SIGKILL, SEND_SIG_FORCED, tsk, true);
+}
+
+static void kill_abuser(struct mm_struct *mm)
+{
+	struct task_struct *tsk;
+
+	for_each_process(tsk)
+		if (tsk->mm == mm)
+			break;
+
+	if (down_write_trylock(&mm->mmap_sem)) {
+		kill_mm(tsk);
+		up_write(&mm->mmap_sem);
+	} else {
+		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, tsk, true);
+	}
+}
+
+void mm_mapcount_overflow(struct page *page)
+{
+	struct mm_struct *entry = current->mm;
+	unsigned int id;
+	struct vm_area_struct *vma;
+	struct address_space *mapping = page_mapping(page);
+	unsigned long pgoff = page_to_pgoff(page);
+	unsigned int count = 0;
+
+	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff + 1) {
+		if (vma->vm_mm == entry)
+			count++;
+		if (count > 1000)
+			kill_mm(current);
+	}
+
+	rcu_read_lock();
+	idr_for_each_entry(&heavy_users, entry, id) {
+		count = 0;
+
+		vma_interval_tree_foreach(vma, &mapping->i_mmap,
+				pgoff, pgoff + 1) {
+			if (vma->vm_mm == entry)
+				count++;
+			if (count > 1000) {
+				kill_abuser(entry);
+				goto out;
+			}
+		}
+	}
+	if (!entry)
+		panic("No abusers found but mapcount exceeded\n");
+out:
+	rcu_read_unlock();
+}
+#else
+static void mmap_track_user(struct mm_struct *mm, int max) { }
+static void mmap_untrack_user(struct mm_struct *mm) { }
+#endif
+
 /*
  * The caller must hold down_write(&current->mm->mmap_sem).
  */
@@ -1357,6 +1466,8 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	/* Too many mappings? */
 	if (mm->map_count > sysctl_max_map_count)
 		return -ENOMEM;
+	if (mm->map_count > mm_track_threshold)
+		mmap_track_user(mm, mm_track_threshold);
 
 	/* Obtain the address to map to. we verify (or select) it and ensure
 	 * that it represents a valid section of the address space.
@@ -2997,6 +3108,8 @@ void exit_mmap(struct mm_struct *mm)
 	/* mm's last user has gone, and its about to be pulled down */
 	mmu_notifier_release(mm);
 
+	mmap_untrack_user(mm);
+
 	if (mm->locked_vm) {
 		vma = mm->mmap;
 		while (vma) {
diff --git a/mm/rmap.c b/mm/rmap.c
index 47db27f8049e..d88acf5c98e9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1190,6 +1190,7 @@ void page_add_file_rmap(struct page *page, bool compound)
 		VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
 		__inc_node_page_state(page, NR_SHMEM_PMDMAPPED);
 	} else {
+		int v;
 		if (PageTransCompound(page) && page_mapping(page)) {
 			VM_WARN_ON_ONCE(!PageLocked(page));
 
@@ -1197,8 +1198,13 @@ void page_add_file_rmap(struct page *page, bool compound)
 			if (PageMlocked(page))
 				clear_page_mlock(compound_head(page));
 		}
-		if (!atomic_inc_and_test(&page->_mapcount))
+		v = atomic_inc_return(&page->_mapcount);
+		if (likely(v > 0))
 			goto out;
+		if (unlikely(v < 0)) {
+			mm_mapcount_overflow(page);
+			goto out;
+		}
 	}
 	__mod_lruvec_page_state(page, NR_FILE_MAPPED, nr);
 out:
