Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4913EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C1D2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C1D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbeLFVUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:20:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbeLFVUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:20:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B62A9F754;
        Thu,  6 Dec 2018 21:20:31 +0000 (UTC)
Received: from sky.random (ovpn-122-73.rdu2.redhat.com [10.10.122.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E360FD1E7;
        Thu,  6 Dec 2018 21:20:28 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jann Horn <jannh@google.com>, Peter Xu <peterx@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH 1/1] userfaultfd: check VM_MAYWRITE was set after verifying the uffd is registered
Date:   Thu,  6 Dec 2018 16:20:28 -0500
Message-Id: <20181206212028.18726-2-aarcange@redhat.com>
In-Reply-To: <20181206212028.18726-1-aarcange@redhat.com>
References: <20181206212028.18726-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 06 Dec 2018 21:20:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling UFFDIO_UNREGISTER on virtual ranges not yet registered in uffd
could trigger an harmless false positive WARN_ON. Check the vma is
already registered before checking VM_MAYWRITE to shut off the
false positive warning.

Cc: <stable@vger.kernel.org>
Fixes: 29ec90660d68 ("userfaultfd: shmem/hugetlbfs: only allow to register VM_MAYWRITE vmas")
Reported-by: syzbot+06c7092e7d71218a2c16@syzkaller.appspotmail.com
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 fs/userfaultfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index cd58939dc977..7a85e609fc27 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1566,7 +1566,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma));
-		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
 
 		/*
 		 * Nothing to do: this vma is already registered into this
@@ -1575,6 +1574,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		if (!vma->vm_userfaultfd_ctx.ctx)
 			goto skip;
 
+		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
+
 		if (vma->vm_start > start)
 			start = vma->vm_start;
 		vma_end = min(end, vma->vm_end);
