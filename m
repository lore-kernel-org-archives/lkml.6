Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569B5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C92C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C92C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeK0E3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:29:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbeK0E3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:29:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8DA9F307DAA9;
        Mon, 26 Nov 2018 17:34:58 +0000 (UTC)
Received: from sky.random (ovpn-120-160.rdu2.redhat.com [10.10.120.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 457D05C229;
        Mon, 26 Nov 2018 17:34:53 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jann Horn <jannh@google.com>, Peter Xu <peterx@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH 2/5] userfaultfd: shmem: allocate anonymous memory for MAP_PRIVATE shmem
Date:   Mon, 26 Nov 2018 12:34:49 -0500
Message-Id: <20181126173452.26955-3-aarcange@redhat.com>
In-Reply-To: <20181126173452.26955-1-aarcange@redhat.com>
References: <20181126173452.26955-1-aarcange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 26 Nov 2018 17:34:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userfaultfd did not create private memory when UFFDIO_COPY was invoked
on a MAP_PRIVATE shmem mapping. Instead it wrote to the shmem file,
even when that had not been opened for writing. Though, fortunately,
that could only happen where there was a hole in the file.

Fix the shmem-backed implementation of UFFDIO_COPY to create private
memory for MAP_PRIVATE mappings. The hugetlbfs-backed implementation
was already correct.

This change is visible to userland, if userfaultfd has been used in
unintended ways: so it introduces a small risk of incompatibility, but
is necessary in order to respect file permissions.

An app that uses UFFDIO_COPY for anything like postcopy live migration
won't notice the difference, and in fact it'll run faster because
there will be no copy-on-write and memory waste in the tmpfs pagecache
anymore.

Userfaults on MAP_PRIVATE shmem keep triggering only on file holes
like before.

The real zeropage can also be built on a MAP_PRIVATE shmem mapping
through UFFDIO_ZEROPAGE and that's safe because the zeropage pte is
never dirty, in turn even an mprotect upgrading the vma permission
from PROT_READ to PROT_READ|PROT_WRITE won't make the zeropage pte
writable.

Reported-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org
Fixes: 4c27fe4c4c84 ("userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support")
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 mm/userfaultfd.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 46c8949e5f8f..471b6457f95f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -380,7 +380,17 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 {
 	ssize_t err;
 
-	if (vma_is_anonymous(dst_vma)) {
+	/*
+	 * The normal page fault path for a shmem will invoke the
+	 * fault, fill the hole in the file and COW it right away. The
+	 * result generates plain anonymous memory. So when we are
+	 * asked to fill an hole in a MAP_PRIVATE shmem mapping, we'll
+	 * generate anonymous memory directly without actually filling
+	 * the hole. For the MAP_PRIVATE case the robustness check
+	 * only happens in the pagetable (to verify it's still none)
+	 * and not in the radix tree.
+	 */
+	if (!(dst_vma->vm_flags & VM_SHARED)) {
 		if (!zeropage)
 			err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
 					       dst_addr, src_addr, page);
@@ -489,7 +499,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 * dst_vma.
 	 */
 	err = -ENOMEM;
-	if (vma_is_anonymous(dst_vma) && unlikely(anon_vma_prepare(dst_vma)))
+	if (!(dst_vma->vm_flags & VM_SHARED) &&
+	    unlikely(anon_vma_prepare(dst_vma)))
 		goto out_unlock;
 
 	while (src_addr < src_start + len) {
