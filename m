Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+fJLEvJsDrG5LM3HcIrS//rNqZpmyc6rCBm5TlGJTupuzOPRQ9CU7XQJAJTj95GGRC4ZsK
ARC-Seal: i=1; a=rsa-sha256; t=1522168293; cv=none;
        d=google.com; s=arc-20160816;
        b=H999tjP7YGG02AMidb7Y4D5R4RJG2XdHM0HSLRElu1qV8ovWjohNT5UxMo13mbLtm5
         i9II8Y9qYilGqH1QGrakMEgStEeo+YZQ2NCJ7hd84bzelPbXTx5xylWcJkZtZimPaxWu
         qEKKzaaW8mwkIAaY4+1XTwTCtTij40qmLwVEjxcBb3T3ywYyXvbYlqTcNsfEbIISleoE
         8k7QAiIlrowmV1TOLzA+PT36QQjRhc20zdqB8AILtMR5gc8yO9BYe7l0yK6SZ0xIwumJ
         jzdkRFjWBLhV9GKXrQCFUjOyyL05r4nkH7bTm1+aQDjjRr5S5p04Gn/dKsUdkPfNjeIS
         UQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SBTb/3970BN14X5HvjXcIoWb+6uTs1A10lre4Hz/Km0=;
        b=lT+zPXAWGbZmGTY05+ciQM5+8ABILzJl/urLqgBSITFDTnM0b4HRMYTHo/Xi9Fmjq2
         Naz/gLwJefdaQMdw4v7FNoiJE8YGBl4bQLipkPhmyMuw6nlrxYt/Mpg2Ddo2fuoQTcCU
         ScNjhNKEfW79B7IdUIbNvxEmYS9U6363PJ7EERI6/fF3DwiTn26ha8AdWK6B9GUQOo9O
         LMkl9lvNAe4dpJQ5lmsp2pPiQeQdPHZHRRU3TatR9aP43NnJDSOYckAgcxttrcjFrlKQ
         kEFpjoHTHnw3TJsxOwSxQt45i1yvcdd5tDOcpD4tjaNf3qspQ+Ckd2ufQABPJjTyPV5X
         hmDA==
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
Subject: [PATCH 4.9 28/67] mm/shmem: do not wait for lock_page() in shmem_unused_huge_shrink()
Date: Tue, 27 Mar 2018 18:27:20 +0200
Message-Id: <20180327162728.504337647@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109139943461012?=
X-GMAIL-MSGID: =?utf-8?q?1596109139943461012?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -466,36 +466,45 @@ next:
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
 
