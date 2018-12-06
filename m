Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3470FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF9220700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108273;
	bh=Ce4+XvsjSkkiVr4q/Tt6vegzeU2AXbvkPjQLEOoCfu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=egw6BFkUOe4vm57Kh1NczdZ3KliPv0zkINqw2HNLgXPjH4HrSUeqBaS/QP3mEoQtl
	 fOebdeGZ68NvHJk02YfWqNe+HekECbReMou7MKXijGaa6DpGc7xtJenC/RgUzOL0sO
	 Zv0tR+fvKNGj2la3/rOGLd8KuQUN5wOd38MvYtHE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF9220700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeLFO5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:57:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:46722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730467AbeLFOm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:42:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45AAC2082B;
        Thu,  6 Dec 2018 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107345;
        bh=Ce4+XvsjSkkiVr4q/Tt6vegzeU2AXbvkPjQLEOoCfu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zu/YtiBz6Cpsm7Y3pnKioTY31WwJensT08BoqC6dBKjqAhndtDfwfBFdQN880jxZm
         UudR5gp2zUOJTtTZPVI2MddhA7O0c7aTe9P46gk/3CW46ojNz2ZWbAqR8P/1JLqV/x
         X3md+k4vGPLParBewj8Rxj3FpUCtJ72l7+ByBSUA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 27/55] userfaultfd: shmem/hugetlbfs: only allow to register VM_MAYWRITE vmas
Date:   Thu,  6 Dec 2018 15:39:01 +0100
Message-Id: <20181206143003.195453574@linuxfoundation.org>
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

commit 29ec90660d68bbdd69507c1c8b4e33aa299278b1 upstream.

After the VMA to register the uffd onto is found, check that it has
VM_MAYWRITE set before allowing registration.  This way we inherit all
common code checks before allowing to fill file holes in shmem and
hugetlbfs with UFFDIO_COPY.

The userfaultfd memory model is not applicable for readonly files unless
it's a MAP_PRIVATE.

Link: http://lkml.kernel.org/r/20181126173452.26955-4-aarcange@redhat.com
Fixes: ff62a3421044 ("hugetlb: implement memfd sealing")
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Hugh Dickins <hughd@google.com>
Reported-by: Jann Horn <jannh@google.com>
Fixes: 4c27fe4c4c84 ("userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support")
Cc: <stable@vger.kernel.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/userfaultfd.c |   15 +++++++++++++++
 mm/userfaultfd.c |   15 ++++++---------
 2 files changed, 21 insertions(+), 9 deletions(-)

--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1362,6 +1362,19 @@ static int userfaultfd_register(struct u
 		ret = -EINVAL;
 		if (!vma_can_userfault(cur))
 			goto out_unlock;
+
+		/*
+		 * UFFDIO_COPY will fill file holes even without
+		 * PROT_WRITE. This check enforces that if this is a
+		 * MAP_SHARED, the process has write permission to the backing
+		 * file. If VM_MAYWRITE is set it also enforces that on a
+		 * MAP_SHARED vma: there is no F_WRITE_SEAL and no further
+		 * F_WRITE_SEAL can be taken until the vma is destroyed.
+		 */
+		ret = -EPERM;
+		if (unlikely(!(cur->vm_flags & VM_MAYWRITE)))
+			goto out_unlock;
+
 		/*
 		 * If this vma contains ending address, and huge pages
 		 * check alignment.
@@ -1407,6 +1420,7 @@ static int userfaultfd_register(struct u
 		BUG_ON(!vma_can_userfault(vma));
 		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
 		       vma->vm_userfaultfd_ctx.ctx != ctx);
+		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
 
 		/*
 		 * Nothing to do: this vma is already registered into this
@@ -1553,6 +1567,7 @@ static int userfaultfd_unregister(struct
 		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma));
+		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
 
 		/*
 		 * Nothing to do: this vma is already registered into this
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -228,8 +228,9 @@ retry:
 		if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
 			goto out_unlock;
 		/*
-		 * Only allow __mcopy_atomic_hugetlb on userfaultfd
-		 * registered ranges.
+		 * Check the vma is registered in uffd, this is
+		 * required to enforce the VM_MAYWRITE check done at
+		 * uffd registration time.
 		 */
 		if (!dst_vma->vm_userfaultfd_ctx.ctx)
 			goto out_unlock;
@@ -472,13 +473,9 @@ retry:
 	if (!dst_vma)
 		goto out_unlock;
 	/*
-	 * Be strict and only allow __mcopy_atomic on userfaultfd
-	 * registered ranges to prevent userland errors going
-	 * unnoticed. As far as the VM consistency is concerned, it
-	 * would be perfectly safe to remove this check, but there's
-	 * no useful usage for __mcopy_atomic ouside of userfaultfd
-	 * registered ranges. This is after all why these are ioctls
-	 * belonging to the userfaultfd and not syscalls.
+	 * Check the vma is registered in uffd, this is required to
+	 * enforce the VM_MAYWRITE check done at uffd registration
+	 * time.
 	 */
 	if (!dst_vma->vm_userfaultfd_ctx.ctx)
 		goto out_unlock;


