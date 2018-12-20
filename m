Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B297C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1AE20811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298751;
	bh=7gMbO2YH8hCjRUVTK6xgeC9bZyFKIplnKnUxALmO66U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cl4YWBv/vpNhK9Cv3eC+1h309ONH3lIlVND9HaGxYGmJdQtlPkOvSl5Am/3Ngh2fe
	 ueLOI2RmGP5j1T04QSrNd7XXlWVeKVDFK55wexz5peTM40I5fwAouy/s9J9OoQEc9l
	 LljbQjbtGzMM/7nc79WR5zJzbR7pQZEBGK3KfWhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732894AbeLTJiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:38:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:54288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732084AbeLTJ0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:26:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F577218C3;
        Thu, 20 Dec 2018 09:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297982;
        bh=7gMbO2YH8hCjRUVTK6xgeC9bZyFKIplnKnUxALmO66U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=euP06A7K8J6UyeKFRxiOa/f7A682jnYxtgvSusBbCnqH8k6ULacRnKf0LAFeZQgKD
         mvOHAsOMNkO1h/0eHILtYaFGKD5ytjh0bU63OU2oBFX161WPL1aGkNYxUHxJA0vKz8
         Uc696FggYqGgtxvOEfOVYdhqbrcrVeU0Fqq5q0aE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>,
        syzbot+06c7092e7d71218a2c16@syzkaller.appspotmail.com,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 04/72] userfaultfd: check VM_MAYWRITE was set after verifying the uffd is registered
Date:   Thu, 20 Dec 2018 10:18:03 +0100
Message-Id: <20181220085922.508932777@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
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
@@ -1567,7 +1567,6 @@ static int userfaultfd_unregister(struct
 		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma));
-		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
 
 		/*
 		 * Nothing to do: this vma is already registered into this
@@ -1576,6 +1575,8 @@ static int userfaultfd_unregister(struct
 		if (!vma->vm_userfaultfd_ctx.ctx)
 			goto skip;
 
+		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
+
 		if (vma->vm_start > start)
 			start = vma->vm_start;
 		vma_end = min(end, vma->vm_end);


