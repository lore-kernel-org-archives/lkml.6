Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27902C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15BA20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108149;
	bh=GZ934Ioc4i3NP9GMoOMP5kb20stv8ZY33+NfQqMwpdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e6O6+pVkp5DMe5P9degN601AY22Eh1Gex3jG2zCNGZ6lgKJtZ9W8q/ouXAV6+EQgn
	 ZLwNM0Z1mhNxd1uBRg/O1cb0DTWKx8qXollGFzn6tKgDajXTKw8HH0BvWoVcObjaNZ
	 k9gng4RyLVIL4zHRW66rFJgqKYFZfD3mq4a7nwcM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15BA20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbeLFOnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:43:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:48252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730270AbeLFOno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:43:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FAB420661;
        Thu,  6 Dec 2018 14:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107423;
        bh=GZ934Ioc4i3NP9GMoOMP5kb20stv8ZY33+NfQqMwpdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rpo0/fwEIIDBvK3StjTmsQAiQnx5e/km+UZDTuC/HqG/OB/2PvaGbY4Xf/4kW858n
         Ten9v30YAlWJtgS+V587NSoLOh0rjuWuNQWv/GsQbmsZ0Cg76UieS4awACHsCwdVrz
         0VOAr2QVjA+aBRqIPt9yd+iLRR9i2jYMhVsAaX+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jann Horn <jannh@google.com>, Peter Xu <peterx@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 22/55] userfaultfd: use ENOENT instead of EFAULT if the atomic copy user fails
Date:   Thu,  6 Dec 2018 15:38:56 +0100
Message-Id: <20181206143002.952207928@linuxfoundation.org>
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

commit 9e368259ad988356c4c95150fafd1a06af095d98 upstream.

Patch series "userfaultfd shmem updates".

Jann found two bugs in the userfaultfd shmem MAP_SHARED backend: the
lack of the VM_MAYWRITE check and the lack of i_size checks.

Then looking into the above we also fixed the MAP_PRIVATE case.

Hugh by source review also found a data loss source if UFFDIO_COPY is
used on shmem MAP_SHARED PROT_READ mappings (the production usages
incidentally run with PROT_READ|PROT_WRITE, so the data loss couldn't
happen in those production usages like with QEMU).

The whole patchset is marked for stable.

We verified QEMU postcopy live migration with guest running on shmem
MAP_PRIVATE run as well as before after the fix of shmem MAP_PRIVATE.
Regardless if it's shmem or hugetlbfs or MAP_PRIVATE or MAP_SHARED, QEMU
unconditionally invokes a punch hole if the guest mapping is filebacked
and a MADV_DONTNEED too (needed to get rid of the MAP_PRIVATE COWs and
for the anon backend).

This patch (of 5):

We internally used EFAULT to communicate with the caller, switch to
ENOENT, so EFAULT can be used as a non internal retval.

Link: http://lkml.kernel.org/r/20181126173452.26955-2-aarcange@redhat.com
Fixes: 4c27fe4c4c84 ("userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support")
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Hugh Dickins <hughd@google.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Jann Horn <jannh@google.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: <stable@vger.kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/hugetlb.c     |    2 +-
 mm/shmem.c       |    2 +-
 mm/userfaultfd.c |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4037,7 +4037,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_s
 
 		/* fallback to copy_from_user outside mmap_sem */
 		if (unlikely(ret)) {
-			ret = -EFAULT;
+			ret = -ENOENT;
 			*pagep = page;
 			/* don't free the page */
 			goto out;
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2266,7 +2266,7 @@ static int shmem_mfill_atomic_pte(struct
 				*pagep = page;
 				shmem_inode_unacct_blocks(inode, 1);
 				/* don't free the page */
-				return -EFAULT;
+				return -ENOENT;
 			}
 		} else {		/* mfill_zeropage_atomic */
 			clear_highpage(page);
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -49,7 +49,7 @@ static int mcopy_atomic_pte(struct mm_st
 
 		/* fallback to copy_from_user outside mmap_sem */
 		if (unlikely(ret)) {
-			ret = -EFAULT;
+			ret = -ENOENT;
 			*pagep = page;
 			/* don't free the page */
 			goto out;
@@ -275,7 +275,7 @@ retry:
 
 		cond_resched();
 
-		if (unlikely(err == -EFAULT)) {
+		if (unlikely(err == -ENOENT)) {
 			up_read(&dst_mm->mmap_sem);
 			BUG_ON(!page);
 
@@ -521,7 +521,7 @@ retry:
 				       src_addr, &page, zeropage);
 		cond_resched();
 
-		if (unlikely(err == -EFAULT)) {
+		if (unlikely(err == -ENOENT)) {
 			void *page_kaddr;
 
 			up_read(&dst_mm->mmap_sem);


