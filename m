Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52227C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1830E218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151261;
	bh=1Lm//mzU2e0gxuE+a3YjC4vogDBirIO5eOvwbikJxGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mS1rBo6VUtDcWZ2QV/83CtztpF9/S7JvR/csCbPqjIk29rmQgde64AImZuJb1ahrt
	 KXpRl4BMhEMWTm/yuc3R0ehexJzdbgqyOjZCzP/YqQpTxY+cbRLCZ4vP3kYtn5UQwL
	 BvKD/L7TLRMayPHJjj7bpNU9eBW8VN6qGLVnR2jQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeLRQlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:41:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbeLRQkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D35C218A3;
        Tue, 18 Dec 2018 16:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151253;
        bh=1Lm//mzU2e0gxuE+a3YjC4vogDBirIO5eOvwbikJxGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xP78srxL32O2h0rxcJH40BOjuxQ+dGVw+RSVOHy9HDwKRGIuhrEVEB+M3cCUY6oN3
         VuoEuHLiCwjDGzWJFvStrBPi9vpL3KttXxCe/c58osJ9JNxUdKAirknFXCY3WvrSQk
         hrEahlAqXZ7wnKQFDyTGxi7S0oG7WIvtVFmsHn1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>,
        syzbot+06c7092e7d71218a2c16@syzkaller.appspotmail.com,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 12/44] userfaultfd: check VM_MAYWRITE was set after verifying the uffd is registered
Date:   Tue, 18 Dec 2018 17:39:24 +0100
Message-Id: <20181218163928.971029930@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

commit 01e881f5a1fca4677e82733061868c6d6ea05ca7 upstream.

Calling UFFDIO_UNREGISTER on virtual ranges not yet registered in uffd
could trigger an harmless false positive WARN_ON.  Check the vma is
already registered before checking VM_MAYWRITE to shut off the false
positive warning.

Link: http://lkml.kernel.org/r/20181206212028.18726-2-aarcange@redhat.com
Cc: <stable@vger.kernel.org>
Fixes: 29ec90660d68 ("userfaultfd: shmem/hugetlbfs: only allow to register VM_MAYWRITE vmas")
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Reported-by: syzbot+06c7092e7d71218a2c16@syzkaller.appspotmail.com
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Hugh Dickins <hughd@google.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/userfaultfd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1566,7 +1566,6 @@ static int userfaultfd_unregister(struct
 		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma));
-		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
 
 		/*
 		 * Nothing to do: this vma is already registered into this
@@ -1575,6 +1574,8 @@ static int userfaultfd_unregister(struct
 		if (!vma->vm_userfaultfd_ctx.ctx)
 			goto skip;
 
+		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
+
 		if (vma->vm_start > start)
 			start = vma->vm_start;
 		vma_end = min(end, vma->vm_end);


