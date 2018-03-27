Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49O+gQgMctHkyp/RrHqJFNi0rqcaY+MQwKd22JUlxtziym3btwtPfYBJDcHTLt2gKnwcmzp
ARC-Seal: i=1; a=rsa-sha256; t=1522168557; cv=none;
        d=google.com; s=arc-20160816;
        b=cqnNLiLPmNKeBaFLejF/qfPGXuFhoDVqGUVzX+6HDJl50dwLv4VRLSjFmQazgxvzXx
         K6TbdAi8wjuveHCDsVvIQCSklJ02C3X/+uBxqY5FUQNaJtgJ+xMdfUmnXim0sycUP59q
         RStQLkgHJSQHGob+BKEEHu2lEzW39scEpRv+QvS65ZrJECM5uYe8hB2DB4FpInMd3qZF
         njTevmFolshBsG5vwkfTcaRJfT+aGq/kX/LYruEFR5dPajTcmCS9jumppVURezB3e2pq
         bhQ04O3SAKlJYk2XXNpRECT+GXVF2Z78VpYYmMoR0SWDbB2G0MZXADcBSn2wP4dCoVOq
         myqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OZ7KElSpO1IthBOCYpCGf/I829kUJfrLRt9RBx4v0UU=;
        b=vb2cRiodS5RXLC9aDJvb17ezjp7YQXobjfXZIrNYX7QpomdYjeNrXStinMD2rOhdv2
         243Pcq8PP04asGZtE80Gl7TUhLT5zdl7Uk220LM9yY7uGQJ0brC7cUlsME+2xBC/3Rpr
         Q9evDPfzNn6PRK8d6OX8kqhgjB0qQakvLoec4Vg5uIb/bTSXj17iVCou8k9c7AcAXSbq
         iHe1CU2a4lLeYQ4eEbmf8+3NBGGrG4ofhcctQsevkox1ofWkViAAbjr8VroelBFEwvmK
         x6qsV9pXJpC3br1hjgcMKXcXrnsXat1yiuFeXnzLFEDnKZm52bUC8EcmMR8MB+yfKTgM
         n+nw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Eric Wheeler <linux-mm@lists.ewheeler.net>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Hugh Dickins <hughd@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 051/101] mm/shmem: do not wait for lock_page() in shmem_unused_huge_shrink()
Date: Tue, 27 Mar 2018 18:27:23 +0200
Message-Id: <20180327162753.159852108@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109139943461012?=
X-GMAIL-MSGID: =?utf-8?q?1596109417348742541?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

commit b3cd54b257ad95d344d121dc563d943ca39b0921 upstream.

shmem_unused_huge_shrink() gets called from reclaim path.  Waiting for
page lock may lead to deadlock there.

There was a bug report that may be attributed to this:

  http://lkml.kernel.org/r/alpine.LRH.2.11.1801242349220.30642@mail.ewheeler.net

Replace lock_page() with trylock_page() and skip the page if we failed
to lock it.  We will get to the page on the next scan.

We can test for the PageTransHuge() outside the page lock as we only
need protection against splitting the page under us.  Holding pin oni
the page is enough for this.

Link: http://lkml.kernel.org/r/20180316210830.43738-1-kirill.shutemov@linux.intel.com
Fixes: 779750d20b93 ("shmem: split huge pages beyond i_size under memory pressure")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Eric Wheeler <linux-mm@lists.ewheeler.net>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>	[4.8+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/shmem.c |   31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -493,36 +493,45 @@ next:
 		info = list_entry(pos, struct shmem_inode_info, shrinklist);
 		inode = &info->vfs_inode;
 
-		if (nr_to_split && split >= nr_to_split) {
-			iput(inode);
-			continue;
-		}
+		if (nr_to_split && split >= nr_to_split)
+			goto leave;
 
-		page = find_lock_page(inode->i_mapping,
+		page = find_get_page(inode->i_mapping,
 				(inode->i_size & HPAGE_PMD_MASK) >> PAGE_SHIFT);
 		if (!page)
 			goto drop;
 
+		/* No huge page at the end of the file: nothing to split */
 		if (!PageTransHuge(page)) {
-			unlock_page(page);
 			put_page(page);
 			goto drop;
 		}
 
+		/*
+		 * Leave the inode on the list if we failed to lock
+		 * the page at this time.
+		 *
+		 * Waiting for the lock may lead to deadlock in the
+		 * reclaim path.
+		 */
+		if (!trylock_page(page)) {
+			put_page(page);
+			goto leave;
+		}
+
 		ret = split_huge_page(page);
 		unlock_page(page);
 		put_page(page);
 
-		if (ret) {
-			/* split failed: leave it on the list */
-			iput(inode);
-			continue;
-		}
+		/* If split failed leave the inode on the list */
+		if (ret)
+			goto leave;
 
 		split++;
 drop:
 		list_del_init(&info->shrinklist);
 		removed++;
+leave:
 		iput(inode);
 	}
 
