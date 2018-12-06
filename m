Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55600C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1917720672
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107237;
	bh=n2etj/aLbhXQZz7JkwKYtaUphVyn2ZjHwRpAYdxSqtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0kQ8HKRadcbMyH/GLHNF2c79bqXxMh2gouhlqHAx9DOGPc+bKv9s+WI8vhYHyFX+F
	 gjnDnwhc4BLPwEpboXoOMwp4Ub1NLGFC5hA3kR5LwISv0dalT72Fn6uYQYUx2A81lt
	 fCXKNdNVNpS9gaau+HnNvHNlrPei+6msSSrTQb4Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1917720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbeLFOkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:40:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729966AbeLFOkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:40:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC4E520661;
        Thu,  6 Dec 2018 14:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107231;
        bh=n2etj/aLbhXQZz7JkwKYtaUphVyn2ZjHwRpAYdxSqtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rWcrLv5LN7bimI2LJNgPtrvn6ZpnnIRDpunthYxAjMhOek62hCQIJv7wJpvEwticE
         BCUqfjgDSyLf/W8Tb0a/eWPHqg6x94YsjdYJRbTgHzkJWfJJtYKH/tSyQw7rfERq1W
         4DZfEbrLrVdoxwS4GgInIkYh4wQ/JZycmNhRVRIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Jann Horn <jannh@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 24/41] userfaultfd: shmem: UFFDIO_COPY: set the page dirty if VM_WRITE is not set
Date:   Thu,  6 Dec 2018 15:39:04 +0100
Message-Id: <20181206142951.798212731@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrea Arcangeli <aarcange@redhat.com>

commit dcf7fe9d89763a28e0f43975b422ff141fe79e43 upstream.

Set the page dirty if VM_WRITE is not set because in such case the pte
won't be marked dirty and the page would be reclaimed without writepage
(i.e.  swapout in the shmem case).

This was found by source review.  Most apps (certainly including QEMU)
only use UFFDIO_COPY on PROT_READ|PROT_WRITE mappings or the app can't
modify the memory in the first place.  This is for correctness and it
could help the non cooperative use case to avoid unexpected data loss.

Link: http://lkml.kernel.org/r/20181126173452.26955-6-aarcange@redhat.com
Reviewed-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org
Fixes: 4c27fe4c4c84 ("userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support")
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/shmem.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2325,6 +2325,16 @@ static int shmem_mfill_atomic_pte(struct
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
 
@@ -2358,6 +2368,7 @@ out:
 	return ret;
 out_release_uncharge_unlock:
 	pte_unmap_unlock(dst_pte, ptl);
+	ClearPageDirty(page);
 	delete_from_page_cache(page);
 out_release_uncharge:
 	mem_cgroup_cancel_charge(page, memcg, false);


