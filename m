Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A5DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5B920862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5B920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeK0E3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:29:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeK0E3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:29:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA8F580F8D;
        Mon, 26 Nov 2018 17:34:59 +0000 (UTC)
Received: from sky.random (ovpn-120-160.rdu2.redhat.com [10.10.120.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B942173DF;
        Mon, 26 Nov 2018 17:34:56 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jann Horn <jannh@google.com>, Peter Xu <peterx@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH 5/5] userfaultfd: shmem: UFFDIO_COPY: set the page dirty if VM_WRITE is not set
Date:   Mon, 26 Nov 2018 12:34:52 -0500
Message-Id: <20181126173452.26955-6-aarcange@redhat.com>
In-Reply-To: <20181126173452.26955-1-aarcange@redhat.com>
References: <20181126173452.26955-1-aarcange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 26 Nov 2018 17:34:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the page dirty if VM_WRITE is not set because in such case the pte
won't be marked dirty and the page would be reclaimed without
writepage (i.e. swapout in the shmem case).

This was found by source review. Most apps (certainly including QEMU)
only use UFFDIO_COPY on PROT_READ|PROT_WRITE mappings or the app can't
modify the memory in the first place. This is for correctness and it
could help the non cooperative use case to avoid unexpected data loss.

Reviewed-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org
Fixes: 4c27fe4c4c84 ("userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support")
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 mm/shmem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index c3ece7a51949..82a381d463bc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2272,6 +2272,16 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
 	if (dst_vma->vm_flags & VM_WRITE)
 		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
+	else {
+		/*
+		 * We don't set the pte dirty if the vma has no
+		 * VM_WRITE permission, so mark the page dirty or it
+		 * could be freed from under us. We could do it
+		 * unconditionally before unlock_page(), but doing it
+		 * only if VM_WRITE is not set is faster.
+		 */
+		set_page_dirty(page);
+	}
 
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
 
@@ -2305,6 +2315,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	return ret;
 out_release_uncharge_unlock:
 	pte_unmap_unlock(dst_pte, ptl);
+	ClearPageDirty(page);
 	delete_from_page_cache(page);
 out_release_uncharge:
 	mem_cgroup_cancel_charge(page, memcg, false);
