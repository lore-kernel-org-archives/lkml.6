Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuj6i7e4C6lAxIQpgZGiDjKw5xD2IeTxxi0ENgyUtknXnGgkpBm/3+ZT3R8YWXCMaWuLPl9
ARC-Seal: i=1; a=rsa-sha256; t=1519676535; cv=none;
        d=google.com; s=arc-20160816;
        b=jiJmeXpk0wrd7bx62cIwT4IrzMJ9D8rqa2f+ZtoD3lUEMwST4+HPk29TPlFqKtjqvz
         TVLhjKdksRxCmY16eHRpuL/XXRN8OlBr5H1rDGXFExR5pbTYHvRgUN+CubM9rVJhYBTD
         0WIGv9K7/4Ox0qtMriiYbnBHz6e/iH3DsdL4nw0CgjwRPyeDKmKyQ6RhrptYLLr99udW
         566c9yp1cnhjIV+Osrz4utPypK+hqilH0tn5vKZweFWWkTRym7w7ULsaJY96FBrduG3b
         e8PF9BzkM1jhwwyl9J1V0AqopSu2OQahlRQPVwGHyX6rETT72dS0vMH7ZnY0xuu4XYAj
         AKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xLK+v4M8nEIpPPuIfhzGS9qigJCCFfJCe4WXqiujY6Y=;
        b=fcMTErZO5gIlqzraUXxZryVLg9uVUTkWwGho8tIuV/WZVITsg+ZRDy07THiVI2+5U6
         KamyiToBeQwMHE9Pkn8t7OQYd3A1bc8OTV324r3dZ0epPhuSjyr4vh5uxynkf8+MWBA2
         uvf0+pARINbY85Qp4nUCNP3Gj8WYflOHBIHe2UoxmCoY9iS0Ew/1rfqiV8vw+Q0jW8FF
         txfPbf1zgeSGcWg0LihTp/zXkZvGIHWv0iZaDnyA1Tp1yg3HGYQFCwWVN3vE9CLoon2W
         BvTznYzom/ssAp7PsCR4DRj/9YM5xoET7TkGSCDS8F6OerZAsW5MDHQWzZHZd/HyZL9+
         hEDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Jan Kara <jack@suse.cz>,
	Pawel Lebioda <pawel.lebioda@intel.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Xiong Zhou <xzhou@redhat.com>,
	Eryu Guan <eguan@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 29/39] mm: avoid spurious bad pmd warning messages
Date: Mon, 26 Feb 2018 21:20:50 +0100
Message-Id: <20180226201644.948091150@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496342409689938?=
X-GMAIL-MSGID: =?utf-8?q?1593496342409689938?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Zwisler <ross.zwisler@linux.intel.com>

commit d0f0931de936a0a468d7e59284d39581c16d3a73 upstream.

When the pmd_devmap() checks were added by 5c7fb56e5e3f ("mm, dax:
dax-pmd vs thp-pmd vs hugetlbfs-pmd") to add better support for DAX huge
pages, they were all added to the end of if() statements after existing
pmd_trans_huge() checks.  So, things like:

  -       if (pmd_trans_huge(*pmd))
  +       if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd))

When further checks were added after pmd_trans_unstable() checks by
commit 7267ec008b5c ("mm: postpone page table allocation until we have
page to map") they were also added at the end of the conditional:

  +       if (pmd_trans_unstable(fe->pmd) || pmd_devmap(*fe->pmd))

This ordering is fine for pmd_trans_huge(), but doesn't work for
pmd_trans_unstable().  This is because DAX huge pages trip the bad_pmd()
check inside of pmd_none_or_trans_huge_or_clear_bad() (called by
pmd_trans_unstable()), which prints out a warning and returns 1.  So, we
do end up doing the right thing, but only after spamming dmesg with
suspicious looking messages:

  mm/pgtable-generic.c:39: bad pmd ffff8808daa49b88(84000001006000a5)

Reorder these checks in a helper so that pmd_devmap() is checked first,
avoiding the error messages, and add a comment explaining why the
ordering is important.

Fixes: commit 7267ec008b5c ("mm: postpone page table allocation until we have page to map")
Link: http://lkml.kernel.org/r/20170522215749.23516-1-ross.zwisler@linux.intel.com
Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Pawel Lebioda <pawel.lebioda@intel.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Xiong Zhou <xzhou@redhat.com>
Cc: Eryu Guan <eguan@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory.c |   40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2848,6 +2848,17 @@ static int __do_fault(struct fault_env *
 	return ret;
 }
 
+/*
+ * The ordering of these checks is important for pmds with _PAGE_DEVMAP set.
+ * If we check pmd_trans_unstable() first we will trip the bad_pmd() check
+ * inside of pmd_none_or_trans_huge_or_clear_bad(). This will end up correctly
+ * returning 1 but not before it spams dmesg with the pmd_clear_bad() output.
+ */
+static int pmd_devmap_trans_unstable(pmd_t *pmd)
+{
+	return pmd_devmap(*pmd) || pmd_trans_unstable(pmd);
+}
+
 static int pte_alloc_one_map(struct fault_env *fe)
 {
 	struct vm_area_struct *vma = fe->vma;
@@ -2871,18 +2882,27 @@ static int pte_alloc_one_map(struct faul
 map_pte:
 	/*
 	 * If a huge pmd materialized under us just retry later.  Use
-	 * pmd_trans_unstable() instead of pmd_trans_huge() to ensure the pmd
-	 * didn't become pmd_trans_huge under us and then back to pmd_none, as
-	 * a result of MADV_DONTNEED running immediately after a huge pmd fault
-	 * in a different thread of this mm, in turn leading to a misleading
-	 * pmd_trans_huge() retval.  All we have to ensure is that it is a
-	 * regular pmd that we can walk with pte_offset_map() and we can do that
-	 * through an atomic read in C, which is what pmd_trans_unstable()
-	 * provides.
+	 * pmd_trans_unstable() via pmd_devmap_trans_unstable() instead of
+	 * pmd_trans_huge() to ensure the pmd didn't become pmd_trans_huge
+	 * under us and then back to pmd_none, as a result of MADV_DONTNEED
+	 * running immediately after a huge pmd fault in a different thread of
+	 * this mm, in turn leading to a misleading pmd_trans_huge() retval.
+	 * All we have to ensure is that it is a regular pmd that we can walk
+	 * with pte_offset_map() and we can do that through an atomic read in
+	 * C, which is what pmd_trans_unstable() provides.
 	 */
-	if (pmd_trans_unstable(fe->pmd) || pmd_devmap(*fe->pmd))
+	if (pmd_devmap_trans_unstable(fe->pmd))
 		return VM_FAULT_NOPAGE;
 
+	/*
+	 * At this point we know that our vmf->pmd points to a page of ptes
+	 * and it cannot become pmd_none(), pmd_devmap() or pmd_trans_huge()
+	 * for the duration of the fault.  If a racing MADV_DONTNEED runs and
+	 * we zap the ptes pointed to by our vmf->pmd, the vmf->ptl will still
+	 * be valid and we will re-check to make sure the vmf->pte isn't
+	 * pte_none() under vmf->ptl protection when we return to
+	 * alloc_set_pte().
+	 */
 	fe->pte = pte_offset_map_lock(vma->vm_mm, fe->pmd, fe->address,
 			&fe->ptl);
 	return 0;
@@ -3456,7 +3476,7 @@ static int handle_pte_fault(struct fault
 		fe->pte = NULL;
 	} else {
 		/* See comment in pte_alloc_one_map() */
-		if (pmd_trans_unstable(fe->pmd) || pmd_devmap(*fe->pmd))
+		if (pmd_devmap_trans_unstable(fe->pmd))
 			return 0;
 		/*
 		 * A regular pmd is established and it can't morph into a huge
