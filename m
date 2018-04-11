Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+icKEMJcYLdWPobwTn3Q1KS3JX2N520gcp2SavQ6lM1R6KzDfIw1fpeuF0dtpE6nP5pPM3
ARC-Seal: i=1; a=rsa-sha256; t=1523472140; cv=none;
        d=google.com; s=arc-20160816;
        b=lx9LJmmpoeXVjzvEBd3DpP/y19g5GWb0ZQzHxsCSfg6qmggfYDwn99QNOCaCMreY9P
         A9/R/z58qfUvxgG3Z8cElFvayzCprFEzTqAoPtr+dhC9KucCtm7LZHQaDhS1RQc1WYKQ
         qSqtAZ8UYuUQrnSn9OCNlA42W2aDXzEkTJpitTP1IxTr1RXsCksB4EpPdWRsLDt9rLbi
         JoDHkFwiZV5sLvmpYZbMsUY6LvZ2Zs4G3U2+zGMG0i2sFyXhcFOHs2eNY9K/37YAY/sH
         dQzkT8ETGqDtsJP1TC68pN0ufNNX/jUJb9adB7eHeLSpq5iv4H3jJFkAXt3B8MKuCRsX
         K6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CsdCwsUHbsW6q5ITmwIVWkKFrZkwl2wE58A+5iPyJOU=;
        b=oWJEGOues3WdRF01QMB8oJzDK/tNcPTbYQzycdVi2I0N7UAIOn6Bp2Or5KEaMg0jZL
         msPJfNrUMNwDQa5lFyiuEYVL5dDpikJJCSBiVt6CVzZxVE8MiImn5KYKKfyEF4fBf76Q
         iHWLozXpaHIt9ed5Jr77Eiu1LmdKzKYOuaAXqh6jeFdkA7KfoTj5GnAfgDeczE4KMEuO
         X8xeY9XVf8XvkR/Z288Re1zYJ6PV48loG+ezqNIN5mdiupRvP9/2bmPUE4R4/EFmrJBC
         rQUUKJ4oGefAdR8IBmpRNoGmoPNfmIk38mtHDBu6Rdk4x+n2s0LNMp3m/G5qFCUo+jhI
         kn2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mel Gorman <mgorman@suse.de>,
	Davidlohr Bueso <dbueso@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Chris Mason <clm@fb.com>,
	Darren Hart <dvhart@linux.intel.com>,
	Hugh Dickins <hughd@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	dave@stgolabs.net,
	Ingo Molnar <mingo@kernel.org>,
	Chenbo Feng <fengc@google.com>
Subject: [PATCH 3.18 102/121] futex: Remove requirement for lock_page() in get_futex_key()
Date: Wed, 11 Apr 2018 20:36:45 +0200
Message-Id: <20180411183503.017076745@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476323311602672?=
X-GMAIL-MSGID: =?utf-8?q?1597476323311602672?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mel Gorman <mgorman@suse.de>

commit 65d8fc777f6dcfee12785c057a6b57f679641c90 upstream.

When dealing with key handling for shared futexes, we can drastically reduce
the usage/need of the page lock. 1) For anonymous pages, the associated futex
object is the mm_struct which does not require the page lock. 2) For inode
based, keys, we can check under RCU read lock if the page mapping is still
valid and take reference to the inode. This just leaves one rare race that
requires the page lock in the slow path when examining the swapcache.

Additionally realtime users currently have a problem with the page lock being
contended for unbounded periods of time during futex operations.

Task A
     get_futex_key()
     lock_page()
    ---> preempted

Now any other task trying to lock that page will have to wait until
task A gets scheduled back in, which is an unbound time.

With this patch, we pretty much have a lockless futex_get_key().

Experiments show that this patch can boost/speedup the hashing of shared
futexes with the perf futex benchmarks (which is good for measuring such
change) by up to 45% when there are high (> 100) thread counts on a 60 core
Westmere. Lower counts are pretty much in the noise range or less than 10%,
but mid range can be seen at over 30% overall throughput (hash ops/sec).
This makes anon-mem shared futexes much closer to its private counterpart.

Signed-off-by: Mel Gorman <mgorman@suse.de>
[ Ported on top of thp refcount rework, changelog, comments, fixes. ]
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Chris Mason <clm@fb.com>
Cc: Darren Hart <dvhart@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: dave@stgolabs.net
Link: http://lkml.kernel.org/r/1455045314-8305-3-git-send-email-dave@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Chenbo Feng <fengc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/futex.c |   98 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 91 insertions(+), 7 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -400,6 +400,7 @@ get_futex_key(u32 __user *uaddr, int fsh
 	unsigned long address = (unsigned long)uaddr;
 	struct mm_struct *mm = current->mm;
 	struct page *page, *page_head;
+	struct address_space *mapping;
 	int err, ro = 0;
 
 	/*
@@ -478,7 +479,19 @@ again:
 	}
 #endif
 
-	lock_page(page_head);
+	/*
+	 * The treatment of mapping from this point on is critical. The page
+	 * lock protects many things but in this context the page lock
+	 * stabilizes mapping, prevents inode freeing in the shared
+	 * file-backed region case and guards against movement to swap cache.
+	 *
+	 * Strictly speaking the page lock is not needed in all cases being
+	 * considered here and page lock forces unnecessarily serialization
+	 * From this point on, mapping will be re-verified if necessary and
+	 * page lock will be acquired only if it is unavoidable
+	 */
+
+	mapping = READ_ONCE(page_head->mapping);
 
 	/*
 	 * If page_head->mapping is NULL, then it cannot be a PageAnon
@@ -495,18 +508,31 @@ again:
 	 * shmem_writepage move it from filecache to swapcache beneath us:
 	 * an unlikely race, but we do need to retry for page_head->mapping.
 	 */
-	if (!page_head->mapping) {
-		int shmem_swizzled = PageSwapCache(page_head);
+	if (unlikely(!mapping)) {
+		int shmem_swizzled;
+
+		/*
+		 * Page lock is required to identify which special case above
+		 * applies. If this is really a shmem page then the page lock
+		 * will prevent unexpected transitions.
+		 */
+		lock_page(page);
+		shmem_swizzled = PageSwapCache(page) || page->mapping;
 		unlock_page(page_head);
 		put_page(page_head);
+
 		if (shmem_swizzled)
 			goto again;
+
 		return -EFAULT;
 	}
 
 	/*
 	 * Private mappings are handled in a simple way.
 	 *
+	 * If the futex key is stored on an anonymous page, then the associated
+	 * object is the mm which is implicitly pinned by the calling process.
+	 *
 	 * NOTE: When userspace waits on a MAP_SHARED mapping, even if
 	 * it's a read-only handle, it's expected that futexes attach to
 	 * the object not the particular process.
@@ -524,16 +550,74 @@ again:
 		key->both.offset |= FUT_OFF_MMSHARED; /* ref taken on mm */
 		key->private.mm = mm;
 		key->private.address = address;
+
+		get_futex_key_refs(key); /* implies smp_mb(); (B) */
+
 	} else {
+		struct inode *inode;
+
+		/*
+		 * The associated futex object in this case is the inode and
+		 * the page->mapping must be traversed. Ordinarily this should
+		 * be stabilised under page lock but it's not strictly
+		 * necessary in this case as we just want to pin the inode, not
+		 * update the radix tree or anything like that.
+		 *
+		 * The RCU read lock is taken as the inode is finally freed
+		 * under RCU. If the mapping still matches expectations then the
+		 * mapping->host can be safely accessed as being a valid inode.
+		 */
+		rcu_read_lock();
+
+		if (READ_ONCE(page_head->mapping) != mapping) {
+			rcu_read_unlock();
+			put_page(page_head);
+
+			goto again;
+		}
+
+		inode = READ_ONCE(mapping->host);
+		if (!inode) {
+			rcu_read_unlock();
+			put_page(page_head);
+
+			goto again;
+		}
+
+		/*
+		 * Take a reference unless it is about to be freed. Previously
+		 * this reference was taken by ihold under the page lock
+		 * pinning the inode in place so i_lock was unnecessary. The
+		 * only way for this check to fail is if the inode was
+		 * truncated in parallel so warn for now if this happens.
+		 *
+		 * We are not calling into get_futex_key_refs() in file-backed
+		 * cases, therefore a successful atomic_inc return below will
+		 * guarantee that get_futex_key() will still imply smp_mb(); (B).
+		 */
+		if (WARN_ON_ONCE(!atomic_inc_not_zero(&inode->i_count))) {
+			rcu_read_unlock();
+			put_page(page_head);
+
+			goto again;
+		}
+
+		/* Should be impossible but lets be paranoid for now */
+		if (WARN_ON_ONCE(inode->i_mapping != mapping)) {
+			err = -EFAULT;
+			rcu_read_unlock();
+			iput(inode);
+
+			goto out;
+		}
+
 		key->both.offset |= FUT_OFF_INODE; /* inode-based key */
-		key->shared.inode = page_head->mapping->host;
+		key->shared.inode = inode;
 		key->shared.pgoff = basepage_index(page);
+		rcu_read_unlock();
 	}
 
-	get_futex_key_refs(key); /* implies MB (B) */
-
 out:
-	unlock_page(page_head);
 	put_page(page_head);
 	return err;
 }
