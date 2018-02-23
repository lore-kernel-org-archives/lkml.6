Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4006443-1519424076-2-5053514788276123829
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519424076; b=XU/gENqGhxDH9BsiE4BiHhEXMi8cpSDLXLfqh8uV3EMceAx
    fKBYIanYmBxRHi2WX8ndGmnjuwoV0xB6L1c1NyuJeOZIO6P3mDwVZOGapB9Pp5bP
    Vm311fuenKZnctTG9SzBBQ/2CWxDmUbGVA2o41psgLHx0HGY5hCs+iKkVripJeZ5
    WOWTtUqc0WSlaaBiMi7DcvYuF+AZ8GZdwshOF/uWhHp3Vp+aHKxBvzgpMSKmn1MH
    AwK1VP34WwjB7TehGOJKRiij4Dl7AE13tI6DAED5Dv+e6k2SilGlDbJC9+HUbVvt
    LqxsZS9wSRkBuz8rGXgfpvbCXxq4mrEzrojkt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519424076; bh=jOUW1iwdjkPAjIpG9tjEjWQImABD2sIJ9zdvTb8B5yc=; b=I
    EyIEQN7MQkXPeWDt6uy7x62SYHmT0c1gyt1D2VwLnjKNbIyp4xMlgXmepWvhY+DJ
    1qcNAXb2BM+HrlKn4GL4zRW5IRDlmGXvOncyVa4vJue5wQkvZU+U4IiaxMYie7jH
    qPnGFRZ23Mc1D4rJl4ZQbbNwBwX06MP3C8kB02gApU0CgjTL06+B1PgQ1ZZSkD7l
    KnvLuWbieQew9ztA1C5XPAmG5zLq75CCJ/yplVRkizocWGwMXHz69J0uexPHqwBK
    HbdS5j5c3jhnh9TB1jb+A/o5SCsJQr156Y2THqAsPQ8YyhDkxKkUo/xgaML4owCj
    t9RUiMMxS8TxOQEm+6qYg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751648AbeBWWOe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 17:14:34 -0500
Received: from mga06.intel.com ([134.134.136.31]:6453 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751425AbeBWWOd (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 17:14:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="37004980"
Subject: [4.9-stable PATCH 01/11] mm: avoid spurious 'bad pmd' warning
 messages
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Cc: Jan Kara <jack@suse.cz>, Eryu Guan <eguan@redhat.com>,
        Xiong Zhou <xzhou@redhat.com>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
        Pawel Lebioda <pawel.lebioda@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Date: Fri, 23 Feb 2018 14:05:27 -0800
Message-ID: <151942352781.21775.15841303754448120195.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
---
 mm/memory.c |   40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index e2e68767a373..d2db2c4eb0a4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2848,6 +2848,17 @@ static int __do_fault(struct fault_env *fe, pgoff_t pgoff,
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
@@ -2871,18 +2882,27 @@ static int pte_alloc_one_map(struct fault_env *fe)
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
@@ -3456,7 +3476,7 @@ static int handle_pte_fault(struct fault_env *fe)
 		fe->pte = NULL;
 	} else {
 		/* See comment in pte_alloc_one_map() */
-		if (pmd_trans_unstable(fe->pmd) || pmd_devmap(*fe->pmd))
+		if (pmd_devmap_trans_unstable(fe->pmd))
 			return 0;
 		/*
 		 * A regular pmd is established and it can't morph into a huge
