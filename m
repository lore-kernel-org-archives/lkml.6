Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21CAC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FD520892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107432;
	bh=hJAY9MHq6YJiDw9xDHCSHyvOWbT8lTxHWzqBQ+8LupY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eT1pffidx1yYKX2Nhhrt7bCXzNM8ZgKzBApZfwm1QWGAEX/j3/RXkTIB9DvePviIh
	 1gF4Xkza35mZ7aQUk/K3vnaS+l3Ak48FejMRw5fUfNoYfC74TxImG+Na1hgbcXtyT/
	 ahVI8sNjR4718mjuqaXeR0BRjwVmEVjrNgALNhOw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FD520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbeLFOnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:43:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730241AbeLFOnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:43:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6EAA20892;
        Thu,  6 Dec 2018 14:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107426;
        bh=hJAY9MHq6YJiDw9xDHCSHyvOWbT8lTxHWzqBQ+8LupY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w6C921TXjZY2h0qu1HrbDq7qDFpBHl1WhkiDX0kEgiJ3WA6EyBgCZfpaRKqFtC5AW
         QvlwQM4ftNUwADBca3kkG/C/0MRUD2mBbeI84A4b/e1UILDJ5e06Ea3dkXxYxg9oai
         yBm2hGOTUViQb7SZAxlQ5fbjomDju35f3VwGmnfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Jann Horn <jannh@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 23/55] userfaultfd: shmem: allocate anonymous memory for MAP_PRIVATE shmem
Date:   Thu,  6 Dec 2018 15:38:57 +0100
Message-Id: <20181206143003.002397136@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrea Arcangeli <aarcange@redhat.com>

commit 5b51072e97d587186c2f5390c8c9c1fb7e179505 upstream.

Userfaultfd did not create private memory when UFFDIO_COPY was invoked
on a MAP_PRIVATE shmem mapping.  Instead it wrote to the shmem file,
even when that had not been opened for writing.  Though, fortunately,
that could only happen where there was a hole in the file.

Fix the shmem-backed implementation of UFFDIO_COPY to create private
memory for MAP_PRIVATE mappings.  The hugetlbfs-backed implementation
was already correct.

This change is visible to userland, if userfaultfd has been used in
unintended ways: so it introduces a small risk of incompatibility, but
is necessary in order to respect file permissions.

An app that uses UFFDIO_COPY for anything like postcopy live migration
won't notice the difference, and in fact it'll run faster because there
will be no copy-on-write and memory waste in the tmpfs pagecache
anymore.

Userfaults on MAP_PRIVATE shmem keep triggering only on file holes like
before.

The real zeropage can also be built on a MAP_PRIVATE shmem mapping
through UFFDIO_ZEROPAGE and that's safe because the zeropage pte is
never dirty, in turn even an mprotect upgrading the vma permission from
PROT_READ to PROT_READ|PROT_WRITE won't make the zeropage pte writable.

Link: http://lkml.kernel.org/r/20181126173452.26955-3-aarcange@redhat.com
Fixes: 4c27fe4c4c84 ("userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support")
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Reported-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/userfaultfd.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -381,7 +381,17 @@ static __always_inline ssize_t mfill_ato
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
@@ -480,7 +490,8 @@ retry:
 	 * dst_vma.
 	 */
 	err = -ENOMEM;
-	if (vma_is_anonymous(dst_vma) && unlikely(anon_vma_prepare(dst_vma)))
+	if (!(dst_vma->vm_flags & VM_SHARED) &&
+	    unlikely(anon_vma_prepare(dst_vma)))
 		goto out_unlock;
 
 	while (src_addr < src_start + len) {


