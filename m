Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA4AC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F04E20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F04E20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbeLMTi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:38:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbeLMTi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:38:28 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C0BC307CDDA;
        Thu, 13 Dec 2018 19:38:28 +0000 (UTC)
Received: from llong.com (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A79A316EFE;
        Thu, 13 Dec 2018 19:38:24 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm: Replace verify_mm_writelocked() by lockdep_assert_held_exclusive()
Date:   Thu, 13 Dec 2018 14:38:05 -0500
Message-Id: <1544729885-30702-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 13 Dec 2018 19:38:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using down_read_trylock() to check if a task holds a write lock on
a rwsem is not reliable. A task can hold a read lock on a rwsem and
down_read_trylock() can fail if a writer is waiting in the wait queue.
So use lockdep_assert_held_exclusive() instead which can do the right
check when CONFIG_LOCKDEP is on.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/mmap.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6c04292..62a5593 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2962,16 +2962,6 @@ int vm_munmap(unsigned long start, size_t len)
 	return ret;
 }
 
-static inline void verify_mm_writelocked(struct mm_struct *mm)
-{
-#ifdef CONFIG_DEBUG_VM
-	if (unlikely(down_read_trylock(&mm->mmap_sem))) {
-		WARN_ON(1);
-		up_read(&mm->mmap_sem);
-	}
-#endif
-}
-
 /*
  *  this is really a simplified "do_mmap".  it only handles
  *  anonymous maps.  eventually we may be able to do some
@@ -3002,7 +2992,7 @@ static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long fla
 	 * mm->mmap_sem is required to protect against another thread
 	 * changing the mappings in case we sleep.
 	 */
-	verify_mm_writelocked(mm);
+	lockdep_assert_held_exclusive(&mm->mmap_sem);
 
 	/*
 	 * Clear old maps.  this also does some error checking for us
-- 
1.8.3.1

