Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2322DC282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54FD20663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359122;
	bh=bfM/PB3X4q404qFnorvsPKbbDL8U4Mct+1S00ZTOK74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Khjkz9uvUyn2RC76S2AOM3S8xDgE1SrkMi5ah1HEVyUxnu5nPgZQU/yje4Fwa85mA
	 2LZa/DUmEn1/lbGg9/Sa2jc6o6HTxGUjFbS1y6t4ShbdBvNwY/ljOZx7POXb8/M232
	 t9omAebtCbtMHgW3wZGJ5xI7/kgyCETe2V+I5VFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbfAXTo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:44:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731336AbfAXTov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:44:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAA3620663;
        Thu, 24 Jan 2019 19:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548359090;
        bh=bfM/PB3X4q404qFnorvsPKbbDL8U4Mct+1S00ZTOK74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GzWJfa89iek1x2eK1c67ngq00hzTtVrsWEl1FwCJNTYvxJIqBc/fuVNnK0e0V/kat
         yQau7ZYf1qumRk2NuxqWlMTEmF9SyZwMvjw0tTxpUnqA4MMTmuD/S6AHU4/Bhkjbpw
         zqUNG0Y3/QKkuWvC0MbuR59YjkbKacJBrZhJu9cQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 118/127] userfaultfd: clear flag if remap event not enabled
Date:   Thu, 24 Jan 2019 20:21:04 +0100
Message-Id: <20190124190216.970004275@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3cfd22be0ad663248fadfc8f6ffa3e255c394552 ]

When the process being tracked does mremap() without
UFFD_FEATURE_EVENT_REMAP on the corresponding tracking uffd file handle,
we should not generate the remap event, and at the same time we should
clear all the uffd flags on the new VMA.  Without this patch, we can still
have the VM_UFFD_MISSING|VM_UFFD_WP flags on the new VMA even the fault
handling process does not even know the existance of the VMA.

Link: http://lkml.kernel.org/r/20181211053409.20317-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Hugh Dickins <hughd@google.com>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>
Cc: Pravin Shedge <pravin.shedge4linux@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/userfaultfd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 7a85e609fc27..d8b8323e80f4 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -736,10 +736,18 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 	struct userfaultfd_ctx *ctx;
 
 	ctx = vma->vm_userfaultfd_ctx.ctx;
-	if (ctx && (ctx->features & UFFD_FEATURE_EVENT_REMAP)) {
+
+	if (!ctx)
+		return;
+
+	if (ctx->features & UFFD_FEATURE_EVENT_REMAP) {
 		vm_ctx->ctx = ctx;
 		userfaultfd_ctx_get(ctx);
 		WRITE_ONCE(ctx->mmap_changing, true);
+	} else {
+		/* Drop uffd context if remap feature not enabled */
+		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
+		vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
 	}
 }
 
-- 
2.19.1



