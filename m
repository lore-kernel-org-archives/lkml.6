Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1F6C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA2E217C8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA2E217C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbeHDLEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:04:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48526 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbeHDLEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:04:11 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 95B11BB3;
        Sat,  4 Aug 2018 09:04:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        syzbot+121be635a7a35ddb7dcb@syzkaller.appspotmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 18/23] userfaultfd: remove uffd flags from vma->vm_flags if UFFD_EVENT_FORK fails
Date:   Sat,  4 Aug 2018 11:01:09 +0200
Message-Id: <20180804082645.662812777@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082643.641435547@linuxfoundation.org>
References: <20180804082643.641435547@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Rapoport <rppt@linux.vnet.ibm.com>

commit 31e810aa1033a7db50a2746cd34a2432237f6420 upstream.

The fix in commit 0cbb4b4f4c44 ("userfaultfd: clear the
vma->vm_userfaultfd_ctx if UFFD_EVENT_FORK fails") cleared the
vma->vm_userfaultfd_ctx but kept userfaultfd flags in vma->vm_flags
that were copied from the parent process VMA.

As the result, there is an inconsistency between the values of
vma->vm_userfaultfd_ctx.ctx and vma->vm_flags which triggers BUG_ON
in userfaultfd_release().

Clearing the uffd flags from vma->vm_flags in case of UFFD_EVENT_FORK
failure resolves the issue.

Link: http://lkml.kernel.org/r/1532931975-25473-1-git-send-email-rppt@linux.vnet.ibm.com
Fixes: 0cbb4b4f4c44 ("userfaultfd: clear the vma->vm_userfaultfd_ctx if UFFD_EVENT_FORK fails")
Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Reported-by: syzbot+121be635a7a35ddb7dcb@syzkaller.appspotmail.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Eric Biggers <ebiggers3@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/userfaultfd.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -628,8 +628,10 @@ static void userfaultfd_event_wait_compl
 		/* the various vma->vm_userfaultfd_ctx still points to it */
 		down_write(&mm->mmap_sem);
 		for (vma = mm->mmap; vma; vma = vma->vm_next)
-			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx)
+			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
 				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
+				vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
+			}
 		up_write(&mm->mmap_sem);
 
 		userfaultfd_ctx_put(release_new_ctx);


