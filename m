Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51702C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2B32070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975785;
	bh=+V65MindRhoSnsW+P21tyvTfAWRlw7ukVetCcTGzEGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fgBQ7SU2G1aFfH0QwY5jyJXbnVBKScrgBOqS1M8AuPi7g6AGjpq8cXXaAEm51K21X
	 9eUoRKo7SlyYI3gFsjSjH04SHZlIPm2y82tb/ewmC5nAY/U7GrZQDhoTqGYdyaYe6N
	 V0pDOh0xfzQfMBWGnZzzsmQiaQIf2xRn4YAgjgvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfAHT3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:29:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730449AbfAHT3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95D0720827;
        Tue,  8 Jan 2019 19:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975778;
        bh=+V65MindRhoSnsW+P21tyvTfAWRlw7ukVetCcTGzEGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SN2s3RpjuZ57kYUQVim8imxYV3WgoFUyVYjnajkwNitZ8/swHlvuIBNyXOpwMj+3g
         iZgxZXO1z6jU5LxHkiJfL5/RdDBkX0kTuLulOYvTk7pVW7oTdEfe+w7JhprgkjOORd
         p2rJdq12aEHAFVHU/dhh0EcqvtYfBlR+K6HQHGBY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 115/117] userfaultfd: clear flag if remap event not enabled
Date:   Tue,  8 Jan 2019 14:26:23 -0500
Message-Id: <20190108192628.121270-115-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

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

