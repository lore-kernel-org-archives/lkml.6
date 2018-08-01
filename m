Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC942C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD5B20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD5B20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407924AbeHATXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:23:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52928 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436565AbeHATSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F2B89E24;
        Wed,  1 Aug 2018 16:53:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Rik van Riel <riel@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 017/336] mm: check for SIGKILL inside dup_mmap() loop
Date:   Wed,  1 Aug 2018 18:45:52 +0200
Message-Id: <20180801165029.641924158@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 655c79bb40a0870adcd0871057d01de11625882b ]

As a theoretical problem, dup_mmap() of an mm_struct with 60000+ vmas
can loop while potentially allocating memory, with mm->mmap_sem held for
write by current thread.  This is bad if current thread was selected as
an OOM victim, for current thread will continue allocations using memory
reserves while OOM reaper is unable to reclaim memory.

As an actually observable problem, it is not difficult to make OOM
reaper unable to reclaim memory if the OOM victim is blocked at
i_mmap_lock_write() in this loop.  Unfortunately, since nobody can
explain whether it is safe to use killable wait there, let's check for
SIGKILL before trying to allocate memory.  Even without an OOM event,
there is no point with continuing the loop from the beginning if current
thread is killed.

I tested with debug printk().  This patch should be safe because we
already fail if security_vm_enough_memory_mm() or
kmem_cache_alloc(GFP_KERNEL) fails and exit_mmap() handles it.

   ***** Aborting dup_mmap() due to SIGKILL *****
   ***** Aborting dup_mmap() due to SIGKILL *****
   ***** Aborting dup_mmap() due to SIGKILL *****
   ***** Aborting dup_mmap() due to SIGKILL *****
   ***** Aborting exit_mmap() due to NULL mmap *****

[akpm@linux-foundation.org: add comment]
Link: http://lkml.kernel.org/r/201804071938.CDE04681.SOFVQJFtMHOOLF@I-love.SAKURA.ne.jp
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Rik van Riel <riel@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: David Rientjes <rientjes@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/fork.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -440,6 +440,14 @@ static __latent_entropy int dup_mmap(str
 			continue;
 		}
 		charge = 0;
+		/*
+		 * Don't duplicate many vmas if we've been oom-killed (for
+		 * example)
+		 */
+		if (fatal_signal_pending(current)) {
+			retval = -EINTR;
+			goto out;
+		}
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned long len = vma_pages(mpnt);
 


