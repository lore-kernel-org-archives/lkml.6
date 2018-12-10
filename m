Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADB4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A952081C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A952081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbeLJGvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 01:51:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbeLJGvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 01:51:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9321158E52;
        Mon, 10 Dec 2018 06:51:31 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-85.pek2.redhat.com [10.72.12.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F04D5D759;
        Mon, 10 Dec 2018 06:51:23 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-mm@kvack.org
Subject: [PATCH] userfaultfd: clear flag if remap event not enabled
Date:   Mon, 10 Dec 2018 14:51:21 +0800
Message-Id: <20181210065121.14984-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 10 Dec 2018 06:51:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the process being tracked do mremap() without
UFFD_FEATURE_EVENT_REMAP on the corresponding tracking uffd file
handle, we should not generate the remap event, and at the same
time we should clear all the uffd flags on the new VMA.  Without
this patch, we can still have the VM_UFFD_MISSING|VM_UFFD_WP
flags on the new VMA even the fault handling process does not
even know the existance of the VMA.

CC: Andrea Arcangeli <aarcange@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Mike Rapoport <rppt@linux.vnet.ibm.com>
CC: Kirill A. Shutemov <kirill@shutemov.name>
CC: Hugh Dickins <hughd@google.com>
CC: Pavel Emelyanov <xemul@virtuozzo.com>
CC: Pravin Shedge <pravin.shedge4linux@gmail.com>
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index cd58939dc977..798ae8a438ff 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -740,6 +740,9 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 		vm_ctx->ctx = ctx;
 		userfaultfd_ctx_get(ctx);
 		WRITE_ONCE(ctx->mmap_changing, true);
+	} else if (ctx) {
+		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
+		vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
 	}
 }
 
-- 
2.17.1

