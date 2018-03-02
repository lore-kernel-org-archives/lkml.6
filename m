Return-Path: <kernel-hardening-return-12081-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsdOE/J3uTRD/QDoRsGNObTCNXqrtH1pzF8GdG1s9SP+ORTIb8I1oWSKOvcriyG/1aXFfPF
ARC-Seal: i=1; a=rsa-sha256; t=1520028243; cv=none;
        d=google.com; s=arc-20160816;
        b=Do/kaImngXPZlv8WHyGmIF+OR5VqjTsT+LJL6707eczOVrjBalXn68gMj/Uc0iLjiC
         DE2VLULgU3PRzwz4x4MoHJcSEnEvEOwzc5i2RxetkBBjL+mlM7GMtQRMTR3IhGIUUy+h
         6FcvwecIGU1tRzCyPf9giEMjNhl7Wio7hbY+iazuMPrQbUj+ECJsckSuGT+axB+scIcZ
         kVF6zXFIo11GD8JC3ouBV2onTmq9sXr/sd6yZO4Ef3X7FIKNxKqV4ZbUtS8ESf2LK11i
         K9pO0e8goi1mHmLpd6ebAy59v9DQCPxMB5W8Z9/8FQimJEBhgOvBq5FUCclSkDbzwrQi
         SODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=tAK774M3hcBS5ZLiu3DXZX8LmChdfOAYcFcfUTbfuSM=;
        b=cNa4KjbFhDWKSqVcG0MQsl7hc6bdeED8cAKaoAepITCuQG72Ke1/i5ny5RS22fH2tv
         ksmmjX+cy2jdNueXJBrUImECtQFyW0IJ2SYHZu1QPhAeb8/ryheKhWTZNAqfSS0EhXTh
         0lywOYb4CCGVv6htaln2TM9px8um7gP68aRW+R2FzCnM+hsR9IzqD495IgFfPt14WJ9B
         hsME54cJrr9o8ozcyzrMZrMmcoMNcOHNFAODUinzXn/F2XuS8jGV+wpIfDUHAKIVsQ1+
         DecpyMDLcT3S6ZWKds8nsp24/77fQBBu16CsOrnwYi2O5S3CtPimPdksw8bHC9hKWcCB
         Ql+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=G191BGyq;
       spf=pass (google.com: domain of kernel-hardening-return-12081-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12081-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=G191BGyq;
       spf=pass (google.com: domain of kernel-hardening-return-12081-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12081-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 2 Mar 2018 14:03:40 -0800
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC] Handle mapcount overflows
Message-ID: <20180302220340.GC671@bombadil.infradead.org>
References: <20180208021112.GB14918@bombadil.infradead.org>
 <20180302212637.GB671@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302212637.GB671@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593862799647691952?=
X-GMAIL-MSGID: =?utf-8?q?1593865135277672977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 01:26:37PM -0800, Matthew Wilcox wrote:
> Here's my third effort to handle page->_mapcount overflows.

If you like this approach, but wonder if it works, here's a little forkbomb
of a program and a patch to add instrumentation.

In my dmesg, I never see the max mapcount getting above 65539.  I see a mix
of unlucky, it him! and it me! messages.

#define _GNU_SOURCE

#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

int dummy;

int main(int argc, char **argv)
{
	int fd = open(argv[1], O_RDWR);
	int i;

	if (fd < 0) {
		perror(argv[1]);
		return 1;
	}

	// Spawn 511 children
	for (i = 0; i < 9; i++)
		fork();

	for (i = 0; i < 5000; i++)
		dummy = *(int *)mmap(NULL, 4096, PROT_READ, MAP_SHARED, fd, 0);
}


diff --git a/mm/mmap.c b/mm/mmap.c
index 575766ec02f8..2b6187156db0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1325,7 +1325,7 @@ static inline int mlock_future_check(struct mm_struct *mm,
  * Experimentally determined.  gnome-shell currently uses fewer than
  * 3000 mappings, so should have zero effect on desktop users.
  */
-#define mm_track_threshold	5000
+#define mm_track_threshold	50
 static DEFINE_SPINLOCK(heavy_users_lock);
 static DEFINE_IDR(heavy_users);
 
@@ -1377,9 +1377,11 @@ static void kill_abuser(struct mm_struct *mm)
 			break;
 
 	if (down_write_trylock(&mm->mmap_sem)) {
+		printk_ratelimited("it him!\n");
 		kill_mm(tsk);
 		up_write(&mm->mmap_sem);
 	} else {
+		printk_ratelimited("unlucky!\n");
 		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, tsk, true);
 	}
 }
@@ -1396,8 +1398,10 @@ void mm_mapcount_overflow(struct page *page)
 	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff + 1) {
 		if (vma->vm_mm == entry)
 			count++;
-		if (count > 1000)
+		if (count > 1000) {
+			printk_ratelimited("it me!\n");
 			kill_mm(current);
+		}
 	}
 
 	rcu_read_lock();
@@ -1408,7 +1412,7 @@ void mm_mapcount_overflow(struct page *page)
 				pgoff, pgoff + 1) {
 			if (vma->vm_mm == entry)
 				count++;
-			if (count > 1000) {
+			if (count > 10) {
 				kill_abuser(entry);
 				goto out;
 			}
diff --git a/mm/rmap.c b/mm/rmap.c
index d88acf5c98e9..3f0509f6f011 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1190,6 +1190,7 @@ void page_add_file_rmap(struct page *page, bool compound)
 		VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
 		__inc_node_page_state(page, NR_SHMEM_PMDMAPPED);
 	} else {
+		static int max = 0;
 		int v;
 		if (PageTransCompound(page) && page_mapping(page)) {
 			VM_WARN_ON_ONCE(!PageLocked(page));
@@ -1199,12 +1200,14 @@ void page_add_file_rmap(struct page *page, bool compound)
 				clear_page_mlock(compound_head(page));
 		}
 		v = atomic_inc_return(&page->_mapcount);
-		if (likely(v > 0))
-			goto out;
-		if (unlikely(v < 0)) {
+		if (unlikely(v > 65535)) {
+			if (max < v) max = v;
+			printk_ratelimited("overflow %d max %d\n", v, max);
 			mm_mapcount_overflow(page);
 			goto out;
 		}
+		if (likely(v > 0))
+			goto out;
 	}
 	__mod_lruvec_page_state(page, NR_FILE_MAPPED, nr);
 out:
