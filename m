Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3586BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A5C21726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359611;
	bh=9sUUDAQbNaNMnWoHs+JxnZvhk4tK10wNsw+8bMXxJ4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EujSODIsMtt8dASQZG96UTM8lY+I0+4GnqJwEnFe5or9x9CsDxVzAFniBfPRToImL
	 hVWtw1e4oDDEnZaJtrdrJBgsfjBBpBnJDJ8VNrK+QrByX/21XpPPcbS2O/0C2GjcH/
	 DK4LKl+Ku73sXAjg5y/5D3xZMr3wWFchMmkxUpFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfAXTx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732241AbfAXTiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:38:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F5F121904;
        Thu, 24 Jan 2019 19:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358693;
        bh=9sUUDAQbNaNMnWoHs+JxnZvhk4tK10wNsw+8bMXxJ4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZjX4fdTaWBVIyrNaPHsgUEm3TWithFWzHcseXtO89LszxawAnRiiV5Ha/FWTzF1u
         T9oVl8DzwhBB2WlWXGxVZvewcB4pgqIYFiaRTuAK5iCY32opadLFD0VX8n7EledKJy
         xTNEQsXArvJKfMGI2RaePHJg/16CZ/tD8lmrfbM0=
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
Subject: [PATCH 4.19 098/106] userfaultfd: clear flag if remap event not enabled
Date:   Thu, 24 Jan 2019 20:20:55 +0100
Message-Id: <20190124190212.192261567@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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



