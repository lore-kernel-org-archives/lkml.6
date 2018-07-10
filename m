Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA31C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BECA208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BECA208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389060AbeGJSdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:33:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47858 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388082AbeGJSds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:33:48 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7A756E6B;
        Tue, 10 Jul 2018 18:33:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 01/53] userfaultfd: hugetlbfs: fix userfaultfd_huge_must_wait() pte access
Date:   Tue, 10 Jul 2018 20:24:37 +0200
Message-Id: <20180710182458.838930219@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
References: <20180710182458.736721865@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janosch Frank <frankja@linux.ibm.com>

commit 1e2c043628c7736dd56536d16c0ce009bc834ae7 upstream.

Use huge_ptep_get() to translate huge ptes to normal ptes so we can
check them with the huge_pte_* functions.  Otherwise some architectures
will check the wrong values and will not wait for userspace to bring in
the memory.

Link: http://lkml.kernel.org/r/20180626132421.78084-1-frankja@linux.ibm.com
Fixes: 369cd2121be4 ("userfaultfd: hugetlbfs: userfaultfd_huge_must_wait for hugepmd ranges")
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/userfaultfd.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -220,24 +220,26 @@ static inline bool userfaultfd_huge_must
 					 unsigned long reason)
 {
 	struct mm_struct *mm = ctx->mm;
-	pte_t *pte;
+	pte_t *ptep, pte;
 	bool ret = true;
 
 	VM_BUG_ON(!rwsem_is_locked(&mm->mmap_sem));
 
-	pte = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
-	if (!pte)
+	ptep = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
+
+	if (!ptep)
 		goto out;
 
 	ret = false;
+	pte = huge_ptep_get(ptep);
 
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
 	 * changes under us.
 	 */
-	if (huge_pte_none(*pte))
+	if (huge_pte_none(pte))
 		ret = true;
-	if (!huge_pte_write(*pte) && (reason & VM_UFFD_WP))
+	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
 		ret = true;
 out:
 	return ret;


